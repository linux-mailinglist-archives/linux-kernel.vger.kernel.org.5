Return-Path: <linux-kernel+bounces-99602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB8F878AA8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D628D1F22930
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565DE57876;
	Mon, 11 Mar 2024 22:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="eByAki9w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GJVizqWv"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA105732E;
	Mon, 11 Mar 2024 22:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710195656; cv=none; b=n8lV45nCAHoOWPfAM6G3tpUWlICOy6BmlFqoTVsRQzUkOQZXY9nRKdfg621q6IVRqOOdZ617FIp0Tz86rz6e+ZqdhqLFiWJfITgvbr1EbNKlU4roqbERfmu/05rxsMoJUC/L7gLnAo/fKMnC8VZQluk2pn2nsJGSE2BAjTYE5c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710195656; c=relaxed/simple;
	bh=VRQLhinwT/LuQFd/XiKpnPNLCQmE5ROtUmOmCx24HrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K4aUw7DBydOeh26ddnVy9oxuQuC4Bl1X/MQhaChan7bbgO+26NSY1K3z9CtsX/VPYfFSKUWW51S7W4B6MiaV4H4Iw4My/IKaOFuPPiBYCfcajwuILxAD9ofIWt6vq2I10cZpDradF8jL5laG4+1W50dBg+Uffz0b01DrKWTM1j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sholland.org; spf=pass smtp.mailfrom=sholland.org; dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b=eByAki9w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GJVizqWv; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sholland.org
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B33E3114011D;
	Mon, 11 Mar 2024 18:20:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 11 Mar 2024 18:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1710195652;
	 x=1710282052; bh=y0WVDLnkL/e8PWpqoEk2UI+JKneMl4BIZbFWtAEcPLc=; b=
	eByAki9wwszOHWXB3pGc8UVdMrpPv6h9WHlXsyXtfc1nFUT9O9aizS1ry+EmnHM2
	vxHxpqbw0N6SzBDWfRPSTnmDdiGcFY/pXM1jDlrUft0DaBlPulJKF2HXKlvdNS8W
	eBbehtFthaEb0bOm2dEx+Abe4WgNJK9b3tCS2Iik71uxAskN2HE+dxfh15aH8lxy
	iUko5nUo4YZ5ZCI/0vss/6jhfEh6qLW3AQDDP1FhC4L36trdtofAuvXvJSdlM7Qh
	qLnKbxfmNqF7AD9kh40B+5vvd5jP2IX3puiziDnuo6YvXVVyX1TNFRd9DOGUiFrC
	tTpep33MWhd4WxGQzPLy/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710195652; x=
	1710282052; bh=y0WVDLnkL/e8PWpqoEk2UI+JKneMl4BIZbFWtAEcPLc=; b=G
	JVizqWvQM1inBIqfL96stIzWnPtbNBb1rdPfu8GAj3b3n7OaOmIoG8wn6RjgSwU6
	nFqs1a+11qKXklJnfqpIXMFNnivm3pImsy9iG6oxik2RJobJNSP25G6XOzdzOPgE
	mvunhxGK3a1X7UTtdO2l9VLoOkbxYWQ9VdfqEy7mJWY7HPIn4aCAJAoeYH9D9E0R
	sB9cMPvZeqtHfksTNQvDC0JbDYPpXTcFjREVtyWB3V5jD5pZIgBGwGnBTR4WqeBa
	jUcm1uXkVVJPjMyDtgWd//hFfP+Sz/UBjxlRn1RluYirO6U352mWeH4fFEXEprgo
	KxET118f467yMNg1xEecg==
X-ME-Sender: <xms:xIPvZXpXFLXs1UeNSLGIFRWCwB3T6ujpS43B5PLkrS-RkYDtOVy9Ew>
    <xme:xIPvZRr3rhgVD1pq3s5klYqJ2V4yPv-ZhUuwEPz9uFaRL20N8bOmFUR1mWvEN0fSr
    uMI1_eu9qcwPpui5w>
X-ME-Received: <xmr:xIPvZUPq2AMXRIW_r1r84xC_jQJ4zghKIxms3OzvLrfSyVPdV6r2BhfddR_4D7MjNohFrMEUL3KbRtW98yahCNLvLQnrW9cYrMljifLVcA04h12mTti37TktSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedugdduieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeetieekgeeilefgtdfgteejhfevtdfgieekvdffjedvvedvveei
    veelfeeuhffhfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:xIPvZa5ce9poCrjTBQpUHu5Sg_xXAhmGkGwrCyHBaqqXAcvfmSjLUg>
    <xmx:xIPvZW6Odmx1HuhUf_lNyMa0__SCFAiyilHUGJS9US2SBkSLa3MdEA>
    <xmx:xIPvZSgVwOShwGWdHpMtAYf0lySv-cQaKMwVkZKsyfYmc6eH6hSPmg>
    <xmx:xIPvZZJ4oLONEZgB5mWsM8ZPakE4jUmzmnMBvm57lgUq7l_iJfbwnA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Mar 2024 18:20:51 -0400 (EDT)
Message-ID: <f203a0a3-9107-4290-a934-0f6736fe218a@sholland.org>
Date: Mon, 11 Mar 2024 17:20:50 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: mfd: x-powers,axp152: document AXP717
To: Andre Przywara <andre.przywara@arm.com>
Cc: devicetree@vger.kernel.org, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20240310010211.28653-1-andre.przywara@arm.com>
 <20240310010211.28653-3-andre.przywara@arm.com>
Content-Language: en-US
From: Samuel Holland <samuel@sholland.org>
In-Reply-To: <20240310010211.28653-3-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andre,

On 3/9/24 19:02, Andre Przywara wrote:
> The X-Powers AXP717 is a PMIC used on some newer Allwinner devices.
> Among quite some regulators it features the usual ADC/IRQ/power key
> parts, plus a battery charger circuit, and some newly introduced USB
> type-C circuitry.

Do you plan to put the Type-C logic under a subnode, or should the
Type-C connector node go directly under the PMIC node? Either way, the
binding probably needs to be updated for that.

> Like two other recent PMICs, it lacks the DC/DC converter PWM frequency
> control register, that rate is fixed here as well.
> 
> Add the new compatible string, and add that to the list of PMICs without
> the PWM frequency property.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> index 06f1779835a1e..b8e8db0d58e9c 100644
> --- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> +++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> @@ -83,6 +83,7 @@ allOf:
>              enum:
>                - x-powers,axp313a
>                - x-powers,axp15060
> +              - x-powers,axp717
>  
>      then:
>        properties:
> @@ -99,6 +100,7 @@ properties:
>            - x-powers,axp221
>            - x-powers,axp223
>            - x-powers,axp313a
> +          - x-powers,axp717
>            - x-powers,axp803
>            - x-powers,axp806
>            - x-powers,axp809

The regulators patternProperties needs to be updated for the new boost
regulator.

Regards,
Samuel



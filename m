Return-Path: <linux-kernel+bounces-66125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D06DB85575A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 369BB1F22C7D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080241420B2;
	Wed, 14 Feb 2024 23:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="Dc2PqHBS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r2Cs+7W6"
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5342574B;
	Wed, 14 Feb 2024 23:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707953863; cv=none; b=Tt3WtxYywUAIKvMjpl605CjrUirlppO3JxQoildWmnV4AG7YuR2DZgr5a84QjWT96D3/5KwioQBhDjgJvD/XBRoCHb+xyIL2KbAbINTXeAbDC9qtU6ApFrqWI9ezg/EpPRDudxpl1HSuGXkQha8wfoYZSVy6iVU9g7fchqhUzsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707953863; c=relaxed/simple;
	bh=wHhSkCAQ4jCsmCUPi1doFLRLF21eREZxoFe7qX9fcqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYZihEjZpNYCsFl7T7bAu76bCuPbMi7mkUhx+4Yp+jTOxr6fsKvw066xyeHY2UU9WyxBPDneWnE0SqglIwfxXxYdMXdnIpE6KDEzOXgLTLQnEsEdT8qvfJYryfIKn9VwnCpD+s+XqWLBU/H7BYrm7urljHSkQw3M/cgdIUIYNFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org; spf=pass smtp.mailfrom=feathertop.org; dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b=Dc2PqHBS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r2Cs+7W6; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id BE97E13800B9;
	Wed, 14 Feb 2024 18:37:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 14 Feb 2024 18:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1707953859; x=1708040259; bh=/UFfJYIm/yavIcO2nw7qw6EXLoX+Pvhw
	S6K9sGJKtnc=; b=Dc2PqHBSIA54bk5jx/HL8ncEcCJ8dx4USPT3/hYMTx0vlquB
	oEON0McF4x+kOjdaxH8znnE2nqIeMux5Orp2THmoILtHCw5MVblXmqsNt8AFQinj
	B8X6BnzIP3IFIoeQhWbQx94ID9qVuzJznUnqZhcHQZ6fs2UY043viHUhRbJP0w4i
	USfbWjxRln9dwTXnpxuDU3o7S3QlxyXG2yU4XDyHrAaEiMlRcb/MTHOLIlhUcMXg
	WvYODEaWDNxecKVYJTali5eXynUnegmTDeCBqGgjoyu3HkjnSN3CM6IRvwt5JdkP
	CRBx77gCtMUOU1voaqUePtkC85YSQyNNWspLlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707953859; x=
	1708040259; bh=/UFfJYIm/yavIcO2nw7qw6EXLoX+PvhwS6K9sGJKtnc=; b=r
	2Cs+7W6j6xo+o5B64T5cFuFbU0DuNU8+nsfVlNd1YFTKTghPwzW15gtDbboqkrPC
	qErQ3BcgF+1zCrsSTNamGusdaHppwtLHg5wulhXZTZEyHcWLHRytRIoqIgVWGiaw
	x84tlfu/lTu0IYTX8x5sNCfVb5Gk3jIzFJ+IKVn97SY+5v5NX3hlqYct0ahNBFr5
	ya5Am954aurv2GookVao1zo+9ptrlt6BbgtptYEnnDHY5SrMj6BjlTBOlevvAH3G
	ogMrF4yAbnn38pVDfz8SRg2WZU0PoDhCmmXyt3h8bR/Y3pml5wTy7Jet9gIJnxD2
	LmBl+lfczu19cU6tLDDNQ==
X-ME-Sender: <xms:wk7NZfFW_PXbkXwdsRTWvhCnftN7JgkYwlL1XudcKEupsYOBML3pqg>
    <xme:wk7NZcWmr95cnPYvR489vGUanqTHKE3aCMymkz3G7LbOQIi0V41r_ndTlHXv2dsQZ
    VCxElnKIg>
X-ME-Received: <xmr:wk7NZRJYmyslXFlWUIJqc2pvEarVclulWUuv4DjCuzjIxXFySlkwm78WFwP8DBDpWlSrVQ8jbh8DRrV5bOGI5a216OpyribhCHKYrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepvfhimhcu
    nfhunhhnuceothhimhesfhgvrghthhgvrhhtohhprdhorhhgqeenucggtffrrghtthgvrh
    hnpeehhefglefhffegfeekgfejleekudelfeevhffgkefgteeftedvieegkeejvdffheen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtihhmse
    hfvggrthhhvghrthhophdrohhrgh
X-ME-Proxy: <xmx:wk7NZdEXwDPUolblje4cQKguYlvdYcg5BYRPYL1ULQwZ51xC2gt9XA>
    <xmx:wk7NZVWuHw3pi7b1V7va6ZbODXZMCQ-tHpGLhDv3f8oxEGY9armslw>
    <xmx:wk7NZYM0YPrzTZdX4UqDekGMajBCbyfbyQMSpJIsXAeIsbtwWxxgrA>
    <xmx:w07NZaUdsm12Ula9ZJj0ghgmSaEwUrx4m92tipuODtEOH4M0WODwrA>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Feb 2024 18:37:34 -0500 (EST)
Message-ID: <3f1c1f14-9a6e-4d07-8311-59d7b55e1c9d@feathertop.org>
Date: Thu, 15 Feb 2024 10:37:30 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: arm: rockchip: Correct vendor for Banana
 Pi R2 Pro
Content-Language: en-US
To: linux-rockchip@lists.infradead.org
Cc: Andy Yan <andyshrk@163.com>, Chris Morgan <macromorgan@hotmail.com>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jagan Teki <jagan@edgeble.ai>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Ondrej Jirman <megi@xff.cz>, Rob Herring <robh+dt@kernel.org>,
 Tianling Shen <cnsztl@gmail.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240214040731.3069111-1-tim@feathertop.org>
 <20240214040731.3069111-3-tim@feathertop.org>
From: Tim Lunn <tim@feathertop.org>
In-Reply-To: <20240214040731.3069111-3-tim@feathertop.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/14/24 15:07, Tim Lunn wrote:
> The vendor for this board was incorrectly listed as Rockchip. Fix this
> now while they are not used anywhere, in the future they may be used by
> bootloader to select dts.
>
> Update the vendor to Sinovoip.
>
> Signed-off-by: Tim Lunn <tim@feathertop.org>
Fixes: 8ad885126daa ("dt-bindings: rockchip: Add BananaPi R2 Pro Board")
> ---
>
>   Documentation/devicetree/bindings/arm/rockchip.yaml | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 29f922f3ca4e..89261b9601ce 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -940,9 +940,9 @@ properties:
>             - const: rockchip,rk3568-evb1-v10
>             - const: rockchip,rk3568
>   
> -      - description: Rockchip RK3568 Banana Pi R2 Pro
> +      - description: Sinovoip RK3568 Banana Pi R2 Pro
>           items:
> -          - const: rockchip,rk3568-bpi-r2pro
> +          - const: sinovoip,rk3568-bpi-r2pro
>             - const: rockchip,rk3568
>   
>         - description: Sonoff iHost Smart Home Hub


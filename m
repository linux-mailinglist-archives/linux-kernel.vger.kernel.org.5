Return-Path: <linux-kernel+bounces-66128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B48E85576F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBDF11C26CCF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B362C145332;
	Wed, 14 Feb 2024 23:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="PGF6LE/z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KyU24nWb"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0701D1420DD;
	Wed, 14 Feb 2024 23:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707954348; cv=none; b=DU/niFBcHAWdgB1ggSPXcC6v9ZmCHa3Lej//ZYhhadgx02aEqx/Qn9k1aqznmT9QoNZqS+b9JkmThK+/jX10UVVGJpWwTzJsibEXP+JZ3nk2OKzp40qBmPkGmuzNtNZ88g1zrLVr9J3aYDSfplj9qFAH8N7m2OP81Uup/9gEdP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707954348; c=relaxed/simple;
	bh=fi7gfzCCbQQA/Oqoj1M8vAgZsO6JfkjOligTB2EWADM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RpnQRMJ2+t6MUK3E5Ze7l+yTS7GkaIKP+ozgK0qGOIQQl3c/R3/poN9e+Jf4Z8fwoADR741acM3Kd0JsshmZE2MpT2Ln96oH7Je7koBkXTr3IoB3V78p116wRjf3aJmpaF7f0JXgBuU6ZPCv6/HxkC2Qxwg8dm0vstrTAzCCAOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org; spf=pass smtp.mailfrom=feathertop.org; dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b=PGF6LE/z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KyU24nWb; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D2E1C11400C2;
	Wed, 14 Feb 2024 18:45:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 14 Feb 2024 18:45:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1707954345; x=1708040745; bh=AQeY3wowKfmbs6NAg7U/aU+sEcmVoRrQ
	g5C1WLQ/QO0=; b=PGF6LE/zkDkCYCDm/EJaL5w0K9+oXiJY11zZWFAJm3A6x5OT
	hvTDzTGTGh0JHAru/3tvOouhTIhZFaS+gVZT8kVD0zNj9St7d/6JTQFekOrZUb0C
	Z+e1VrbB2701a+jOuW3nmiGm1q/GBlU7ZITwVj8V8wju5Q4Mte9N4mCHiPOvQJQ/
	ArO9eKyHPz6vu66mI0RGfx5mD28KM/13hWHVsbPjr4mn9J+NjsS7YTjTFwT+FvsN
	L5ED6enZbWdntfJw2HApjRHPMNt9JQX0TzceikeelyLC3Z0pC/m0v9SX+rSE8245
	pSj0l28Lm40zH2H17cdqwfkLu0F//GzoglI5kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707954345; x=
	1708040745; bh=AQeY3wowKfmbs6NAg7U/aU+sEcmVoRrQg5C1WLQ/QO0=; b=K
	yU24nWblowt5brepYqhv6N5qd26FZXoSlN6P220E81HW30koTR1imPi/acCiHEHr
	hl916m7X39ViLbAN2AQSw/fLghKny2RF0RUVSeK+gIsziKCgmebk5JQLPohS1uwz
	kQUBE8CG8OQEzHNsanpyskaL1aojThbyztqU/0akmx3pifHd/6jt3vCEAFsj3QWX
	rsReDrfy7N30/LjUxfGTkkPdXcC7FQ5h2XGqt1AKmdZIZ6beJud+/yjgPjvrEJnu
	AjytQUp/aVThVCxwvS3X7FKjQhuKvHHl+V9zf9o+lAlqW96vn8mqqMHKAIVXjrnc
	KRU1P5rDWHiDI9j+FTidg==
X-ME-Sender: <xms:qVDNZWHQoDROPXgJowx7MWn4lnle8T_fjnl0MBg-t3kc9gHdJp7d6w>
    <xme:qVDNZXX7EWNaHN_r_cOAZ8du8E8mO7O0XI2J51b4Izy8Ek4IBS9b5umgbpatRz7LN
    hH6g6-icw>
X-ME-Received: <xmr:qVDNZQKHz5PInv9C4CtVaj7WMam4j8_U0e0maZkrZ2v8vnfIcBqM9FkcgFyNEsLa4CopB_VbGk-Eb3XdjiP8tD4t40AW0ZfY1B1oFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepvfhimhcu
    nfhunhhnuceothhimhesfhgvrghthhgvrhhtohhprdhorhhgqeenucggtffrrghtthgvrh
    hnpeehhefglefhffegfeekgfejleekudelfeevhffgkefgteeftedvieegkeejvdffheen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtihhmse
    hfvggrthhhvghrthhophdrohhrgh
X-ME-Proxy: <xmx:qVDNZQG0Y9kzOgZRWdfoIbd344AzibkCTxqA8mTm1LSbCuWceL5HmA>
    <xmx:qVDNZcVOXC4Vao3e_kMJkXNRwmwU2DBBJwMdTdk8TB8cT1C_TcaMsA>
    <xmx:qVDNZTMklaBxEWqSaPKDzG3MXZ-cQnx0b6uB51J3fCxR56mIGKOhpw>
    <xmx:qVDNZdV4r5lJSb-FppgdDlv1dx_Q0-vgCFIojEWSqUCM1wCAIFQSHg>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Feb 2024 18:45:41 -0500 (EST)
Message-ID: <0e6cee7c-9726-4d45-a06a-a8882e271e7b@feathertop.org>
Date: Thu, 15 Feb 2024 10:45:39 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: arm: rockchip: Correct vendor for Orange
 Pi RK3399 board
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
 <20240214040731.3069111-2-tim@feathertop.org>
From: Tim Lunn <tim@feathertop.org>
In-Reply-To: <20240214040731.3069111-2-tim@feathertop.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/14/24 15:07, Tim Lunn wrote:
> The vendor for this board was incorrectly listed as Rockchip. Fix this
> now while they are not used anywhere, in the future they may be used by
> bootloader to select dts.
>
> Update the vendor to Xunlong.
>
> Signed-off-by: Tim Lunn <tim@feathertop.org>
Fixes: 08b64bd2c681 ("arm64: dts: rockchip: Add support for the Orange 
Pi RK3399 board")
> ---
>
>   Documentation/devicetree/bindings/arm/rockchip.yaml | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 5cf5cbef2cf5..29f922f3ca4e 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -626,9 +626,9 @@ properties:
>             - const: openailab,eaidk-610
>             - const: rockchip,rk3399
>   
> -      - description: Orange Pi RK3399 board
> +      - description: Xunlong Orange Pi RK3399 board
>           items:
> -          - const: rockchip,rk3399-orangepi
> +          - const: xunlong,rk3399-orangepi
>             - const: rockchip,rk3399
>   
>         - description: Phytec phyCORE-RK3288 Rapid Development Kit


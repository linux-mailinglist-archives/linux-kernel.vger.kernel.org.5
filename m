Return-Path: <linux-kernel+bounces-26916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B004682E7D0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 03:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35055B22065
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AF029AD;
	Tue, 16 Jan 2024 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="nQp7+hD1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uf9q2wMC"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76260388;
	Tue, 16 Jan 2024 02:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 5FB0A5C0178;
	Mon, 15 Jan 2024 21:00:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 15 Jan 2024 21:00:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1705370425; x=1705456825; bh=2Z1qmxEMsTLQKMDBfJ+3O0kjmLD/ZIDW
	rrbu4Nd1JY8=; b=nQp7+hD1mEDFNO9npIAC09Ca9w/EUlHo5mORB4C09PhCzBaN
	vPaMLM3XpxZ0mdePdFX9F+cVNHRM0YuecJV9brXIQHCtMh+71H8sVoBCkzLvTi1E
	HIGouJJSU94nSPb8PgY4lSppEnL4x4Z5WmKAKB+KTejQ/zFJIyfF0h97Oc67J590
	pKC3Mo88Iao1rb6t1tDJQ/71TtBRBRaHRrWpO+LjLKuQiwdQ0t0oWs+saA3r0F6d
	BbOqtf1QSIlQiijNOhr57KA1PZpp2jyl50pSO+BIM3+yGk/jJkRmRgZ2mfep/NtA
	lpLAqIrKmXN3Lr15z64O1RVVMxUwxZ7HWgfuww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705370425; x=
	1705456825; bh=2Z1qmxEMsTLQKMDBfJ+3O0kjmLD/ZIDWrrbu4Nd1JY8=; b=U
	f9q2wMCYiBq/sv/XZ0oWHcrEPi5NNNjVQNkEkxP4pvGO8hOGUyCunIDIY3S75nCs
	TiDPxJXJVckT4/Lmwb8o3bKFhs1k93/585YD/GN9LX5JV4po2kqLNAzh1JatpmpS
	ahxvTOayTo6mv7aVBL56W7dHsJ1HZon//HO1LgRgaKXgLfE4MLj4FY848T1Kul5+
	nI8YI/wrNr5/r4HWZa4CjwT3K9Z0WNe8pFb+9f1w1EFFTHA0I3UhZHVQKrd14YSX
	0uigaULCZeMy0ilwADhDb3YVIdcMmRib1ktFD2RC25B9T869M8TL5sORW+eTnRbx
	AGjRzdLOusHM1liQpc1bA==
X-ME-Sender: <xms:OOOlZfmX7XpJvnjcIa9Kq1JcYz2nDGCrHILkaK0r93BG80MKu4kAAg>
    <xme:OOOlZS2HNR2SJlC5C0scqG2XwwqLfVf8jIJKLItxWifU6nkS-AAOHdsVmprJHDHJ0
    m74amzj1w>
X-ME-Received: <xmr:OOOlZVpUGSIBay8uQZZCejcjUleP1uczMxKswtuDkjbnkqnYe6l14zz-CiyMXppb_My4wmOQ4AgkwnjT1N6qpzOBgTtfgGD2lwF4Hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejvddggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhm
    ucfnuhhnnhcuoehtihhmsehfvggrthhhvghrthhophdrohhrgheqnecuggftrfgrthhtvg
    hrnhepjeekhfeikeffgfeuvdefgfehudevffeiudeiudfgveevudeukeetveeiueehtedv
    necuffhomhgrihhnpehlihhnrghrohdrohhrghdpihhnfhhrrgguvggrugdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtihhmsehf
    vggrthhhvghrthhophdrohhrgh
X-ME-Proxy: <xmx:OOOlZXkybVrzi8xkVydYhUDZetMJ5H9fWi2TATa3iDPS_elPcyfW2g>
    <xmx:OOOlZd33pk1pFHCqC1v0oPRHV-Iuhw8aquvYHI4Ng45Wt0CngGujVA>
    <xmx:OOOlZWuzarl8bGVNlAV5XEobCJXPhTeUbmQnEQ8ZTwEl_5Qf88gKrA>
    <xmx:OeOlZc3UFnagpq3i1sFx5jLSm0Ps7dZvTsFgMsCgGQgm8ltRqTCecQ>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jan 2024 21:00:18 -0500 (EST)
Message-ID: <8b31ae29-b88b-4ded-95b4-c2d9bbad24e1@feathertop.org>
Date: Tue, 16 Jan 2024 13:00:15 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: rockchip: Fix Hardkernel ODROID-M1 board
 bindings
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 KyuHyuk Lee <lee@kyuhyuk.kr>, Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Chris Morgan <macromorgan@hotmail.com>, Tianling Shen <cnsztl@gmail.com>,
 Jagan Teki <jagan@edgeble.ai>, Ondrej Jirman <megi@xff.cz>,
 Andy Yan <andyshrk@163.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240115145142.6292-1-lee@kyuhyuk.kr>
 <b4f97202-43ec-4f04-af95-b1ccd3b5d203@linaro.org>
From: Tim Lunn <tim@feathertop.org>
In-Reply-To: <b4f97202-43ec-4f04-af95-b1ccd3b5d203@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/16/24 01:58, Krzysztof Kozlowski wrote:
> On 15/01/2024 15:51, KyuHyuk Lee wrote:
>> The vendor in ODROID-M1 is hardkernel, but it was incorrectly written
>> as rockchip. Fixed the vendor prefix correctly.
>>
>> Signed-off-by: KyuHyuk Lee <lee@kyuhyuk.kr>
>> ---
>>   Documentation/devicetree/bindings/arm/rockchip.yaml | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> You need to start testing your patches. Your last M1 fails as well in
> multiple places.
>
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).
>
> The DTS change will break the users, so would be nice to mention this in
> its commit msg.

I notice there are a couple of other boards that incorrectly use 
rockchip as the vendor also:

           - const: rockchip,rk3399-orangepi
           - const: rockchip,rk3568-bpi-r2pro

Perhaps these should also be fixed at the same time?

Regards
   Tim

>
> Best regards,
> Krzysztof
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


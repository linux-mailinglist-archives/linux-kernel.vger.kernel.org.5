Return-Path: <linux-kernel+bounces-47660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C0E8450E3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323472900F0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFE071B32;
	Thu,  1 Feb 2024 05:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="K9mqaiBt"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6991612E5;
	Thu,  1 Feb 2024 05:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706766344; cv=none; b=MJS1sp6vE6HlsP74QoWaXQIiYAwZ+VSdJ/BpQSgPWNgop0FAWDgNaKLVPuhQLqU+SEVFeyQHVz8opB58JSAkAcDB9D/lCIktqRbF+3ozFnZeeGi9A0PsmQFh3u+ZGG/vF7wh9kNdV/+smYs7rIiA1g6uDy7wIyJOlV+zNVgbQew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706766344; c=relaxed/simple;
	bh=jEXaJxk3bfW1i9fWeuWYYX1uSmdxuhTcmO6xBhD+QkU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=prRbk5fVvVRJcBuXvH0NG4B0OLvsWFL3h5yO5kqUYHnlWTmK0EoPJQXtrJPEc/zZ/8k/2rVM8tAZFaFSx2EOAJg7uA5bCnwLlnPONH+P5132Ce/aSPaVvQ6KmOvmOGd70IQhfK/sRHbkl/ZT1o+YnXkkS2yJdP+ktNQMMRbP4nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=K9mqaiBt; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-76-194.adl-apt-pir-bras31.tpg.internode.on.net [14.2.76.194])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 01E622017A;
	Thu,  1 Feb 2024 13:45:39 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1706766340;
	bh=nKCRisLpHjguaVO1EIS9AvNZ77fEHliVyA2UU02dTc8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=K9mqaiBtHwYehzQbf5LaySLWiMCocrRBFE0VQPz2DmpZPkhuPeOFm6ToPACVmmhNd
	 gT07+TMmNj9qpG8aCnyBBbV8CaBuulaA5srG3xBcXDkX9C0i4WhB/umOKB1qdImekR
	 Q1r5eP5JX86BpKSstQ4UD7qHS7Kjj+durIOQ7II1spM81ecVoyV/mE3bLCFcE8EL7e
	 0yV4ayPVVbVpUspAvNhyypdmuq9ughVDFn+F6GH9NJ6tK3IoFBIxLgEtApXyCGpU3E
	 vt5MiOFY657MRQuIP/nuHajEcqO6edsky6r18lwHEn839OxnhzXngpISCpgZ4O5yQ4
	 itYW4YT67vOKA==
Message-ID: <1823c7e3fd460b64c5bab3c1c6623a0a63e073d6.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5 11/21] ARM: dts: aspeed: yosemite4: Add eeprom for
 yosemite4 use
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Joel Stanley <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 01 Feb 2024 16:15:39 +1030
In-Reply-To: <20240131084134.328307-12-Delphine_CC_Chiu@wiwynn.com>
References: <20240131084134.328307-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240131084134.328307-12-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-31 at 16:41 +0800, Delphine CC Chiu wrote:
> Add eeprom for yosemite4 use
>=20
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index e8d7eb7ff568..f00df378a371 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -932,7 +932,7 @@ temperature-sensor@4b {
>  	};
> =20
>  	eeprom@54 {
> -		compatible =3D "atmel,24c256";
> +		compatible =3D "atmel,24c128";

This is changing an existing eeprom, not adding a new one - contrary to
the commit message. It probably should be in a separate patch?
Presumably this is also motivated by the change in the schematics? Some
explanation would be helpful.

I'm half wondering whether it would have been easier to add a separate
DTS for the new version of the schematic rather than make all these
piecemeal changes.

Andrew



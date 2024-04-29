Return-Path: <linux-kernel+bounces-161897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9269A8B52EE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D7E028113E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4020168DD;
	Mon, 29 Apr 2024 08:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="b1CB8J1X"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CB0171B6;
	Mon, 29 Apr 2024 08:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714378569; cv=none; b=QrtrmsmBjyEf3cfOPMCR32L/Fy439OA02UrAMNym7SFVQ4AyMzmaAOZHMm991jgXlop0ycfqY3A6W7SqP7S20lhV1rx0mKokuqKZy4zCNra+WdsTLSGZoppp3M7uwJLxLOtVTZcnVEOUsg/aPLS4VhPs/qaae6HbjH3SDJGwoAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714378569; c=relaxed/simple;
	bh=7s5iSvsqFTmUoIa3Px/8v12ZjGoByRIT5TVQBF9IpCI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K0zhV32ECno/i7jmtwVTV15yAYdJ7XQEArwm/i7zRgahyuM8LspdYxoCYnzBFgTXqBTnvzd0XzxgubkkW6c2b3O917UcVQeqYHydRAYO8vaE+dLC4GoD0r5pFdJZpZBdSBc/AjfUZO+N7KPgad7/nM4TwZzs48RtaU0lQX7wo3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=b1CB8J1X; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=se7AtBgKBLSCjIDiPgMN8FZNwkMaou8DnZoH+7yRAOM=; t=1714378565; x=1714983365; 
	b=b1CB8J1XsoXQ6Pr6hZVsCRGdF3iRglqRCaAjTebRweR5DiQWjnDFp4cXJq5+ncO2c06minowzsW
	hTUHFze7WzkBflpd5u8H+No1H3Nl4o5fFyGufczGVxf14QS0PNajE03YTw7Jk5f++WUnpp51FRr5l
	UrvHNroTjyCvQjf6NvSeP+bCg104i09qjyZX/Pz2uUEu1lxtV13qrM1RCBLJr/SSOGzfs+UMyCM55
	Fo6aURU2cmQ+jOCdrV2VodlxudDaLTVNoo1qIjcCs09AQpu/QHafOgqgBoNTuT/5fcr/QVPPfdr5N
	iJ20zLA+gv8D9mV5/8TgT+0QttHLycRmInxw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s1MB8-00000003YzM-12Vc; Mon, 29 Apr 2024 10:16:02 +0200
Received: from dynamic-077-191-138-057.77.191.pool.telefonica.de ([77.191.138.57] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s1MB8-00000001HgH-08dG; Mon, 29 Apr 2024 10:16:02 +0200
Message-ID: <d6b562f336b3750c131830a984b148ea7103ab0d.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: j2: drop incorrect SPI controller max frequency
 property
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
  Conor Dooley <conor+dt@kernel.org>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 devicetree@vger.kernel.org, linux-sh@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Kousik Sanagavarapu <five231003@gmail.com>
Date: Mon, 29 Apr 2024 10:16:01 +0200
In-Reply-To: <20240322064221.25776-1-krzysztof.kozlowski@linaro.org>
References: <20240322064221.25776-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Fri, 2024-03-22 at 07:42 +0100, Krzysztof Kozlowski wrote:
> The J2 SPI controller bindings never allowed spi-max-frequency property
> in the controller node.  Neither old spi-bus.txt bindings, nor new DT
> schema allows it.  Linux driver does not parse that property from
> controller node, thus drop it from DTS as incorrect hardware
> description.  The SPI child device has already the same property with
> the same value, so functionality should not be affected.
>=20
> Cc: Kousik Sanagavarapu <five231003@gmail.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/sh/boot/dts/j2_mimas_v2.dts | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/arch/sh/boot/dts/j2_mimas_v2.dts b/arch/sh/boot/dts/j2_mimas=
_v2.dts
> index fa9562f78d53..faf884f53804 100644
> --- a/arch/sh/boot/dts/j2_mimas_v2.dts
> +++ b/arch/sh/boot/dts/j2_mimas_v2.dts
> @@ -71,8 +71,6 @@ spi0: spi@40 {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
> =20
> -			spi-max-frequency =3D <25000000>;
> -
>  			reg =3D <0x40 0x8>;
> =20
>  			sdcard@0 {

It seems that spi-bus.txt has been replaced by spi-controller.yaml now, so
I think we should update the filename in the commit message, shouldn't we?

Besides that, I agree with the changes.

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913


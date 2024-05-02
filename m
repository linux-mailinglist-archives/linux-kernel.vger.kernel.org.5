Return-Path: <linux-kernel+bounces-166302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 845008B98CB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83381C21E89
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7FC58AC4;
	Thu,  2 May 2024 10:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="R75ht3ED"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34DC5490A;
	Thu,  2 May 2024 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714645695; cv=none; b=Z1rEUopdsyZ8sAR6yPPsC/drqpU174f8iakAD8ifGr2oX9ibhnGi8PbmPjHnt9vUznyYLWQLiKQk0h8PUDthUVS1+WlFndiOp+7SDPdlyE8ryFXNrMpC1HCs8V1XxLA7On4JAqbSXdIzfMEsivyn6qiOxmMm6RC3oP5vPkT8/W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714645695; c=relaxed/simple;
	bh=QmV/eTHFw8ZKJX10ez9RvU5h49+qC63UtC3QhKPZVpw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bRPYxCF4Vzlx+sfVDFCPaHACEZz/ZYBZC46tA1b1I6K7Ix5leeXFaUL7nMlO7D0pLW340bdaVu98NWD52A+RfKqndvQCFzNDRBjw4V7fGdr4WryObmFdyhVsYK1lJHu4fxGVbC/etM4NBvoMVpNgxkB+8/PAdkvn7YoOi4sH4HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=R75ht3ED; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ravhJOzIKgIW3saDRAbKe8VZQUb/zFOpUwQ7zgeZ6Ms=; t=1714645693; x=1715250493; 
	b=R75ht3EDRsv8hOTbRSDFY64C+zTBXL99lvQUfQi6nby8K+RsqFmRd7QwxXpG/VaYQsnAdJUaFPT
	cEhx6ALSCt5aUth80JP9XNJFKDxHzZqkgFvLV7SLaqrJXx3V+5HP53xsH/REBCc4t/yFhOQD8fNxG
	moMtNOBtLp021DGOos4zwry+IP4ZItn4V64owk2AwooKHjcXCvpf5/PFnCmlcaHF+DpvkXjdn0N88
	66gKpZjnHh3tgWXBEIYjbgky5sybh9bq+/VBAOiL3R5pmQ0vYXzA8qqVpK3OvTSOWDBgU1Ruid3ZV
	mGdt0KUDS+a8a1i+PjVUgZotG+93zh9ELntA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s2Tfe-00000001yC6-1TSg; Thu, 02 May 2024 12:28:10 +0200
Received: from p57bd90e8.dip0.t-ipconnect.de ([87.189.144.232] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s2Tfe-000000007WF-0Y7d; Thu, 02 May 2024 12:28:10 +0200
Message-ID: <1280dad5fe1761d0c8828d6cee6dbd91e077a5b0.camel@physik.fu-berlin.de>
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
Date: Thu, 02 May 2024 12:28:09 +0200
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

Applied to my sh-linux tree in the for-next branch.

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913


Return-Path: <linux-kernel+bounces-112710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBED887D38
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 15:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247551C20ABD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F21A182D4;
	Sun, 24 Mar 2024 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="Zgfs6kJu"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A3810A19;
	Sun, 24 Mar 2024 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711291128; cv=none; b=AHtZntQMt/ESxFy7I2U/NkGuJ4TgornTIQm6V/JFzYlG592otj0EYPqmg7uoaX1p0iGhpAMYs95UZLXEEjerMGmYzFa5LMl0qLGrT/6vS+/hQYc0juSU0oRULELc7jKAv0FzjbTEiHp8I6WzFH2ByIp+yVvsGASaQq13lNFVFAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711291128; c=relaxed/simple;
	bh=IbsCl9l2o8yFRzxnTIHD21nvFORmc81BmARxaSCYcRc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TFzAoXww/IhaYzSVaJtJ9wOVKELuMb2yjm/JgU6Rn6AUaLcu181OI+UjpEPgoQ+RLpR48A6hTGKwRgJOpwRWcSI5grYynWs/ACEGMCd90qz7XSjtOILGyvt+3GOeA3ndgPpZ0aFEHCoE9Vx0PRTBs7Moktx4shvNrl+xPXwMnCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=Zgfs6kJu; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1711291118;
	bh=IbsCl9l2o8yFRzxnTIHD21nvFORmc81BmARxaSCYcRc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Zgfs6kJu7XcbbtN5sfNCkJmpgBquCo0qpHVWDb0ye12q1YA2pIun9RU/ncnRIrm2m
	 ZQCq4XQbP7vMZSbG3oyJ3blii5OrRtC/jpxV83y96CJ4eMOCbQA96dM+ZhxattXuxs
	 uNdiWM2T1ep3SipujgMP1W2b5bXHOM3wo9GsfsMg=
Received: from [IPv6:240e:358:11fe:a000:dc73:854d:832e:8] (unknown [IPv6:240e:358:11fe:a000:dc73:854d:832e:8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 06DBA6737D;
	Sun, 24 Mar 2024 10:38:26 -0400 (EDT)
Message-ID: <0c3c6f3cae125fd51105264308aff5d9968a65e2.camel@xry111.site>
Subject: Re: [PATCH v8 4/4] riscv: dts: thead: Enable LicheePi 4A eMMC and
 microSD
From: Xi Ruoyao <xry111@xry111.site>
To: Drew Fustini <drew@pdp7.com>, Maxim Kiselev <bigunclemax@gmail.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, 
 devicetree@vger.kernel.org, dfustini@baylibre.com, guoren@kernel.org, 
 jkridner@beagleboard.org, jszhang@kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, open list
 <linux-kernel@vger.kernel.org>,  linux-riscv@lists.infradead.org, Palmer
 Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 robertcnelson@beagleboard.org, Rob Herring <robh+dt@kernel.org>, 
 wefu@redhat.com
Date: Sun, 24 Mar 2024 22:38:21 +0800
In-Reply-To: <Zf+A7KEYL/tZb9/N@x1>
References: 
	<CALHCpMhc1F5Ue7U_gsDXREHUZRVQJNYRCJxYxoNqbN=-39jf7A@mail.gmail.com>
	 <Zf+A7KEYL/tZb9/N@x1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-03-23 at 18:25 -0700, Drew Fustini wrote:
> On Wed, Mar 20, 2024 at 03:28:19PM +0300, Maxim Kiselev wrote:
> > Hi Xi, Drew
> >=20
> > I have the same problem with SD on my LicheePi 4A.
> >=20
> > After some investigations I found how to fix this tuning error.
> > Here is the patch that increases tuning loop count from
> > 40(MAX_TUNING_LOOP at sdhci.c) to 128.
> >=20
> > diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c
> > b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > index 8d6cfb648096..da8f5820fb69 100644
> > --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> > +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > @@ -706,6 +706,7 @@ static int th1520_execute_tuning(struct
> > sdhci_host
> > *host, u32 opcode)
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* perform tuning */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sdhci_start_tuning(host);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 host->tuning_loop_count =3D 128:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 host->tuning_err =3D __sdhci=
_execute_tuning(host, opcode);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (host->tuning_err) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* disable auto-tuning upon tuning error */
> >=20
> > After that change tuning works fine. The same value of loop count is
> > used in RevyOS BSP
> > https://github.com/revyos/thead-kernel/blob/c6d4e5df18a17903d012ffd89e6=
7d0ee5ce6cf2d/drivers/mmc/host/sdhci-of-dwcmshc.c#L185
> >=20
> > Honestly, it looks a little bit strange for me.
> >=20
> > It seems that the tuning algorithm requires to move through
> > all the taps of delay line(128 taps?) even if we use THRESHOLD_MODE
> > instend LARGEST_WIN_MODE (I mean bit 2 in AT_CTRL_R(0x540)
> > register).
> >=20
> > Xi, could you also test my fix on your board?

It works for me as well.  I'm now getting:

[    0.854357] mmc1: new ultra high speed SDR104 SDXC card at address aaaa
[    0.862267] mmcblk1: mmc1:aaaa SR256 238 GiB
[    0.876623]  mmcblk1: p1

Tested-by: Xi Ruoyao <xry111@xry111.site>

Thanks a lot!

> Thanks for figuring this out!
>=20
> When I was upstreaming support, I noticed __sdhci_execute_tuning() in
> T-Head's version of sdhci-of-dwcmshc.c seemed to duplicate what already
> existed in drivers/mmc/host/sdhci.c. I had thought T-Head copied it
> because it was a static function.
>=20
> 9cc811a342be ("mmc: sdhci: add __sdhci_execute_tuning() to header")
> allowed me to remove __sdhci_execute_tuning() from sdhci-of-dwcmshc.
> However, I overlooked this resulted in changing the tuning loop from
> 128 back to the upstream default of 40.
>=20
> Before this change, the microSD did work for me on the lpi4 but I would
> see the following:
>=20
> [=C2=A0=C2=A0=C2=A0 4.182483] mmc1: Tuning failed, falling back to fixed =
sampling
> clock
> [=C2=A0=C2=A0=C2=A0 4.189022] sdhci-dwcmshc ffe7090000.mmc: tuning failed=
: -11
> [=C2=A0=C2=A0=C2=A0 4.194734] mmc1: tuning execution failed: -5
> [=C2=A0=C2=A0=C2=A0 4.287899] mmc1: new high speed SDHC card at address a=
aaa
> [=C2=A0=C2=A0=C2=A0 4.299763] mmcblk1: mmc1:aaaa SD32G 29.7 GiB
> [=C2=A0=C2=A0=C2=A0 4.316963]=C2=A0 mmcblk1: p1 p2
>=20
> root@lpi4amain:~# cat /sys/kernel/debug/mmc1/ios
> clock:		50000000 Hz
> actual clock:	49500000 Hz
> vdd:		21 (3.3 ~ 3.4 V)
> bus mode:	2 (push-pull)
> chip select:	0 (don't care)
> power mode:	2 (on)
> bus width:	2 (4 bits)
> timing spec:	2 (sd high-speed)
> signal voltage:	0 (3.30 V)
> driver type:	0 (driver type B)
>=20
> With the change to 128, I no longer see the tuning failure and the
> microSD continues to work okay:
>=20
> [=C2=A0=C2=A0=C2=A0 4.307040] mmc1: new ultra high speed SDR104 SDHC card=
 at address
> aaaa
> [=C2=A0=C2=A0=C2=A0 4.320462] mmcblk1: mmc1:aaaa SD32G 29.7 GiB
> [=C2=A0=C2=A0=C2=A0 4.338646]=C2=A0 mmcblk1: p1 p2
>=20
> root@lpi4amain:/sys/kernel/debug/mmc1# cat ios
> clock:		198000000 Hz
> actual clock:	198000000 Hz
> vdd:		21 (3.3 ~ 3.4 V)
> bus mode:	2 (push-pull)
> chip select:	0 (don't care)
> power mode:	2 (on)
> bus width:	2 (4 bits)
> timing spec:	6 (sd uhs SDR104)
> signal voltage:	1 (1.80 V)
> driver type:	0 (driver type B)
>=20
> This has the benefit of the card now works at 198 MHz in SDR104 mode
> instead of 50 MHz when tuning failed.
>=20
> Tested-by: Drew Fustini <drew@pdp7.com>

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University


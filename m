Return-Path: <linux-kernel+bounces-108917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B788811E6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64DBF1C224F7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B25405EC;
	Wed, 20 Mar 2024 12:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="SW6BUJls"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31976224F2;
	Wed, 20 Mar 2024 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710939142; cv=none; b=pK+2Pdk6p2+CAudHnm5TkTj/Ih8HBcsrj3dyBWsHIwLBDFkICbceYKqgVz2Rf9kkO+BTGuJbGTQSmV+x2b2m2sdFV8DrHtEpKm8HAnjkeslmn6SCaEeKUmEoPPHnJWtc84k1lD6vZvSpNaQfG0BYAhiDkVRvk77o6xAuPamc7x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710939142; c=relaxed/simple;
	bh=nQsfUBwMPXVe4K5gt0eAIEFG0mAVL84r5St9i8+wxIk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AbiTg6zXxDmIg/wnvdRBoqXIhC11h8UN7Wr/wZmqmkyS/JxROMNQguy696uqbals65weYE5es032Bar+vSO5R1QPmWjSHjxyAUXZ7f8fUhPwNyP0nGnRGpXd1tIrpljTeihLyNqmakm4PyMPZi+fOpFirmM6kB0V1+/dTRDjrLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=SW6BUJls; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1710939138;
	bh=nQsfUBwMPXVe4K5gt0eAIEFG0mAVL84r5St9i8+wxIk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=SW6BUJlsDX/vH6gjWlpT+cbGApubryaDyEF8qDyDRffiR8F8JyIwyHOJ+GRsIFzBo
	 uDfOMHVc+690RVFFaVnT6KvRq57AOMDFG8hGl66yVb4i18Af+br29PzGSi8oUQXTc8
	 sLEEsQ/2rahhL4NQYDVDANRz/3xsfoNC8uxbwzWc=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 1B11B6776E;
	Wed, 20 Mar 2024 08:52:14 -0400 (EDT)
Message-ID: <2d3d529e006a6fbef6fe4a8a20b3eb23fa476ff7.camel@xry111.site>
Subject: Re: [PATCH v8 4/4] riscv: dts: thead: Enable LicheePi 4A eMMC and
 microSD
From: Xi Ruoyao <xry111@xry111.site>
To: Maxim Kiselev <bigunclemax@gmail.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, 
 devicetree@vger.kernel.org, dfustini@baylibre.com, guoren@kernel.org, 
 jkridner@beagleboard.org, jszhang@kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, open list
 <linux-kernel@vger.kernel.org>,  linux-riscv@lists.infradead.org, Palmer
 Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 robertcnelson@beagleboard.org, Rob Herring <robh+dt@kernel.org>, 
 wefu@redhat.com
Date: Wed, 20 Mar 2024 20:52:13 +0800
In-Reply-To: <CALHCpMhc1F5Ue7U_gsDXREHUZRVQJNYRCJxYxoNqbN=-39jf7A@mail.gmail.com>
References: 
	<CALHCpMhc1F5Ue7U_gsDXREHUZRVQJNYRCJxYxoNqbN=-39jf7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-03-20 at 15:28 +0300, Maxim Kiselev wrote:
> Hi Xi, Drew
>=20
> I have the same problem with SD on my LicheePi 4A.
>=20
> After some investigations I found how to fix this tuning error.
> Here is the patch that increases tuning loop count from
> 40(MAX_TUNING_LOOP at sdhci.c) to 128.
>=20
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c
> b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 8d6cfb648096..da8f5820fb69 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -706,6 +706,7 @@ static int th1520_execute_tuning(struct sdhci_host
> *host, u32 opcode)
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* perform tuning */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sdhci_start_tuning(host);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 host->tuning_loop_count =3D 128:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 host->tuning_err =3D __sdhci_e=
xecute_tuning(host, opcode);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (host->tuning_err) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* disable auto-tuning upon tuning error */
>=20
> After that change tuning works fine. The same value of loop count is
> used in RevyOS BSP
> https://github.com/revyos/thead-kernel/blob/c6d4e5df18a17903d012ffd89e67d=
0ee5ce6cf2d/drivers/mmc/host/sdhci-of-dwcmshc.c#L185
>=20
> Honestly, it looks a little bit strange for me.
>=20
> It seems that the tuning algorithm requires to move through
> all the taps of delay line(128 taps?) even if we use THRESHOLD_MODE
> instend LARGEST_WIN_MODE (I mean bit 2 in AT_CTRL_R(0x540) register).
>=20
> Xi, could you also test my fix on your board?

I'll try it this weekend.  Now having some work with "real time
priority" to do :(.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University


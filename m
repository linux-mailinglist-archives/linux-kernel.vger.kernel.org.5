Return-Path: <linux-kernel+bounces-108194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97C388074E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A21EB22288
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45827364D4;
	Tue, 19 Mar 2024 22:31:25 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16D9ED8;
	Tue, 19 Mar 2024 22:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710887484; cv=none; b=jNoDDUhn8j+rvh/DNxkxV9Q09lszRTtsB4ONW4eBt6iyfpcE7MSnTchcz/K6/cfqPZFXFzjNZVg6mdNgO9mosxS47MZA8mZLRHDe6iv6z0Fzw5wwc4w/JmSYCJE6P+hn1j593Qd9hSbESBBu68q+MorEsBfcACXWlaI7/SGIPPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710887484; c=relaxed/simple;
	bh=A34E+yxv1ovafAWAJetRKKG1Vwoa2cf9CTfz+kxC8Sg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=GzoqjWVit0kaV43LxtW5sIauezl0twJlHIf/aUkpNPjI76JSiManYiGgNRTK6o25SBzqpii1jtOmoqRcCNQyd69X/S4+QjVDvAsW/GFp8Ndh48qPyQb6re+NNkEHZ4O2bhBPuzTsD0MFbh13/1jND2ndbgRPrDu6buyGo2x+1I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 5CB9D62E1A81;
	Tue, 19 Mar 2024 23:31:19 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id buCitthY5iPP; Tue, 19 Mar 2024 23:31:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id A8F1762348AD;
	Tue, 19 Mar 2024 23:31:18 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qcuwPV9gpYre; Tue, 19 Mar 2024 23:31:18 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 7BE7E6450958;
	Tue, 19 Mar 2024 23:31:18 +0100 (CET)
Date: Tue, 19 Mar 2024 23:31:18 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	david oberhollenzer <david.oberhollenzer@sigma-star.at>
Message-ID: <1196553263.78350.1710887478387.JavaMail.zimbra@nod.at>
In-Reply-To: <Ze5uUyUuEDBM3p43@makrotopia.org>
References: <cover.1702952891.git.daniel@makrotopia.org> <82ceb13954f7e701bf47c112333e7b15a57fc360.1702952891.git.daniel@makrotopia.org> <20240219120156.383a1427@xps-13> <1209094181.98490.1708899174329.JavaMail.zimbra@nod.at> <ZdvV1KABu_UCSL7B@makrotopia.org> <1754825522.38834.1710105437883.JavaMail.zimbra@nod.at> <Ze5uUyUuEDBM3p43@makrotopia.org>
Subject: Re: [PATCH v7 7/7] mtd: ubi: provide NVMEM layer over UBI volumes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: provide NVMEM layer over UBI volumes
Thread-Index: ULk91lSCNuYw1pJMwwbTh6ecFyLSEA==

----- Urspr=C3=BCngliche Mail -----
> Von: "Daniel Golle" <daniel@makrotopia.org>
>> BTW: Is there a nice way to test this with nandsim in qemu?
>> I'd love being able to test all ubi attach code paths on my test setup.
>=20
> From what I can tell 'nandsim' doesn't have a way to be defined in
> Device Tree, making it unsuitable to test the attachment of UBI in
> this way.
>=20
> However, QEMU does support emulating TI OMAP's OneNAND controller, eg.
> as part of the Nokia N810 hardware supported by qemu-system-arm, see
>=20
> https://www.qemu.org/docs/master/system/arm/nseries.html
>=20
> So we could use that and modify the device tree in Linux to have a MTD
> partition for UBI and 'compatible =3D "linux,ubi";' set therein:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/arm/boot/dts/ti/omap/omap2420-n8x0-common.dtsi#n84
>=20
> If you like I can prepare such a test setup.

This would be great!

> Is there a repository for MTD/UBI tests to be run on QEMU which I should
> contribute this to?

UBI tests reside in the mtd-utils repository.
http://git.infradead.org/?p=3Dmtd-utils.git;a=3Dtree;f=3Dtests/ubi-tests;h=
=3D20fd6a043eeb96a81736dd07885f74e4e0bb0cc0;hb=3DHEAD

Maybe you can provide a small shell script which configures qemu?
It doesn't have to be fancy, just something David or I can use as staring p=
oint.

Thanks,
//richard


Return-Path: <linux-kernel+bounces-80319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C56862D5D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 23:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 811F3B20F40
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6181BC31;
	Sun, 25 Feb 2024 22:13:01 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C44D1B959;
	Sun, 25 Feb 2024 22:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708899181; cv=none; b=ZtkDHX+KVC4Gknr9sD5+V6nnk96c4/cmKtBXMZIynd8zBdVWdG0A9SLBgFINumBKK9JRiOHK/9v9y3+nVAyQkf/2IcRWhAB5/lW3448MNBGSMuvKb7NKgl2NPncgRCfDk2TCyGhhvzIXe52MeQhYGf+h/QPrKuHJZ3gNzBLOnwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708899181; c=relaxed/simple;
	bh=R3PowNmV6z7V5+4rKOYfRZaysNd/F1B+PjegZMDewpo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=tRGSyCM0JSzhMpXG+o5D8ZAM0jbg5cXhmCH0mRCZErJAqLRGHf7rJLHSdfjhQTWB/+d9XvxqsECw9c9U1Wr7eDS7Ar0Wqbr0DL1WZDHIsN/kYyYVf2DgxJHdZYts2SW/MwAXZKjFk3++m2Ef3UQT0SsuEFcucrUoGIF6jGoTm+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 7FFD36342D4C;
	Sun, 25 Feb 2024 23:12:55 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id ZLfvZ-sQLlLK; Sun, 25 Feb 2024 23:12:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id A73D46340E18;
	Sun, 25 Feb 2024 23:12:54 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DkOwGdRYt7b1; Sun, 25 Feb 2024 23:12:54 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 7DB686343B4B;
	Sun, 25 Feb 2024 23:12:54 +0100 (CET)
Date: Sun, 25 Feb 2024 23:12:54 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Daniel Golle <daniel@makrotopia.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1209094181.98490.1708899174329.JavaMail.zimbra@nod.at>
In-Reply-To: <20240219120156.383a1427@xps-13>
References: <cover.1702952891.git.daniel@makrotopia.org> <82ceb13954f7e701bf47c112333e7b15a57fc360.1702952891.git.daniel@makrotopia.org> <20240219120156.383a1427@xps-13>
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
Thread-Index: LhVCT6G++U013VIiCZmvxnpZEu2GqQ==

----- Urspr=C3=BCngliche Mail -----
> Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
> An: "Daniel Golle" <daniel@makrotopia.org>
> CC: "richard" <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>, =
"Rob Herring" <robh+dt@kernel.org>, "Krzysztof
> Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@=
kernel.org>, "linux-mtd"
> <linux-mtd@lists.infradead.org>, "devicetree" <devicetree@vger.kernel.org=
>, "linux-kernel"
> <linux-kernel@vger.kernel.org>
> Gesendet: Montag, 19. Februar 2024 12:01:56
> Betreff: Re: [PATCH v7 7/7] mtd: ubi: provide NVMEM layer over UBI volume=
s

> Hi Daniel,
>=20
> daniel@makrotopia.org wrote on Tue, 19 Dec 2023 02:33:48 +0000:
>=20
>> In an ideal world we would like UBI to be used where ever possible on a
>> NAND chip. And with UBI support in ARM Trusted Firmware and U-Boot it
>> is possible to achieve an (almost-)all-UBI flash layout. Hence the need
>> for a way to also use UBI volumes to store board-level constants, such
>> as MAC addresses and calibration data of wireless interfaces.
>>=20
>> Add UBI volume NVMEM driver module exposing UBI volumes as NVMEM
>> providers. Allow UBI devices to have a "volumes" firmware subnode with
>> volumes which may be compatible with "nvmem-cells".
>> Access to UBI volumes via the NVMEM interface at this point is
>> read-only, and it is slow, opening and closing the UBI volume for each
>> access due to limitations of the NVMEM provider API.
>=20
> I don't feel qualified enough to review the other patches, however this
> one looks good to me.

Finally(!), I had enough time to look.
Thanks for addressing all my comments form the previous series.
Patches applied.

I have only one tiny request, can you share the lockdep spalt
you encountered in ubi_notify_add() regarding mtd_table_mutex
and ubi_devices_mutex? The solutions looks okay to me, but
if you have more details that would be great.

Thanks,
//richard


Return-Path: <linux-kernel+bounces-80364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C3186675F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 01:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4DC1F21464
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 00:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163AB613D;
	Mon, 26 Feb 2024 00:34:17 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278B6DDA9;
	Mon, 26 Feb 2024 00:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708907656; cv=none; b=YkZ9bGrqqEjwTOrNrmBwO/7/Isn1TApKYVtxbopIFzcqdXybn8ObrSZ7aYPlw8VjDyelfKg3YlP9sgiDg4mOQj9DIESBmxEoxHxH2ttabObSZlgNk9KmToxZHsEJ5ejGvVBSPr+XN0uFiXh/YtlofZlNnlmo6YGdjbN+CGrxqxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708907656; c=relaxed/simple;
	bh=54BOPxkMLzdRKYevCC6yKEk91ZN6DktUcQnOZ91yBos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOFdPv8dz1FTIAiHEO44iNnX/8l8Tm+bE7RsHSeyG+l8fD/ol59zmvNza/mEO3SN5Y+JpODIKa8wDTvqfdBbbI5UwiuKM/LVRDthe2yDlZxwTDzW+Uyb75w6TyY48++r8MKisPnPuc9gW63xd7FgJetzL7kOvMaKXpEEgd/7+7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1reOVA-0001je-1q;
	Mon, 26 Feb 2024 00:05:48 +0000
Date: Mon, 26 Feb 2024 00:05:40 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Richard Weinberger <richard@nod.at>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-mtd <linux-mtd@lists.infradead.org>,
	devicetree <devicetree@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 7/7] mtd: ubi: provide NVMEM layer over UBI volumes
Message-ID: <ZdvV1KABu_UCSL7B@makrotopia.org>
References: <cover.1702952891.git.daniel@makrotopia.org>
 <82ceb13954f7e701bf47c112333e7b15a57fc360.1702952891.git.daniel@makrotopia.org>
 <20240219120156.383a1427@xps-13>
 <1209094181.98490.1708899174329.JavaMail.zimbra@nod.at>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1209094181.98490.1708899174329.JavaMail.zimbra@nod.at>

Hi Richard,

On Sun, Feb 25, 2024 at 11:12:54PM +0100, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
> > Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
> > An: "Daniel Golle" <daniel@makrotopia.org>
> > CC: "richard" <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof
> > Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>, "linux-mtd"
> > <linux-mtd@lists.infradead.org>, "devicetree" <devicetree@vger.kernel.org>, "linux-kernel"
> > <linux-kernel@vger.kernel.org>
> > Gesendet: Montag, 19. Februar 2024 12:01:56
> > Betreff: Re: [PATCH v7 7/7] mtd: ubi: provide NVMEM layer over UBI volumes
> 
> > Hi Daniel,
> > 
> > daniel@makrotopia.org wrote on Tue, 19 Dec 2023 02:33:48 +0000:
> > 
> >> In an ideal world we would like UBI to be used where ever possible on a
> >> NAND chip. And with UBI support in ARM Trusted Firmware and U-Boot it
> >> is possible to achieve an (almost-)all-UBI flash layout. Hence the need
> >> for a way to also use UBI volumes to store board-level constants, such
> >> as MAC addresses and calibration data of wireless interfaces.
> >> 
> >> Add UBI volume NVMEM driver module exposing UBI volumes as NVMEM
> >> providers. Allow UBI devices to have a "volumes" firmware subnode with
> >> volumes which may be compatible with "nvmem-cells".
> >> Access to UBI volumes via the NVMEM interface at this point is
> >> read-only, and it is slow, opening and closing the UBI volume for each
> >> access due to limitations of the NVMEM provider API.
> > 
> > I don't feel qualified enough to review the other patches, however this
> > one looks good to me.
> 
> Finally(!), I had enough time to look.
> Thanks for addressing all my comments form the previous series.
> Patches applied.

It's an enourmous coicident that you are writing just now that I found
a sizeof(int)-related problem which triggers a compiler warning when
building the UBI NVMEM provider on 32-bit platforms. I was just about
to prepare an updated series. Literally in this minute.
Should I still send the whole updates series or only the final patch
(as the necessary change is there) or a follow-up patch fixing the
original patch?

> 
> I have only one tiny request, can you share the lockdep spalt
> you encountered in ubi_notify_add() regarding mtd_table_mutex
> and ubi_devices_mutex? The solutions looks okay to me, but
> if you have more details that would be great.

I will setup a test build to reproduce the original warning and
let you know shortly.


Cheers


Daniel


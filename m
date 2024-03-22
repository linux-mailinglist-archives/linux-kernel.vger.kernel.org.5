Return-Path: <linux-kernel+bounces-111734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5955887016
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A462E1C22877
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBFD56448;
	Fri, 22 Mar 2024 15:57:24 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B315653811;
	Fri, 22 Mar 2024 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123043; cv=none; b=GNA6/b6N0QDxYP3wK0TmtvHbes+CzJ7D5nyR3QJCzvzjwLVaIZsfsuyjNHnrXrrDQ6uWKCa2sXYKvLrj9aFLs3+5wjV3UWwvYlZEaYeynUZvuIT58icTRzaDdCLPjNdBC3n+Tn3kgWAnUnbNHP4E5SjkM5rrcNi9/TG6HOifgGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123043; c=relaxed/simple;
	bh=g8t//AI7C/xXEKlaVarUSs1GgQOPycd3Pj2sIFog6vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXISWou+/Z2fGTLQrWvzD9YUjVGi284eGUQ9FmKAHV2i++cFfmxjQbzV/POJKBivw2OzahYwFk4DuhQBB3CRZf9wZLNIDa5vPGkEwf1tRMZyD600KtYoflTN5BiRmMrfHUrhnvRsGHuN3QE5Jd6Z9MFLxGP7gOPwCdVBa/qtTkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rnhGL-000542-0p;
	Fri, 22 Mar 2024 15:56:57 +0000
Date: Fri, 22 Mar 2024 15:56:49 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Richard Weinberger <richard@nod.at>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-mtd <linux-mtd@lists.infradead.org>,
	devicetree <devicetree@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	david oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: Re: [PATCH v7 7/7] mtd: ubi: provide NVMEM layer over UBI volumes
Message-ID: <Zf2qQSRWYDzKd4--@makrotopia.org>
References: <cover.1702952891.git.daniel@makrotopia.org>
 <82ceb13954f7e701bf47c112333e7b15a57fc360.1702952891.git.daniel@makrotopia.org>
 <20240219120156.383a1427@xps-13>
 <1209094181.98490.1708899174329.JavaMail.zimbra@nod.at>
 <ZdvV1KABu_UCSL7B@makrotopia.org>
 <1754825522.38834.1710105437883.JavaMail.zimbra@nod.at>
 <Ze5uUyUuEDBM3p43@makrotopia.org>
 <1196553263.78350.1710887478387.JavaMail.zimbra@nod.at>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1196553263.78350.1710887478387.JavaMail.zimbra@nod.at>

On Tue, Mar 19, 2024 at 11:31:18PM +0100, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
> > Von: "Daniel Golle" <daniel@makrotopia.org>
> >> BTW: Is there a nice way to test this with nandsim in qemu?
> >> I'd love being able to test all ubi attach code paths on my test setup.
> > 
> > From what I can tell 'nandsim' doesn't have a way to be defined in
> > Device Tree, making it unsuitable to test the attachment of UBI in
> > this way.
> > 
> > However, QEMU does support emulating TI OMAP's OneNAND controller, eg.
> > as part of the Nokia N810 hardware supported by qemu-system-arm, see
> > 
> > https://www.qemu.org/docs/master/system/arm/nseries.html
> > 
> > So we could use that and modify the device tree in Linux to have a MTD
> > partition for UBI and 'compatible = "linux,ubi";' set therein:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/ti/omap/omap2420-n8x0-common.dtsi#n84
> > 
> > If you like I can prepare such a test setup.
> 
> This would be great!
> 
> > Is there a repository for MTD/UBI tests to be run on QEMU which I should
> > contribute this to?
> 
> UBI tests reside in the mtd-utils repository.
> http://git.infradead.org/?p=mtd-utils.git;a=tree;f=tests/ubi-tests;h=20fd6a043eeb96a81736dd07885f74e4e0bb0cc0;hb=HEAD
> 
> Maybe you can provide a small shell script which configures qemu?
> It doesn't have to be fancy, just something David or I can use as staring point.

I'm working on it but it turns out to be a bit more difficult than I
thought it would be, because

 * the only devices with NAND flash emulated in QEMU or Nokia N800 and
   N810 as well as some even more ancient Intel PXA270 based PDA like
   the Sharp 'spitz'.

 * QEMU support for the N800 and N810 has apparently been bitrotting and
   is broken at least since 2019, nobody seems to care much.

 * The spitz predates device tree and hence is unsuitable for testing
   attachment of UBI via DT. But it at least boots because Guenter Roeck
   makes sure it does[1].

I was about to create a spitz-like imaginary board with DT, but also that
doesn't seem to be completely trivial.

So: hold my beer, I'll be back shortly ;)

If anyone has better ideas on how to utilize support for raw NAND or the
OneNAND controller in QEMU in a device-tree environment which actually
works, that'd be great. Obviously I don't care about other peripherals
like Bluetooth and all the complicated stuff of the N80x...

[1]: https://github.com/groeck/linux-build-test/blob/master/rootfs/arm/run-qemu-arm.sh#L64


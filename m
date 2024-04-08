Return-Path: <linux-kernel+bounces-135224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF6089BD01
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505581C216C1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31006535D5;
	Mon,  8 Apr 2024 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DxKZrt9N"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BF452F82;
	Mon,  8 Apr 2024 10:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571926; cv=none; b=iOx1LnJ6DJdK/CG1INlP8W46RmOh8L3f5B3tOGPNtjgHESGMONTLp/yAgLf9Jv6XDbteGObMKqdfw9tlmPLf+dTx06Ji0QZgvtd5ErHzDLTZNyEXO6VUNPcIpdYduQaM75JzrvFxyuNeNMFKgFmcCoeS7oz1k7206H5qkEXIAhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571926; c=relaxed/simple;
	bh=Uab3bx1gPT1snh2DM+Z6/uoVdtZfkeKrMGCstkzKNg4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bqUg93jGi+lKhxxGZSMLUAlaYV1RqJUQ1f5T1YrUvzYoIxjbW+6nrexyvcFxSo7MzRuSumXAIF9cd6zHgsKad6boz8BDmoQ4Cfx7zM0S1EkdQon/BDhe50ca+wCRd7A8Df0vPL4nYue1Ssjm1F2OZ919rnvIBBfYPdm9QSp/Ivk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DxKZrt9N; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712571925; x=1744107925;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Uab3bx1gPT1snh2DM+Z6/uoVdtZfkeKrMGCstkzKNg4=;
  b=DxKZrt9Nfx16EtmeJGjMfgBeE3Txv16oTFKRiRfxCA9hipqGxFQ8xjX8
   VdZtU0PNidmhz4GZlC3wb1MTo+e2vYSMNEKqLoL7H31T5/8TXbto5G32x
   3nuD7BJdF1ilzj6tyVHwSNHR7msmh3FMlyaszs3jo5sP451378FoHhuim
   JfRwqig2a4dwwQ4ldJocUWjXFYjAvipZy3hVDupst82l01XgRdhkMkDKi
   SrBIOz5vOqhFBiIOCoPNEMoK7Jh0buxxdO4pNfprG/KCzvhKMmI5VOeEl
   H8mom4vRPdjzulhOnJa64KBHly+NetYNaWBBWzIlh6U3SbTYmG9ile/m+
   A==;
X-CSE-ConnectionGUID: PSVEW6BEQE6j4yxM2rby/g==
X-CSE-MsgGUID: 54BbDBOaTcK+It8TG/EsnA==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="25339562"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="25339562"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 03:25:23 -0700
X-CSE-ConnectionGUID: YMR2HhP6Q26/wPEV7++T9Q==
X-CSE-MsgGUID: sgrfuxHKQRCBUX2qENLqWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="24312238"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.28])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 03:25:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 8 Apr 2024 13:25:15 +0300 (EEST)
To: Arnd Bergmann <arnd@kernel.org>
cc: Niklas Schnelle <schnelle@linux.ibm.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Heiko Carstens <hca@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
In-Reply-To: <80c20c7b-4e7a-43af-8b59-7f2a98272e99@app.fastmail.com>
Message-ID: <e4299a49-eeef-da89-2806-377d62b417e2@linux.intel.com>
References: <20240405152924.252598-1-schnelle@linux.ibm.com> <20240405152924.252598-2-schnelle@linux.ibm.com> <1a14ac6e-30e9-048e-50cc-c1c3aacc2118@linux.intel.com> <80c20c7b-4e7a-43af-8b59-7f2a98272e99@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-171181184-1712571915=:1249"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-171181184-1712571915=:1249
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 8 Apr 2024, Arnd Bergmann wrote:

> On Mon, Apr 8, 2024, at 11:54, Ilpo J=C3=A4rvinen wrote:
> > On Fri, 5 Apr 2024, Niklas Schnelle wrote:
>=20
> >>  config SERIAL_8250_CS
> >>  =09tristate "8250/16550 PCMCIA device support"
> >> -=09depends on PCMCIA && SERIAL_8250
> >> +=09depends on PCMCIA && SERIAL_8250 && HAS_IOPORT
> >>  =09help
> >>  =09  Say Y here to enable support for 16-bit PCMCIA serial devices,
> >>  =09  including serial port cards, modems, and the modem functions of
> >
> > What about drivers that use SERIAL8250_PORT()?
>=20
> It probably makes sense to hide these, since they won't ever
> work. I probably missed them in my initial series because they
> don't cause a compile-time error, but I agree that there is no
> use in showing the options here.
>=20
> > Also port provided in 8250_PNP might expect it I think.
>=20
> I don't think these need any change: 8250_pnp.c supports
> both IORESOURCE_IO and IORESOURCE_MEM based ports. It will
> still create a 8250 port for the I/O based ones but they
> will now correctly fail to probe in the main driver rather
> than crashing the kernel. PNP devices that only use
> memory BARs will keep working as before, on both machines
> with and without CONFIG_HAS_IOPORT.
>=20
> I think that most 8250_pnp variants are probably used only
> with ISAPNP or PNPBIOS, neither of which exists without
> HAS_IOPORT,

Okay, seems fine then if that dependency is handled somewhere.

--=20
 i.

> but you could certainly have PNPACPI on arm
> or riscv machines that don't have port I/O but come with
> a memory-mapped 8250 port described by firmware.

--8323328-171181184-1712571915=:1249--


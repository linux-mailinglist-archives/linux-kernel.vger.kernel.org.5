Return-Path: <linux-kernel+bounces-166653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 961958B9D9C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23915287194
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4D615B567;
	Thu,  2 May 2024 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="hNraKQzQ"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C7D5103D;
	Thu,  2 May 2024 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714664181; cv=none; b=SS+GbXuYjB3qmDEhhrpXgOgZ40UDlZ9sbiB4COICzD5ZeTI8TtcZ8k7ZJnh/6+A265TGwFKIgG2s3seF0Lhsy0rnzR/gZFJBavI+GYRhvwj2dWODngKMzt3HgEXlX1H+WfpP+Rj22UoBbYhPLDKQmJ1wAbP9xu1RTXWZ3i2Vnvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714664181; c=relaxed/simple;
	bh=pynW+jXzeH7NsB+O42ERsKQuANfOkFi1iL6uf8ALyaI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bNtLMg7u1N8bIp60shpEob0Zs02PWiJBXBbJsRLChPhB0SDj8f76Gr2+9hte05zQpcXy/5aSyMLeP0aJ0y7HkmTMvcymfBk1EpvPeP9JfUisTH9+Bcb7j/idva1R23MEbnE8f1S7r9wWCipi6zYnq9apC6ubZiHPrp/hXKgtg4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=hNraKQzQ; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1714664172; x=1715268972; i=parker@finest.io;
	bh=W0LitNlEcqi8JRY/15+qeV+pHGz20lY39zLVjASVSzA=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hNraKQzQzfg9hwK4XywSR3UPzf5WnW7ygFNsKSmNe8uEhT5HFv0+1rMQFB/mG10F
	 Yr4duYhL5IWuTg2WDnjr72S4bAjPHSwOKpPkR4rPNVgO+QAz79F5dKYwy4PKcRVyN
	 MMpnDtbNalcOl7KjUU6wIYLGVRHZ/adpqSsvlQ+B9iypOxSz0efqfQ+x/kuuBaAXF
	 607B4puDO8SfzdsU3hHMlkuW+cVzBsrz0neVotRXoGNuWUQDzW6PMGLUXI/ucvCI5
	 dXRcEyaYKS/sPdpopm7cb4Odo7kVY+sF9dP5nMQ1DquV1oSlNvYika1h4qTIYzVg5
	 dsvhbWQPJ2uxuO4IXA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0Lr0QH-1sWN7n1xJL-00cd3U; Thu, 02 May 2024 17:36:12 +0200
Date: Thu, 2 May 2024 11:36:10 -0400
From: Parker Newman <parker@finest.io>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Parker Newman <pnewman@connecttech.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 03/13] serial: 8250_exar: Kill CTI_PCI_DEVICE()
Message-ID: <20240502113610.01881f3b@SWDEV2.connecttech.local>
In-Reply-To: <ZjOxQWc1OtGWatKC@smile.fi.intel.com>
References: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
	<20240502144626.2716994-4-andriy.shevchenko@linux.intel.com>
	<20240502111314.63d66b54@SWDEV2.connecttech.local>
	<ZjOxQWc1OtGWatKC@smile.fi.intel.com>
Organization: Connect Tech Inc.
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rW8qwN/6FTe7Q3pgYRWho80xuLlutrj0X5GUe8euHWDFknsFnTO
 gCm0rgz+y7PM1ORFFnshHVrBppMZw0/C4roH4W3/w5YT2xE/J+nyu+a9oqk99Nkgn45pSMQ
 1/922dnKLfy0aT0RzsR0kqcJG6NI9VgmwHcYY3dk9zOjRCjGpKaDTvd5msR2Tpl1sU77FdO
 7FdyM1s1q6494yytAGb9w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:V42GeMkZp+U=;g/7zFTFhk+E+9KwKYQBi1S+4mzp
 J5JD3EqF1HW234Ux9zR3huPG3BwknTMczlp8C5f3jVpoxLGuM5H7rjVWNubYzb1gk4YRGLOCo
 lfmgQmx3KiJXNhT0/EsIQVm5zuylrtMIS+cvQrWNPMMioIaDY20IyDwfDY6N3dx0nEeFRM9VQ
 wGdpkL1cxu0KLxf1Sbi5fjg2KRRZMEskBSkCuxYSGU2M0c/2mbN+Ss6T4BVPSk/aB1lpbk/2I
 dIRoOdvLSQVbTDTyIRG1Ivp/hfnuI6ZUWqrPZLKzk+2dL8nQwa/B+QHi8i966sRoHUHSCOG/J
 AJC8uZ68mbV+hqXXrhEsyVNtN5kfjMbmUhFOkSAESuPG3IiRpYvht3omMIWgGE5j7F41D+Fhc
 tjSdk0N4hjPaM2c7Q6tMfwDWKNj5prRzyC/U5qAO4GaQQOlNNHVpFJbZ6NDnF495RA6QBDGS4
 i4IOdO2ikylhHAWwgPUDZo76GbhZuu5pei6gVKJhms6WQeByJnrZjoURWLB7cYHsh6WFrNPZU
 RB9m9KVwtH5iUwjYC6k6gGuD47HClLy+wNp74MLxw9MjlodiyM9DI7Ep5o9MFqb35WMOmkeP1
 NUwXh8qzQopgGzcI3DwdLGIuWcVj02XJ159v7ArpB3R7SUJcTGEmZ7y6EA5e0bbIhQR0hPIEv
 Ads0xAhD+lZQ7xPcStyD+NhQUtYU3B6euvp4wEL9ocef6VYRMcVrphYdJ19popiOQNjPe3tNX
 N5aCdnqik9Co9BqXlhUA0B89oz31U6mSq+rS6QQ+2OPAk8Fx4W8JJc=

On Thu, 2 May 2024 18:29:05 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, May 02, 2024 at 11:13:14AM -0400, Parker Newman wrote:
> > On Thu,  2 May 2024 17:43:57 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > > The CTI_PCI_DEVICE() duplicates EXAR_DEVICE(). Kill the former.
>
> ...
>
> > > -// For Connect Tech cards with Connect Tech vendor/device PCI IDs (=
FPGA based)
> > > -#define CTI_PCI_DEVICE(devid, bd) {                     \
> > > -	PCI_DEVICE_SUB(                                 \
> > > -		PCI_VENDOR_ID_CONNECT_TECH,             \
> > > -		PCI_DEVICE_ID_CONNECT_TECH_PCI_##devid, \
>
>
> #define PCI_DEVICE_SUB(vend, dev, subvend, subdev) \
>         .vendor =3D (vend), .device =3D (dev), \
>         .subvendor =3D (subvend), .subdevice =3D (subdev)
>
> #define PCI_DEVICE_DATA(vend, dev, data) \
>         .vendor =3D PCI_VENDOR_ID_##vend, .device =3D PCI_DEVICE_ID_##ve=
nd##_##dev, \
>         .subvendor =3D PCI_ANY_ID, .subdevice =3D PCI_ANY_ID, 0, 0, \
>         .driver_data =3D (kernel_ulong_t)(data)
>
>
> > > -		PCI_ANY_ID,                             \
> > > -		PCI_ANY_ID), 0, 0,                      \
> > > -		(kernel_ulong_t)&bd                     \
> > > -	}
> > > -
> > >  #define EXAR_DEVICE(vend, devid, bd) { PCI_DEVICE_DATA(vend, devid,=
 &bd) }
>
> > This is not correct. The CTI_PCI_DEVICE() macro is for cards that have=
 the
> > Connect Tech PCI Vendor ID (not Sub-Vendor ID). EXAR_DEVICE() is for c=
ards with
> > Exar PCI Vendor ID.
>
> Above I added current code of these macros, can you elaborate how it's i=
ncorrect?
>

Sorry, you are correct. I was mixed up.
Thanks,
Parker


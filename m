Return-Path: <linux-kernel+bounces-166638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFDB8B9D60
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F276B1C214D3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E2915B125;
	Thu,  2 May 2024 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="zBon1hg4"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B561598E9;
	Thu,  2 May 2024 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714663609; cv=none; b=Phwj7PmMQaJj8yB2r2FB3/gHYNgI0+Iq14fvHuJk96pNr0ItHYj9OqMC+LrBwNSmrUpcy7ACBlVJWVc2rAvCD/RGKSzyEyLQyd8w2AqsevcscDC/8dH7s4QtSQRP5vc6rp/XwB31M3CVaQcQr7ersfsFNvzW2xeWboi0nW+GAX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714663609; c=relaxed/simple;
	bh=mE5/RlENTW0brlPOOMw/MSYaBxBXYrv8dh9dZKsKnCw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tdXnCFKcczVEtnwoPK0Wo8vAsgOAnnivsAa+jjCwdUcN9NQAjfHyhQjfFcW/pLWEHatMq1VTeEmGTyDfXEjEKo8O3CXtQbFGOQSQ/q04vzRptPcw6VuDZdUCF8IWoQQKm2QS5Qramw+mvcsTt92ZJ5ttIr3SIKn30M41pdskjLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=zBon1hg4; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1714663604; x=1715268404; i=parker@finest.io;
	bh=Xdn6Lap92TRzjIdv/bV1bZFq6oj9fxDr1Ng84N8c8dg=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=zBon1hg4NcQNzSRfCxpPEuY21lKJjOoYcVUkLTXtQWBfXIZ1p1yTrmPm+8Uhdo+z
	 Xq7yJUgTUOajD7cYe2xfvzLRwqMkV3usFNbrRuKeRuLU7zbuxzmtriIQsndX801YR
	 TtoD03zBKw9AfLNtXKgykY9AkmRI0w1t+mDv9er4YETnEsdoJabyIcQC9rlg2N12K
	 iJ1RsP/jnl2Xi2x3abj3wJr9hEN/YZzptleRkPMwiK5VXnbCq8UVW3HlXi1oUcyIH
	 Hi2xZHrwewoMkjhJ44UDsh8aCr1INYt4WlTX6E/zmZoW1NXewgsoDMGNLpiwy5dZR
	 wbxv+AUzsCaGtlVulQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1MTAup-1sDqXz0e3L-00UWRW; Thu, 02 May 2024 17:13:16 +0200
Date: Thu, 2 May 2024 11:13:14 -0400
From: Parker Newman <parker@finest.io>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Parker Newman <pnewman@connecttech.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 03/13] serial: 8250_exar: Kill CTI_PCI_DEVICE()
Message-ID: <20240502111314.63d66b54@SWDEV2.connecttech.local>
In-Reply-To: <20240502144626.2716994-4-andriy.shevchenko@linux.intel.com>
References: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
	<20240502144626.2716994-4-andriy.shevchenko@linux.intel.com>
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
X-Provags-ID: V03:K1:aYTPzpuKTAky+KwX9aJTIWey6lWeDhLhNW+akQD3uatwCpcmWyN
 FRniZhDuLe//hy/nXndYTnXbPnqsK4JgijurtsazDWo0525+dqLD60dXZ+ZUoS3pLMiF0F1
 SuzJZ55B+Y0hz0rNP+JDLNzfygc0x0m/sXNR9r4HntKLwtwWF4Jeg5aEld/ZbyF8gsINnPb
 0FHL8S6Dg+p/f1KKf8ktQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tBVLFZH2foQ=;j0Zh0tu/j0MEz628iIGs21qF6e/
 3eikaKo1QEiCGEceoviTxIaX7O38N7N9k2GpQN8LdVvJoiZJLeV28PO/LTmSYrmuLfgWJrdhg
 3J7cxoFVXep4KTYexq7LW0sp/IbS1PxPYCb4LmJwU57sQb5OHiQunD6/5IeB8hegTBf4qfrMy
 mwtIAFpyda6Q+5pH9o7ohUC4pu3M8oNdnMFa82wHeVzprF9chRJYCxcrn/RXG64Dup4cbLefs
 SyHqyz1x4b3s7enIhtnStvWDJkAFnHYb5MuZeiMPKu/95eTj7laSOtzWJ6/KchB4uzwuDwt51
 umj5rXmA48HPza4prbDKyMhHoCH4dJm4vYCF0AgV1zVvV1MeWyiDngLW7euiLl0wHCdMrKGC8
 TybFW5XqsgQrz4JcSECaQCsAvoNTotkdZkTJ/lPvEtdp50eZz9FZ/SXiss7q41tTYBQfMYL8y
 4tnrq1iSyP7myny4nKKZxFHZHjFOTmeev5HG/K3Df9s6W07jpImpGrWdBLKIxLI65E95iba78
 JDdLN56LG4GyU33s1mjXSM6fL9MpZarcAg/Go1A8UgtmdwPCo7UaDIWgMKN7wknbduGu9iJAf
 GJicgGgUhiW12tSpxLiC+aAa+tlRISe50cwgvUy87iyFHL5yhEvXbxvXq+0wqeIEoWPeM6fc+
 1rKTXdt/oK317SJvdzpr2ChLuHnRgnUN2eaZTGJ9zEdxK54pE7L9poM7EusZ1wpawmfrlh9Uw
 HQhvLsqxtejMcHIPUJJu5dBBBjw1I73FnaPfgJJqzcUDRcw+FDH0zI=

On Thu,  2 May 2024 17:43:57 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> The CTI_PCI_DEVICE() duplicates EXAR_DEVICE(). Kill the former.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_exar.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/82=
50/8250_exar.c
> index 150c4abd92fc..ab0abc14ecf8 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -1737,7 +1737,6 @@ static const struct exar8250_board pbn_exar_XR17V8=
358 =3D {
>  	.exit		=3D pci_xr17v35x_exit,
>  };
>
> -// For Connect Tech cards with Exar vendor/device PCI IDs
>  #define CTI_EXAR_DEVICE(devid, bd) {                    \
>  	PCI_DEVICE_SUB(                                 \
>  		PCI_VENDOR_ID_EXAR,                     \
> @@ -1747,16 +1746,6 @@ static const struct exar8250_board pbn_exar_XR17V=
8358 =3D {
>  		(kernel_ulong_t)&bd                     \
>  	}
>
> -// For Connect Tech cards with Connect Tech vendor/device PCI IDs (FPGA=
 based)
> -#define CTI_PCI_DEVICE(devid, bd) {                     \
> -	PCI_DEVICE_SUB(                                 \
> -		PCI_VENDOR_ID_CONNECT_TECH,             \
> -		PCI_DEVICE_ID_CONNECT_TECH_PCI_##devid, \
> -		PCI_ANY_ID,                             \
> -		PCI_ANY_ID), 0, 0,                      \
> -		(kernel_ulong_t)&bd                     \
> -	}
> -
>  #define EXAR_DEVICE(vend, devid, bd) { PCI_DEVICE_DATA(vend, devid, &bd=
) }
>
This is not correct. The CTI_PCI_DEVICE() macro is for cards that have the
Connect Tech PCI Vendor ID (not Sub-Vendor ID). EXAR_DEVICE() is for cards=
 with
Exar PCI Vendor ID.

Thanks,
Parker

>  #define IBM_DEVICE(devid, sdevid, bd) {			\
> @@ -1786,6 +1775,7 @@ static const struct pci_device_id exar_pci_tbl[] =
=3D {
>  	EXAR_DEVICE(ACCESSIO, COM_4SM, pbn_exar_XR17C15x),
>  	EXAR_DEVICE(ACCESSIO, COM_8SM, pbn_exar_XR17C15x),
>
> +	/* Connect Tech cards with Exar vendor/device PCI IDs */
>  	CTI_EXAR_DEVICE(XR17C152,       pbn_cti_xr17c15x),
>  	CTI_EXAR_DEVICE(XR17C154,       pbn_cti_xr17c15x),
>  	CTI_EXAR_DEVICE(XR17C158,       pbn_cti_xr17c15x),
> @@ -1798,9 +1788,10 @@ static const struct pci_device_id exar_pci_tbl[] =
=3D {
>  	CTI_EXAR_DEVICE(XR17V354,       pbn_cti_xr17v35x),
>  	CTI_EXAR_DEVICE(XR17V358,       pbn_cti_xr17v35x),
>
> -	CTI_PCI_DEVICE(XR79X_12_XIG00X, pbn_cti_fpga),
> -	CTI_PCI_DEVICE(XR79X_12_XIG01X, pbn_cti_fpga),
> -	CTI_PCI_DEVICE(XR79X_16,        pbn_cti_fpga),
> +	/* Connect Tech cards with Connect Tech vendor/device PCI IDs (FPGA ba=
sed) */
> +	EXAR_DEVICE(CONNECT_TECH, PCI_XR79X_12_XIG00X, pbn_cti_fpga),
> +	EXAR_DEVICE(CONNECT_TECH, PCI_XR79X_12_XIG01X, pbn_cti_fpga),
> +	EXAR_DEVICE(CONNECT_TECH, PCI_XR79X_16,        pbn_cti_fpga),
>
>  	IBM_DEVICE(XR17C152, SATURN_SERIAL_ONE_PORT, pbn_exar_ibm_saturn),
>



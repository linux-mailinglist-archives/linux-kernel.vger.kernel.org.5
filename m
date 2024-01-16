Return-Path: <linux-kernel+bounces-27668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 797BC82F3E2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07AEAB23C95
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94341CFAD;
	Tue, 16 Jan 2024 18:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ntfNTKq8"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A211CD30
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428882; cv=none; b=bs6bndoz8CL+A6akgEYPhTGjhtPhZzkVY+QL6Q0w6Es71IOUG5nCzPs4VuruE16+iEu83rKpl//nSo2t+ks+Wn67cTS4YQJzafsHRhb/6/lxUF1Sc+Ck9IqUcVzylGsr8bClikn2XvkrGEbBemyYplh8QezoXmFTiBYsFVpOF2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428882; c=relaxed/simple;
	bh=cv59bDCTOqRhiDC3HpONyDpPUeopXrDeTyWmM+8EkOI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=Hgp2bKkdi+woeo/MGG0lj4ZqLjtUZwVLdS502ASidJX6pzmThh/HflM72eQJN3lVqGg2WNRi7X8KOWARzyuuYDV1thEHK6zZOYk+WKS3DJAAU2Gvuh4t9CR51aSWjDbg3ngvG+4CD9FkAz2He+4FCYNheEHbtz4Pz7L0+yF+P0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ntfNTKq8; arc=none smtp.client-ip=209.85.166.53
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7ba903342c2so539628039f.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705428879; x=1706033679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRhLuuiIVVo+A52y6bxPnSkQ+JrLAw3wqr2sWjodaZc=;
        b=ntfNTKq8C4HxrhN7HqHgbmqQXfktwh8hmtgTA5ncDWjXGizdF3GP0fGzClzVcPySY5
         Fr/LPYZkV9MKuT7X9Ho1WvaMWPpxFEqRhWT90Sy7hmG1jl9bMpHMyWnWjyEYvOSSdOWL
         7RsivC3zzWi4FqeKBp1Fbus4EvmmfmE3Ira6cAvx5n03Mi7ocy62RMTCJHCjxRribQ2T
         RcvSJ0PxWvBqmO8FcwuvIr3ttU+VFagMYmrqyEP++o14SO2/yzy3wEuWj1wWkEpVm1EU
         paXan10Buan5kMdpRnQbVihNjLYYRVwsx6+Ihh3oMBg7fP1FX6pVxm41RiGQqlToSr72
         7SNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705428879; x=1706033679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRhLuuiIVVo+A52y6bxPnSkQ+JrLAw3wqr2sWjodaZc=;
        b=JFJzHuYF55D/jJTma+WWdrcjdwp+8+uhvIMRoFQHoHrdzxg4giTUXgAYpjC1K62dCh
         gahPfMbdduMZyrD5+89ifuqRGRNT4wiVElWGihfgkx2hmjiGUKaO53NmOLsFzXhRmslv
         j4WkJvaXydTYicy5EmTka7GTJgIFYj7b9rsvfXQfiARVmwrThStkI/f7+CuLd3mErJt0
         Mo4W+vuMsYeAxhYxtLrfwzybb1558ZgNFuK7nS52aoUXhLzBufjeSoIGcAN4IJSUGZa4
         VEXlcmVqynfWR/Ctu+fIq6sNk5bWo+5kW+Z2d3n7waRDTujJ3FctxNTyEbdxqm8mvR6M
         +SxA==
X-Gm-Message-State: AOJu0Yy5FLqGtwMZqjjslFEL+NJ0R6YqhG8NO6fOezLAQ9GpRAiUXTF3
	7hphDqLd1+6nQsw2XJ07lULre5W63G0AKHsoNAs9RAPCDBaDXQ==
X-Google-Smtp-Source: AGHT+IEfZdEKTVV73IlpY3EGlS1kPKh3DImT91Va7UPo6ctMhZS1jwa3ClSyV/+ZVIEwxJrtZw8TuE8UvHu/GnDXkQ4=
X-Received: by 2002:a05:6602:3054:b0:7be:d30c:d170 with SMTP id
 p20-20020a056602305400b007bed30cd170mr8728680ioy.34.1705428879752; Tue, 16
 Jan 2024 10:14:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110102102.61587-1-tudor.ambarus@linaro.org> <20240110102102.61587-4-tudor.ambarus@linaro.org>
In-Reply-To: <20240110102102.61587-4-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 16 Jan 2024 12:14:28 -0600
Message-ID: <CAPLW+4mY4VUm+cryBDFLp9TFkxG2oqJrmbZVuRuT5bFOzYXrnQ@mail.gmail.com>
Subject: Re: [PATCH 03/18] tty: serial: samsung: add gs101 earlycon support
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com, 
	willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 4:21=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
org> wrote:
>
> The entire bus (PERIC) on which the GS101 serial resides only allows
> 32-bit register accesses. The reg-io-width dt property is disallowed
> for the "google,gs101-uart" compatible and instead the iotype is
> inferred from the compatible. Always set UPIO_MEM32 iotype for the
> gs101 earlycon.
>
> Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/tty/serial/samsung_tty.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index 20ec6ef1a52f..74bc5151dad4 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -2810,6 +2810,17 @@ OF_EARLYCON_DECLARE(exynos4210, "samsung,exynos421=
0-uart",
>  OF_EARLYCON_DECLARE(artpec8, "axis,artpec8-uart",
>                         s5pv210_early_console_setup);
>
> +static int __init gs101_early_console_setup(struct earlycon_device *devi=
ce,
> +                                           const char *opt)
> +{
> +       /* gs101 always expects MMIO32 register accesses. */
> +       device->port.iotype =3D UPIO_MEM32;
> +
> +       return s5pv210_early_console_setup(device, opt);
> +}
> +
> +OF_EARLYCON_DECLARE(gs101, "google,gs101-uart", gs101_early_console_setu=
p);
> +
>  /* Apple S5L */
>  static int __init apple_s5l_early_console_setup(struct earlycon_device *=
device,
>                                                 const char *opt)
> --
> 2.43.0.472.g3155946c3a-goog
>
>


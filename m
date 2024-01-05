Return-Path: <linux-kernel+bounces-18049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7BA8257CF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2013C1F24A7F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5453F2E84B;
	Fri,  5 Jan 2024 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QZx085Dv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C2531758
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6daa89a6452so1142304b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 08:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704471089; x=1705075889; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=30iRbRIp00TA/PfyCKUbGuGBVTofPojplhmzgjq54FM=;
        b=QZx085DvLNwj2q/ziRNvtoV168/7nYfvQNTYS+kvTGz6UNUcQCQWFicBlbAYtFqIf0
         5wWUhmZytNTpEAceTDJFA7d8RYYos3L4kFccuhLpb9QNnkTGp/sdN8UmqVzjr+Y0HOiS
         Gch04zs0Mr7Ux1R9cs2VR6Z/2sph/FnhkzoAisLYZPEYvdHRGtdQUxllaPRpVISrK2Gd
         y5mDk8sh1INLSzCmbPpfyQxy6+eox9vcA8PEdIW0MZPPqRipEiaIh23FJRSW7srGGgLk
         FZN6ZX/REPzQO+hYm61l45Pf21PsavqE/X/vpIDyzCUj35VNSogUS+VMGnpoyQ1BI3C4
         Y4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704471089; x=1705075889;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=30iRbRIp00TA/PfyCKUbGuGBVTofPojplhmzgjq54FM=;
        b=W5Kt2/E+NDRNcIpcQXb5ukyGSFm4yAc6k+WcGKA9aiGbwC4Y6QoipNVoIlezPmvF63
         i9Ef5SCSd+lqml1U60LQvF+eHeLONjzYFJYGBcNkWeYI7RJeUeoclXU3R1Vy2/kYkYwi
         sffyZ2ntyY89KoEYXEgkwrrzopeeJ3KEPUQx08kT2U9XCIPavnvlIaQAvHFX2nyxHl6J
         uwS9q415t4fvmSo68PpgW18FhrHERe5+NK1g2d+CaDG+T7L+cueWy2gy179GYYzLg62d
         NfvkfyBtavOII9AGqKFRoDmLThEG4N2P16BVe8iDoEEQnoGcLAQA0GDGefEyR7jf9D0k
         cLRQ==
X-Gm-Message-State: AOJu0YzWHRhQXY+UxlPq5vr00xf3b3RqiFgAozJNb2u2OLYTLN24sRFJ
	wbLLJlmDI5iXy3YTcDnenCIQZ+QJxVMcgRa1btnvXQaLleQxyw==
X-Google-Smtp-Source: AGHT+IGJn9c7Kdn/fwPYYs/b7yOeH9vWnRE43QOLggPt8eJfLcJAlYwTSQ2DISsY9X7skJDjK0vytVYOrsIlDSNzjUQ=
X-Received: by 2002:a05:6a20:da88:b0:197:3395:a5c9 with SMTP id
 iy8-20020a056a20da8800b001973395a5c9mr2173845pzb.90.1704471089504; Fri, 05
 Jan 2024 08:11:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105055840.1977897-1-lcherian@marvell.com> <20240105055840.1977897-7-lcherian@marvell.com>
In-Reply-To: <20240105055840.1977897-7-lcherian@marvell.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Fri, 5 Jan 2024 16:11:18 +0000
Message-ID: <CAJ9a7VhStuDsNz-BiVe-bW5E91UxQttKTbE4x+M+8NmdEKtAJw@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] coresight: tmc: Stop trace capture on FlIn
To: Linu Cherian <lcherian@marvell.com>
Cc: suzuki.poulose@arm.com, james.clark@arm.com, leo.yan@linaro.org, 
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
	linux-kernel@vger.kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, sgoutham@marvell.com, gcherian@marvell.com
Content-Type: text/plain; charset="UTF-8"

Hi,

On Fri, 5 Jan 2024 at 05:59, Linu Cherian <lcherian@marvell.com> wrote:
>
> Configure TMC ETR and ETF to flush and stop trace capture
> on FlIn event. As a side effect, do manual flush only if
> auto flush fails.
>
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> ---
> Changelog from v5:
> * No changes
>
>  drivers/hwtracing/coresight/coresight-tmc-etf.c | 10 ++++++++--
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 10 ++++++++--
>  drivers/hwtracing/coresight/coresight-tmc.h     |  3 +++
>  3 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index 72c2315f4e23..57a9a9300d36 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -34,7 +34,7 @@ static int __tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
>         writel_relaxed(TMC_MODE_CIRCULAR_BUFFER, drvdata->base + TMC_MODE);
>         writel_relaxed(TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI |
>                        TMC_FFCR_FON_FLIN | TMC_FFCR_FON_TRIG_EVT |
> -                      TMC_FFCR_TRIGON_TRIGIN,
> +                      TMC_FFCR_TRIGON_TRIGIN | TMC_FFCR_STOP_ON_FLUSH,
>                        drvdata->base + TMC_FFCR);
>

This is a problem. Setting TMC_FFCR_STOP_ON_FLUSH changes the
fundamentals of trigger event handling. Without this bit ETM can
generate multiple event  + triggers which are then embedded into the
formatted trace stream for later search.
With this new bit the capture will stop on the first event. Setting
this bit should be dependent on the mode being set to ETR_MODE_RESRV



>         writel_relaxed(drvdata->trigger_cntr, drvdata->base + TMC_TRG);
> @@ -615,7 +615,13 @@ static int tmc_panic_sync_etf(struct coresight_device *csdev)
>         if (val != TMC_MODE_CIRCULAR_BUFFER)
>                 goto out;
>
> -       tmc_flush_and_stop(drvdata);
> +       val = readl(drvdata->base + TMC_FFSR);
> +       /* Do manual flush and stop only if its not auto-stopped */
> +       if (!(val & TMC_FFSR_FT_STOPPED)) {
> +               dev_info(&csdev->dev,
> +                        "%s: Triggering manual flush\n", __func__);
> +               tmc_flush_and_stop(drvdata);
> +       }
>
Is there some reason to believe that the stop on flush will not work?

Using this conditional skips the  tmc_wait_for_tmcready() called by
tmc_flush_and_stop() if the formatter is stopped - which is a
different condition test on a different register.

Why is this block of code not in the patch that introduces the
tmc_panic_sync_etf()

>         /* Sync registers from hardware to metadata region */
>         mdata->sts = csdev_access_relaxed_read32(csa, TMC_STS);
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index ab7521bbb2f5..4b3c7ec7f62b 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1113,7 +1113,7 @@ static int __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
>
>         writel_relaxed(TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI |
>                        TMC_FFCR_FON_FLIN | TMC_FFCR_FON_TRIG_EVT |
> -                      TMC_FFCR_TRIGON_TRIGIN,
> +                      TMC_FFCR_TRIGON_TRIGIN | TMC_FFCR_STOP_ON_FLUSH,
>                        drvdata->base + TMC_FFCR);
>         writel_relaxed(drvdata->trigger_cntr, drvdata->base + TMC_TRG);
>         tmc_enable_hw(drvdata);
> @@ -1846,7 +1846,13 @@ static int tmc_panic_sync_etr(struct coresight_device *csdev)
>         if (!(val & TMC_CTL_CAPT_EN))
>                 goto out;
>
> -       tmc_flush_and_stop(drvdata);
> +       val = readl(drvdata->base + TMC_FFSR);
> +       /* Do manual flush and stop only if its not auto-stopped */
> +       if (!(val & TMC_FFSR_FT_STOPPED)) {
> +               dev_info(&csdev->dev,
> +                        "%s: Triggering manual flush\n", __func__);
> +               tmc_flush_and_stop(drvdata);
> +       }
>

Above comments for etf apply equally to etr.

Regards

Mike

>         /* Sync registers from hardware to metadata region */
>         mdata->size = csdev_access_relaxed_read32(csa, TMC_RSZ);
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index 6e1e910d5ea4..cf9313b302c7 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -77,6 +77,9 @@
>  #define TMC_AXICTL_AXCACHE_OS  (0xf << 2)
>  #define TMC_AXICTL_ARCACHE_OS  (0xf << 16)
>
> +/* TMC_FFSR - 0x300 */
> +#define TMC_FFSR_FT_STOPPED    BIT(1)
> +
>  /* TMC_FFCR - 0x304 */
>  #define TMC_FFCR_FLUSHMAN_BIT  6
>  #define TMC_FFCR_EN_FMT                BIT(0)
> --
> 2.34.1
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK


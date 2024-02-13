Return-Path: <linux-kernel+bounces-63508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1901185308E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA371F25474
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AB23AC0F;
	Tue, 13 Feb 2024 12:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vzeCD31V"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61BA1EB21
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707827627; cv=none; b=jNeiswlWdvkg09YM4hhQNPY01Cys9liuckOo9jWfh5xn02k5HNe40wGUurjo91eOV+/Is9J0eQMDUV0SFHGZ4g3fUETdQMxDyypol7XQ2biyaEQfC2OI3C0qGvxZj/a+hHsHCfzrVbyHxVTuItw6DcKAjkmlZ6hDoFsAg7BziKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707827627; c=relaxed/simple;
	bh=/GJ4QFR4osX4gLa51sIA6o5xnM4aOd/oZc5etiXgL0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iS6cdkHc8DpLevpmMTobBlEG/ezFS3YCe6jN/l5+h2XHD04vkmMpgnLmtaolyriapFklnM1cgiO6DWUK9S6UMdFNiKEG9t20be7zgltqQD3dXmggUL4Wgo6pMZl5QVDaAA3I2eZTyAwFkj4sSs4HGN6lhFNS1nnQQ748d3XObcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vzeCD31V; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-604aaf2d047so43303207b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 04:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707827625; x=1708432425; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qzyv/WoCMge5Duet8jp2D0QmHRULtMDBTqMNs3hbObU=;
        b=vzeCD31VJnMqPvGnxfyM0zjd+q61LdAuyZcOHEXVGOeKUIl6drb/xHuV3rwZSyiIB4
         FlFbbLxFcDHB/nl+iL90KnEBAJxV6pmTSPJGoF5B+1jsCr0n7AskooVRxU7ocwOGY6JS
         aG+eQM+86Ync6V2D2vvwd3gPTW5wm3EtYC5lbrPePHntv3xtve1hO5jG45OPnSaiCjOQ
         jQQEDskoz2OWpuHOB0y7LSo4n5NUOL0fBL/sMzgtFYadX2E3h5t3ugW/pWh6BYo5Ci2V
         l5Cv4948lVddSpvmqk5OmpfDyzFTDvw2GdJnSOEbuaEolwBGynm1Sqomb67Um4vCcME6
         NgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707827625; x=1708432425;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qzyv/WoCMge5Duet8jp2D0QmHRULtMDBTqMNs3hbObU=;
        b=V8TmtMGkcT9qGyLvYeTRzK97iSRAgjVeCFRC3E4rp1Ul9pEVI4wVpvbyJN683ZRqnX
         WmCWlY/yhnJbMnSumlj0DtrpvkNR1Jea1ZRF3a4W2jdDnBulxfPkxGsIAdoXRBtCHNTy
         FRe3s+q1lCYGnAsP273xpaBNR+892yiG2DwbUlkdwkmoeQAu2W1bNqMzShWXagitEqlv
         cBZzA8CxvsIGnFhfNGvm3F60X5RQvmD90GWrEPtC8/eglaqQ2+nQXptP9mOE4RE2XnNd
         hcYSXriIUMTWpgkhNYm9B8NOr2/yKYwOvdzKX6nSYrhdX+ttllKemHNdhlpCmyZzWw8m
         clPg==
X-Forwarded-Encrypted: i=1; AJvYcCVIX6h2XHGpNPSpqDNVo0NraCXfOT8DMBBMobOrqCAkq+U6xzSQGnfV28rtIYoaJbt8QQVzbxwijAcysZNimQgm8pZqvH1yHgmCiaDh
X-Gm-Message-State: AOJu0Yxve0+CMIOzOqFIwgtiOeWQlbkiZj9haImqGMXssbI8A4Rqs028
	y7gidCDaJpyb9cZUZ4/MMYfYlJBcVzaVSoYE43wu6g6nxv4+kFlFQDovRXXdmUCuUXSYI21Jxvt
	OSvn9m9C/kF/9qvgqIiTj3J903L3dfHMjWd5aCQ==
X-Google-Smtp-Source: AGHT+IGFyrrSYwBqPLrMhhh9GDxxlSQDKtyfUqNSima8IgUPgwDz9wnrBRv0W0Jygr+WapDaQ19ac613tdC5Q7dXnTI=
X-Received: by 2002:a05:690c:2f88:b0:607:782e:fdf3 with SMTP id
 ew8-20020a05690c2f8800b00607782efdf3mr2615924ywb.23.1707827624727; Tue, 13
 Feb 2024 04:33:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125191756.868860-1-cristian.marussi@arm.com>
In-Reply-To: <20240125191756.868860-1-cristian.marussi@arm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 13 Feb 2024 13:33:08 +0100
Message-ID: <CAPDyKFq=35C6CdbsXmkVSgJ=JyxjMM70tfcWURGMntf6h_u0eA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: arm: Fix NULL dereference on scmi_perf_domain removal
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jan 2024 at 20:18, Cristian Marussi <cristian.marussi@arm.com> wrote:
>
> On unloading of the scmi_perf_domain module got the below splat, when in
> the DT provided to the system under test the '#power-domain-cells' property
> was missing.
> Indeed, this particular setup causes the probe to bail out early without
> giving any error, so that, then, the removal code is run on unload, but
> without all the expected initialized structures in place.
>
> Add a check and bail out early on remove too.
>
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
> Mem abort info:
>    ESR = 0x0000000096000004
>    EC = 0x25: DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>    FSC = 0x04: level 0 translation fault
>  Data abort info:
>    ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>    CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>  user pgtable: 4k pages, 48-bit VAs, pgdp=00000001076e5000
>  [0000000000000008] pgd=0000000000000000, p4d=0000000000000000
>  Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
>  Modules linked in: scmi_perf_domain(-) scmi_module scmi_core
>  CPU: 0 PID: 231 Comm: rmmod Not tainted 6.7.0-00084-gb4b1f27d3b83-dirty #15
>  Hardware name: linux,dummy-virt (DT)
>  pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
>  pc : scmi_perf_domain_remove+0x28/0x70 [scmi_perf_domain]
>  lr : scmi_perf_domain_remove+0x28/0x70 [scmi_perf_domain]
>  sp : ffff80008393bc10
>  x29: ffff80008393bc10 x28: ffff0000875a8000 x27: 0000000000000000
>  x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
>  x23: ffff00008030c090 x22: ffff00008032d490 x21: ffff80007b287050
>  x20: 0000000000000000 x19: ffff00008032d410 x18: 0000000000000000
>  x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>  x14: 8ba0696d05013a2f x13: 0000000000000000 x12: 0000000000000002
>  x11: 0101010101010101 x10: ffff00008510cff8 x9 : ffff800080a6797c
>  x8 : 0101010101010101 x7 : 7f7f7f7f7f7f7f7f x6 : fefefeff6364626d
>  x5 : 8080808000000000 x4 : 0000000000000020 x3 : 00000000553a3dc1
>  x2 : ffff0000875a8000 x1 : ffff0000875a8000 x0 : ffff800082ffa048
>  Call trace:
>   scmi_perf_domain_remove+0x28/0x70 [scmi_perf_domain]
>   scmi_dev_remove+0x28/0x40 [scmi_core]
>   device_remove+0x54/0x90
>   device_release_driver_internal+0x1dc/0x240
>   driver_detach+0x58/0xa8
>   bus_remove_driver+0x78/0x108
>   driver_unregister+0x38/0x70
>   scmi_driver_unregister+0x28/0x180 [scmi_core]
>   scmi_perf_domain_driver_exit+0x18/0xb78 [scmi_perf_domain]
>   __arm64_sys_delete_module+0x1a8/0x2c0
>   invoke_syscall+0x50/0x128
>   el0_svc_common.constprop.0+0x48/0xf0
>   do_el0_svc+0x24/0x38
>   el0_svc+0x34/0xb8
>   el0t_64_sync_handler+0x100/0x130
>   el0t_64_sync+0x190/0x198
>  Code: a90153f3 f9403c14 f9414800 955f8a05 (b9400a80)
>  ---[ end trace 0000000000000000 ]---
>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Fixes: 2af23ceb8624 ("pmdomain: arm: Add the SCMI performance domain")
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Applied for fixes - and by amending the commit message a bit,
according to suggestions from Sudeep, thanks!

Kind regards
Uffe


> ---
> I suppose the probe does NOT bail out with an error because this DT config has
> to be supported, right ?
> ---
>  drivers/pmdomain/arm/scmi_perf_domain.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/pmdomain/arm/scmi_perf_domain.c b/drivers/pmdomain/arm/scmi_perf_domain.c
> index 709bbc448fad..d7ef46ccd9b8 100644
> --- a/drivers/pmdomain/arm/scmi_perf_domain.c
> +++ b/drivers/pmdomain/arm/scmi_perf_domain.c
> @@ -159,6 +159,9 @@ static void scmi_perf_domain_remove(struct scmi_device *sdev)
>         struct genpd_onecell_data *scmi_pd_data = dev_get_drvdata(dev);
>         int i;
>
> +       if (!scmi_pd_data)
> +               return;
> +
>         of_genpd_del_provider(dev->of_node);
>
>         for (i = 0; i < scmi_pd_data->num_domains; i++)
> --
> 2.43.0
>


Return-Path: <linux-kernel+bounces-15588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A5B822E78
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4A181C23888
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ADE19BB9;
	Wed,  3 Jan 2024 13:34:40 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DCC19BAF;
	Wed,  3 Jan 2024 13:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-59584f41f1eso326532eaf.1;
        Wed, 03 Jan 2024 05:34:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704288877; x=1704893677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9Bgrg98jxZjd7ez0NoKDpKp4vfROtPramNH7zK9BAo=;
        b=FBZHwHrlSGKlbHPEqJwa6HFJE/2fi1qUpFNpmk37DXsBcwpN7xwBkBbhTMH/BN/DXo
         xRU7MjZ1JtpdZ9zMGGcNSTuO9lW+V4o138iwWRSOHRGfVjrcFH+V8dyRqm1Mn4+scog6
         FRDev7Yrfy2yWKyjK0HspFAKZMCPPWnd3LYJIXjR3zi5PZjCmOSqKcenW0r4twgC9G3i
         f1u6de+oTRccNjsdA37iRHeeht+W79vnqFDn22MbUwea6T3HKt+G9cFHq3uZxI7LWauj
         2ZRUEC7pfLdqqkyV8sbqbaJWbqsPzeBGDLQXbAk+/SEVuL+Dcp4wR+yB269Bm6V472p7
         vVfA==
X-Gm-Message-State: AOJu0Yz3uQL+PZuw6pV/dxABkWZrQq4M7bSad4bAWCX5d4m4a5EmUoBp
	GP1xCw+kycB38sVp6bqOq+lcio8a7SofQ/xmXCs=
X-Google-Smtp-Source: AGHT+IFc7Z9XSqU3McTnqXZSCroIcFhuxIocwa0R3cGvcY8mVtOExpCzY65PhNtg5QjA76Hu4F17Zs5ER06so/2z8po=
X-Received: by 2002:a05:6870:9192:b0:204:208c:aa68 with SMTP id
 b18-20020a056870919200b00204208caa68mr30552051oaf.2.1704288877615; Wed, 03
 Jan 2024 05:34:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103041459.11113-1-ricardo.neri-calderon@linux.intel.com> <20240103041459.11113-5-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20240103041459.11113-5-ricardo.neri-calderon@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Jan 2024 14:34:26 +0100
Message-ID: <CAJZ5v0jSERoeMki9ZvWtTqiZidETeo1Xm_Qb0Oo2qRG0PMrSJQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] thermal: intel: hfi: Add a suspend notifier
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, 
	Len Brown <len.brown@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Zhao Liu <zhao1.liu@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The subject should say "add a PM notifier" to indicate that
hibernation is covered too.

On Wed, Jan 3, 2024 at 5:13=E2=80=AFAM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> The kernel gives the HFI hardware a memory region that the latter uses to
> provide updates to the HFI table. The kernel allocates this memory region
> at boot. It remains constant throughout runtime time.
>
> When resuming from suspend or hibernation, the restore kernel allocates a

The restore kernel is only used during resume from hibernation, so
this particular problem is hibernation-specific.

It is possible, at least in principle, that the address of the HFI
table is "lost" by the processor during resume from "deep" suspend
(ACPI S3), in which case it may not survive the firmware-driven part
of the suspend-resume cycle.  It is thus prudent to disable HFI on
suspend and re-enable it on resume for the boot CPU (under the
assumption that the other CPUs will be taken care of by CPU offline),
but for a somewhat different reason than in the hibernation case.

> second memory buffer and reprograms the HFI hardware with the new locatio=
n
> as part of a normal boot. The location of the second memory buffer may
> differ from the one allocated by the image kernel. Subsequently, when the
> restore kernel transfers control to the image kernel, the second buffer
> becomes invalid, potentially leading to memory corruption if the hardware
> writes to it (hardware continues using the buffer from the restore kernel=
).
>
> Add a suspend notifier to disable all HFI instances before jumping to the
> image kernel and enable them once the image kernel has been restored. Use
> the memory buffer that the image kernel allocated.
>
> For non-boot CPUs, rely on the CPU hotplug callbacks as CPUs are disabled
> and enabled during suspend and resume, respectively.
>
> The CPU hotplug callbacks do not cover the boot CPU. Handle the HFI
> instance of the boot CPU from the suspend notifier callback.
>
> Cc: Chen Yu <yu.c.chen@intel.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Zhao Liu <zhao1.liu@linux.intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: stable@vger.kernel.org    # 6.1
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> --
> Changes since v1:
>  * Moved registration of the suspend notifier towards the end of
>    intel_hfi_init(). (Stan)
>  * Renamed hfi_do_pm_[enable|disable]() to hfi_do_[enable|disable](). Sta=
n
>    will use these functions outside the suspend notifier. (Stan)
>  * Added locking to calls to hfi_[enable|disable]() from the suspend
>    notifier. (Rafael)
> ---
>  drivers/thermal/intel/intel_hfi.c | 62 +++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>
> diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/in=
tel_hfi.c
> index 22445403b520..8d6e4f8dc67a 100644
> --- a/drivers/thermal/intel/intel_hfi.c
> +++ b/drivers/thermal/intel/intel_hfi.c
> @@ -30,11 +30,13 @@
>  #include <linux/kernel.h>
>  #include <linux/math.h>
>  #include <linux/mutex.h>
> +#include <linux/notifier.h>
>  #include <linux/percpu-defs.h>
>  #include <linux/printk.h>
>  #include <linux/processor.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/suspend.h>
>  #include <linux/string.h>
>  #include <linux/topology.h>
>  #include <linux/workqueue.h>
> @@ -571,6 +573,60 @@ static __init int hfi_parse_features(void)
>         return 0;
>  }
>
> +static void hfi_do_enable(void *info)
> +{
> +       struct hfi_instance *hfi_instance =3D info;
> +
> +       hfi_set_hw_table(hfi_instance);
> +       hfi_enable();
> +}
> +
> +static void hfi_do_disable(void *info)
> +{
> +       hfi_disable();
> +}
> +
> +static int hfi_pm_notify(struct notifier_block *nb,
> +                        unsigned long mode, void *unused)
> +{
> +       struct hfi_cpu_info *info =3D &per_cpu(hfi_cpu_info, 0);
> +       struct hfi_instance *hfi =3D info->hfi_instance;
> +       int ret =3D 0;
> +
> +       /* HFI may not be in use. */
> +       if (!hfi)
> +               return ret;
> +
> +       mutex_lock(&hfi_instance_lock);
> +       /*
> +        * Only handle the HFI instance of the package of the boot CPU. T=
he
> +        * instances of other packages are handled in the CPU hotplug cal=
lbacks.
> +        */
> +       switch (mode) {
> +       case PM_HIBERNATION_PREPARE:
> +       case PM_SUSPEND_PREPARE:
> +       case PM_RESTORE_PREPARE:
> +               ret =3D smp_call_function_single(0, hfi_do_disable, NULL,=
 true);
> +               break;
> +
> +       case PM_POST_RESTORE:
> +       case PM_POST_HIBERNATION:
> +       case PM_POST_SUSPEND:
> +               ret =3D smp_call_function_single(0, hfi_do_enable, hfi, t=
rue);
> +               break;

Because this handles the boot CPU only, one has to wonder if it should
be a syscore op rather than a PM notifier.

It does not sleep AFAICS, so it can run in that context, and it is
guaranteed to run on the boot CPU then, so it is not necessary to
force that.  Moreover, syscore ops are guaranteed to be
non-concurrent, so locking is not needed.

In addition, disabling HFI from a PM notifier is generally observable
by user space, because PM notifiers run before user space is frozen,
but doing it from a syscore op wouldn't be.


Return-Path: <linux-kernel+bounces-31598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 582D9833098
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 23:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB79A1F22928
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562B058AAE;
	Fri, 19 Jan 2024 22:00:55 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6501058123;
	Fri, 19 Jan 2024 22:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705701654; cv=none; b=dffkENUpsEkuFTd0gmR49q/enfuMEGln0H1Xt9PpxPwRdKHSIlpIDm3yH9TlI4XAQO7zkpuwpGMGnVNA/VJ+I8vLL/T5J/tuAjmjWuQdmVrGYIu9LWQmWrDrcv/sGbsj38zp0rDl9Q5uhZmWi5o2F+dlUUo97eFmyhbHPpFXBhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705701654; c=relaxed/simple;
	bh=Kse0PIpkp1eW761DnNoy1BgjfnS1ObybWXpfX+UXoFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/fKBTtgM/8vIfiYdH2yL9JX/LB+ywhTBKosTsDV0UoCbRlQvT0Sixl8GbL59eQ2CYmMnLbB0V/y+0jgbpuqR+Sa4NKopjLemT6rZ5f000WTUsbLZfxZcO0tGDIkTiaJEWTdLMnjhPdberVlyNtPfOHPQcW+VrH5egNSfw4WBZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-53fa455cd94so774703a12.2;
        Fri, 19 Jan 2024 14:00:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705701653; x=1706306453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12c2ARLo1DzPmVN8NnE58YkJlTXRWZ7lnCmUYNjTW2I=;
        b=WR0tr6XATHj3kO3vA0nHt0iiRFsee4uGzN/EouyApYXs1wb7UkViwYKUs4TlNhZ3wo
         gSZP2Lg130R1BQOv3PW3QK7Sc4A6p/mfLcGmrCQZZB8bvzJqVGaPdmZN8vYtYx8BLni/
         yk7Avvg5Mx6b2xFKJXA7R9gJV+NPBeVAbn5+hXt3649himq0YPeTuyE0pYoV6o2dfrDz
         dwURGB/TcYXCWOS5hlnoLmxLCpF8eM+svH09PhpR0HOYXx+QyF3uzJw/bKeWetp+sWx3
         CzObE0tGI6vjqsMxipRdcuD6Bp6jCShxK4ljmhKjMBHeBbVOU7/DxMQ+H60dEIypvnpL
         T8eQ==
X-Gm-Message-State: AOJu0YwDKOc4YnSprCyMZS0EfubKRn1f5a98qvo3rKum+HK6u1yUPfIi
	uCb5qMG82gb0FPSSacCAxhfzoPbQW/7L6b22aGSKmolBpKt+8EOzoRyu+E02kAr9VR5gvDbIJ2i
	GlWCaMakT4qdhpwEP1sVFBh0+Khw=
X-Google-Smtp-Source: AGHT+IHjdaVUHskCyMOUbNn6cvOvq8mmYxB4O6Xhj6CxkRtg4NlhYQc5lLCxfgB1l2SO3xq42x42tsux4CId48SeWD0=
X-Received: by 2002:a17:90a:7562:b0:28c:8478:f4aa with SMTP id
 q89-20020a17090a756200b0028c8478f4aamr455480pjk.66.1705701652722; Fri, 19 Jan
 2024 14:00:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-1-lizhijian@fujitsu.com> <20240116045151.3940401-3-lizhijian@fujitsu.com>
In-Reply-To: <20240116045151.3940401-3-lizhijian@fujitsu.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 19 Jan 2024 14:00:41 -0800
Message-ID: <CAM9d7cirhP65hMsgD7Kt+puferoJ76i+p6f7EGJsaoh4a2eLag@mail.gmail.com>
Subject: Re: [PATCH 05/42] arch/x86/events/intel: Convert snprintf to sysfs_emit
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Jan 15, 2024 at 8:53=E2=80=AFPM Li Zhijian <lizhijian@fujitsu.com> =
wrote:
>
> Per filesystems/sysfs.rst, show() should only use sysfs_emit()
> or sysfs_emit_at() when formatting the value to be returned to user space=
.
>
> coccinelle complains that there are still a couple of functions that use
> snprintf(). Convert them to sysfs_emit().
>
> > ./arch/x86/events/intel/core.c:5496:8-16: WARNING: please use sysfs_emi=
t
> > ./arch/x86/events/intel/core.c:5530:8-16: WARNING: please use sysfs_emi=
t
> > ./arch/x86/events/intel/core.c:5546:8-16: WARNING: please use sysfs_emi=
t
> > ./arch/x86/events/intel/pt.c:99:8-16: WARNING: please use sysfs_emit
>
> No functional change intended
>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Arnaldo Carvalho de Melo <acme@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> CC: Jiri Olsa <jolsa@kernel.org>
> CC: Namhyung Kim <namhyung@kernel.org>
> CC: Ian Rogers <irogers@google.com>
> CC: Adrian Hunter <adrian.hunter@intel.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Borislav Petkov <bp@alien8.de>
> CC: Dave Hansen <dave.hansen@linux.intel.com>
> CC: x86@kernel.org
> CC: "H. Peter Anvin" <hpa@zytor.com>
> CC: linux-perf-users@vger.kernel.org
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  arch/x86/events/intel/core.c | 6 +++---
>  arch/x86/events/intel/pt.c   | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 0f2786d4e405..aa5fa64a923b 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -5493,7 +5493,7 @@ static ssize_t show_sysctl_tfa(struct device *cdev,
>                               struct device_attribute *attr,
>                               char *buf)
>  {
> -       return snprintf(buf, 40, "%d\n", allow_tsx_force_abort);
> +       return sysfs_emit(buf, "%d\n", allow_tsx_force_abort);

I guess the size doesn't matter here..

Anyway there's freeze_on_smi_show() even uses sprintf().

Thanks,
Namhyung

>  }
>
>  static ssize_t set_sysctl_tfa(struct device *cdev,
> @@ -5527,7 +5527,7 @@ static ssize_t branches_show(struct device *cdev,
>                              struct device_attribute *attr,
>                              char *buf)
>  {
> -       return snprintf(buf, PAGE_SIZE, "%d\n", x86_pmu.lbr_nr);
> +       return sysfs_emit(buf, "%d\n", x86_pmu.lbr_nr);
>  }
>
>  static DEVICE_ATTR_RO(branches);
> @@ -5543,7 +5543,7 @@ static ssize_t pmu_name_show(struct device *cdev,
>                              struct device_attribute *attr,
>                              char *buf)
>  {
> -       return snprintf(buf, PAGE_SIZE, "%s\n", pmu_name_str);
> +       return sysfs_emit(buf, "%s\n", pmu_name_str);
>  }
>
>  static DEVICE_ATTR_RO(pmu_name);
> diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
> index 8e2a12235e62..30bba5f3a840 100644
> --- a/arch/x86/events/intel/pt.c
> +++ b/arch/x86/events/intel/pt.c
> @@ -96,7 +96,7 @@ static ssize_t pt_cap_show(struct device *cdev,
>                 container_of(attr, struct dev_ext_attribute, attr);
>         enum pt_capabilities cap =3D (long)ea->var;
>
> -       return snprintf(buf, PAGE_SIZE, "%x\n", intel_pt_validate_hw_cap(=
cap));
> +       return sysfs_emit(buf, "%x\n", intel_pt_validate_hw_cap(cap));
>  }
>
>  static struct attribute_group pt_cap_group __ro_after_init =3D {
> --
> 2.29.2
>


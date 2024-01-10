Return-Path: <linux-kernel+bounces-22330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F631829C3F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EABCB27333
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF604BA89;
	Wed, 10 Jan 2024 14:13:42 +0000 (UTC)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5054B5C5;
	Wed, 10 Jan 2024 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59584f41f1eso427128eaf.1;
        Wed, 10 Jan 2024 06:13:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704896019; x=1705500819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VB6UqhNETBqYunxJJvMUA9SmS3r4uwslMpuYoOasyy0=;
        b=W2Bs3zPU4UhyDtzPpnCAZKKf6JRPW5IyfUa0kiCcFFaYA08zVBCDKLMWeM139eMnJM
         AZrnxbCr+FuER59afpqbSstI4y/HRXW8atgo0F1LknhAhoBBh8w0mLhwKiiVFGRSz8kM
         T/WTUG3+HJZX6+q8KrSZnfL/PIQ6xQCY+LXzj8PEKA8ulWayd6U4IdqrtHsH3+DnwE7C
         6YL2/qqolU4GSyDDeI7DubGZDAvCC3deDxVMz512k/1dkpCtbesu28JPE6lrMSvU3SD6
         XOAss9vzXVpE9NYh6zVB/60+qNm4B8t8UwKDEp7bTxIE4VImLwj4kjD2AUa4Yf3C9Pkz
         9ETg==
X-Gm-Message-State: AOJu0YzDPD3egE3CFIvHOC0LQq2AMJoJKUWa4sqq+asuMajZttthdhcW
	RWsCpzWT69s9q+FJNOq3o2xgTV0cswlO/Lwq/v5TQTw8
X-Google-Smtp-Source: AGHT+IEJF3AmfXmuebgf2YmkFzAhusVLGBp57WDhxGwNT5Z2T4O/RqPhLLmQY2XCPzCrIvOcj51DRKeoKiLMsEu7g0Y=
X-Received: by 2002:a4a:bb8d:0:b0:598:75ed:c5c6 with SMTP id
 h13-20020a4abb8d000000b0059875edc5c6mr2108775oop.0.1704896019116; Wed, 10 Jan
 2024 06:13:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109175801.447943-1-e.velu@criteo.com>
In-Reply-To: <20240109175801.447943-1-e.velu@criteo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Jan 2024 15:13:27 +0100
Message-ID: <CAJZ5v0juCOaLQGD_5nAtW-Ov5k5Gh+=e51NhdWy4bf-XDtvvQg@mail.gmail.com>
Subject: Re: [PATCH 1/2] admin-guide: Fixing typos
To: Erwan Velu <erwanaliasr1@gmail.com>
Cc: Erwan Velu <e.velu@criteo.com>, Jonathan Corbet <corbet@lwn.net>, Huang Rui <ray.huang@amd.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 6:58=E2=80=AFPM Erwan Velu <erwanaliasr1@gmail.com> =
wrote:
>
> This commit fixes two typos in the admin-guide.
>
> - a missing e in "reference_perf".
> - the amd_pstate sysfs path uses a dash instead of an underscore.
>
> Signed-off-by: Erwan Velu <e.velu@criteo.com>
> ---
>  Documentation/admin-guide/acpi/cppc_sysfs.rst | 2 +-
>  Documentation/admin-guide/pm/amd-pstate.rst   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/acpi/cppc_sysfs.rst b/Documentatio=
n/admin-guide/acpi/cppc_sysfs.rst
> index e53d76365aa7..36981c667823 100644
> --- a/Documentation/admin-guide/acpi/cppc_sysfs.rst
> +++ b/Documentation/admin-guide/acpi/cppc_sysfs.rst
> @@ -75,4 +75,4 @@ taking two different snapshots of feedback counters at =
time T1 and T2.
>    delivered_counter_delta =3D fbc_t2[del] - fbc_t1[del]
>    reference_counter_delta =3D fbc_t2[ref] - fbc_t1[ref]
>
> -  delivered_perf =3D (refernce_perf x delivered_counter_delta) / referen=
ce_counter_delta
> +  delivered_perf =3D (reference_perf x delivered_counter_delta) / refere=
nce_counter_delta
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/=
admin-guide/pm/amd-pstate.rst
> index 1cf40f69278c..9eb26014d34b 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -361,7 +361,7 @@ Global Attributes
>
>  ``amd-pstate`` exposes several global attributes (files) in ``sysfs`` to
>  control its functionality at the system level.  They are located in the
> -``/sys/devices/system/cpu/amd-pstate/`` directory and affect all CPUs.
> +``/sys/devices/system/cpu/amd_pstate/`` directory and affect all CPUs.
>
>  ``status``
>         Operation mode of the driver: "active", "passive" or "disable".
> --

Applied as 6.8-rc1 material with some edits in the subject and changelog.

Thanks!


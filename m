Return-Path: <linux-kernel+bounces-135485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC89D89C67E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B5A1C229A5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F6F8529C;
	Mon,  8 Apr 2024 14:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hi4haSiz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC9984D1C;
	Mon,  8 Apr 2024 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585510; cv=none; b=faCJAns5daGJeyTvM1f/Y5Cn5r8cuCzS60KcK6KVxKB++kOaJqo4bqsGHTktkTautVOFBDYm/DwtfMCU6kirGkLpYgsiB8qrn6QeClliaW+C9pGYP3EO74gH9t7zWpuNo/QUbwT2NTMxdUP74s39+3lvF5MQXGssvN00SPsbkcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585510; c=relaxed/simple;
	bh=Y5VDGX/dMQKlUWcPOeqi5ZCYWJijxH8qLM/15IHq2Ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pNzWCJtZTC44Bh4sRv1hxpljvwkPsjk6dPlKwF/VfaYMq4N475Tn4Y1G7wvOrn7xwdFvgVf0SfjTcOHt7G9qQl809QPJmvCNXT1sauA71lLQO9LIHBboFv1nrm0VU8LB4Pa+HFFjO0S/JuEuC3Q4zE+VZvDGSmhl/To0GAtAJ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hi4haSiz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D384C433F1;
	Mon,  8 Apr 2024 14:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712585509;
	bh=Y5VDGX/dMQKlUWcPOeqi5ZCYWJijxH8qLM/15IHq2Ag=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hi4haSizLHLeV1cxPz2QxOf0sM5W3Vwrpvpz75wspuo6phr5Q9EBAv7ole5+JcHVD
	 B4mexWtiU6i6SPVdOj2n6Rq505T3XDeG9s3dNAD6hSM0PNKHldCAeGmRisHEQNiz6K
	 cb+isO7Gdz7sXcDItzLKhMvJCpxh+KiIJoLpSY2qlF2PO8kXAnnXj95DQWRnhJiLh/
	 S8FBsGvp1Z0706XWzLBPsM41nUCDTILIr4iJyQZj+ZsAONcNlB0pglPvW4cIeFCQYK
	 /cSTYusoNphLJSzIou22wDseKz2gruSn/tzKFclelULXvPLE8+LGdg+8FIXiv6PRkB
	 VasGbzrUpZMFQ==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6ea0a6856d7so606196a34.1;
        Mon, 08 Apr 2024 07:11:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVUoPJgMkLd+wuxJNYrSwV8ur1Sn0Sge/n8Lm9XdVgFBz5aULQVZoiE0I36oPyCHNniI8Nme594ZFmF34frxwdNRbAAC4F7F6OnsAUpBJhIF3l7XfBqjLFwGOmVuy61OesEkMTmxU7y2XXc329rkuvDu5BaUu/XZzUY+jWrS1O+7MEQ
X-Gm-Message-State: AOJu0YxZt49HPtNuVBTord259UCSjilcfqiP0CavN+SfVhcwTpx0A2Z7
	bNxvP6Q3qypWZ7rx0RxSzAU56bDpAAu2cjY7Bic+XrzcWZffvxxW/q7nVkc9ea1ODgQmsmaazDj
	rmHQ2zKgEtqgcCDDxXaPOXVfq3Zs=
X-Google-Smtp-Source: AGHT+IHXfmB+SUI1PFf5gbH9pXpP3RXeYlH6OKyn7AkJ05XBV8CG5i8TYv8qnvxxum64Q8ax1o9IrX71zGPJ88VXXks=
X-Received: by 2002:a05:6808:130a:b0:3c5:dc7a:57d0 with SMTP id
 y10-20020a056808130a00b003c5dc7a57d0mr10464908oiv.5.1712585508701; Mon, 08
 Apr 2024 07:11:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405121819.31331-1-sumeet.r.pawnikar@intel.com>
In-Reply-To: <20240405121819.31331-1-sumeet.r.pawnikar@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Apr 2024 16:11:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0is1Y+QHWfp-=sddAD8bUgn+QD7PmfBnAzgjZktqMYhBA@mail.gmail.com>
Message-ID: <CAJZ5v0is1Y+QHWfp-=sddAD8bUgn+QD7PmfBnAzgjZktqMYhBA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: DPTF: Add Lunar Lake support
To: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc: rafael@kernel.org, srinivas.pandruvada@linux.intel.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 2:31=E2=80=AFPM Sumeet Pawnikar
<sumeet.r.pawnikar@intel.com> wrote:
>
> Add Lunar Lake ACPI IDs for DPTF devices.
>
> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> ---
>  drivers/acpi/dptf/dptf_pch_fivr.c                       | 1 +
>  drivers/acpi/dptf/dptf_power.c                          | 2 ++
>  drivers/acpi/dptf/int340x_thermal.c                     | 6 ++++++
>  drivers/acpi/fan.h                                      | 1 +
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 1 +
>  drivers/thermal/intel/int340x_thermal/int3403_thermal.c | 1 +
>  6 files changed, 12 insertions(+)
>
> diff --git a/drivers/acpi/dptf/dptf_pch_fivr.c b/drivers/acpi/dptf/dptf_p=
ch_fivr.c
> index 654aaa53c67f..d202730fafd8 100644
> --- a/drivers/acpi/dptf/dptf_pch_fivr.c
> +++ b/drivers/acpi/dptf/dptf_pch_fivr.c
> @@ -150,6 +150,7 @@ static const struct acpi_device_id pch_fivr_device_id=
s[] =3D {
>         {"INTC1045", 0},
>         {"INTC1049", 0},
>         {"INTC1064", 0},
> +       {"INTC106B", 0},
>         {"INTC10A3", 0},
>         {"", 0},
>  };
> diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_powe=
r.c
> index b8187babbbbb..8023b3e23315 100644
> --- a/drivers/acpi/dptf/dptf_power.c
> +++ b/drivers/acpi/dptf/dptf_power.c
> @@ -232,6 +232,8 @@ static const struct acpi_device_id int3407_device_ids=
[] =3D {
>         {"INTC1061", 0},
>         {"INTC1065", 0},
>         {"INTC1066", 0},
> +       {"INTC106C", 0},
> +       {"INTC106D", 0},
>         {"INTC10A4", 0},
>         {"INTC10A5", 0},
>         {"", 0},
> diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int3=
40x_thermal.c
> index b7113fa92fa6..014ada759954 100644
> --- a/drivers/acpi/dptf/int340x_thermal.c
> +++ b/drivers/acpi/dptf/int340x_thermal.c
> @@ -43,6 +43,12 @@ static const struct acpi_device_id int340x_thermal_dev=
ice_ids[] =3D {
>         {"INTC1064"},
>         {"INTC1065"},
>         {"INTC1066"},
> +       {"INTC1068"},
> +       {"INTC1069"},
> +       {"INTC106A"},
> +       {"INTC106B"},
> +       {"INTC106C"},
> +       {"INTC106D"},
>         {"INTC10A0"},
>         {"INTC10A1"},
>         {"INTC10A2"},
> diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
> index e7b4b4e4a55e..f89d19c922dc 100644
> --- a/drivers/acpi/fan.h
> +++ b/drivers/acpi/fan.h
> @@ -15,6 +15,7 @@
>         {"INTC1044", }, /* Fan for Tiger Lake generation */ \
>         {"INTC1048", }, /* Fan for Alder Lake generation */ \
>         {"INTC1063", }, /* Fan for Meteor Lake generation */ \
> +       {"INTC106A", }, /* Fan for Lunar Lake generation */ \
>         {"INTC10A2", }, /* Fan for Raptor Lake generation */ \
>         {"PNP0C0B", } /* Generic ACPI fan */
>
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/dr=
ivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 427d370648d5..f8ebdd19d340 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -705,6 +705,7 @@ static const struct acpi_device_id int3400_thermal_ma=
tch[] =3D {
>         {"INTC1040", 0},
>         {"INTC1041", 0},
>         {"INTC1042", 0},
> +       {"INTC1068", 0},
>         {"INTC10A0", 0},
>         {}
>  };
> diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c b/dr=
ivers/thermal/intel/int340x_thermal/int3403_thermal.c
> index 9b33fd3a66da..86901f9f54d8 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> @@ -284,6 +284,7 @@ static const struct acpi_device_id int3403_device_ids=
[] =3D {
>         {"INTC1043", 0},
>         {"INTC1046", 0},
>         {"INTC1062", 0},
> +       {"INTC1069", 0},
>         {"INTC10A1", 0},
>         {"", 0},
>  };
> --

Applied as 6.10 material, thanks!


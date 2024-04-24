Return-Path: <linux-kernel+bounces-157576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF338B1318
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8A081F27A88
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9309F22EE9;
	Wed, 24 Apr 2024 19:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUVL1y/B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0721B7FD;
	Wed, 24 Apr 2024 19:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985300; cv=none; b=flXc4Qgmnesj/ZgtHkl5hNIq4V2UYW65H/qIXMQzXPS2MxKsYaTroXFgK8zoEC/aIfv1mtbS2Tb0ghzpt5sBEmF8ZlM0wklk9t/1iSMlYbvj8VuVdFvID3WWhe5nKDSEBmH/0H6INFLYFBZne7eVso6/4bD9afZQs5kW48qcYKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985300; c=relaxed/simple;
	bh=AUAwhdW+M8AMnRI433zCP6rrFHe66cysjLyGIeXMbYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOU5+pwrWUyqVXnSSHriE79gG7VWFRkxsAgaR7fIXBipIPlILjLdpcwWR4Bquc2X54hYDOxfvlk4IsM7uQRkK4Q+nLm1XDCyIfb9B1BqHcolAf/Rz7r/8WgJR8cxZtYC/HDgMmPB02jLTEfv2tcAMi7KeR6w+VBexaArVhBS5Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUVL1y/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC42C32783;
	Wed, 24 Apr 2024 19:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713985300;
	bh=AUAwhdW+M8AMnRI433zCP6rrFHe66cysjLyGIeXMbYU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gUVL1y/BKDh3ii9owcmzWkQXKwWdUgsIaP/pNHQrnybXwAIqY2XJkCN+kLscAy+zV
	 Ziq7LcVHWWmxzyrqVPecEH+Z5ChOZj6Z5b7kS2/qfhw4CsVB0KBlkFczMnGj6Fr+YQ
	 mk9L5t+HJCsepwn31OLY3utw4N50Fiavg1onS91kdTsJkQNXwlvBktIdwgaHW4mJWz
	 JV087DgZjC6kokUNQEaKzJz8OHDixG4NpZEFsCVhktMypAxhsg8PLu/xZCyQlFicLh
	 7eXC73E6ILSJtvar1DyYacdP9QZFv640GZDu9S37FLHn3YroH7yfJAwIgd28qD1UFn
	 +Z5BhkKG0ASFg==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5aca32d3f78so33239eaf.1;
        Wed, 24 Apr 2024 12:01:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW6+wXcIOuvwwb0VVc5RmGDDHKw1U88ERwUgmSmdRU7WKP7ZIk3A+5pLt85gSAWNET4yNkrQ0F7hMcs7hQTJZ4k/wwGMDzZoRXIqqOP4CHYXkuKHmhVIuM/AK+Z1zT40/hKPtUGqoW+SJj1EfBU8xaUjqShReGQeJOlry0vLBviB053aHaVF0FtHkn1E7TpYw5K0eiF55gUKY5+1jrb8rp6ENCEGcTonB169A==
X-Gm-Message-State: AOJu0YwPbuLTghc+4FAf1FCXtORHyOdpinB913PzfNCPfaSTDDUV8SXp
	zcw1KWrecck2m0YH1urlX4Xe7AAtpw40f2BXY7rjnRL2z8YwGiDfVj8Bkb4N0FzocLbq4vXLWiT
	DzusfIdLYCUAqlZzooaZNiI5dcEk=
X-Google-Smtp-Source: AGHT+IGvBQ2jFo2NOYEzKPYTqsFLqDDLw5PpBktYstWvuP0UE7S+AFO3g19ze7Bwo0WYNLV3mUTJhJ2us3ywPEAtuhc=
X-Received: by 2002:a4a:c710:0:b0:5aa:3e4f:f01e with SMTP id
 n16-20020a4ac710000000b005aa3e4ff01emr3319234ooq.1.1713985299242; Wed, 24 Apr
 2024 12:01:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422195745.5089-1-W_Armin@gmx.de>
In-Reply-To: <20240422195745.5089-1-W_Armin@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 24 Apr 2024 21:01:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gLQYOWLTmpe24epb9GzV5o2qSuaP5t25eu-OXYoE2pAQ@mail.gmail.com>
Message-ID: <CAJZ5v0gLQYOWLTmpe24epb9GzV5o2qSuaP5t25eu-OXYoE2pAQ@mail.gmail.com>
Subject: Re: [PATCH v6] ACPI: fan: Add hwmon support
To: Armin Wolf <W_Armin@gmx.de>
Cc: mlj@danelec.com, rafael.j.wysocki@intel.com, lenb@kernel.org, 
	jdelvare@suse.com, andy.shevchenko@gmail.com, linux@roeck-us.net, 
	linux@weissschuh.net, ilpo.jarvinen@linux.intel.com, 
	linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 9:58=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Currently, the driver does only support a custom sysfs
> interface to allow userspace to read the fan speed.
> Add support for the standard hwmon interface so users
> can read the fan speed with standard tools like "sensors".
>
> Tested with a custom ACPI SSDT.
>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

I need Guenter to tell me that this is fine with him.

Also please see one nit below.

> ---
> Changes since v5:
> - fix coding style issues
> - replace double break with return
> - add missing includes
>
> Changes since v4:
> - fix spelling issues
> - check power values for overflow condition too
>
> Changes since v3:
> - drop fault attrs
> - rework initialization
>
> Changes since v2:
> - add support for fanX_target and power attrs
>
> Changes since v1:
> - fix undefined reference error
> - fix fan speed validation
> - coding style fixes
> - clarify that the changes are compile-tested only
> - add hwmon maintainers to cc list
> ---
>  drivers/acpi/Makefile    |   1 +
>  drivers/acpi/fan.h       |   9 +++
>  drivers/acpi/fan_core.c  |   4 +
>  drivers/acpi/fan_hwmon.c | 169 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 183 insertions(+)
>  create mode 100644 drivers/acpi/fan_hwmon.c
>
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 39ea5cfa8326..61ca4afe83dc 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -77,6 +77,7 @@ obj-$(CONFIG_ACPI_TINY_POWER_BUTTON)  +=3D tiny-power-b=
utton.o
>  obj-$(CONFIG_ACPI_FAN)         +=3D fan.o
>  fan-objs                       :=3D fan_core.o
>  fan-objs                       +=3D fan_attr.o
> +fan-$(CONFIG_HWMON)            +=3D fan_hwmon.o
>
>  obj-$(CONFIG_ACPI_VIDEO)       +=3D video.o
>  obj-$(CONFIG_ACPI_TAD)         +=3D acpi_tad.o
> diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
> index f89d19c922dc..db25a3898af7 100644
> --- a/drivers/acpi/fan.h
> +++ b/drivers/acpi/fan.h
> @@ -10,6 +10,8 @@
>  #ifndef _ACPI_FAN_H_
>  #define _ACPI_FAN_H_
>
> +#include <linux/kconfig.h>
> +
>  #define ACPI_FAN_DEVICE_IDS    \
>         {"INT3404", }, /* Fan */ \
>         {"INTC1044", }, /* Fan for Tiger Lake generation */ \
> @@ -57,4 +59,11 @@ struct acpi_fan {
>  int acpi_fan_get_fst(struct acpi_device *device, struct acpi_fan_fst *fs=
t);
>  int acpi_fan_create_attributes(struct acpi_device *device);
>  void acpi_fan_delete_attributes(struct acpi_device *device);
> +
> +#if IS_REACHABLE(CONFIG_HWMON)
> +int devm_acpi_fan_create_hwmon(struct acpi_device *device);
> +#else
> +static inline int devm_acpi_fan_create_hwmon(struct acpi_device *device)=
 { return 0; };
> +#endif
> +
>  #endif
> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
> index ff72e4ef8738..7cea4495f19b 100644
> --- a/drivers/acpi/fan_core.c
> +++ b/drivers/acpi/fan_core.c
> @@ -336,6 +336,10 @@ static int acpi_fan_probe(struct platform_device *pd=
ev)
>                 if (result)
>                         return result;
>
> +               result =3D devm_acpi_fan_create_hwmon(device);
> +               if (result)
> +                       return result;
> +
>                 result =3D acpi_fan_create_attributes(device);
>                 if (result)
>                         return result;
> diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
> new file mode 100644
> index 000000000000..34a524c285a5
> --- /dev/null
> +++ b/drivers/acpi/fan_hwmon.c
> @@ -0,0 +1,169 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Hwmon interface for the ACPI Fan driver.
> + *
> + * Copyright (C) 2024 Armin Wolf <W_Armin@gmx.de>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +#include <linux/limits.h>
> +#include <linux/units.h>
> +
> +#include "fan.h"
> +
> +/* Returned when the ACPI fan does not support speed reporting */
> +#define FAN_SPEED_UNAVAILABLE  U32_MAX
> +#define FAN_POWER_UNAVAILABLE  U32_MAX
> +
> +static struct acpi_fan_fps *acpi_fan_get_current_fps(struct acpi_fan *fa=
n, u64 control)
> +{
> +       unsigned int i;
> +
> +       for (i =3D 0; i < fan->fps_count; i++) {
> +               if (fan->fps[i].control =3D=3D control)
> +                       return &fan->fps[i];
> +       }
> +
> +       return NULL;
> +}
> +
> +static umode_t acpi_fan_is_visible(const void *drvdata, enum hwmon_senso=
r_types type, u32 attr,
> +                                  int channel)
> +{
> +       const struct acpi_fan *fan =3D drvdata;
> +       unsigned int i;
> +
> +       switch (type) {
> +       case hwmon_fan:
> +               switch (attr) {
> +               case hwmon_fan_input:
> +                       return 0444;
> +               case hwmon_fan_target:
> +                       /*
> +                        * When in fine grain control mode, not every fan=
 control value
> +                        * has an associated fan performance state.
> +                        */
> +                       if (fan->fif.fine_grain_ctrl)
> +                               return 0;
> +
> +                       return 0444;
> +               default:
> +                       return 0;
> +               }
> +       case hwmon_power:
> +               switch (attr) {
> +               case hwmon_power_input:
> +                       /*
> +                        * When in fine grain control mode, not every fan=
 control value
> +                        * has an associated fan performance state.
> +                        */
> +                       if (fan->fif.fine_grain_ctrl)
> +                               return 0;
> +
> +                       /*
> +                        * When all fan performance states contain no val=
id power data,
> +                        * when the associated attribute should not be cr=
eated.
> +                        */
> +                       for (i =3D 0; i < fan->fps_count; i++) {
> +                               if (fan->fps[i].power !=3D FAN_POWER_UNAV=
AILABLE)
> +                                       return 0444;
> +                       }
> +
> +                       return 0;
> +               default:
> +                       return 0;
> +               }
> +       default:
> +               return 0;
> +       }
> +}
> +
> +static int acpi_fan_read(struct device *dev, enum hwmon_sensor_types typ=
e, u32 attr, int channel,
> +                        long *val)
> +{
> +       struct acpi_device *adev =3D to_acpi_device(dev->parent);
> +       struct acpi_fan *fan =3D dev_get_drvdata(dev);
> +       struct acpi_fan_fps *fps;
> +       struct acpi_fan_fst fst;
> +       int ret;
> +
> +       ret =3D acpi_fan_get_fst(adev, &fst);
> +       if (ret < 0)
> +               return ret;
> +
> +       switch (type) {
> +       case hwmon_fan:
> +               switch (attr) {
> +               case hwmon_fan_input:
> +                       if (fst.speed =3D=3D FAN_SPEED_UNAVAILABLE)
> +                               return -ENODATA;
> +
> +                       if (fst.speed > LONG_MAX)
> +                               return -EOVERFLOW;
> +
> +                       *val =3D fst.speed;
> +                       return 0;
> +               case hwmon_fan_target:
> +                       fps =3D acpi_fan_get_current_fps(fan, fst.control=
);
> +                       if (!fps)
> +                               return -ENODATA;
> +
> +                       if (fps->speed > LONG_MAX)
> +                               return -EOVERFLOW;
> +
> +                       *val =3D fps->speed;
> +                       return 0;
> +               default:
> +                       return -EOPNOTSUPP;
> +               }
> +       case hwmon_power:
> +               switch (attr) {
> +               case hwmon_power_input:
> +                       fps =3D acpi_fan_get_current_fps(fan, fst.control=
);
> +                       if (!fps)
> +                               return -ENODATA;
> +
> +                       if (fps->power =3D=3D FAN_POWER_UNAVAILABLE)
> +                               return -ENODATA;
> +
> +                       if (fps->power > LONG_MAX / MICROWATT_PER_MILLIWA=
TT)
> +                               return -EOVERFLOW;
> +
> +                       *val =3D fps->power * MICROWATT_PER_MILLIWATT;
> +                       return 0;
> +               default:
> +                       return -EOPNOTSUPP;
> +               }
> +       default:
> +               return -EOPNOTSUPP;
> +       }
> +}
> +
> +static const struct hwmon_ops acpi_fan_ops =3D {
> +       .is_visible =3D acpi_fan_is_visible,
> +       .read =3D acpi_fan_read,
> +};

I would add "hwmon" to the names of functions and variables related to
hwmon.  Something like

+static const struct hwmon_ops acpi_fan_hwmon_ops =3D {
+       .is_visible =3D acpi_fan_hwmon_is_visible,
+       .read =3D acpi_fan_hwmon_read,
+};

Otherwise, it looks fine to me.

> +
> +static const struct hwmon_channel_info * const acpi_fan_info[] =3D {
> +       HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT | HWMON_F_TARGET),
> +       HWMON_CHANNEL_INFO(power, HWMON_P_INPUT),
> +       NULL
> +};
> +
> +static const struct hwmon_chip_info acpi_fan_chip_info =3D {
> +       .ops =3D &acpi_fan_ops,
> +       .info =3D acpi_fan_info,
> +};
> +
> +int devm_acpi_fan_create_hwmon(struct acpi_device *device)
> +{
> +       struct acpi_fan *fan =3D acpi_driver_data(device);
> +       struct device *hdev;
> +
> +       hdev =3D devm_hwmon_device_register_with_info(&device->dev, "acpi=
_fan", fan,
> +                                                   &acpi_fan_chip_info, =
NULL);
> +       return PTR_ERR_OR_ZERO(hdev);
> +}
> --


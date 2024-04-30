Return-Path: <linux-kernel+bounces-164626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 969F18B804C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E942B21F20
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7C8194C93;
	Tue, 30 Apr 2024 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYKfkgWG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3493184122;
	Tue, 30 Apr 2024 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714504072; cv=none; b=tYc8c5G3cE6YX68Lslo9Q7+UcATh9LvyhUI8wiyiofSvRGxayAIjqy2gvcmlnDbY33p86SSa71nxkKHsn8doEMkAhnw9fbJ5JVw/7g1DcoWP1gfMpPZUci1uOeLMyxozo4jM2Tfu3O1cY6CS2nEQ4eRhnUNRq4VHXAsg9nFfsbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714504072; c=relaxed/simple;
	bh=jdZQdtzHlUX2tMN0QcmZaAYJHwpQLuI3w3rBe5Y9zr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NikNWwEDuBAoEew7vY8YHCPTZSfWrCgp7Nowl7iE+cWMKhb36OIMxgkCVeNekTg9EOvxe96vztM9Nsco5KhI5SG8PsHDLoiYPgD0KdF06vrHW7VGmpLh0ZPv50PGj0Tlsux4s0Xh0Kgc2iVP0P+NIe7WoCdKb4GZTGZjLeoY8QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYKfkgWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589DFC4AF18;
	Tue, 30 Apr 2024 19:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714504072;
	bh=jdZQdtzHlUX2tMN0QcmZaAYJHwpQLuI3w3rBe5Y9zr8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QYKfkgWGYPwxKrUfv93KsSzV5OfrPNHpM/bThrurHrprhhv4LTDaNQ/rwicYQwsK+
	 WDM7mk0jctOdc9ndzT92A2pxsL6qGgMZ/b0IXq9FmhYomdZrRz97WgOaYpGDytXDaB
	 JiKszig18g/yUw3bEWBujfwY22ECP+2vMJsvL61NDmvP2KTeK2Gubaz/flMKOc4lrC
	 GQ2XDFfkOjHUzhSu6zONxf4y0GIwRJVSxhiikDPMusINEkjEUNp6cFYK5G8jS6V2u5
	 abnbeTBkJK6m82MF/5IjlYLFzdeLGzgejacA0q2dDKK77dlLI1F+dR5DSHJmHdKIbk
	 6QWaRuA3L+02g==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ee5ee29423so328686a34.2;
        Tue, 30 Apr 2024 12:07:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvgJH2qiro6SrAF4JyOo1Bq3USXaMbchdt4Zqx2rie9N5WBqix6Vgxw01rQEq0xsD6VbQMt2w84kAepGtcOuoiRLzTGwMVGEvVbA/IawVPiJuniA20hkxiK/DwIVLzw+aFs6dSOChJSdLBAWtL2bdhtmsHE79Z1R5kFMtczTnZHbn0Pw==
X-Gm-Message-State: AOJu0YyubdET82Y+Y7Ig8H3ys3xZrwd6UpKk1NQ+oT+hfEgmxivKnbQ+
	uBarjW5PXE4AGyOx0DtpjXkagsiarmv1ywYAm3IlJrLPYnX/V0gUOhxh6/JNAhWUQbqxmvDvboI
	PVpyDAE6i/1PLcGnTD2BNGFjUUZQ=
X-Google-Smtp-Source: AGHT+IGDfc6zWcy4TFxA5svJDvHpMfY7IBw4Cn1jXgJP++Z4jbGTWNd7QXhRwjObQV5CGpljILDA4Nbv/s0fTYDQR1s=
X-Received: by 2002:a05:6820:1007:b0:5aa:14ff:4128 with SMTP id
 v7-20020a056820100700b005aa14ff4128mr349495oor.1.1714504071493; Tue, 30 Apr
 2024 12:07:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425171311.19519-1-ricardo.neri-calderon@linux.intel.com> <20240425171311.19519-2-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20240425171311.19519-2-ricardo.neri-calderon@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 30 Apr 2024 21:07:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i4pREX_HPRvxFM209MiwMScxGCYUr0L8XSXfvkrav1_Q@mail.gmail.com>
Message-ID: <CAJZ5v0i4pREX_HPRvxFM209MiwMScxGCYUr0L8XSXfvkrav1_Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] thermal: intel: intel_tcc: Add model checks for
 temperature registers
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ricardo Neri <ricardo.neri@intel.com>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 7:06=E2=80=AFPM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> The register MSR_TEMPERATURE_TARGET is not architectural. Its fields may =
be
> defined differently for each processor model. TCC_OFFSET is an example of
> such case.
>
> Despite being specified as architectural, the registers IA32_[PACKAGE]_
> THERM_STATUS have become model-specific: in recent processors, the
> digital temperature readout uses bits [23:16] whereas the Intel Software
> Developer's manual specifies bits [22:16].
>
> Create an array of processor models and their bitmasks for TCC_OFFSET and
> the digital temperature readout fields. Do not include recent processors.
> Instead, use the bitmasks of these recent processors as default.
>
> Use these model-specific bitmasks when reading TCC_OFFSET or the
> temperature sensors.
>
> Initialize a model-specific data structure during subsys_initcall() to
> have it ready when thermal drivers are loaded.
>
> Expose the new interface intel_tcc_get_offset_mask(). The
> intel_tcc_cooling driver will use it.
>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: linux-hwmon@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org # v6.7+
> ---
> Changes since v1:
>  * Renamed TCC_FAM6_MODEL_TEMP_MASKS as TCC_MODEL_TEMP_MASKS. (Rui)
>  * Renamed get_tcc_offset_mask() as intel_tcc_get_offset_mask(). (Rui)
>  * Do not export intel_tcc_get_temp_mask() as it is no longer used
>    outside intel_tcc.c
>  * Dropped stub functions for digital temperature readout and TCC
>    offset. They are not needed as users select CONFIG_INTEL_TCC.
> ---
>  drivers/thermal/intel/intel_tcc.c | 177 +++++++++++++++++++++++++++++-
>  include/linux/intel_tcc.h         |   1 +
>  2 files changed, 173 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_tcc.c b/drivers/thermal/intel/in=
tel_tcc.c
> index 5e8b7f34b395..9943c43c06df 100644
> --- a/drivers/thermal/intel/intel_tcc.c
> +++ b/drivers/thermal/intel/intel_tcc.c
> @@ -6,8 +6,170 @@
>
>  #include <linux/errno.h>
>  #include <linux/intel_tcc.h>
> +#include <asm/cpu_device_id.h>
> +#include <asm/intel-family.h>
>  #include <asm/msr.h>
>
> +/**
> + * struct temp_masks - Bitmasks for temperature readings
> + * @tcc_offset:                        TCC offset in MSR_TEMPERATURE_TAR=
GET
> + * @digital_readout:           Digital readout in MSR_IA32_THERM_STATUS
> + * @pkg_digital_readout:       Digital readout in MSR_IA32_PACKAGE_THERM=
_STATUS
> + *
> + * Bitmasks to extract the fields of the MSR_TEMPERATURE and IA32_[PACKA=
GE]_
> + * THERM_STATUS registers for different processor models.
> + *
> + * The bitmask of TjMax is not included in this structure. It is always =
0xff.
> + */
> +struct temp_masks {
> +       u32 tcc_offset;
> +       u32 digital_readout;
> +       u32 pkg_digital_readout;
> +};
> +
> +#define TCC_MODEL_TEMP_MASKS(model, _tcc_offset, _digital_readout,     \
> +                            _pkg_digital_readout)                      \
> +       static const struct temp_masks temp_##model __initconst =3D {    =
 \
> +               .tcc_offset =3D _tcc_offset,                             =
 \
> +               .digital_readout =3D _digital_readout,                   =
 \
> +               .pkg_digital_readout =3D _pkg_digital_readout            =
 \
> +       }
> +
> +TCC_MODEL_TEMP_MASKS(nehalem, 0, 0x7f, 0x7f);
> +TCC_MODEL_TEMP_MASKS(haswell_x, 0xf, 0x7f, 0x7f);
> +TCC_MODEL_TEMP_MASKS(broadwell, 0x3f, 0x7f, 0x7f);
> +TCC_MODEL_TEMP_MASKS(goldmont, 0x7f, 0x7f, 0x7f);
> +TCC_MODEL_TEMP_MASKS(tigerlake, 0x3f, 0xff, 0xff);
> +TCC_MODEL_TEMP_MASKS(sapphirerapids, 0x3f, 0x7f, 0xff);
> +
> +/* Use these masks for processors not included in @tcc_cpu_ids. */
> +static struct temp_masks intel_tcc_temp_masks __ro_after_init =3D {
> +       .tcc_offset =3D 0x7f,
> +       .digital_readout =3D 0xff,
> +       .pkg_digital_readout =3D 0xff,
> +};
> +
> +static const struct x86_cpu_id intel_tcc_cpu_ids[] __initconst =3D {
> +       X86_MATCH_INTEL_FAM6_MODEL(CORE_YONAH,          &temp_nehalem),
> +       X86_MATCH_INTEL_FAM6_MODEL(CORE2_MEROM,         &temp_nehalem),
> +       X86_MATCH_INTEL_FAM6_MODEL(CORE2_MEROM_L,       &temp_nehalem),
> +       X86_MATCH_INTEL_FAM6_MODEL(CORE2_PENRYN,        &temp_nehalem),
> +       X86_MATCH_INTEL_FAM6_MODEL(CORE2_DUNNINGTON,    &temp_nehalem),
> +       X86_MATCH_INTEL_FAM6_MODEL(NEHALEM,             &temp_nehalem),
> +       X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_G,           &temp_nehalem),
> +       X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_EP,          &temp_nehalem),
> +       X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_EX,          &temp_nehalem),
> +       X86_MATCH_INTEL_FAM6_MODEL(WESTMERE,            &temp_nehalem),
> +       X86_MATCH_INTEL_FAM6_MODEL(WESTMERE_EP,         &temp_nehalem),
> +       X86_MATCH_INTEL_FAM6_MODEL(WESTMERE_EX,         &temp_nehalem),
> +       X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE,         &temp_nehalem),
> +       X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X,       &temp_nehalem),
> +       X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE,           &temp_nehalem),
> +       X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE_X,         &temp_haswell_x),
> +       X86_MATCH_INTEL_FAM6_MODEL(HASWELL,             &temp_nehalem),
> +       X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X,           &temp_haswell_x),
> +       X86_MATCH_INTEL_FAM6_MODEL(HASWELL_L,           &temp_nehalem),
> +       X86_MATCH_INTEL_FAM6_MODEL(HASWELL_G,           &temp_nehalem),
> +       X86_MATCH_INTEL_FAM6_MODEL(BROADWELL,           &temp_broadwell),
> +       X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_G,         &temp_broadwell),
> +       X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,         &temp_haswell_x),
> +       X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D,         &temp_haswell_x),
> +       X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,           &temp_broadwell),
> +       X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,             &temp_broadwell),
> +       X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,           &temp_haswell_x),
> +       X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,          &temp_broadwell),
> +       X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,            &temp_broadwell),
> +       X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,           &temp_broadwell),
> +       X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,         &temp_broadwell),
> +       X86_MATCH_INTEL_FAM6_MODEL(CANNONLAKE_L,        &temp_broadwell),
> +       X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,           &temp_broadwell),
> +       X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,           &temp_broadwell),
> +       X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,             &temp_broadwell),
> +       X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,           &temp_broadwell),
> +       X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_NNPI,        &temp_broadwell),
> +       X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,          &temp_broadwell),
> +       X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,         &temp_tigerlake),
> +       X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,           &temp_tigerlake),
> +       X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,    &temp_sapphirerap=
ids),
> +       X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,     &temp_sapphirerap=
ids),
> +       X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,           &temp_broadwell),
> +       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,           &temp_tigerlake),
> +       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,         &temp_tigerlake),
> +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,          &temp_tigerlake),
> +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &temp_tigerlake),
> +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,        &temp_tigerlake),
> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_BONNELL,        &temp_nehalem),
> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_BONNELL_MID,    &temp_nehalem),
> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_SALTWELL,       &temp_nehalem),
> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_SALTWELL_MID,   &temp_nehalem),
> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,     &temp_broadwell),
> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_D,   &temp_broadwell),
> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID, &temp_broadwell),
> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,        &temp_broadwell),
> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT_MID,    &temp_broadwell),
> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT_NP,     &temp_broadwell),
> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,       &temp_goldmont),
> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,     &temp_goldmont),
> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,  &temp_goldmont),
> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,      &temp_broadwell),
> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,        &temp_broadwell),
> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,      &temp_broadwell),
> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,      &temp_tigerlake),
> +       X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,        &temp_broadwell),
> +       X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,        &temp_broadwell),
> +       {}
> +};
> +
> +static int __init intel_tcc_init(void)
> +{
> +       const struct x86_cpu_id *id;
> +
> +       id =3D x86_match_cpu(intel_tcc_cpu_ids);
> +       if (id)
> +               memcpy(&intel_tcc_temp_masks, (const void *)id->driver_da=
ta,
> +                      sizeof(intel_tcc_temp_masks));
> +
> +       return 0;
> +}
> +/*
> + * Use subsys_initcall to ensure temperature bitmasks are initialized be=
fore
> + * the drivers that use this library.
> + */
> +subsys_initcall(intel_tcc_init);
> +
> +/**
> + * intel_tcc_get_offset_mask() - Returns the bitmask to read TCC offset
> + *
> + * Get the model-specific bitmask to extract TCC_OFFSET from the MSR
> + * TEMPERATURE_TARGET register. If the mask is 0, it means the processor=
 does
> + * not support TCC offset.
> + *
> + * Return: The model-specific bitmask for TCC offset.
> + */
> +u32 intel_tcc_get_offset_mask(void)
> +{
> +       return intel_tcc_temp_masks.tcc_offset;
> +}
> +EXPORT_SYMBOL_NS(intel_tcc_get_offset_mask, INTEL_TCC);
> +
> +/**
> + * get_temp_mask() - Returns the model-specific bitmask for temperature
> + *
> + * @pkg: true: Package Thermal Sensor. false: Core Thermal Sensor.
> + *
> + * Get the model-specific bitmask to extract the temperature reading fro=
m the
> + * MSR_IA32_[PACKAGE]_THERM_STATUS register.
> + *
> + * Callers must check if the thermal status registers are supported.
> + *
> + * Return: The model-specific bitmask for temperature reading
> + */
> +static u32 get_temp_mask(bool pkg)
> +{
> +       return pkg ? intel_tcc_temp_masks.pkg_digital_readout :
> +              intel_tcc_temp_masks.digital_readout;
> +}
> +
>  /**
>   * intel_tcc_get_tjmax() - returns the default TCC activation Temperatur=
e
>   * @cpu: cpu that the MSR should be run on, nagative value means any cpu=
.
> @@ -56,7 +218,7 @@ int intel_tcc_get_offset(int cpu)
>         if (err)
>                 return err;
>
> -       return (low >> 24) & 0x3f;
> +       return (low >> 24) & intel_tcc_temp_masks.tcc_offset;
>  }
>  EXPORT_SYMBOL_NS_GPL(intel_tcc_get_offset, INTEL_TCC);
>
> @@ -76,7 +238,10 @@ int intel_tcc_set_offset(int cpu, int offset)
>         u32 low, high;
>         int err;
>
> -       if (offset < 0 || offset > 0x3f)
> +       if (!intel_tcc_temp_masks.tcc_offset)
> +               return -ENODEV;
> +
> +       if (offset < 0 || offset > intel_tcc_temp_masks.tcc_offset)
>                 return -EINVAL;
>
>         if (cpu < 0)
> @@ -90,7 +255,7 @@ int intel_tcc_set_offset(int cpu, int offset)
>         if (low & BIT(31))
>                 return -EPERM;
>
> -       low &=3D ~(0x3f << 24);
> +       low &=3D ~(intel_tcc_temp_masks.tcc_offset << 24);
>         low |=3D offset << 24;
>
>         if (cpu < 0)
> @@ -113,8 +278,8 @@ EXPORT_SYMBOL_NS_GPL(intel_tcc_set_offset, INTEL_TCC)=
;
>   */
>  int intel_tcc_get_temp(int cpu, int *temp, bool pkg)
>  {
> -       u32 low, high;
>         u32 msr =3D pkg ? MSR_IA32_PACKAGE_THERM_STATUS : MSR_IA32_THERM_=
STATUS;
> +       u32 low, high, mask;
>         int tjmax, err;
>
>         tjmax =3D intel_tcc_get_tjmax(cpu);
> @@ -132,7 +297,9 @@ int intel_tcc_get_temp(int cpu, int *temp, bool pkg)
>         if (!(low & BIT(31)))
>                 return -ENODATA;
>
> -       *temp =3D tjmax - ((low >> 16) & 0x7f);
> +       mask =3D get_temp_mask(pkg);
> +
> +       *temp =3D tjmax - ((low >> 16) & mask);
>
>         return 0;
>  }
> diff --git a/include/linux/intel_tcc.h b/include/linux/intel_tcc.h
> index 8ff8eabb4a98..fa788817acfc 100644
> --- a/include/linux/intel_tcc.h
> +++ b/include/linux/intel_tcc.h
> @@ -14,5 +14,6 @@ int intel_tcc_get_tjmax(int cpu);
>  int intel_tcc_get_offset(int cpu);
>  int intel_tcc_set_offset(int cpu, int offset);
>  int intel_tcc_get_temp(int cpu, int *temp, bool pkg);
> +u32 intel_tcc_get_offset_mask(void);
>
>  #endif /* __INTEL_TCC_H__ */
> --

This clashes with the Tony Luck's rework of Intel CPU model defines
(see https://lore.kernel.org/lkml/20240430164913.73473-1-tony.luck@intel.co=
m/),
so I'd rather defer it until commit 2eda374e883a ("x86/mm: Switch to
new Intel CPU model defines") reaches the mainline and make it use the
new CPU model defines from the start.


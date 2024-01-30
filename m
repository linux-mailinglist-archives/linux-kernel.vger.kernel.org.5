Return-Path: <linux-kernel+bounces-44699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC37384262B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987DD28CF72
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD1B6BB54;
	Tue, 30 Jan 2024 13:26:28 +0000 (UTC)
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8087166B51;
	Tue, 30 Jan 2024 13:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706621187; cv=none; b=h6D5osBGsQpBTS3PmZW7D/b3KPqRwiHNjubfadIcVYh8G/8j3ooGXWKuAPgac1ZWSFwhz9web3KD3WSIMp1eSSGoEsvS6tzv5LY7O19afvzhcibkC5QgqDzDom3t5qvskKAXWSWkm+aLMdhKciPYIqw6ReEQ0Rcl+6N5Sh1AXV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706621187; c=relaxed/simple;
	bh=PF8CAVL4rEFi9w1ZE/f1iolLbWvY7zhJk9STs3r80is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N0yvkbiH163MfGwzMAG02tBzSRNBrhNVgWY2VMX7Vi1Xw9VcLgPEvZzB7F6rKakLEd8uBrxHvHE/a+HdUytPbSyrrVIPI/OTp7Solbxj+6UKucSm5pkUjqk/E/Zlq9a9WAnZkoPhBeHVxr6+2apCmW9ZB2BcRE/5gyQlPF9EWZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-20536d5c5c7so2476396fac.2;
        Tue, 30 Jan 2024 05:26:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706621184; x=1707225984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twRUHDzS8w4WKfQKLf30GrMRPHMUcxhF058BULLzw1Q=;
        b=T6Cbm5Ook6mzsNmevwT8X4ViTMwLLVkIH0jpqoJ/aPWw1vluaiHZtpervNJaen8zcm
         y7Efb7Xb2Vkhub8H6rKHu6MlvhKDuADkh5Rd1patBG8UmmQb/oVO3+1Z2qJNnoEgMIT2
         oTf2/N+RwjflCSfPRKOkBwD8p4mGUACjTaJnp31A86EFu4bGBcTta8XNs+YgZlIChcjl
         pOT6mMHsGtLk1gAjOHLN1//0jGexPdprqSjhybqPGBYZ4aKtk6TM6Zp37oG7Lx3CKyII
         LMpuqCF7v9GGpbGf72DmfkSblZI5nWUaq4MnLvaD3qkA/X0qexTcz8vzqD0hAAMvsnB/
         8SjA==
X-Gm-Message-State: AOJu0YwtLR6zeQFQ/D4pXEeu0G868bKNtBkuK1ms1DEUVj2KzvDDxzP7
	xICod1VpcLWfWNGK0SwPTn0WOkLAMRDK8YUCJKVePsSSac7wozFDKJaZucMj8KY=
X-Google-Smtp-Source: AGHT+IGgq38bhoeG59BH65Ja8KFWXHL5iTihljLt3Fjpux1S3N8uNoMeFoWUPjhw0kO2fb2gO1QH5A==
X-Received: by 2002:a05:6871:8191:b0:218:61af:1c75 with SMTP id so17-20020a056871819100b0021861af1c75mr5223962oab.37.1706621184274;
        Tue, 30 Jan 2024 05:26:24 -0800 (PST)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com. [209.85.210.41])
        by smtp.gmail.com with ESMTPSA id n13-20020a9d4d0d000000b006e11d51d04csm1292201otf.18.2024.01.30.05.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 05:26:23 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6dde5d308c6so2643387a34.0;
        Tue, 30 Jan 2024 05:26:23 -0800 (PST)
X-Received: by 2002:a9d:6a8e:0:b0:6dd:e8d5:9afb with SMTP id
 l14-20020a9d6a8e000000b006dde8d59afbmr5897353otq.3.1706621183706; Tue, 30 Jan
 2024 05:26:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130111250.185718-1-angelogioacchino.delregno@collabora.com> <20240130111250.185718-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240130111250.185718-3-angelogioacchino.delregno@collabora.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jan 2024 14:26:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUKXwxAKgtmgMxj+y-8GBWBLWC=ROP31uStTnfLDx6OLQ@mail.gmail.com>
Message-ID: <CAMuHMdUKXwxAKgtmgMxj+y-8GBWBLWC=ROP31uStTnfLDx6OLQ@mail.gmail.com>
Subject: Re: [PATCH v1 02/18] thermal: Add new structures and thermal_zone_device_register()
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: daniel.lezcano@linaro.org, miquel.raynal@bootlin.com, rafael@kernel.org, 
	rui.zhang@intel.com, lukasz.luba@arm.com, support.opensource@diasemi.com, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-imx@nxp.com, andersson@kernel.org, 
	konrad.dybcio@linaro.org, amitk@kernel.org, thara.gopinath@gmail.com, 
	niklas.soderlund@ragnatech.se, srinivas.pandruvada@linux.intel.com, 
	baolin.wang@linux.alibaba.com, u.kleine-koenig@pengutronix.de, 
	hayashi.kunihiko@socionext.com, d-gole@ti.com, linus.walleij@linaro.org, 
	DLG-Adam.Ward.opensource@dm.renesas.com, error27@gmail.com, heiko@sntech.de, 
	hdegoede@redhat.com, jernej.skrabec@gmail.com, f.fainelli@gmail.com, 
	bchihi@baylibre.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Angelo,

On Tue, Jan 30, 2024 at 12:13=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
> In preparation for extending the thermal zone devices to actually
> have a name and disambiguate thermal zone types/names, and to do
> a reorganization in thermal_zone_device, add some new Thermal Zone
> structures:
>
> Introduce new thermal_governor_params, thermal_zone_platform_params
> and thermal_zone_device_params structures which are meant to hold
> the parameters for thermal zone registration and, in the future, to
> stop having a catch-all thermal_zone_device structure.
>
> While at it, also add a new thermal_zone_device_register() function
> which uses the new structure(s) for registration;
> the now old functions thermal_tripless_zone_device_register() and
> thermal_zone_device_register_with_trips() are now advertised as
> being deprecated and changed to instead act as wrappers around the
> new thermal_zone_device_register().
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Thanks for your patch!

> ---
>  drivers/thermal/gov_power_allocator.c |  38 +++----
>  drivers/thermal/qcom/tsens.c          |   4 +-
>  drivers/thermal/thermal_core.c        | 146 ++++++++++++++++++--------
>  drivers/thermal/thermal_helpers.c     |   8 +-
>  drivers/thermal/thermal_sysfs.c       |  16 +--
>  include/linux/thermal.h               |  73 +++++++++++--
>  6 files changed, 202 insertions(+), 83 deletions(-)

This also needs an update to the documentation, which still refers to
the old function removed in commit edd220b33f479cf9 ("thermal: core:
Drop thermal_zone_device_register()") in v6.6.:

Documentation/driver-api/thermal/power_allocator.rst:`thermal_zone_device_r=
egister()`
Documentation/driver-api/thermal/power_allocator.rst:`thermal_zone_device_r=
egister()`
(i.e., platform code), then weights
Documentation/driver-api/thermal/sysfs-api.rst:
*thermal_zone_device_register(char *type,

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


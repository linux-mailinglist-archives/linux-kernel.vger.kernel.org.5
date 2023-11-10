Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE6B7E7E43
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344152AbjKJRmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjKJRlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:41:53 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B5342C27
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 09:01:51 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1f066fc2a28so1187304fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 09:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699635711; x=1700240511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMrYZbRlgCXN0jdJWgsU4bTo4xTt1FXQt6GOccDcYUQ=;
        b=ItN7kX3/CuRvB0MH+zoAN3i7E+huuMVkzGLkLS8+VrRPWKKUkDoax/abFFzU4fLATm
         +Nnfr3DOFiYpejkkJZKXzqXX6MKRyu6fKombrUyU0vjDykgxBEWNqBt0XY7QEeVekAJd
         TbTKI3ARIYrgxlZ1KM6iut1uZ/CYvYleB3qVE8/qyEAaS4Vrk0F8PU6yxxztW1th9xLP
         JcXccy09v3zjv2XQuQFIgyRtGLhyT2IuCYhHDijNm1Azu6LgeeCSihXHL47KtIUvM4Sx
         hFFF8GdoVdIf3XMFQ1uG7pv3sasSZZoZddLID+MRnoVBkDsyvV/cHwrn7XSzaRYX5Xfz
         LG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699635711; x=1700240511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMrYZbRlgCXN0jdJWgsU4bTo4xTt1FXQt6GOccDcYUQ=;
        b=i8s8sEUq3T9y/f8Sxgdsj1Rd5yOD7s+mYVI+4mwl6+POzc7JmDsuQ1jnpOFpWDrGpR
         u/RGal6SAAS/4sf0RXI26s+Mwq1L5yU82KU40OKvXU9R4tJveUqryD6chYV+I1Z/mc0r
         GEaUe4iRDQkfFGcnyihaxYh/pf9f8y0EgdVqPrZm3ZyN47C5GQjMntTiGnTPjUwTnTVT
         mtwnNtHAk6SdOck/WAbo7oucFuY9gxTlgqGirs+wyiwcjC5qoPDLckvA6P0GToWXOqa1
         6DnEE/5wdMpvbWw7hCorf6bEimH4WVYfpTQkloGSDXuCwBuBJqSATC7+aXC5t5JgrAWw
         iD2A==
X-Gm-Message-State: AOJu0YzgopRjN0KQ08WHV5BpTYqSWmK2UwDu/XUMgT70xUYGGyte+uVb
        5X8yiHgHiE+ZLqRbf5ULAkFxxWgiKbtU4LTLr/Y=
X-Google-Smtp-Source: AGHT+IFl+/Nl/Vd6SMC08TbrrJikc5Cwz1liEKDu9OSvpC5Ug3/XWtCFUFE0q3JqNBokWuXM1Cv+CweVjxik2T5qJ+E=
X-Received: by 2002:a05:6870:1090:b0:1f0:d96:8d9f with SMTP id
 16-20020a056870109000b001f00d968d9fmr7573876oaq.57.1699635710907; Fri, 10 Nov
 2023 09:01:50 -0800 (PST)
MIME-Version: 1.0
References: <20231110155548.20599-1-andrealmeid@igalia.com>
In-Reply-To: <20231110155548.20599-1-andrealmeid@igalia.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 10 Nov 2023 12:01:39 -0500
Message-ID: <CADnq5_MOQXiUkyobpuEAnNmcX2jFbEvva+1bm4hrRQ0aguPFag@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Document device reset methods
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, alexander.deucher@amd.com,
        ray.huang@amd.com, christian.koenig@amd.com, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 10:56=E2=80=AFAM Andr=C3=A9 Almeida <andrealmeid@ig=
alia.com> wrote:
>
> Document what each amdgpu driver reset method does.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index a79d53bdbe13..500f86c79eb7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -504,6 +504,26 @@ struct amdgpu_allowed_register_entry {
>         bool grbm_indexed;
>  };
>
> +/**
> + * enum amd_reset_method - Methods for resetting AMD GPU devices
> + *
> + * @AMD_RESET_METHOD_NONE: The device will not be reset.
> + * @AMD_RESET_LEGACY: Method reserved for SI/CIK asics.

This also applies to VI asics.

> + * @AMD_RESET_MODE0: High level PCIe reset.

Resets the entire ASIC.  Here for completeness, but not actually
available to the driver.

> + * @AMD_RESET_MODE1: Resets each IP block (SDMA, GFX, VCN, etc.) individ=
ually.
> + *                   Suitable only for some discrete GPUs.

Resets all IPs on the asic.  Not available on all asics.

> + * @AMD_RESET_MODE2: Resets only the GFX block. Useful for APUs, giving =
that
> + *                   the rest of IP blocks and SMU is shared with the CP=
U.

Resets a lesser level of IPs compared to MODE1.  Which IPs are reset
depends on the asic.  Notably doesn't reset IPs shared with the CPU on
APUs or the memory controllers (so VRAM is not lost).  Not available
on all asics.

> + * @AMD_RESET_BACO: BACO (Bus Alive, Chip Off) method powers off and on =
the card
> + *                  but without powering off the PCI bus. Suitable only =
for
> + *                  discrete GPUs.
> + * @AMD_RESET_PCI: Does a full bus reset, including powering on and off =
the
> + *                 card.

This calls into the core Linux PCI reset code and does a secondary bus
reset or FLR, depending on what the underlying hardware supports.

> + *
> + * Methods available for AMD GPU driver for resetting the device. Not al=
l
> + * methods are suitable for every device. User can overwrite the method =
using
> + * module parameter `reset_method`.
> + */
>  enum amd_reset_method {
>         AMD_RESET_METHOD_NONE =3D -1,
>         AMD_RESET_METHOD_LEGACY =3D 0,
> --
> 2.42.1
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDC57EE80C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 21:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjKPUBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 15:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjKPUBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 15:01:35 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A88B1A8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 12:01:32 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1f066fc2a28so637310fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 12:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700164891; x=1700769691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5F/bRACSm+KB9HqCPptTC4wnPimDAu4Tx2OSkrkdoQs=;
        b=Jm9oQWkY4Bt6SErZaI2O/D5YHn8wOOJE8VFKHqS0KUS9G/x9s3uPkF6H0VBRT6//lw
         Bci7gm2GNmiK7YAtThzwjNjthwYxlIl9lb6Cw4hP0lPM0qa8YC9yKcTxDNM1l9L2tDyW
         TF0yCwRvlfI2LCgfjvJK2CQKqC8ytqCIMK/wE8we0idjz+HqWQJ3+odhkN1CRU/TkW/p
         QG821Fk4wgMMtyxWbOri6NXS+gex7tjOX5GzIbtbTcV8E50X4jxWrOREn8Chmm0bRtqF
         eNKOgpZI70WkE9FtHMr9tgntJau8b7eCbOyc5rq48YK8Ahc3d1Ppgf5jvE8wkYXzBnT2
         SEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700164891; x=1700769691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5F/bRACSm+KB9HqCPptTC4wnPimDAu4Tx2OSkrkdoQs=;
        b=I/o9ryp17uvOlUFka7FaL7NQa1uyIrmzYm1agHS+RciluUbN7D4D58tZJa0av+VPoN
         yb697VvhJaNuWdQXdMfgVD7+oeg9Pzuw566eG7Cu+fDWfvabk9TEWDe2mkCJ2+6IE0KN
         /HgHR0CjcoFiCqLrC6kFY4nBWIiz6mMQWYqjRv5N0iet8BXJVMw96gqd6KXSmChbzple
         iy4WnKXoM5htnW+YzrGVYVU7XZ84n79FXphQwyzUWm8qCCf4T9IDlBiLUJDHwuRCr5JQ
         NSNT7nlyDgqONMe4DZgOnjUddrz7xgBcMEDhrwmyE5trx55I4Rj3djxOA79tG3x0dGi3
         9Uhw==
X-Gm-Message-State: AOJu0YxCm+aaJ8pwncGxCC7acJIcjroABinp9LfdylUgLhcdnDupRPFM
        ulK8HO7f8r6c9alLdlvKwaSDgaoCqIgaWysYohc=
X-Google-Smtp-Source: AGHT+IFIN8bwGRrQxflEzWWxXE5Gr3CVLYY+pkoS2zfF+G1/FFhZzzoNEh8/iT12Y98vW/4ZjMSvtf3sxtGvLbdDprc=
X-Received: by 2002:a05:6870:e85:b0:1e9:cdad:4903 with SMTP id
 mm5-20020a0568700e8500b001e9cdad4903mr20368203oab.50.1700164891382; Thu, 16
 Nov 2023 12:01:31 -0800 (PST)
MIME-Version: 1.0
References: <20231110172328.27451-1-andrealmeid@igalia.com>
In-Reply-To: <20231110172328.27451-1-andrealmeid@igalia.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 16 Nov 2023 15:01:19 -0500
Message-ID: <CADnq5_P9Kpw3_eVaEc_g8E3viTYT=JVvpqOVPV_CEYH8oaJEig@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd: Document device reset methods
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

On Fri, Nov 10, 2023 at 12:23=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@ig=
alia.com> wrote:
>
> Document what each amdgpu driver reset method does.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Applied with Randy's suggestion.  Thanks!

Alex

> ---
> v2: Add more details and small correction (Alex)
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index a79d53bdbe13..c4675572f907 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -504,6 +504,31 @@ struct amdgpu_allowed_register_entry {
>         bool grbm_indexed;
>  };
>
> +/**
> + * enum amd_reset_method - Methods for resetting AMD GPU devices
> + *
> + * @AMD_RESET_METHOD_NONE: The device will not be reset.
> + * @AMD_RESET_LEGACY: Method reserved for SI, CIK and VI ASICs.
> + * @AMD_RESET_MODE0: Reset the entire ASIC. Not currently available for =
the
> + *                   any device.
> + * @AMD_RESET_MODE1: Resets all IP blocks on the ASIC (SDMA, GFX, VCN, e=
tc.)
> + *                   individually. Suitable only for some discrete GPU, =
not
> + *                   available for all ASICs.
> + * @AMD_RESET_MODE2: Resets a lesser level of IPs compared to MODE1. Whi=
ch IPs
> + *                   are reset depends on the ASIC. Notably doesn't rese=
t IPs
> + *                   shared with the CPU on APUs or the memory controlle=
rs (so
> + *                   VRAM is not lost). Not available on all ASICs.
> + * @AMD_RESET_BACO: BACO (Bus Alive, Chip Off) method powers off and on =
the card
> + *                  but without powering off the PCI bus. Suitable only =
for
> + *                  discrete GPUs.
> + * @AMD_RESET_PCI: Does a full bus reset using core Linux subsystem PCI =
reset
> + *                 and does a secondary bus reset or FLR, depending on w=
hat the
> + *                 underlying hardware supports.
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

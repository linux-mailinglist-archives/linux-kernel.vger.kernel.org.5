Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FDE772C96
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjHGRSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjHGRSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:18:35 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6BD1A3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:18:10 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6bca88c3487so3942732a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428689; x=1692033489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XV34gRN59NUXgPyKRqnl/Sn4kJFEpMQBDpWvtbTAeLk=;
        b=c8QS/POYZDVCy+zrr7lKWNWXC1LM0EjzSsNlMdfGnQH3HUcEzwfacv4W3XGqZFp1Nx
         kqHHS3BhtciMnfLsrjTBDvV1/2qxBs4wDwzlquknrAjdmd5I3cvtcGCsX/TdtH0O/X7S
         b5LtGKzhVpfodzCbifmnJ1xF/tJTP/JljGD/n8+5hJD4r4ObNJCi3Bii09hyxjE4Gksc
         VnSElVbQDzM3AONVcHv0+RcIm8YZtPxMH6As44T9anuJXJEoE2OPNh81HFxgQmW3Zf9p
         wut85O+rkynHPJwkzc+kqz5QWNcuRbm4hPpji3ijwLl28N/8AqtN9DYT4OFiYZeshZli
         OHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428689; x=1692033489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XV34gRN59NUXgPyKRqnl/Sn4kJFEpMQBDpWvtbTAeLk=;
        b=SPjBvInV7JsRqqe4HapfBl5eicQfQ6n2MropWutYqzSVgE1b4jkaAFFuKUcgNhrGRf
         J2Uu776RTb7dvOs1+mKOBBGLSvWAE9Wat10PQImrVsMoUu54w1ntDLjEEF0FRmiMXamp
         aPmSe1IFQBneHiOocUVgezFydLr6Kf1FlyoGLTAsYkTyn35i9UuPzmwxcQrOfH2hMsxk
         RkyrivMotF2XqK5pjU9gMm6u1EY+GYpaeSEUabkl+x3ik7bn0psHm0HnIkZQ0a8YQpTu
         jksIqL8IozGE8dpxbTqmFhlkZ0aan0qitj8DfgYx3q7RkfR21hKbDKq55Wtxu+SOe8pF
         Avpg==
X-Gm-Message-State: AOJu0Yxvyno/72dXloLbVMiANRzk4WKgiLoAlB5f5qx6EMjoanhgLky3
        hD9hIJt0X6QDz0G7qXPMvhWsjA7Ia1yHVdwQnaQ=
X-Google-Smtp-Source: AGHT+IEqb0XN5+AviKjgEtzF5xxq33xiyN7TQ2h94ZssjX8/OEf4jSCH08clopGvmS9RGtf1fE6Uau80c6mGy5akoQA=
X-Received: by 2002:a05:6870:63a3:b0:1bb:a359:b909 with SMTP id
 t35-20020a05687063a300b001bba359b909mr11694940oap.55.1691428689591; Mon, 07
 Aug 2023 10:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230802064333.11895-1-sunran001@208suo.com>
In-Reply-To: <20230802064333.11895-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:17:58 -0400
Message-ID: <CADnq5_MmBnK5sq=LVfJa9hWyN23XQ=TRvw15ns28sm+G7E=9aA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Clean up errors in ih_v6_0.c
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Wed, Aug 2, 2023 at 2:43=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: trailing statements should be on next line
> ERROR: that open brace { should be on the previous line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/ih_v6_0.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/a=
mdgpu/ih_v6_0.c
> index 980b24120080..ec0c8f8b465a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> @@ -494,7 +494,8 @@ static int ih_v6_0_self_irq(struct amdgpu_device *ade=
v,
>                 *adev->irq.ih1.wptr_cpu =3D wptr;
>                 schedule_work(&adev->irq.ih1_work);
>                 break;
> -       default: break;
> +       default:
> +               break;
>         }
>         return 0;
>  }
> @@ -759,8 +760,7 @@ static void ih_v6_0_set_interrupt_funcs(struct amdgpu=
_device *adev)
>         adev->irq.ih_funcs =3D &ih_v6_0_funcs;
>  }
>
> -const struct amdgpu_ip_block_version ih_v6_0_ip_block =3D
> -{
> +const struct amdgpu_ip_block_version ih_v6_0_ip_block =3D {
>         .type =3D AMD_IP_BLOCK_TYPE_IH,
>         .major =3D 6,
>         .minor =3D 0,
> --
> 2.17.1
>

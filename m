Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD29772CA0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjHGRTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjHGRTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:19:21 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558241BC8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:19:18 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6bcae8c4072so3058043a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428757; x=1692033557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxEiyQxJR+MJn6mnDsJhhgZUCEoHOzUbkjiBn5UslYs=;
        b=CJFPzwNdpeWZ00IiOd46LHzzZB8tpxBsf7PXlc/iWTquMWvh99W6YkZJKzWz8pYp4y
         8+sd9+MYFbLL/5rv2SaeEeIUltjQ1DtiHoiyzjYNQ9qitCHfm2zpHqS87kNUdhXqFC5y
         YuIm9df9AutYhMFPD9fsuxr6SLBJyPj5xRKxzn5ZFV/eqyFT+l/z9nd+f4kWVKaAH00e
         0oTqPkLaiIPVaVDQIRZz+Fu+Jl7n1QEukHK29gavjXstwfImdeN9zKyA9SWhVv4WQtgU
         m35TQvTSHLGniBaWVLf071fYNICYHeWNQ2cZAGAv9rLcFBFbEItVTIBwlfeAtlm6dZ+m
         O4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428757; x=1692033557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxEiyQxJR+MJn6mnDsJhhgZUCEoHOzUbkjiBn5UslYs=;
        b=VLhEgrUraMiraaiOYRENwgDpk9skJGHJ2cWMJ0wEC+SF8sXX4GUIYgun7AHBR1bcHc
         EbA4tIl3V0U+s8FitjdK05Sew74/RfekJFoGfD3SyU/pE4ZUuTADSqTBX+pnEevmIt8J
         KuUkTXC/BfvFjFeiy8lv+wPP3vSRhuj6zmgFj46Ty3H29RXQsr7Mh0h3igVzBPK/Z2IM
         vRGs2O6Z2N9alpEhdd8p6SBq1VgVZ0ggD6aZAuSPeB1FtOL00idAtGCclAyn1qFQS0EQ
         Z8h2Bkx4A/D0P5SZaD5bWgWDosGCaMXNWYxXBBNflhl1jplUpgO/Z1v9A64GwIDyN7/p
         x5Hg==
X-Gm-Message-State: AOJu0YxU8Kg7IDxHYp5BLkrS69KG2I5kIVBEphd7a6g1eUd1hk67fAPe
        Gt2o/qop+7kYNmjpoc+UkibufKkf0FUPShN6rWU9YA55
X-Google-Smtp-Source: AGHT+IE3xOaBqhnOeAxi1epTXhzLf4kTnq1R2FU9Q8JoPuQt/opYkvKf7wmsBzImz5m6YitBN8F7A1a9PCUQ1DBl3kE=
X-Received: by 2002:a05:6871:151:b0:1ad:2b76:c3 with SMTP id
 z17-20020a056871015100b001ad2b7600c3mr9537798oab.39.1691428757637; Mon, 07
 Aug 2023 10:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230802064822.12093-1-sunran001@208suo.com>
In-Reply-To: <20230802064822.12093-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:19:06 -0400
Message-ID: <CADnq5_N_bSFmRtA-FuSCOUZo=+KijbPZ9w-OD37D=SPF9XZJSQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Clean up errors in mmhub_v9_4.c
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

On Wed, Aug 2, 2023 at 2:48=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: code indent should use tabs where possible
> ERROR: space required before the open parenthesis '('
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/am=
d/amdgpu/mmhub_v9_4.c
> index e790f890aec6..5718e4d40e66 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> @@ -108,7 +108,7 @@ static void mmhub_v9_4_setup_vm_pt_regs(struct amdgpu=
_device *adev, uint32_t vmi
>  }
>
>  static void mmhub_v9_4_init_system_aperture_regs(struct amdgpu_device *a=
dev,
> -                                                int hubid)
> +                                               int hubid)
>  {
>         uint64_t value;
>         uint32_t tmp;
> @@ -1568,7 +1568,7 @@ static int mmhub_v9_4_get_ras_error_count(struct am=
dgpu_device *adev,
>         uint32_t sec_cnt, ded_cnt;
>
>         for (i =3D 0; i < ARRAY_SIZE(mmhub_v9_4_ras_fields); i++) {
> -               if(mmhub_v9_4_ras_fields[i].reg_offset !=3D reg->reg_offs=
et)
> +               if (mmhub_v9_4_ras_fields[i].reg_offset !=3D reg->reg_off=
set)
>                         continue;
>
>                 sec_cnt =3D (value &
> --
> 2.17.1
>

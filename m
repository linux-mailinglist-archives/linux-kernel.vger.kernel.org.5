Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2CE772C8D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjHGRRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjHGRR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:17:28 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E0F1FE8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:17:03 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6bc886d1504so4297410a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428622; x=1692033422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gw1/lE3oDwvMAgGbwq37rEFlQSYTjYJZy4ndo+1nhtE=;
        b=PYa4DP2yxIeyhlwZu/rPWrm5u8/LOyHx8Wb3WN0mNHawTQHz5v9jXQbcEkNSE17cT0
         MwCCxHEXQUTYcwf1zR6JMVKl9Pai4WqzciT8CtwuX2/fLyJf/ZLONz9S3IpfBmyf6yEG
         eLWpw+x82hKB42Cox596LNm/VEkU61DbCvQwfpSWlq+1r1SOxbNMtNVc153qcrrntALf
         RY7xYgGqEv2I5XdwUXfA8V4RI9ipPdZqTO7kqi+R6xhPG4mil90QlRbVLk98WRhP8G53
         CFYX6xPVdYGlRN9q5CNRzxs+Ktrc6cmXcw9fx80NezPK8h1vgS5BiKzLXHGgcCvouVnh
         HQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428622; x=1692033422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gw1/lE3oDwvMAgGbwq37rEFlQSYTjYJZy4ndo+1nhtE=;
        b=OWKE+6bFUYn8kdgkk5dpAIdHV0lRXB3QOWUaKylb08NSq38Dpl4yEvE+ITjEUgIGtz
         Z/yg/jkJKCLrJNbIBdukI/P83ndXBqHci7Fryp5E1RCIomtcSAaQkK04N7mgykUufOXx
         xt0zCBmSKivgS73MklJVUu06rCSlZuQVCnchJmhNutLk0cvnCpLRNwUv3QcMoTFyCMr2
         iQNL1zSUOaBfojVvOvl5NLpOrlNkebmVACkTk/RGrtlmcLZTlxR8jm+He8OCbvSyfSpg
         9lG9t5cL2oWbJJCBLpyBLMHsHKjZfN0oh7gNjl75ULVn+z4SAuxHMv7/M3W1K10FkFaN
         bslg==
X-Gm-Message-State: AOJu0YygLxSNbUS0tHvFEgLgrA6unZWXuBq/w6BY5yB/d5dnFR3pmOF8
        5y2mV+/+QxlTyDpoQNdATRtYqKdCz0lsQOWe89H1H+O8
X-Google-Smtp-Source: AGHT+IEOzJSLELMOxOLp3WGomkZUhV4gON0TULeLPfu0jawep70yBs3PRuPqpq4e9U+cKPawF6dpxljuyAtFpqhp0kc=
X-Received: by 2002:a05:6871:82a:b0:1bf:174b:a17e with SMTP id
 q42-20020a056871082a00b001bf174ba17emr11432280oap.22.1691428622112; Mon, 07
 Aug 2023 10:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230802063742.11697-1-sunran001@208suo.com>
In-Reply-To: <20230802063742.11697-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:16:51 -0400
Message-ID: <CADnq5_PFn8bsHGJw0s72VuAMo4UWx_Rr=1dZ_=hOD3cpQvzNpQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Clean up errors in vce_v3_0.c
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Wed, Aug 2, 2023 at 2:38=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: that open brace { should be on the previous line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vce_v3_0.c
> index 8def62c83ffd..18f6e62af339 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -998,8 +998,7 @@ static void vce_v3_0_set_irq_funcs(struct amdgpu_devi=
ce *adev)
>         adev->vce.irq.funcs =3D &vce_v3_0_irq_funcs;
>  };
>
> -const struct amdgpu_ip_block_version vce_v3_0_ip_block =3D
> -{
> +const struct amdgpu_ip_block_version vce_v3_0_ip_block =3D {
>         .type =3D AMD_IP_BLOCK_TYPE_VCE,
>         .major =3D 3,
>         .minor =3D 0,
> @@ -1007,8 +1006,7 @@ const struct amdgpu_ip_block_version vce_v3_0_ip_bl=
ock =3D
>         .funcs =3D &vce_v3_0_ip_funcs,
>  };
>
> -const struct amdgpu_ip_block_version vce_v3_1_ip_block =3D
> -{
> +const struct amdgpu_ip_block_version vce_v3_1_ip_block =3D {
>         .type =3D AMD_IP_BLOCK_TYPE_VCE,
>         .major =3D 3,
>         .minor =3D 1,
> @@ -1016,8 +1014,7 @@ const struct amdgpu_ip_block_version vce_v3_1_ip_bl=
ock =3D
>         .funcs =3D &vce_v3_0_ip_funcs,
>  };
>
> -const struct amdgpu_ip_block_version vce_v3_4_ip_block =3D
> -{
> +const struct amdgpu_ip_block_version vce_v3_4_ip_block =3D {
>         .type =3D AMD_IP_BLOCK_TYPE_VCE,
>         .major =3D 3,
>         .minor =3D 4,
> --
> 2.17.1
>

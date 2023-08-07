Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DD3772D04
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjHGRbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjHGRbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:31:50 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36160F9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:31:49 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1bb58b4c513so3543850fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691429508; x=1692034308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=076JJ4vvpe4Hogv09ZSyczaDY6j365GFf7clQP3Kyy0=;
        b=GewKJ+7D2HxtJUE/e7HkEFFricw8bVIBD/teJv7aIGFHXpP2gzVksmcN2MLIF+U+zJ
         2Lav5ecR1WTKN0aY0PN9P4bINxdHc4iy2hDfuboyPTBsjEc/SVziNsL52Wcxg9gBdWUr
         Acsn3I/tVKkXyEHhbTNbFyBZUBMJaD9W4EzULF6BFsL1CL7i7RyyqotKpzti/ohQjmeI
         pVsUdgP/3qSThRXsHD9qqiPOSZMp/RzGGgM+N3vokzeTS311/Ky7e50BHYcVyBTD+9xo
         PhFWCvjJ3dunB+EgPwbHatoI2bNpcYNF6JecCNa4m3uvBlCrrGskk7T8u34LENzmJ1Je
         H5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691429508; x=1692034308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=076JJ4vvpe4Hogv09ZSyczaDY6j365GFf7clQP3Kyy0=;
        b=gKmHlIydykuCl1e8WMtU701CUNfH+nBlf8+HxhcpjmX/YFiiYO+9KAIQkkxIpiMTXY
         iSkgwT8QLl/mXGPivP/PduP25UciXqaz0q+gJoRP1VxcLFlw3hKyTl3RxBJx8qe1fCWI
         OrIVkdmIoGvhEGsCEqoB7uk/SWx7nzVVjGpG5bI5meSxIfzIPbZ31/jZwg7U1212wr/P
         O96AdPdhiS8+iSsaPdMew2qcDg5mt5kV8uaWTqz+DsmlpQD3YJss3HAzooaGUK9pkH9z
         8LNYVRmpzKkDJ+5Y0xfUmY00bnSKphZu59eksx6SHg+Q4Hd5Qr1RNiGceNZqICDvM7ZV
         MSkA==
X-Gm-Message-State: AOJu0YwX3VWaMJusKbVG0O/mHytz1RzDzWFOcaprg1RHt4wyeSDFr6Wd
        yQM/gnDvTeShoP7XDb0ri1U8NxQhstkH0ndOi3B0cQp+
X-Google-Smtp-Source: AGHT+IGp7pPKVqROyIZghJyysbYahTbYpKq7awECK6ZPckm/aCSYkRExkCDYPe43B6XSHWCqny+SrxAP2iyaZyJUZac=
X-Received: by 2002:a05:6871:6a9:b0:19f:2c0e:f865 with SMTP id
 l41-20020a05687106a900b0019f2c0ef865mr12265529oao.7.1691429508553; Mon, 07
 Aug 2023 10:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230802074315.13688-1-sunran001@208suo.com>
In-Reply-To: <20230802074315.13688-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:31:37 -0400
Message-ID: <CADnq5_PYnyF4JB5vWYydcWziaAyULWmxayZN6q+-iYnCBohO+A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Clean up errors in vcn_v4_0.c
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

On Wed, Aug 2, 2023 at 3:43=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> spaces required around that '=3D=3D' (ctx:VxV)
> ERROR: space required before the open parenthesis '('
> ERROR: that open brace { should be on the previous line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index 6089c7deba8a..ef5b16061e96 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1139,11 +1139,11 @@ static int vcn_v4_0_start(struct amdgpu_device *a=
dev)
>                                 if (status & 2)
>                                         break;
>                                 mdelay(10);
> -                               if (amdgpu_emu_mode=3D=3D1)
> +                               if (amdgpu_emu_mode =3D=3D 1)
>                                         msleep(1);
>                         }
>
> -                       if (amdgpu_emu_mode=3D=3D1) {
> +                       if (amdgpu_emu_mode =3D=3D 1) {
>                                 r =3D -1;
>                                 if (status & 2) {
>                                         r =3D 0;
> @@ -1959,7 +1959,7 @@ static int vcn_v4_0_set_powergating_state(void *han=
dle, enum amd_powergating_sta
>                 return 0;
>         }
>
> -       if(state =3D=3D adev->vcn.cur_state)
> +       if (state =3D=3D adev->vcn.cur_state)
>                 return 0;
>
>         if (state =3D=3D AMD_PG_STATE_GATE)
> @@ -1967,7 +1967,7 @@ static int vcn_v4_0_set_powergating_state(void *han=
dle, enum amd_powergating_sta
>         else
>                 ret =3D vcn_v4_0_start(adev);
>
> -       if(!ret)
> +       if (!ret)
>                 adev->vcn.cur_state =3D state;
>
>         return ret;
> @@ -2101,8 +2101,7 @@ static const struct amd_ip_funcs vcn_v4_0_ip_funcs =
=3D {
>         .set_powergating_state =3D vcn_v4_0_set_powergating_state,
>  };
>
> -const struct amdgpu_ip_block_version vcn_v4_0_ip_block =3D
> -{
> +const struct amdgpu_ip_block_version vcn_v4_0_ip_block =3D {
>         .type =3D AMD_IP_BLOCK_TYPE_VCN,
>         .major =3D 4,
>         .minor =3D 0,
> --
> 2.17.1
>

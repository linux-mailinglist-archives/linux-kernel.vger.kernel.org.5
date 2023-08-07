Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6317A772CB4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjHGRWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjHGRWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:22:20 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD5819B6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:22:01 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1bbaa549bcbso3627950fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428907; x=1692033707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YvbsUJg0/MEi6rG+cUpAFNtn5WudefBqhX2T15JqJg=;
        b=ed1lHmdV820f17A4KM8vckb+CtmsQK+h8Na/No7yS6n8rRy92/oVzmqcGTuD+zm0j5
         c6KO4c4ZAHIaUqTRd4Jq/QxdveAcVWJMMhhXWnoiUuHV2uDzmoWABAL4jtoVrkdieqdX
         DvdPuBSLG/NC+MaWVyhOnGIflKlJDmuptwkQKdi8xPk31LKQJYvTavYfbLb+05F5TGJ8
         FgvhEDtssv3/jG168DMsO04k23WP8HE2zjqt51dC5n3nl2zUvWVvqvLJUcahraUXX5ha
         Yztyi+jc5YLth7eArr7EZogtQITjFmR+8RcUYRJV51nHiFAkCVB2Lr+PZiu6uJ7ayhG/
         KVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428907; x=1692033707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YvbsUJg0/MEi6rG+cUpAFNtn5WudefBqhX2T15JqJg=;
        b=J1RgBesD24eXG4tlWsv05auCXrX+663ZCsVxU9yVhj+Gw47bRzCwGPMle8HXJ7KwCV
         ugVoWnGnPvYuEY+kAD5gvoAIK+kyNtRs0dfYuM0dOmF2ttdkuOCv/54bYCXJKdEuQzlL
         WpV59umRAJ8d7MZKGLx5DU+6N3/ygWMZvuuvJGG+tg4twAV5v2EKWidGgi2p9Jd8Dpyi
         u0VSHGPKs+r5x9j6JkuiRv71R+vK5kGrP0TU/pDXSEPB3xZurQMdgXeQyy7WDq2MzQVQ
         CUQ01ZnsKaCzfJebUDYZnkbx3uow6JJxI3Xg4qhkqf6gtatPXcayWxFJsDzKOveCCnag
         UreQ==
X-Gm-Message-State: AOJu0YxtDevzzB83RjQGJItdZzrrFNp9AVbMhb8Hi1N/1i1EHKJtf339
        QMMtpnu1bpcm125cR7fyW5v1l+GHkN9tBdf+YtY=
X-Google-Smtp-Source: AGHT+IHawkKgmlrHGsgRqcMkQZbxvKoqspEbzHp781Amg3VTbLYE3tUVZu5Y5/KQnXJrM1eeSgpKwe0EleAfxLnD29I=
X-Received: by 2002:a05:6870:c1cb:b0:1bf:4a66:d54f with SMTP id
 i11-20020a056870c1cb00b001bf4a66d54fmr11790002oad.56.1691428907356; Mon, 07
 Aug 2023 10:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230802065518.12271-1-sunran001@208suo.com>
In-Reply-To: <20230802065518.12271-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:21:36 -0400
Message-ID: <CADnq5_NOoz1ciFDqtbv54dRB2Bd_55sO-0kLnZXxBxxdT2cc_A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Clean up errors in amdgpu_cgs.c
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

Already fixed.

On Wed, Aug 2, 2023 at 2:55=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: switch and case should be at the same indent
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c | 64 ++++++++++++-------------
>  1 file changed, 32 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_cgs.c
> index 456e385333b6..fafe7057a8c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
> @@ -163,38 +163,38 @@ static uint16_t amdgpu_get_firmware_version(struct =
cgs_device *cgs_device,
>         uint16_t fw_version =3D 0;
>
>         switch (type) {
> -               case CGS_UCODE_ID_SDMA0:
> -                       fw_version =3D adev->sdma.instance[0].fw_version;
> -                       break;
> -               case CGS_UCODE_ID_SDMA1:
> -                       fw_version =3D adev->sdma.instance[1].fw_version;
> -                       break;
> -               case CGS_UCODE_ID_CP_CE:
> -                       fw_version =3D adev->gfx.ce_fw_version;
> -                       break;
> -               case CGS_UCODE_ID_CP_PFP:
> -                       fw_version =3D adev->gfx.pfp_fw_version;
> -                       break;
> -               case CGS_UCODE_ID_CP_ME:
> -                       fw_version =3D adev->gfx.me_fw_version;
> -                       break;
> -               case CGS_UCODE_ID_CP_MEC:
> -                       fw_version =3D adev->gfx.mec_fw_version;
> -                       break;
> -               case CGS_UCODE_ID_CP_MEC_JT1:
> -                       fw_version =3D adev->gfx.mec_fw_version;
> -                       break;
> -               case CGS_UCODE_ID_CP_MEC_JT2:
> -                       fw_version =3D adev->gfx.mec_fw_version;
> -                       break;
> -               case CGS_UCODE_ID_RLC_G:
> -                       fw_version =3D adev->gfx.rlc_fw_version;
> -                       break;
> -               case CGS_UCODE_ID_STORAGE:
> -                       break;
> -               default:
> -                       DRM_ERROR("firmware type %d do not have version\n=
", type);
> -                       break;
> +       case CGS_UCODE_ID_SDMA0:
> +               fw_version =3D adev->sdma.instance[0].fw_version;
> +               break;
> +       case CGS_UCODE_ID_SDMA1:
> +               fw_version =3D adev->sdma.instance[1].fw_version;
> +               break;
> +       case CGS_UCODE_ID_CP_CE:
> +               fw_version =3D adev->gfx.ce_fw_version;
> +               break;
> +       case CGS_UCODE_ID_CP_PFP:
> +               fw_version =3D adev->gfx.pfp_fw_version;
> +               break;
> +       case CGS_UCODE_ID_CP_ME:
> +               fw_version =3D adev->gfx.me_fw_version;
> +               break;
> +       case CGS_UCODE_ID_CP_MEC:
> +               fw_version =3D adev->gfx.mec_fw_version;
> +               break;
> +       case CGS_UCODE_ID_CP_MEC_JT1:
> +               fw_version =3D adev->gfx.mec_fw_version;
> +               break;
> +       case CGS_UCODE_ID_CP_MEC_JT2:
> +               fw_version =3D adev->gfx.mec_fw_version;
> +               break;
> +       case CGS_UCODE_ID_RLC_G:
> +               fw_version =3D adev->gfx.rlc_fw_version;
> +               break;
> +       case CGS_UCODE_ID_STORAGE:
> +               break;
> +       default:
> +               DRM_ERROR("firmware type %d do not have version\n", type)=
;
> +               break;
>         }
>         return fw_version;
>  }
> --
> 2.17.1
>

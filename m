Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEE4772C07
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjHGRGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHGRGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:06:34 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D490C2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:06:34 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a5ad21a1f9so3288196b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691427993; x=1692032793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLDScHjDjgU2dNICfgHVvNlYK9Try5et+YRqhYmFBk8=;
        b=PmPoOrMbUmYQQrA9L1loL6tAuljo1As/0pfzu0hEDaxMvt9Up4xwA33Y93eVRpgMYh
         OoAOjU5mtSvy6MLa9AdD2J5m1XbKuA0yUb/xekLsq2iDcstvbRf8CTkDVhfxMgXZXExo
         jDux+z+pyp/XqhHuvG5rTxfcPAQfPInoEg4qeS5hXPUQHiQMyT750PO/d1+bdEXrWlB5
         i6ghH+VSnlxra+4x1pDlWCSh8Rx+COJOBgSztGbrDdBSP7P9lbvg7V1jO8IjxpSt7NcA
         eYg+OMcJzB91+vXBNbh26ajkbc/giHF6rWT8Ulxlqdk5qmZBpS8OVJlxRG7xjMmtpbmt
         f24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691427993; x=1692032793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLDScHjDjgU2dNICfgHVvNlYK9Try5et+YRqhYmFBk8=;
        b=ESGJYgCDKVjyDvRewwQV6fuxv192Y8YKa5P0jg7fUKuOwHFSBHQh9r0rCpdSXQLRPW
         ZaX69hAPzK3f8sND/+XY+oEy1mGdVwigv3s1i1P/531GtIRPEQZPC2TeJgfIAGBlLhdJ
         OExuVxQ2BVdolz+6gfvO5fdpCF3brBlKT5s4HwJdqmeINYim+qd2uAmQv4Hu9EKPy5/i
         MkuhsM+siACuNTSYw/t6hklAiEfAwpm0q//4Zy7EHTGGAE743t1YenDiDwQMZGKzDGTU
         120ofN8PRCT7D4QBeoiu2I6iGKjtLWrOcW6/hQeykNovu81VLcIW+UsglOUyuk/N+Dcn
         UpLg==
X-Gm-Message-State: AOJu0YxSblC/ZKML0MtOYlzjAYYysGEy7xirEoXCmlrQgAGryvOysMCF
        IUtWPFlB5U6PXNc2xZY1V9/VxYcFXKtkp+wlZ8A=
X-Google-Smtp-Source: AGHT+IHSB9fXVJNJdhoJJavHP9tjCE+HR0p7P5SqCVY6Q+IWYe9oFwSsU+jpVUt5xWFSSMteVs2tYnZYP3RYLRswnwE=
X-Received: by 2002:a05:6870:8a14:b0:1bb:75af:37b5 with SMTP id
 p20-20020a0568708a1400b001bb75af37b5mr10976138oaq.10.1691427993175; Mon, 07
 Aug 2023 10:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230802023955.10014-1-sunran001@208suo.com>
In-Reply-To: <20230802023955.10014-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:06:22 -0400
Message-ID: <CADnq5_OK0VXCNpA-aix2hCvBJ04R1FXhem+Q0eGpvtWu9kna=Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Clean up errors in color_gamma.c
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

On Tue, Aug 1, 2023 at 10:40=E2=80=AFPM Ran Sun <sunran001@208suo.com> wrot=
e:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: trailing whitespace
> ERROR: else should follow close brace '}'
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/dr=
ivers/gpu/drm/amd/display/modules/color/color_gamma.c
> index 67a062af3ab0..ff8e5708735d 100644
> --- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
> +++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
> @@ -359,7 +359,7 @@ static struct fixed31_32 translate_from_linear_space(
>                 scratch_1 =3D dc_fixpt_add(one, args->a3);
>                 /* In the first region (first 16 points) and in the
>                  * region delimited by START/END we calculate with
> -                * full precision to avoid error accumulation.
> +                * full precision to avoid error accumulation.
>                  */
>                 if ((cal_buffer->buffer_index >=3D PRECISE_LUT_REGION_STA=
RT &&
>                         cal_buffer->buffer_index <=3D PRECISE_LUT_REGION_=
END) ||
> @@ -379,8 +379,7 @@ static struct fixed31_32 translate_from_linear_space(
>                 scratch_1 =3D dc_fixpt_sub(scratch_1, args->a2);
>
>                 return scratch_1;
> -       }
> -       else
> +       } else
>                 return dc_fixpt_mul(args->arg, args->a1);
>  }
>
> --
> 2.17.1
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D20772CF7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjHGR3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjHGR3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:29:31 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE99510FE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:29:27 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a76cbd4bbfso3710058b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691429366; x=1692034166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxI0sX/bHlGbroOhST0CXWhe2PjX6mn9rOX1bspgZeg=;
        b=nOpV9SIadaALQmP0ifWEr7qPnFSJIkJd9WZ23kL2xPTbBQqAPj35vBqi15sMJz8bgg
         a5DpmNmj8XeIjFYjY+/V2HcBntXuEj2qrhBOAcGsEwSEvZ9CHcNiQNCSnwhKXMN5qQnj
         uEnUUswP63K6zEEve6BJMUgxBMfFDhcOUtDMpplf7QqT6nBkpxb7kthRF6DiN8WdSvVl
         v9XCV6dFDGLYKD4vQIL/UHo2AWfxgH2ehTrNeGigczm7J34W+HooAwglepVIwUg93rSq
         e8hIMcFJh0O+0yu09qrbZygv86gwAiY2y9d4crxafZbtnIaZXUjtsvonsoTQ3n5h+2jX
         GlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691429366; x=1692034166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxI0sX/bHlGbroOhST0CXWhe2PjX6mn9rOX1bspgZeg=;
        b=aS+XR2KsG6CqrFIMANpZSOzTiLR27Ya1wnQsrMrzWsNgBpAoYSQQx8fB/62IB7KY2j
         7/k3ilHZZninp5Jj/dn98usI5i7gBnCCJF0RyP0QMJ6nGJoRKIlgHtGz8guBZSGNlAR+
         j44/PGawTOlI3MXOvI6wTJE6qfAfcBoItGIuncpXPqTZI353YkiS+6r70DLzQIBhuVre
         9g9u0sChjekmos/SUoALgzaN8CwBjedtXOgbT4y3UXy2i/bLa3tA2gZGKdljvWB36IRx
         rtQosPir4omVp7oQtzsaaS5k9VV9JQ5Hs8R6eiRW0nvVWXaHCnV8t741DySOIDEWtf82
         sbiA==
X-Gm-Message-State: AOJu0Yx6uMVoA6oFm/b+xbAzOyGYV//8XL6U9oP7SXiTkqxv8IhjjhSJ
        XeHWdEIg7XifPb90OJLWGBTa7oSmlpXiJn5BCWQ=
X-Google-Smtp-Source: AGHT+IHTHPuDthKALX7K16Uo8m13HAqVVIHgxWMlhIydeR+iCjkwJIf9vCVCJ/5qaOiKuAUOJxUWwYfsSD4tVucjRRs=
X-Received: by 2002:a05:6808:1204:b0:3a7:2621:2d9e with SMTP id
 a4-20020a056808120400b003a726212d9emr12156773oil.27.1691429366520; Mon, 07
 Aug 2023 10:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230802073141.13343-1-sunran001@208suo.com>
In-Reply-To: <20230802073141.13343-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:29:15 -0400
Message-ID: <CADnq5_PyBm7AhC_QNnFeoHGHXuqPXomHC_8EkMNUQrb7wmhHWg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Clean up errors in amdgpu_virt.c
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

On Wed, Aug 2, 2023 at 3:31=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: space required before the open parenthesis '('
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.c
> index ec044f711eb9..96857ae7fb5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -520,7 +520,7 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_=
device *adev)
>                         tmp =3D ((struct amd_sriov_msg_pf2vf_info *)pf2vf=
_info)->mm_bw_management[i].encode_max_frame_pixels;
>                         adev->virt.encode_max_frame_pixels =3D max(tmp, a=
dev->virt.encode_max_frame_pixels);
>                 }
> -               if((adev->virt.decode_max_dimension_pixels > 0) || (adev-=
>virt.encode_max_dimension_pixels > 0))
> +               if ((adev->virt.decode_max_dimension_pixels > 0) || (adev=
->virt.encode_max_dimension_pixels > 0))
>                         adev->virt.is_mm_bw_enabled =3D true;
>
>                 adev->unique_id =3D
> --
> 2.17.1
>

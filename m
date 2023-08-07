Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7A2772C93
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjHGRSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbjHGRSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:18:00 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9A41BF4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:17:35 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1a28de15c8aso3619914fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428653; x=1692033453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x941QFRlMNZmZDZM2xkbsmo9UZJniXSX6pOd9x9J2Qs=;
        b=blhY82Z2TAD9PejRmNdoxblYK6rGOr/pG9QeXBKDotxEHgZe3gVEfLcZBrhIKZ5CMk
         +N2OA83ILZ5n4KkKb6F/f7u7cI3CpdvCspz8dTAS6Bo5H/E93db8IndBORsE2glQH0cf
         n4wmdIn3ThQ671Q/vRQ5jw3JJE/7jgzDA7OkdKebIL4aEgmsFwtFiIQYSuDHdQ5ZRGXz
         KtfKW0Lj8Ds925SH18glTANjFG6z5sV69sQnWP3TWiVgTtoAV9uz9iN9fOcQ+v314H6p
         yyiLDhNqNmocQbt8kMZv74QFJBaW9Ts0H393Vy8Tw3b8GlHViwpEI893Yig2LwGVxVTb
         +18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428653; x=1692033453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x941QFRlMNZmZDZM2xkbsmo9UZJniXSX6pOd9x9J2Qs=;
        b=QLQQMsV/wTJohGIy7Lh8FyAa6/K9BTLPbp0oXFtYSYgaQvU34OwMyEdRaSIWnfqf6W
         Nv02am9v8Qo6fF3ko4G/BBQ7BLEsjCZluxcV+jOeEgjRKyMkfok6hZVPdl/VltE1ifN/
         7aKturwV6hxZKZLRsASm7SyoQiMs0svDXbM7ugtLU0gZtbNoP+Uw6kTydTsIhwyBZt7O
         DzvbtkeEG0Fqro0ai8f5FpVaRvkn6tbtYc7mnUPsTM4XCDmW+pPpEGE5qUXrDcRfz9IE
         3REbnYj0hfqK93urXzZHB9D42rNPesAQcqXY54AkjT3N8uioEynIQZYKVTuuzoBSCyH8
         2W6w==
X-Gm-Message-State: AOJu0YxbQRIMtSAYTAK+RRFwSad6LWi1vxLcfrQT2rUOkK/9ouFIipWv
        xALGk0OeLkN6ubuzMnbmQL/5TjD8Dhhjn7zGkYs=
X-Google-Smtp-Source: AGHT+IHaA9hJV6vOMsXo4/1MdAleuqC1jj0XAUUTOZfjJpB83+O/s/QZSipeKBkSC0UZCxCc7qSr5BJUnGwHnuIA/vQ=
X-Received: by 2002:a05:6870:c1cb:b0:1bf:4a66:d54f with SMTP id
 i11-20020a056870c1cb00b001bf4a66d54fmr11775593oad.56.1691428653044; Mon, 07
 Aug 2023 10:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230802064024.11806-1-sunran001@208suo.com>
In-Reply-To: <20230802064024.11806-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:17:22 -0400
Message-ID: <CADnq5_Nk_kyK2SViK3cPKvkXQOgsW+tGCwz+4uFveCUBk0BjkQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Clean up errors in amdgpu_psp.h
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

On Wed, Aug 2, 2023 at 2:40=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: open brace '{' following struct go on the same line
> ERROR: open brace '{' following enum go on the same line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.h
> index c3203de4a007..feef988bf0c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -78,8 +78,7 @@ enum psp_bootloader_cmd {
>         PSP_BL__LOAD_TOS_SPL_TABLE      =3D 0x10000000,
>  };
>
> -enum psp_ring_type
> -{
> +enum psp_ring_type {
>         PSP_RING_TYPE__INVALID =3D 0,
>         /*
>          * These values map to the way the PSP kernel identifies the
> @@ -89,8 +88,7 @@ enum psp_ring_type
>         PSP_RING_TYPE__KM =3D 2  /* Kernel mode ring (formerly called GPC=
OM) */
>  };
>
> -struct psp_ring
> -{
> +struct psp_ring {
>         enum psp_ring_type              ring_type;
>         struct psp_gfx_rb_frame         *ring_mem;
>         uint64_t                        ring_mem_mc_addr;
> @@ -107,8 +105,7 @@ enum psp_reg_prog_id {
>         PSP_REG_LAST
>  };
>
> -struct psp_funcs
> -{
> +struct psp_funcs {
>         int (*init_microcode)(struct psp_context *psp);
>         int (*bootloader_load_kdb)(struct psp_context *psp);
>         int (*bootloader_load_spl)(struct psp_context *psp);
> @@ -307,8 +304,7 @@ struct psp_runtime_scpm_entry {
>         enum psp_runtime_scpm_authentication scpm_status;
>  };
>
> -struct psp_context
> -{
> +struct psp_context {
>         struct amdgpu_device            *adev;
>         struct psp_ring                 km_ring;
>         struct psp_gfx_cmd_resp         *cmd;
> --
> 2.17.1
>

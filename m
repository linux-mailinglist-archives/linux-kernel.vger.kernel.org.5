Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB75E772B12
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjHGQgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjHGQgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:36:33 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903EC2114
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:36:06 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6b9cf1997c4so3917650a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691426163; x=1692030963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/X2RI7KjH5Yx+MU8RevEmyA0pwRz4NFKlvWhA6KHUgM=;
        b=P+G6uB23xPqDxt5w3eH9Aw5PuuUCNxmoRZ86hj8p1Rr9oOF8Ckq4HpTWplRoy46eSr
         kW4bMZhjnXhCSbIBlk/Z3vqRhjnabPJIo2KuIq0DdPCIv4O14uEED7mWmiBNcmGqmlSA
         JcUyQ8zEC8xBwReEFVXBx24nG9CMPrr6R5+z2hjAMlpwkeA304bu8+CuXYuuSWtY5rqn
         UKS48b/dh+WxZdLT2It0+WCKvBOU/ZUmj+8fbmp6KEByIGeXo16i7s9XKk6wBlyy/icD
         UNxfmP99ttz64JvMe/ZwMEKcj5fO74CsYuI3AfWYFsv+6rgZ05XjGU27b6c425xfhmDS
         bS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691426163; x=1692030963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/X2RI7KjH5Yx+MU8RevEmyA0pwRz4NFKlvWhA6KHUgM=;
        b=S659wagxbei85b3DxxNo0QVrsJ9Er40Tf40thdr2MYNNxgM3oA0PoEr0fMWclr29Wk
         WugfRiAdILVeWwoRkbBIPBtwy231p7/7aqvmLJLF0lcuPLaUh2jAujdq3D8whP4hSGPd
         R5NrSBtLCDru6HizV367BABo8hwocWwGZn8TAt9ZXX/Hju5tR5AAkNx+k1E5q1r0ER0T
         OB+ir6VoJmW5wyo3kDN4pvNFbC5aJehF1SZvFPyt6kbF8QSekoVCjL6D0n0+Slt8E7M9
         JEhQKNmfG5kamz7LQfQwlweZGOd9iltTBWDYPPFKDK+yfAj3Zr45L9iX1LmAwWC3JcnQ
         nd9w==
X-Gm-Message-State: AOJu0Yx9kHNea08ktcW+KKKuE2b9M/5kGQuNp1oDy770I8evPA4z4zfq
        D+eOEOwO16OL5BNWexnGUMoyT8y/nk5tlEwDYWk=
X-Google-Smtp-Source: AGHT+IHxav8wq0MkdwiAu07noGH5tXWTHhZ4OcQv3DFcN9zfoRPcjrC38lMKmPF563QGU2Wz26RfLuwAGk4KiDBGSrI=
X-Received: by 2002:a05:6871:5c6:b0:1be:c688:1c0 with SMTP id
 v6-20020a05687105c600b001bec68801c0mr12543916oan.47.1691426163362; Mon, 07
 Aug 2023 09:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230801075951.6467-1-sunran001@208suo.com>
In-Reply-To: <20230801075951.6467-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:35:52 -0400
Message-ID: <CADnq5_Oao-NQ2zJkYvA9Xyd10O4eUYe8CKmsyf8TzwgHrj2R8A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Clean up errors in smu_helper.c
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

On Tue, Aug 1, 2023 at 4:00=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: spaces required around that '=3D' (ctx:VxV)
> ERROR: spaces required around that '<' (ctx:VxV)
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
> index d0b1ab6c4523..79a566f3564a 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
> @@ -696,7 +696,7 @@ int smu_get_voltage_dependency_table_ppt_v1(
>                                 return -EINVAL);
>
>         dep_table->count =3D allowed_dep_table->count;
> -       for (i=3D0; i<dep_table->count; i++) {
> +       for (i =3D 0; i < dep_table->count; i++) {
>                 dep_table->entries[i].clk =3D allowed_dep_table->entries[=
i].clk;
>                 dep_table->entries[i].vddInd =3D allowed_dep_table->entri=
es[i].vddInd;
>                 dep_table->entries[i].vdd_offset =3D allowed_dep_table->e=
ntries[i].vdd_offset;
> --
> 2.17.1
>

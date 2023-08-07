Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593E0772A73
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjHGQVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjHGQVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:21:39 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B38610D0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:21:38 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1bb7e083783so3589462fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691425297; x=1692030097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6a6OPGqjVivVDw1eoWRT/DMOBdbCCUrI0pcLxomi0w=;
        b=b8xSm4HEayy9a0u8zHlqX6LS/nvpqAH9HKyb7F5ICDjpGy/eYcNvMc54RfC/nWPvVd
         NlCEnfjLDMSj0d3flf7SS5/MI1QGfd8jjVqP7u+OajuWWD7CwywAk/NKUAYmwHQsf3vr
         EhBbwbnoR5B99pcE5jg/4K63eTmn9RT61M6ETknfLCMQTnhfQCXMxAsK+1s6WFtsqdaO
         9EFpm6n69F6jX0n/DbO32hhKC4SicrBhlMmwFas9DVSsriks+gp65VdT2UGjbnbi3YbZ
         P3IXBX6VLURauHOnwFi+b/oCHxYbNyE3ha7nmWwA/0FtiJYKErKhG6ZvRYqZo37d/xO6
         MnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691425297; x=1692030097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6a6OPGqjVivVDw1eoWRT/DMOBdbCCUrI0pcLxomi0w=;
        b=fV1ONeCxrTN+5qwSl0VBh/hB8asFtvSqRnmfEKzHApk8sdeJ4eNztTwzL2WVp6esI/
         2cadn5ea1AqBz8lfz1HCPN+RjspWBPxMc+iahjYSZERpOqOyWyhVuMHMc5E/HRkHbVsm
         6GT6mnpKAnFMtHRc1j+Lr5X7LOTUc/9xtAt2gVnS2A26KTH1vHT4YYLRuje4okaq2ggT
         86VfroTq3/btOkJ0lF4OzbNPSGJC+O0pQ1ZBfmkAqdQnam41a9vrdOCeRCHnah+PGGxG
         gkFUSatRah6dJ6GPCBUCwAm7PpKjbDqv26nYBoaJm+PTfYRw8uN3xldqsML1lX1CVOSi
         RIHA==
X-Gm-Message-State: AOJu0YxOMGSKAk58Ltol6Xb3KNrJgOs2ZRM2mP5WEhaOyCMEvRFRoJ7u
        ksqmNecBYL2scgr1MaQhuSvjJP9DZm+j2eyye1vDUGkw
X-Google-Smtp-Source: AGHT+IHkQbeZrmJm8STaoLnhIdcxpNY5NmiGjOO7tyrMjyxIIgZifm159Q1bsgtg2qO+pREbHpds+OSLviai86hpVA0=
X-Received: by 2002:a05:6870:5607:b0:1bb:b13c:7f9c with SMTP id
 m7-20020a056870560700b001bbb13c7f9cmr10569693oao.57.1691425297605; Mon, 07
 Aug 2023 09:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230801020625.4281-1-sunran001@208suo.com>
In-Reply-To: <20230801020625.4281-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:21:26 -0400
Message-ID: <CADnq5_M9j6pM+cic6PHj2k+AhkxnsyYfWMh2gfJ168uQD2jANQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in smu_v13_0_6_ppt.c
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

On Mon, Jul 31, 2023 at 10:06=E2=80=AFPM Ran Sun <sunran001@208suo.com> wro=
te:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: code indent should use tabs where possible
> ERROR: that open brace { should be on the previous line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 1ac552142763..43afa1ee1b4a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -1248,9 +1248,9 @@ static int smu_v13_0_6_get_power_limit(struct smu_c=
ontext *smu,
>                                        uint32_t *default_power_limit,
>                                        uint32_t *max_power_limit)
>  {
> -        struct smu_table_context *smu_table =3D &smu->smu_table;
> -        struct PPTable_t *pptable =3D
> -                (struct PPTable_t *)smu_table->driver_pptable;
> +       struct smu_table_context *smu_table =3D &smu->smu_table;
> +       struct PPTable_t *pptable =3D
> +               (struct PPTable_t *)smu_table->driver_pptable;
>         uint32_t power_limit =3D 0;
>         int ret;
>
> @@ -1366,8 +1366,7 @@ static int smu_v13_0_6_set_irq_state(struct amdgpu_=
device *adev,
>         return 0;
>  }
>
> -static const struct amdgpu_irq_src_funcs smu_v13_0_6_irq_funcs =3D
> -{
> +static const struct amdgpu_irq_src_funcs smu_v13_0_6_irq_funcs =3D {
>         .set =3D smu_v13_0_6_set_irq_state,
>         .process =3D smu_v13_0_6_irq_process,
>  };
> --
> 2.17.1
>

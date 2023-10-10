Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2517C0320
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343566AbjJJR7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbjJJR7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:59:30 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B389D
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:59:29 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3ae65e8eb45so4114650b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696960768; x=1697565568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGIeLbonPPYlH9oYKOAbS/s/wMjxEMpdPvDdi4ETn8U=;
        b=ZnjxZvqE64j19H/6w9cqBIHrAaz4QYH2BhgZLPdz2mFEzdsoS3JHlKMPwiFyJM2Nbs
         nt/Nq9/AAlMBiZoKYSAGfSwVSQUn8ncVHKn2N59RbEP5loNDfm7lIfUra3lcf522D1A8
         CbNfZmLPKnfOuZ1zap/jGIEzS9uZ0rnF6QnLqKJz7zP4BDFFso3Q0adiQbnucen8j74z
         +SwJNgzteqax1LH326YJKppcZkALi37E7pxszhNvbJTfrsbiwREHcdMZLJBEL7sX2k0W
         JGWkXRZG/Jkwd5q0YrfU54eCn2+2whWqa6wbWR21xXqllRt999uLV/rku6lHK/j22/hL
         cd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696960768; x=1697565568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGIeLbonPPYlH9oYKOAbS/s/wMjxEMpdPvDdi4ETn8U=;
        b=dNwUSlhmFHZibCBBgdrEa6ysHXdFKwkcB1NwhVFc+uA7JhD3pRQPwCAgYj/66kPiw9
         tSP4mKj5c9KBBTamNIJCmAZK+lR1kAqlLp0h0/FGh4TkgnNVgPHp6Ph0f3H4o0RNxZG1
         ZABVHj1dkFED0XDFqDzG8raAYDbfm7kULV1gdhsuqrJr8Ap7zeBE6JaQ1qlQ9XWEKm4F
         0tyPZmhQ7iA4aexwhnYcaOg0JpCcq6sUfj6FdubrP2B1QO2B7ri3ZYQ1tBBcSlgVArmj
         eLJ60jxHkPXolO0VC20zDIwgcQrgRktkrlOAiixzWp6uxD7T4M+3qbqW24rY567ecYLq
         dvKQ==
X-Gm-Message-State: AOJu0YziXC/cHNHH92OClOah3pu/FnJDuC00A6hivi0oh5zOb5/ae7Wd
        3jitQPqtCbebXC6MogFNdqO7Uz8fhCMWwbcrMKc=
X-Google-Smtp-Source: AGHT+IE6T3Xrn9dGWUdNXdC0Ro5S5WfkJlG8Vzrtn1AyZD1HHQ/ZvG1EbKuMokTpPOhfphSdp5q0y0y/rZdODqzaT/c=
X-Received: by 2002:a05:6871:79c:b0:1d6:5fee:d8ef with SMTP id
 o28-20020a056871079c00b001d65feed8efmr20943526oap.22.1696960768389; Tue, 10
 Oct 2023 10:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <PH7PR12MB5997C208CDD4587332346CD782CDA@PH7PR12MB5997.namprd12.prod.outlook.com>
 <20231010061039.75878-1-chentao@kylinos.cn> <PH7PR12MB5997E8A541A39046B0B3BCB982CDA@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB5997E8A541A39046B0B3BCB982CDA@PH7PR12MB5997.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Oct 2023 13:59:17 -0400
Message-ID: <CADnq5_MLOSkC+qgOxCLkfQ-ML0SdVXackvn6L9GRLFmpndv-OQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Fix a memory leak on an error path
To:     "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Cc:     "Kunwu.Chan" <chentao@kylinos.cn>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "kunwu.chan@hotmail.com" <kunwu.chan@hotmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Lazar, Lijo" <Lijo.Lazar@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kamal, Asad" <Asad.Kamal@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "evan.quan@amd.com" <evan.quan@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
        "Zhang, Hawking" <Hawking.Zhang@amd.com>
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

Alex

On Tue, Oct 10, 2023 at 2:32=E2=80=AFAM Wang, Yang(Kevin)
<KevinYang.Wang@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
>
> Best Regards,
> Kevin
>
> -----Original Message-----
> From: Kunwu.Chan <chentao@kylinos.cn>
> Sent: Tuesday, October 10, 2023 2:11 PM
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kam=
al@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhang, Hawking <=
Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Lazar, Lijo <Lijo.Lazar@amd=
.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; airlied@gmail.com; amd-gfx@lists.f=
reedesktop.org; chentao@kylinos.cn; dan.carpenter@linaro.org; daniel@ffwll.=
ch; dri-devel@lists.freedesktop.org; evan.quan@amd.com; kunwu.chan@hotmail.=
com; linux-kernel@vger.kernel.org
> Subject: [PATCH] drm/amd/pm: Fix a memory leak on an error path
>
> Add missing free on an error path.
>
> Fixes: 511a95552ec8 ("drm/amd/pm: Add SMU 13.0.6 support")
> Signed-off-by: Kunwu.Chan <chentao@kylinos.cn>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index ce971a93d28b..c26e12ff532c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -1981,8 +1981,10 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct =
smu_context *smu, void **table
>
>         metrics =3D kzalloc(sizeof(MetricsTable_t), GFP_KERNEL);
>         ret =3D smu_v13_0_6_get_metrics_table(smu, metrics, true);
> -       if (ret)
> +       if (ret) {
> +               kfree(metrics);
>                 return ret;
> +       }
>
>         smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>
> --
> 2.25.1
>

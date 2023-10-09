Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07177BEA03
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378176AbjJISqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378120AbjJISqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:46:07 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A667A6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:46:06 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6c4e38483d2so3465839a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696877165; x=1697481965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hO3LUe5ofUhhf/JzpF6obyH/g5xq6HG7iuNZoAV8g0A=;
        b=mqeC56XKMg1n3zpHXSKbrhwTHY+FxOjFy7Dcj3wdPDM/FcYCI6tCwkMN10mhgGE+03
         c9s9Hyd8qGBV8Abz5HO/59LDzK69T2u+RxgbHO4MAqPNhCkdarWZju56RI9BxlpDK9PZ
         KZYo4WmGx0ZqZxZzpA1VjFE+VJhS1mOw790E1dAGmBOA4d4X/3XENSkglj7d/ZNdf902
         civaTk5Gvywnx9Vc/uRz9rCCXNaY+iiDMVL1aftHudYGTVHcUBcK9NInivS6K9n7pXhF
         TZ95y8YlzGJVXv1r4C1keWmbtE0HyN5f6ICg6EpgNtFwtPvE23vL88MJsC+WPVl/r292
         b8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696877165; x=1697481965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hO3LUe5ofUhhf/JzpF6obyH/g5xq6HG7iuNZoAV8g0A=;
        b=ooXs/vUqcIisjM7E1RBCHbGVE5WPKXMc7CzBlj+mkeNIKmktB37Oy8WlDzpn+ywMMm
         P9ul+Cfx67gijqkUvJqZQQr4YPlt08Kqw7ltZDcp7E5T+ByNVup8xmjUOs7wsxJ+ky+Z
         8SsyNbP43ELjYMmCt+xzrg+tgBTq7Gn69k36Skjq8Ui78ZS+VK+kvvlH7cJCBwLDNDX/
         qcV/7t9WW+wE6cXIsqBts90z74W/SJv9n3852fXyJtx/n9dJ/LxvZqhc4a8B60Wu/A+9
         wERqldqAufzjVxJAtzqgAqzKOVURsAgDzxSgNnekXVuA0HIo1iodoFgRenM4qfrK7DzU
         p9Ig==
X-Gm-Message-State: AOJu0Yxhe/fvrt3tvY945JggzEmi5+Sxcs6ZYGPtzWXAlsZwTmfgJPWn
        2s2VMyAq0OGIS74QL2dLE4ZEpLTpKbINv3WWcSQ=
X-Google-Smtp-Source: AGHT+IGPYT0RA6DlQ4e2wnpZWcJFoS79JDz2JE5zmK9PmczS5ESfePxUym53XyVJIbPneoKuwkdOzdEcD189F8+MdJA=
X-Received: by 2002:a05:6871:451:b0:1dc:ddcd:876f with SMTP id
 e17-20020a056871045100b001dcddcd876fmr19133264oag.41.1696877165351; Mon, 09
 Oct 2023 11:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231008064649.3184677-1-uwu@icenowy.me> <MW4PR12MB5667743E5B759FFE85F204ACF2CEA@MW4PR12MB5667.namprd12.prod.outlook.com>
In-Reply-To: <MW4PR12MB5667743E5B759FFE85F204ACF2CEA@MW4PR12MB5667.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 9 Oct 2023 14:45:54 -0400
Message-ID: <CADnq5_PziCZsBy==21t4Wen_Dv_F7Q1AMNbJXmSjtBrgsboSAg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix SI failure due to doorbells allocation
To:     "Sharma, Shashank" <Shashank.Sharma@amd.com>
Cc:     Icenowy Zheng <uwu@icenowy.me>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Yadav, Arvind" <Arvind.Yadav@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Mon, Oct 9, 2023 at 5:27=E2=80=AFAM Sharma, Shashank <Shashank.Sharma@am=
d.com> wrote:
>
> [AMD Official Use Only - General]
>
> Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>
>
> Regards
> Shashank
> -----Original Message-----
> From: Icenowy Zheng <uwu@icenowy.me>
> Sent: Sunday, October 8, 2023 8:47 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Ch=
ristian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David Airlie <ai=
rlied@gmail.com>; Daniel Vetter <daniel@ffwll.ch>; Sharma, Shashank <Shasha=
nk.Sharma@amd.com>; Yadav, Arvind <Arvind.Yadav@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux=
-kernel@vger.kernel.org; Icenowy Zheng <uwu@icenowy.me>
> Subject: [PATCH] drm/amdgpu: fix SI failure due to doorbells allocation
>
> SI hardware does not have doorbells at all, however currently the code wi=
ll try to do the allocation and thus fail, makes SI AMDGPU not usable.
>
> Fix this failure by skipping doorbells allocation when doorbells count is=
 zero.
>
> Fixes: 54c30d2a8def ("drm/amdgpu: create kernel doorbell pages")
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> index d0249ada91d30..599aece42017a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> @@ -142,6 +142,10 @@ int amdgpu_doorbell_create_kernel_doorbells(struct a=
mdgpu_device *adev)
>         int r;
>         int size;
>
> +       /* SI HW does not have doorbells, skip allocation */
> +       if (adev->doorbell.num_kernel_doorbells =3D=3D 0)
> +               return 0;
> +
>         /* Reserve first num_kernel_doorbells (page-aligned) for kernel o=
ps */
>         size =3D ALIGN(adev->doorbell.num_kernel_doorbells * sizeof(u32),=
 PAGE_SIZE);
>
> --
> 2.39.1
>

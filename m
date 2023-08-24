Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523D7787311
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241689AbjHXO76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242036AbjHXO7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:59:24 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215F4FD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:59:22 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-570f0cb0c1eso6223eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692889161; x=1693493961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOrKAhL/7L8rx8ShdtWBY/61puZF7B2DZm1BsaoYJt8=;
        b=Mx0bXIz8ZJ8ay48rsZT8xh5Xaslo5YJX+IhZgiPsWRv93e3mXYmyHs+wEfuu/y0rOj
         5+J1irYrF8A8zvInfA8EGoGnM1+N6GVNstBJtJrlXEqGL6tb8WEeW1AT8SjdaCP4bnRT
         tzucCOcNj+X8mKRPbnztDvMF1Gs8kPxgViiMs3+wx3c1xEPu3EFIfUXzld6wh2KIXyh1
         MPNHDpOu/ePFJSvGCxQ1JpU09u+kQlHHUV7WwNVqJnqguZBucCtsUOnbFlg5vBdwIVQl
         IYdamPMsP+ZCEKw9Y/XoDCkgZOChNHZOg4w3vt1wvIUw2Zor0IR6T9eYDrJJkgxlzlia
         AlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692889161; x=1693493961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOrKAhL/7L8rx8ShdtWBY/61puZF7B2DZm1BsaoYJt8=;
        b=TtN0gnEZ1rXQav7r/D9mugpqj8soBRz77J1gVAlXyVrGTORT7o8uZAxCY7TmFj4yBs
         QGjK9MVCwCJbHoM3IzHpn/Chy52ZCN6exSrpWS1ESFiL0JN0YYphwIFO1TdYj/zNqlFc
         3pI6yHOYoqgtt/LGG1fvItFY6MR2EQlgdY7tU8ZxT7o9qtD6FNd8DnsCiLnE3fTaUiCC
         SrmAFZJf6yO6G8XJGqFdtwqOR+iBTokhtqISwqSomQNB/LQwK1XSNs8GgoD0ZlzzRinP
         BpyUbNvimhWSFpbLR6g6g0dJ+Ygfry7lB/U504gouSjytmueLiY46PPLbtvvOe5uktPt
         ZlXQ==
X-Gm-Message-State: AOJu0YzmG+iXod9rmZpqEcYPBz1klZOZ7+0Q2lBI62RzYz9wdNlTI0A6
        apMf7DxGKNaNgIK3wUtkMKZ8rF0mDjd8Xti/D10F8QKP
X-Google-Smtp-Source: AGHT+IES2etgcqRdMcU6Cv/oaMM2wsQXHG0/gHbgwbSl5bh0abxyxRhClWxMpv8vCb8toTlVVasaO5RJmdKYA5hjhpQ=
X-Received: by 2002:a4a:3014:0:b0:573:2312:b3 with SMTP id q20-20020a4a3014000000b00573231200b3mr1983597oof.4.1692889161451;
 Thu, 24 Aug 2023 07:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230824073710.2677348-1-lee@kernel.org> <20230824073710.2677348-12-lee@kernel.org>
 <MW4PR12MB56671A4E4281690A44C45C91F21DA@MW4PR12MB5667.namprd12.prod.outlook.com>
In-Reply-To: <MW4PR12MB56671A4E4281690A44C45C91F21DA@MW4PR12MB5667.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 24 Aug 2023 10:59:10 -0400
Message-ID: <CADnq5_P4jFAdWwaemnaGq7ADt8V95g+U9JeiO99N=cyDBMhHEw@mail.gmail.com>
Subject: Re: [PATCH 11/20] drm/amd/amdgpu/amdgpu_doorbell_mgr: Correct
 misdocumented param 'doorbell_index'
To:     "Sharma, Shashank" <Shashank.Sharma@amd.com>
Cc:     Lee Jones <lee@kernel.org>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
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

On Thu, Aug 24, 2023 at 4:35=E2=80=AFAM Sharma, Shashank
<Shashank.Sharma@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> Reviewed-by: : Shashank Sharma <shashank.sharma@amd.com>
>
> Regards
> Shashank
> -----Original Message-----
> From: Lee Jones <lee@kernel.org>
> Sent: Thursday, August 24, 2023 9:37 AM
> To: lee@kernel.org
> Cc: linux-kernel@vger.kernel.org; Deucher, Alexander <Alexander.Deucher@a=
md.com>; Koenig, Christian <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.=
Pan@amd.com>; David Airlie <airlied@gmail.com>; Daniel Vetter <daniel@ffwll=
.ch>; Sharma, Shashank <Shashank.Sharma@amd.com>; amd-gfx@lists.freedesktop=
.org; dri-devel@lists.freedesktop.org
> Subject: [PATCH 11/20] drm/amd/amdgpu/amdgpu_doorbell_mgr: Correct misdoc=
umented param 'doorbell_index'
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c:123: warning: Function =
parameter or member 'doorbell_index' not described in 'amdgpu_doorbell_inde=
x_on_bar'
>  drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c:123: warning: Excess fu=
nction parameter 'db_index' description in 'amdgpu_doorbell_index_on_bar'
>
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Shashank Sharma <shashank.sharma@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> index da4be0bbb4466..d0249ada91d30 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> @@ -113,7 +113,7 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev=
, u32 index, u64 v)
>   *
>   * @adev: amdgpu_device pointer
>   * @db_bo: doorbell object's bo
> - * @db_index: doorbell relative index in this doorbell object
> + * @doorbell_index: doorbell relative index in this doorbell object
>   *
>   * returns doorbell's absolute index in BAR
>   */
> --
> 2.42.0.rc1.204.g551eb34607-goog
>

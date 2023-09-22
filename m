Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD437AB7F3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjIVRmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjIVRmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:42:38 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACA2CF;
        Fri, 22 Sep 2023 10:42:32 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1d598ba1b74so1334531fac.0;
        Fri, 22 Sep 2023 10:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695404551; x=1696009351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1mscbgmaMFCH+sggQx7YqczyCptW8ney4CIT5DP64U=;
        b=cJ+JYUG4XkAn1AAFTmtZNs3+4TmYuJIlO5PQrVL2+2aoiMOvCR8M0K26K3zw2c2m1e
         wJSVIW5bRw5cDb9DsnRKcYzOyLVtd+t947jlQRgndg4p2X7zHCw9TIxqt9XAcP0abM30
         ZykNUfwLTjx/9L7YAeGZT7qK2S/y9mvKg70fgD58XHc82xGNYONl7KayJhri2rLZPlnM
         Y+oUbmQdl14BVv1QLlLvyROdAcvElyeoLRSwPrC+4YZqax05K4XL5OiL9Ts1Ir9J/Lc5
         735TibuyRTXxgk8RSIeOxcGdrd9RQ5IrihyLLt7TpH7ABrCZk+xWR1ZEPdV/kS8J7bN2
         nWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695404551; x=1696009351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1mscbgmaMFCH+sggQx7YqczyCptW8ney4CIT5DP64U=;
        b=kHBv71vGq7fVWfPZ+aOA7x3dtuCdoOhG5IvxFap+LiUQ31ELOC3ci17RzJKKEsJRe4
         UclW+i3CsZaU7EGzYaEQFsAuDrnrOmwtcH9oS9QNuDb5n5WWL5RMNPO9beki6IhkS7SX
         qtBkenUHFCyZ6WmDYnuoTaboyPk37Q4efdeXQZwVbKItUPzGB3xH5B/9K3eDfXwYzqZp
         PMjNT6dL/AOdZi+X15olLvRlYjS791gsZL698EYR5T6tPYY96ahl5FTrGpQWgcc36LGT
         AImivEGfcp7UiL+f9bPfYz/ubCzril85cjEU5LnbOKg69lMKiOsNJUuZQVTXVVtJOHav
         /ePw==
X-Gm-Message-State: AOJu0YwUIb+CeEAj24ugk2TuGBn/7F9qVk6TiqhdksM44toBd92/DrL8
        Du20u17IBSZH4in0m4S0wOq4u1HHl3CSA8FVG+M=
X-Google-Smtp-Source: AGHT+IFPsM3Hdk+pcYqT5bpsUWbwTA0MpnAJeoAQZ6o66BtolUGO//OpOOgoyvfV1ya4MzJTleibWsMBwKq26jjzaO8=
X-Received: by 2002:a05:6870:2383:b0:1dc:33a:40d8 with SMTP id
 e3-20020a056870238300b001dc033a40d8mr162032oap.4.1695404551639; Fri, 22 Sep
 2023 10:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230922173110.work.084-kees@kernel.org> <20230922173216.3823169-2-keescook@chromium.org>
In-Reply-To: <20230922173216.3823169-2-keescook@chromium.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 22 Sep 2023 13:42:20 -0400
Message-ID: <CADnq5_OV7L4_z5mhAq8x8nV4+yp_wGhyVeg1MrKAVoSbMVV1uw@mail.gmail.com>
Subject: Re: [PATCH 2/9] drm/amdgpu/discovery: Annotate struct ip_hw_instance
 with __counted_by
To:     Kees Cook <keescook@chromium.org>
Cc:     David Airlie <airlied@gmail.com>,
        Tejas Upadhyay <tejas.upadhyay@intel.com>,
        Emma Anholt <emma@anholt.net>, Tom Rix <trix@redhat.com>,
        llvm@lists.linux.dev, dri-devel@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Prike Liang <Prike.Liang@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Matthew Brost <matthew.brost@intel.com>,
        Karol Herbst <kherbst@redhat.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        amd-gfx@lists.freedesktop.org,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Nathan Chancellor <nathan@kernel.org>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        nouveau@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-hardening@vger.kernel.org, Lijo Lazar <lijo.lazar@amd.com>,
        Yifan Zhang <yifan1.zhang@amd.com>,
        linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        Kevin Wang <kevin1.wang@amd.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Melissa Wen <mwen@igalia.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Evan Quan <evan.quan@amd.com>, Sean Paul <sean@poorly.run>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>, Le Ma <le.ma@amd.com>,
        freedreno@lists.freedesktop.org,
        Bjorn Andersson <andersson@kernel.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Nirmoy Das <nirmoy.das@intel.com>, Lang Yu <Lang.Yu@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        John Harrison <john.c.harrison@intel.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
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

On Fri, Sep 22, 2023 at 1:33=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUND=
S
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct ip_hw_instance.
>
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/c=
ounted_by.cocci
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index d1bc7b212520..be4c97a3d7bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -662,7 +662,7 @@ struct ip_hw_instance {
>         u8  harvest;
>
>         int num_base_addresses;
> -       u32 base_addr[];
> +       u32 base_addr[] __counted_by(num_base_addresses);
>  };
>
>  struct ip_hw_id {
> --
> 2.34.1
>

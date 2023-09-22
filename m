Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE3B7AB7DF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjIVRmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjIVRmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:42:09 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6066099;
        Fri, 22 Sep 2023 10:42:03 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1d71102a35bso1273828fac.0;
        Fri, 22 Sep 2023 10:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695404522; x=1696009322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XekgGSaX3ptkpR/7Vl4AaE79EkIJG3ApSeSAmfaaNYY=;
        b=YKWSB/hzjuWMoAeDnK2TnLtXpgYCo6qj3Fi8nmnlpj8i6owcjUTS/a9jJUaqim/jbN
         fNPDl1+s+A7EwO6zS4NXxfWSbnVSJMK222tHOaQ0vuiH5FlMOWBPqyK28xRwOUL+4HrZ
         idGRxjnEDlLLRgiFqDR6R6y/rNsroJfmZ483MP9P28cxEOTuwZhjyMC31d5NFm3cgmEN
         72XIhAMwQSF/wjx/lyLH+W02SC4ao/0Gl+yWceIFmMGrxnAGfqKQOMaXM2gcKcmtlbzr
         QFPXO0w7W9Jc8KxrWw+IJUO1qCFWEQc6Kycy0pi2CU6F83Z3vvOATBKRH9jCGmIYFv2O
         3JOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695404522; x=1696009322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XekgGSaX3ptkpR/7Vl4AaE79EkIJG3ApSeSAmfaaNYY=;
        b=Zkil6TavbHqg5Uh6VEuu3jFVz5wUowZi1GKs3DKIbEOKZVM8VAS4uZeRLnac0msUva
         rSYEedeK28YS47ZakaA+6VHN41AQf5yHZNTbBOLWS//VNLM79+NxXzkl5NXnMqqP3A/L
         wKWVwizX7yVMgFaEhRcmNa47lEaJsrL156fXNYmSgWrug4yTO08udzrs+27Yx0iN8GVY
         w/pDpQpnYD0Gv/qV6dgLRjWpGLz2lZXtsz92TSISe8SbCKsz5w4bbahNaBdSJKqmAWmS
         P5LO0Q6O/YO/YpWUJOo7izK+EHBhvASrCwHLBjccV8Wc3FhcoQyNQYUCJkoZbu9NhZl2
         Wz9Q==
X-Gm-Message-State: AOJu0Yx+D6xKsmzzi3DLbCcMrA6Ii845pEwCVVkPuTZy/S9uZ0+Ysbu7
        AkJKwysGxXnrpfoLMuH6gHBnqyNFKWKl4TkUpIURNmbV
X-Google-Smtp-Source: AGHT+IG39K8OoDMaCogRuGeRtHy4kPLjYTbpmj4vuvYl6iT+u3RXeJQ2kVCIXH4X5mx+L+1FvNpYYUZbI2a21sY0YAA=
X-Received: by 2002:a05:6870:f689:b0:1d5:b9e1:d35e with SMTP id
 el9-20020a056870f68900b001d5b9e1d35emr103462oab.41.1695404522615; Fri, 22 Sep
 2023 10:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230922173110.work.084-kees@kernel.org> <20230922173216.3823169-1-keescook@chromium.org>
In-Reply-To: <20230922173216.3823169-1-keescook@chromium.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 22 Sep 2023 13:41:51 -0400
Message-ID: <CADnq5_P2p3bmczci=pU+pG6f9+hqn=-xp1EynP2345CJZRW08w@mail.gmail.com>
Subject: Re: [PATCH 1/9] drm/amd/pm: Annotate struct smu10_voltage_dependency_table
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 1:32=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
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
> As found with Coccinelle[1], add __counted_by for struct smu10_voltage_de=
pendency_table.
>
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/c=
ounted_by.cocci
>
> Cc: Evan Quan <evan.quan@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Xiaojian Du <Xiaojian.Du@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: Kevin Wang <kevin1.wang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.h b/drive=
rs/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.h
> index 808e0ecbe1f0..42adc2a3dcbc 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.h
> @@ -192,7 +192,7 @@ struct smu10_clock_voltage_dependency_record {
>
>  struct smu10_voltage_dependency_table {
>         uint32_t count;
> -       struct smu10_clock_voltage_dependency_record entries[];
> +       struct smu10_clock_voltage_dependency_record entries[] __counted_=
by(count);
>  };
>
>  struct smu10_clock_voltage_information {
> --
> 2.34.1
>

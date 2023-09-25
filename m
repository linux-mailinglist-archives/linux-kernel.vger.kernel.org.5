Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311037AD9BA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjIYOHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjIYOHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:07:46 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8F5C0;
        Mon, 25 Sep 2023 07:07:39 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1dcedc832d4so1596272fac.3;
        Mon, 25 Sep 2023 07:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695650859; x=1696255659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOm71FSa/a54JWdPxFTdFQYbsSYB0XKCvLJel7l+Bek=;
        b=jpP9f+SoKQVqdTnEQFoH5+vMmHrMw0e/70zsHfZH/xpE97jLfDgqAHah88ugAV0rnN
         2abK60Jt4jELKdCt/4ejxbl/HvUUPl0eYNToTSNFZNMpYHecr2+qKLW57q6NeNoVfuy0
         O+Zski8i8p1tE+ZhSDi+y+iK9sgwLoLqFf7uDMqUB85m0wLCmoMVp3ijoHEFafFCm7L+
         hE6O616wGt0zbqORXyYHqQwyLLn/4+GMP8VInbs9Sb9Y7Mn/6OFKR5VJ+NJddMRmdnHO
         bDirD2rZA8i7dqUwEQdRYqpTBDu2bejN8pAqDKDF+nzQgxkXLNk6I+vwhRDSFLELji32
         ZpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695650859; x=1696255659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOm71FSa/a54JWdPxFTdFQYbsSYB0XKCvLJel7l+Bek=;
        b=um0ZjABdcpWgOfuqigQtnzpgcpSIN7joQYjrmG/Vds25nR0FNlGiGIBOkSnbH+KEDI
         /68OvvuO7TahZRsBTWyt60y5CJjNKN3ibJUPitnDpvbmlBHLxECAPrydizwHapx8gaCn
         qHTP8DOTksdSkd4mdKaUr45GfYqKSpNvH54fhMM3Zi7tOg3FKXeMoA3A42IswNUE/bb+
         t+dVwgNHFKzfkD6+L+9R4PiUoSKhQZf+eaVEku8rh1smOXTooTQ7PCz+uOxXpnS6LK/F
         i9BOz4o+6oa2zhGawmH/cl8XdtrbOLV0LP5MkyGpcEjfBgtOKK71gpdqXg3DX8eum3qR
         nDgg==
X-Gm-Message-State: AOJu0YyK/5RVyHaJ0pfuiyLO0XgzxV7c99+uS/99j9rs8gdW2M76EIkU
        yaPuwfnax9Cd55Wd74MHAO3Emzd9u4u/X3dOrUs=
X-Google-Smtp-Source: AGHT+IEAGihrK0Fxy+zmQS+jCavrD8i0S0F6RPaTyUWR0Tsr+swWkiWj17Z4gpkbPnpNw9W+uaTcvGPHY2GFxPPQ6jk=
X-Received: by 2002:a05:6870:b68b:b0:19e:fa1f:fc2f with SMTP id
 cy11-20020a056870b68b00b0019efa1ffc2fmr7668945oab.38.1695650859043; Mon, 25
 Sep 2023 07:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230922173110.work.084-kees@kernel.org> <20230922173216.3823169-1-keescook@chromium.org>
 <CADnq5_P2p3bmczci=pU+pG6f9+hqn=-xp1EynP2345CJZRW08w@mail.gmail.com> <2635922e-f52a-4e91-40c6-4f1358972786@amd.com>
In-Reply-To: <2635922e-f52a-4e91-40c6-4f1358972786@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 25 Sep 2023 10:07:27 -0400
Message-ID: <CADnq5_P1tg2-rWUmsRAy3aPJLT7ZmaZORMSOrPa6t6oSc5xS3g@mail.gmail.com>
Subject: Re: [PATCH 1/9] drm/amd/pm: Annotate struct smu10_voltage_dependency_table
 with __counted_by
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Kees Cook <keescook@chromium.org>,
        David Airlie <airlied@gmail.com>,
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

On Mon, Sep 25, 2023 at 2:30=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 22.09.23 um 19:41 schrieb Alex Deucher:
> > On Fri, Sep 22, 2023 at 1:32=E2=80=AFPM Kees Cook <keescook@chromium.or=
g> wrote:
> >> Prepare for the coming implementation by GCC and Clang of the __counte=
d_by
> >> attribute. Flexible array members annotated with __counted_by can have
> >> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BO=
UNDS
> >> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-fami=
ly
> >> functions).
> >>
> >> As found with Coccinelle[1], add __counted_by for struct smu10_voltage=
_dependency_table.
> >>
> >> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/example=
s/counted_by.cocci
> >>
> >> Cc: Evan Quan <evan.quan@amd.com>
> >> Cc: Alex Deucher <alexander.deucher@amd.com>
> >> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> >> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> >> Cc: David Airlie <airlied@gmail.com>
> >> Cc: Daniel Vetter <daniel@ffwll.ch>
> >> Cc: Xiaojian Du <Xiaojian.Du@amd.com>
> >> Cc: Huang Rui <ray.huang@amd.com>
> >> Cc: Kevin Wang <kevin1.wang@amd.com>
> >> Cc: amd-gfx@lists.freedesktop.org
> >> Cc: dri-devel@lists.freedesktop.org
> >> Signed-off-by: Kees Cook <keescook@chromium.org>
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
>
> Mhm, I'm not sure if this is a good idea. That is a structure filled in
> by the firmware, isn't it?
>
> That would imply that we might need to byte swap count before it is
> checkable.

True. Good point.  Same for the other amdgpu patch.

Alex

>
> Regards,
> Christian.
>
> >
> >> ---
> >>   drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.h | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.h b/dr=
ivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.h
> >> index 808e0ecbe1f0..42adc2a3dcbc 100644
> >> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.h
> >> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.h
> >> @@ -192,7 +192,7 @@ struct smu10_clock_voltage_dependency_record {
> >>
> >>   struct smu10_voltage_dependency_table {
> >>          uint32_t count;
> >> -       struct smu10_clock_voltage_dependency_record entries[];
> >> +       struct smu10_clock_voltage_dependency_record entries[] __count=
ed_by(count);
> >>   };
> >>
> >>   struct smu10_clock_voltage_information {
> >> --
> >> 2.34.1
> >>
>

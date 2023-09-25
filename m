Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0747ADE21
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 19:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjIYR4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 13:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjIYR4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 13:56:34 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A4C116;
        Mon, 25 Sep 2023 10:56:27 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-57ad95c555eso3870011eaf.3;
        Mon, 25 Sep 2023 10:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695664587; x=1696269387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1F9rg4X23ujFzzgF5l8L8aKk/znEnb8MB1jEXGz6ng=;
        b=g+CjNbBUnovRogi7wun3lBlAcEshVtBKflFUL4/Es29kOdheOO8p3chE6gXgRC3zyt
         AdfskP2/RRLOxSm0/zNsGlaFbDdCpsYmREZ4+Cc5w07MSZktPXUhnneL9dRDiQb/m6at
         zqDFzBwIfgiBrCVIgE8mHFnYqPEeSVTxvWw6uXl5z2aEqBtjePeq2+zE0v1bhBZPIpkk
         Ewhaw4iJ0+Rg3WP2Wr33cCbpJr3gvR7siBS01WEVw2g3f9QBOTVWIJjMppzLzcg9apVX
         qE5jFdC1J9rJ6IRRRS6ZP/yHm/7wD1M6Sg4wKCtIYOxPZwFkwsACs613pYtvbaYV3ZM6
         RcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695664587; x=1696269387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1F9rg4X23ujFzzgF5l8L8aKk/znEnb8MB1jEXGz6ng=;
        b=SMAU9VqdgPQV4mbS8iCFXT0kvI+RBF50xd0u5fTijODCeS1K4PFOo6IKn2ZaO7Y2s/
         JalYjlgQLp4DaEExQ6V2Ix+I1T5YAeW3xNBkaCwjI2HbIwG7wFJHLY0auMZiPDcxDNAe
         EDb3Ubp+NDgmqtjaOQ+rMr/PhJlgj0d8ju673hptjA7JLF2+zuwICS8pLfsQDpuhrsqh
         YLpiriCfeeUEOZUc8bu3fnB4+lNDLUeJQfviakJUohvXHYqVqaTERAA2WPbMSv13cVra
         uCM3VGtsMxP37hSZhgrYb/CwD2aElLmAk8/l5i4AxqDahnb/GvrMT552v8qQa9KNkF5W
         5YPg==
X-Gm-Message-State: AOJu0Yz0z29CxjYW0kRzdAS0fAc4SAThVYXF32YyKXlrpNvKMt7inXo8
        VTgb1mb9cYyllQFTxpNKJ1xDqVp5G1/hdj2fvUI=
X-Google-Smtp-Source: AGHT+IHKGmpSNoLKRlPKgMz3PfLu9l0asTJ/KJeRR4YlCqKx/0xgmJzaJCWHK+NWln0berAZsxELHx2SNeMkUMNHpCU=
X-Received: by 2002:a05:6870:c227:b0:1db:3679:198a with SMTP id
 z39-20020a056870c22700b001db3679198amr8758871oae.24.1695664587047; Mon, 25
 Sep 2023 10:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230922173110.work.084-kees@kernel.org> <20230922173216.3823169-1-keescook@chromium.org>
 <CADnq5_P2p3bmczci=pU+pG6f9+hqn=-xp1EynP2345CJZRW08w@mail.gmail.com>
 <2635922e-f52a-4e91-40c6-4f1358972786@amd.com> <202309251051.EE3ECE7B@keescook>
In-Reply-To: <202309251051.EE3ECE7B@keescook>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 25 Sep 2023 13:56:16 -0400
Message-ID: <CADnq5_PaXmFa6N_2-NRp7_2+m3TYt8s--4aYm1UTnQKXDUhwYw@mail.gmail.com>
Subject: Re: [PATCH 1/9] drm/amd/pm: Annotate struct smu10_voltage_dependency_table
 with __counted_by
To:     Kees Cook <keescook@chromium.org>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 1:52=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Mon, Sep 25, 2023 at 08:30:30AM +0200, Christian K=C3=B6nig wrote:
> > Am 22.09.23 um 19:41 schrieb Alex Deucher:
> > > On Fri, Sep 22, 2023 at 1:32=E2=80=AFPM Kees Cook <keescook@chromium.=
org> wrote:
> > > > Prepare for the coming implementation by GCC and Clang of the __cou=
nted_by
> > > > attribute. Flexible array members annotated with __counted_by can h=
ave
> > > > their accesses bounds-checked at run-time checking via CONFIG_UBSAN=
_BOUNDS
> > > > (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-f=
amily
> > > > functions).
> > > >
> > > > As found with Coccinelle[1], add __counted_by for struct smu10_volt=
age_dependency_table.
> > > >
> > > > [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/exam=
ples/counted_by.cocci
> > > >
> > > > Cc: Evan Quan <evan.quan@amd.com>
> > > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > > Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> > > > Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> > > > Cc: David Airlie <airlied@gmail.com>
> > > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > > Cc: Xiaojian Du <Xiaojian.Du@amd.com>
> > > > Cc: Huang Rui <ray.huang@amd.com>
> > > > Cc: Kevin Wang <kevin1.wang@amd.com>
> > > > Cc: amd-gfx@lists.freedesktop.org
> > > > Cc: dri-devel@lists.freedesktop.org
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > Mhm, I'm not sure if this is a good idea. That is a structure filled in=
 by
> > the firmware, isn't it?
> >
> > That would imply that we might need to byte swap count before it is
> > checkable.
>
> The script found this instance because of this:
>
> static int smu10_get_clock_voltage_dependency_table(struct pp_hwmgr *hwmg=
r,
>                         struct smu10_voltage_dependency_table **pptable,
>                         uint32_t num_entry, const DpmClock_t *pclk_depend=
ency_table)
> {
>         uint32_t i;
>         struct smu10_voltage_dependency_table *ptable;
>
>         ptable =3D kzalloc(struct_size(ptable, entries, num_entry), GFP_K=
ERNEL);
>         if (NULL =3D=3D ptable)
>                 return -ENOMEM;
>
>         ptable->count =3D num_entry;
>
> So the implication is that it's native byte order... but you tell me! I
> certainly don't want this annotation if it's going to break stuff. :)

In this case, the code is for an integrated GPU in an x86 CPU so the
firmware and driver endianness match.  You wouldn't find a stand alone
dGPU that uses this structure.  In this case it's ok.  False alarm.

Alex

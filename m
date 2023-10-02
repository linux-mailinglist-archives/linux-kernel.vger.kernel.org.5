Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F867B582C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238529AbjJBQxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjJBQx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:53:28 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2483A7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 09:53:25 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c61acd1285so38095ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 09:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696265605; x=1696870405; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zPrUH5J+k/nTCuPqHTvyGlvTCCkInD9EOwhmWD637e8=;
        b=f16iptU4NGHN2Gshz+newGrq9CO5Bcs/ufv6XeLLZ85fOMW1YLhZQmOVWTQIY8rt+8
         ON2yqMF+f1r0+7a+TlMkpnSLafnmqIBYGJ6Fi7JT2SlM9MOgZdAqte8NUOzgnc7Q5swn
         FDoEZ/qC4MC8IeDPukdjDGGFpV+b/aIrxufN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696265605; x=1696870405;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zPrUH5J+k/nTCuPqHTvyGlvTCCkInD9EOwhmWD637e8=;
        b=KgSKyISTTFST3Q1qn7rl27CXVvlLelKtFlchNcFaTkiu60GdzmD2hhYAhmN6kpjsK3
         Tmwv/+dMQrkPzJIjft2ODQowSnnKzonNtWL8foMDXWZnZ6yQWqJs3lGr1zDpmfzrASDW
         UWnmwCiTq15H3vnVBN/bzWJ22xF5jMwFV1tIM64b7fnXfY98jCycp2uGiIyvfwgx2nmU
         TuULD3EhypIvp6GyxhI7QZeF/MEzFtxdnMfBLae/xqFwm+zXPij848bSTLClJo2No5+g
         V0wIJz7B0jPbkpfYJYL69ef207CC08gq7yDWEOMQrd9QEZpyt1BFkuLTzErJbQwC0VFy
         tGJw==
X-Gm-Message-State: AOJu0Yz69F/Y6oqSc4eQnR1kPAh0k6YIyPBoP1K5opOOTmJQbjt9yT+V
        Qw6mxSBQELTL6w2J9Np7fjQSCA==
X-Google-Smtp-Source: AGHT+IFfbFaeQO9242udM1wOdI7Nv+81OlhqJQIxio/cgMdcj4JL3Y+uRVoQhZuEb4vC1HVU7rLNZA==
X-Received: by 2002:a17:902:ec8d:b0:1c6:1fc3:6857 with SMTP id x13-20020a170902ec8d00b001c61fc36857mr13017401plg.27.1696265605046;
        Mon, 02 Oct 2023 09:53:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f54600b001c74876f032sm6638850plf.162.2023.10.02.09.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 09:53:24 -0700 (PDT)
Date:   Mon, 2 Oct 2023 09:53:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        David Airlie <airlied@gmail.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Karol Herbst <kherbst@redhat.com>, Tom Rix <trix@redhat.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        dri-devel@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Prike Liang <Prike.Liang@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Matthew Brost <matthew.brost@intel.com>,
        Evan Quan <evan.quan@amd.com>, Emma Anholt <emma@anholt.net>,
        amd-gfx@lists.freedesktop.org,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        nouveau@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Chia-I Wu <olvaffe@gmail.com>, llvm@lists.linux.dev,
        Yifan Zhang <yifan1.zhang@amd.com>,
        linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        Kevin Wang <kevin1.wang@amd.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>, Le Ma <le.ma@amd.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        virtualization@lists.linux-foundation.org,
        Sean Paul <sean@poorly.run>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Xiaojian Du <Xiaojian.Du@amd.com>, Lang Yu <Lang.Yu@amd.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Tejas Upadhyay <tejas.upadhyay@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Rob Clark <robdclark@gmail.com>, Melissa Wen <mwen@igalia.com>,
        John Harrison <john.c.harrison@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        freedreno@lists.freedesktop.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Zack Rusin <zackr@vmware.com>, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/9] drm: Annotate structs with __counted_by
Message-ID: <202310020952.E7DE0948C0@keescook>
References: <20230922173110.work.084-kees@kernel.org>
 <169601600138.3014939.8511343741428844249.b4-ty@chromium.org>
 <83cd056c-52ae-01dd-7576-42d41da64c26@gmail.com>
 <CADnq5_Ma2CrLYggJHKFEObsNmUoqJwb2p1xai5DfL=m43U6zEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_Ma2CrLYggJHKFEObsNmUoqJwb2p1xai5DfL=m43U6zEA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 11:06:19AM -0400, Alex Deucher wrote:
> On Mon, Oct 2, 2023 at 5:20 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
> >
> > Am 29.09.23 um 21:33 schrieb Kees Cook:
> > > On Fri, 22 Sep 2023 10:32:05 -0700, Kees Cook wrote:
> > >> This is a batch of patches touching drm for preparing for the coming
> > >> implementation by GCC and Clang of the __counted_by attribute. Flexible
> > >> array members annotated with __counted_by can have their accesses
> > >> bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS (for array
> > >> indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family functions).
> > >>
> > >> As found with Coccinelle[1], add __counted_by to structs that would
> > >> benefit from the annotation.
> > >>
> > >> [...]
> > > Since this got Acks, I figure I should carry it in my tree. Let me know
> > > if this should go via drm instead.
> > >
> > > Applied to for-next/hardening, thanks!
> > >
> > > [1/9] drm/amd/pm: Annotate struct smu10_voltage_dependency_table with __counted_by
> > >        https://git.kernel.org/kees/c/a6046ac659d6
> >
> > STOP! In a follow up discussion Alex and I figured out that this won't work.

I'm so confused; from the discussion I saw that Alex said both instances
were false positives?

> >
> > The value in the structure is byte swapped based on some firmware
> > endianness which not necessary matches the CPU endianness.
> 
> SMU10 is APU only so the endianess of the SMU firmware and the CPU
> will always match.

Which I think is what is being said here?

> > Please revert that one from going upstream if it's already on it's way.
> >
> > And because of those reasons I strongly think that patches like this
> > should go through the DRM tree :)

Sure, that's fine -- please let me know. It was others Acked/etc. Who
should carry these patches?

Thanks!

-Kees


> >
> > Regards,
> > Christian.
> >
> > > [2/9] drm/amdgpu/discovery: Annotate struct ip_hw_instance with __counted_by
> > >        https://git.kernel.org/kees/c/4df33089b46f
> > > [3/9] drm/i915/selftests: Annotate struct perf_series with __counted_by
> > >        https://git.kernel.org/kees/c/ffd3f823bdf6
> > > [4/9] drm/msm/dpu: Annotate struct dpu_hw_intr with __counted_by
> > >        https://git.kernel.org/kees/c/2de35a989b76
> > > [5/9] drm/nouveau/pm: Annotate struct nvkm_perfdom with __counted_by
> > >        https://git.kernel.org/kees/c/188aeb08bfaa
> > > [6/9] drm/vc4: Annotate struct vc4_perfmon with __counted_by
> > >        https://git.kernel.org/kees/c/59a54dc896c3
> > > [7/9] drm/virtio: Annotate struct virtio_gpu_object_array with __counted_by
> > >        https://git.kernel.org/kees/c/5cd476de33af
> > > [8/9] drm/vmwgfx: Annotate struct vmw_surface_dirty with __counted_by
> > >        https://git.kernel.org/kees/c/b426f2e5356a
> > > [9/9] drm/v3d: Annotate struct v3d_perfmon with __counted_by
> > >        https://git.kernel.org/kees/c/dc662fa1b0e4
> > >
> > > Take care,
> > >
> >

-- 
Kees Cook

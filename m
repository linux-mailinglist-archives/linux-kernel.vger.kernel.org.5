Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1677B59DE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbjJBSI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 14:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238053AbjJBSIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:08:23 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC1C9E
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 11:08:19 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-690f7d73a3aso56152b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 11:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696270099; x=1696874899; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=muC7B8fW75NQ6UziQ28q/q7hcKRLv9QhdzwxKJUqnpg=;
        b=G3NlaP3YaI91sck9zFTD2dJRDN4xk7xGcgoHcgRQhJHyFfSZmQlKFpPJM8vaz1/OlL
         oRhGvuP3GCZ1FyiPv/a4GIA1NR2EIjtUaYPqVINl3afdPjiZtnLB7jOikks+iJiGf7xl
         3wFxZrZDLPUypijXkv0SantcFE4TXC9L5QHVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696270099; x=1696874899;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=muC7B8fW75NQ6UziQ28q/q7hcKRLv9QhdzwxKJUqnpg=;
        b=h6Nf5aLuh8U467E5reF8wyZNhcMeXVrPW7nZNCTCggqkcyeBFSQF5rkPXMNZEdPwd0
         uoAFrC8mWdY0tqbw03JhHBPQrm3LHioriKDrFK6HefpuZ9ZkYCV1SqNXIecdmJRBlspN
         m0FGc1PZHwlPKKiE7cc0+i58yrl3VE64r1oykTEfIE6a0cYZ+wEBZMJc2VPkyl4zp+L2
         fV9O4Rd1BbK2O7xME2+/HSMgbTJh+R6tr6usoufEBw+6RIb8AQEtb4RMDiYw7N5uVU2H
         sgqR1+A5hmA8UbCDAIVTh5S1wlS8uQUW0GnGFJdcJ2wjP5VAZZrNJ17sa2IQXjq4c9PU
         HXAQ==
X-Gm-Message-State: AOJu0Yw2SdZ6FNuX99QSZCxJ6gGoQsBcu42VvMg4dsTg9lSvnbc4uRaD
        m3A/79FxmIW5ODGBuFjBwF83rA==
X-Google-Smtp-Source: AGHT+IGK/e2oSlCojI587t74YMxVHXLqvaWj0VPyFJA0HDYydaNO3UN+zUcs2ZUYssbDXqdQDti0TQ==
X-Received: by 2002:a05:6a21:6d90:b0:162:d056:9f52 with SMTP id wl16-20020a056a216d9000b00162d0569f52mr13164891pzb.14.1696270098813;
        Mon, 02 Oct 2023 11:08:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 22-20020aa79216000000b0068fb8e18971sm19824611pfo.130.2023.10.02.11.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 11:08:18 -0700 (PDT)
Date:   Mon, 2 Oct 2023 11:08:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
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
Message-ID: <202310021107.9BB46FB8E@keescook>
References: <20230922173110.work.084-kees@kernel.org>
 <169601600138.3014939.8511343741428844249.b4-ty@chromium.org>
 <83cd056c-52ae-01dd-7576-42d41da64c26@gmail.com>
 <CADnq5_Ma2CrLYggJHKFEObsNmUoqJwb2p1xai5DfL=m43U6zEA@mail.gmail.com>
 <202310020952.E7DE0948C0@keescook>
 <10644b5f-b0a7-85ef-0658-2353ee14df0d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10644b5f-b0a7-85ef-0658-2353ee14df0d@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 08:01:57PM +0200, Christian König wrote:
> Am 02.10.23 um 18:53 schrieb Kees Cook:
> > On Mon, Oct 02, 2023 at 11:06:19AM -0400, Alex Deucher wrote:
> > > On Mon, Oct 2, 2023 at 5:20 AM Christian König
> > > <ckoenig.leichtzumerken@gmail.com> wrote:
> > > > Am 29.09.23 um 21:33 schrieb Kees Cook:
> > > > > On Fri, 22 Sep 2023 10:32:05 -0700, Kees Cook wrote:
> > > > > > This is a batch of patches touching drm for preparing for the coming
> > > > > > implementation by GCC and Clang of the __counted_by attribute. Flexible
> > > > > > array members annotated with __counted_by can have their accesses
> > > > > > bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS (for array
> > > > > > indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family functions).
> > > > > > 
> > > > > > As found with Coccinelle[1], add __counted_by to structs that would
> > > > > > benefit from the annotation.
> > > > > > 
> > > > > > [...]
> > > > > Since this got Acks, I figure I should carry it in my tree. Let me know
> > > > > if this should go via drm instead.
> > > > > 
> > > > > Applied to for-next/hardening, thanks!
> > > > > 
> > > > > [1/9] drm/amd/pm: Annotate struct smu10_voltage_dependency_table with __counted_by
> > > > >         https://git.kernel.org/kees/c/a6046ac659d6
> > > > STOP! In a follow up discussion Alex and I figured out that this won't work.
> > I'm so confused; from the discussion I saw that Alex said both instances
> > were false positives?
> > 
> > > > The value in the structure is byte swapped based on some firmware
> > > > endianness which not necessary matches the CPU endianness.
> > > SMU10 is APU only so the endianess of the SMU firmware and the CPU
> > > will always match.
> > Which I think is what is being said here?
> > 
> > > > Please revert that one from going upstream if it's already on it's way.
> > > > 
> > > > And because of those reasons I strongly think that patches like this
> > > > should go through the DRM tree :)
> > Sure, that's fine -- please let me know. It was others Acked/etc. Who
> > should carry these patches?
> 
> Probably best if the relevant maintainer pick them up individually.
> 
> Some of those structures are filled in by firmware/hardware and only the
> maintainers can judge if that value actually matches what the compiler
> needs.
> 
> We have cases where individual bits are used as flags or when the size is
> byte swapped etc...
> 
> Even Alex and I didn't immediately say how and where that field is actually
> used and had to dig that up. That's where the confusion came from.

Okay, I've dropped them all from my tree. Several had Acks/Reviews, so
hopefully those can get picked up for the DRM tree?

Thanks!

-Kees

-- 
Kees Cook

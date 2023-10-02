Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAE27B5A23
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238759AbjJBSWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 14:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238393AbjJBSW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:22:28 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E3AD3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 11:22:25 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5892832f8daso494104a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 11:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696270944; x=1696875744; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6vMwsjYrlAei3Hxc6ZjjNt+EO9kZEbPnxPSvxjTe6qw=;
        b=cPlNc38yrERG6xjKCfIraTaao/KlIj/KqDXcZ+eR8xsGpq4GvIIuW7ZTHzSlBJ3q5i
         lys/rxdMdSAT2eV3/DTnuqfKOJ6NGaYGWxFaM45hSNrzbZg55INaSB4qnqonvuv9rajl
         KfeUJlJhYhno4DOltLrXaFX8GBxNs3VhyvXXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696270944; x=1696875744;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6vMwsjYrlAei3Hxc6ZjjNt+EO9kZEbPnxPSvxjTe6qw=;
        b=iZWeKNHg6QydWI0XgdlW7xWrZk9WGJY9dj7LX/Yh1LpAwTEuxPA0yg2ZMLJm4mmG/D
         6AEY/yZG+sT89Gdwdd3pbmWXf0cnn3ucNmWOoZAUqy8moG4hGQIniO2BSNreC/UTZgr3
         fsT9s1Jfu8/IUcYT3gtwUbZ8UVR1zqtsCwU7AmC0hNx2nhoUnbCMLYsGyXDCscm2/HqI
         ScOuncV10iK9VZWd7g0Z27myyur7TYaAVrwDkeKJ9qQA8LUgMmSPRi+CA1H18Fqwjjfk
         XJqaqbuugZ5B8Q6pahyme3TKnv0BgNoEcyngAxtZMEydWuAQWX4bQ0+E6dakNx6CiT7B
         oEeg==
X-Gm-Message-State: AOJu0YxF8FBwgvNHVebgryym9JO8+d8BkO22hFgQl6AgoVdYelb4moiL
        E/sQHYMR/pgAyKYbAG1MfGNtUA==
X-Google-Smtp-Source: AGHT+IFN44X3NT3rmon5KyimO6IH657T1P2k+qKM5XXdV6IMP4cnvC0Xx05CvgoaqkelMPJSCwLVWA==
X-Received: by 2002:a17:90b:4414:b0:274:cf7e:f11c with SMTP id hx20-20020a17090b441400b00274cf7ef11cmr529470pjb.19.1696270944438;
        Mon, 02 Oct 2023 11:22:24 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ml24-20020a17090b361800b00262e485156esm6569943pjb.57.2023.10.02.11.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 11:22:23 -0700 (PDT)
Date:   Mon, 2 Oct 2023 11:22:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        Alex Deucher <alexdeucher@gmail.com>,
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
        freedreno@lists.freedesktop.org, Zack Rusin <zackr@vmware.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/9] drm: Annotate structs with __counted_by
Message-ID: <202310021122.B6DA850FB0@keescook>
References: <20230922173110.work.084-kees@kernel.org>
 <169601600138.3014939.8511343741428844249.b4-ty@chromium.org>
 <83cd056c-52ae-01dd-7576-42d41da64c26@gmail.com>
 <CADnq5_Ma2CrLYggJHKFEObsNmUoqJwb2p1xai5DfL=m43U6zEA@mail.gmail.com>
 <202310020952.E7DE0948C0@keescook>
 <10644b5f-b0a7-85ef-0658-2353ee14df0d@gmail.com>
 <202310021107.9BB46FB8E@keescook>
 <0be2dfa4-b6c1-f62a-66e1-615da7aa3c76@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0be2dfa4-b6c1-f62a-66e1-615da7aa3c76@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 08:11:41PM +0200, Christian König wrote:
> Am 02.10.23 um 20:08 schrieb Kees Cook:
> > On Mon, Oct 02, 2023 at 08:01:57PM +0200, Christian König wrote:
> > > Am 02.10.23 um 18:53 schrieb Kees Cook:
> > > > On Mon, Oct 02, 2023 at 11:06:19AM -0400, Alex Deucher wrote:
> > > > > On Mon, Oct 2, 2023 at 5:20 AM Christian König
> > > > > <ckoenig.leichtzumerken@gmail.com> wrote:
> > > > > > Am 29.09.23 um 21:33 schrieb Kees Cook:
> > > > > > > On Fri, 22 Sep 2023 10:32:05 -0700, Kees Cook wrote:
> > > > > > > > This is a batch of patches touching drm for preparing for the coming
> > > > > > > > implementation by GCC and Clang of the __counted_by attribute. Flexible
> > > > > > > > array members annotated with __counted_by can have their accesses
> > > > > > > > bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS (for array
> > > > > > > > indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family functions).
> > > > > > > > 
> > > > > > > > As found with Coccinelle[1], add __counted_by to structs that would
> > > > > > > > benefit from the annotation.
> > > > > > > > 
> > > > > > > > [...]
> > > > > > > Since this got Acks, I figure I should carry it in my tree. Let me know
> > > > > > > if this should go via drm instead.
> > > > > > > 
> > > > > > > Applied to for-next/hardening, thanks!
> > > > > > > 
> > > > > > > [1/9] drm/amd/pm: Annotate struct smu10_voltage_dependency_table with __counted_by
> > > > > > >          https://git.kernel.org/kees/c/a6046ac659d6
> > > > > > STOP! In a follow up discussion Alex and I figured out that this won't work.
> > > > I'm so confused; from the discussion I saw that Alex said both instances
> > > > were false positives?
> > > > 
> > > > > > The value in the structure is byte swapped based on some firmware
> > > > > > endianness which not necessary matches the CPU endianness.
> > > > > SMU10 is APU only so the endianess of the SMU firmware and the CPU
> > > > > will always match.
> > > > Which I think is what is being said here?
> > > > 
> > > > > > Please revert that one from going upstream if it's already on it's way.
> > > > > > 
> > > > > > And because of those reasons I strongly think that patches like this
> > > > > > should go through the DRM tree :)
> > > > Sure, that's fine -- please let me know. It was others Acked/etc. Who
> > > > should carry these patches?
> > > Probably best if the relevant maintainer pick them up individually.
> > > 
> > > Some of those structures are filled in by firmware/hardware and only the
> > > maintainers can judge if that value actually matches what the compiler
> > > needs.
> > > 
> > > We have cases where individual bits are used as flags or when the size is
> > > byte swapped etc...
> > > 
> > > Even Alex and I didn't immediately say how and where that field is actually
> > > used and had to dig that up. That's where the confusion came from.
> > Okay, I've dropped them all from my tree. Several had Acks/Reviews, so
> > hopefully those can get picked up for the DRM tree?
> 
> I will pick those up to go through drm-misc-next.
> 
> Going to ping maintainers once more when I'm not sure if stuff is correct or
> not.

Sounds great; thanks!

-Kees

-- 
Kees Cook

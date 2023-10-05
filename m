Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394607BA61B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbjJEQ1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243196AbjJEQWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:22:37 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F45F30E9
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 09:16:24 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6969b391791so905472b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 09:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696522583; x=1697127383; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xpZu6lqlyEvAN7T4WQyZZbFvUnbP262xmkxGmbRAMgI=;
        b=GgnioRLSfuHluJcKeRVhJg2pJrRhq/2PX+jbibkiDkTO+pmOZPLczBLmEoTGyR4DDg
         LlgTMxnlBMFBrGT02fujhcmCmtkMhjWuZcWex/BjFg7Sg9mwI/m5KGMPx/VcPdwlI01B
         uC/TKlTqDRBhG/u3NYIC7Jo8xud5BAOa9vN7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696522583; x=1697127383;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xpZu6lqlyEvAN7T4WQyZZbFvUnbP262xmkxGmbRAMgI=;
        b=VHyL6bET66SKn2LDYWstIOhERE5N/+nd4irnjnP2UrZeLmYBsXtXO8ewWLeFGncdok
         rUXlRc+wCmWW+8LX6oilw8sGh8uvUGURGYm2yuz230Ev+i/O0n//rqJRL+pq8OydO202
         HjI4BQBfCXJeFTX1qzax3Lh9oo0fTjtBn+tJhGHk6pcZdPB/bbpzmHVzEmuDQCjCIf0E
         omeIAIpVjTcjIbPmGajj0PIEyF25ENYmq5E5HG+/icBWc5tLf6UKUjXTkC2eWDRguNJT
         +Z9CWQvCCHt8Mi0g4FJ+TqdhykfKXMS5+Gyw1zSa7tAqKDeU0NXLPGk/dJjYDlqSF5le
         qu2g==
X-Gm-Message-State: AOJu0YyYjxkFvuv8yKiGCcYBE0GO5HNkwzClFWCJOg1VoeKS28lQd7XQ
        stWO7uYoywCjl6PpYiJqVyDauA==
X-Google-Smtp-Source: AGHT+IE6Ak6UYgEgJauQ6Y1uxdTD0V7hmNR5oIggJNBHvibyJu+tgYd9HJ0fF4GhOMQzLDOwnBAQAw==
X-Received: by 2002:a05:6a20:7d84:b0:15c:b7ba:9137 with SMTP id v4-20020a056a207d8400b0015cb7ba9137mr6912555pzj.2.1696522583080;
        Thu, 05 Oct 2023 09:16:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902d38400b001bc675068e2sm1903597pld.111.2023.10.05.09.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 09:16:22 -0700 (PDT)
Date:   Thu, 5 Oct 2023 09:16:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
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
Message-ID: <202310050915.ABB0419C@keescook>
References: <20230922173110.work.084-kees@kernel.org>
 <169601600138.3014939.8511343741428844249.b4-ty@chromium.org>
 <83cd056c-52ae-01dd-7576-42d41da64c26@gmail.com>
 <CADnq5_Ma2CrLYggJHKFEObsNmUoqJwb2p1xai5DfL=m43U6zEA@mail.gmail.com>
 <202310020952.E7DE0948C0@keescook>
 <10644b5f-b0a7-85ef-0658-2353ee14df0d@gmail.com>
 <202310021107.9BB46FB8E@keescook>
 <0be2dfa4-b6c1-f62a-66e1-615da7aa3c76@amd.com>
 <202310021122.B6DA850FB0@keescook>
 <d58bbe17-efa7-4548-9c7d-bf0310d31ef5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d58bbe17-efa7-4548-9c7d-bf0310d31ef5@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 11:42:38AM +0200, Christian König wrote:
> Am 02.10.23 um 20:22 schrieb Kees Cook:
> > On Mon, Oct 02, 2023 at 08:11:41PM +0200, Christian König wrote:
> > > Am 02.10.23 um 20:08 schrieb Kees Cook:
> > > > On Mon, Oct 02, 2023 at 08:01:57PM +0200, Christian König wrote:
> > > > > Am 02.10.23 um 18:53 schrieb Kees Cook:
> > > > > > On Mon, Oct 02, 2023 at 11:06:19AM -0400, Alex Deucher wrote:
> > > > > > > On Mon, Oct 2, 2023 at 5:20 AM Christian König
> > > > > > > <ckoenig.leichtzumerken@gmail.com> wrote:
> > > > > > > > Am 29.09.23 um 21:33 schrieb Kees Cook:
> > > > > > > > > On Fri, 22 Sep 2023 10:32:05 -0700, Kees Cook wrote:
> > > > > > > > > > This is a batch of patches touching drm for preparing for the coming
> > > > > > > > > > implementation by GCC and Clang of the __counted_by attribute. Flexible
> > > > > > > > > > array members annotated with __counted_by can have their accesses
> > > > > > > > > > bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS (for array
> > > > > > > > > > indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family functions).
> > > > > > > > > > 
> > > > > > > > > > As found with Coccinelle[1], add __counted_by to structs that would
> > > > > > > > > > benefit from the annotation.
> > > > > > > > > > 
> > > > > > > > > > [...]
> > > > > > > > > Since this got Acks, I figure I should carry it in my tree. Let me know
> > > > > > > > > if this should go via drm instead.
> > > > > > > > > 
> > > > > > > > > Applied to for-next/hardening, thanks!
> > > > > > > > > 
> > > > > > > > > [1/9] drm/amd/pm: Annotate struct smu10_voltage_dependency_table with __counted_by
> > > > > > > > >           https://git.kernel.org/kees/c/a6046ac659d6
> > > > > > > > STOP! In a follow up discussion Alex and I figured out that this won't work.
> > > > > > I'm so confused; from the discussion I saw that Alex said both instances
> > > > > > were false positives?
> > > > > > 
> > > > > > > > The value in the structure is byte swapped based on some firmware
> > > > > > > > endianness which not necessary matches the CPU endianness.
> > > > > > > SMU10 is APU only so the endianess of the SMU firmware and the CPU
> > > > > > > will always match.
> > > > > > Which I think is what is being said here?
> > > > > > 
> > > > > > > > Please revert that one from going upstream if it's already on it's way.
> > > > > > > > 
> > > > > > > > And because of those reasons I strongly think that patches like this
> > > > > > > > should go through the DRM tree :)
> > > > > > Sure, that's fine -- please let me know. It was others Acked/etc. Who
> > > > > > should carry these patches?
> > > > > Probably best if the relevant maintainer pick them up individually.
> > > > > 
> > > > > Some of those structures are filled in by firmware/hardware and only the
> > > > > maintainers can judge if that value actually matches what the compiler
> > > > > needs.
> > > > > 
> > > > > We have cases where individual bits are used as flags or when the size is
> > > > > byte swapped etc...
> > > > > 
> > > > > Even Alex and I didn't immediately say how and where that field is actually
> > > > > used and had to dig that up. That's where the confusion came from.
> > > > Okay, I've dropped them all from my tree. Several had Acks/Reviews, so
> > > > hopefully those can get picked up for the DRM tree?
> > > I will pick those up to go through drm-misc-next.
> > > 
> > > Going to ping maintainers once more when I'm not sure if stuff is correct or
> > > not.
> > Sounds great; thanks!
> 
> I wasn't 100% sure for the VC4 patch, but pushed the whole set to
> drm-misc-next anyway.
> 
> This also means that the patches are now auto merged into the drm-tip
> integration branch and should any build or unit test go boom we should
> notice immediately and can revert it pretty easily.

Thanks very much; I'll keep an eye out for any reports.

-- 
Kees Cook

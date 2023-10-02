Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE167B567D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237948AbjJBPGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237474AbjJBPGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:06:34 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BDA9D;
        Mon,  2 Oct 2023 08:06:31 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6c4fa1c804bso5514464a34.2;
        Mon, 02 Oct 2023 08:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696259191; x=1696863991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0wIcnLi0eW3KIpAYRJEn1N+1DF/SZtUbN/0mO//zy4=;
        b=lQmbbl+K/9N2hpTJxNy3mX5TsM1YCoHHrdezyjnneJ8vWmZgsSbAi2hTT8HHKqD6+o
         CXUo1droddx4Dorq7yWKIXujMBKEjYgcSLLZmO7NfKv8+QRJJ4K3taLyf7UGeiUe2UXv
         uh1XSgEpxuwwTtvah6yXqTUGHDp6cRIQgHahUNTmUETAi7PzNlxwKO25Wk14zDx4A9AL
         zVkX5YMlEkX+wX4v78Prf4VSN9/lJMsirR143C8L9Uo6CemIIK9o03UWZ44gl0KOIRq0
         Z8bheAgqoOa/eUx0n9NpxtH2f8lSeWvQ8Va7/CovtZ9SqOuq/yKQ8nGuBNqFqLgPOXOg
         u3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696259191; x=1696863991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0wIcnLi0eW3KIpAYRJEn1N+1DF/SZtUbN/0mO//zy4=;
        b=gnja4DceimnPtDJFvz7lx0B2BH8T7yzMpQdrT3hbTau0XKxJ32GYGa2EbPbmFaRP+n
         Y0zw6gmJRkuwxq3XppgV7LBWJUaproBSnMXx5x9NCtb8rXe9Lr230BWwvK/VjV1LWy3Z
         IW+qNIKse5u6pWFKb9pax0R/+rkIVB3HQWKTS8r4QBFkC9XZsdCzziw48tmksZ6rEthW
         9iKOvTSWiNvYk9s6VgkVmFmJikv4oVAwZ3F8sTyKO4jLv+DoCfoLa/v3BJzlXCIOtrt0
         LhdPd7anLR8Kk9udECEYVuxSg8gk55wpsag9JrAxEjXmK44+tYvWHIqijZlX+CYjgq1M
         4UAA==
X-Gm-Message-State: AOJu0YwOKlKN2bZC/iG6gAu5zUTVfy3OaB7fxgoxBSyi+QtGrDsaJHW9
        c+tju83DFYlP1F4OmFoNRu5OTnhh2YNF8hieCIQ=
X-Google-Smtp-Source: AGHT+IEX1je+61h+JUKWDKJZA+eu4NOUlivFnUEzoxSozC/G9+CulawvWCmD9DLQxtVZD1wdvqrdGNPyL3ZP6lrp6ME=
X-Received: by 2002:a05:6870:a115:b0:1dd:7fa9:ed52 with SMTP id
 m21-20020a056870a11500b001dd7fa9ed52mr15044564oae.17.1696259190738; Mon, 02
 Oct 2023 08:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230922173110.work.084-kees@kernel.org> <169601600138.3014939.8511343741428844249.b4-ty@chromium.org>
 <83cd056c-52ae-01dd-7576-42d41da64c26@gmail.com>
In-Reply-To: <83cd056c-52ae-01dd-7576-42d41da64c26@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 2 Oct 2023 11:06:19 -0400
Message-ID: <CADnq5_Ma2CrLYggJHKFEObsNmUoqJwb2p1xai5DfL=m43U6zEA@mail.gmail.com>
Subject: Re: [PATCH 0/9] drm: Annotate structs with __counted_by
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
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
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Zack Rusin <zackr@vmware.com>, linux-hardening@vger.kernel.org
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

On Mon, Oct 2, 2023 at 5:20=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 29.09.23 um 21:33 schrieb Kees Cook:
> > On Fri, 22 Sep 2023 10:32:05 -0700, Kees Cook wrote:
> >> This is a batch of patches touching drm for preparing for the coming
> >> implementation by GCC and Clang of the __counted_by attribute. Flexibl=
e
> >> array members annotated with __counted_by can have their accesses
> >> bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS (for array
> >> indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family function=
s).
> >>
> >> As found with Coccinelle[1], add __counted_by to structs that would
> >> benefit from the annotation.
> >>
> >> [...]
> > Since this got Acks, I figure I should carry it in my tree. Let me know
> > if this should go via drm instead.
> >
> > Applied to for-next/hardening, thanks!
> >
> > [1/9] drm/amd/pm: Annotate struct smu10_voltage_dependency_table with _=
_counted_by
> >        https://git.kernel.org/kees/c/a6046ac659d6
>
> STOP! In a follow up discussion Alex and I figured out that this won't wo=
rk.
>
> The value in the structure is byte swapped based on some firmware
> endianness which not necessary matches the CPU endianness.

SMU10 is APU only so the endianess of the SMU firmware and the CPU
will always match.

Alex

>
> Please revert that one from going upstream if it's already on it's way.
>
> And because of those reasons I strongly think that patches like this
> should go through the DRM tree :)
>
> Regards,
> Christian.
>
> > [2/9] drm/amdgpu/discovery: Annotate struct ip_hw_instance with __count=
ed_by
> >        https://git.kernel.org/kees/c/4df33089b46f
> > [3/9] drm/i915/selftests: Annotate struct perf_series with __counted_by
> >        https://git.kernel.org/kees/c/ffd3f823bdf6
> > [4/9] drm/msm/dpu: Annotate struct dpu_hw_intr with __counted_by
> >        https://git.kernel.org/kees/c/2de35a989b76
> > [5/9] drm/nouveau/pm: Annotate struct nvkm_perfdom with __counted_by
> >        https://git.kernel.org/kees/c/188aeb08bfaa
> > [6/9] drm/vc4: Annotate struct vc4_perfmon with __counted_by
> >        https://git.kernel.org/kees/c/59a54dc896c3
> > [7/9] drm/virtio: Annotate struct virtio_gpu_object_array with __counte=
d_by
> >        https://git.kernel.org/kees/c/5cd476de33af
> > [8/9] drm/vmwgfx: Annotate struct vmw_surface_dirty with __counted_by
> >        https://git.kernel.org/kees/c/b426f2e5356a
> > [9/9] drm/v3d: Annotate struct v3d_perfmon with __counted_by
> >        https://git.kernel.org/kees/c/dc662fa1b0e4
> >
> > Take care,
> >
>

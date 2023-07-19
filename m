Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45372759FDD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjGSUdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjGSUd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:33:26 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FB9210E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:33:05 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-5658573b1faso92683eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689798726; x=1692390726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVa5fBSVAdHHhZFj/pRkL4ALpTE995mDIMsnkkRTm0Q=;
        b=Lde5n1cKOA1T4bKffkRp7OCLFw3kIzNszFORWjdILVZqUjkjtj/r9hJnWetWPtfHma
         ljuFtQpXVY4jecYQAp9auj6671m4eJtWAWASvcxJ0vh6TBOL3L3JPhny0qmlkfIO9s+W
         8B9dU1kPuZnzPVLrgJf4wHRzdb2yDbMwGZLSaAOSX8ifu+zNVAZ4k00aAjhvtL71UYFE
         zBzIW5qzWajLb4R1YlKHx0jzIA1FhXb9NOCMhsidexUSwl+9zzaHMeWSsIwt4d/UKdn3
         ou8P9mOiEJewUTZVMKvwVKWKgZcn3ZknSYuePQSkjSIgj6WoH4BvzHG+o4ET6ZkJEN1+
         idEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689798726; x=1692390726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVa5fBSVAdHHhZFj/pRkL4ALpTE995mDIMsnkkRTm0Q=;
        b=FOIEcAWe3lRHPs/EHsXZYEQpAZnT2T/j3PV0IPoKXe/pzBH+0IOpU3jfu0WwMx0NdJ
         M6EqQcc9Y2qH7tuCOKikGu+aKX1V2+Kx8f7CQMPWZ+D+gTHOWjinPAsEuu/chrbUKAQh
         zv62AybE/fd4JU269TmW5e47fcYAv+HEiG0gg5gjmR4eZ3sS+hMAz2Voq2S8ioEb3jwk
         ba8S1kkoicst/ixfKXkvDV2nikX+0z/pSsuJ9BG9ZKz7j9MtHYf0XeAgbnv+krcBHi/y
         oRoihSYcDI3rSR7eov6wmQbxFxcMRulPImzHpH3FhLrFOoos6/9z0/cHnfQVv2yz3u+S
         GsaQ==
X-Gm-Message-State: ABy/qLaZ2WlAEfRgbKYwWQjqDNvHwKeQpG7Ik468hyignc+7I6wU1iuY
        IngCa21APHRakZzcZpW45UINm6QwrsrLBmN2csrfpQ==
X-Google-Smtp-Source: APBJJlG0LOmFWJJYoiI2DoFv8CdP9UbzzCs8Y7kDwJRTGKPR2LDaC31eQP8L8zN0JJDBJcCQwWuezCzERqGP128mCXI=
X-Received: by 2002:a05:6808:138c:b0:3a3:eab8:8710 with SMTP id
 c12-20020a056808138c00b003a3eab88710mr4242718oiw.43.1689798726160; Wed, 19
 Jul 2023 13:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230712114605.519432-1-tvrtko.ursulin@linux.intel.com>
In-Reply-To: <20230712114605.519432-1-tvrtko.ursulin@linux.intel.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Wed, 19 Jul 2023 13:31:54 -0700
Message-ID: <CABdmKX1PUF+X897ZMOr0RNiYdoiL_2NkcSt+Eh55BfW-05LopQ@mail.gmail.com>
Subject: Re: [RFC v5 00/17] DRM cgroup controller with scheduling control and
 memory stats
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
        Kenny.Ho@amd.com,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Brian Welty <brian.welty@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Eero Tamminen <eero.t.tamminen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 4:47=E2=80=AFAM Tvrtko Ursulin
<tvrtko.ursulin@linux.intel.com> wrote:
>
>   drm.memory.stat
>         A nested file containing cumulative memory statistics for the who=
le
>         sub-hierarchy, broken down into separate GPUs and separate memory
>         regions supported by the latter.
>
>         For example::
>
>           $ cat drm.memory.stat
>           card0 region=3Dsystem total=3D12898304 shared=3D0 active=3D0 re=
sident=3D12111872 purgeable=3D167936
>           card0 region=3Dstolen-system total=3D0 shared=3D0 active=3D0 re=
sident=3D0 purgeable=3D0
>
>         Card designation corresponds to the DRM device names and multiple=
 line
>         entries can be present per card.
>
>         Memory region names should be expected to be driver specific with=
 the
>         exception of 'system' which is standardised and applicable for GP=
Us
>         which can operate on system memory buffers.
>
>         Sub-keys 'resident' and 'purgeable' are optional.
>
>         Per category region usage is reported in bytes.
>
>  * Feedback from people interested in drm.active_us and drm.memory.stat i=
s
>    required to understand the use cases and their usefulness (of the fiel=
ds).
>
>    Memory stats are something which was easy to add to my series, since I=
 was
>    already working on the fdinfo memory stats patches, but the question i=
s how
>    useful it is.
>
Hi Tvrtko,

I think this style of driver-defined categories for reporting of
memory could potentially allow us to eliminate the GPU memory tracking
tracepoint used on Android (gpu_mem_total). This would involve reading
drm.memory.stat at the root cgroup (I see it's currently disabled on
the root), which means traversing the whole cgroup tree under the
cgroup lock to generate the values on-demand. This would be done
rarely, but I still wonder what the cost of that would turn out to be.
The drm_memory_stats categories in the output don't seem like a big
value-add for this use-case, but no real objection to them being
there. I know it's called the DRM cgroup controller, but it'd be nice
if there were a way to make the mem tracking part work for any driver
that wishes to participate as many of our devices don't use a DRM
driver. But making that work doesn't look like it would fit very
cleanly into this controller, so I'll just shut up now.

Thanks!
-T.J.

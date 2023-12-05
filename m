Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833A4805B6A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345408AbjLEROR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLEROP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:14:15 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D311B2;
        Tue,  5 Dec 2023 09:14:21 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54c9116d05fso3910506a12.3;
        Tue, 05 Dec 2023 09:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701796459; x=1702401259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRWCEbwpa+lEbKRH93JbcpIUltHp9P4l3x5jAvbRhYU=;
        b=W868KhefZRQGzMB4CEBc+ttQr318fTUsmrPYsSqSzVLvpAVwYm5OdnlWzxrFMzSkTx
         hzkK9G3s6pn1xCPPJW58frcLALCg/g9ygDnjmGmsId7aCOIX+NAIqIDMJUo0qmyPjple
         ZCgzfuAGTnw8srZzI1DIpP0+OY58ThmvPPT3dz1IYE4bwe+JAhhSYAAiqOmqVDGemgJ1
         g98gboarIPWvFwD6ua5XxxoL3RjpeGoLBdBMtJszBoDv9/2CPF5pQzdLWC8/p9MFvxmH
         8aRYOhxhNNh+S9W72kvhRRQJC4/3Y8Ewjzyb4nuz+P19pZQeF4gwjzXvVj/juvqTo+wq
         tTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701796459; x=1702401259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRWCEbwpa+lEbKRH93JbcpIUltHp9P4l3x5jAvbRhYU=;
        b=uH1ayPkwfT1jDp7ynylTpE/EHwWh6Ow/mGPFKEs3MFTwuS4Jjsj0V3cAljdthghEio
         pcEYSSvHH4+vczYKDOVLN2OIRp1qjl+wqwMIvSkPAAilIaN4EpUgrXzTeIoHyXBaOIiP
         trJrRco4xwvkjCgNYZ9pzj80wBAdIKpxHDdbCls9cPmrANVA6M0aIMavP8D4gox5+Xo8
         7tl4ugn3FjyRINptA0jm2EXp5kbT6ZEW3jTwziXhR4gayQIQnVWFa9zpLjaUyJbw+gsr
         Ou1J7EaxhcViS6jAymZpUIEWToPlwxmLLv8VcuQzCmvfkoDdgCITphFHn98/I37s2k8/
         oqLA==
X-Gm-Message-State: AOJu0YzY+wLSyyCKW7c2QFBnzg9GIEVAjaGwAGrHqRUpb53KW/e4gU1c
        fxtrE/nZ4WtaQui3YI44WiBlUX87/VT+4VR5Hso=
X-Google-Smtp-Source: AGHT+IHO2bnhMHc7TCbx5rnqpkgXvooRmLWUByXMa0WUN3FxPFT6t/93eaEMC2EdK3+y7PInpH1Btu/MUBEMFX9ncbg=
X-Received: by 2002:a17:906:2091:b0:a1c:5fa9:5320 with SMTP id
 17-20020a170906209100b00a1c5fa95320mr497872ejq.252.1701796459254; Tue, 05 Dec
 2023 09:14:19 -0800 (PST)
MIME-Version: 1.0
References: <20230322224403.35742-1-robdclark@gmail.com> <b9fb81f1-ac9e-cf3f-5cf4-f2d972d3ed3d@amd.com>
 <CAF6AEGvMwZCLntfYeH3Vg_Z7kYynqdVrinp+pmcbREksK1WGMA@mail.gmail.com>
 <e2fa296b-9b71-a41b-d37d-33f0fac2cd4e@amd.com> <CAF6AEGvdVca_mnZVo9He9oKVfYp84e_kOPWaxX+K5aV4Es9kcQ@mail.gmail.com>
 <CAF6AEGt2D6Ei6OkUK5osz+jWzmkX8tmB1KGi305HaNd=bnQSoA@mail.gmail.com>
 <69d66b9e-5810-4844-a53f-08b7fd8eeccf@amd.com> <CAF6AEGuSexYVL2RF4yVCJptfJgN9vvTgzGWn3CminbsYvctTaw@mail.gmail.com>
 <96665cc5-01ab-4446-af37-e0f456bfe093@amd.com> <CAF6AEGtyUsARUTJb=+LwRQ96665tdcLLBxXH--18FDECuYOP6Q@mail.gmail.com>
In-Reply-To: <CAF6AEGtyUsARUTJb=+LwRQ96665tdcLLBxXH--18FDECuYOP6Q@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 5 Dec 2023 09:14:07 -0800
Message-ID: <CAF6AEGs5uh1sRDzz7xeDr5xZrXdtg7eoWJhPhRgqhcqAeTX1Jg@mail.gmail.com>
Subject: Re: [RFC] drm/scheduler: Unwrap job dependencies
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 8:56=E2=80=AFAM Rob Clark <robdclark@gmail.com> wrot=
e:
>
> On Tue, Dec 5, 2023 at 7:58=E2=80=AFAM Christian K=C3=B6nig <christian.ko=
enig@amd.com> wrote:
> >
> > Am 05.12.23 um 16:41 schrieb Rob Clark:
> > > On Mon, Dec 4, 2023 at 10:46=E2=80=AFPM Christian K=C3=B6nig
> > > <christian.koenig@amd.com> wrote:
> > >> Am 04.12.23 um 22:54 schrieb Rob Clark:
> > >>> On Thu, Mar 23, 2023 at 2:30=E2=80=AFPM Rob Clark <robdclark@gmail.=
com> wrote:
> > >>>> [SNIP]
> > >>> So, this patch turns out to blow up spectacularly with dma_fence
> > >>> refcnt underflows when I enable DRIVER_SYNCOBJ_TIMELINE .. I think,
> > >>> because it starts unwrapping fence chains, possibly in parallel wit=
h
> > >>> fence signaling on the retire path.  Is it supposed to be permissib=
le
> > >>> to unwrap a fence chain concurrently?
> > >> The DMA-fence chain object and helper functions were designed so tha=
t
> > >> concurrent accesses to all elements are always possible.
> > >>
> > >> See dma_fence_chain_walk() and dma_fence_chain_get_prev() for exampl=
e.
> > >> dma_fence_chain_walk() starts with a reference to the current fence =
(the
> > >> anchor of the walk) and tries to grab an up to date reference on the
> > >> previous fence in the chain. Only after that reference is successful=
ly
> > >> acquired we drop the reference to the anchor where we started.
> > >>
> > >> Same for dma_fence_array_first(), dma_fence_array_next(). Here we ho=
ld a
> > >> reference to the array which in turn holds references to each fence
> > >> inside the array until it is destroyed itself.
> > >>
> > >> When this blows up we have somehow mixed up the references somewhere=
.
> > > That's what it looked like to me, but wanted to make sure I wasn't
> > > overlooking something subtle.  And in this case, the fence actually
> > > should be the syncobj timeline point fence, not the fence chain.
> > > Virtgpu has essentially the same logic (there we really do want to
> > > unwrap fences so we can pass host fences back to host rather than
> > > waiting in guest), I'm not sure if it would blow up in the same way.
> >
> > Well do you have a backtrace of what exactly happens?
> >
> > Maybe we have some _put() before _get() or something like this.
>
> I hacked up something to store the backtrace in dma_fence_release()
> (and leak the block so the backtrace would still be around later when
> dma_fence_get/put was later called) and ended up with:
>
> [  152.811360] freed at:
> [  152.813718]  dma_fence_release+0x30/0x134
> [  152.817865]  dma_fence_put+0x38/0x98 [gpu_sched]
> [  152.822657]  drm_sched_job_add_dependency+0x160/0x18c [gpu_sched]
> [  152.828948]  drm_sched_job_add_syncobj_dependency+0x58/0x88 [gpu_sched=
]
> [  152.835770]  msm_ioctl_gem_submit+0x580/0x1160 [msm]
> [  152.841070]  drm_ioctl_kernel+0xec/0x16c
> [  152.845132]  drm_ioctl+0x2e8/0x3f4
> [  152.848646]  vfs_ioctl+0x30/0x50
> [  152.851982]  __arm64_sys_ioctl+0x80/0xb4
> [  152.856039]  invoke_syscall+0x8c/0x120
> [  152.859919]  el0_svc_common.constprop.0+0xc0/0xdc
> [  152.864777]  do_el0_svc+0x24/0x30
> [  152.868207]  el0_svc+0x8c/0xd8
> [  152.871365]  el0t_64_sync_handler+0x84/0x12c
> [  152.875771]  el0t_64_sync+0x190/0x194
>
> I suppose that doesn't guarantee that this was the problematic put.
> But dropping this patch to unwrap the fence makes the problem go
> away..

Oh, hmm, _add_dependency() is consuming the fence reference

BR,
-R

> BR,
> -R
>
> > Thanks,
> > Christian.
> >
> > >
> > > BR,
> > > -R
> > >
> > >> Regards,
> > >> Christian.
> > >>
> > >>> BR,
> > >>> -R
> >

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA43C7FDF8E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 19:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjK2Sp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 13:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK2Sp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 13:45:26 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A494F12C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:45:32 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6d817ccaa6dso81051a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701283532; x=1701888332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7DCR/D2puLrlYKtfnL5wOuzekl2PYjebLOO/OkVlkg=;
        b=BDaD2ZZfUnzTjLGUoGY8V4IYu9wqvnF7OoUC8CQ+QrLktaefBxg1jtXWskEVTCAIzM
         AEah5t5MFFQ1TaetXKSxjbq2aqGgeqp/9UPn7QS/o6wl166doaPchZ3h1VmMnyj0HBvT
         HFNO9W4e8trURT/14mzzM0kyxs+rwqTI1yzOfjPGTD3K89kjpkeJtOnWyVM14Zdy/0Hk
         UCRql293+0XHr2KB6AQWskv8f0ZaGCUJYO0ZXmnQZ/t0wqd62IpxGBpW8G5DiFD5SYYT
         6Js6TqGicdsftT4zrLN8aEUcqrz6Mlh0KzoJX0kwl1ydHiDF733+jKJRhDoGP8D5sh3d
         CS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701283532; x=1701888332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7DCR/D2puLrlYKtfnL5wOuzekl2PYjebLOO/OkVlkg=;
        b=Fv0GwE3HiG8lx49o11u8Coq3Zu5wnU0+pHVcih1WVJTk9sbTUroAFbqBuVXoEbQgGF
         tpNHX+Eq7JvRGMiQzzfHzV9dMAuAd/sF+i2gPUnEKAi7aXCwXgKAOiYiOe4vfVyJ5DXo
         694poSt1KlDgdb/AIIRyg/kLr3PQ5EPJRF0EryLoxBcLJQeAU8BIB8ps14fEizMRSODQ
         2pNfM+cI2kB4vcOVVFC/fb94KlcLBH47FLp+P5uFw6W4JurikzNacmntfx4l3x/cvtC+
         +ztYyIXRCHlmYqt4+Rpxkm8TrmQQXRvGBk01PRSPiwojtIaZnvNSFrsvK668gG8jZShU
         dq0g==
X-Gm-Message-State: AOJu0YyuvWyk6iNDeHMsMvcn87D99jTQ9x+/XpKpQV0+zR6FFzkBONmz
        e/iCNDLMkLiFPSbrMgkS0GakYw30Sx5WKmM922M=
X-Google-Smtp-Source: AGHT+IHlGLSafRGtkek0S5tuVTw6o7OhfniAJh5CzM0bn20/DR1kfW77Bo0cCRmK4BBhQD4xqF8usW0gMwTqN3vrV/Q=
X-Received: by 2002:a05:6870:9e06:b0:1f9:f5c5:c023 with SMTP id
 ps6-20020a0568709e0600b001f9f5c5c023mr28673722oab.57.1701283531835; Wed, 29
 Nov 2023 10:45:31 -0800 (PST)
MIME-Version: 1.0
References: <87edgv4x3i.fsf@vps.thesusis.net> <559d0fa5-953a-4a97-b03b-5eb1287c83d8@leemhuis.info>
 <CAPM=9tw-8pQWFso0zuLqpsqd5BSHWtc4As9ttdjY-DDr70EMqQ@mail.gmail.com>
 <bdb238b6-60c7-4f26-81d0-9e62cd5dd326@gmail.com> <CADnq5_NVGS1XykxGxpcu_bpPbzboCUJQkcCF3r+0N9a23KUgiQ@mail.gmail.com>
 <96e2e13c-f01c-4baf-a9a3-cbaa48fb10c7@amd.com> <CADnq5_NBfeAXEyQw0gnSd67=tR-bUKg8w=10+4z9pGGuRnP9uw@mail.gmail.com>
 <87jzq2ixtm.fsf@vps.thesusis.net> <CADnq5_Ou-MVVm0rdWDmDnJNLkWUayXzO26uCEtz3ucNa4Ghy2w@mail.gmail.com>
 <95fe9b5b-05ce-4462-9973-9aca306bc44f@gmail.com> <CADnq5_MYEWx=e1LBLeVs0UbR5_xEScjDyw_-75mLe8RAMnqh6g@mail.gmail.com>
 <05007cb0-871e-4dc7-af58-1351f4ba43e2@gmail.com>
In-Reply-To: <05007cb0-871e-4dc7-af58-1351f4ba43e2@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 29 Nov 2023 13:45:20 -0500
Message-ID: <CADnq5_P3iCNRZ6o3w=u1GrZCd7vkM8GspTpdwT-1G_1eJSNwmQ@mail.gmail.com>
Subject: Re: Radeon regression in 6.6 kernel
To:     Luben Tuikov <ltuikov89@gmail.com>
Cc:     Phillip Susi <phill@thesusis.net>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        linux-kernel@vger.kernel.org,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Danilo Krummrich <dakr@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 11:21=E2=80=AFAM Luben Tuikov <ltuikov89@gmail.com>=
 wrote:
>
> On 2023-11-29 08:50, Alex Deucher wrote:
> > On Tue, Nov 28, 2023 at 11:45=E2=80=AFPM Luben Tuikov <ltuikov89@gmail.=
com> wrote:
> >>
> >> On 2023-11-28 17:13, Alex Deucher wrote:
> >>> On Mon, Nov 27, 2023 at 6:24=E2=80=AFPM Phillip Susi <phill@thesusis.=
net> wrote:
> >>>>
> >>>> Alex Deucher <alexdeucher@gmail.com> writes:
> >>>>
> >>>>>> In that case those are the already known problems with the schedul=
er
> >>>>>> changes, aren't they?
> >>>>>
> >>>>> Yes.  Those changes went into 6.7 though, not 6.6 AFAIK.  Maybe I'm
> >>>>> misunderstanding what the original report was actually testing.  If=
 it
> >>>>> was 6.7, then try reverting:
> >>>>> 56e449603f0ac580700621a356d35d5716a62ce5
> >>>>> b70438004a14f4d0f9890b3297cd66248728546c
> >>>>
> >>>> At some point it was suggested that I file a gitlab issue, but I too=
k
> >>>> this to mean it was already known and being worked on.  -rc3 came ou=
t
> >>>> today and still has the problem.  Is there a known issue I could tra=
ck?
> >>>>
> >>>
> >>> At this point, unless there are any objections, I think we should jus=
t
> >>> revert the two patches
> >> Uhm, no.
> >>
> >> Why "the two" patches?
> >>
> >> This email, part of this thread,
> >>
> >> https://lore.kernel.org/all/87r0kircdo.fsf@vps.thesusis.net/
> >>
> >> clearly states that reverting *only* this commit,
> >> 56e449603f0ac5 drm/sched: Convert the GPU scheduler to variable number=
 of run-queues
> >> *does not* mitigate the failed suspend. (Furthermore, this commit does=
n't really change
> >> anything operational, other than using an allocated array, instead of =
a static one, in DRM,
> >> while the 2nd patch is solely contained within the amdgpu driver code.=
)
> >>
> >> Leaving us with only this change,
> >> b70438004a14f4 drm/amdgpu: move buffer funcs setting up a level
> >> to be at fault, as the kernel log attached in the linked email above s=
hows.
> >>
> >> The conclusion is that only b70438004a14f4 needs reverting.
> >
> > b70438004a14f4 was a fix for 56e449603f0ac5.  Without b70438004a14f4,
> > 56e449603f0ac5 breaks amdgpu.
>
> It doesn't "break" it, amdgpu just needs to be fixed.
>
> I know we put in a Fixes tag in
> b70438004a14f4 "drm/amdgpu: move buffer funcs setting up a level"
> pointing to 56e449603f0ac5 "drm/sched: Convert the GPU scheduler to varia=
ble number of run-queues",
> but given the testing Phillip has done, the culprit is wholly contained i=
n
> the amdgpu driver code.
>
> No other driver has this problem since commit 56e449603f0ac5.
>
> The Fixes tag in b70438004a14f4 "drm/amdgpu: move buffer funcs setting up=
 a level" should've ideally
> pointed to an amdgpu-driver code commit only (perhaps an old-old commit),=
 and I was a bit uncomfortable
> putting in a Fixes tag which pointed to drm code, but we did it so that t=
he amdgpu commit follows
> the changes in DRM. In retrospect, the Fixes tag should've pointed to and=
 amdgpu-driver commit when
> that the amdgpu code was originally written.
>
> I remember that the problem was really that amdgpu called drm_sched_entit=
y_init(),
> in amdgpu_ttm_set_buffer_funcs_status() without actually having initializ=
ed the scheduler
> used therein. For instance, the code before commit b70438004a14f4, looked=
 like this:
>
> void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool =
enable)
> {
>         struct ttm_resource_manager *man =3D ttm_manager_type(&adev->mman=
.bdev, TTM_PL_VRAM);
>         uint64_t size;
>         int r;
>
>         if (!adev->mman.initialized || amdgpu_in_reset(adev) ||
>             adev->mman.buffer_funcs_enabled =3D=3D enable)
>                 return;
>
>         if (enable) {
>                 struct amdgpu_ring *ring;
>                 struct drm_gpu_scheduler *sched;
>
>                 ring =3D adev->mman.buffer_funcs_ring;
>                 sched =3D &ring->sched;                             <-- L=
T: No one has initialized this scheduler
>                 r =3D drm_sched_entity_init(&adev->mman.entity,     <-- O=
opses, now that sched->sched_rq is not a static array
>                                           DRM_SCHED_PRIORITY_KERNEL, &sch=
ed,
>                                           1, NULL);
>                 if (r) {
>                         DRM_ERROR("Failed setting up TTM BO move entity (=
%d)\n",
>                                   r);
>                         return;
>                 }
>
>
> Before commit 56e449603f0ac5, amdgpu was getting away with this, because =
the sched->sched_rq
> was a static array.
>
> Ideally, amdgpu code would be fixed.

b70438004a14f4 was the amdgpu fix for this, but it appears to break
suspend for some users.  I'm not confident we can fix it in time for
6.7 final.

Alex

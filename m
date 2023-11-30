Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC217FFF70
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377245AbjK3X2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377216AbjK3X2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:28:22 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4DC10C2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:28:28 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6d84ddd642fso912812a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701386908; x=1701991708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smrNDXAc/syQyWE6VYvQDM0BmSBPKcPsC5CPtRv9e1k=;
        b=TEV0z8HBLCxwQANPEtxv8twY2mpsg3jOC+36y3ZWCIqHLTOlDKzKmHR5FsYKjHNzoX
         NzXnfNVVT02j7QU+rsbsHMo41YA1Z2j45rD4MYWIowLbKsmwuey3NRSZesTNnAK/yzbb
         mwUO/5a0PAHPw71gCU1G8+07T0k+X/NtyiWWpt44emmd5QhUzXvqUBP4uKie2wOHs/WY
         bKEPW+ghiq6W7cd2ADzz6+79k4vudpiBzSjvyhmwvttpBUMP+9L3dwZ+9+Lx74iGwGp3
         dEV6P2PO6KMIaRcpUERD499Os9EMpyi/fFHVUimzbUyD/1ahJ94xafEo4pl9zOcTfW4e
         Pnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701386908; x=1701991708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smrNDXAc/syQyWE6VYvQDM0BmSBPKcPsC5CPtRv9e1k=;
        b=JcAKnXqS67OJhmkvDXs7oo5wkVLTbkTgydiSQsbn2CDeeJbvNNg+MGYezpFVwGT0EP
         iK3oV29dCg5/LTyWak3UqRDsmoieAf33zRAgLXGmPmoVk9h+5NKHJn5oLEdA/YxCg4oP
         kE8yEDMqJteRMk5c8TX93fzQeo7B/M6HqUXbNUOVnMcE/y1opRcJye7WKmqxhnIrgIms
         pqOksCIOCPNaBVmxlABsXwGuxbaH6Te1oPQ+ZYv8fnpQjRHkehUes7gbHV0xNqy8vuWO
         TCktF9DlyHkJ2gzhJWVaRFvQsJkqlAfUsY4L1iWufrVimMg8UPCX+7+g+TKtDI4pD8Bb
         pfjA==
X-Gm-Message-State: AOJu0YwuHhwKTHqWOwdNBfcwVkzC9pUzT+4plhcl5P+Ld48re6aS8Gxw
        PKYImR7DXT38W+m6NmE74N7YneQ4F9tz6mDHwV4=
X-Google-Smtp-Source: AGHT+IE3O3B7I2zbKJ/VUqaQhLXEIkrbY+q7iFWC1NNsg2niTotxroSLh9InklkFQ8sLsM2Do3Uacq0M+MDTY1Q4ujM=
X-Received: by 2002:a05:6871:550:b0:1fa:2095:e1f with SMTP id
 t16-20020a056871055000b001fa20950e1fmr22746411oal.35.1701386907675; Thu, 30
 Nov 2023 15:28:27 -0800 (PST)
MIME-Version: 1.0
References: <87edgv4x3i.fsf@vps.thesusis.net> <559d0fa5-953a-4a97-b03b-5eb1287c83d8@leemhuis.info>
 <CAPM=9tw-8pQWFso0zuLqpsqd5BSHWtc4As9ttdjY-DDr70EMqQ@mail.gmail.com>
 <bdb238b6-60c7-4f26-81d0-9e62cd5dd326@gmail.com> <CADnq5_NVGS1XykxGxpcu_bpPbzboCUJQkcCF3r+0N9a23KUgiQ@mail.gmail.com>
 <96e2e13c-f01c-4baf-a9a3-cbaa48fb10c7@amd.com> <CADnq5_NBfeAXEyQw0gnSd67=tR-bUKg8w=10+4z9pGGuRnP9uw@mail.gmail.com>
 <87jzq2ixtm.fsf@vps.thesusis.net> <CADnq5_Ou-MVVm0rdWDmDnJNLkWUayXzO26uCEtz3ucNa4Ghy2w@mail.gmail.com>
 <95fe9b5b-05ce-4462-9973-9aca306bc44f@gmail.com> <CADnq5_MYEWx=e1LBLeVs0UbR5_xEScjDyw_-75mLe8RAMnqh6g@mail.gmail.com>
 <CADnq5_OC=JFpGcN0oGbTF5xYEt4X3r0=jEY6hJ12W8CzYq1+cA@mail.gmail.com>
 <9595b8bf-e64d-4926-9263-97e18bcd7d05@gmail.com> <CADnq5_N6DF-huOzgaVygvS5N_j_oNUEC1aa4zRsZTzx8GOD_aw@mail.gmail.com>
 <CADnq5_PgMxoW=4iabtgeHydwye-6DvwvCyETdfBToEpuYWocmA@mail.gmail.com>
 <CADnq5_P0S7Jem0e4K6mG2+bboG8P56nELaGC1p4Pfx-8eV-BjQ@mail.gmail.com>
 <05a4dec0-1c07-4a64-9439-e2c306807ded@gmail.com> <db75bcf5-13a7-4176-a2fb-94cd198a1a7b@gmail.com>
In-Reply-To: <db75bcf5-13a7-4176-a2fb-94cd198a1a7b@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 30 Nov 2023 18:28:16 -0500
Message-ID: <CADnq5_PuUxmG7dxfCYkY7-qx91XDgG+eXBgdBer_cKss8WmvXA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 10:47=E2=80=AFPM Luben Tuikov <ltuikov89@gmail.com>=
 wrote:
>
> On 2023-11-29 22:36, Luben Tuikov wrote:
> > On 2023-11-29 15:49, Alex Deucher wrote:
> >> On Wed, Nov 29, 2023 at 3:10=E2=80=AFPM Alex Deucher <alexdeucher@gmai=
l.com> wrote:
> >>>
> >>> Actually I think I see the problem.  I'll try and send out a patch
> >>> later today to test.
> >>
> >> Does the attached patch fix it?
> >
> > Thanks for the patch, Alex.
> >
> > Is it possible for AMD to also reproduce this issue and test this patch=
 on a Navi23 system?
> >
> >> From 96e75b5218f7a124eafa53853681eef8fe567ab8 Mon Sep 17 00:00:00 2001
> >> From: Alex Deucher <alexander.deucher@amd.com>
> >> Date: Wed, 29 Nov 2023 15:44:25 -0500
> >> Subject: [PATCH] drm/amdgpu: fix buffer funcs setting order on suspend
> >>
> >> We need to make disable this after the last eviction
> >
> > "make disable" --> "disable"
> >
> >> call, but before we disable the SDMA IP.
> >>
> >> Fixes: b70438004a14 ("drm/amdgpu: move buffer funcs setting up a level=
")
> >> Link: https://lists.freedesktop.org/archives/amd-gfx/2023-November/101=
197.html
> >
> > Link: https://lore.kernel.org/r/87edgv4x3i.fsf@vps.thesusis.net
> >
> > Let's link the start of the thread.
> >
> > Regards,
> > Luben
> >
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> Cc: Phillip Susi <phill@thesusis.net>
> >> Cc: Luben Tuikov <ltuikov89@gmail.com>
> >> ---
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c
> >> index b5edf40b5d03..78553e027db4 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> @@ -4531,8 +4531,6 @@ int amdgpu_device_suspend(struct drm_device *dev=
, bool fbcon)
> >>
> >>      amdgpu_ras_suspend(adev);
> >>
> >> -    amdgpu_ttm_set_buffer_funcs_status(adev, false);
> >> -
> >>      amdgpu_device_ip_suspend_phase1(adev);
> >>
> >>      if (!adev->in_s0ix)
> >> @@ -4542,6 +4540,8 @@ int amdgpu_device_suspend(struct drm_device *dev=
, bool fbcon)
> >>      if (r)
> >>              return r;
> >>
> >> +    amdgpu_ttm_set_buffer_funcs_status(adev, false);
> >> +
>
> If you're moving this past phase 1, there's another instance in amdgpu_de=
vice_ip_suspend(),
> which may need to be moved down.

I think that one should be ok since we don't do any evictions in
amdgpu_device_ip_suspend().

Alex

>
> Regards,
> Luben
>
> >>      amdgpu_fence_driver_hw_fini(adev);
> >>
> >>      amdgpu_device_ip_suspend_phase2(adev);
> >
> >>
> >> Alex
> >>
> >>>
> >>> Alex
> >>>
> >>> On Wed, Nov 29, 2023 at 1:52=E2=80=AFPM Alex Deucher <alexdeucher@gma=
il.com> wrote:
> >>>>
> >>>> On Wed, Nov 29, 2023 at 11:41=E2=80=AFAM Luben Tuikov <ltuikov89@gma=
il.com> wrote:
> >>>>>
> >>>>> On 2023-11-29 10:22, Alex Deucher wrote:
> >>>>>> On Wed, Nov 29, 2023 at 8:50=E2=80=AFAM Alex Deucher <alexdeucher@=
gmail.com> wrote:
> >>>>>>>
> >>>>>>> On Tue, Nov 28, 2023 at 11:45=E2=80=AFPM Luben Tuikov <ltuikov89@=
gmail.com> wrote:
> >>>>>>>>
> >>>>>>>> On 2023-11-28 17:13, Alex Deucher wrote:
> >>>>>>>>> On Mon, Nov 27, 2023 at 6:24=E2=80=AFPM Phillip Susi <phill@the=
susis.net> wrote:
> >>>>>>>>>>
> >>>>>>>>>> Alex Deucher <alexdeucher@gmail.com> writes:
> >>>>>>>>>>
> >>>>>>>>>>>> In that case those are the already known problems with the s=
cheduler
> >>>>>>>>>>>> changes, aren't they?
> >>>>>>>>>>>
> >>>>>>>>>>> Yes.  Those changes went into 6.7 though, not 6.6 AFAIK.  May=
be I'm
> >>>>>>>>>>> misunderstanding what the original report was actually testin=
g.  If it
> >>>>>>>>>>> was 6.7, then try reverting:
> >>>>>>>>>>> 56e449603f0ac580700621a356d35d5716a62ce5
> >>>>>>>>>>> b70438004a14f4d0f9890b3297cd66248728546c
> >>>>>>>>>>
> >>>>>>>>>> At some point it was suggested that I file a gitlab issue, but=
 I took
> >>>>>>>>>> this to mean it was already known and being worked on.  -rc3 c=
ame out
> >>>>>>>>>> today and still has the problem.  Is there a known issue I cou=
ld track?
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> At this point, unless there are any objections, I think we shou=
ld just
> >>>>>>>>> revert the two patches
> >>>>>>>> Uhm, no.
> >>>>>>>>
> >>>>>>>> Why "the two" patches?
> >>>>>>>>
> >>>>>>>> This email, part of this thread,
> >>>>>>>>
> >>>>>>>> https://lore.kernel.org/all/87r0kircdo.fsf@vps.thesusis.net/
> >>>>>>>>
> >>>>>>>> clearly states that reverting *only* this commit,
> >>>>>>>> 56e449603f0ac5 drm/sched: Convert the GPU scheduler to variable =
number of run-queues
> >>>>>>>> *does not* mitigate the failed suspend. (Furthermore, this commi=
t doesn't really change
> >>>>>>>> anything operational, other than using an allocated array, inste=
ad of a static one, in DRM,
> >>>>>>>> while the 2nd patch is solely contained within the amdgpu driver=
 code.)
> >>>>>>>>
> >>>>>>>> Leaving us with only this change,
> >>>>>>>> b70438004a14f4 drm/amdgpu: move buffer funcs setting up a level
> >>>>>>>> to be at fault, as the kernel log attached in the linked email a=
bove shows.
> >>>>>>>>
> >>>>>>>> The conclusion is that only b70438004a14f4 needs reverting.
> >>>>>>>
> >>>>>>> b70438004a14f4 was a fix for 56e449603f0ac5.  Without b70438004a1=
4f4,
> >>>>>>> 56e449603f0ac5 breaks amdgpu.
> >>>>>>
> >>>>>> We can try and re-enable it in the next kernel.  I'm just not sure
> >>>>>> we'll be able to fix this in time for 6.7 with the holidays and al=
l
> >>>>>> and I don't want to cause a lot of scheduler churn at the end of t=
he
> >>>>>> 6.7 cycle if we hold off and try and fix it.  Reverting seems like=
 the
> >>>>>> best short term solution.
> >>>>>
> >>>>> A lot of subsequent code has come in since commit 56e449603f0ac5, a=
s it opened
> >>>>> the opportunity for a 1-to-1 relationship between an entity and a s=
cheduler.
> >>>>> (Should've always been the case, from the outset. Not sure why it w=
as coded as
> >>>>> a fixed-size array.)
> >>>>>
> >>>>> Given that commit 56e449603f0ac5 has nothing to do with amdgpu, and=
 the problem
> >>>>> is wholly contained in amdgpu, and no other driver has this problem=
, there is
> >>>>> no reason to have to "churn", i.e. go back and forth in DRM, only t=
o cover up
> >>>>> an init bug in amdgpu. See the response I just sent in @this thread=
:
> >>>>> https://lore.kernel.org/r/05007cb0-871e-4dc7-af58-1351f4ba43e2@gmai=
l.com
> >>>>>
> >>>>> And it's not like this issue is unknown. I first posted about it on=
 2023-10-16.
> >>>>>
> >>>>> Ideally, amdgpu would just fix their init code.
> >>>>
> >>>> You can't make changes to core code that break other drivers.
> >>>> Arguably 56e449603f0ac5 should not have gone in in the first place i=
f
> >>>> it broke amdgpu.  b70438004a14f4 was the code to fix amdgpu's init
> >>>> code, but as a side effect it seems to have broken suspend for some
> >>>> users.
> >>>>
> >>>> Alex

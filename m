Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3C87FDFB3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 19:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjK2Swf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 13:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK2Swd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 13:52:33 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A1B12C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:52:38 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6d858670630so108338a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701283958; x=1701888758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKCMdliecR8K3FRKmMsgrRyyz7+kEtWPm4FIJ7dTiTY=;
        b=NbOaDDQLNu/FfGlRvPNk/4+61TTM3VzB86epgju2gHEO0LFloyemCYbFiKI/e5CFq7
         YvOwlcM8wo/Wd4jjA5Em6iQhPHXyDuBKopoUL5p8XkK+yOZrJRO/7MINnep6DGZpCENr
         KYmn0Y16n6rbdQOsTm9Wh+gBR/lDdqgZkirQ7osfoYy6Q5q4M2s2p9ukIqO9r9I6YIMw
         2tioDLlZvZPVLoK6qpic3guLn0fFltlQWONTg99traINKWw1YSDlIl2ezhrzzy9NnmPN
         OjGhBQjz4zRZs4zle+DlsQRD/5fMMtNCIftG6Co/0Msm7pe4RJUuvAdzoA05iv9t3q3q
         F6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701283958; x=1701888758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKCMdliecR8K3FRKmMsgrRyyz7+kEtWPm4FIJ7dTiTY=;
        b=aNhhvb+AmGdjndNtYjc8/EqbNuijNb+bNXOJJCYfTwf+xZQ2dp/uWTp1oASdM/ytyR
         y+04VSJhWaNLiiaXbHeemaH4PcaZMgrNmKvYHZOZ5qq2bdheyRREpMRaZCrxfH7L7jT7
         Bw0W/HyRv8iYcNoHPrJ0GEO0F8bE8+q3fI3/tN/jqeVr1KndQUI9R1968az+fjO0lBZG
         72IgKLJAzxg8Qwgr/I+U3/0MX1pwq6dPoe1+fY3oWgpwm674hiw7yRwUT1piFCnx3cL4
         ODtwY6drWwd80OFIa/gPBs/hFRdQf+v3oyHrP0uccOs7thMAPJMwOzwzD6fc3d3Ssntf
         6ZQQ==
X-Gm-Message-State: AOJu0YxcHoWZY/ED+gwcM45giH+a74q0v7Oa8FKZMyU8nt0baLR5I7ly
        Ma8DnuwSv0ra7GvDPhQGyFcN6verH2KlJCwfopQ=
X-Google-Smtp-Source: AGHT+IF3oOywhpirX3+AP8XTM3+9p+TwpPLHbDmBIZTRg15hZZxmdOFhzj4n/rOsFaUbFqEpr1x9fgbgQl7aRBPDypc=
X-Received: by 2002:a05:6870:7a09:b0:1e9:f0fe:6ba4 with SMTP id
 hf9-20020a0568707a0900b001e9f0fe6ba4mr28988964oab.11.1701283957735; Wed, 29
 Nov 2023 10:52:37 -0800 (PST)
MIME-Version: 1.0
References: <87edgv4x3i.fsf@vps.thesusis.net> <559d0fa5-953a-4a97-b03b-5eb1287c83d8@leemhuis.info>
 <CAPM=9tw-8pQWFso0zuLqpsqd5BSHWtc4As9ttdjY-DDr70EMqQ@mail.gmail.com>
 <bdb238b6-60c7-4f26-81d0-9e62cd5dd326@gmail.com> <CADnq5_NVGS1XykxGxpcu_bpPbzboCUJQkcCF3r+0N9a23KUgiQ@mail.gmail.com>
 <96e2e13c-f01c-4baf-a9a3-cbaa48fb10c7@amd.com> <CADnq5_NBfeAXEyQw0gnSd67=tR-bUKg8w=10+4z9pGGuRnP9uw@mail.gmail.com>
 <87jzq2ixtm.fsf@vps.thesusis.net> <CADnq5_Ou-MVVm0rdWDmDnJNLkWUayXzO26uCEtz3ucNa4Ghy2w@mail.gmail.com>
 <95fe9b5b-05ce-4462-9973-9aca306bc44f@gmail.com> <CADnq5_MYEWx=e1LBLeVs0UbR5_xEScjDyw_-75mLe8RAMnqh6g@mail.gmail.com>
 <CADnq5_OC=JFpGcN0oGbTF5xYEt4X3r0=jEY6hJ12W8CzYq1+cA@mail.gmail.com> <9595b8bf-e64d-4926-9263-97e18bcd7d05@gmail.com>
In-Reply-To: <9595b8bf-e64d-4926-9263-97e18bcd7d05@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 29 Nov 2023 13:52:26 -0500
Message-ID: <CADnq5_N6DF-huOzgaVygvS5N_j_oNUEC1aa4zRsZTzx8GOD_aw@mail.gmail.com>
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

On Wed, Nov 29, 2023 at 11:41=E2=80=AFAM Luben Tuikov <ltuikov89@gmail.com>=
 wrote:
>
> On 2023-11-29 10:22, Alex Deucher wrote:
> > On Wed, Nov 29, 2023 at 8:50=E2=80=AFAM Alex Deucher <alexdeucher@gmail=
.com> wrote:
> >>
> >> On Tue, Nov 28, 2023 at 11:45=E2=80=AFPM Luben Tuikov <ltuikov89@gmail=
.com> wrote:
> >>>
> >>> On 2023-11-28 17:13, Alex Deucher wrote:
> >>>> On Mon, Nov 27, 2023 at 6:24=E2=80=AFPM Phillip Susi <phill@thesusis=
.net> wrote:
> >>>>>
> >>>>> Alex Deucher <alexdeucher@gmail.com> writes:
> >>>>>
> >>>>>>> In that case those are the already known problems with the schedu=
ler
> >>>>>>> changes, aren't they?
> >>>>>>
> >>>>>> Yes.  Those changes went into 6.7 though, not 6.6 AFAIK.  Maybe I'=
m
> >>>>>> misunderstanding what the original report was actually testing.  I=
f it
> >>>>>> was 6.7, then try reverting:
> >>>>>> 56e449603f0ac580700621a356d35d5716a62ce5
> >>>>>> b70438004a14f4d0f9890b3297cd66248728546c
> >>>>>
> >>>>> At some point it was suggested that I file a gitlab issue, but I to=
ok
> >>>>> this to mean it was already known and being worked on.  -rc3 came o=
ut
> >>>>> today and still has the problem.  Is there a known issue I could tr=
ack?
> >>>>>
> >>>>
> >>>> At this point, unless there are any objections, I think we should ju=
st
> >>>> revert the two patches
> >>> Uhm, no.
> >>>
> >>> Why "the two" patches?
> >>>
> >>> This email, part of this thread,
> >>>
> >>> https://lore.kernel.org/all/87r0kircdo.fsf@vps.thesusis.net/
> >>>
> >>> clearly states that reverting *only* this commit,
> >>> 56e449603f0ac5 drm/sched: Convert the GPU scheduler to variable numbe=
r of run-queues
> >>> *does not* mitigate the failed suspend. (Furthermore, this commit doe=
sn't really change
> >>> anything operational, other than using an allocated array, instead of=
 a static one, in DRM,
> >>> while the 2nd patch is solely contained within the amdgpu driver code=
.)
> >>>
> >>> Leaving us with only this change,
> >>> b70438004a14f4 drm/amdgpu: move buffer funcs setting up a level
> >>> to be at fault, as the kernel log attached in the linked email above =
shows.
> >>>
> >>> The conclusion is that only b70438004a14f4 needs reverting.
> >>
> >> b70438004a14f4 was a fix for 56e449603f0ac5.  Without b70438004a14f4,
> >> 56e449603f0ac5 breaks amdgpu.
> >
> > We can try and re-enable it in the next kernel.  I'm just not sure
> > we'll be able to fix this in time for 6.7 with the holidays and all
> > and I don't want to cause a lot of scheduler churn at the end of the
> > 6.7 cycle if we hold off and try and fix it.  Reverting seems like the
> > best short term solution.
>
> A lot of subsequent code has come in since commit 56e449603f0ac5, as it o=
pened
> the opportunity for a 1-to-1 relationship between an entity and a schedul=
er.
> (Should've always been the case, from the outset. Not sure why it was cod=
ed as
> a fixed-size array.)
>
> Given that commit 56e449603f0ac5 has nothing to do with amdgpu, and the p=
roblem
> is wholly contained in amdgpu, and no other driver has this problem, ther=
e is
> no reason to have to "churn", i.e. go back and forth in DRM, only to cove=
r up
> an init bug in amdgpu. See the response I just sent in @this thread:
> https://lore.kernel.org/r/05007cb0-871e-4dc7-af58-1351f4ba43e2@gmail.com
>
> And it's not like this issue is unknown. I first posted about it on 2023-=
10-16.
>
> Ideally, amdgpu would just fix their init code.

You can't make changes to core code that break other drivers.
Arguably 56e449603f0ac5 should not have gone in in the first place if
it broke amdgpu.  b70438004a14f4 was the code to fix amdgpu's init
code, but as a side effect it seems to have broken suspend for some
users.

Alex

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3B9801155
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378557AbjLAQzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjLAQzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:55:44 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED6712A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:55:49 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-58cec5943c1so1266960eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 08:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701449749; x=1702054549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWhV56djU95aQfLVNm7Soh/hXtQRCsN2ft0VIHAER8A=;
        b=hEnhUvJTMgU3lra1zgbntzQWX7QMeKeXk7mwyJ20WTHqaLSwW2xvdN+llAYFY68i7j
         RfqZ+99/1KSkPjQ1AhOcLWt6IUlnMBGEXDA7SXUKqslG8hzIUPNSZEjQSU93D6BHohVW
         3cqaxE3iZgOaZZydWwI6P7nFBev17n6F+No1nr8ZxuzPIS0wXQweiRD5QalIbxja9dXP
         rIVBjN7NbtMOqDRA/SYNQsBpQ/d0UXDAR9phOPjK1CuPh0gJv8D2k0ubTTK0uPgzCVts
         Y8dcdENujY8qKLb7PA2YLQhAlq0cMaqt8F4T2SDci/WHjW0bUD2sfqFjc2HecG0Y5ar2
         yQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701449749; x=1702054549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWhV56djU95aQfLVNm7Soh/hXtQRCsN2ft0VIHAER8A=;
        b=FhtuJgjxBnrjYqL+6d1rlRCMPR879OXH/cwfEVS/yg59D7EBYIj257pQXoj6nktVDx
         W8mlwE07dnugtiSVuTR0CJpY+Yl2mLGf6Y3hwIfMrRUpfCXmoWxpqFT66rmTIhHzuIl3
         Oaxco4CBc3yf26bqG27NIwJvZFIQy6oT4hSFLMhTwGawsM91+1PpuplfbD7ZIOzQi5MX
         GafPGETNyvOw+O/sxZKR4HKk25UsuLOSnlptp6UPeIdmJYk6WUxWVqOxjd+402pc/f9e
         IehaMrxNVJyCh7fH3KQcD5po7TBhFkDInAsvEV+BQNCR9NFhSPDlEjFMqdsS6k5Cuuv8
         bEcg==
X-Gm-Message-State: AOJu0Yx1EXY9KIetkBTpNnRCay4OoCjSm4ujbW1UUJNjKDch3j32vpAm
        JWDOFpj3Ws0oEuCDCprWfxL/eqQLGA0Ft4XpnX4=
X-Google-Smtp-Source: AGHT+IFcxTbgF9xXKMxzTnObK/CQ9MvvfivvyKXOzVzXQNvJW4i8otQvmBPx8yuN1coi/2TEmdpNoBi0J9sKp8BZ7gk=
X-Received: by 2002:a05:6870:2182:b0:1f9:8f1b:86f7 with SMTP id
 l2-20020a056870218200b001f98f1b86f7mr29208291oae.42.1701449748697; Fri, 01
 Dec 2023 08:55:48 -0800 (PST)
MIME-Version: 1.0
References: <87edgv4x3i.fsf@vps.thesusis.net> <559d0fa5-953a-4a97-b03b-5eb1287c83d8@leemhuis.info>
 <CAPM=9tw-8pQWFso0zuLqpsqd5BSHWtc4As9ttdjY-DDr70EMqQ@mail.gmail.com>
 <bdb238b6-60c7-4f26-81d0-9e62cd5dd326@gmail.com> <CADnq5_NVGS1XykxGxpcu_bpPbzboCUJQkcCF3r+0N9a23KUgiQ@mail.gmail.com>
 <96e2e13c-f01c-4baf-a9a3-cbaa48fb10c7@amd.com> <CADnq5_NBfeAXEyQw0gnSd67=tR-bUKg8w=10+4z9pGGuRnP9uw@mail.gmail.com>
 <87jzq2ixtm.fsf@vps.thesusis.net> <CADnq5_Ou-MVVm0rdWDmDnJNLkWUayXzO26uCEtz3ucNa4Ghy2w@mail.gmail.com>
 <95fe9b5b-05ce-4462-9973-9aca306bc44f@gmail.com> <CADnq5_MYEWx=e1LBLeVs0UbR5_xEScjDyw_-75mLe8RAMnqh6g@mail.gmail.com>
 <CADnq5_OC=JFpGcN0oGbTF5xYEt4X3r0=jEY6hJ12W8CzYq1+cA@mail.gmail.com>
 <9595b8bf-e64d-4926-9263-97e18bcd7d05@gmail.com> <CADnq5_N6DF-huOzgaVygvS5N_j_oNUEC1aa4zRsZTzx8GOD_aw@mail.gmail.com>
 <CADnq5_PgMxoW=4iabtgeHydwye-6DvwvCyETdfBToEpuYWocmA@mail.gmail.com> <CADnq5_P0S7Jem0e4K6mG2+bboG8P56nELaGC1p4Pfx-8eV-BjQ@mail.gmail.com>
In-Reply-To: <CADnq5_P0S7Jem0e4K6mG2+bboG8P56nELaGC1p4Pfx-8eV-BjQ@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 1 Dec 2023 11:55:36 -0500
Message-ID: <CADnq5_Oy6RMyJ52TbsxVjZ=0p=wYJHduE4X8B3DiYnqHYJUAvw@mail.gmail.com>
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

Phillip,

Can you test this patch?  I was not able to repro the issue on the
navi2x card I had handy, but I think it should fix it.

Thanks,

Alex

On Wed, Nov 29, 2023 at 3:49=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Wed, Nov 29, 2023 at 3:10=E2=80=AFPM Alex Deucher <alexdeucher@gmail.c=
om> wrote:
> >
> > Actually I think I see the problem.  I'll try and send out a patch
> > later today to test.
>
> Does the attached patch fix it?
>
> Alex
>
> >
> > Alex
> >
> > On Wed, Nov 29, 2023 at 1:52=E2=80=AFPM Alex Deucher <alexdeucher@gmail=
.com> wrote:
> > >
> > > On Wed, Nov 29, 2023 at 11:41=E2=80=AFAM Luben Tuikov <ltuikov89@gmai=
l.com> wrote:
> > > >
> > > > On 2023-11-29 10:22, Alex Deucher wrote:
> > > > > On Wed, Nov 29, 2023 at 8:50=E2=80=AFAM Alex Deucher <alexdeucher=
@gmail.com> wrote:
> > > > >>
> > > > >> On Tue, Nov 28, 2023 at 11:45=E2=80=AFPM Luben Tuikov <ltuikov89=
@gmail.com> wrote:
> > > > >>>
> > > > >>> On 2023-11-28 17:13, Alex Deucher wrote:
> > > > >>>> On Mon, Nov 27, 2023 at 6:24=E2=80=AFPM Phillip Susi <phill@th=
esusis.net> wrote:
> > > > >>>>>
> > > > >>>>> Alex Deucher <alexdeucher@gmail.com> writes:
> > > > >>>>>
> > > > >>>>>>> In that case those are the already known problems with the =
scheduler
> > > > >>>>>>> changes, aren't they?
> > > > >>>>>>
> > > > >>>>>> Yes.  Those changes went into 6.7 though, not 6.6 AFAIK.  Ma=
ybe I'm
> > > > >>>>>> misunderstanding what the original report was actually testi=
ng.  If it
> > > > >>>>>> was 6.7, then try reverting:
> > > > >>>>>> 56e449603f0ac580700621a356d35d5716a62ce5
> > > > >>>>>> b70438004a14f4d0f9890b3297cd66248728546c
> > > > >>>>>
> > > > >>>>> At some point it was suggested that I file a gitlab issue, bu=
t I took
> > > > >>>>> this to mean it was already known and being worked on.  -rc3 =
came out
> > > > >>>>> today and still has the problem.  Is there a known issue I co=
uld track?
> > > > >>>>>
> > > > >>>>
> > > > >>>> At this point, unless there are any objections, I think we sho=
uld just
> > > > >>>> revert the two patches
> > > > >>> Uhm, no.
> > > > >>>
> > > > >>> Why "the two" patches?
> > > > >>>
> > > > >>> This email, part of this thread,
> > > > >>>
> > > > >>> https://lore.kernel.org/all/87r0kircdo.fsf@vps.thesusis.net/
> > > > >>>
> > > > >>> clearly states that reverting *only* this commit,
> > > > >>> 56e449603f0ac5 drm/sched: Convert the GPU scheduler to variable=
 number of run-queues
> > > > >>> *does not* mitigate the failed suspend. (Furthermore, this comm=
it doesn't really change
> > > > >>> anything operational, other than using an allocated array, inst=
ead of a static one, in DRM,
> > > > >>> while the 2nd patch is solely contained within the amdgpu drive=
r code.)
> > > > >>>
> > > > >>> Leaving us with only this change,
> > > > >>> b70438004a14f4 drm/amdgpu: move buffer funcs setting up a level
> > > > >>> to be at fault, as the kernel log attached in the linked email =
above shows.
> > > > >>>
> > > > >>> The conclusion is that only b70438004a14f4 needs reverting.
> > > > >>
> > > > >> b70438004a14f4 was a fix for 56e449603f0ac5.  Without b70438004a=
14f4,
> > > > >> 56e449603f0ac5 breaks amdgpu.
> > > > >
> > > > > We can try and re-enable it in the next kernel.  I'm just not sur=
e
> > > > > we'll be able to fix this in time for 6.7 with the holidays and a=
ll
> > > > > and I don't want to cause a lot of scheduler churn at the end of =
the
> > > > > 6.7 cycle if we hold off and try and fix it.  Reverting seems lik=
e the
> > > > > best short term solution.
> > > >
> > > > A lot of subsequent code has come in since commit 56e449603f0ac5, a=
s it opened
> > > > the opportunity for a 1-to-1 relationship between an entity and a s=
cheduler.
> > > > (Should've always been the case, from the outset. Not sure why it w=
as coded as
> > > > a fixed-size array.)
> > > >
> > > > Given that commit 56e449603f0ac5 has nothing to do with amdgpu, and=
 the problem
> > > > is wholly contained in amdgpu, and no other driver has this problem=
, there is
> > > > no reason to have to "churn", i.e. go back and forth in DRM, only t=
o cover up
> > > > an init bug in amdgpu. See the response I just sent in @this thread=
:
> > > > https://lore.kernel.org/r/05007cb0-871e-4dc7-af58-1351f4ba43e2@gmai=
l.com
> > > >
> > > > And it's not like this issue is unknown. I first posted about it on=
 2023-10-16.
> > > >
> > > > Ideally, amdgpu would just fix their init code.
> > >
> > > You can't make changes to core code that break other drivers.
> > > Arguably 56e449603f0ac5 should not have gone in in the first place if
> > > it broke amdgpu.  b70438004a14f4 was the code to fix amdgpu's init
> > > code, but as a side effect it seems to have broken suspend for some
> > > users.
> > >
> > > Alex

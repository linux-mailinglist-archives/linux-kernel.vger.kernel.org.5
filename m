Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB4F7FDB1F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbjK2PXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbjK2PXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:23:04 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B80D7F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:23:09 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1fa21f561a1so2216410fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701271389; x=1701876189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eCUywg88tT8nR8OAzlEKxFmQomFdBEbseNCKYUwF6z0=;
        b=LDOpBzh5kTNU7wHu2l+bZaXjEZ8zCtiUUsnN7pSROuceujbjStO5oSZKFjX+aeaOu+
         IornWMIFr8cf3rqQ3onb4OoSZw4NIj13U+LIf3H6ZPsv4arpoD7DzhF43oTvrnTittL+
         OC2v/QbvGnNI+iIYJ02q1SP85SMlo9KuhJw5OQl3tIfmirkEaiVm7/IR3afYsPH6kJlk
         khAUYTUYuZDEFJggIga97oBkPGXNkpVlZv1bIcFFDGA18UD09G7zueaPInWI9nc5ZF39
         eQBxQZE0w129O7mTNHT/j1UTvKpN/jckmXlMJRCJX/dC0VhDfLaLmN0vLPXXGrrnmJdz
         a8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701271389; x=1701876189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eCUywg88tT8nR8OAzlEKxFmQomFdBEbseNCKYUwF6z0=;
        b=f8bipGvyXM7PiRaiUCI4m8nbKyKqNmmpj8tADuzf/xrG4P3D5eTA7ocPZWWgpD22ui
         2YCaLjYdMvXe90Lt5ow5wMJyj9n4E5DiDkI+lJkpHCgh7kJqeB5O7ScbGzmwGHAJc90O
         Yk8bfqoEB0RJlY76j7k5HA2cHJeOZDpe8dEFQJE8YmZF3s2IlPeMCyj3mGtmuSZu5s53
         A4ux1zUwYHiKo4icinrHJ3+ZIwqvBsU/Q8fMwzbRLZ/AI2AMuMbNBYQ0bt3lFOsXf9cX
         E7OlxPqYSFXvPyCc0WE2yXgLweaUXBCTE25lucDtQp9xpNB8zDq93nY6Lbur5s8CB1Jq
         P/vg==
X-Gm-Message-State: AOJu0YyP4hiy0F4hX1HY6mqA3WqXRG/mcVB4q0WguRizwVIiZzb52inb
        xHYIi9pPC1c/0Kx66hLVqZvmWF/Ocfi9Ke72b2s=
X-Google-Smtp-Source: AGHT+IGbi8FXFb8iIYdiAjppd2yUdKIHbDEmAip93Ro7/8+qtzvhgxIyR0+q8J5YJuIzV7KOp/r4TqyhsH8NZT9HSAc=
X-Received: by 2002:a05:6870:c45:b0:1fa:345e:5e15 with SMTP id
 lf5-20020a0568700c4500b001fa345e5e15mr15412255oab.13.1701271389082; Wed, 29
 Nov 2023 07:23:09 -0800 (PST)
MIME-Version: 1.0
References: <87edgv4x3i.fsf@vps.thesusis.net> <559d0fa5-953a-4a97-b03b-5eb1287c83d8@leemhuis.info>
 <CAPM=9tw-8pQWFso0zuLqpsqd5BSHWtc4As9ttdjY-DDr70EMqQ@mail.gmail.com>
 <bdb238b6-60c7-4f26-81d0-9e62cd5dd326@gmail.com> <CADnq5_NVGS1XykxGxpcu_bpPbzboCUJQkcCF3r+0N9a23KUgiQ@mail.gmail.com>
 <96e2e13c-f01c-4baf-a9a3-cbaa48fb10c7@amd.com> <CADnq5_NBfeAXEyQw0gnSd67=tR-bUKg8w=10+4z9pGGuRnP9uw@mail.gmail.com>
 <87jzq2ixtm.fsf@vps.thesusis.net> <CADnq5_Ou-MVVm0rdWDmDnJNLkWUayXzO26uCEtz3ucNa4Ghy2w@mail.gmail.com>
 <95fe9b5b-05ce-4462-9973-9aca306bc44f@gmail.com> <CADnq5_MYEWx=e1LBLeVs0UbR5_xEScjDyw_-75mLe8RAMnqh6g@mail.gmail.com>
In-Reply-To: <CADnq5_MYEWx=e1LBLeVs0UbR5_xEScjDyw_-75mLe8RAMnqh6g@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 29 Nov 2023 10:22:57 -0500
Message-ID: <CADnq5_OC=JFpGcN0oGbTF5xYEt4X3r0=jEY6hJ12W8CzYq1+cA@mail.gmail.com>
Subject: Re: Radeon regression in 6.6 kernel
To:     Luben Tuikov <ltuikov89@gmail.com>
Cc:     Phillip Susi <phill@thesusis.net>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        linux-kernel@vger.kernel.org,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Wed, Nov 29, 2023 at 8:50=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Tue, Nov 28, 2023 at 11:45=E2=80=AFPM Luben Tuikov <ltuikov89@gmail.co=
m> wrote:
> >
> > On 2023-11-28 17:13, Alex Deucher wrote:
> > > On Mon, Nov 27, 2023 at 6:24=E2=80=AFPM Phillip Susi <phill@thesusis.=
net> wrote:
> > >>
> > >> Alex Deucher <alexdeucher@gmail.com> writes:
> > >>
> > >>>> In that case those are the already known problems with the schedul=
er
> > >>>> changes, aren't they?
> > >>>
> > >>> Yes.  Those changes went into 6.7 though, not 6.6 AFAIK.  Maybe I'm
> > >>> misunderstanding what the original report was actually testing.  If=
 it
> > >>> was 6.7, then try reverting:
> > >>> 56e449603f0ac580700621a356d35d5716a62ce5
> > >>> b70438004a14f4d0f9890b3297cd66248728546c
> > >>
> > >> At some point it was suggested that I file a gitlab issue, but I too=
k
> > >> this to mean it was already known and being worked on.  -rc3 came ou=
t
> > >> today and still has the problem.  Is there a known issue I could tra=
ck?
> > >>
> > >
> > > At this point, unless there are any objections, I think we should jus=
t
> > > revert the two patches
> > Uhm, no.
> >
> > Why "the two" patches?
> >
> > This email, part of this thread,
> >
> > https://lore.kernel.org/all/87r0kircdo.fsf@vps.thesusis.net/
> >
> > clearly states that reverting *only* this commit,
> > 56e449603f0ac5 drm/sched: Convert the GPU scheduler to variable number =
of run-queues
> > *does not* mitigate the failed suspend. (Furthermore, this commit doesn=
't really change
> > anything operational, other than using an allocated array, instead of a=
 static one, in DRM,
> > while the 2nd patch is solely contained within the amdgpu driver code.)
> >
> > Leaving us with only this change,
> > b70438004a14f4 drm/amdgpu: move buffer funcs setting up a level
> > to be at fault, as the kernel log attached in the linked email above sh=
ows.
> >
> > The conclusion is that only b70438004a14f4 needs reverting.
>
> b70438004a14f4 was a fix for 56e449603f0ac5.  Without b70438004a14f4,
> 56e449603f0ac5 breaks amdgpu.

We can try and re-enable it in the next kernel.  I'm just not sure
we'll be able to fix this in time for 6.7 with the holidays and all
and I don't want to cause a lot of scheduler churn at the end of the
6.7 cycle if we hold off and try and fix it.  Reverting seems like the
best short term solution.

Alex

>
> Alex

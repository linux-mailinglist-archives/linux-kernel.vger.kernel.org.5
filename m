Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE707FE0CD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbjK2UK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbjK2UKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:10:23 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB1AD7F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:10:26 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1fa20395185so47302fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701288625; x=1701893425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kY1GN59hmbEJaNOpwQAxi652Fp3hiuaW7jARiW8zew8=;
        b=G3oAsHy6cPVbStp9mepdonDPLQuz27eiQTY/P1FPmYAsMNygWDlAuOImCOeq7QNMxm
         sfmeDBnfizUvYjl9OaL4zT599v6TYZqwTw8iQ6ITZmVbLl52w5FliRF5hKZSFFFBDpN7
         uj9uK/i8M+7JURmoMOkVt17ttcmkWtGV5FWTIG3r+oF5MwMcVHdOMrqA2x8KSNPC26HM
         kFKeoEkrg3/rFxt/lLmIdqpK6PIzepDx8bdzQ9x6OPKJUMvMrMtc7lPYPb3U5Gcvq3hA
         bj33jBQv26MV/Pp9z+iJRBqaIW8KKbt9zm4EfN5xN3nnUgXJCEPFTgo6ZuKYT1HBz5Dv
         FClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701288625; x=1701893425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kY1GN59hmbEJaNOpwQAxi652Fp3hiuaW7jARiW8zew8=;
        b=J3dKIF639bJG/KFuDvyrJcAqA/IyC2wVyPNjzLViahYpbQ/57gWB2wWw7GS4uDhPO7
         USuOs3zGJDH558lmd2H2hSNVenloHgrZG6NxrFH73JU3rcCY4Lh/0Ri0RzGzpgHwCE3T
         8/3Fiu4wrIsLDiNSb1nUnKU7XiyQ3vYpxSadKUREN+KnoyLljPr7nF/mjiwZZQU+Bmai
         Ted5zFDhCIohiNEW883gkCLGLySKIObzN1dIRV5vdLOK9EPfMKOcCIefwvHlgihuTJja
         ej+/uFwZKGwqFaC4jgCwupnyvNBHFmqea7BubnrNQBZ15jX/Flww1k+51MfFukiC6S2F
         H9dg==
X-Gm-Message-State: AOJu0YxfwHCyU4lyVvBYdPBu27Og2LMRVWp21LnyiTRiClV1mbKFdFsc
        V30ea8EHuXxd51rvRiiSow4Fh/WDs9e5Y56y9/zoslF8
X-Google-Smtp-Source: AGHT+IFF/qP3ukLLaH5SkwRpcG5Rn/G/+5CcGHEnukHZQgqdbv6oOYgnqOot/gbgWz4i5R1mWdpkT+sWBSqNGDxsaho=
X-Received: by 2002:a05:6870:2248:b0:1fa:a6d4:3b10 with SMTP id
 j8-20020a056870224800b001faa6d43b10mr3117415oaf.50.1701288625588; Wed, 29 Nov
 2023 12:10:25 -0800 (PST)
MIME-Version: 1.0
References: <87edgv4x3i.fsf@vps.thesusis.net> <559d0fa5-953a-4a97-b03b-5eb1287c83d8@leemhuis.info>
 <CAPM=9tw-8pQWFso0zuLqpsqd5BSHWtc4As9ttdjY-DDr70EMqQ@mail.gmail.com>
 <bdb238b6-60c7-4f26-81d0-9e62cd5dd326@gmail.com> <CADnq5_NVGS1XykxGxpcu_bpPbzboCUJQkcCF3r+0N9a23KUgiQ@mail.gmail.com>
 <96e2e13c-f01c-4baf-a9a3-cbaa48fb10c7@amd.com> <CADnq5_NBfeAXEyQw0gnSd67=tR-bUKg8w=10+4z9pGGuRnP9uw@mail.gmail.com>
 <87jzq2ixtm.fsf@vps.thesusis.net> <CADnq5_Ou-MVVm0rdWDmDnJNLkWUayXzO26uCEtz3ucNa4Ghy2w@mail.gmail.com>
 <95fe9b5b-05ce-4462-9973-9aca306bc44f@gmail.com> <CADnq5_MYEWx=e1LBLeVs0UbR5_xEScjDyw_-75mLe8RAMnqh6g@mail.gmail.com>
 <CADnq5_OC=JFpGcN0oGbTF5xYEt4X3r0=jEY6hJ12W8CzYq1+cA@mail.gmail.com>
 <9595b8bf-e64d-4926-9263-97e18bcd7d05@gmail.com> <CADnq5_N6DF-huOzgaVygvS5N_j_oNUEC1aa4zRsZTzx8GOD_aw@mail.gmail.com>
In-Reply-To: <CADnq5_N6DF-huOzgaVygvS5N_j_oNUEC1aa4zRsZTzx8GOD_aw@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 29 Nov 2023 15:10:14 -0500
Message-ID: <CADnq5_PgMxoW=4iabtgeHydwye-6DvwvCyETdfBToEpuYWocmA@mail.gmail.com>
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

Actually I think I see the problem.  I'll try and send out a patch
later today to test.

Alex

On Wed, Nov 29, 2023 at 1:52=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Wed, Nov 29, 2023 at 11:41=E2=80=AFAM Luben Tuikov <ltuikov89@gmail.co=
m> wrote:
> >
> > On 2023-11-29 10:22, Alex Deucher wrote:
> > > On Wed, Nov 29, 2023 at 8:50=E2=80=AFAM Alex Deucher <alexdeucher@gma=
il.com> wrote:
> > >>
> > >> On Tue, Nov 28, 2023 at 11:45=E2=80=AFPM Luben Tuikov <ltuikov89@gma=
il.com> wrote:
> > >>>
> > >>> On 2023-11-28 17:13, Alex Deucher wrote:
> > >>>> On Mon, Nov 27, 2023 at 6:24=E2=80=AFPM Phillip Susi <phill@thesus=
is.net> wrote:
> > >>>>>
> > >>>>> Alex Deucher <alexdeucher@gmail.com> writes:
> > >>>>>
> > >>>>>>> In that case those are the already known problems with the sche=
duler
> > >>>>>>> changes, aren't they?
> > >>>>>>
> > >>>>>> Yes.  Those changes went into 6.7 though, not 6.6 AFAIK.  Maybe =
I'm
> > >>>>>> misunderstanding what the original report was actually testing. =
 If it
> > >>>>>> was 6.7, then try reverting:
> > >>>>>> 56e449603f0ac580700621a356d35d5716a62ce5
> > >>>>>> b70438004a14f4d0f9890b3297cd66248728546c
> > >>>>>
> > >>>>> At some point it was suggested that I file a gitlab issue, but I =
took
> > >>>>> this to mean it was already known and being worked on.  -rc3 came=
 out
> > >>>>> today and still has the problem.  Is there a known issue I could =
track?
> > >>>>>
> > >>>>
> > >>>> At this point, unless there are any objections, I think we should =
just
> > >>>> revert the two patches
> > >>> Uhm, no.
> > >>>
> > >>> Why "the two" patches?
> > >>>
> > >>> This email, part of this thread,
> > >>>
> > >>> https://lore.kernel.org/all/87r0kircdo.fsf@vps.thesusis.net/
> > >>>
> > >>> clearly states that reverting *only* this commit,
> > >>> 56e449603f0ac5 drm/sched: Convert the GPU scheduler to variable num=
ber of run-queues
> > >>> *does not* mitigate the failed suspend. (Furthermore, this commit d=
oesn't really change
> > >>> anything operational, other than using an allocated array, instead =
of a static one, in DRM,
> > >>> while the 2nd patch is solely contained within the amdgpu driver co=
de.)
> > >>>
> > >>> Leaving us with only this change,
> > >>> b70438004a14f4 drm/amdgpu: move buffer funcs setting up a level
> > >>> to be at fault, as the kernel log attached in the linked email abov=
e shows.
> > >>>
> > >>> The conclusion is that only b70438004a14f4 needs reverting.
> > >>
> > >> b70438004a14f4 was a fix for 56e449603f0ac5.  Without b70438004a14f4=
,
> > >> 56e449603f0ac5 breaks amdgpu.
> > >
> > > We can try and re-enable it in the next kernel.  I'm just not sure
> > > we'll be able to fix this in time for 6.7 with the holidays and all
> > > and I don't want to cause a lot of scheduler churn at the end of the
> > > 6.7 cycle if we hold off and try and fix it.  Reverting seems like th=
e
> > > best short term solution.
> >
> > A lot of subsequent code has come in since commit 56e449603f0ac5, as it=
 opened
> > the opportunity for a 1-to-1 relationship between an entity and a sched=
uler.
> > (Should've always been the case, from the outset. Not sure why it was c=
oded as
> > a fixed-size array.)
> >
> > Given that commit 56e449603f0ac5 has nothing to do with amdgpu, and the=
 problem
> > is wholly contained in amdgpu, and no other driver has this problem, th=
ere is
> > no reason to have to "churn", i.e. go back and forth in DRM, only to co=
ver up
> > an init bug in amdgpu. See the response I just sent in @this thread:
> > https://lore.kernel.org/r/05007cb0-871e-4dc7-af58-1351f4ba43e2@gmail.co=
m
> >
> > And it's not like this issue is unknown. I first posted about it on 202=
3-10-16.
> >
> > Ideally, amdgpu would just fix their init code.
>
> You can't make changes to core code that break other drivers.
> Arguably 56e449603f0ac5 should not have gone in in the first place if
> it broke amdgpu.  b70438004a14f4 was the code to fix amdgpu's init
> code, but as a side effect it seems to have broken suspend for some
> users.
>
> Alex

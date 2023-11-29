Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F7F7FD8A2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbjK2NvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjK2NvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:51:05 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE71CE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:51:09 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6d856210057so89652a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701265868; x=1701870668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KD1muJiPB8+lXdz9QAzcQerA6N3IurpNa/FCWjvcTTA=;
        b=IsRfBS2cevhaB8UdzTVYOHqKkOkVQzwsq1Z+FJSSC04nxA/pVaAjrwgB9xJ88xh7Jk
         jP9wmRCrb6udHOJa2WdL+mu6pqHW3f+pIaYgOeLPT6b8v8TC7U2CFw+XnyCD1QYiuu77
         KAMOcJXnDfZspv2nlg31mUj+35uRPz2oFs0loxxI4y4EfhLf4WW21tnEmkhQEv6DXTsQ
         KGp5j4g5OVoA9Zg6gSC2D27bS1IrlIRlxeFO5H0iNE3fgMvPAs79N+fyyd0f/GJq00MQ
         Rlm3A8PzNK4fXeK1dok9UUgMf77SsfKzEOP5/vD0ZU0qYoV9WrWzgrHjZZLTdw3kMBsO
         Pplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701265868; x=1701870668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KD1muJiPB8+lXdz9QAzcQerA6N3IurpNa/FCWjvcTTA=;
        b=kFGYJRf12HDpbPTNzgI3RtA8OuzYMDhTAePW6hUCtVRfIl4NiKgNoH4LCFFC85klZh
         5iPFzEpiYC9DIDC1borMSkZPZ4nhxsx7NhO3fLrV2KjFE8Xyx2LFo2XcfxyVTt+ks07t
         KEMabGhB3Ak7UAKPZ5yoJaW6+3nNt6AVKlIVViuc8qbcu/oMYIwCWwGAH0+vwjJpOy2b
         jUZ+qYpg+YJHDTpuMpIZwqfhhsowUk96gd5ixEQfwfkeoOyjV3Y4gk3/frE+3/quk5SZ
         12AS1VMbEW1oBCBFXspi/NqH/Yf8IInJjfz7+rEnR1kj6ysSNda04HOb+Q+shKM3DidF
         OPZw==
X-Gm-Message-State: AOJu0Yxtd4ljfU6ZWlIoe1/mXQGFxAFgm7pj7kSh96n4Vm2hQsXJB7oN
        IlDPlxJUV6gXbw4tB85Z9SirV3yfh2PHCwJzrFE=
X-Google-Smtp-Source: AGHT+IF/P408lEGrdFVoOU8I1AP/p9OaFI9E1g6cnVNM5pbGGA7QD9y6ObERwISbTugNJXoU+G8fLgVOFsGaG1BgagU=
X-Received: by 2002:a05:6870:e99a:b0:1fa:126:2b27 with SMTP id
 r26-20020a056870e99a00b001fa01262b27mr20000238oao.50.1701265868318; Wed, 29
 Nov 2023 05:51:08 -0800 (PST)
MIME-Version: 1.0
References: <87edgv4x3i.fsf@vps.thesusis.net> <559d0fa5-953a-4a97-b03b-5eb1287c83d8@leemhuis.info>
 <CAPM=9tw-8pQWFso0zuLqpsqd5BSHWtc4As9ttdjY-DDr70EMqQ@mail.gmail.com>
 <bdb238b6-60c7-4f26-81d0-9e62cd5dd326@gmail.com> <CADnq5_NVGS1XykxGxpcu_bpPbzboCUJQkcCF3r+0N9a23KUgiQ@mail.gmail.com>
 <96e2e13c-f01c-4baf-a9a3-cbaa48fb10c7@amd.com> <CADnq5_NBfeAXEyQw0gnSd67=tR-bUKg8w=10+4z9pGGuRnP9uw@mail.gmail.com>
 <87jzq2ixtm.fsf@vps.thesusis.net> <CADnq5_Ou-MVVm0rdWDmDnJNLkWUayXzO26uCEtz3ucNa4Ghy2w@mail.gmail.com>
 <95fe9b5b-05ce-4462-9973-9aca306bc44f@gmail.com>
In-Reply-To: <95fe9b5b-05ce-4462-9973-9aca306bc44f@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 29 Nov 2023 08:50:56 -0500
Message-ID: <CADnq5_MYEWx=e1LBLeVs0UbR5_xEScjDyw_-75mLe8RAMnqh6g@mail.gmail.com>
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

On Tue, Nov 28, 2023 at 11:45=E2=80=AFPM Luben Tuikov <ltuikov89@gmail.com>=
 wrote:
>
> On 2023-11-28 17:13, Alex Deucher wrote:
> > On Mon, Nov 27, 2023 at 6:24=E2=80=AFPM Phillip Susi <phill@thesusis.ne=
t> wrote:
> >>
> >> Alex Deucher <alexdeucher@gmail.com> writes:
> >>
> >>>> In that case those are the already known problems with the scheduler
> >>>> changes, aren't they?
> >>>
> >>> Yes.  Those changes went into 6.7 though, not 6.6 AFAIK.  Maybe I'm
> >>> misunderstanding what the original report was actually testing.  If i=
t
> >>> was 6.7, then try reverting:
> >>> 56e449603f0ac580700621a356d35d5716a62ce5
> >>> b70438004a14f4d0f9890b3297cd66248728546c
> >>
> >> At some point it was suggested that I file a gitlab issue, but I took
> >> this to mean it was already known and being worked on.  -rc3 came out
> >> today and still has the problem.  Is there a known issue I could track=
?
> >>
> >
> > At this point, unless there are any objections, I think we should just
> > revert the two patches
> Uhm, no.
>
> Why "the two" patches?
>
> This email, part of this thread,
>
> https://lore.kernel.org/all/87r0kircdo.fsf@vps.thesusis.net/
>
> clearly states that reverting *only* this commit,
> 56e449603f0ac5 drm/sched: Convert the GPU scheduler to variable number of=
 run-queues
> *does not* mitigate the failed suspend. (Furthermore, this commit doesn't=
 really change
> anything operational, other than using an allocated array, instead of a s=
tatic one, in DRM,
> while the 2nd patch is solely contained within the amdgpu driver code.)
>
> Leaving us with only this change,
> b70438004a14f4 drm/amdgpu: move buffer funcs setting up a level
> to be at fault, as the kernel log attached in the linked email above show=
s.
>
> The conclusion is that only b70438004a14f4 needs reverting.

b70438004a14f4 was a fix for 56e449603f0ac5.  Without b70438004a14f4,
56e449603f0ac5 breaks amdgpu.

Alex

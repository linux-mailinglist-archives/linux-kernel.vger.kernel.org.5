Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663E27F1A00
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbjKTRbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjKTRbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:31:53 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9496D8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:31:49 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1f938410f92so664702fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700501509; x=1701106309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAF1U/lCbnAz9mXeRmxCPX739RNT9Ki2al6h9FhAbIA=;
        b=lcwtqxZko3TddVRGzqogbr3ywmZHJw7TLUjAH+7nVS5xIng7Se9yQEBtqwtZB+yRJs
         4LVgd/NHWm7c6B34OibpgElYCq8Ywr8IiSpA9ni37hs37Ihm1Y9sq8F/cpvKURGO/cTV
         ckeYeckaPno7LO2Rq/xvWWzeVXyFvfmuL+12MwP1rTgyQBNfmcF3x4Aq1Tgfjn2I5agT
         sFgzDl71mT2VNjSbhw3Zo5koTvBRxOLy2KSOSj8nW9gkxzBVuNSMTtV332jR3k456l1L
         Et2ss4bmwf/OymyFIjH9T8jwPlvs4sqpaGqbR9VSNN+og4qeF3HbzDrACNd/3078JPlj
         oRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700501509; x=1701106309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAF1U/lCbnAz9mXeRmxCPX739RNT9Ki2al6h9FhAbIA=;
        b=XmAABpwN77+TEvt+3ia5UcGI8v9Dj38aHEueAfy6D+nInvWP0DMc2qZ5MtA+gWs7tW
         P5iYmcY8t2QWwx0ce91e6IqyugOc6lvHzYkLDpVN1tLWU8obQBrfUgo9sFJPIzpN9V15
         jJi+WakzBkl1tnciL9ps8SLkgBfsEqe2bwCP8UoM/i7Ad6CDTXSZtRHKH/U8ejwnBqeP
         2/ct2KtdRGic8tPjwfLxfcTs9+7YgPfafqKjMQO7dOgTvFsLSmzmzhz36a4mgTJ/n5cq
         noXNxePvZuLlgMknZ8f5LLBA66/xVZ5Sviyzqtm28y7Gd2nChSGyQXbJ5n8hYtlLi2cO
         i16A==
X-Gm-Message-State: AOJu0YyYzDB97WnQhP5B0fHAoKyKBD6wUqgpMnuJZdNuVONos2T2f93m
        r3W1GHskfcRUFoyqjjJ73xwJHWBCtIGJC64zhoo=
X-Google-Smtp-Source: AGHT+IHXGPskkZjPASHv5zjmBj8vTC+m/HXkKut1/0s33s6XPps0+a5t8sGmtHhxRowQsRtHWKhR/1Ty6hqrzEufKKE=
X-Received: by 2002:a05:6870:d3cc:b0:1f0:c29:d75c with SMTP id
 l12-20020a056870d3cc00b001f00c29d75cmr9798494oag.47.1700501509193; Mon, 20
 Nov 2023 09:31:49 -0800 (PST)
MIME-Version: 1.0
References: <87edgv4x3i.fsf@vps.thesusis.net> <559d0fa5-953a-4a97-b03b-5eb1287c83d8@leemhuis.info>
 <CAPM=9tw-8pQWFso0zuLqpsqd5BSHWtc4As9ttdjY-DDr70EMqQ@mail.gmail.com>
 <bdb238b6-60c7-4f26-81d0-9e62cd5dd326@gmail.com> <CADnq5_NVGS1XykxGxpcu_bpPbzboCUJQkcCF3r+0N9a23KUgiQ@mail.gmail.com>
 <96e2e13c-f01c-4baf-a9a3-cbaa48fb10c7@amd.com>
In-Reply-To: <96e2e13c-f01c-4baf-a9a3-cbaa48fb10c7@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 20 Nov 2023 12:31:38 -0500
Message-ID: <CADnq5_NBfeAXEyQw0gnSd67=tR-bUKg8w=10+4z9pGGuRnP9uw@mail.gmail.com>
Subject: Re: Radeon regression in 6.6 kernel
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        linux-kernel@vger.kernel.org,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        dri-devel@lists.freedesktop.org, Phillip Susi <phill@thesusis.net>,
        Alex Deucher <alexander.deucher@amd.com>
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

On Mon, Nov 20, 2023 at 11:24=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 20.11.23 um 17:08 schrieb Alex Deucher:
> > On Mon, Nov 20, 2023 at 10:57=E2=80=AFAM Christian K=C3=B6nig
> > <ckoenig.leichtzumerken@gmail.com> wrote:
> >> Am 19.11.23 um 07:47 schrieb Dave Airlie:
> >>>> On 12.11.23 01:46, Phillip Susi wrote:
> >>>>> I had been testing some things on a post 6.6-rc5 kernel for a week =
or
> >>>>> two and then when I pulled to a post 6.6 release kernel, I found th=
at
> >>>>> system suspend was broken.  It seems that the radeon driver failed =
to
> >>>>> suspend, leaving the display dead, the wayland display server hung,=
 and
> >>>>> the system still running.  I have been trying to bisect it for the =
last
> >>>>> few days and have only been able to narrow it down to the following=
 3
> >>>>> commits:
> >>>>>
> >>>>> There are only 'skip'ped commits left to test.
> >>>>> The first bad commit could be any of:
> >>>>> 56e449603f0ac580700621a356d35d5716a62ce5
> >>>>> c07bf1636f0005f9eb7956404490672286ea59d3
> >>>>> b70438004a14f4d0f9890b3297cd66248728546c
> >>>>> We cannot bisect more!
> >>>> Hmm, not a single reply from the amdgpu folks. Wondering how we can
> >>>> encourage them to look into this.
> >>>>
> >>>> Phillip, reporting issues by mail should still work, but you might h=
ave
> >>>> more luck here, as that's where the amdgpu afaics prefer to track bu=
gs:
> >>>> https://gitlab.freedesktop.org/drm/amd/-/issues
> >>>>
> >>>> When you file an issue there, please mention it here.
> >>>>
> >>>> Furthermore it might help if you could verify if 6.7-rc1 (or rc2, wh=
ich
> >>>> comes out later today) or 6.6.2-rc1 improve things.
> >>> It would also be good to test if reverting any of these is possible o=
r not.
> >> Well none of the commits mentioned can affect radeon in any way. Radeo=
n
> >> simply doesn't use the scheduler.
> >>
> >> My suspicion is that the user is actually using amdgpu instead of
> >> radeon. The switch potentially occurred accidentally, for example by
> >> compiling amdgpu support for SI/CIK.
> >>
> >> Those amdgpu problems for older ASIC have already been worked on and
> >> should be fixed by now.
> > In this case it's a navi23 (so radeon in the marketing sense).
>
> Thanks, couldn't find that in the mail thread.
>
> In that case those are the already known problems with the scheduler
> changes, aren't they?

Yes.  Those changes went into 6.7 though, not 6.6 AFAIK.  Maybe I'm
misunderstanding what the original report was actually testing.  If it
was 6.7, then try reverting:
56e449603f0ac580700621a356d35d5716a62ce5
b70438004a14f4d0f9890b3297cd66248728546c

Alex

>
> Christian.
>
> >
> > Alex
> >
> >> Regards,
> >> Christian.
> >>
> >>> File the gitlab issue and we should poke amd a but more to take a loo=
k.
> >>>
> >>> Dave.
>

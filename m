Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8507DDD9C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 09:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjKAINu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 04:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjKAINt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 04:13:49 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5740103
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 01:13:41 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1d542f05b9aso1331113fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 01:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1698826421; x=1699431221; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iTrJrLiBbNpY45EDAaoUQiZijsCyasehzQFvLcrvRfE=;
        b=N0moWa0eDlX8w1Yncve6lzhrU1h5IVjW49chOqf2+DG5Yf6ZxrJgr5n2XXs0NgQ2fW
         GLFtSOgeDRa7Yp0bFVP6u+CNWQjnPs4wUVvZspG6dHwey9RHzUW5wNRNVbXA2LH20/ow
         ioS/BD+djVaTSPAYosa/40PWugcreRm4O+rSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698826421; x=1699431221;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iTrJrLiBbNpY45EDAaoUQiZijsCyasehzQFvLcrvRfE=;
        b=rDw00OeDHTHyi8js32D40Ci/HNR94WXMuKS8XF0QD70iXtqzZrLWjlXHMOgOfqDh/m
         kV5ibIyt6CVQTERsjH2whUqUPTPFFQDPiDYLbordagvDC8piSoIyhuEDKfePQMLzgCTS
         OptFQlhW7ej9SQNLuISzcv0YO8wKWjfs8HeAB15K/rSMB9//ISYM+hPliqgmFyBbjFZS
         VyQEe9PW83XbcCdfrWMCFFRWmuKfKTEhFgEVDWCVysl3zkshttUyKB0Rr9qHWgqRzocr
         foG6ssvtXgq9IcsyxxV8IMN8dqJc+x/Ek9mJFNYESU773l66aljoyZG35H2PWngFrV47
         rSFw==
X-Gm-Message-State: AOJu0YzXG1lZWjJO10PJm1Q0BpsjWlWOyiLsqpVR7cBs7qgwm2lkNRRz
        7riMXlmZkQEJ+Pg+iqakiCA3/XCvofvy8sinrd7X6w==
X-Google-Smtp-Source: AGHT+IHNo6PSvmt4/ey9BXcYHKsI5T5cP/oapm7vIEpZ5K+zWs51oNxmCWeDe0/qnVahB9OScvTSqBGtBMtX0xcfODM=
X-Received: by 2002:a05:6870:af44:b0:1e9:8ab9:11ca with SMTP id
 uy4-20020a056870af4400b001e98ab911camr19772936oab.3.1698826421144; Wed, 01
 Nov 2023 01:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <9c0cff84-45b1-268f-bdad-38c16316dbc3@amd.com> <20230714-drm-sched-fixes-v1-0-c567249709f7@asahilina.net>
 <20230714-drm-sched-fixes-v1-2-c567249709f7@asahilina.net>
 <bef7ef62-3cd9-6ceb-5eb4-5ae0c0236778@amd.com> <de502b41-2864-db1e-16a0-8a5d5e0e4ad3@asahilina.net>
 <d9dc2fd5-d054-dbf3-72b7-fe9deaa46350@amd.com> <236422117088ca854a6717114de73d99b2b9ba2f@rosenzweig.io>
 <a42bd218-6eb5-6ddb-bbb4-d25118c59f40@amd.com> <7b564e55-a9b7-0585-3cf1-d1f132f9a918@asahilina.net>
 <daf48d76-ceee-c82d-a63a-e8e7770a9d83@amd.com> <f5de10fa-57d6-a3d0-1cf9-084491aa6025@asahilina.net>
 <200e9d74-7191-b1ed-e5f3-775827550853@amd.com> <CAPM=9txcC9+ZePA5onJxtQr+nBe8UcA3_Kp5Da3zjKL7ZB4JPQ@mail.gmail.com>
In-Reply-To: <CAPM=9txcC9+ZePA5onJxtQr+nBe8UcA3_Kp5Da3zjKL7ZB4JPQ@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 1 Nov 2023 09:13:29 +0100
Message-ID: <CAKMK7uG0G02ierkgAmJE1gfLto08LK5twGUEX1qN+qk9-AavYA@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/scheduler: Fix UAF in drm_sched_fence_get_timeline_name
To:     Dave Airlie <airlied@gmail.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Asahi Lina <lina@asahilina.net>,
        Luben Tuikov <luben.tuikov@amd.com>, alyssa@rosenzweig.io,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Faith Ekstrand <faith.ekstrand@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2023 at 07:59, Dave Airlie <airlied@gmail.com> wrote:
>
> >
> > Well, to make it clear once more: Signaling a dma_fence from the
> > destructor of a reference counted object is very problematic! This will
> > be rejected no matter if you do that in C or in Rust.
> >
> > What we can do is to make it safe in the sense that you don't access
> > freed up memory by using the scheduler fences even more as wrapper
> > around the hardware fence as we do now. But this quite a change and
> > requires a bit more than just hacking around
> > drm_sched_fence_get_timeline_name().
>
> I really think this needs to be documented if nothing else out of this thread.
>
> Clearly nobody is going to get it right and hidden here in this
> thread, this info isn't useful.
>
> Can we have some sort of design document for the dma-fence/scheduler
> interactions written and we can try and refine it with solutions on
> the list, because I'm tired of people proposing things and NAK's
> getting thrown around without anything to point people at.
>
> The next NAK I see on the list will mean I block all patches from the
> sender until they write a documentation patch, because seriously this
> stuff is too hard for someone to just keep it in their head and expect
> everyone else to understand from reading the code.

I very much like the idea that NAK replies are counted as "you've just
volunteered yourself for some documentation patches so that next time
around you can reply with a link to the docs instead of just a NAK".

I don't think we'll get out of these discussions otherwise, since
currently we have undocumented, but very tricky semantics of the
drm/sched codebase for ringbuffer scheduling which is extended to fw
scheduling in also very tricky ways, with not entirely clear impacts
on semantics of all the drm/sched things. And as a result we just pile
up enormous amounts of threads where I think the only thing assured is
that people talk past each another.

Converting NAKs into doc patches should at least eventually get rid of
the worst confusions we're dealing with here.

Cheers, Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

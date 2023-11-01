Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19BB7DDCE9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 08:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345061AbjKAHAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 03:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjKAHAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 03:00:01 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A47E4;
        Tue, 31 Oct 2023 23:59:54 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9c603e235d1so1012945266b.3;
        Tue, 31 Oct 2023 23:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698821993; x=1699426793; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OoRJsZQA0JRmj7+Zm7KWg2a0Vv+QGemQYHWSkunKRm8=;
        b=j5/2YLYeYo2VVfUg3BpcwjWcCe4BlZTRDENHAHNUcCzV8j6iV8DW+PWURR/ptgqJhJ
         owsaBi6/QTWb0t4/K+mqwEs/VGYecdbrf0TsPgJc1LcG9ln8nlYfKxU3rL4j34tMoSM+
         MYmm61J5Y05HCvNv2j1Qql/tNodBqF7cWuvExc3r8KYM4MjHCfnnGn7CikBYdXHN4F60
         GnlzIVVsaXlMToQTmZ61X42bexiVFPDo1hxb1lr3jzz1QtG7pw4/Abu7eoDVHy6y1+ZA
         FITKjs1Nxa/ikUWqSs6d15bRSEMRE86QvCLlKbxRMgWOnPeYoH8ytWcG30GkvAAxJV2W
         vlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698821993; x=1699426793;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OoRJsZQA0JRmj7+Zm7KWg2a0Vv+QGemQYHWSkunKRm8=;
        b=Gu2I2VDnKSTXwARyPKyOF2K6HJniXRyG0bQZOvl4VM59Pk7fmV1sWgztd6MNiE72Pf
         GoUXyn+2X68KQq6n4KUl6VgUWWuigjFokivW/cLlF6UYhZn7C97JTYM25x5SkwsUuucY
         /2hS/WmEvZR2bxLZ5X8yHf9lEsswbxA0ulZHw+hW2deIvyfi2QenRYP2CLBHITlbw9WM
         zByUzP8LdJnO9Iphij2X4MQSYg3utPxAAvRcAIZLQBLxKME6yfXvmXUjEgxSam4lu2YF
         O3oScgL8pGR7s5LWad+xRuvo0PwLa3LjTiG2uCMCF+5/rUtUbZjQ/JlqbCB4KTLYNL3r
         Sf1g==
X-Gm-Message-State: AOJu0YxD5DHjsuqbdPoWvJkjEK8eZWOWrCDxV1/qlEpQFJowGAgmnm5P
        3GOQo/euakyGgMHFfjAsmCrTIuh2AyUC0oADa5s=
X-Google-Smtp-Source: AGHT+IEr42YbSo5u1ztwgfEXuJgcVFbGHH6ew8zc8QEvevYhY3xgiLLyXDW3jKmYJXFF/eUQO4FOj43/eeqO2NRVnLo=
X-Received: by 2002:a17:907:36cd:b0:9be:5ab2:73c2 with SMTP id
 bj13-20020a17090736cd00b009be5ab273c2mr1135771ejc.58.1698821992749; Tue, 31
 Oct 2023 23:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <9c0cff84-45b1-268f-bdad-38c16316dbc3@amd.com> <20230714-drm-sched-fixes-v1-0-c567249709f7@asahilina.net>
 <20230714-drm-sched-fixes-v1-2-c567249709f7@asahilina.net>
 <bef7ef62-3cd9-6ceb-5eb4-5ae0c0236778@amd.com> <de502b41-2864-db1e-16a0-8a5d5e0e4ad3@asahilina.net>
 <d9dc2fd5-d054-dbf3-72b7-fe9deaa46350@amd.com> <236422117088ca854a6717114de73d99b2b9ba2f@rosenzweig.io>
 <a42bd218-6eb5-6ddb-bbb4-d25118c59f40@amd.com> <7b564e55-a9b7-0585-3cf1-d1f132f9a918@asahilina.net>
 <daf48d76-ceee-c82d-a63a-e8e7770a9d83@amd.com> <f5de10fa-57d6-a3d0-1cf9-084491aa6025@asahilina.net>
 <200e9d74-7191-b1ed-e5f3-775827550853@amd.com>
In-Reply-To: <200e9d74-7191-b1ed-e5f3-775827550853@amd.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 1 Nov 2023 16:59:40 +1000
Message-ID: <CAPM=9txcC9+ZePA5onJxtQr+nBe8UcA3_Kp5Da3zjKL7ZB4JPQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/scheduler: Fix UAF in drm_sched_fence_get_timeline_name
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Asahi Lina <lina@asahilina.net>,
        Luben Tuikov <luben.tuikov@amd.com>, alyssa@rosenzweig.io,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Faith Ekstrand <faith.ekstrand@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Well, to make it clear once more: Signaling a dma_fence from the
> destructor of a reference counted object is very problematic! This will
> be rejected no matter if you do that in C or in Rust.
>
> What we can do is to make it safe in the sense that you don't access
> freed up memory by using the scheduler fences even more as wrapper
> around the hardware fence as we do now. But this quite a change and
> requires a bit more than just hacking around
> drm_sched_fence_get_timeline_name().

I really think this needs to be documented if nothing else out of this thread.

Clearly nobody is going to get it right and hidden here in this
thread, this info isn't useful.

Can we have some sort of design document for the dma-fence/scheduler
interactions written and we can try and refine it with solutions on
the list, because I'm tired of people proposing things and NAK's
getting thrown around without anything to point people at.

The next NAK I see on the list will mean I block all patches from the
sender until they write a documentation patch, because seriously this
stuff is too hard for someone to just keep it in their head and expect
everyone else to understand from reading the code.

Dave.

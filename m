Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D7C7ABAB0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 22:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjIVUw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 16:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjIVUw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 16:52:26 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E9FCE;
        Fri, 22 Sep 2023 13:52:20 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52f3ba561d9so6982440a12.1;
        Fri, 22 Sep 2023 13:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695415939; x=1696020739; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r3oqUTe9wNeve3d2J33jPhFoj9/rOq9QesLkANOfVRw=;
        b=AMo7Oz6JKpDbKC+WhyHVDiO9+VnuLrq5OJaa2zc/tFHHVxHatPMnR3YCRLJZGjhDYV
         jvl5TXkaAy/Vp2k/KqUwSI1NtIyHmzqnpR+qW+1LHgP1dCsnmEnYugKt9UVadOakWouS
         YHRWdSG4lH5z98QFOFwAil0GSH2zX1dx4GdT2Y/WvdWxxoCIWoxyXMAaFj0necnxj2Jb
         P4wwyW1LWIag4gI7i/3ul959ZXZ5o4iIts7Xg6F5z30klm349KyGlE8GVbfheUPaGzbv
         8iSc65ql2MT8pBHRImcz9oo7nMhZGM6gaAzj5sCA0ml9mq+FcGKqeF196h2iIUmurOBF
         cdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695415939; x=1696020739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r3oqUTe9wNeve3d2J33jPhFoj9/rOq9QesLkANOfVRw=;
        b=UShyVqUqadV5pPQNQBgTNIpvT2Bd0G28Qe0oqD26YTVO04fiYeFkxGXb3p+nJhqQNR
         jveRySUKfu+vVbkJyPg5yqJ1OEnNS8yTm16Kq1aiLsMNkzyJcx4MF4AV49itO5zg4KT6
         Rw68OQ0/+Gx3M54DzEKuz90w3NkcydLzn5wfDdxzhfLH4YdU0HfRwGIGyNcJVd1j2rvj
         FPforXroKkEsFs2wqrdzluvxURBn4lBDWc+lMbGqZfFPTjzR0t2WPaKZ0/D5Iss0AKhl
         e9Cv7q2mgov+6HpZGKoI4LNdyRBC++ZL4eQFHJdTipCny7CzW2hpLtvdw/HC+dJRLmsA
         qKJA==
X-Gm-Message-State: AOJu0Yzxs09YoTgsfmS4bKvc0DTtjPHD1IeGbjc5xeOM/ClluWWn6FBb
        XOMK0uskflDJZxegbThjt3aD/viFbvSou7ppbjQ=
X-Google-Smtp-Source: AGHT+IGai71+8E/DfqHKaccXApvdAwzcb/1J5L1Y8/Im5VWZzW/x5K0fN2UeDxQgvD3eiAtUlzVAHFSO/LjCReVHRlk=
X-Received: by 2002:aa7:d293:0:b0:525:8124:20fe with SMTP id
 w19-20020aa7d293000000b00525812420femr1387283edq.18.1695415938567; Fri, 22
 Sep 2023 13:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <5a7f2a6e-46a4-a5c8-fe6a-c2581496b5cd@gmail.com>
 <c7e70f54-9696-4b39-aa17-576987ffce85@leemhuis.info> <CANiJ1U80VNiLGKEmgYpGjUQ2poREN9uGnv2QXM_GtzjgBtUSWQ@mail.gmail.com>
 <2662e142-8b19-6e88-8030-47815598bf12@leemhuis.info>
In-Reply-To: <2662e142-8b19-6e88-8030-47815598bf12@leemhuis.info>
From:   brett hassall <brett.hassall@gmail.com>
Date:   Sat, 23 Sep 2023 06:52:07 +1000
Message-ID: <CANiJ1U8VJfJ9GX3m0Z3KhGKRKwWiQOcC6-_Pi8Aj_27nBQrYqw@mail.gmail.com>
Subject: Re: Fwd: 5c8a79e8e12b ("wifi: rtw88: correct PS calculation for
 SUPPORTS_DYNAMIC_PS", 2023-05-27) increases CPU usage usage for irq
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I don't think it is a duplicate.

https://bugzilla.kernel.org/show_bug.cgi?id=217841 affects systems
with VMD controllers. I searched the lspci output from
https://bugzilla.kernel.org/show_bug.cgi?id=217321 and the system does
not have a VMD controller.

I also checked that patch code and it does not appear related.

Thanks

On Thu, 21 Sept 2023 at 00:09, Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> On 16.09.23 01:04, brett hassall wrote:
> >
> > I'd suggest that there are actually 2 regressions
> > (https://bugzilla.kernel.org/show_bug.cgi?id=217841 and this bug). Bug
> > 217841 masks this bug
>
> Is that maybe a duplicate of this one:
> https://bugzilla.kernel.org/show_bug.cgi?id=217321
>
> In that case it might make sense to test with a proposed fix for that
> bug (that iirc is
> https://lore.kernel.org/all/20230911073352.3472918-1-mika.westerberg@linux.intel.com/
> ) to speed up fixing the rtw88 regression in case there is one.
>
> Ciao, Thorsten
>
> > as it prevents the laptop reaching package C8
> > and I'm assuming this bug shows when in C8. The patch for 21784 only
> > affects devices connected to a VMD controller so I wouldn't expect it
> > to affect the 8822CE.
> >
> > Options that I can see are:
> > 1. Park this bug until 217841 is resolved
> > 2. Try to test on a laptop with a Realtek 8822CE but not a VMD
> > controller. I have access to 5 different laptop models but none meet
> > those criteria.
> >
> >
> > Thanks for the reply
> > Brett
> >
> > On Mon, 11 Sept 2023 at 23:29, Linux regression tracking (Thorsten
> > Leemhuis) <regressions@leemhuis.info> wrote:
> >>
> >> On 27.08.23 04:37, Bagas Sanjaya wrote:
> >>>
> >>> I notice a regression report on Bugzilla [1]. Quoting from it:
> >>>
> >>>> This commit improves power saving - it enables the kernel to
> >>>> achieve package C8. To achieve package C8, 3 Ubuntu VMD commits
> >>>> must be applied as well. [...]
> >>
> >> To me that sounds like there is no upstream problem, hence this
> >> shouldn't be tracked as a regression. Please correct me if I'm wrong.
> >>
> >>> #regzbot introduced: 26a125f550a3bf
> >>> https://bugzilla.kernel.org/show_bug.cgi?id=217828 #regzbot title:
> >>> correcting SUPPORTS_DYNAMIC_PS calculation for rtw88 increases CPU
> >>> utilization #regzbot link:
> >>> https://bugs.launchpad.net/ubuntu/+source/linux-hwe-6.2/+bug/2025040
> >>>
> >>> Thanks.
> >>>
> >>> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217828
> >>
> >> #regzbot resolved: invalid: seems to only be a problem with a patched kernel
> >> #regzbot ignore-activity
> >>
> >> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> >> --
> >> Everything you wanna know about Linux kernel regression tracking:
> >> https://linux-regtracking.leemhuis.info/about/#tldr
> >> If I did something stupid, please tell me, as explained on that page.
> >>
> >>
> >
> >

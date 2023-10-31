Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C8B7DC9D1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjJaJq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjJaJqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:46:24 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA501DB
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:46:21 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so11446a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698745580; x=1699350380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTxwVslDLW3XYJPo7d6erwK3L6Z/wP0aOPPJa5+jpt4=;
        b=Ivazv2FBA1ly+xwSsRAuPrEZQbH7qt9T9KSwF9PKoaIjiAlRn5yfEPKpLnQaR2FFyH
         DyQXiPaP81qWm7LxoL7hTwYnZEZireSPxUrE4rrrDImhZFOG6MdBUAf9K8YOJeGD5T/4
         NyVURawt1jAVvuc0JgZpriAAYS1ze0D9eg3D4kDhfgzB0mwuxyC4505/8+sp29Wl/KNC
         4FNgwYxi9eH9rXP5sdZGFdbTurjhb1foyalotKs51VhET6SoPNZj+gPZNISf8buY4oAO
         IU9W3+sLBAEahflyJtZ+dT2o+ahoY62fciWcjNVdmK6SYJwAp/Ypk3CVA30K9tyyn8F6
         mhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698745580; x=1699350380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTxwVslDLW3XYJPo7d6erwK3L6Z/wP0aOPPJa5+jpt4=;
        b=CCT0Dn91JebQF2/01I/K7goXKvzJjDcMxrRX96zRiB0mDYnif9QIA8QDLwW2DVmEba
         pFV471J6EW4gKq1omZqrEgf5iBO7ZwmTIcLJR0RLb42AlKosoXBhm5QwcABZlvKan/Ch
         tnbY82WO7WtHEQVWHJuTC4YUwArwXK5FG97eJ4EMluIypghYhODYf3G8F6uJJW1T1Yex
         hXeGpGHrmHQU0gbIOIZKrA2QSPGKiRIpjXZdkzTV03kJrG//CdtpGsYdraoxkNzbOFzC
         TrnomjCsgnJ6kjGo7E6TN5Yf/bERf/nbzGNX4plmDBkzIlZf9Ch/XtAr0ZF4e2Dl4bC+
         RZGw==
X-Gm-Message-State: AOJu0YxSogfaihVXoEYKj8N61IFMUJPFeMvJnTqlWu3kBaYh7QR91+4H
        P2qMJq6EuOxGVxW1gv7sA+IkZjY16DgRChnRTQPraA==
X-Google-Smtp-Source: AGHT+IGN3mM2N+nqhUvVo2QBdU6T2kfKp/GcVG7fysFgfPGginW9R/mMZndp5Wgf1dH9dRq0NT6zzHwUQrAg7PXbjGQ=
X-Received: by 2002:a50:d514:0:b0:543:3f97:aa0f with SMTP id
 u20-20020a50d514000000b005433f97aa0fmr77047edi.4.1698745579834; Tue, 31 Oct
 2023 02:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <VI1P193MB075256E076A09E5B2EF7A16F99D6A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <CA+fCnZfn0RnnhifNxctrUaLEptE=z9L=e3BY_8tRH2UXZWAO6Q@mail.gmail.com>
 <VI1P193MB07524EFBE97632D575A91EDB99A2A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <CACT4Y+a+xfzXBgqVz3Gxv4Ri1CqHTV1m=i=h4j5KWxsmdP+t5A@mail.gmail.com>
 <VI1P193MB075221DDE87BE09A4E7CBB1A99A1A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <CACT4Y+bxMKEVUhu-RDvOMcbah=iYCWdXFZDU0JN3D7OP26Q_Dw@mail.gmail.com> <VI1P193MB0752753CB059C9A4420C875799A1A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
In-Reply-To: <VI1P193MB0752753CB059C9A4420C875799A1A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 31 Oct 2023 10:46:07 +0100
Message-ID: <CACT4Y+ZS5cz9wZgxLVo2EsGtt-tkFXkFPA6CGAA8Gy7+sEyDUQ@mail.gmail.com>
Subject: Re: [RFC] mm/kasan: Add Allocation, Free, Error timestamps to KASAN report
To:     Juntong Deng <juntong.deng@outlook.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>, ryabinin.a.a@gmail.com,
        glider@google.com, vincenzo.frascino@arm.com,
        akpm@linux-foundation.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 at 12:32, Juntong Deng <juntong.deng@outlook.com> wrote=
:
>
> On 2023/10/30 18:10, Dmitry Vyukov wrote:
> > On Mon, 30 Oct 2023 at 10:28, Juntong Deng <juntong.deng@outlook.com> w=
rote:
> >>
> >> On 2023/10/30 14:29, Dmitry Vyukov wrote:
> >>> On Sun, 29 Oct 2023 at 10:05, Juntong Deng <juntong.deng@outlook.com>=
 wrote:
> >>>>
> >>>> On 2023/10/26 3:22, Andrey Konovalov wrote:
> >>>>> On Tue, Oct 17, 2023 at 9:40=E2=80=AFPM Juntong Deng <juntong.deng@=
outlook.com> wrote:
> >>>>>>
> >>>>>> The idea came from the bug I was fixing recently,
> >>>>>> 'KASAN: slab-use-after-free Read in tls_encrypt_done'.
> >>>>>>
> >>>>>> This bug is caused by subtle race condition, where the data struct=
ure
> >>>>>> is freed early on another CPU, resulting in use-after-free.
> >>>>>>
> >>>>>> Like this bug, some of the use-after-free bugs are caused by race
> >>>>>> condition, but it is not easy to quickly conclude that the cause o=
f the
> >>>>>> use-after-free is race condition if only looking at the stack trac=
e.
> >>>>>>
> >>>>>> I did not think this use-after-free was caused by race condition a=
t the
> >>>>>> beginning, it took me some time to read the source code carefully =
and
> >>>>>> think about it to determine that it was caused by race condition.
> >>>>>>
> >>>>>> By adding timestamps for Allocation, Free, and Error to the KASAN
> >>>>>> report, it will be much easier to determine if use-after-free is
> >>>>>> caused by race condition.
> >>>>>
> >>>>> An alternative would be to add the CPU number to the alloc/free sta=
ck
> >>>>> traces. Something like:
> >>>>>
> >>>>> Allocated by task 42 on CPU 2:
> >>>>> (stack trace)
> >>>>>
> >>>>> The bad access stack trace already prints the CPU number.
> >>>>
> >>>> Yes, that is a great idea and the CPU number would help a lot.
> >>>>
> >>>> But I think the CPU number cannot completely replace the free timest=
amp,
> >>>> because some freeing really should be done at another CPU.
> >>>>
> >>>> We need the free timestamp to help us distinguish whether it was fre=
ed
> >>>> a long time ago or whether it was caused to be freed during the
> >>>> current operation.
> >>>>
> >>>> I think both the CPU number and the timestamp should be displayed, m=
ore
> >>>> information would help us find the real cause of the error faster.
> >>>>
> >>>> Should I implement these features?
> >>>
> >>> Hi Juntong,
> >>>
> >>> There is also an aspect of memory consumption. KASAN headers increase
> >>> the size of every heap object. So we tried to keep them as compact as
> >>> possible. At some point CPU numbers and timestamps (IIRC) were alread=
y
> >>> part of the header, but we removed them to shrink the header to 16
> >>> bytes.
> >>> PID gives a good approximation of potential races. I usually look at
> >>> PIDs to understand if it's a "plain old single-threaded
> >>> use-after-free", or free and access happened in different threads.
> >>> Re timestamps, I see you referenced a syzbot report. With syzkaller
> >>> most timestamps will be very close even for non-racing case.
> >>> So if this is added, this should be added at least under a separate c=
onfig.
> >>>
> >>> If you are looking for potential KASAN improvements, here is a good l=
ist:
> >>> https://bugzilla.kernel.org/buglist.cgi?bug_status=3D__open__&compone=
nt=3DSanitizers&list_id=3D1134168&product=3DMemory%20Management
> >>
> >> Hi Dmitry,
> >>
> >> I think PID cannot completely replace timestamp for reason similar to
> >> CPU number, some frees really should be done in another thread, but it
> >> is difficult for us to distinguish if it is a free that was done some
> >> time ago, or under subtle race conditions.
> >
> > I agree it's not a complete replacement, it just does not consume
> > additional memory.
> >
> >> As to whether most of the timestamps will be very close even for
> >> non-racing case, this I am not sure, because I do not have
> >> enough samples.
> >>
> >> I agree that these features should be in a separate config and
> >> the user should be free to choose whether to enable them or not.
> >>
> >> We can divide KASAN into normal mode and depth mode. Normal mode
> >> records only minimal critical information, while depth mode records
> >> more potentially useful information.
> >>
> >> Also, honestly, I think a small amount of extra memory consumption
> >> should not stop us from recording more information.
> >>
> >> Because if someone enables KASAN for debugging, then memory consumptio=
n
> >> and performance are no longer his main concern.
> >
> > There are a number of debugging tools created with the "performance
> > does not matter" attitude. They tend to be barely usable, not usable
> > in wide scale testing, not usable in canaries, etc.
> > All of sanitizers were created with lots of attention to performance,
> > attention on the level of the most performance critical production
> > code (sanitizer code is hotter than any production piece of code).
> > That's what made them so widely used. Think of interactive uses,
> > smaller devices, etc. Please let's keep this attitude.
>
> Yes, I agree that debugging tools used at a wide scale need to have
> more rigorous performance considerations.
>
> Do you think it is worth using the extra bytes to record more
> information? If this is a user-configurable feature.

If it's user-configurable, then it is OK.

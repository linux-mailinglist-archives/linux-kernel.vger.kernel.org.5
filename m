Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A799D7DB77C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjJ3KKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjJ3KKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:10:40 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C56E8A66
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:10:37 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40837124e1cso78665e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698660635; x=1699265435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3zgy30RJ+D4CBrJvlTQXpMKazTmgNjyYtW3+p1yMKE=;
        b=Mx/PaUNMRmlfqDjDUNvdUQmNdt6jM1HQ7yGtMjlYgLt4kdRZ7+w/0fr2OwHNqNhDgp
         bso7BmyVjjBWwQSWoBBsiRojD6Aa1USWB20MHk2/hW8p2IA+IhVmL73gi0ALLCupuUN5
         UXpWg8yXl66WvI4ZpI5oCNSEixTqD1zUwRFyWWwuhTYl0L95SqgXAhN2J0EHk6THQrHi
         +nAxxiWeicBOYWET1LsFjvLR75m/msUOMr9O0MYfe/C6MGnAmMtvJdhTCAGtdDRMsF9q
         lDEZ07AVmuEE/YmRMxcdQbOFdWM8ZacyZ1hT9QLw9d7a6OA+CcrcE6lSx3Uo4SW6yTvI
         0Kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698660635; x=1699265435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3zgy30RJ+D4CBrJvlTQXpMKazTmgNjyYtW3+p1yMKE=;
        b=BZSrerERb51BepanCcmN24CQr6G7/Q0ekFP3wRjdVKCJdrIiQ6IIEOFp/tx0oWCfRX
         ptgmI+ag0bOYP0sV4CQyO7N9sEFwmH+40lAEYq7T28S05yKmdrtMVIHgKlFolb76Ex+q
         gQmRqt4K2SJ47C2NVUWQbkbZCECUHT8ADBFy1JU/Aq6FXvC2JCB9GZG88firZ45Y+aMj
         s3wW2Dn3IrrK1R1NqCVDHcxsdwe00Oon0qCGJ6H09TnFIig2IGiX/ZvUfWHi0hlD0m85
         NzZbj49xSihLJiZx8xvoW9ya5P1ImH7Iwh6IYIfPG0RcX1qr20q2DRPOAm69Bw5jomcJ
         kzXA==
X-Gm-Message-State: AOJu0YxMyxPTMvZWnuaoTrkgLvmgPOyB3a3Qr0oveqYYAvAZvJAyid9r
        RmORvAIj7Y5TgPeI8nzRbcSfbXtuTTGsLj4c91pTHXqtxYwclOAMKtc0Cw==
X-Google-Smtp-Source: AGHT+IEx18gywoxoTCuRJl1RZx7vKGVb7LBy12SquWLHYEomOx12+8+oFG8e5WT78snujNUoacBz1xrMag4bb2IlSZE=
X-Received: by 2002:a05:600c:1d17:b0:400:c6de:6a20 with SMTP id
 l23-20020a05600c1d1700b00400c6de6a20mr92585wms.3.1698660635350; Mon, 30 Oct
 2023 03:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <VI1P193MB075256E076A09E5B2EF7A16F99D6A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <CA+fCnZfn0RnnhifNxctrUaLEptE=z9L=e3BY_8tRH2UXZWAO6Q@mail.gmail.com>
 <VI1P193MB07524EFBE97632D575A91EDB99A2A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <CACT4Y+a+xfzXBgqVz3Gxv4Ri1CqHTV1m=i=h4j5KWxsmdP+t5A@mail.gmail.com> <VI1P193MB075221DDE87BE09A4E7CBB1A99A1A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
In-Reply-To: <VI1P193MB075221DDE87BE09A4E7CBB1A99A1A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 30 Oct 2023 11:10:22 +0100
Message-ID: <CACT4Y+bxMKEVUhu-RDvOMcbah=iYCWdXFZDU0JN3D7OP26Q_Dw@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 at 10:28, Juntong Deng <juntong.deng@outlook.com> wrote=
:
>
> On 2023/10/30 14:29, Dmitry Vyukov wrote:
> > On Sun, 29 Oct 2023 at 10:05, Juntong Deng <juntong.deng@outlook.com> w=
rote:
> >>
> >> On 2023/10/26 3:22, Andrey Konovalov wrote:
> >>> On Tue, Oct 17, 2023 at 9:40=E2=80=AFPM Juntong Deng <juntong.deng@ou=
tlook.com> wrote:
> >>>>
> >>>> The idea came from the bug I was fixing recently,
> >>>> 'KASAN: slab-use-after-free Read in tls_encrypt_done'.
> >>>>
> >>>> This bug is caused by subtle race condition, where the data structur=
e
> >>>> is freed early on another CPU, resulting in use-after-free.
> >>>>
> >>>> Like this bug, some of the use-after-free bugs are caused by race
> >>>> condition, but it is not easy to quickly conclude that the cause of =
the
> >>>> use-after-free is race condition if only looking at the stack trace.
> >>>>
> >>>> I did not think this use-after-free was caused by race condition at =
the
> >>>> beginning, it took me some time to read the source code carefully an=
d
> >>>> think about it to determine that it was caused by race condition.
> >>>>
> >>>> By adding timestamps for Allocation, Free, and Error to the KASAN
> >>>> report, it will be much easier to determine if use-after-free is
> >>>> caused by race condition.
> >>>
> >>> An alternative would be to add the CPU number to the alloc/free stack
> >>> traces. Something like:
> >>>
> >>> Allocated by task 42 on CPU 2:
> >>> (stack trace)
> >>>
> >>> The bad access stack trace already prints the CPU number.
> >>
> >> Yes, that is a great idea and the CPU number would help a lot.
> >>
> >> But I think the CPU number cannot completely replace the free timestam=
p,
> >> because some freeing really should be done at another CPU.
> >>
> >> We need the free timestamp to help us distinguish whether it was freed
> >> a long time ago or whether it was caused to be freed during the
> >> current operation.
> >>
> >> I think both the CPU number and the timestamp should be displayed, mor=
e
> >> information would help us find the real cause of the error faster.
> >>
> >> Should I implement these features?
> >
> > Hi Juntong,
> >
> > There is also an aspect of memory consumption. KASAN headers increase
> > the size of every heap object. So we tried to keep them as compact as
> > possible. At some point CPU numbers and timestamps (IIRC) were already
> > part of the header, but we removed them to shrink the header to 16
> > bytes.
> > PID gives a good approximation of potential races. I usually look at
> > PIDs to understand if it's a "plain old single-threaded
> > use-after-free", or free and access happened in different threads.
> > Re timestamps, I see you referenced a syzbot report. With syzkaller
> > most timestamps will be very close even for non-racing case.
> > So if this is added, this should be added at least under a separate con=
fig.
> >
> > If you are looking for potential KASAN improvements, here is a good lis=
t:
> > https://bugzilla.kernel.org/buglist.cgi?bug_status=3D__open__&component=
=3DSanitizers&list_id=3D1134168&product=3DMemory%20Management
>
> Hi Dmitry,
>
> I think PID cannot completely replace timestamp for reason similar to
> CPU number, some frees really should be done in another thread, but it
> is difficult for us to distinguish if it is a free that was done some
> time ago, or under subtle race conditions.

I agree it's not a complete replacement, it just does not consume
additional memory.

> As to whether most of the timestamps will be very close even for
> non-racing case, this I am not sure, because I do not have
> enough samples.
>
> I agree that these features should be in a separate config and
> the user should be free to choose whether to enable them or not.
>
> We can divide KASAN into normal mode and depth mode. Normal mode
> records only minimal critical information, while depth mode records
> more potentially useful information.
>
> Also, honestly, I think a small amount of extra memory consumption
> should not stop us from recording more information.
>
> Because if someone enables KASAN for debugging, then memory consumption
> and performance are no longer his main concern.

There are a number of debugging tools created with the "performance
does not matter" attitude. They tend to be barely usable, not usable
in wide scale testing, not usable in canaries, etc.
All of sanitizers were created with lots of attention to performance,
attention on the level of the most performance critical production
code (sanitizer code is hotter than any production piece of code).
That's what made them so widely used. Think of interactive uses,
smaller devices, etc. Please let's keep this attitude.

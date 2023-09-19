Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD527A676A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjISO5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjISO5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:57:43 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE60BC;
        Tue, 19 Sep 2023 07:57:37 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d815a5eee40so5245792276.2;
        Tue, 19 Sep 2023 07:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695135456; x=1695740256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mIaJyUn8RI0FK5RTul2K30K/J4q1nZarbiEpq/gFEs=;
        b=mwNfggrNKm1prvFtB50FpKh6dZF10052gPlUlT48UhS2oAwF2wCVwT2eK6GhsrbIkZ
         rpnWun2cRKQgH0BQOhjccWypYvBtjYEOE4/XeERPSVGKcz4phamgq5o+UkndAeUcsF3K
         AnajZI6YOsz1qAmNb8jrpgwvY8sL/ZAIsPfrmnqOFxTQH+x5cVA4c0jOp9CjH361DGWj
         kl012Lebqu9o0mmBXYXmhSjruc4M9+MyzWhJ2Lad4AokFeRuttsgDAwlSN6R16fK6TaR
         F3W6buQqMsjZ9DuTfiQXNaX843241CXQz5l6xquL1Va0rOQkp0ny0+Sti7O0bgEBw5cW
         gf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695135456; x=1695740256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mIaJyUn8RI0FK5RTul2K30K/J4q1nZarbiEpq/gFEs=;
        b=EuoCACrCI5lNifWezOmX7pERPPjYSsVdDoQrreR7d5oh3uUUayTMcogRGXEkPS/FCl
         LkciVJDf1ROT1cZyc99S0SvX0xioRy9vrTvY2y5lkiazzAmws5cHdj8KQLX0qN/zkAXR
         DKgWTPAU7JWDcYeg+9U7+0VopKVhn6zTI/05zB2ZMwGFAj1J4kQVYTgSkTw9xbLx18M5
         n6PryVT1BWbMCd1U2hofdUiGpPB6vhgxUzRUq6tld1VMHy8o1e3TVnCEy5MNxTXGjp4c
         RM1lXF8mZ2LJVIc1h2B8ixZ9JZM2wLReiTMGBzc5aM0C0Mvk0QtCcpfTB7Y0xOLCA2r4
         Hjsg==
X-Gm-Message-State: AOJu0YwEs7qXJjuCkKtoWps07E5e0KQ2lVBtj/w0JHZr/bmrlcjC08Cz
        cIhnxtbarbB3Eanu1GYSdJ9zN0N/qkaLhiUE1C+lGOrglgmObw==
X-Google-Smtp-Source: AGHT+IGcBGsVxn25jswNs80R/yoKy6qzKyJOnTD3BOHxaRGMJ0JXIB34kFzqj6wy6lqaw/mBs9oZ3uCr7ZvPWzMti6E=
X-Received: by 2002:a25:76c9:0:b0:d12:ab1:d88a with SMTP id
 r192-20020a2576c9000000b00d120ab1d88amr12466931ybc.40.1695135456312; Tue, 19
 Sep 2023 07:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <87zg1u1h5t.fsf@oracle.com> <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net> <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net> <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx> <ZQmbhoQIINs8rLHp@casper.infradead.org>
 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
 <20230919134218.GA39281@noisy.programming.kicks-ass.net> <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
 <877comw8m7.ffs@tglx> <7EB81196-3A32-4638-A076-0C0CFF722996@zytor.com>
In-Reply-To: <7EB81196-3A32-4638-A076-0C0CFF722996@zytor.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Tue, 19 Sep 2023 10:57:24 -0400
Message-ID: <CAEdQ38H8QZvnwTMJ+-y56je7--Z2Ru-4kmPo7zcW3X8mxfXv1Q@mail.gmail.com>
Subject: Re: Arches that don't support PREEMPT
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de,
        rostedt@goodmis.org, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Brian Cain <bcain@quicinc.com>,
        linux-hexagon@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 10:51=E2=80=AFAM H. Peter Anvin <hpa@zytor.com> wro=
te:
>
> On September 19, 2023 7:17:04 AM PDT, Thomas Gleixner <tglx@linutronix.de=
> wrote:
> >On Tue, Sep 19 2023 at 15:48, John Paul Adrian Glaubitz wrote:
> >> On Tue, 2023-09-19 at 15:42 +0200, Peter Zijlstra wrote:
> >>> > The agreement to kill off ia64 wasn't an invitation to kill off oth=
er stuff
> >>> > that people are still working on! Can we please not do this?
> >>>
> >>> If you're working on one of them, then surely it's a simple matter of
> >>> working on adding CONFIG_PREEMPT support :-)
> >>
> >> As Geert poined out, I'm not seeing anything particular problematic wi=
th the
> >> architectures lacking CONFIG_PREEMPT at the moment. This seems to be m=
ore
> >> something about organizing KConfig files.
> >>
> >> I find it a bit unfair that maintainers of architectures that have hug=
e companies
> >> behind them use their manpower to urge less popular architectures for =
removal just
> >> because they don't have 150 people working on the port so they can kee=
p up with
> >> design changes quickly.
> >
> >I don't urge for removal. I just noticed that these four architectures
> >lack PREEMPT support. The only thing which is missing is the actual
> >preemption point in the return to kernel code path.
> >
> >But otherwise it should just work, which I obviously can't confirm :)
> >
> >Even without that preemption point it should build and boot. There might
> >be some minor latency issues when that preemption point is not there,
> >but adding it is not rocket science either. It's probably about 10 lines
> >of ASM code, if at all.
> >
> >Though not adding that might cause a blocking issue for the rework of
> >the whole preemption logic in order to remove the sprinkled around
> >cond_resched() muck or force us to maintain some nasty workaround just
> >for the benefit of a few stranglers.
> >
> >So I can make the same argument the other way around, that it's
> >unjustified that some architectures which are just supported for
> >nostalgia throw roadblocks into kernel developemnt.
> >
> >If my ALPHA foo wouldn't be very close to zero, I'd write that ASM hack
> >myself, but that's going to cost more of my and your time than it's
> >worth the trouble,
> >
> >Hmm. I could delegate that to Linus, he might still remember :)
> >
> >Thanks,
> >
> >        tglx
>
> Does *anyone* actually run Alpha at this point?

I do, as part of maintaining the Gentoo distribution for Alpha.

I'm listed in MAINTAINERS, but really only so I can collect patches
send them to Linus after testing. I don't have copious amounts of free
time to be proactive in kernel development and it's also not really my
area of expertise so I'm nowhere near effective at it.

I would be happy to test any patches sent my way (but I acknowledge
that writing these patches wouldn't be high on anyone's priority list,
etc)

(A video my friend Ian and I made about a particularly large
AlphaServer I have in my basement, in case anyone is interested:
https://www.youtube.com/watch?v=3Dz658a8Js5qg)

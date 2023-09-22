Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B030F7ABA56
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 22:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjIVUDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 16:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjIVUDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 16:03:14 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A517219B;
        Fri, 22 Sep 2023 13:03:08 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-59f4f80d084so2106817b3.1;
        Fri, 22 Sep 2023 13:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695412988; x=1696017788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQxVwDWGzICCtzIyR/1ybOxtmRno79pEfOcqjcENqi8=;
        b=k92Na7MQzZl3UDgIoik+tSsBfP/ktc3ogoXB3qSJrn0sDk6MXRExsumh4Pa346ZUP8
         ZYOtGosibwfRw2yZHNX8oq3hj0heIV59XVgZg2u7FI4xFF8Jdpo912+nm6SgkxYN7+Ir
         EzCcozDuGMVHYax1s3W/EMXKGnJl/GI3lUFt4YVlfotlIbTB5vP+9ftFNOVbBRBArq3u
         3frbYxj3gXaVDQsKzAvLHS5GQzcSkORZzglPy9hrSJ0aBQS4SY2NQt5rWQRID/Xzlcup
         9x2qTmMoGcN6z6Jd3ImptClkjQVstlaej+eJje+vSOoX5AiCAN+bYwXif98Jabyz+kPm
         KeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695412988; x=1696017788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQxVwDWGzICCtzIyR/1ybOxtmRno79pEfOcqjcENqi8=;
        b=NJ0o4grIzogD5CpKVo+kb5+f4MFGBkAcZ33+FO0uXlwFTZaOxAmQ7l7FN2dqgTd5FG
         51Aj5uD9uYU3m9YxgAuTwmitPiWX2MZ6LT3Q10u1n2j8xC3meN0hAoZxMT09+jxmbgu6
         Asi7LSCbAdqDodmWdv2nAqH3tygEK37bGA6FFZVYRywVZFdMuJeLwdddz87YlXf8Bb6l
         atHVk3HMbBbAdsw21M36AnodRpIYQxQ6/Qo6Id4YAiFEaW7hWZwGlDcw41folHKu7Oz8
         zk0fb2ePrZb+UqT+D9kQp9rnjZLwML9Og/+bmKFbVqoJrkonGl0mTeDaktIBrsXrOQ/4
         Gupg==
X-Gm-Message-State: AOJu0YyyHvnhn8/6IyYJWOID9m0QLlorq1Ob3/NeQZofTLFt4Sj1avUO
        8nhnr7lzp3p3HjTEFx2FVp10RLCJaat4o8id4dg=
X-Google-Smtp-Source: AGHT+IHzt5WM9Wp1e/5x78GHrBbk1G/TM58GZnAzfq+tYJUVDOOcij3HKdxqrFvyenoQ7+gvZQKYkFdiTKLyTMB0BHs=
X-Received: by 2002:a81:5205:0:b0:59b:69cf:72c0 with SMTP id
 g5-20020a815205000000b0059b69cf72c0mr772796ywb.6.1695412987630; Fri, 22 Sep
 2023 13:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230922111247.497-1-ansuelsmth@gmail.com> <20230922111247.497-3-ansuelsmth@gmail.com>
 <13bc074d-30c2-4bbf-8b4c-82f561c844b0@lunn.ch> <650d8af4.5d0a0220.5ce38.2c5e@mx.google.com>
In-Reply-To: <650d8af4.5d0a0220.5ce38.2c5e@mx.google.com>
From:   Dave Taht <dave.taht@gmail.com>
Date:   Fri, 22 Sep 2023 13:02:55 -0700
Message-ID: <CAA93jw5fXb2d6xqBud3jxO5eQhg0eykOM80p28t7c9gA5AneUw@mail.gmail.com>
Subject: Re: [net-next PATCH 3/3] net: stmmac: increase TX coalesce timer to 5ms
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Simon Horman <horms@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Pirko <jiri@resnulli.us>,
        Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        dave seddon <dave.seddon.ca@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 5:39=E2=80=AFAM Christian Marangi <ansuelsmth@gmail=
.com> wrote:
>
> On Fri, Sep 22, 2023 at 02:28:06PM +0200, Andrew Lunn wrote:
> > On Fri, Sep 22, 2023 at 01:12:47PM +0200, Christian Marangi wrote:
> > > Commit 8fce33317023 ("net: stmmac: Rework coalesce timer and fix
> > > multi-queue races") decreased the TX coalesce timer from 40ms to 1ms.
> > >
> > > This caused some performance regression on some target (regression wa=
s
> > > reported at least on ipq806x) in the order of 600mbps dropping from
> > > gigabit handling to only 200mbps.
> > >
> > > The problem was identified in the TX timer getting armed too much tim=
e.
> > > While this was fixed and improved in another commit, performance can =
be
> > > improved even further by increasing the timer delay a bit moving from
> > > 1ms to 5ms.

I am always looking for finding ways to improve interrupt service
time, rather than paper over the problem by increasing batchi-ness.

http://www.taht.net/~d/broadcom_aug9_2018.pdf

But also looking for hard data, particularly as to observed power
savings. How much power does upping this number save?

I have tried to question other assumptions more modern kernels are
making, in particular I wish more folk would experience with
decreasing the overlarge (IMHO) NAPI default of 64 packets to, say 8
in the mq case, benefiting from multiple arm cores still equipped with
limited cache, as well as looking at the impact of TLB flushes. Other
deferred multi-core processing... that is looking good on a modern
xeon, but might not be so good on a more limited arm, worries me.

Over here there was an enormous test series recently run against a
bunch of older arm64s which appears to indicate that memory bandwidth
is a source of problems:

https://docs.google.com/document/d/1HxIU_TEBI6xG9jRHlr8rzyyxFEN43zMcJXUFlRu=
hiUI/edit

We are looking to add more devices to that testbed.

> > >
> > > The value is a good balance between battery saving by prevending too
> > > much interrupt to be generated and permitting good performance for
> > > internet oriented devices.
> >
> > ethtool has a settings you can use for this:
> >
> >       ethtool -C|--coalesce devname [adaptive-rx on|off] [adaptive-tx o=
n|off]
> >               [rx-usecs N] [rx-frames N] [rx-usecs-irq N] [rx-frames-ir=
q N]
> >               [tx-usecs N] [tx-frames N] [tx-usecs-irq N] [tx-frames-ir=
q N]
> >               [stats-block-usecs N] [pkt-rate-low N] [rx-usecs-low N]
> >               [rx-frames-low N] [tx-usecs-low N] [tx-frames-low N]
> >               [pkt-rate-high N] [rx-usecs-high N] [rx-frames-high N]
> >               [tx-usecs-high N] [tx-frames-high N] [sample-interval N]
> >               [cqe-mode-rx on|off] [cqe-mode-tx on|off] [tx-aggr-max-by=
tes N]
> >               [tx-aggr-max-frames N] [tx-aggr-time-usecs N]
> >
> > If this is not implemented, i suggest you add support for it.
> >
> > Changing the default might cause regressions. Say there is a VoIP
> > application which wants this low latency? It would be safer to allow
> > user space to configure it as wanted.
> >
>
> Yep stmmac already support it. Idea here was to not fallback to use
> ethtool and find a good value.
>
> Just for reference before one commit, the value was set to 40ms and
> nobody ever pointed out regression about VoIP application. Wtih some
> testing I found 5ms a small increase that restore original perf and
> should not cause any regression.

Does this driver have BQL?

> (for reference keeping this to 1ms cause a lost of about 100-200mbps)
> (also the tx timer implementation was created before any napi poll logic
> and before dma interrupt handling was a thing, with the later change I
> expect this timer to be very little used in VoIP scenario or similar
> with continuous traffic as napi will take care of handling packet)

I would be pretty interested in a kernel flame graph of the before vs the a=
fter.

> Aside from these reason I totally get the concern and totally ok with
> this not getting applied, was just an idea to push for a common value.

I try to get people to run much longer and more complicated tests such
as the flent rrul test to see what kind of damage bigger buffers did
to latency, as well as how other problems might show up. Really
notable in the above test series was how badly various devices behaved
over time on that workload. Extremely notable in that test series
above was how badly the  jetson performed:

https://github.com/randomizedcoder/cake/blob/2023_09_02/pfifo_fast/jetson.p=
ng

And the nanopi was weird.

https://github.com/randomizedcoder/cake/blob/2023_09_02/pfifo_fast/nanopi-n=
eo3.png

> Just preferred to handle this here instead of script+userspace :(
> (the important part is the previous patch)
>
> --
>         Ansuel
>
--
Oct 30: https://netdevconf.info/0x17/news/the-maestro-and-the-music-bof.htm=
l
Dave T=C3=A4ht CSO, LibreQos

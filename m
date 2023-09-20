Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9277A7431
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbjITHcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbjITHcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:32:50 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7F7DD;
        Wed, 20 Sep 2023 00:32:43 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-401ec23be82so69882075e9.0;
        Wed, 20 Sep 2023 00:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695195162; x=1695799962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jWzgC+PpnfmZJpwJToZon+LX7cLfjuMVcroIeSc6zGs=;
        b=eHwbfk3T4K7FfIw/icgd0CVcXFEsLzlRgIqN0uUreBD9KJU7AFka1mgjM/mGzOSmEa
         /pSlhklTcaMYzcJRHYxZxw9n0uAV8lqQIQSETCaPhGjb/bi18Wsj2cZUjcs2/64WcenQ
         0rm48tz/qdo17WBeL5JWFBlZb2kaWovHcTBDilZqp8taMdcNS6UQOJFqYyPSkuccRKso
         XQEBu4Bj7LXMfUtwjmeAiMqqqKmEAtJtB1YsGxw/i4OTXQACG/OcPQtBQCgPIkwHezJk
         ge/S7RXs1GnhABwc0AnTmR+Tb7FO8fnyDjSYlYLSALClG0bjiighlYKrnFsBPHUApNZE
         BQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695195162; x=1695799962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWzgC+PpnfmZJpwJToZon+LX7cLfjuMVcroIeSc6zGs=;
        b=VEi0Lv8OVYKn/Sog59YBgE340a9tntq37upaVOHJdtTh/Un0+nRfiKgLgctXRTjeba
         ISpO5vh/z+lJQckU9Mdi/jCaLCb8ypSxMvT2Oxe/SxcPqnt48dB2rGhFj3v9KKKLKjJV
         qctcGaZj+YwvTUIIDI9HdvGFEGDxPDWItQRsNupH71qYzEvGDHOZLBMxhf3MV61B1bdT
         6iEpOEogy1/J5vu+P8nUv6UwMaGr5S2GUpcBIm7Mijs4lO4hUtT4tfJUh/oY3pi36s4z
         Cqeiv7vaQ/Uby8xu7K8rZHi1wzDt6jtfD6gmQZHtdETxSPzIAEZbXNsQ/PNj2l0R9ckO
         cBFQ==
X-Gm-Message-State: AOJu0Yw8X5S0nAYgkU4JWGSCSO1WoMPqitzwatnkqBxJqRnE+Nr47zky
        9bJfkBO3Ix/zROntvKjztpg=
X-Google-Smtp-Source: AGHT+IFlh1qPrteRsulMqGbbOgPwlxP6U162lurEOGcRJRUAWbbb9DGlfVvYxyhGzmU9ONgAgb+Ukw==
X-Received: by 2002:a7b:cbc5:0:b0:3fd:30f7:2be1 with SMTP id n5-20020a7bcbc5000000b003fd30f72be1mr1579415wmi.39.1695195161611;
        Wed, 20 Sep 2023 00:32:41 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id h4-20020a05600c350400b00402f713c56esm1165817wmq.2.2023.09.20.00.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 00:32:41 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 20 Sep 2023 09:32:38 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Brian Cain <bcain@quicinc.com>,
        linux-hexagon@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: Re: Arches that don't support PREEMPT
Message-ID: <ZQqgFpA6l1eK1KKV@gmail.com>
References: <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx>
 <ZQmbhoQIINs8rLHp@casper.infradead.org>
 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
 <20230919134218.GA39281@noisy.programming.kicks-ass.net>
 <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
 <CAHk-=wgUimqtF7PqFfRw4Ju5H1KYkp6+8F=hBz7amGQ8GaGKkA@mail.gmail.com>
 <87pm2eui95.ffs@tglx>
 <20230919143816.1741760a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919143816.1741760a@gandalf.local.home>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 19 Sep 2023 20:31:50 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > The removal of cond_resched() might cause latencies, but then I doubt
> > that these museus pieces are used for real work :)
> 
> We could simply leave the cond_resched() around but defined as nops for
> everything but the "nostalgia club" to keep them from having any regressions.

That's not a good idea IMO, it's an invitation for accelerated rate bitrot 
turning cond_resched() meaningless very quickly.

We should remove cond_resched() - but probably not as the first step. They 
are conceptually independent of NEED_RESCHED_LAZY and we don't *have to* 
remove them straight away.

By removing cond_resched() separately there's an easily bisectable point to 
blame for any longer latencies on legacy platforms, should any of them 
still be used with recent kernels.

Thanks,

	Ingo

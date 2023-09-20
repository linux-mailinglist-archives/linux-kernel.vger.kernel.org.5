Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666A07A7417
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbjITH3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbjITH3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:29:33 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFC6CA;
        Wed, 20 Sep 2023 00:29:27 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4051f8e1ba0so6818335e9.1;
        Wed, 20 Sep 2023 00:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695194965; x=1695799765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9FUmFWGdaoCCAX+yBYd9oidTjhPdRU5Hczc1k2R6GM=;
        b=lYBYsrmhPNW96ohxoysYDSqqE8OzwYp7oyFXge92IlJPIpKW1IObFR39gYATLEJLJX
         Th+IT73wJWAjUv7ZbGdbbmmq1qASbBQP4S0asJhUxSb6LdP6ON7nEZkvBiKWb27/lG7m
         t9cZg24pxlXfeKgxTykpJQjKV/Rl+lBB65wf3/JryRaymRpOEUYdjy8OXfNdH16HP0qX
         k4aJg8gca3ZgCWzqlGeSqqKa/z9MXHYn/WZpQtG3n1jr1A1xPuMsDehMohuYm8/xtbk/
         o8jvN32SvCd1BN72fs5a4hTfqkZQU1bi1nW1+k+eH22Wb4Z0s2goyEQUVsfvB2WN7z+Y
         QzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695194965; x=1695799765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9FUmFWGdaoCCAX+yBYd9oidTjhPdRU5Hczc1k2R6GM=;
        b=dMX0q9lIYcSPT0dtXJqetoLai4WuDbq0vRe9Coray2HkyIEp9ZhB6b3lVKcsuNmGJ8
         g7ECBzrnAUbWiO4okQyNuivWqyMGgc+aA7pgCQs7TK81eeDg2NCn8QhqUexVn9g+wQqm
         8rWdahTul9j0BauvDkf6STwZI6scW0MJgIwQhY6BVRR4kQxBv3VjrsY3bqjuQeksqb5Z
         +BX/lPeLrWGgo6x6S911d+D3JYPfCvgSg0TDRS8tXpFZAgN5P/ozd9Yr3czvdIDXz7o3
         2EA7WqFPQQXf3f/+LJOaA052oU1g1MPUPTfuZelbRgpHrmxhwWjeqX8nKRXDPD2Lceyb
         tuNw==
X-Gm-Message-State: AOJu0YzN1yQve/wCFuNN/Ct5eDlZBhsrPI5Dh2aiP5TpTRh3fdKT3skZ
        mRjD5hgPLUSPLXBnAZ9Y1jw=
X-Google-Smtp-Source: AGHT+IEpVnT/Cd2oEohbdKSMFoVqTb9dtDqJrcJ42h6au+YxgKEXvw3MWUudbGLbWXtUB4DWJ+z6pA==
X-Received: by 2002:a05:600c:152:b0:404:2dbb:8943 with SMTP id w18-20020a05600c015200b004042dbb8943mr1805727wmm.2.1695194965229;
        Wed, 20 Sep 2023 00:29:25 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id t19-20020a7bc3d3000000b003fefca26c72sm1136535wmj.23.2023.09.20.00.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 00:29:24 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 20 Sep 2023 09:29:21 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de,
        rostedt@goodmis.org, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com,
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
Message-ID: <ZQqfURDGaXQdTzZS@gmail.com>
References: <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx>
 <ZQmbhoQIINs8rLHp@casper.infradead.org>
 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
 <20230919134218.GA39281@noisy.programming.kicks-ass.net>
 <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
 <CAHk-=wgUimqtF7PqFfRw4Ju5H1KYkp6+8F=hBz7amGQ8GaGKkA@mail.gmail.com>
 <87pm2eui95.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pm2eui95.ffs@tglx>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Tue, Sep 19 2023 at 10:25, Linus Torvalds wrote:
> > On Tue, 19 Sept 2023 at 06:48, John Paul Adrian Glaubitz
> > <glaubitz@physik.fu-berlin.de> wrote:
> >>
> >> As Geert poined out, I'm not seeing anything particular problematic with the
> >> architectures lacking CONFIG_PREEMPT at the moment. This seems to be more
> >> something about organizing KConfig files.
> >
> > It can definitely be problematic.
> >
> > Not the Kconfig file part, and not the preempt count part itself.
> >
> > But the fact that it has never been used and tested means that there
> > might be tons of "this architecture code knows it's not preemptible,
> > because this architecture doesn't support preemption".
> >
> > So you may have basic architecture code that simply doesn't have the
> > "preempt_disable()/enable()" pairs that it needs.
> >
> > PeterZ mentioned the generic entry code, which does this for the entry
> > path. But it actually goes much deeper: just do a
> >
> >     git grep preempt_disable arch/x86/kernel
> >
> > and then do the same for some other architectures.
> >
> > Looking at alpha, for example, there *are* hits for it, so at least
> > some of the code there clearly *tries* to do it. But does it cover all
> > the required parts? If it's never been tested, I'd be surprised if
> > it's all just ready to go.
> >
> > I do think we'd need to basically continue to support ARCH_NO_PREEMPT
> > - and such architectures migth end up with the worst-cast latencies of
> > only scheduling at return to user space.
> 
> The only thing these architectures should gain is the preempt counter 
> itself, [...]

And if any of these machines are still used, there's the small benefit of 
preempt_count increasing debuggability of scheduling in supposedly 
preempt-off sections that were ignored silently previously, as most of 
these architectures do not even enable CONFIG_DEBUG_ATOMIC_SLEEP=y in their 
defconfigs:

  $ for ARCH in alpha hexagon m68k um; do git grep DEBUG_ATOMIC_SLEEP arch/$ARCH; done
  $

Plus the efficiency of CONFIG_DEBUG_ATOMIC_SLEEP=y is much reduced on 
non-PREEMPT kernels to begin with: it will basically only detect scheduling 
in hardirqs-off critical sections.

So IMHO there's a distinct debuggability & robustness plus in enabling the 
preemption count on all architectures, even if they don't or cannot use the 
rescheduling points.

> [...] but yes the extra preemption points are not mandatory to have, i.e. 
> we simply do not enable them for the nostalgia club.
> 
> The removal of cond_resched() might cause latencies, but then I doubt 
> that these museus pieces are used for real work :)

I'm not sure we should initially remove *explicit* legacy cond_resched() 
points, except from high-freq paths where they hurt - and of course remove 
them from might_sleep().

Thanks,

	Ingo

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E7A75FB48
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjGXP4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGXP4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:56:21 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD13187
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 08:56:20 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-993a37b79e2so729150766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 08:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690214178; x=1690818978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqJrERUDo+zp/o5kHkQ6aMOqQKKqLEOmzFVk7PKhL/I=;
        b=JdG4Xr7VqlTXKGF8SSI6DyfjkU4GYVHVVgHHIAcG8So1/im/pm0YxYokFrMbsgmwB+
         nt5DZ6HvPlimfjhV7cS26UwBr/d9Jogp7N7Aj2d7hApdYKziTwU1WPbWvdOfj1obdI57
         R6mEp+LXChBtdUmLN8VdSN9SvyqpD+M9U9X+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690214178; x=1690818978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqJrERUDo+zp/o5kHkQ6aMOqQKKqLEOmzFVk7PKhL/I=;
        b=HD+6xZN3+pXZI9ev1V0Z3JIYIgMxJ0g8jFO6AWtJXNBZMmbyJOcKWtMyk7/qkSDbYg
         SR1CfGa/cYkJG55dwpg2YYTS9Vojf3rQ3GqKscvE2XcKBHCRtshCHanQrhuFjMi4x2C0
         P4EhIOACaQkbTdgqcdS4xyHMb8NVY//zLr9mTRjXJ8zN0tt1J950QzFllvKVuR4JS6am
         czp3GUMxu816M4tcUJ4Z+ZaOZn4i/9fBrszHqBGCimketbzKnIbDSdjvRsoAQaVKMG+X
         lgN+uZdh91rTN8XW70H+a4yIA5927pkUFGqYRg0aH6pl/P2h6lNFIY5TMXvgql0dPxs1
         iVew==
X-Gm-Message-State: ABy/qLbYKuFGvgV3WGpADMXcNxnkfgD8XFjkGtHApz0OSy3EHJYItTaB
        w8mDqvwbNR86HRLbcwjyb/NTIB2L4MSmWQHUgJY1TR/I
X-Google-Smtp-Source: APBJJlFKLCoXeETaEp60gZ4Co2+adNWSdy+wLsNe2S/7leHPZ4mwxYTuTiC0WwDMVb5rORAxbsLDjQ==
X-Received: by 2002:a17:906:53d0:b0:970:1b2d:45cc with SMTP id p16-20020a17090653d000b009701b2d45ccmr9985178ejo.57.1690214178072;
        Mon, 24 Jul 2023 08:56:18 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id qn15-20020a170907210f00b009892cca8ae3sm6897452ejb.165.2023.07.24.08.56.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 08:56:17 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3fbb07e7155so125715e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 08:56:17 -0700 (PDT)
X-Received: by 2002:a50:f68e:0:b0:522:3ead:377 with SMTP id
 d14-20020a50f68e000000b005223ead0377mr33590edn.7.1690214156878; Mon, 24 Jul
 2023 08:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230601213440.2488667-1-dianders@chromium.org>
In-Reply-To: <20230601213440.2488667-1-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Jul 2023 08:55:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V2fFqwg3f3KS29+AkggHFDbyYvfAb12DrDn_PF8+bJjA@mail.gmail.com>
Message-ID: <CAD=FV=V2fFqwg3f3KS29+AkggHFDbyYvfAb12DrDn_PF8+bJjA@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] arm64: Add debug IPI for backtraces / kgdb; try to
 use NMI for it
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com,
        Chen-Yu Tsai <wens@csie.org>, Ard Biesheuvel <ardb@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        kgdb-bugreport@lists.sourceforge.net,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Wei Li <liwei391@huawei.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

On Thu, Jun 1, 2023 at 2:37=E2=80=AFPM Douglas Anderson <dianders@chromium.=
org> wrote:
>
> This is an attempt to resurrect Sumit's old patch series [1] that
> allowed us to use the arm64 pseudo-NMI to get backtraces of CPUs and
> also to round up CPUs in kdb/kgdb. The last post from Sumit that I
> could find was v7, so I started my series at v8. I haven't copied all
> of his old changelongs here, but you can find them from the link.
>
> I'm really looking for a way to land this patch series. In response to
> v8, Mark Rutland indicated [2] that he was worried about the soundness
> of pseudo NMI. Those definitely need to get fixed, but IMO this patch
> series could still land in the meantime. That would at least let
> people test with it.
>
> Request for anyone reading this: please help indicate your support of
> this patch series landing by replying, even if you don't have the
> background for a full review. My suspicion is that there are a lot of
> people who agree that this would be super useful to get landed.
>
> Since v8, I have cleaned up this patch series by integrating the 10th
> patch from v8 [3] into the whole series. As part of this, I renamed
> the "NMI IPI" to the "debug IPI" since it could now be backed by a
> regular IPI in the case that pseudo NMIs weren't available. With the
> fallback, this allowed me to drop some extra patches from the
> series. This feels (to me) to be pretty clean and hopefully others
> agree. Any patch I touched significantly I removed Masayoshi and
> Chen-Yu's tags from.
>
> ...also in v8, I reorderd the patches a bit in a way that seemed a
> little cleaner to me.
>
> Since v7, I have:
> * Addressed the small amount of feedback that was there for v7.
> * Rebased.
> * Added a new patch that prevents us from spamming the logs with idle
>   tasks.
> * Added an extra patch to gracefully fall back to regular IPIs if
>   pseudo-NMIs aren't there.
>
> It can be noted that this patch series works very well with the recent
> "hardlockup" patches that have landed through Andrew Morton's tree and
> are currently in linuxnext. It works especially well with the "buddy"
> lockup detector.
>
> [1] https://lore.kernel.org/linux-arm-kernel/1604317487-14543-1-git-send-=
email-sumit.garg@linaro.org/
> [2] https://lore.kernel.org/lkml/ZFvGqD%2F%2Fpm%2FlZb+p@FVFF77S0Q05N.camb=
ridge.arm.com/
> [3] https://lore.kernel.org/r/20230419155341.v8.10.Ic3659997d6243139d0522=
fc3afcdfd88d7a5f030@changeid/
>
> Changes in v9:
> - Add a warning if we don't have enough IPIs for the NMI IPI
> - Added comments that we might not be using NMI always.
> - Added missing "inline"
> - Added to commit message that this doesn't catch all cases.
> - Fold in v8 patch #10 ("Fallback to a regular IPI if NMI isn't enabled")
> - Moved header file out of "include" since it didn't need to be there.
> - Remove arm64_supports_nmi()
> - Remove fallback for when debug IPI isn't available.
> - Renamed "NMI IPI" to "debug IPI" since it might not be backed by NMI.
> - Update commit description
> - arch_trigger_cpumask_backtrace() no longer returns bool
>
> Changes in v8:
> - "Provide a stub kgdb_nmicallback() if !CONFIG_KGDB" new for v8
> - "Tag the arm64 idle functions as __cpuidle" new for v8
> - Removed "#ifdef CONFIG_SMP" since arm64 is always SMP
> - debug_ipi_setup() and debug_ipi_teardown() no longer take cpu param
>
> Douglas Anderson (2):
>   arm64: idle: Tag the arm64 idle functions as __cpuidle
>   kgdb: Provide a stub kgdb_nmicallback() if !CONFIG_KGDB
>
> Sumit Garg (5):
>   irqchip/gic-v3: Enable support for SGIs to act as NMIs
>   arm64: Add framework for a debug IPI
>   arm64: smp: Assign and setup the debug IPI
>   arm64: ipi_debug: Add support for backtrace using the debug IPI
>   arm64: kgdb: Roundup cpus using the debug IPI
>
>  arch/arm64/include/asm/irq.h  |   3 +
>  arch/arm64/kernel/Makefile    |   2 +-
>  arch/arm64/kernel/idle.c      |   4 +-
>  arch/arm64/kernel/ipi_debug.c | 102 ++++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/ipi_debug.h |  13 +++++
>  arch/arm64/kernel/kgdb.c      |  14 +++++
>  arch/arm64/kernel/smp.c       |  11 ++++
>  drivers/irqchip/irq-gic-v3.c  |  29 +++++++---
>  include/linux/kgdb.h          |   1 +
>  9 files changed, 168 insertions(+), 11 deletions(-)

I'm looking for some ideas on what to do to move this patch series
forward. Thanks to Daniel, the kgdb patch is now in Linus's tree which
hopefully makes this simpler to land. I guess there is still the
irqchip dependency that will need to be sorted out, though...

Even if folks aren't in agreement about whether this is ready to be
enabled in production, I don't think anything here is super
objectionable or controversial, is it? Can we land it? If you feel
like it needs extra review, would it help if I tried to drum up some
extra people to provide review feedback?

Also: in case it's interesting to anyone, I've been doing benchmarks
on sc7180-trogdor devices in preparation for enabling this. On that
platform, I did manage to see about 4% reduction in a set of hackbench
numbers when fully enabling pseudo-NMI. However, when I instead ran
Speedometer 2.1 I saw no difference. See:

https://issuetracker.google.com/issues/197061987

-Doug

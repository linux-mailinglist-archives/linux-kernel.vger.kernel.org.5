Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603AE7724A6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjHGMrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjHGMrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:47:05 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701E3172D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:46:43 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-79aa01cc971so1671290241.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 05:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691412396; x=1692017196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9t5nBRjNzdkdc9QzeOluuR4xKMtvtID49kCNpeDzH2Y=;
        b=FwJjNe45kCbq5qXs+ry0Q1vC6w59/+Im+9Iw2Tvscb/IIQ6465g0P045SBWdXLPzfu
         yaOXI7hqamCPU3+JqHAHlSS0YR8n2hLDcFZsuRBYGWZ1hyYrkRwaaknrdd1Eo359Wd6V
         QZSWH6AgC8J/18tkRHRkXXwmUvJb7B0LUjdyUwabFXwkWlTS/nihJu6LO6LbsA+hxij1
         xxXoF11NXguL33AeDKFUig6UTUosMmFCJgeN+8JsIDHFUuftJTlebpAjy8WeWwt/GoEt
         df1gb0u1BPJIWSG/F3il55Dy8PSlm4YXmVYH7vvixK95vYt1LpMbaMXPoZwdxjZNrJJM
         PzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691412396; x=1692017196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9t5nBRjNzdkdc9QzeOluuR4xKMtvtID49kCNpeDzH2Y=;
        b=Q6JnYlINDJdadXG63oroQkp4AKirctcsifS6qQf6JoV3OiFl2ZLGPKKfa+OaCC4ApF
         9zIT9+kYyJWgbqkAMgNQzv9El6eqV8B8iDZChEEHSfowntZLwM0SsR3t3s8S8bS90QyH
         F/PfoR8LFoVJe0CUVR44BkK7hHsLd8hoaG38AKN2etIzrrBzecXV/1F500+umDwusfn2
         p5nlIdnQO4Bzca1rYH5FmDQMMmyTpNqoTSMsMej/CMow4iwfynzZmSpbeWm7HwZMSCT1
         Ia3w5wB6m8lzKi8is8k8kMDpqFVqE1hf9mUdy9+6ojYh1stukgD3yMsap3/083upFrEI
         zHww==
X-Gm-Message-State: AOJu0YyoAcdhPz3mK8CJdTJhd4Z//b6g6YR3gzw3etXG8pl+YhSq6uFi
        wUvZFNuXckTCbvzfgUd8X/4ggnnGsI1VDgrGICyssQ==
X-Google-Smtp-Source: AGHT+IG2sQb4KYXITpRPT/2oajN8A3GYoBsP/KAHU7XnME8OTvWW3UQnsC7Bentk96hJ/VHFSMldrPbP1fvvCyVgaIE=
X-Received: by 2002:a67:f912:0:b0:446:da54:19b3 with SMTP id
 t18-20020a67f912000000b00446da5419b3mr4527404vsq.23.1691412395913; Mon, 07
 Aug 2023 05:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230601213440.2488667-1-dianders@chromium.org>
 <CAD=FV=V2fFqwg3f3KS29+AkggHFDbyYvfAb12DrDn_PF8+bJjA@mail.gmail.com> <ZNDKVP2m-iiZCz3v@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZNDKVP2m-iiZCz3v@FVFF77S0Q05N.cambridge.arm.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 7 Aug 2023 18:16:24 +0530
Message-ID: <CAFA6WYMD4TRR5psUyhu2jhZ2XBMUfav3D7_eH1HE8VJfXc7Fuw@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] arm64: Add debug IPI for backtraces / kgdb; try to
 use NMI for it
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Aug 2023 at 16:11, Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Doug,
>
> Apologies for the delay.
>
> On Mon, Jul 24, 2023 at 08:55:44AM -0700, Doug Anderson wrote:
> > On Thu, Jun 1, 2023 at 2:37=E2=80=AFPM Douglas Anderson <dianders@chrom=
ium.org> wrote:
> > I'm looking for some ideas on what to do to move this patch series
> > forward. Thanks to Daniel, the kgdb patch is now in Linus's tree which
> > hopefully makes this simpler to land. I guess there is still the
> > irqchip dependency that will need to be sorted out, though...
> >
> > Even if folks aren't in agreement about whether this is ready to be
> > enabled in production, I don't think anything here is super
> > objectionable or controversial, is it? Can we land it? If you feel
> > like it needs extra review, would it help if I tried to drum up some
> > extra people to provide review feedback?
>
> Ignoring the soundness issues I mentioned before (which I'm slowly chippi=
ng
> away at, and you're likely lucky enough to avoid in practice)...
>
> Having looked over the series, I think the GICv3 bit isn't quite right, b=
ut is
> easy enough to fix. I've commented on the patch with what I think we shou=
ld
> have there.

Thanks for catching this and I agree with your proposed fix.

>
> The only major thing otherwise from my PoV is the structure of the debug =
IPI
> framework. I'm not keen on that being a separate body of code and I think=
 it
> should live in smp.c along with the other IPIs.

That's a fair point.

> I'd also strongly prefer if we
> could have separate IPI_CPU_BACKTRACE and IPI_CPU_KGDB IPIs,

With current logic of single debug IPI, it is not required for a user
to enable KGDB in order to use that IPI for backtrace. The original
motivation for this logic was that the IPIs are a scarce resource on
arm64 as per comments from Marc. So I am fine either way to keep them
separate or unified.

> and I think we can
> do that either by unifying IPI_CPU_STOP && IPI_CPU_CRASH_STOP or by recla=
iming
> IPI_WAKEUP by reusing a different IPI for the parking protocol (e.g.
> IPI_RESCHEDULE).

That sounds like a good cleanup.

>
> I think it'd be nice if the series could enable NMIs for backtrace and th=
e
> CPU_{,CRASH_}STOP cases, with KGDB being the bonus atop. That way it'd be
> clearly beneficial for anyone trying to debug lockups even if they're not=
 a
> KGDB user.
>

It's good to see other use-cases of IPIs turned into NMIs.

-Sumit

> > Also: in case it's interesting to anyone, I've been doing benchmarks
> > on sc7180-trogdor devices in preparation for enabling this. On that
> > platform, I did manage to see about 4% reduction in a set of hackbench
> > numbers when fully enabling pseudo-NMI. However, when I instead ran
> > Speedometer 2.1 I saw no difference. See:
> >
> > https://issuetracker.google.com/issues/197061987
>
> Thanks for the pointer!
>
> I know that there are a couple of things that we could do to slightly imp=
rove
> local_irq_*() when using pNMIs, though I suspect that the bulk of the cos=
t
> there will come from the necessary synchronization.
>
> Thanks,
> Mark.

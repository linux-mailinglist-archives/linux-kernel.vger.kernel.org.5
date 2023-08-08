Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0601D773DA0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjHHQUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbjHHQSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:18:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432D910D4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:48:44 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a0c:5a83:9201:1300:c39b:5cf0:4d57:ce7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 29B4066071EE;
        Tue,  8 Aug 2023 10:55:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691488550;
        bh=YoAY9Fw/9c6MO4ZIunTXxK9WxUDg1XM2ZcHTlhXdURE=;
        h=From:To:Cc:Subject:References:In-reply-to:Date:From;
        b=mwdnbXehlEpzg7R2KR4tUl44XSUn7006sUv9sHuEGDqfG3qRAjZvk+tlu3f/jURb+
         cqToTLsYTT+W/3DTCDfSZNeibTZTZQx0RVqUW00H1oxd6XqpGu+sN2bKH+sGlbwu8X
         kJ4tauJeWcF3D4RAmq4QLYDpD6T1gnHOtB9SPW25A+tQdzvSXv6BxjDkB9o9YQDP8R
         +7FixGgo/B3w2XAChcsYeu7oH7t1K/7v+M69LuEbvjcHur8Bc36TlXRJkx24JdEgPG
         nzvH6sFAdr4ietd3J2LSmP6zThzv+dWi/r3FHC9qIhs8zwaLb7ALR27aolP/SnxbXl
         IbFn4S/3zsWYg==
From:   Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     Nikolai Kondrashov <spbnick@gmail.com>, kernelci@lists.linux.dev,
        gregkh@linuxfoundation.org, thorsten@leemhuis.info,
        regressions@lists.linux.dev
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: Re: Kernel regression tracking/reporting initiatives and KCIDB
References: <874jljhtmj.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me> <f40c35d3-5558-6a46-4ad4-1631ca9e1805@gmail.com>
In-reply-to: <f40c35d3-5558-6a46-4ad4-1631ca9e1805@gmail.com>
Date:   Tue, 08 Aug 2023 11:55:47 +0200
Message-ID: <87v8dphn8c.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolai,

Thanks for the comprehensive answer, see my comments below,

On vie, ago 04 2023 at 19:06:26, Nikolai Kondrashov <spbnick@gmail.com> wrote:
> I tried to review these efforts last year:
> https://archive.fosdem.org/2022/schedule/event/masking_known_issues_across_six_kernel_ci_systems/

That's a good summary, and it's nice to see an unbiased analysis of the
current state of the art and what could be improved. I think we agree in
most of the points.

> At this moment KCIDB submitters can send data linking a particular test or
> build result to an issue and its category (kernel/test/framework). We can
> generate notifications on e.g. a new issue being found by CI system
> (maintainers) in a particular repo/branch. There's no support on dashboards
> yet, and I'm yet to push for integration with particular CI systems.
>
> Here's the full announcement with examples:
> https://lore.kernel.org/kernelci/182b43fa-0261-11b7-2edb-f379a669bc28@redhat.com/

What's the current status of this? Have any of the CI systems provided a
set of issues and incidents yet?

I like the solution to bring CI-specific patterns and definitions into a
CI-agnostic aggregator like KCIDB. I'm not familiar with the KCIDB
schemas so I'm not aware of the different ways that each individual CI
system chooses to define their test results.

A different approach could be to define a standard way to report CI test
results that every CI system could adhere to, but I guess that task
could become way too expensive. I think defining some common
abstractions is definitely possible and the way you did it is a good
start. Hopefully it can be extended if needed.

>  > - is it possible that the test failed because of an infrastructure
>  >    error?
>
> Not sure how to approach this in KCIDB. How do you (plan to) do it?

In general, we can tell certain common errors very clearly by parsing
the test log. We had prior experience running tests in different
platforms in Collabora's LAVA lab so we were familiar with the most
frequent types of infrastructure errors seen there: assorted network
errors, failure to mount an NFS volume, failure to find the ramdisk,
etc.

We define a set of strings to match against:
https://gitlab.collabora.com/kernel/kernelci-regressions-tracker/-/blob/main/configs/logs-string-match.yaml
and we keep adding to the list when we found new patterns

At some point we'd like to use a similar approach, although automatized,
to detect frequent patterns in test outputs so that a regression
analyzer can match test results with known issues to avoid excessive
report duplication and also to do a first-stage tagging and triaging of
regressions.

>  > - does the test fail consistently since that commit or does it show
>  >    unstable results?
>
> This is a difficult thing to properly figure out in KCIDB, because it
> aggregates data from multiple CI systems. A single CI system can assume that
> earlier results for a branch correspond to earlier commits. However, because
> different CI systems test at different speeds, KCIDB cannot make that
> assumption. Commits and their testing results can come in any order. So we
> cannot draw these kinds of conclusions based on time alone.

Couldn't the results be filtered by CI-system origin so they can be
analyzed without the noise of results from other origins? I was thinking
about filtering the results by CI origin and then sorting them by
date. But, as I said, I'm not familiar with the KCIDB schema so I
wouldn't really know how to navigate through the results.

I can check the code to find the schema definitions but I was wondering
if there's a quick way to visualize the raw test results data and the
relationships between them.

> The only way KCIDB can make this work correctly is by correlating with actual
> git history, following the commit graph.

I think this might depend on the context that we have for every test
result. That could be different depending on the data origin, but in our
case, when checking the recent history of a KernelCI test we took
advantage of the fact that KernelCI builds progress linearly (new builds
are always newer versions of old builds, AFAICT), so we built the
queries around that and we don't have to do any processing of the git
repos to fetch the list of test runs of a particular test configuration
after the last failed run:
https://gitlab.collabora.com/kernel/kernelci-regressions-tracker/-/blob/main/common/analysis.py#L27

For other systems this will be different, of course. But the key idea is
that we might be able to get to the same point using different paths,
maybe simpler.

> E.g. on the dashboard of a particular test result, display graphs of this
> test's results over time: overall, and for
> architecture/compiler/config/repo/branch of this test run. And something
> similar for test views on revision/checkout/build dashboards.

Yes, we have similar visions about how the dashboard
features. Unfortunately, a proper dashboard would be a key part of the
solution but it looks like it's still pretty far away in the future.

> BTW, a couple Mercurial folks approached me after the talk above, saying that
> they're working on supporting storing test results in history so they could do
> a similar kind of correlation and reasoning. So the idea is in the air.

This is very interesting. I think one thing we're missing from git is
a standard way to keep commits metadata that won't be tied to specific
refs (ie. metadata that could be linked to a commit even if it gets
rebased).
There's plenty of commit metadata scattered all over the kernel commit
logs in the form of tags, and then anyone can write tools on top of that
to find relationships between commits, patches and tests, but that's
kind of suboptimal. Having proper support for that in the repo would
make a huge difference in how the repo data is used, beyond tracking code
changes.

> This is what the KCIDB issue-linking support described above is working
> towards. Next step is to build a triaging system linking issues to build/test
> results automatically, based on patterns submitted by both CI systems, via the
> regular submission interface, and humans, via a dedicated UI.
>
> Patterns would specify which issue (bug URL) they're matching and include
> basic things like test name, architecture, hardware, and so on, but also
> patterns to find in e.g. test output files, logs, or in dmesg.
>
> That should answer questions of whether a test or a build exhibit a particular
> issue seen before.

This is a good approach, and it could tie in with what I mentioned above
about log parsing and identifying similar issues from their test log
outputs.

> One comment regarding the prototype you shared is that it's quite verbose and
> it's difficult to put together a feeling of what's been happening from
> overabundance of textual information. I think a visual touch could help here.

I agree, this started as an experiment and it shows. Having a nice and
flexible html output was never the main requirement.

> E.g. drawing a timeline of test results, pointing particular events (first
> failed, first passed, stability and so on) along its length.
>
> So instead of this:
>
>  > first failed: today (2023-08-02)
>  >
>  >     kernel: chromeos-stable-20230802.0
>  >     commit: 5c04267bed569d41aea3940402c7ce8cf975a5fe
>  >
>  > most recent fail: today (2023-08-02)
>  >
>  >     kernel: chromeos-stable-20230802.0
>  >     commit: 5c04267bed569d41aea3940402c7ce8cf975a5fe
>  >
>  > last passed: 1 day ago (2023-08-01)
>  >
>  >     kernel: chromeos-stable-20230801.1
>  >     commit: cd496545d91d820441277cd6a855b9af725fdb8a
>
> Something like this (roughly):
>
>               |
> 2023-08-02   F - last FAIL
>               F
>               |
>               P
>               F
>               |
> 2023-08-02   F - first FAIL
>               |
> 2023-08-01   P - last PASS
>               |
>               P

That's absolutely right. We have the data, I just wish I had the webdev
chops to do that XD. Although we could probably give it a try now that
the feature set is mostly stable.

Thanks for the detailed answers and your insights. It's great to see we
share many points of view. Now that we know there's a long road ahead
it's time to draw an initial roadmap and see how far it can get us.

So, what would you recommend we can start with KCIDB? Would there be a
way for us to consume the data, even if it's only partially, to
experiment and get some ideas about what to do next? Would you rather
have these features implemented as part of KCIDB itself?

Cheers,
Ricardo

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72F677059B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjHDQGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjHDQGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:06:42 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C8E2D71
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:06:40 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-40fcc91258fso16451261cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 09:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691165199; x=1691769999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9WHpaML7TDpchlXETOyRPhVVaYZ8jGUF38TR9WRuWOk=;
        b=kFTiARaoAXW2m4aK60apoeeCITzjsHdc6gptlWS/PNQ9yvKwzIrKGaSl0Ahf6XkNAR
         JoS5FjzksZlmxMoTeizw+tbXrHfB4iv1Cm6aS+hC9KBKV14ZMhU9/lpJv3P3xjJY1wmf
         W6HMTOeWlHSi0IjpsZrCmVuvp7VbhoExuTBbG8dsMDvW8TTH/JY+yhYBRRkI10Mhbzl5
         IMLXIKgmtPdIBdg5y4uOsOslSsCqSB/CXpyY334jzyCmv9CGICISmqB+gobA+Yst62cC
         ggUoEVNraubR17J7I2u6I9UgB2ct+K6ikrkumOcFjDMYi99jmlRzHev6RsLYs+rNdOtA
         7cZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691165199; x=1691769999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9WHpaML7TDpchlXETOyRPhVVaYZ8jGUF38TR9WRuWOk=;
        b=IdLkzLDOqhMK8JdLEX2mkQcMbVs03RRKIBqJxPZ/S3WDcTyoI9XwlEzJvpLTjGPirZ
         zB3M69FnmYtlBVk701GnmvtLJrl9rCbIzjeomGDDFF+hCv2/yIcx9UK6XWeHnYTyUGLp
         daWkvFcXQwSYFHjXBMsAKqApDdLJGJ8u97CaGBB0SREJqPP76phwTJIn5EX/Xym/kHDT
         7t2ITqX8AXIjDcT7dOiIgkttaJXXoj0em/F8/IsvJ7/TACeUVqyZIIJhd15nc1gi+D9l
         Sr4loHZNLXY7TxoAGRp8h9DRIGVFqWCx4NJwczVwRKYCbBpydB9S47LpFDL2mjCkzn2H
         0eSQ==
X-Gm-Message-State: AOJu0YybIQB+23L/I+D8oTewL4N6K92dCPzS4ur29vW7b4MnW4IZZAhW
        feknRD96dSXCqZYh3MpMghw=
X-Google-Smtp-Source: AGHT+IG4llEuyDN62wdGO5+g2Pd6HbEpOc2DuV5egwlhQAnyr8QgmANl9YPT9LP7PGVJrJ1elAr2jQ==
X-Received: by 2002:ac8:5843:0:b0:3f6:c253:a738 with SMTP id h3-20020ac85843000000b003f6c253a738mr3483552qth.41.1691165199093;
        Fri, 04 Aug 2023 09:06:39 -0700 (PDT)
Received: from [192.168.0.118] (88-113-27-52.elisa-laajakaista.fi. [88.113.27.52])
        by smtp.gmail.com with ESMTPSA id y24-20020ac87c98000000b0040541a8bd66sm734830qtv.60.2023.08.04.09.06.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 09:06:33 -0700 (PDT)
Message-ID: <f40c35d3-5558-6a46-4ad4-1631ca9e1805@gmail.com>
Date:   Fri, 4 Aug 2023 19:06:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: Kernel regression tracking/reporting initiatives and KCIDB
To:     =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>,
        kernelci@lists.linux.dev, gregkh@linuxfoundation.org,
        thorsten@leemhuis.info, regressions@lists.linux.dev
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>
References: <874jljhtmj.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
Content-Language: en-US
From:   Nikolai Kondrashov <spbnick@gmail.com>
In-Reply-To: <874jljhtmj.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On 8/1/23 14:47, Ricardo Cañuelo wrote:
 > Hi all,
 >
 > I'm Ricardo from Collabora. In the past months, we’ve been analyzing the
 > current status of CI regression reporting and tracking in the Linux
 > kernel: assessing the existing tools, testing their functionalities,
 > collecting ideas about desirable features that aren’t available yet and
 > sketching some of them.
 >
 > As part of this effort, we wrote a Regression Tracker tool [1] as a
 > proof of concept. It’s a rather simple tool that takes existing
 > regression data and reports and uses them to show more context on each
 > reported regression, as well as highlighting the relationships between
 > them, whether they can be caused by an infrastructure error and other
 > additional metadata about their current status.  We’ve been using it
 > mostly as a playground for us to explore the current status of the
 > functionalities provided by CI systems and to test ideas about new
 > features.
 >
 > We’re also checking other tools and services provided by the community,
 > such as regzbot [2], collaborating with them when possible and thinking
 > about how to combine multiple scattered efforts by different people
 > towards the same common goal. As a first step, we’ve contributed to
 > regzbot and partially integrated its results into the Regression Tracker
 > tool.

Nicely done!

Especially cooperating with regzbot, something I haven't seen so far.

Various other kernel CI systems have been building similar things for a while,
and it's nice to see the trend growing. It means we're getting somewhere.

I tried to review these efforts last year:
https://archive.fosdem.org/2022/schedule/event/masking_known_issues_across_six_kernel_ci_systems/

 > So far, we’ve been using the KernelCI regression data and reports as a
 > data source, we're now wondering if we could tackle the problem with a
 > more general approach by building on top of what KCIDB already provides.

Yes, I would love to work with you on a KCIDB implementation/integration.

I've been exploring and implementing a solution for tracking regressions (or
"known issues" as I usually call them) based on what I researched (and
presented above).

At this moment KCIDB submitters can send data linking a particular test or
build result to an issue and its category (kernel/test/framework). We can
generate notifications on e.g. a new issue being found by CI system
(maintainers) in a particular repo/branch. There's no support on dashboards
yet, and I'm yet to push for integration with particular CI systems.

Here's the full announcement with examples:
https://lore.kernel.org/kernelci/182b43fa-0261-11b7-2edb-f379a669bc28@redhat.com/

Admittedly it's not much, and you're much further along (as many other CI
systems), but we have further plans (more on that below).

 > In general, CI systems tend to define regressions as a low-level concept
 > which is rather static: a snapshot of a test result at a certain point
 > in time. When it comes to reporting them to developers, there's much
 > more info that could be added to them. In particular, the context of it
 > and the fact that a reported regression has a life cycle:
 >
 > - did this test also fail on other hardware targets or with other kernel
 >    configurations?
 > - is it possible that the test failed because of an infrastructure
 >    error?
 > - does the test fail consistently since that commit or does it show
 >    unstable results?
 > - does the test output show any traces of already known bugs?
 > - has this regression been bisected and reported anywhere?
 > - was the regression reported by anyone? If so, is there someone already
 >    working on it?
 >
 > Many of these info points can be extracted from the CI results databases
 > and processed to provide additional regression data. That’s what we’re
 > trying to do with the Regression Tracker tool, and we think it’d be
 > interesting to start experimenting with the data in KCIDB to see how
 > this could be improved and what would be the right way to integrate this
 > type of functionality.

These all are very useful insights to extract from the data, nicely done!

Here's how they map to KCIDB:

 > - did this test also fail on other hardware targets or with other kernel
 >    configurations?

KCIDB doesn't have a schema for identifying hardware at this moment. We can
work on that, but meanwhile KCIDB dashboards wouldn't be able to show this.

 > - is it possible that the test failed because of an infrastructure
 >    error?

Not sure how to approach this in KCIDB. How do you (plan to) do it?

 > - does the test fail consistently since that commit or does it show
 >    unstable results?

This is a difficult thing to properly figure out in KCIDB, because it
aggregates data from multiple CI systems. A single CI system can assume that
earlier results for a branch correspond to earlier commits. However, because
different CI systems test at different speeds, KCIDB cannot make that
assumption. Commits and their testing results can come in any order. So we
cannot draw these kinds of conclusions based on time alone.

The only way KCIDB can make this work correctly is by correlating with actual
git history, following the commit graph. I did some research into graph
databases and while they can potentially help us do it, their performance with
the actual Linux kernel git history turned out to be abysmal, due to a large
number of nodes and edges, and the lack of optimization for DAGs:

https://fosdem.org/2023/schedule/event/graph_case_for_dag/

I got an optimistic promise from Neo4j folks to have this possibly working by
next FOSDEM, but I wouldn't hold my breath for that. The fallback plan is to
hack something together using libgit2 and/or the git command-tools.

Before that happens, I think we can still do other things, just with time, to
help us along.

E.g. on the dashboard of a particular test result, display graphs of this
test's results over time: overall, and for
architecture/compiler/config/repo/branch of this test run. And something
similar for test views on revision/checkout/build dashboards.

BTW, a couple Mercurial folks approached me after the talk above, saying that
they're working on supporting storing test results in history so they could do
a similar kind of correlation and reasoning. So the idea is in the air.

 > - does the test output show any traces of already known bugs?
 > - was the regression reported by anyone? If so, is there someone already
 >    working on it?

This is what the KCIDB issue-linking support described above is working
towards. Next step is to build a triaging system linking issues to build/test
results automatically, based on patterns submitted by both CI systems, via the
regular submission interface, and humans, via a dedicated UI.

Patterns would specify which issue (bug URL) they're matching and include
basic things like test name, architecture, hardware, and so on, but also
patterns to find in e.g. test output files, logs, or in dmesg.

That should answer questions of whether a test or a build exhibit a particular
issue seen before.

 > - has this regression been bisected and reported anywhere?

Once we have history correlation mentioned above, then we would be able to
find the PASS/FAIL boundaries between commits for particular issues, already
based on just issue-linking reported by CI systems (even before implementing
triaging).

This would be a way to detect bisections, among other things. I.e. detecting
if two adjacent commits both have results of a particular test, and they are
different. This would, of course, also detect cases when the results just
happened to appear in adjacent commits, not only because of bisection.

I think this could be done more generally via frequency domain analyzis (FFT)
of test outcomes over git history, which would also detect cases of flaky test
changing failure frequency. But here I'm getting waaay ahead of myself :D

Anyway, these are my ideas for KCIDB. I would love to hear your ideas as well
feedback on the above. Email, IRC, Slack, or a video call would all do :D

--

One comment regarding the prototype you shared is that it's quite verbose and
it's difficult to put together a feeling of what's been happening from
overabundance of textual information. I think a visual touch could help here.

E.g. drawing a timeline of test results, pointing particular events (first
failed, first passed, stability and so on) along its length.

So instead of this:

 > first failed: today (2023-08-02)
 >
 >     kernel: chromeos-stable-20230802.0
 >     commit: 5c04267bed569d41aea3940402c7ce8cf975a5fe
 >
 > most recent fail: today (2023-08-02)
 >
 >     kernel: chromeos-stable-20230802.0
 >     commit: 5c04267bed569d41aea3940402c7ce8cf975a5fe
 >
 > last passed: 1 day ago (2023-08-01)
 >
 >     kernel: chromeos-stable-20230801.1
 >     commit: cd496545d91d820441277cd6a855b9af725fdb8a

Something like this (roughly):

              |
2023-08-02   F - last FAIL
              F
              |
              P
              F
              |
2023-08-02   F - first FAIL
              |
2023-08-01   P - last PASS
              |
              P

And e.g. have the commit and other extra info pop up as needed when hovering
over the status (F/P) letters/icons

And in general try to express information more visually, so it could be
absorbed at a glance, without needing to read much text, and tuck away
information that's not immediately necessary into more on-hover popups.

---

Hope this helps, and thanks for reading through :D
Nick

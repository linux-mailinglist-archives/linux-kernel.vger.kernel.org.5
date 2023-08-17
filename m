Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E1477F7CF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350743AbjHQNdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351542AbjHQNcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:32:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D33114
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 06:32:26 -0700 (PDT)
Received: from [192.168.250.83] (g1t59-h01-176-145-90-3.dsl.sta.abo.bbox.fr [176.145.90.3])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6D28E660722E;
        Thu, 17 Aug 2023 14:32:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692279145;
        bh=D/+tz6bfHmASh+DG53YYymqYkFJSEUKhizFaQuJhf6A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WLv4oGcL6CotEl53YEIAgk5UDJp9g2oTqHE9ayX3w3Aw9hKtLkFkB99xoPVj5/8du
         qjm9l3VKskx536oFV+ZZELdukpszV8nTqX2SeMOqJrA3Dxx47+wQN8Qni0Xz5gSDvZ
         SseeFiqbU4JNnckaDchBYLyeFbGXxbIWp11JP7O+QIC6ARxh7PjjHefP1bX+YT2jDX
         V9JO6DCSdMCwU2WBDHzRQrWt0vZcnT4oRmOZW0eYf2brbiF5xO4lex2zZTWxPRGA22
         szfXZNso/XUUIk38md91R2zET4i1HgjEPmHYZf6W+Qj587lXtFf7ir5yGjx4tUan3c
         aWjUrWmNIdq9A==
Message-ID: <c7120c90-e40b-0433-0175-f23f928daa50@collabora.com>
Date:   Thu, 17 Aug 2023 15:32:21 +0200
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
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
In-Reply-To: <874jljhtmj.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On 01/08/2023 13:47, Ricardo Cañuelo wrote:
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
> 
> So far, we’ve been using the KernelCI regression data and reports as a
> data source, we're now wondering if we could tackle the problem with a
> more general approach by building on top of what KCIDB already provides.

As the new KernelCI API is ramping up, we're now starting a
discussion about how to address the issue of having 2 APIs in
KernelCI.  There are several ways to solve this, but essentially
I think we agree we would like to have one main database and one
new web dashboard showing this data.  With the new API, data is
owned by the users who submit it so we can effectively provide a
solution for grouping data from multiple CI systems like KCIDB
does.

The key thing here is that KernelCI as a project will be
providing a database with regression information collected from
any public CI system.  So the topic of tracking regressions for
the whole kernel is already part of the roadmap for KernelCI, and
if just waiting for CI systems to push data is not enough we can
have services that actively go and look for regressions to feed
them into the database under a particular category (or user).

It would be good to align ideas you may have with KernelCI's
plans, also please take into account the fact that the current
Regression tracker you've created relies on the legacy system
which is going to be retired in the coming months.

> In general, CI systems tend to define regressions as a low-level concept
> which is rather static: a snapshot of a test result at a certain point
> in time. When it comes to reporting them to developers, there's much
> more info that could be added to them. In particular, the context of it
> and the fact that a reported regression has a life cycle:
> 
> - did this test also fail on other hardware targets or with other kernel
>   configurations?
> - is it possible that the test failed because of an infrastructure
>   error?

This should be treated as a false-positive failing test rather
than a "regression".  But yes of course we need to deal with
them, it's just slightly off-topic here I think.

> - does the test fail consistently since that commit or does it show
>   unstable results?
> - does the test output show any traces of already known bugs?
> - has this regression been bisected and reported anywhere?
> - was the regression reported by anyone? If so, is there someone already
>   working on it?

These are all part of the post-regression checks we've been
discussing to run as part of KernelCI.  Basically, extending from
the current automated bisection jobs we have and also taking into
account the notion of dynamic scheduling.  However, when
collecting data from other CI systems I don't think there is much
we can do if the data is not there.  But we might be able to
create collaborations to run extra post-regression checks in
other CI systems to tackle this.  For example, with TuxSuite
compatibility in KernelCI we could run CI tests for any system
that relies on TuxSuite.

> Many of these info points can be extracted from the CI results databases
> and processed to provide additional regression data. That’s what we’re
> trying to do with the Regression Tracker tool, and we think it’d be
> interesting to start experimenting with the data in KCIDB to see how
> this could be improved and what would be the right way to integrate this
> type of functionality.
> 
> Please let us know if that's a possibility and if you'd like to add
> anything to the ideas proposed above.

Experimenting with KCIDB now may be interesting, but depending on
the outcome of the discussions around having one central database
for KernelCI it might not be the optimal way to do it.  The
critical thing here is to stay in sync with developments in and
around KernelCI in general I think.

The new API is about to start its Early Access phase so we need
to stay focused on this for now, and then make sure we have a
reliable production deployment to replace the legacy system in
the coming months.  Then the focus should start shifting towards
the more advanced features we'll be enabling with the new API and
we can have a more detailed KernelCI plan to cover this.  There's
an "Advanced Features" milestone on the GitHub roadmap[3] for
that.  Let's see if we can already do some preparation work by
discussing the topic there, in coordination with whatever extra
efforts you guys might be driving outside the KernelCI realm.

Thanks,
Guillaume

> [1] https://kernel.pages.collabora.com/kernelci-regressions-tracker/
> [2] https://linux-regtracking.leemhuis.info/regzbot/all/

[3] https://github.com/orgs/kernelci/projects/10/views/15

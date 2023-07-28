Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AA9767680
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbjG1Tn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjG1Tn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:43:27 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF55D2688;
        Fri, 28 Jul 2023 12:43:24 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qPTMx-0004vy-3H; Fri, 28 Jul 2023 21:43:23 +0200
Message-ID: <da2bfc5b-8c98-17a4-1dbc-ef7989facc54@leemhuis.info>
Date:   Fri, 28 Jul 2023 21:43:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: XPS 17 9730 runs significantly warmer on Kernel 6.5-rc3
 compared to Kernel 6.4.3
Content-Language: en-US, de-DE
To:     Goran Brkuljan <goran.brkuljan@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
References: <107f05b8-0104-501c-130c-4f89f3f8a628@gmail.com>
 <2e512646-816f-ff98-d466-b82f3a7d05ef@leemhuis.info>
 <CANhdOJEq-+KaMv=TX7E4ggf7rm456ibha2W_+Y5m1580ngCw_A@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CANhdOJEq-+KaMv=TX7E4ggf7rm456ibha2W_+Y5m1580ngCw_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1690573404;a2ae5249;
X-HE-SMSGID: 1qPTMx-0004vy-3H
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.07.23 20:13, Goran Brkuljan wrote:
> Hi Everyone,

Please don't sent HTML mail to Linux kernel lists, it often will be
rejected.

>     Goran: On Tuesday, I asked you to perform bisection. Any update on it?
> 
>  
> Sorry for the delayed response. I wasn't able to do git bisection as I
> was quite busy this week. 
> 
> However, I am no longer convinced that there is a kernel related issue.
> I reinstalled both kernels and now I get consistent results between two,
> and they both return higher values.
> Now on both kernels, core20 spikes to +100.0°C and it stays there for
> the duration of the test. Other cores are going from 80-95°C.
>
> Note that I used the mainline kernel installer for handling installation. 

FWIW, I (and likely many others that read this) have no idea what
(distro specifc?) tool you are talking about. But I guess that doesn't
matter. :-D

> I would close the issue as tests and behaviour don't suggest significant
> differences between kernel versions. 

Okydo, thx for the update.

#regzbot resolve: notabug: seems everything is working fine

Ciao, Thorsten

> On Fri, Jul 28, 2023 at 3:42 PM Thorsten Leemhuis
> <regressions@leemhuis.info <mailto:regressions@leemhuis.info>> wrote:
> 
>     [CCing Thermal maintainer Rafael, maybe he can help guide us]
> 
>     Hi Bagas and everyone!
> 
>     On 27.07.23 16:24, Bagas Sanjaya wrote:
>     >
>     > I notice a regression report on Bugzilla [1].
> 
>     Bagas, it looks like you forwarded this to the maintainers of
>     "THERMAL/CPU_COOLING"; I think "THERMAL" would have been the way better
>     entry in MAINTAINERS, as many (all?) of the former are Linaro employees
>     and thus primarily care about ARM based devices. That's why I CCed
>     Rafael.
> 
>     > Quoting from it:
>     >
>     >> On my new XPS 17 9730 laptop, I recently installed the Kernel
>     6.5-rc3. I noticed, however, that during its operation, the laptop
>     was getting significantly warmer than before. I did some analysis
>     using the 'stress' tool to measure and compare the difference in CPU
>     temperatures between Kernel 6.4.3 and Kernel 6.5-rc3. Here are my
>     results:
> 
>     One thought: I wonder if there something wrong now or was there
>     something wrong earlier that was fixed to unleash the full performance
>     potential of the device. That 100°C there sounds like it's the latter
>     case, as that's the TJUNCTION temp for that processor. But would be good
>     to confirm from someone that knows better how hot such processors are
>     allowed to get these days.
> 
>     Ciao, Thorsten
> 
>     >> OS: Ubuntu 23.10
>     >> CPU: i7-13700H
>     >>
>     >> kernel 6.4.3:
>     >>                                                                 
>                                                                        
>                                                        
>     >> Initial CPU temperature:
>     >> coretemp-isa-0000
>     >> Core 0:        +47.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 4:        +45.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 8:        +46.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 12:       +46.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 16:       +45.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 20:       +44.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 24:       +44.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 25:       +44.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 26:       +44.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 27:       +44.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 28:       +45.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 29:       +45.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 30:       +45.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 31:       +45.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Stressing CPU for 30 seconds...
>     >> stress: info: [4858] dispatching hogs: 14 cpu, 0 io, 0 vm, 0 hdd
>     >> stress: info: [4858] successful run completed in 30s
>     >> CPU temperature immediately after stress test:
>     >> coretemp-isa-0000
>     >> Core 0:        +67.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 4:        +76.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 8:        +69.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 12:       +77.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 16:       +69.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 20:       +76.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 24:       +68.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 25:       +68.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 26:       +68.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 27:       +68.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 28:       +71.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 29:       +71.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 30:       +71.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 31:       +71.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Test ended at: Tue Jul 25 01:10:16 PM CEST 2023
>     >>
>     >>
>     >> kernel 6.5-rc-3:
>     >>
>     >> Initial CPU temperature:
>     >> coretemp-isa-0000
>     >> Core 0:        +46.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 4:        +46.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 8:        +46.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 12:       +46.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 16:       +44.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 20:       +44.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 24:       +45.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 25:       +45.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 26:       +45.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 27:       +45.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 28:       +45.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 29:       +45.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 30:       +45.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 31:       +45.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Stressing CPU for 30 seconds...
>     >> stress: info: [11146] dispatching hogs: 14 cpu, 0 io, 0 vm, 0 hdd
>     >> stress: info: [11146] successful run completed in 30s
>     >> CPU temperature immediately after stress test:
>     >> coretemp-isa-0000
>     >> Core 0:        +84.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 4:        +97.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 8:        +87.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 12:      +100.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 16:       +86.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 20:       +99.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 24:       +83.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 25:       +83.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 26:       +83.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 27:       +83.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 28:       +89.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 29:       +89.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 30:       +89.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Core 31:       +89.0°C  (high = +100.0°C, crit = +100.0°C)
>     >> Test ended at: Tue Jul 25 01:05:42 PM CEST 2023
>     >>
>     >> I tested few times with different setup and CPU temp on 6.5-rc3
>     is always higher especially when stressing with fewer cores.
>     >
>     > See Bugzilla for the full thread.
>     >
>     > Goran: On Tuesday, I asked you to perform bisection. Any update on it?
>     >
>     > Anyway, I'm adding this regression to regzbot:
>     >
>     > #regzbot introduced: v6.4..v6.5-rc3
>     https://bugzilla.kernel.org/show_bug.cgi?id=217703
>     <https://bugzilla.kernel.org/show_bug.cgi?id=217703>
>     > #regzbot title: significant temperature increase on XPS 17 9730
>     >
>     > Thanks.
>     >
>     > [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217703
>     <https://bugzilla.kernel.org/show_bug.cgi?id=217703>
>     >
> 

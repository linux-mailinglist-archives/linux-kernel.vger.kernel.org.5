Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5807763F74
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjGZTXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjGZTW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:22:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167E22115;
        Wed, 26 Jul 2023 12:22:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 979B661CA1;
        Wed, 26 Jul 2023 19:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C401CC433C7;
        Wed, 26 Jul 2023 19:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690399375;
        bh=y2c01r5DrVD9LAWnn2eltEtIg/G4Uc7VK457lA2zvus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sPhuTXCt42tSTRyuQCBdAgJNzENfkbID3457aJg5QG5aRDw8b+XcU4Jn3F0I7KUJ+
         e7dNTp41wpR/6z25W1tHLKbOpA2fR5e5APaB4PqpHTrd29N1ThQI5wb+3fruRZJxUj
         SD/5yS1g4DV0kLohvGCDCSXqk8VHPqJkMHqy30KyHW1zBMEDbnLx9kBR09VGS461QS
         R5Z0JbGBUCEcHNkjKMyzaP1NIAH2ZDyg1HxeAKrHukWTXbpMQTpMXK/+rywMkgdrJa
         jYUSGNtY10gTCg+tQ+it7+QuWOhjUPwtO21UZMN9mjk06t5M3usvOLOBXwQ9n9SczM
         +JlP8/2oND/Gw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EA7E940516; Wed, 26 Jul 2023 16:22:51 -0300 (-03)
Date:   Wed, 26 Jul 2023 16:22:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Adding Support for Firefox's Gecko Profile Format
Message-ID: <ZMFyi5S4JlFeZ/9c@kernel.org>
References: <CAP-5=fU7ukrQSh_8OwH9C+a-EwCamCrMaZxjqDhE9f+bFJwQBQ@mail.gmail.com>
 <ZIHPXV5/ZopqcSSc@yoga>
 <ZIofrGKElc3nkNk0@yoga>
 <CAP-5=fV9tXNpYHH9DW0cVbRoFLGvG9SNn-MUhuyKuVBRuDqjoA@mail.gmail.com>
 <ZJyT8bt0LFLw6hKV@yoga>
 <CAM9d7ch7TdagV+dzj6MCp4fY15Vc4oGJjKAoQDyc=BXqy7qi+A@mail.gmail.com>
 <287bf3c8-fa0e-8c36-df14-7d728c63c265@intel.com>
 <ZKQu00bJZwO+Fc6m@yoga>
 <ZKRcTqAsKxF/Q3fQ@yoga>
 <ZMFgIekihhoGFBpn@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMFgIekihhoGFBpn@yoga>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 26, 2023 at 11:34:17PM +0530, Anup Sharma escreveu:
> Dear all,
> 
> I want to share a recent development in our project that
> I have been working on this week. I have successfully
> implemented a new feature that allows users to directly
> open the browser and visualize the output of perf.data
> on Firefox Profiler.

Excellent news!
 
> To enhance user experience, I have made sure this option
> is enabled by default. Additionally, I've also added a
> handy command line argument, "--save-only," which allows
> users to save the output file as needed. This enhancement
> replaces the previous standard output method, providing a
> much-improved experience.
> 
> Moreover, Everything is processed locally, and no data is
> sent to any server.

That addresses the worry about sending possibly sensitive data over the
network by default, great.
 
> During this implementation, I had the opportunity to delve
> into several exciting topics, including threading, HTTP server,
> and CORS mechanisms. The learning process has been both
> challenging and rewarding.

Cool that you're so excited learning all this.
 
> Currently, I am in the process of performing some clean-up tasks.
> Once that is complete, I will be sharing the next version of the
> series, which includes this fantastic new feature, with all of
> you very soon.
> 
> Thank you for your ongoing support and encouragement.

Keep it up!

- Arnaldo

> Thanks,
> Anup
> 
> > > Regards,
> > > Anup
> > > > > 
> > > > >>
> > > > >> The second challenge revolved around the usage of event hooks provided with the perf script
> > > > >> python event handlers. I found myself deliberating between two approaches. The first
> > > > >> approach involved creating custom functions that would be called using the event
> > > > >> handlers. These functions would then save the data in an organized format within
> > > > >> globally created data structures. The alternative approach was to write the entire
> > > > >> logic inside the event handlers themselves.
> > > > >>
> > > > >> Additionally, I contemplated whether it would be more suitable to handle the creation of
> > > > >> a Gecko format for JSON and the profile format within the same script or to separate
> > > > >> them into different scripts.
> > > > >>
> > > > >> I will discuss this points during tomorrow's office hour.
> > > > >>
> > > > >> However, I have gained a deeper understanding of the problem at hand and will use this
> > > > >> knowledge to make more informed decisions and progress more effectively in the coming weeks.
> > > > > 
> > > > > Sounds like you did a good amount of research on how perf script
> > > > > works.  We can talk about the details in the meeting.
> > > > > 
> > > > > Thanks,
> > > > > Namhyung
> > > > 

-- 

- Arnaldo

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EBA763E1C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjGZSE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjGZSE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:04:27 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19322115;
        Wed, 26 Jul 2023 11:04:26 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bb8e45185bso355215ad.1;
        Wed, 26 Jul 2023 11:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690394666; x=1690999466;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l2QbhaPAlPYsT2PUzbG85aHBFLLce4qA+jmwFSFHZJs=;
        b=RxeYPUxj81dmSfsMgf7dWDb/x4yccpl81Wwpt9jIfTBqNerwz6I/f0Y2D6vCkarqHG
         jIN3AXT7UXkFlPJK4sCMpyv7R0Kw+Hp38YRb/PQcMUfdKi9HlFbwmH7Wcqzg+/cn5Yvi
         wtuS/8Nom5UxtBNApqNaK+J8+v3jWSHKr9P6sjmulQyS0UOJMLozVm92WPc85+4Aj7BM
         qd3p1yMNk0jYFD3oWpLJqKtfEutmScT2mYZEy5SyxY6MtbZHM9jVhWjt1Fv7uFo0qIhH
         XrZc0C8TDyKaMPNSff/oh+dvXx+FQ0RtuhMvRaqttecbmNygJxhw0ptQwKrXp5k4OJSc
         /ZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690394666; x=1690999466;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l2QbhaPAlPYsT2PUzbG85aHBFLLce4qA+jmwFSFHZJs=;
        b=K574ZWrwSlTQYTk4vJflygVsNnKp0Up049P8Ugh8W3cXoSLmih7ehYc7Dr1/aORmB3
         hLLWs3a88wEBNAJAlFldmBPeQ3uEDjw0mc/ibHlu8g5Wyq6/m4ZM762OgLnK5Q1/YUCM
         Y4aqaifpk9EXuX2PRzz89nXQyrZogBZqQpACghhru2IcNTPiRWq+9LWo0rVFqD140/LO
         LJV6wMdJJfKkj4oBzxCHf53IhV9IyxmzkpWSXSJXUo5Jo+fhsmEwhR/A8uxPhhX9/YM+
         a3pSGUYdpvYC5UUVej9Psux1bVMAmARFnaVHTODyifQcFvl1wk8T3D6+5Ien1os9wgJb
         148Q==
X-Gm-Message-State: ABy/qLZXNnsO9sYBgjaVkrNeoZaLZxRDEgPRwVdW0Bu5qyVA4SFTTdKn
        KKhVGSd/qw5yEPmctBUlPiU=
X-Google-Smtp-Source: APBJJlERukextq0jo17nDcTkBIhIccterGAj2jKmLEWMyL/Qo+VJor/7Vn2chc1fRzMn2xOxxLPIyQ==
X-Received: by 2002:a17:902:bb8c:b0:1bb:98de:251d with SMTP id m12-20020a170902bb8c00b001bb98de251dmr1664814pls.63.1690394665778;
        Wed, 26 Jul 2023 11:04:25 -0700 (PDT)
Received: from yoga ([2400:1f00:13:8218:22e3:beae:16c:c1d1])
        by smtp.gmail.com with ESMTPSA id t11-20020a170902a5cb00b001b9dab0397bsm11790053plq.29.2023.07.26.11.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 11:04:25 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Wed, 26 Jul 2023 23:34:17 +0530
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Adding Support for Firefox's Gecko Profile Format
Message-ID: <ZMFgIekihhoGFBpn@yoga>
References: <ZH5YBBWW5ANckoMp@yoga>
 <CAP-5=fU7ukrQSh_8OwH9C+a-EwCamCrMaZxjqDhE9f+bFJwQBQ@mail.gmail.com>
 <ZIHPXV5/ZopqcSSc@yoga>
 <ZIofrGKElc3nkNk0@yoga>
 <CAP-5=fV9tXNpYHH9DW0cVbRoFLGvG9SNn-MUhuyKuVBRuDqjoA@mail.gmail.com>
 <ZJyT8bt0LFLw6hKV@yoga>
 <CAM9d7ch7TdagV+dzj6MCp4fY15Vc4oGJjKAoQDyc=BXqy7qi+A@mail.gmail.com>
 <287bf3c8-fa0e-8c36-df14-7d728c63c265@intel.com>
 <ZKQu00bJZwO+Fc6m@yoga>
 <ZKRcTqAsKxF/Q3fQ@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZKRcTqAsKxF/Q3fQ@yoga>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 11:22:14PM +0530, Anup Sharma wrote:
> On Tue, Jul 04, 2023 at 08:08:11PM +0530, Anup Sharma wrote:
> > On Thu, Jun 29, 2023 at 09:35:22AM +0300, Adrian Hunter wrote:
> > > On 29/06/23 09:26, Namhyung Kim wrote:
> > > > Hi Anup,
> > > > 
> > > > On Wed, Jun 28, 2023 at 1:11 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> > > >>
> > > >> On Wed, Jun 14, 2023 at 01:17:52PM -0700, Ian Rogers wrote:
> > > >>> On Wed, Jun 14, 2023 at 1:14 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> > > >>>>
> > > >>>> On Thu, Jun 08, 2023 at 06:23:49PM +0530, Anup Sharma wrote:
> > > >>>> I wanted to take a moment to provide you with an update on the progress
> > > >>>> of our Firefox Gecko converter work. While I must emphasize that the code
> > > >>>> I'm sharing is not the final version, I wanted to share the advancements
> > > >>>> I have made thus far.
> > > >>>>
> > > >>>> This script can generate a JSON format from the output of the "perf script" command.
> > > >>>> I attempted to load this JSON file into profile.firefox.com, and although it
> > > >>>> successfully loaded, the call tree are not visible. I'm certain this issue
> > > >>>> is related to the format of the JSON file or if there is another underlying
> > > >>>> cause. I will continue investigating to determine the cause of this problem.
> > > >>>
> > > >>> Great Anup, progress can be frustrating slow at first but it is a good
> > > >>> milestone to be generating output and having firefox profiler consume
> > > >>> it. You can open up the JavaScript console for the firefox profiler
> > > >>> and it will give some debug output. This should hopefully help you
> > > >>> make progress.
> > > >>
> > > >> This week I tried playing with perf-script-python, the first challenge was
> > > >> figuring out how to parse the data coming from the process_events.
> > > >> Understanding the structure and extracting the necessary information
> > > >> proved to be more complex than anticipated. This required me to spend
> > > >> a significant amount of time researching and experimenting with different
> > > >> parsing techniques.
> > > > 
> > > > I'm not sure what kind of parsing you meant.  IIRC the sample data is
> > > > in a dict and all the information should be available there.  Maybe we
> > > > missed some new sample data types though.
> > > 
> > > Most data is there.  There are existing scripts in
> > > tools/perf/scripts/python/ for reference.
> > > 
> > > There is also the dlfilter API:
> > > 
> > > https://perf.wiki.kernel.org/index.php/Latest_Manual_Page_of_perf-dlfilter.1
> > >
> > Hello everyone,
> > 
> > I hope you're all doing well. I have been working on the using process_events function and have made
> > progress in developing the converter script. Currently, I am in the testing phase. However, I
> > have encountered a problem after performing some recent compilations. I am no longer receiving
> > the complete callchains in the output as I used to.
> > For Example, when I ran the command perf script -F +pid, the output would include detailed
> > information like the following example:
> > 
> > perf-exec  132554/132554  171854.674582:        356 cycles:P: 
> > 	ffffffff8fab3fc6 arch_static_branch+0x6 (inlined)
> > 	ffffffff8fab3fc6 static_key_false+0x6 (inlined)
> > 	ffffffff8fab3fc6 native_write_msr+0x6 (/lib/modules/6.4.0-rc1/build/vmlinux)
> > 	ffffffff8fa12ca5 intel_pmu_enable_all+0x15 (/lib/modules/6.4.0-rc1/build/vmlinux)
> > 
> > However, in my current situation, the output is limited to the following:
> > 
> > perf  108107/108107  [000] 67650.031827:          1 cycles:P:  
> > ffffffff83ab3fc4 native_write_msr+0x4 (/lib/modules/6.4.0-rc1/build/vmlinux)
> > perf  108107/108107  [000] 67650.031832:          1 cycles:P:
> > ffffffff83ab3fc4 native_write_msr+0x4 (/lib/modules/6.4.0-rc1/build/vmlinux)
> > 
> > It seems to be issue in perf record. I would appreciate any suggestions or assistance
> > in resolving this issue. Thank you all for your help.
> 
> My apologies, I realized that I had mistakenly not included the '-g' option,
> and it is now working fine."

Dear all,

I want to share a recent development in our project that
I have been working on this week. I have successfully
implemented a new feature that allows users to directly
open the browser and visualize the output of perf.data
on Firefox Profiler.

To enhance user experience, I have made sure this option
is enabled by default. Additionally, I've also added a
handy command line argument, "--save-only," which allows
users to save the output file as needed. This enhancement
replaces the previous standard output method, providing a
much-improved experience.

Moreover, Everything is processed locally, and no data is
sent to any server.

During this implementation, I had the opportunity to delve
into several exciting topics, including threading, HTTP server,
and CORS mechanisms. The learning process has been both
challenging and rewarding.

Currently, I am in the process of performing some clean-up tasks.
Once that is complete, I will be sharing the next version of the
series, which includes this fantastic new feature, with all of
you very soon.

Thank you for your ongoing support and encouragement.

Thanks,
Anup

> > Regards,
> > Anup
> > > > 
> > > >>
> > > >> The second challenge revolved around the usage of event hooks provided with the perf script
> > > >> python event handlers. I found myself deliberating between two approaches. The first
> > > >> approach involved creating custom functions that would be called using the event
> > > >> handlers. These functions would then save the data in an organized format within
> > > >> globally created data structures. The alternative approach was to write the entire
> > > >> logic inside the event handlers themselves.
> > > >>
> > > >> Additionally, I contemplated whether it would be more suitable to handle the creation of
> > > >> a Gecko format for JSON and the profile format within the same script or to separate
> > > >> them into different scripts.
> > > >>
> > > >> I will discuss this points during tomorrow's office hour.
> > > >>
> > > >> However, I have gained a deeper understanding of the problem at hand and will use this
> > > >> knowledge to make more informed decisions and progress more effectively in the coming weeks.
> > > > 
> > > > Sounds like you did a good amount of research on how perf script
> > > > works.  We can talk about the details in the meeting.
> > > > 
> > > > Thanks,
> > > > Namhyung
> > > 

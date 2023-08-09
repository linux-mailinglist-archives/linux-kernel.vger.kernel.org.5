Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448B6776963
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjHIUBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjHIUBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:01:19 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4447DD2;
        Wed,  9 Aug 2023 13:01:18 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bc411e9d17so2081745ad.0;
        Wed, 09 Aug 2023 13:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691611278; x=1692216078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HS88ftUTyzR3Q0GvZ4/QO9Y1ZAxs9zglfag3dq1XafI=;
        b=nRoM0L2Wry6nncUwzn0RLyiuHAyBqiQXR9WzQBN1nEhLyTjwLvFMuL+TNsuascbDyN
         PPCRUtsfD9CsabN0HGzyBzc7M2Dbs8tpceMQQZjMaA1nEKMuqZ0PUx4sUs7t4r6eNoER
         097BItuKHgrE2F5z/16RatVM08Wl2mOcR/74MXd9q4JJjVApkGoDcWKempKrESOPm9iT
         yI8adNsag3LqmsdIsd3nS0tJ1YBkn+F3WqOiOQ+2zCpabWZeC1eAQdh4B0An+DBHdPQ4
         RQdSKu4OjWYQaxyFyagPrgtQDfI7ZleDfRUtRjq5VpIU5rolldDNmvY/bFOeHa9FG1jJ
         5UdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691611278; x=1692216078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HS88ftUTyzR3Q0GvZ4/QO9Y1ZAxs9zglfag3dq1XafI=;
        b=hbqy3tIqGSc0d/f3nj9Pz6WtsKyXoSfPNcYPMW736aWloXPmFQTPbNk+stJHqrO/iT
         KmscVjajmC2/8n5r+vZi4kf0louUPQ9ZaLpcdsF4jjl2TSdQCOnkX2vaaMpWadhcCPvq
         gLqEVcDlQtPAu9BZFDpqP+oTcO4h4PvgmGyn97H6cg4SQ1kHSkC1pCOnpD99RmLEOb0g
         WN29yn/9pqrTZQxALFQ6mZ9M+oUb/xjrcw8xYMgTCHdEXaEyuduRl+9kVYb8Echgz5QD
         /RIhOwQiZp5zA9j8DnBZFmi6HKOB3fzur4mH85oBh9a31WXQxYKnmKbHd8KnZGs599HB
         JGaQ==
X-Gm-Message-State: AOJu0YySmj7CO2hMEvT3TJeB9xbXfgES+dsM4J/V0ZgnEu59rpagUzer
        8xhBoXJdYKFJANs8oVlYem0=
X-Google-Smtp-Source: AGHT+IFOG2krU+ld7Ezro95lU0nUAvoAI2MtWQ+5LGTblfUXkndK/rofRwJs99wk6TIFICPtVIU1BQ==
X-Received: by 2002:a17:902:ea02:b0:1bc:382b:6897 with SMTP id s2-20020a170902ea0200b001bc382b6897mr114934plg.13.1691611277411;
        Wed, 09 Aug 2023 13:01:17 -0700 (PDT)
Received: from yoga ([2400:1f00:13:9c9a:9cd0:55ee:75bd:a5c5])
        by smtp.gmail.com with ESMTPSA id a2-20020a1709027d8200b001bc39aa63ebsm11571085plm.121.2023.08.09.13.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:01:16 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Thu, 10 Aug 2023 01:31:09 +0530
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        anupnewsmail@gmail.com
Subject: Re: [RFC] Adding Support for Firefox's Gecko Profile Format
Message-ID: <ZNPwhctOgd0RdtwO@yoga>
References: <ZIofrGKElc3nkNk0@yoga>
 <CAP-5=fV9tXNpYHH9DW0cVbRoFLGvG9SNn-MUhuyKuVBRuDqjoA@mail.gmail.com>
 <ZJyT8bt0LFLw6hKV@yoga>
 <CAM9d7ch7TdagV+dzj6MCp4fY15Vc4oGJjKAoQDyc=BXqy7qi+A@mail.gmail.com>
 <287bf3c8-fa0e-8c36-df14-7d728c63c265@intel.com>
 <ZKQu00bJZwO+Fc6m@yoga>
 <ZKRcTqAsKxF/Q3fQ@yoga>
 <ZMFgIekihhoGFBpn@yoga>
 <ZMFyi5S4JlFeZ/9c@kernel.org>
 <ZMqnp1kBv1ACIiGS@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMqnp1kBv1ACIiGS@yoga>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 12:29:51AM +0530, Anup Sharma wrote:
> On Wed, Jul 26, 2023 at 04:22:51PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Jul 26, 2023 at 11:34:17PM +0530, Anup Sharma escreveu:
> > > Dear all,
> > > 
> > > I want to share a recent development in our project that
> > > I have been working on this week. I have successfully
> > > implemented a new feature that allows users to directly
> > > open the browser and visualize the output of perf.data
> > > on Firefox Profiler.
> > 
> > Excellent news!
> >  
> > > To enhance user experience, I have made sure this option
> > > is enabled by default. Additionally, I've also added a
> > > handy command line argument, "--save-only," which allows
> > > users to save the output file as needed. This enhancement
> > > replaces the previous standard output method, providing a
> > > much-improved experience.
> > > 
> > > Moreover, Everything is processed locally, and no data is
> > > sent to any server.
> > 
> > That addresses the worry about sending possibly sensitive data over the
> > network by default, great.
> >  
> > > During this implementation, I had the opportunity to delve
> > > into several exciting topics, including threading, HTTP server,
> > > and CORS mechanisms. The learning process has been both
> > > challenging and rewarding.
> > 
> > Cool that you're so excited learning all this.
> >  
> > > Currently, I am in the process of performing some clean-up tasks.
> > > Once that is complete, I will be sharing the next version of the
> > > series, which includes this fantastic new feature, with all of
> > > you very soon.
> > > 
> > > Thank you for your ongoing support and encouragement.
> > 
> > Keep it up!
> 
> This week, I'm working on documenting the gecko converter for our wiki.
> I've dedicated a significant amount of time to think about the content
> and how to approach it. So far, I've written sections covering the
> introduction to Firefox Profiler and the formatting guidelines(not
> published yet).
> 
> However, I've left the usage part blank because I'm uncertain about how
> to enable gecko.py arguments when executing the "perf script gecko" command.
> I've looked at examples like flamegraph-report and sctop-report, but I'm
> still confused. I attempted to enable the script to take the gecko.py
> command example "perf script report gecko --save-only=profiler.json,"
> but this caused issues when running "perf script gecko -a sleep 3" again.
> This has left me feeling rather puzzled, and I would appreciate discussing
> this during our office hour, or any help here.
> 
> Due to this blocker, I haven't been able to send the updated patch
> for test_gecko yet. However, I hope I'll find a solution soon and overcome
> this obstacle.

Hello All,
As discussed during last office hour, I was little occupied this week, so
I haven't been able to make much progress on my TODO list. Nonetheless,
I've resent a server patch and test script patch for your review. If I can
get it reviewed it would be great to make further progress.

I'm also working on writing documentation for our wiki. I've already written a
bit, and you can see it here: https://perf.wiki.kernel.org/index.php/Tutorial#Firefox_Profiler.
If you have any thoughts or suggestions, I'd appreciate hearing them. I'll add
more details once I've sorted out some issues I'm having with certain commands.

This week, I do not have a specific agenda. Hence, if we opt to skip this week's
office hour, it wouldn't pose any inconvenience. Nevertheless, I am available if
there are matters you wish to discuss.

Here's what I have in mind to work on next:

1. Making sure that gecko script args work with commands, like
(perf script gecko --save-only=profile.json) or (perf script gecko --kernel-color=green),which
aren't working right now.

2. Trying out "perf record -p firefox" or using it with a specific process ID to
see if the current script supports these recording commands.

3. Adding page fault and one more event in stackTable in gecko script.

4. Making the documentation better.

Thanks,
Anup

> > - Arnaldo
> > 
> > > Thanks,
> > > Anup
> > > 
> > > > > Regards,
> > > > > Anup
> > > > > > > 
> > > > > > >>
> > > > > > >> The second challenge revolved around the usage of event hooks provided with the perf script
> > > > > > >> python event handlers. I found myself deliberating between two approaches. The first
> > > > > > >> approach involved creating custom functions that would be called using the event
> > > > > > >> handlers. These functions would then save the data in an organized format within
> > > > > > >> globally created data structures. The alternative approach was to write the entire
> > > > > > >> logic inside the event handlers themselves.
> > > > > > >>
> > > > > > >> Additionally, I contemplated whether it would be more suitable to handle the creation of
> > > > > > >> a Gecko format for JSON and the profile format within the same script or to separate
> > > > > > >> them into different scripts.
> > > > > > >>
> > > > > > >> I will discuss this points during tomorrow's office hour.
> > > > > > >>
> > > > > > >> However, I have gained a deeper understanding of the problem at hand and will use this
> > > > > > >> knowledge to make more informed decisions and progress more effectively in the coming weeks.
> > > > > > > 
> > > > > > > Sounds like you did a good amount of research on how perf script
> > > > > > > works.  We can talk about the details in the meeting.
> > > > > > > 
> > > > > > > Thanks,
> > > > > > > Namhyung
> > > > > > 
> > 
> > -- 
> > 
> > - Arnaldo

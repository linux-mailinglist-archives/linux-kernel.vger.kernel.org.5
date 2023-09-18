Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9397A3FBC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 05:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbjIRDkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 23:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjIRDjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 23:39:54 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281ED11C;
        Sun, 17 Sep 2023 20:39:48 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68fac346f6aso3727945b3a.3;
        Sun, 17 Sep 2023 20:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695008387; x=1695613187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DDSlcJo5rIfEnCIjkrrQvFleAfDylgIEYNugls+9aRk=;
        b=BlzUPca9COjN60j4q/pLhkM0DtOhfnuiXDu61gAu/bOV2zoQJrf2L2dBg0fm7sFAn/
         FOtxh6yXJzQVzi9BUtgWhgfpDTzrDGeHz466bsL0l7TorQFKNl30dbRRa1yNn86iCI5p
         ROE/Tgs56tFM5owadGqQUBjIQnRIFigcx2eQIDwiZfqYA0YBT13xuSqa3TOhF+w8SmiB
         EOcBzFfVFt0O3lB6m43ZEFm2LKAolCj13w0RorguGUVONqA2L69AKMglYpQ0aJi11dpx
         XUJCPvzFBt1sQY66mDgKhRXucJA6+PhpvctpxRmicmH+mm5is+xM3wUeOPTZx/ULPGZC
         1msQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695008387; x=1695613187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDSlcJo5rIfEnCIjkrrQvFleAfDylgIEYNugls+9aRk=;
        b=N0hNU8br4YwgN4qIfGkzJp8USUH6LYcqFcGiNdutelN8PnnUc9awtPxq5r8l8JLHi1
         CJJGmiq40PEnE2Dl33dAhsavrt5BUIkklSHSzDwuvQ+kK6yCW+OnrkxrOm557KlKGo8e
         ewk4zdPA7HBFJ83f8t4+pM6eDg5+gcEjwSLTEfCZ8NfykLgLRPRBESfyIFCq8I9vqPKa
         SbZ8+V8q5H/STQlGzb+qhZ+mF06RLIq7lRgL0ynmQREBv77xl7JFI0ngfOT0oLoBGdp+
         Rvoeo4ZYxiTnEPKEt6XtVBVs2/YBv/n3bgXRUzYuR2rwW4aZVCSOFD4b499uGzaoujBg
         1mJg==
X-Gm-Message-State: AOJu0YzmpvuwaqzhKtQ74b7/AgRXVyXNGMuQ2hWCP6hcoOe05EL3Ed0C
        7Cq4G5plhrJll9RHlLpVi18=
X-Google-Smtp-Source: AGHT+IHp7iYi+9MFG5k8kbiYk37XGilifye9fC086/lr4YaWfbkuM+w0hlC2YHu5AuecTKcAxEd/FA==
X-Received: by 2002:a05:6a20:8e19:b0:10f:be0:4dce with SMTP id y25-20020a056a208e1900b0010f0be04dcemr8569764pzj.8.1695008387190;
        Sun, 17 Sep 2023 20:39:47 -0700 (PDT)
Received: from yoga ([2409:40e6:1:3b7d:8e2e:1958:4e7b:d9ef])
        by smtp.gmail.com with ESMTPSA id bb18-20020a17090b009200b00274bbfc34c8sm2897898pjb.16.2023.09.17.20.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 20:39:46 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Mon, 18 Sep 2023 09:09:38 +0530
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Adding Support for Firefox's Gecko Profile Format
Message-ID: <ZQfGejxpeJa1D7j+@yoga>
References: <ZJyT8bt0LFLw6hKV@yoga>
 <CAM9d7ch7TdagV+dzj6MCp4fY15Vc4oGJjKAoQDyc=BXqy7qi+A@mail.gmail.com>
 <287bf3c8-fa0e-8c36-df14-7d728c63c265@intel.com>
 <ZKQu00bJZwO+Fc6m@yoga>
 <ZKRcTqAsKxF/Q3fQ@yoga>
 <ZMFgIekihhoGFBpn@yoga>
 <ZMFyi5S4JlFeZ/9c@kernel.org>
 <ZMqnp1kBv1ACIiGS@yoga>
 <ZNPwhctOgd0RdtwO@yoga>
 <ZN0C7yXk/aORpsI1@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN0C7yXk/aORpsI1@yoga>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 10:40:07PM +0530, Anup Sharma wrote:
> On Thu, Aug 10, 2023 at 01:31:09AM +0530, Anup Sharma wrote:
> > On Thu, Aug 03, 2023 at 12:29:51AM +0530, Anup Sharma wrote:
> > > On Wed, Jul 26, 2023 at 04:22:51PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > Em Wed, Jul 26, 2023 at 11:34:17PM +0530, Anup Sharma escreveu:
> > > > > Dear all,
> > > > > 
> > > > > I want to share a recent development in our project that
> > > > > I have been working on this week. I have successfully
> > > > > implemented a new feature that allows users to directly
> > > > > open the browser and visualize the output of perf.data
> > > > > on Firefox Profiler.
> > > > 
> > > > Excellent news!
> > > >  
> > > > > To enhance user experience, I have made sure this option
> > > > > is enabled by default. Additionally, I've also added a
> > > > > handy command line argument, "--save-only," which allows
> > > > > users to save the output file as needed. This enhancement
> > > > > replaces the previous standard output method, providing a
> > > > > much-improved experience.
> > > > > 
> > > > > Moreover, Everything is processed locally, and no data is
> > > > > sent to any server.
> > > > 
> > > > That addresses the worry about sending possibly sensitive data over the
> > > > network by default, great.
> > > >  
> > > > > During this implementation, I had the opportunity to delve
> > > > > into several exciting topics, including threading, HTTP server,
> > > > > and CORS mechanisms. The learning process has been both
> > > > > challenging and rewarding.
> > > > 
> > > > Cool that you're so excited learning all this.
> > > >  
> > > > > Currently, I am in the process of performing some clean-up tasks.
> > > > > Once that is complete, I will be sharing the next version of the
> > > > > series, which includes this fantastic new feature, with all of
> > > > > you very soon.
> > > > > 
> > > > > Thank you for your ongoing support and encouragement.
> > > > 
> > > > Keep it up!
> > > 
> > > This week, I'm working on documenting the gecko converter for our wiki.
> > > I've dedicated a significant amount of time to think about the content
> > > and how to approach it. So far, I've written sections covering the
> > > introduction to Firefox Profiler and the formatting guidelines(not
> > > published yet).
> > > 
> > > However, I've left the usage part blank because I'm uncertain about how
> > > to enable gecko.py arguments when executing the "perf script gecko" command.
> > > I've looked at examples like flamegraph-report and sctop-report, but I'm
> > > still confused. I attempted to enable the script to take the gecko.py
> > > command example "perf script report gecko --save-only=profiler.json,"
> > > but this caused issues when running "perf script gecko -a sleep 3" again.
> > > This has left me feeling rather puzzled, and I would appreciate discussing
> > > this during our office hour, or any help here.
> > > 
> > > Due to this blocker, I haven't been able to send the updated patch
> > > for test_gecko yet. However, I hope I'll find a solution soon and overcome
> > > this obstacle.
> > 
> > Hello All,
> > As discussed during last office hour, I was little occupied this week, so
> > I haven't been able to make much progress on my TODO list. Nonetheless,
> > I've resent a server patch and test script patch for your review. If I can
> > get it reviewed it would be great to make further progress.
> > 
> > I'm also working on writing documentation for our wiki. I've already written a
> > bit, and you can see it here: https://perf.wiki.kernel.org/index.php/Tutorial#Firefox_Profiler.
> > If you have any thoughts or suggestions, I'd appreciate hearing them. I'll add
> > more details once I've sorted out some issues I'm having with certain commands.
> > 
> > This week, I do not have a specific agenda. Hence, if we opt to skip this week's
> > office hour, it wouldn't pose any inconvenience. Nevertheless, I am available if
> > there are matters you wish to discuss.
> > 
> > Here's what I have in mind to work on next:
> > 
> > 1. Making sure that gecko script args work with commands, like
> > (perf script gecko --save-only=profile.json) or (perf script gecko --kernel-color=green),which
> > aren't working right now.
> 
> I have done this part and sent the patch for review.
> https://lore.kernel.org/all/ZNf7W+EIrrCSHZN0@yoga/
> 
> > 2. Trying out "perf record -p firefox" or using it with a specific process ID to
> > see if the current script supports these recording commands.
> 
> This is working with the existing script. I've tested it and documented it as well.
> https://perf.wiki.kernel.org/index.php/Tutorial#Firefox_Profiler
> 
> > 3. Adding page fault and one more event in stackTable in gecko script.
> 
> I have few doubt regarding this will discuss in office hour.
> 
> > 4. Making the documentation better.
> 
> I am trying to make it better, but I'm not sure if it's good enough. Here's the link:
> https://perf.wiki.kernel.org/index.php/Tutorial#Firefox_Profiler
> 
> I also need to understand on how to prepare the final report for GSoC and
> planning to record a 5 min tutorial video on how to use the script.
> 
> Moreover, I need to make the script run as a root user.
> 
> This are few TODOs I have in mind. Please let me know if you have any suggestions.

I'm thrilled to share that I've received an offer from Nutanix Technologies for the
MTS-1 Kernel Development role, and I couldn't be more excited about it. I want to
express my gratitude for all your support. I'm currently on vacation, but I'll be
back in a few days to continue making contributions.

> > Thanks,
> > Anup
> > 
> > > > - Arnaldo
> > > > 
> > > > > Thanks,
> > > > > Anup
> > > > > 
> > > > > > > Regards,
> > > > > > > Anup
> > > > > > > > > 
> > > > > > > > >>
> > > > > > > > >> The second challenge revolved around the usage of event hooks provided with the perf script
> > > > > > > > >> python event handlers. I found myself deliberating between two approaches. The first
> > > > > > > > >> approach involved creating custom functions that would be called using the event
> > > > > > > > >> handlers. These functions would then save the data in an organized format within
> > > > > > > > >> globally created data structures. The alternative approach was to write the entire
> > > > > > > > >> logic inside the event handlers themselves.
> > > > > > > > >>
> > > > > > > > >> Additionally, I contemplated whether it would be more suitable to handle the creation of
> > > > > > > > >> a Gecko format for JSON and the profile format within the same script or to separate
> > > > > > > > >> them into different scripts.
> > > > > > > > >>
> > > > > > > > >> I will discuss this points during tomorrow's office hour.
> > > > > > > > >>
> > > > > > > > >> However, I have gained a deeper understanding of the problem at hand and will use this
> > > > > > > > >> knowledge to make more informed decisions and progress more effectively in the coming weeks.
> > > > > > > > > 
> > > > > > > > > Sounds like you did a good amount of research on how perf script
> > > > > > > > > works.  We can talk about the details in the meeting.
> > > > > > > > > 
> > > > > > > > > Thanks,
> > > > > > > > > Namhyung
> > > > > > > > 
> > > > 
> > > > -- 
> > > > 
> > > > - Arnaldo

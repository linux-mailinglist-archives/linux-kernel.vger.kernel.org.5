Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2595777E74F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345092AbjHPRKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345074AbjHPRKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:10:17 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7181FF3;
        Wed, 16 Aug 2023 10:10:16 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bee82fad0fso10805685ad.2;
        Wed, 16 Aug 2023 10:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692205816; x=1692810616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JawVpR5OTeIO4yE8f0JeUM7XTh5q6dYLjRB79f5cI08=;
        b=sVHDrk7B/wZ5AEqE/Qbh1eR3FJm1ISVYzGZRDOQidwL/1JSksovcT1ZTxiz0s04Rea
         tADqaGYm5IQv/5qn6DY7UimuV/ulOKyfu/oX/3b2IC0MuGUnbA22KoYHh+xbaH2Uwb09
         M/VZ1hwVPPNah+EezRnowsX3rgbpruKC5nK5x8AQZ48xPWcIKZ7G6EUCrvDSmRddaHbY
         vDhUuDQnH03HtggoqP85Ne+XtACJzLlqJuIhuH3aPxFCrjEQ+xhTdegkUrT77eSkKveD
         MpDelrV8ssy5vamrisuX+x9lU9mEaVyL1mHo0nyTXJbsKOelcnWJAS759lD9sV6zfA8c
         0xaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692205816; x=1692810616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JawVpR5OTeIO4yE8f0JeUM7XTh5q6dYLjRB79f5cI08=;
        b=PpZWd4fEADspgKXSnIBXMydmfMQRWDkssAIRxk5UtBZiZN8ui8LVREW4gEWA9kOfsv
         nQa100QcWTGbWs3OKEnlSeKKAA4gCqALQEjPVZz0Z6Han5fSypwRkgvxSNZ2drkfYUuc
         49bNuGWDMps7FtmqEKdmbuB4e6/NkYWmEPZ3ICVK1vRDc+zbiStQ/JbX7G3auNM4JISw
         dbpDtC2W0FAVZbRv6si6xStyLqQDKyAkgr3n81s2f4Swxo1qkj+C2G4Xlvo5T0ih3HJA
         DxzOEVNnKVCo48UqpjFxY/M+rj0qAjfnBPJfEBNugHHVSkdgq7/Qq2vbq3CFB/pu9BKw
         MECQ==
X-Gm-Message-State: AOJu0Ywneh4uYLmZWSb8cM+p7r/Dw+cd2hEVZaPb9HL0swXWO04lVBPY
        xBcQsxXB8USBOHS3jMf2yLM=
X-Google-Smtp-Source: AGHT+IFiESGusMWJoin8Pql+PLl40FKNQuZBdIYTUNs/n+IjBfSSs/L/YYiZSTh/lHLfSLi0EtGnyA==
X-Received: by 2002:a17:902:ce90:b0:1b9:e937:9763 with SMTP id f16-20020a170902ce9000b001b9e9379763mr2762428plg.12.1692205815586;
        Wed, 16 Aug 2023 10:10:15 -0700 (PDT)
Received: from yoga ([2400:1f00:13:54f4:15af:3399:987d:c0db])
        by smtp.gmail.com with ESMTPSA id d11-20020a170903230b00b001b8af7f632asm13423132plh.176.2023.08.16.10.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 10:10:14 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Wed, 16 Aug 2023 22:40:07 +0530
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
Message-ID: <ZN0C7yXk/aORpsI1@yoga>
References: <CAP-5=fV9tXNpYHH9DW0cVbRoFLGvG9SNn-MUhuyKuVBRuDqjoA@mail.gmail.com>
 <ZJyT8bt0LFLw6hKV@yoga>
 <CAM9d7ch7TdagV+dzj6MCp4fY15Vc4oGJjKAoQDyc=BXqy7qi+A@mail.gmail.com>
 <287bf3c8-fa0e-8c36-df14-7d728c63c265@intel.com>
 <ZKQu00bJZwO+Fc6m@yoga>
 <ZKRcTqAsKxF/Q3fQ@yoga>
 <ZMFgIekihhoGFBpn@yoga>
 <ZMFyi5S4JlFeZ/9c@kernel.org>
 <ZMqnp1kBv1ACIiGS@yoga>
 <ZNPwhctOgd0RdtwO@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNPwhctOgd0RdtwO@yoga>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 01:31:09AM +0530, Anup Sharma wrote:
> On Thu, Aug 03, 2023 at 12:29:51AM +0530, Anup Sharma wrote:
> > On Wed, Jul 26, 2023 at 04:22:51PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Wed, Jul 26, 2023 at 11:34:17PM +0530, Anup Sharma escreveu:
> > > > Dear all,
> > > > 
> > > > I want to share a recent development in our project that
> > > > I have been working on this week. I have successfully
> > > > implemented a new feature that allows users to directly
> > > > open the browser and visualize the output of perf.data
> > > > on Firefox Profiler.
> > > 
> > > Excellent news!
> > >  
> > > > To enhance user experience, I have made sure this option
> > > > is enabled by default. Additionally, I've also added a
> > > > handy command line argument, "--save-only," which allows
> > > > users to save the output file as needed. This enhancement
> > > > replaces the previous standard output method, providing a
> > > > much-improved experience.
> > > > 
> > > > Moreover, Everything is processed locally, and no data is
> > > > sent to any server.
> > > 
> > > That addresses the worry about sending possibly sensitive data over the
> > > network by default, great.
> > >  
> > > > During this implementation, I had the opportunity to delve
> > > > into several exciting topics, including threading, HTTP server,
> > > > and CORS mechanisms. The learning process has been both
> > > > challenging and rewarding.
> > > 
> > > Cool that you're so excited learning all this.
> > >  
> > > > Currently, I am in the process of performing some clean-up tasks.
> > > > Once that is complete, I will be sharing the next version of the
> > > > series, which includes this fantastic new feature, with all of
> > > > you very soon.
> > > > 
> > > > Thank you for your ongoing support and encouragement.
> > > 
> > > Keep it up!
> > 
> > This week, I'm working on documenting the gecko converter for our wiki.
> > I've dedicated a significant amount of time to think about the content
> > and how to approach it. So far, I've written sections covering the
> > introduction to Firefox Profiler and the formatting guidelines(not
> > published yet).
> > 
> > However, I've left the usage part blank because I'm uncertain about how
> > to enable gecko.py arguments when executing the "perf script gecko" command.
> > I've looked at examples like flamegraph-report and sctop-report, but I'm
> > still confused. I attempted to enable the script to take the gecko.py
> > command example "perf script report gecko --save-only=profiler.json,"
> > but this caused issues when running "perf script gecko -a sleep 3" again.
> > This has left me feeling rather puzzled, and I would appreciate discussing
> > this during our office hour, or any help here.
> > 
> > Due to this blocker, I haven't been able to send the updated patch
> > for test_gecko yet. However, I hope I'll find a solution soon and overcome
> > this obstacle.
> 
> Hello All,
> As discussed during last office hour, I was little occupied this week, so
> I haven't been able to make much progress on my TODO list. Nonetheless,
> I've resent a server patch and test script patch for your review. If I can
> get it reviewed it would be great to make further progress.
> 
> I'm also working on writing documentation for our wiki. I've already written a
> bit, and you can see it here: https://perf.wiki.kernel.org/index.php/Tutorial#Firefox_Profiler.
> If you have any thoughts or suggestions, I'd appreciate hearing them. I'll add
> more details once I've sorted out some issues I'm having with certain commands.
> 
> This week, I do not have a specific agenda. Hence, if we opt to skip this week's
> office hour, it wouldn't pose any inconvenience. Nevertheless, I am available if
> there are matters you wish to discuss.
> 
> Here's what I have in mind to work on next:
> 
> 1. Making sure that gecko script args work with commands, like
> (perf script gecko --save-only=profile.json) or (perf script gecko --kernel-color=green),which
> aren't working right now.

I have done this part and sent the patch for review.
https://lore.kernel.org/all/ZNf7W+EIrrCSHZN0@yoga/

> 2. Trying out "perf record -p firefox" or using it with a specific process ID to
> see if the current script supports these recording commands.

This is working with the existing script. I've tested it and documented it as well.
https://perf.wiki.kernel.org/index.php/Tutorial#Firefox_Profiler

> 3. Adding page fault and one more event in stackTable in gecko script.

I have few doubt regarding this will discuss in office hour.

> 4. Making the documentation better.

I am trying to make it better, but I'm not sure if it's good enough. Here's the link:
https://perf.wiki.kernel.org/index.php/Tutorial#Firefox_Profiler

I also need to understand on how to prepare the final report for GSoC and
planning to record a 5 min tutorial video on how to use the script.

Moreover, I need to make the script run as a root user.

This are few TODOs I have in mind. Please let me know if you have any suggestions.

> Thanks,
> Anup
> 
> > > - Arnaldo
> > > 
> > > > Thanks,
> > > > Anup
> > > > 
> > > > > > Regards,
> > > > > > Anup
> > > > > > > > 
> > > > > > > >>
> > > > > > > >> The second challenge revolved around the usage of event hooks provided with the perf script
> > > > > > > >> python event handlers. I found myself deliberating between two approaches. The first
> > > > > > > >> approach involved creating custom functions that would be called using the event
> > > > > > > >> handlers. These functions would then save the data in an organized format within
> > > > > > > >> globally created data structures. The alternative approach was to write the entire
> > > > > > > >> logic inside the event handlers themselves.
> > > > > > > >>
> > > > > > > >> Additionally, I contemplated whether it would be more suitable to handle the creation of
> > > > > > > >> a Gecko format for JSON and the profile format within the same script or to separate
> > > > > > > >> them into different scripts.
> > > > > > > >>
> > > > > > > >> I will discuss this points during tomorrow's office hour.
> > > > > > > >>
> > > > > > > >> However, I have gained a deeper understanding of the problem at hand and will use this
> > > > > > > >> knowledge to make more informed decisions and progress more effectively in the coming weeks.
> > > > > > > > 
> > > > > > > > Sounds like you did a good amount of research on how perf script
> > > > > > > > works.  We can talk about the details in the meeting.
> > > > > > > > 
> > > > > > > > Thanks,
> > > > > > > > Namhyung
> > > > > > > 
> > > 
> > > -- 
> > > 
> > > - Arnaldo

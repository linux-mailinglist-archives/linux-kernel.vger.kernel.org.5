Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2972676D755
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 21:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjHBTAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 15:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjHBTAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 15:00:01 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A63C3;
        Wed,  2 Aug 2023 12:00:00 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bbbbb77b38so1498345ad.3;
        Wed, 02 Aug 2023 12:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691002800; x=1691607600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wK/nsG+p1ZVeBh1KHC2T5H7Nze4MLELKiO/q+jiRasI=;
        b=SLwicSkhC9Icednrp6S3yyFO6DhJzZf2CsyG4EhAYHmZKY+KT1XdmDMYre6sg/9nXD
         MgSRimrmSU0q+QBy1mZlFZ/eT4x39OWBSuoO0qeZwHS0eUqreq2rDeRXME6M9pAJ5d2d
         JclRcB1udxKIsLRlyTZ8sODg6ik69CTg+/pVWov5MSTkOoBl02OX4sR/qmcPhZgCwM1c
         PVsr7Q4Y5oewfVhbF9R38x1THfJ1fnzEav8UfExTbYVE7xvfVnixjYBaWfRCwrlO4TCO
         ne+G0t8pLY7AL+PavCZLt5GYzTVXxUvzqbdaMUhjzDcnk+7jkatWkWIadp57Iw+MPTtZ
         kQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691002800; x=1691607600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wK/nsG+p1ZVeBh1KHC2T5H7Nze4MLELKiO/q+jiRasI=;
        b=TieCzPANLPB5tlY/37vVg+tJFdMAwdYiqE8fvO72iR+Gs/eoalTdRDYg7EAim3pRrw
         xrlCiJV+ER1Np+OPDBaJErZ73c+mPEZ99XUdjWX/NKQRZqOas15xlsAZDs01oxpFNbgl
         oS5LS0cAZYi5fVeCACZ4C/FWWGrfV7zSn2uulKZft9rlm6w019ouFUC8GkI42bFpN5qi
         nUzED94MOZ4Vzcyn+340x/r+h1xW/cUVDjX63xu96dwmzd0ie14kxnxdu/dpkVeum1Cs
         6F1MWCwetYi3n8dbDkTIfxkf3GJfWeP0uZlmicsdqXOuSe6f9ODXGVUWgyzCZCB93NJ9
         /ZTg==
X-Gm-Message-State: ABy/qLbg8pbu/Ly9+kEL4kw9O99OyDPhghUm7e6/OJ0hoa4Rzj4DSjCZ
        MQ1n+pmJs/weuSr/FwGMk0I=
X-Google-Smtp-Source: APBJJlEt2RJcmsvzveK84xRan/cpBdhSiDdbM7jqA4Nvz/7gHi+9jxaxSLpECtPWi8kWbGC2HC3X2Q==
X-Received: by 2002:a17:902:7242:b0:1b5:532e:33b8 with SMTP id c2-20020a170902724200b001b5532e33b8mr13524790pll.35.1691002799585;
        Wed, 02 Aug 2023 11:59:59 -0700 (PDT)
Received: from yoga ([2400:1f00:13:9882:cd17:239a:4f43:dc90])
        by smtp.gmail.com with ESMTPSA id iy15-20020a170903130f00b001b801044466sm12823093plb.114.2023.08.02.11.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 11:59:58 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Thu, 3 Aug 2023 00:29:51 +0530
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Anup Sharma <anupnewsmail@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Adding Support for Firefox's Gecko Profile Format
Message-ID: <ZMqnp1kBv1ACIiGS@yoga>
References: <ZIHPXV5/ZopqcSSc@yoga>
 <ZIofrGKElc3nkNk0@yoga>
 <CAP-5=fV9tXNpYHH9DW0cVbRoFLGvG9SNn-MUhuyKuVBRuDqjoA@mail.gmail.com>
 <ZJyT8bt0LFLw6hKV@yoga>
 <CAM9d7ch7TdagV+dzj6MCp4fY15Vc4oGJjKAoQDyc=BXqy7qi+A@mail.gmail.com>
 <287bf3c8-fa0e-8c36-df14-7d728c63c265@intel.com>
 <ZKQu00bJZwO+Fc6m@yoga>
 <ZKRcTqAsKxF/Q3fQ@yoga>
 <ZMFgIekihhoGFBpn@yoga>
 <ZMFyi5S4JlFeZ/9c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMFyi5S4JlFeZ/9c@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 04:22:51PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jul 26, 2023 at 11:34:17PM +0530, Anup Sharma escreveu:
> > Dear all,
> > 
> > I want to share a recent development in our project that
> > I have been working on this week. I have successfully
> > implemented a new feature that allows users to directly
> > open the browser and visualize the output of perf.data
> > on Firefox Profiler.
> 
> Excellent news!
>  
> > To enhance user experience, I have made sure this option
> > is enabled by default. Additionally, I've also added a
> > handy command line argument, "--save-only," which allows
> > users to save the output file as needed. This enhancement
> > replaces the previous standard output method, providing a
> > much-improved experience.
> > 
> > Moreover, Everything is processed locally, and no data is
> > sent to any server.
> 
> That addresses the worry about sending possibly sensitive data over the
> network by default, great.
>  
> > During this implementation, I had the opportunity to delve
> > into several exciting topics, including threading, HTTP server,
> > and CORS mechanisms. The learning process has been both
> > challenging and rewarding.
> 
> Cool that you're so excited learning all this.
>  
> > Currently, I am in the process of performing some clean-up tasks.
> > Once that is complete, I will be sharing the next version of the
> > series, which includes this fantastic new feature, with all of
> > you very soon.
> > 
> > Thank you for your ongoing support and encouragement.
> 
> Keep it up!

This week, I'm working on documenting the gecko converter for our wiki.
I've dedicated a significant amount of time to think about the content
and how to approach it. So far, I've written sections covering the
introduction to Firefox Profiler and the formatting guidelines(not
published yet).

However, I've left the usage part blank because I'm uncertain about how
to enable gecko.py arguments when executing the "perf script gecko" command.
I've looked at examples like flamegraph-report and sctop-report, but I'm
still confused. I attempted to enable the script to take the gecko.py
command example "perf script report gecko --save-only=profiler.json,"
but this caused issues when running "perf script gecko -a sleep 3" again.
This has left me feeling rather puzzled, and I would appreciate discussing
this during our office hour, or any help here.

Due to this blocker, I haven't been able to send the updated patch
for test_gecko yet. However, I hope I'll find a solution soon and overcome
this obstacle.

> - Arnaldo
> 
> > Thanks,
> > Anup
> > 
> > > > Regards,
> > > > Anup
> > > > > > 
> > > > > >>
> > > > > >> The second challenge revolved around the usage of event hooks provided with the perf script
> > > > > >> python event handlers. I found myself deliberating between two approaches. The first
> > > > > >> approach involved creating custom functions that would be called using the event
> > > > > >> handlers. These functions would then save the data in an organized format within
> > > > > >> globally created data structures. The alternative approach was to write the entire
> > > > > >> logic inside the event handlers themselves.
> > > > > >>
> > > > > >> Additionally, I contemplated whether it would be more suitable to handle the creation of
> > > > > >> a Gecko format for JSON and the profile format within the same script or to separate
> > > > > >> them into different scripts.
> > > > > >>
> > > > > >> I will discuss this points during tomorrow's office hour.
> > > > > >>
> > > > > >> However, I have gained a deeper understanding of the problem at hand and will use this
> > > > > >> knowledge to make more informed decisions and progress more effectively in the coming weeks.
> > > > > > 
> > > > > > Sounds like you did a good amount of research on how perf script
> > > > > > works.  We can talk about the details in the meeting.
> > > > > > 
> > > > > > Thanks,
> > > > > > Namhyung
> > > > > 
> 
> -- 
> 
> - Arnaldo

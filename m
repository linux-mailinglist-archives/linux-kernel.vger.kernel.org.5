Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5850875FA75
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjGXPLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjGXPLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:11:15 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7EF10CE
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 08:11:14 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-76ae5b44426so193985485a.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 08:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690211473; x=1690816273;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9jHLHGvMvxYr4nt1BaNxAR/8eH1fxSS05ogGAzD554c=;
        b=5H5qoia/YCAThHL4tL1FBWzptpsIAsUlPFP+JsHr2dIKRN1bZ3X8b5hbmiozX3Hjp7
         L1O/Z3NDSEeCNdcnjIfiaHtRGuseUTrpR1ipIRSWO0N7Ta7nYAGbsIT0SFmaSyumT8jG
         JqxEdAk6WIvVBfbR02BWAU1k/wjOj3cOUfUgRWeugwFNY0qDl+W2Tvl8pA1P10g4ssbj
         WEtzD2s0fxkzmh3deWnnvupfgH1AhuckGrbpAJw4rlAGZlWgKFGTQnOkuySSo4s6jOF+
         2Jn4QddvJMA0fgJUs7lBnJ4EMoyL92unDt/bFMlUBu4zRno7Uanh/L8s1L/VMRuD2itn
         RMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690211473; x=1690816273;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9jHLHGvMvxYr4nt1BaNxAR/8eH1fxSS05ogGAzD554c=;
        b=PRyk5+gEcirZ8e738e+rEbRzCVEIQ+cFsmukZdh8k+1gJSDGdc5jUR+FLYDs7ptfPe
         BydfE8o7CcSZHZDhN6xGDHxE0aWiRLW/Sb5CwVc/tpquaIlzBuUelut6InkJAKt8k7lk
         2Kne/OHZMuPvP6rFP76vP/odDDwkckawmUWJtSO8V4fC9TWRMy8CtGuhK+wjjdseVp30
         T0mU45Fwa9xEPrTHQ4nx/fitsuvj/w1wmSQBD5RWyYl7z7ro51fshYqQMaoifANAZiMM
         Lyu9e45/H4HyaaidHQlLdrA/qLYPzaN8gjmUc0nBh6ASEgj1xfDjIHDB9wyLbMfhnHjS
         A9TA==
X-Gm-Message-State: ABy/qLaXRJoggMyrBbAGbIhGaqTf+h5U+WNbEMoDElA/0iTo0zQI5UG+
        KpYYcipNj656oq3B8eKejAWRmA==
X-Google-Smtp-Source: APBJJlFFHXH/+LGEPJpqtFuaBMrabrPuHbxjrUl8Ip7uKk3unQpUdzH/+9V33TtYVrX78fV2kYevBg==
X-Received: by 2002:a05:620a:1724:b0:768:1e00:76c4 with SMTP id az36-20020a05620a172400b007681e0076c4mr13167qkb.51.1690211473332;
        Mon, 24 Jul 2023 08:11:13 -0700 (PDT)
Received: from [192.168.1.31] (d-65-175-157-166.nh.cpe.atlanticbb.net. [65.175.157.166])
        by smtp.gmail.com with ESMTPSA id y24-20020a37e318000000b00767d7fa3d05sm2993144qki.136.2023.07.24.08.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 08:11:12 -0700 (PDT)
Message-ID: <2bef1006-3798-3fbe-87ad-4adfaee08cc0@google.com>
Date:   Mon, 24 Jul 2023 11:11:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCHSET v4] sched: Implement BPF extensible scheduler class
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, pjt@google.com, derkling@google.com,
        haoluo@google.com, dvernet@meta.com, dschatzberg@meta.com,
        dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
References: <20230711011412.100319-1-tj@kernel.org>
 <ZLrQdTvzbmi5XFeq@slm.duckdns.org>
From:   Barret Rhoden <brho@google.com>
In-Reply-To: <ZLrQdTvzbmi5XFeq@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.7 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

On 7/21/23 14:37, Tejun Heo wrote:
> Hello,
> 
> It's been more than half a year since the initial posting of the patchset
> and we are now at the fourth iteration. There have been some reviews around
> specifics (should be all addressed now except for the ones Andrea raised on
> this iteration) but none at high level. There also were some in-person and
> off-list discussions. Some, I believe, are addressed by the cover letter but
> it'd be nonetheless useful to delve into them on-list.
> 
> On our side, we've been diligently experimenting. 

On the google side, we're still experimenting and developing schedulers 
based on ghost, which we think we can port over to sched_ext.

Specifically, I've been working on a framework to write multicore 
schedulers in BPF called 'Flux'.  The idea in brief is to compose a 
scheduler as a hierarchy of "subschedulers", where cpus allocations go 
up and down the tree.

Flux is open-source, but it needs the ghost kernel and our BPF 
extensions currently (which are also open source, but harder to use for 
people).  I'll send a proposal to talk about it at LPC in case people 
are interested - if not the scheduler framework itself, then as a "this 
is some crazy stuff people can do with BPF".

As far as results go, I wrote a custom scheduler with Flux for our 
Search app and have been testing it on our single-leaf loadtester.  The 
initial results out of the box were pretty great: 17% QPS increase, 43% 
p99 decrease (default settings for the loadtester).  But the loadtester 
varies a bit, so it's hard to get reliable numbers out of it for an A/B 
comparison of schedulers.  Overall, we run equal or better than CFS.  I 
did a sweep across various offered loads, and we got 5% better QPS on 
average, 30% better p99 latency, 6% lower utilization.  The better 
numbers come under higher load, as you'd expect, when there are more 
threads competing for the cpu.

The big caveat to those numbers is the single-leaf loadtester isn't a 
representative test.  It's more of a microbenchmark.  Our next step is 
to run a full cluster load test, which will give us a better signal.

Anyway, this scheduler is highly specific to our app, including shared 
memory regions where the app's threads can tell us stuff like RPC 
deadlines.  It's the sort of thing you could only reasonably do with a 
pluggable scheduler like sched_ext or ghost.


> We are comfortable with the current API. Everything we tried fit pretty
> well. It will continue to evolve but sched_ext now seems mature enough for
> initial inclusion. I suppose lack of response doesn't indicate tacit
> agreement from everyone, so what are you guys all thinking?

Btw, I backported your patchset to our "franken-kernel".  I was able to 
boot it on one of our nodes, and run the search loadtest on CFS. 
Nothing broke, performance was the same, etc.  Not a huge surprise, 
since I didn't turn on sched_ext.  I haven't been able to get a 
sched_ext scheduler to work yet with our kernel - there's more patch 
backporting needed for your schedulers themselves (the bpf_for iterators 
and whatnot).  I'll report back if/when I can get it running.

Thanks,

Barret



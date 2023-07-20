Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC91075B805
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjGTTcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbjGTTck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:32:40 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB1419A6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:32:38 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-40544d92632so4069181cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689881557; x=1690486357;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zWhwuO2Me2HmK8/saXTSzM5wYXByZMsVez1QS7juqfo=;
        b=e+nt62Bh5ZofrXCZ9bP/gLnuiNloOpMWtvA4dbflLB24Enl5gt0h6pur+PdY9nJNT8
         8KZI6n+U8KkOcRbQIVOmI4YkS5Gc6bojyjiuOmhxUe3olsgwJKmPf4tRlPogOyypEJx9
         hylKQboYNHhMq8uJIJOyQg7h1QeXp98nBK2Bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689881557; x=1690486357;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zWhwuO2Me2HmK8/saXTSzM5wYXByZMsVez1QS7juqfo=;
        b=FrpzlaWQpx5VafaZ1cOftHtXez1brUNhTdp9Ozcau8F/iH1kGF7j2fHpQ7Z8owe4H5
         AcXVSJVGHOQLn6VY/+eB3dgYC0I3R6ECg38GdecWTaRUi4y84V2ZK8lfo8HE8rafTbQs
         uyggp8uqNGzFRuSRb2L5voo9arL4SJ8r7mhixdPFMChqDO1w1rGktX010h/2kFpEAUbR
         NPumevw2RfIju4fm76uQhdTYc5ERd4OZNVszVkgzCF7XhF+G6RNHr/+eKDDE5vV8JXRS
         BBFyE0+aKj8HgKLx1ZJilzM1Y9TQTQz8vKMQ34XO2auqxTJswBBuFsgsD5enISDwbCvG
         Q96A==
X-Gm-Message-State: ABy/qLboa2CUVUDKc1687HCJvhqelbX1Y5IdQyhNiK9KMnLAFDuVZ3eh
        GuV8rtCBeOTXRbPO4K4pjHt6sQ==
X-Google-Smtp-Source: APBJJlEo+6BmEpxWjJfZHMnOZBxlZOJy0JXfy7Enc3/Bc+jVOdN2rTapd2ltYQx6HIlpsiz0lV3iYw==
X-Received: by 2002:a05:622a:64c:b0:3ff:2cce:c625 with SMTP id a12-20020a05622a064c00b003ff2ccec625mr6081078qtb.19.1689881557534;
        Thu, 20 Jul 2023 12:32:37 -0700 (PDT)
Received: from [192.168.0.140] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id d3-20020ac81183000000b00402364e77dcsm659334qtj.7.2023.07.20.12.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 12:32:36 -0700 (PDT)
Message-ID: <8682b08c-347b-5547-60e0-013dcf1f8c93@joelfernandes.org>
Date:   Thu, 20 Jul 2023 15:32:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [BUG] Re: Linux 6.4.4
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        jslaby@suse.cz, rcu@vger.kernel.org
References: <2023071940-suspect-ominous-4a6a@gregkh>
 <20230720132714.GA3726096@google.com>
 <2b8fc10b-785e-48b9-9a38-5c1af81f9578@paulmck-laptop>
 <CAEXW_YQO7OCdkXm_SBcPhAm8V8vMaF_5DQq7PbG9PZb7RFgA_g@mail.gmail.com>
 <f18e165c-9196-4b41-a202-82cfd5ac7f8b@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <f18e165c-9196-4b41-a202-82cfd5ac7f8b@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/23 15:04, Paul E. McKenney wrote:
 > On Thu, Jul 20, 2023 at 12:31:13PM -0400, Joel Fernandes wrote:
 >> Hi Paul,
 >>
 >> On Thu, Jul 20, 2023 at 11:55 AM Paul E. McKenney <paulmck@kernel.org> wrote:
 >>>
 >>> On Thu, Jul 20, 2023 at 01:27:14PM +0000, Joel Fernandes wrote:
[...]
 >>>>
 >>>> So likely RCU boosting is failing:
 >>>>
 >>>> The full TREE03 splat:
 >>>> [   54.243588] ------------[ cut here ]------------
 >>>> [   54.244547] rcu-torture: rcu_torture_boost started
[...]
 >>>> [   54.300499] RIP: 0010:rcu_torture_stats_print+0x5b2/0x620
[...]
 >>>> [ 2169.481783] rcu_torture_writer: rtort_pipe_count: 9
 >>>>
 >>>> However, if we are to believe the '9', it appears the object did made it
 >>>> quite some till the end of the pipe array but not until the free pool.
 >>>
 >>> This is from this if/for statement, correct?
 >>>
 >>>                  stutter_waited = stutter_wait("rcu_torture_writer");
 >>>                  if (stutter_waited &&
 >>>                      !atomic_read(&rcu_fwd_cb_nodelay) &&
 >>>                      !cur_ops->slow_gps &&
 >>>                      !torture_must_stop() &&
 >>>                      boot_ended)
 >>>                          for (i = 0; i < ARRAY_SIZE(rcu_tortures); i++)
 >>>                                  if (list_empty(&rcu_tortures[i].rtort_free) &&
 >>>                                      rcu_access_pointer(rcu_torture_current) !=
 >>>                                      &rcu_tortures[i]) {
 >>>                                          tracing_off();
 >>>                                          show_rcu_gp_kthreads();
 >>>                                          WARN(1, "%s: rtort_pipe_count:
 >>>                                          rcu_ftrace_dump(DUMP_ALL);
 >>>                                  }
 >>
 >> Yes, that's right.
 >>
 >>> If so, this happens when there was a stutter wait, but RCU grace
 >>> periods failed to clear out the backlog during the several seconds that
 >>> rcutorture was forced idle.  This might be related to the RCU priority
 >>> boosting failure, in which a preempted reader persisted across the
 >>> stutter interval.
 >>
 >> When RCU is operating normally, shouldn't the check
 >> "(list_empty(&rcu_tortures[i].rtort_free)" not run until the preempted
 >> reader unblocks and exits its RCU read-side critical section?
 >
 > Yes, but not just "until", but rather "long after".  If RCU is doing
 > grace periods correctly, an active reader on a given rcu_tortures[]
 > element will prevent .rtort_pipe_count from exceeding the value 2.

Ah ok, so the rtort_pipe_count being 9 is a sign RCU isn't making progress thus 
making it absent from the free list.

 >
 > The element will not be put on a list until .rtort_pipe_count is equal
 > to RCU_TORTURE_PIPE_LEN, which is 10.
 >
 > This warning usually appears when something is holding up the grace-period
 > kthread.  Historically, this has included deadlocks, missed timers,
 > and whatever else can prevent the grace-period kthread from running.

Makes sense.

 >> One thing that confuses me, in the case of
 >> "cur_ops->deferred_free(old_rp);" , the earlier do-while loop may exit
 >> before the async callbacks can finish. So what prevents the
 >> "(list_empty(&rcu_tortures[i].rtort_free)" check from happening before
 >> grace periods happen? Thanks for any clarification.
 >
 > We only enter this code if the stutter_wait() actually waited, and by
 > default this function will wait about five seconds.  Since the rcutorture
 > testing goes idle during this time period (or is supposed to!), if things
 > are working properly, knocking off ten grace periods during that time
 > should be pretty much a given.

Sure, makes sense. And this is not Lazy-RCU so 5 seconds should be plenty ;). I 
think I was subconsciously expecting an rcu_barrier() somewhere in the code 
before those checks, but that's not needed as you pointed that the stutter 
should be giving enough time for RCU to make progress.

So hmm, the count being 9 means that not enough RCU grace periods have passed 
for the rcu_torture object in question thus keeping it always allocated. The GP 
thread not getting CPU can do that indeed, or perhaps something else stalling 
RCU like a preempted reader, length preemption disabling on a CPU and so forth.. 
  I'll try to collect a trace when it happens.

thanks,

  - Joel

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986A878E77C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242627AbjHaIBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 04:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjHaIBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:01:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D002A4;
        Thu, 31 Aug 2023 01:01:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4641FB8214E;
        Thu, 31 Aug 2023 08:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A84EC433C7;
        Thu, 31 Aug 2023 07:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693468858;
        bh=bjOBnN5cuaqL4BPOfU9w7ettZB2fL/iGFa3BBWRvIeQ=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=fUzA/orkD5oTBNPo8NuZmzn2EGr1G/jgtVX/Il5yIja4v8V90CXpnM9+NpwKnWdYw
         UZV0Ser/hd6UBvDG1TdvDNZH17m8WQjVA3tXLuK44j0OZUl2NYvuZFtEC0B97vPKBW
         dW12XUOD8IB+y7vjF2MjnQ5rOgy3scO28TXQjXmXu6JiqURsTHiwoaFF8Lr31b1CL8
         wL1NiPNy50twyPvJmlgxylAG05M8Hp2o0gYHNybet7hAoi9xHPucQrCO112KL5jp/w
         xaBfyX7IWigxKGZeMNglTBIKNCbuvYGDdKeQSiIUUwoZkd7KAhtAWxQfuyGJY5ZdZm
         dSYK772a6qwHQ==
Message-ID: <557b4345-3cdd-6099-5bdc-d546a44d7ddd@kernel.org>
Date:   Thu, 31 Aug 2023 09:59:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [ANNOUNCEMENT] CFP: Real-time and Scheduling MC at LPC
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Abel Wu <wuyun.abel@bytedance.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Hao Jia <jiahao.os@bytedance.com>,
        Huaixin Chang <changhuaixin@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josh Don <joshdon@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Odin Ugedal <odin@uged.al>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Peng Wang <rocking@linux.alibaba.com>,
        Phil Auld <pauld@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>, Qian Cai <cai@lca.pw>,
        Quentin Perret <qperret@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Suren Baghdasaryan <surenb@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Zhen Ni <nizhen@uniontech.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>,
        John Stultz <jstultz@google.com>,
        David Vernet <void@manifault.com>,
        Vlastimil Babka <vbabka@suse.cz>, Chris Mason <clm@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        John Kacur <jkacur@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
        Kate Carcia <kcarcia@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Min Yu <myu@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        =?UTF-8?Q?Luis_Claudio_R=2e_Gon=c3=a7alves?= <lclaudio@redhat.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Mark Brown <mark.brown@linaro.org>,
        joseph.salisbury@canonical.com,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Guenter Roeck <linux@roeck-us.net>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <d6113bec-6591-2efc-2255-66867e5db899@kernel.org>
 <c53cb40d-86c2-0325-4103-af135fd0e680@kernel.org>
Content-Language: en-US, pt-BR, it-IT
In-Reply-To: <c53cb40d-86c2-0325-4103-af135fd0e680@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/23 17:57, Daniel Bristot de Oliveira wrote:
> Hello
> 
> This is a gentle reminder about RT and SCHED MC. We will have to send the
> schedule on the next weeks. Please, submit your topic ASAP.

Last call: we will close the CPF on Sept 4th.

Thanks!

-- Daniel

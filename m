Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB9A76EEF6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbjHCQDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbjHCQDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:03:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9163DF0
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 09:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691078587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sy/pMcIe0FGwi3bcJkSKyZOI5YwKdeEf2lhviH4RpPs=;
        b=BEdcO0flMxhCPI1qKZMBPfLWuEM8GpRdwvhqTu95u8zXhFlvVuKqjNEcqJ8n3c2juPbVVr
        RmGxUs+SFIxxYi0YZfGDFYcEDCqwJNbyF2qOTnP6dzIhnPe2XsVqGSW0nt+Lbw0davcD2X
        lQRuz5SpF0usSxOuyFJosWwtcYKOmVU=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-GVusM_KNO2mJ-jwttlKWlg-1; Thu, 03 Aug 2023 12:03:04 -0400
X-MC-Unique: GVusM_KNO2mJ-jwttlKWlg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6348A1C05B02;
        Thu,  3 Aug 2023 16:03:01 +0000 (UTC)
Received: from [10.22.17.81] (unknown [10.22.17.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 70F68C5796C;
        Thu,  3 Aug 2023 16:03:00 +0000 (UTC)
Message-ID: <e603b6cc-35ee-f22e-ba50-73bd5caefa20@redhat.com>
Date:   Thu, 3 Aug 2023 12:03:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] sched/core: Use empty mask to reset cpumasks in
 sched_setaffinity()
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, aubrey.li@linux.intel.com,
        yu.c.chen@intel.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>
References: <202307251613.4f2de1be-oliver.sang@intel.com>
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <202307251613.4f2de1be-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/25/23 09:07, kernel test robot wrote:
>
> Hello,
>
> kernel test robot noticed "kernel-selftests.vDSO.vdso_test_correctness.fail" on:
>
> commit: 8bd21fae1e37284f0f78fa42fb4d20a6cadfa68a ("[PATCH v2] sched/core: Use empty mask to reset cpumasks in sched_setaffinity()")
> url: https://github.com/intel-lab-lkp/linux/commits/Waiman-Long/sched-core-Use-empty-mask-to-reset-cpumasks-in-sched_setaffinity/20230718-194823
> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 2ae2fb98b77339277a2c2f18dfec605dfd8dd321
> patch link: https://lore.kernel.org/all/20230717180243.3607603-1-longman@redhat.com/
> patch subject: [PATCH v2] sched/core: Use empty mask to reset cpumasks in sched_setaffinity()
>
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-60acb023-1_20230329
> with following parameters:
>
> 	group: group-03
>
>
>
> compiler: gcc-12
> test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> # [OK]	CPU 34: syscall: cpu 34, node 0 vdso: cpu 34, node 0 vsyscall: cpu 34, node 0
> # [OK]	CPU 35: syscall: cpu 35, node 0 vdso: cpu 35, node 0 vsyscall: cpu 35, node 0
> # [FAIL]	CPU 36: syscall: cpu 35, node 0 vdso: cpu 35, node 0 vsyscall: cpu 35, node 0
> not ok 6 selftests: vDSO: vdso_test_correctness # exit=1

I have figured out what this fail. The vdso_test_correctness.c test 
calls sched_setaffinity() from cpu 0 and up until it hits an error 
return. There are 36 CPUs in the test system and once the CPU number hit 
36, the cpumask_empty() test in sched_setaffinity() returns true causing 
a non-error return.

It seems like I need to always return an error code to not break 
existing test program, but perhaps with a different error code to 
indicate some action is done.

Cheers,
Longman


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1049C7904BC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 04:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344632AbjIBCOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 22:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjIBCOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 22:14:33 -0400
X-Greylist: delayed 425 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Sep 2023 19:14:29 PDT
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A5610D4;
        Fri,  1 Sep 2023 19:14:29 -0700 (PDT)
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9D74428A7FA;
        Sat,  2 Sep 2023 02:07:26 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 14EC0240065;
        Sat,  2 Sep 2023 02:07:22 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.112.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id E9C3C13C2B0;
        Fri,  1 Sep 2023 19:07:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E9C3C13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1693620440;
        bh=bi6uwElLHhc456DM9ev5TQVN6E6OFpFw2o7Hsols/pw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dXeuGkGJM25J4DAeHUo5+h6fLueI5ECbTdm/l7y4m6DVysFinv42LsfE7jwfKM1OL
         bj8C9vwPjm78cJRKViYyp0BFxpXVsZn5gCT/2a5Urd/HA0GbQnmClz3JtD4Mb0m65S
         iHrt+aVaRC1s7XnkLuWmYiIJlvXcNN9rvKwbzNwc=
Subject: Re: Fwd: RCU indicates stalls with iwlwifi, causing boot failures
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Linux RCU <rcu@vger.kernel.org>
References: <c1caa7c1-b2c6-aac5-54ab-8bcc6e139ca8@gmail.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <c3f9b35c-087d-0e34-c251-e249f2c058d3@candelatech.com>
Date:   Fri, 1 Sep 2023 19:07:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <c1caa7c1-b2c6-aac5-54ab-8bcc6e139ca8@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1693620443-Y9iIohaJ-lN4
X-MDID-O: us5;ut7;1693620443;Y9iIohaJ-lN4;<greearb@candelatech.com>;b8d401048faafe507750f80ed9fd0903
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/23 5:29 PM, Bagas Sanjaya wrote:
> Hi,
> 
> I notice a bug report on Bugzilla [1]. Quoting from it:

Try booting with pcie=noaer ?

That fixes only known iwlwifi bug we have found in 6.5, but we are also using mostly
backports iwlwifi driver...

Thanks,
Ben

> 
>> I'm seeing RCU warnings in Linus's current tree (like 87dfd85c38923acd9517e8df4afc908565df0961) that come from RCU:
>>
>> WARNING: CPU: 0 PID: 0 at kernel/rcu/tree_exp.h:787 rcu_exp_handler+0x35/0xe0
>>
>> But they *ONLY* occur on a system with a newer iwlwifi device:
>>
>> aa:00.0 Network controller: Intel Corporation Wi-Fi 6 AX210/AX211/AX411 160MHz (rev 1a)
>>
>> and never in a VM or on an older device (like an 8260).  During a bisect the only seem to occur with the "83" version of the firmware.
>>
>> iwlwifi 0000:aa:00.0: loaded firmware version 83.e8f84e98.0 ty-a0-gf-a0-83.ucode op_mode iwlmvm
>>
>> The first warning gets spit out within a millisecond of the last printk() from the iwlwifi driver.  They eventually result in a big spew of RCU messages like this:
>>
>> [   27.124796] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 0-...D } 125 jiffies s: 193 root: 0x1/.
>> [   27.126466] rcu: blocking rcu_node structures (internal RCU debug):
>> [   27.128114] Sending NMI from CPU 3 to CPUs 0:
>> [   27.128122] NMI backtrace for cpu 0 skipped: idling at intel_idle+0x5f/0xb0
>> [   27.159757] loop30: detected capacity change from 0 to 8
>> [   27.204967] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 0-...D } 145 jiffies s: 193 root: 0x1/.
>> [   27.206353] rcu: blocking rcu_node structures (internal RCU debug):
>> [   27.207751] Sending NMI from CPU 3 to CPUs 0:
>> [   27.207825] NMI backtrace for cpu 0 skipped: idling at intel_idle+0x5f/0xb0
>>
>> I usually see them at boot.  In that case, they usually hang the system and keep it from booting.  I've also encountered them at reboots and also seen them *not* be fatal at boot.  I suspect it has to do with which CPU gets wedged.
> 
> See Bugzilla for the full thread and attached full dmesg output.
> 
> Thanks.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217856
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

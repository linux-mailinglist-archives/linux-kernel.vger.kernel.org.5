Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45E07C0036
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjJJPR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjJJPRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:17:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86596AC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=dSk/VYDGR41QItV5uWbRElIWyH6SvVf0iChQztJlGUM=; b=Eg/TlMx837jb09FlmJ6DqI6mf4
        JiZ7HF31mxoYBAZlwM7Fh/03T7AZ3u8QFGdtIkkpcd4p3ORbKlQSQdDZPRTG+wkd9esTCJQ8JVjH9
        bJcyjcjoJI1b2v98tSOnwnFDi5uZbbXDx+si7bdMZ/zCG0AmXyPjCuf/0d3Fw3rA+vdATn4wCz1H1
        AU4QX72WGXmdHpiHTR+6B/FYvg8088dMXn2H0jwmErTD5u7+AmsrxwNV8MfUq33ers8VaieSD5Qx2
        G9+tvbEwFnnjy0zc4UwdQkzk1gday2YuGF+L6v4QmDY1Q4UREZv6k4B34tiQT6bKZIhwgRrfNIDLi
        LJ9sXVBQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qqEU4-00DfVZ-1B;
        Tue, 10 Oct 2023 15:17:20 +0000
Message-ID: <c43b1da4-b377-4dcb-93cb-ca14137a93ae@infradead.org>
Date:   Tue, 10 Oct 2023 08:17:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/intel_rdt/cqm: fix kernel-doc warnings
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
References: <20231006235132.16227-1-rdunlap@infradead.org>
 <5589e93d-9a9c-4199-a187-ab60fb127236@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <5589e93d-9a9c-4199-a187-ab60fb127236@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/9/23 10:07, Reinette Chatre wrote:
> Hi Randy,
> 
> Thank you very much for noticing the bug report and taking the time
> to fix it.
> 
> To match the custom of this area, could you please modify
> the subject to be:
> 	x86/resctrl: Fix kernel-doc warnings
> 
> On 10/6/2023 4:51 PM, Randy Dunlap wrote:
>> The kernel test robot reported kernel-doc warnings here:
>>
>> monitor.c:34: warning: Cannot understand  * @rmid_free_lru    A least recently used list of free RMIDs
>>  on line 34 - I thought it was a doc line
>> monitor.c:41: warning: Cannot understand  * @rmid_limbo_count     count of currently unused but (potentially)
>>  on line 41 - I thought it was a doc line
>> monitor.c:50: warning: Cannot understand  * @rmid_entry - The entry in the limbo and free lists.
>>  on line 50 - I thought it was a doc line
>>
>> We don't have a syntax for documenting individual data items via
>> kernel-doc, so remove the "/**" kernel-doc markers and add a hyphen
>> for consistency.
>>
>> Fixes: 6a445edce657 ("x86/intel_rdt/cqm: Add RDT monitoring initialization")
>> Fixes: 24247aeeabe9 ("x86/intel_rdt/cqm: Improve limbo list processing")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
> 
> Could you please swap the above two tags to follow the tag ordering
> custom followed by the tip maintainers? For reference you can find the
> details in section "Ordering of commit tags" of 
> Documentation/process/maintainer-tip.rst
> 
> Also, below the "Link:" follows the "Cc:".
> 
>> Link: https://lore.kernel.org/all/202310062356.lX3xpLP9-lkp@intel.com/
>> Cc: Vikas Shivappa <vikas.shivappa@linux.intel.com>
>> Cc: Tony Luck <tony.luck@intel.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Fenghua Yu <fenghua.yu@intel.com>
>> Cc: Reinette Chatre <reinette.chatre@intel.com>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: x86@kernel.org
>> ---
>> Not using Closes: since this patch only addresses some of the issues
>>   reported.

Hi Ingo,

Since you have already committed this patch, how would you like to handle
these requested changes?

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     025d5ac978cc3b47874cc1c03ab096a78b49f278
Gitweb:        https://git.kernel.org/tip/025d5ac978cc3b47874cc1c03ab096a78b49f278
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Fri, 06 Oct 2023 16:51:32 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 08 Oct 2023 11:45:16 +02:00

x86/resctrl: Fix kernel-doc warnings



Thanks.

> I am aware of these issues. The person working on this previously
> seems to have moved on. I'll share this work with folks looking for
> this type of opportunity and ensure that it is completed this time.
>  
>>  arch/x86/kernel/cpu/resctrl/monitor.c |   10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff -- a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -30,15 +30,15 @@ struct rmid_entry {
>>  	struct list_head		list;
>>  };
>>  
>> -/**
>> - * @rmid_free_lru    A least recently used list of free RMIDs
>> +/*
>> + * @rmid_free_lru - A least recently used list of free RMIDs
>>   *     These RMIDs are guaranteed to have an occupancy less than the
>>   *     threshold occupancy
>>   */
>>  static LIST_HEAD(rmid_free_lru);
>>  
>> -/**
>> - * @rmid_limbo_count     count of currently unused but (potentially)
>> +/*
>> + * @rmid_limbo_count - count of currently unused but (potentially)
>>   *     dirty RMIDs.
>>   *     This counts RMIDs that no one is currently using but that
>>   *     may have a occupancy value > resctrl_rmid_realloc_threshold. User can
>> @@ -46,7 +46,7 @@ static LIST_HEAD(rmid_free_lru);
>>   */
>>  static unsigned int rmid_limbo_count;
>>  
>> -/**
>> +/*
>>   * @rmid_entry - The entry in the limbo and free lists.
>>   */
>>  static struct rmid_entry	*rmid_ptrs;
> 
> Thank you very much.
> 
> I just have the comments regarding this area's customs. With that
> addressed:
> 
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> 
> Reinette

-- 
~Randy

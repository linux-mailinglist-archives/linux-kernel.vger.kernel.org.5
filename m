Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990F0752F78
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 04:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbjGNChz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 22:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjGNChy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 22:37:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF87F2121
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 19:37:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85EEF1570;
        Thu, 13 Jul 2023 19:38:33 -0700 (PDT)
Received: from [10.163.47.78] (unknown [10.163.47.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 858723F67D;
        Thu, 13 Jul 2023 19:37:44 -0700 (PDT)
Message-ID: <713a99fe-8c43-b416-a574-db235705693d@arm.com>
Date:   Fri, 14 Jul 2023 08:07:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] mm: remove some useless comments of node_stat_item
To:     Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230713114915.74671-1-linmiaohe@huawei.com>
 <ZK/ppvBO00rbspa8@casper.infradead.org>
 <55c255df-9c7c-744f-e1a1-27602fcb5509@huawei.com>
 <ZK/uukqNMQYyyNif@casper.infradead.org>
Content-Language: en-US
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZK/uukqNMQYyyNif@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/13/23 18:01, Matthew Wilcox wrote:
> On Thu, Jul 13, 2023 at 08:18:29PM +0800, Miaohe Lin wrote:
>> On 2023/7/13 20:10, Matthew Wilcox wrote:
>>> On Thu, Jul 13, 2023 at 07:49:15PM +0800, Miaohe Lin wrote:
>>>> Some comments of node_stat_item are not that helpful and even confusing,
>>>> so remove them. No functional change intended.
>>>
>>> No, that's very useful and important.  Why does it confuse you?
>>
>> Thanks for your quick respond.
>>
>> I just can't figure out what these comments want to tell. Could you help explain these?
> 
> Don't snip the thing you want explained to you!
> 
>         NR_INACTIVE_ANON = NR_LRU_BASE, /* must match order of LRU_[IN]ACTIVE */
> -       NR_ACTIVE_ANON,         /*  "     "     "   "       "         */
> -       NR_INACTIVE_FILE,       /*  "     "     "   "       "         */
> -       NR_ACTIVE_FILE,         /*  "     "     "   "       "         */
> -       NR_UNEVICTABLE,         /*  "     "     "   "       "         */
> +	NR_ACTIVE_ANON,
> +       NR_INACTIVE_FILE,
> +       NR_ACTIVE_FILE,
> +	NR_UNEVICTABLE,
> 
> What this is communicating to me is that these five items
> (NR_INACTIVE_ANON to NR_UNEVICTABLE) must stay in the same order with
> LRU_INACTIVE and LRU_ACTIVE.  By removing the ditto-marks from the
> subsequent four lines, you've made the comment say that this one line
> must stay in the same order as LRU_INACTIVE and LRU_ACTIVE ... which
> makes no sense at all.

Just wondering - would it be better to repeat these comments in words for
each line than use "ditto-marks" ?

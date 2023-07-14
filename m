Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4E1752E92
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 03:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbjGNBgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 21:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjGNBgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 21:36:19 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EB02D48
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 18:36:18 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R2DYc4m6NzVjHn;
        Fri, 14 Jul 2023 09:35:00 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 09:36:15 +0800
Subject: Re: [PATCH] mm: remove some useless comments of node_stat_item
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20230713114915.74671-1-linmiaohe@huawei.com>
 <ZK/ppvBO00rbspa8@casper.infradead.org>
 <55c255df-9c7c-744f-e1a1-27602fcb5509@huawei.com>
 <ZK/uukqNMQYyyNif@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <d9efcca5-0448-2d0d-84e0-9af99f0c0701@huawei.com>
Date:   Fri, 14 Jul 2023 09:36:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ZK/uukqNMQYyyNif@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/13 20:31, Matthew Wilcox wrote:
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

I see. Many thanks for your kind explanation. :)



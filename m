Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12C47AD06C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbjIYGqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjIYGqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:46:11 -0400
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F08A9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 23:46:03 -0700 (PDT)
X-QQ-mid: bizesmtp76t1695624220t68d2x3u
Received: from [10.23.230.53] ( [121.46.247.130])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 25 Sep 2023 14:43:39 +0800 (CST)
X-QQ-SSF: 01400000000000101000000A0000000
X-QQ-FEAT: +ynUkgUhZJk84fOipIi/2HdQZgDrTnTIerD1SV/Lf/3gYa4TqxXz++evuB29B
        ZjbEjpNBNQA79wlcoPqcWMhudT348Ei1rNemso+PZ9DRuU1TwHG1AprAaR7Bq75F3JulbA+
        GH6LjCpAUdhfZtQJJjqE53EJGKl4aGd3EFLtvv349ITaGyosLv8+wkRj8M9bmYqcrBIr6DS
        3etcOoNwjgAsWoJEXeK8h6TIOaNXQI/2gwUdPIrqqLE3e+cOYIcodfnGadrpKQ3iLZLLT6h
        C1xaZs1tbjmQVv1ZqvouwZ0brFOUi28bbxD03OyDAcLIsG87gJjEq/LNZa5PDkw3uiJiGE8
        H5M8P6OEU62oD2FBbsByIJ15BKfNQi8or2Nmh/3lpfYz/vQouQ=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17299434549104365918
Message-ID: <9F7DFA20B598B0C4+7dc938b0-67f9-422a-8051-3a7c1fd7a6bf@ex.bilibili.com>
Date:   Mon, 25 Sep 2023 14:43:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] delayacct: add memory reclaim delay in
 get_page_from_freelist
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     bsingharora@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wangyun@bilibili.com
References: <181C946095F0252B+7cc60eca-1abf-4502-aad3-ffd8ef89d910@ex.bilibili.com>
 <20230920090711.ecc2d84cc29bb0fa540f1999@linux-foundation.org>
From:   liwenyu <wenyuli@ex.bilibili.com>
Organization: bilibili
In-Reply-To: <20230920090711.ecc2d84cc29bb0fa540f1999@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:ex.bilibili.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, 20 Sep 2023 17:38:49 +0800 liwenyu <wenyuli@ex.bilibili.com> wrote:
> 
>> The current memory reclaim delay statistics only count the direct memory
>> reclaim of the task in do_try_to_free_pages(). In systems with NUMA
>> open, some tasks occasionally experience slower response times, but the
>> total count of reclaim does not increase, using ftrace can show that
>> node_reclaim has occurred.
>>
>> The memory reclaim occurring in get_page_from_freelist() is also due to
>> heavy memory load. To get the impact of tasks in memory reclaim, this
>> patch adds the statistics of the memory reclaim delay statistics for
>> __node_reclaim().
> 
> Please review Documentation/accounting/delay-accounting.rst, see if
> there is some change we can make to reflect this patch.
> 
> Your email client is wordwrapping the patches - please check that for
> next time.
> 

There is no need to change the 
Documentation/accounting/delay-accounting.rst, because this patch is 
only an expansion of  memory reclaim delayacct.

Thanks!


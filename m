Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38AE7EC841
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjKOQPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKOQPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:15:23 -0500
X-Greylist: delayed 121098 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Nov 2023 08:15:18 PST
Received: from 3.mo584.mail-out.ovh.net (3.mo584.mail-out.ovh.net [46.105.57.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B371125
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:15:18 -0800 (PST)
Received: from director5.ghost.mail-out.ovh.net (unknown [10.109.156.29])
        by mo584.mail-out.ovh.net (Postfix) with ESMTP id AB9D325D78
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 16:05:32 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-k8mr2 (unknown [10.108.4.159])
        by director5.ghost.mail-out.ovh.net (Postfix) with ESMTPS id D06841FE53;
        Wed, 15 Nov 2023 16:05:31 +0000 (UTC)
Received: from RCM-web2.webmail.mail.ovh.net ([176.31.232.109])
        by ghost-submission-6684bf9d7b-k8mr2 with ESMTPSA
        id ayhHFUvsVGXUOSsAdDy9bg
        (envelope-from <jose.pekkarinen@foxhound.fi>); Wed, 15 Nov 2023 16:05:31 +0000
MIME-Version: 1.0
Date:   Wed, 15 Nov 2023 18:05:30 +0200
From:   =?UTF-8?Q?Jos=C3=A9_Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, skhan@linuxfoundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linux.dev,
        syzbot+89edd67979b52675ddec@syzkaller.appspotmail.com,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm/pgtable: return null if no ptl in
 __pte_offset_map_lock
In-Reply-To: <ZVTTbuviH9/RWYyI@casper.infradead.org>
References: <20231115065506.19780-1-jose.pekkarinen@foxhound.fi>
 <ZVTTbuviH9/RWYyI@casper.infradead.org>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <1c4cb1959829ecf4f0c59691d833618c@foxhound.fi>
X-Sender: jose.pekkarinen@foxhound.fi
Organization: Foxhound Ltd.
X-Originating-IP: 185.220.100.249
X-Webmail-UserID: jose.pekkarinen@foxhound.fi
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17026984294489761383
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudefiedgjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihoihgtgfesthekjhdttderjeenucfhrhhomheplfhoshorucfrvghkkhgrrhhinhgvnhcuoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqeenucggtffrrghtthgvrhhnpeekhfeguddufeegvdelgedtvdffgeehvddtkeevkeejvedvgeeitdefleehtdeitdenucfkphepuddvjedrtddrtddruddpudekhedrvddvtddruddttddrvdegledpudejiedrfedurddvfedvrddutdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkeegpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_00,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-15 16:19, Matthew Wilcox wrote:
> On Wed, Nov 15, 2023 at 08:55:05AM +0200, José Pekkarinen wrote:
>> Documentation of __pte_offset_map_lock suggest there is situations 
>> where
> 
> You should have cc'd Hugh who changed all this code recently.

     Hi,

     Sorry, he seems to be missing if I run get_maintainer.pl:

$ ./scripts/get_maintainer.pl include/linux/mm.h
Andrew Morton <akpm@linux-foundation.org> (maintainer:MEMORY MANAGEMENT)
linux-mm@kvack.org (open list:MEMORY MANAGEMENT)
linux-kernel@vger.kernel.org (open list)

>> a pmd may not have a corresponding page table, in which case it should
>> return NULL without changing ptlp. Syzbot found its ways to produce a
>> NULL dereference in the function showing this case. This patch will
>> provide the exit path suggested if this unlikely situation turns up. 
>> The
>> output of the kasan null-ptr-report follows:
> 
> There's no need to include all this nonsense in the changelog.

     No problem, we can clean the patch if we find there is something
worth upstreaming.

>>  spin_lock include/linux/spinlock.h:351 [inline]
>>  __pte_offset_map_lock+0x154/0x360 mm/pgtable-generic.c:373
>>  pte_offset_map_lock include/linux/mm.h:2939 [inline]
>>  filemap_map_pages+0x698/0x11f0 mm/filemap.c:3582
> 
> This was the only interesting part.
> 
>> +++ b/include/linux/mm.h
>> @@ -2854,7 +2854,7 @@ void ptlock_free(struct ptdesc *ptdesc);
>> 
>>  static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
>>  {
>> -	return ptdesc->ptl;
>> +	return (likely(ptdesc)) ? ptdesc->ptl : NULL;
>>  }
> 
> I don't think we should be changing ptlock_ptr().

     This is where the null ptr dereference originates, so the only
alternative I can think of is to protect the life cycle of the ptdesc
to prevent it to die between the pte check and the spin_unlock of
__pte_offset_map_lock. Would that work for you?

>> +++ b/mm/pgtable-generic.c
>> @@ -370,6 +370,8 @@ pte_t *__pte_offset_map_lock(struct mm_struct *mm, 
>> pmd_t *pmd,
>>  	if (unlikely(!pte))
>>  		return pte;
>>  	ptl = pte_lockptr(mm, &pmdval);
>> +	if (unlikely(!ptl))
>> +		return NULL;
>>  	spin_lock(ptl);
> 
> I don't understand how this could possibly solve the problem.  If 
> there's
> no PTE level, then __pte_offset_map() should return NULL and we'd 
> already
> return due to the check for !pte.

     I tested the syzbot reproducer in x86 and it doesn't produce this 
kasan
report anymore.

     José.

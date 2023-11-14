Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC997EB7BD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 21:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbjKNUYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 15:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbjKNUYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 15:24:48 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C3CF5;
        Tue, 14 Nov 2023 12:24:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6DDE8228DF;
        Tue, 14 Nov 2023 20:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1699993482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+6UsT5QFBZcpyy/zzlztYcwvUhTuQe2Zg+uDJvHRCAE=;
        b=i4CWqGKluSn4qThSyc1024Vn6mz9Zc2GzOkuYQR5nIl9eUlkbffodORTufrCMJX4fZKCRv
        uBZigWPm4PSUx7r7sG2uMldplM0Ap1pgKr3Itp+A4MfnisRGsYsxCSAG/lVNufaSDKIRc1
        Cyg1ze8Kw5BksiRZCocz/TcbQGOFi3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1699993482;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+6UsT5QFBZcpyy/zzlztYcwvUhTuQe2Zg+uDJvHRCAE=;
        b=0YXskOkWUbpLyZOFqFgJZowdI9cXHywXSe1Obfoz2GsBxS3cls19rMN6n/U3KN04OiwZVw
        WU7ihsnR38uaWWDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 18DD913460;
        Tue, 14 Nov 2023 20:24:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KmZUBYrXU2V2XgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 14 Nov 2023 20:24:42 +0000
Message-ID: <98380669-875b-3c85-006d-e3617b8fcaab@suse.cz>
Date:   Tue, 14 Nov 2023 21:24:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 11/20] mm/slab: consolidate includes in the internal
 mm/slab.h
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marco Elver <elver@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-33-vbabka@suse.cz> <202311132039.7CC758A@keescook>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <202311132039.7CC758A@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.60
X-Spamd-Result: default: False [-2.60 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         RCVD_TLS_ALL(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MID_RHS_MATCH_FROM(0.00)[];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         BAYES_HAM(-0.00)[10.02%];
         RCPT_COUNT_TWELVE(0.00)[23];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[google.com,linux.com,kernel.org,lge.com,linux-foundation.org,gmail.com,linux.dev,kvack.org,vger.kernel.org,lists.linux.dev,arm.com,cmpxchg.org,googlegroups.com];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/23 05:41, Kees Cook wrote:
> On Mon, Nov 13, 2023 at 08:13:52PM +0100, Vlastimil Babka wrote:
>> The #include's are scattered at several places of the file, but it does
>> not seem this is needed to prevent any include loops (anymore?) so
>> consolidate them at the top. Also move the misplaced kmem_cache_init()
>> declaration away from the top.
>> 
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  mm/slab.h | 28 ++++++++++++++--------------
>>  1 file changed, 14 insertions(+), 14 deletions(-)
>> 
>> diff --git a/mm/slab.h b/mm/slab.h
>> index 6e76216ac74e..c278f8b15251 100644
>> --- a/mm/slab.h
>> +++ b/mm/slab.h
>> @@ -1,10 +1,22 @@
>>  /* SPDX-License-Identifier: GPL-2.0 */
>>  #ifndef MM_SLAB_H
>>  #define MM_SLAB_H
>> +
>> +#include <linux/reciprocal_div.h>
>> +#include <linux/list_lru.h>
>> +#include <linux/local_lock.h>
>> +#include <linux/random.h>
>> +#include <linux/kobject.h>
>> +#include <linux/sched/mm.h>
>> +#include <linux/memcontrol.h>
>> +#include <linux/fault-inject.h>
>> +#include <linux/kmemleak.h>
>> +#include <linux/kfence.h>
>> +#include <linux/kasan.h>
> 
> I've seen kernel code style in other places ask that includes be
> organized alphabetically. Is the order here in this order for some
> particular reason?

Hm not aware of the alphabetical suggestion. I usually order by going from
more low-level and self-contained headers to the more complex ones that
transitively include more, so did that here as well but it's not a precise
process.

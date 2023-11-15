Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB677EB783
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 21:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbjKNULy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 15:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbjKNULw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 15:11:52 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B0F102;
        Tue, 14 Nov 2023 12:11:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 78AB920430;
        Tue, 14 Nov 2023 20:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1699992707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jx5LtWmsLR+LfLuIaijRwnFRntSIu1BC0epYmgHcaMQ=;
        b=QztLg3psAOKHMl6gbAEvrcxmmJo9FhUCQ7OhduKlUpTqKuKkwL0p419HwTadOkkN56LNhV
        DJqfitKLBKDYB0QuPtO139EwyaPKvgaI3qrvj6xusCkDEcJEkKF2x8owyoGrvIlxaiXXDj
        bSacZpf3Co3JzSWXWsvNVsuUJVChs38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1699992707;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jx5LtWmsLR+LfLuIaijRwnFRntSIu1BC0epYmgHcaMQ=;
        b=NcSJZK89lOQ0tthmCnON+iffFckuV9XsKXUSSHht9GT36OrnfM0rMyzOSDB1xtbq3MBssf
        +q6wb/FzUt4TsSDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F4A913460;
        Tue, 14 Nov 2023 20:11:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8LsfBoPUU2V+WAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 14 Nov 2023 20:11:47 +0000
Message-ID: <55a589d7-edcc-6db4-759d-c928577cba8b@suse.cz>
Date:   Tue, 14 Nov 2023 21:11:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 01/20] mm/slab: remove CONFIG_SLAB from all Kconfig and
 Makefile
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
 <20231113191340.17482-23-vbabka@suse.cz> <202311132009.8329C2F5D@keescook>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <202311132009.8329C2F5D@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.65
X-Spamd-Result: default: False [-2.65 / 50.00];
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
         BAYES_HAM(-0.05)[59.88%];
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

On 11/14/23 05:11, Kees Cook wrote:
> On Mon, Nov 13, 2023 at 08:13:42PM +0100, Vlastimil Babka wrote:
>> Remove CONFIG_SLAB, CONFIG_DEBUG_SLAB, CONFIG_SLAB_DEPRECATED and
>> everything in Kconfig files and mm/Makefile that depends on those. Since
>> SLUB is the only remaining allocator, remove the allocator choice, make
>> CONFIG_SLUB a "def_bool y" for now and remove all explicit dependencies
>> on SLUB as it's now always enabled.
>> 
>> Everything under #ifdef CONFIG_SLAB, and mm/slab.c is now dead code, all
>> code under #ifdef CONFIG_SLUB is now always compiled.
>> 
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> [...]
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 89971a894b60..766aa8f8e553 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -228,47 +228,12 @@ config ZSMALLOC_CHAIN_SIZE
>>  
>>  menu "SLAB allocator options"
> 
> Should this be "Slab allocator options" ? (I've always understood
> "slab" to mean the general idea, and "SLAB" to mean the particular
> implementation.

Good point, will change

> Regardless:
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!


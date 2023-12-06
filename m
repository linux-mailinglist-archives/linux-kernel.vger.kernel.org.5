Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39B680750F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378786AbjLFQdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378567AbjLFQdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:33:35 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B0812F;
        Wed,  6 Dec 2023 08:33:41 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 53B1121E9D;
        Wed,  6 Dec 2023 16:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1701880419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k+uFGUs75l4oWQ6f7Z0/b/BLTYEwL24mMWCv32Mzh+k=;
        b=PE/OpJfFlqtBuAWwRSmMCies8b9isQcMz6YeqIQlgfsbO7p+o/V4vexGXdwrF0Pk+LKQMh
        MlWhHsfteW7SZH+yv6zgQOwpVTHUETr8J/551DsYlnPTIxKAPdPODdRy5A6KSYhVlINvRv
        j7B6Jf3UyXfzwyzdG7biyfQncmarjD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1701880419;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k+uFGUs75l4oWQ6f7Z0/b/BLTYEwL24mMWCv32Mzh+k=;
        b=DmVVBZYFBVFTkOefuuoR3OKubS3us88Yv8GAGH93a/xNNFuwh6TgUd3Cn59rhGaJHpaooD
        htBIB9xCX/V3PvDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32767136CD;
        Wed,  6 Dec 2023 16:33:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id rQf7C2OicGU6ZQAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Wed, 06 Dec 2023 16:33:39 +0000
Message-ID: <9649f3fc-1802-6a0b-e492-d1ef6965d442@suse.cz>
Date:   Wed, 6 Dec 2023 17:33:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/3] mm/slub: correct the default value of
 slub_min_objects in doc
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, sxwjean@me.com
Cc:     cl@linux.com, linux-mm@kvack.org, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, corbet@lwn.net, keescook@chromium.org,
        arnd@arndb.de, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiongwei Song <xiongwei.song@windriver.com>
References: <20231203001501.126339-1-sxwjean@me.com>
 <20231203001501.126339-4-sxwjean@me.com>
 <CAB=+i9TVfzWk=anexu6ARPA21AC-uhjQjf4brZF0XDfVaWraWw@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAB=+i9TVfzWk=anexu6ARPA21AC-uhjQjf4brZF0XDfVaWraWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: 0.20
X-Spamd-Result: default: False [0.20 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com,me.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         BAYES_HAM(-0.00)[18.57%];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[16];
         FREEMAIL_TO(0.00)[gmail.com,me.com];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/23 01:53, Hyeonggon Yoo wrote:
> On Sun, Dec 3, 2023 at 9:16 AM <sxwjean@me.com> wrote:
>>
>> From: Xiongwei Song <xiongwei.song@windriver.com>
>>
>> There is no a value assigned to slub_min_objects by default, it always
>> is 0 that is initialized by compiler if no assigned value by command line.
>> min_objects is calculated based on processor numbers in calculate_order().
>> For more details, see commit 9b2cd506e5f2 ("slub: Calculate min_objects
>> based on number of processors.")
>>
>> Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
> 
> While slub_min_objects equals zero by default, 'min_objects' overrides it to
> 4 * (fls(nr_cpus) + 1) when not set. so when slub_min_objects is not
> set, it would be
> equal to or higher than 4. I'm not sure this level of implementation
> detail is worth documenting.

We could say e.g. "(default: automaticaly scaled by number of cpus)"

> Also, I think patch 2 should update Documentation/mm/slub.rst too.
> (slub_$param -> slab_param)

I'd do it as separate patch, not part of patch 2.

>> ---
>>  Documentation/mm/slub.rst | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/mm/slub.rst b/Documentation/mm/slub.rst
>> index be75971532f5..1f4399581449 100644
>> --- a/Documentation/mm/slub.rst
>> +++ b/Documentation/mm/slub.rst
>> @@ -150,7 +150,7 @@ list_lock once in a while to deal with partial slabs. That overhead is
>>  governed by the order of the allocation for each slab. The allocations
>>  can be influenced by kernel parameters:
>>
>> -.. slub_min_objects=x          (default 4)
>> +.. slub_min_objects=x          (default 0)
>>  .. slub_min_order=x            (default 0)
>>  .. slub_max_order=x            (default 3 (PAGE_ALLOC_COSTLY_ORDER))
>>
>> --
>> 2.34.1
>>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC972804E0F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344889AbjLEJi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbjLEJi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:38:57 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4497C6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:39:03 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 22BD81FB80;
        Tue,  5 Dec 2023 09:39:02 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08B7213A2E;
        Tue,  5 Dec 2023 09:39:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id Id6DAbbvbmXUVwAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Tue, 05 Dec 2023 09:39:02 +0000
Message-ID: <c0542b0e-4b36-7774-ec6f-7c54a3ec2b2b@suse.cz>
Date:   Tue, 5 Dec 2023 10:39:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 9/9] slub: Update frozen slabs documentations in the
 source
Content-Language: en-US
To:     Chengming Zhou <chengming.zhou@linux.dev>,
        "Christoph Lameter (Ampere)" <cl@linux.com>
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231102032330.1036151-1-chengming.zhou@linux.dev>
 <20231102032330.1036151-10-chengming.zhou@linux.dev>
 <dd73fdd6-b093-b32a-85a3-25cd22c21652@linux.com>
 <29bd5cc7-e8e6-4a4d-b526-651c7885a185@linux.dev>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <29bd5cc7-e8e6-4a4d-b526-651c7885a185@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: ++++++++
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=none;
        spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of vbabka@suse.cz) smtp.mailfrom=vbabka@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [8.39 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         BAYES_HAM(-0.00)[12.04%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(1.20)[suse.cz];
         R_SPF_SOFTFAIL(4.60)[~all];
         NEURAL_HAM_LONG(-1.00)[-0.998];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         RCPT_COUNT_SEVEN(0.00)[11];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 8.39
X-Rspamd-Queue-Id: 22BD81FB80
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/23 07:06, Chengming Zhou wrote:
> On 2023/12/5 05:41, Christoph Lameter (Ampere) wrote:
>> On Thu, 2 Nov 2023, chengming.zhou@linux.dev wrote:
>> 
>>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>>
>>> The current updated scheme (which this series implemented) is:
>>> - node partial slabs: PG_Workingset && !frozen
>>> - cpu partial slabs: !PG_Workingset && !frozen
>>> - cpu slabs: !PG_Workingset && frozen
>>> - full slabs: !PG_Workingset && !frozen
>> 
>> The above would be good to include in the comments.
>> 
>> Acked-by: Christoph Lameter (Ampere) <cl@linux.com>
>> 
> 
> Thanks for your review and suggestion!
> 
> Maybe something like this:

Thanks, added.

> diff --git a/mm/slub.c b/mm/slub.c
> index 623c17a4cdd6..21f88bd9c16b 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -93,6 +93,12 @@
>   *   by clearing the PG_workingset flag when moving out of the node
>   *   partial list. Please see __slab_free() for more details.
>   *
> + *   To sum up, the current scheme is:
> + *   - node partial slab: PG_Workingset && !frozen
> + *   - cpu partial slab: !PG_Workingset && !frozen
> + *   - cpu slab: !PG_Workingset && frozen
> + *   - full slab: !PG_Workingset && !frozen
> + *
>   *   list_lock
>   *
>   *   The list_lock protects the partial and full list on each node and


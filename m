Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3920880EAA3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjLLLmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjLLLmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:42:36 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019DCC3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:42:42 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6E5891F381;
        Tue, 12 Dec 2023 11:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1702381361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r8rQdTbhdfN1Wpyhb5CblYIrwW052Y/FkuDWvW+nn5c=;
        b=F0XdSCExJqByYR9ejmbJJF1d5HVGZ1xnmjJRpPrWTgU8roT16ijdNACw6mKGPOQTrD0UsM
        aAddTYbU48cA2rx+4yNuSGoYZRtkoFeKr+ZZRMazOQ5I39WXUjnbZazdb3aD7uZ7IF2V6e
        q1T/ohUabLi00N5EB+/5QeXOcIHBPD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1702381361;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r8rQdTbhdfN1Wpyhb5CblYIrwW052Y/FkuDWvW+nn5c=;
        b=gX/Xrx7WOsX36NX6N9ByCFiML4/HWpf1XmY01VyWuZM0uoHhjmhf7dEpYTl/rNKLzXMtym
        UjAtS0o7BMRlpAAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1702381361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r8rQdTbhdfN1Wpyhb5CblYIrwW052Y/FkuDWvW+nn5c=;
        b=F0XdSCExJqByYR9ejmbJJF1d5HVGZ1xnmjJRpPrWTgU8roT16ijdNACw6mKGPOQTrD0UsM
        aAddTYbU48cA2rx+4yNuSGoYZRtkoFeKr+ZZRMazOQ5I39WXUjnbZazdb3aD7uZ7IF2V6e
        q1T/ohUabLi00N5EB+/5QeXOcIHBPD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1702381361;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r8rQdTbhdfN1Wpyhb5CblYIrwW052Y/FkuDWvW+nn5c=;
        b=gX/Xrx7WOsX36NX6N9ByCFiML4/HWpf1XmY01VyWuZM0uoHhjmhf7dEpYTl/rNKLzXMtym
        UjAtS0o7BMRlpAAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D17E13725;
        Tue, 12 Dec 2023 11:42:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id hcdiEjFHeGXqPAAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Tue, 12 Dec 2023 11:42:41 +0000
Message-ID: <fec2561d-42fb-dd47-6e8f-3b55aaf39d85@suse.cz>
Date:   Tue, 12 Dec 2023 12:42:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/4] mm/slub: free KFENCE objects in slab_free_hook()
To:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>
Cc:     Chengming Zhou <chengming.zhou@linux.dev>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
References: <20231204-slub-cleanup-hooks-v1-0-88b65f7cd9d5@suse.cz>
 <20231204-slub-cleanup-hooks-v1-4-88b65f7cd9d5@suse.cz>
 <44421a37-4343-46d0-9e5c-17c2cd038cf2@linux.dev>
 <79e29576-12a2-a423-92f3-d8a7bcd2f0ce@suse.cz>
 <fdd11528-b0f8-48af-8141-15c4b1b01c65@linux.dev>
 <CANpmjNO1_LxE9w4m_Wa5xxc1R87LhnJSZ3DV59ia3-SdQUmtpw@mail.gmail.com>
 <CA+fCnZfhqQ+n0SsZU0RKEov3CkwTNJXM7JTMxtkrODmbJPskDQ@mail.gmail.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CA+fCnZfhqQ+n0SsZU0RKEov3CkwTNJXM7JTMxtkrODmbJPskDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: 1.39
X-Spamd-Bar: +++++
Authentication-Results: smtp-out2.suse.de;
        dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=F0XdSCEx;
        dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="gX/Xrx7W";
        dmarc=none;
        spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of vbabka@suse.cz) smtp.mailfrom=vbabka@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [5.79 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
         TO_DN_SOME(0.00)[];
         R_SPF_SOFTFAIL(4.60)[~all];
         R_RATELIMIT(0.00)[to_ip_from(RLhc4kaujr6ihojcnjq7c1jwbi)];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_TRACE(0.00)[suse.cz:+];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         FREEMAIL_TO(0.00)[gmail.com,google.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         BAYES_HAM(-0.00)[16.11%];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         FROM_HAS_DN(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(1.20)[suse.cz];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         RCPT_COUNT_TWELVE(0.00)[15];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FREEMAIL_CC(0.00)[linux.dev,linux.com,kernel.org,google.com,lge.com,linux-foundation.org,gmail.com,kvack.org,vger.kernel.org,googlegroups.com];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[];
         RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: 5.79
X-Rspamd-Queue-Id: 6E5891F381
X-Spam-Flag: NO
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/23 23:11, Andrey Konovalov wrote:
> On Wed, Dec 6, 2023 at 3:45 PM Marco Elver <elver@google.com> wrote:
>>
>> The is_kfence_address() implementation tolerates tagged addresses,
>> i.e. if it receives a tagged non-kfence address, it will never return
>> true.

So just to be sure, it can't happen that a genuine kfence address would then
become KASAN tagged and handed out, and thus when tested by
is_kfence_address() it would be a false negative?

>> The KASAN_HW_TAGS patches and KFENCE patches were in development
>> concurrently, and at the time there was some conflict resolution that
>> happened when both were merged. The
>> is_kfence_address(kasan_reset_tag(..)) initially came from [1] but was
>> squashed into 2b8305260fb.
>>
>> [1] https://lore.kernel.org/all/9dc196006921b191d25d10f6e611316db7da2efc.1611946152.git.andreyknvl@google.com/
>>
>> Andrey, do you recall what issue you encountered that needed kasan_reset_tag()?
> 
> I don't remember at this point, but this could have been just a safety measure.
> 
> If is_kfence_address tolerates tagged addresses, we should be able to
> drop these kasan_reset_tag calls.

Will drop it once the above is confirmed. Thanks!

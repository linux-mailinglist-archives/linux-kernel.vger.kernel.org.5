Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DB47F72A0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 12:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjKXLYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 06:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjKXLYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 06:24:09 -0500
X-Greylist: delayed 7056 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Nov 2023 03:24:15 PST
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D662FD5A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 03:24:15 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CA73D1FD49;
        Fri, 24 Nov 2023 11:24:11 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD77613A98;
        Fri, 24 Nov 2023 11:24:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id O5n8KduHYGV7DQAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Fri, 24 Nov 2023 11:24:11 +0000
Message-ID: <7512b350-4317-21a0-fab3-4101bc4d8f7a@suse.cz>
Date:   Fri, 24 Nov 2023 12:24:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] Documentation: kernel-parameters: remove
 slab_max_order and noaliencache
Content-Language: en-US
To:     sxwjean@me.com, 42.hyeyoo@gmail.com, linux-mm@kvack.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiongwei Song <xiongwei.song@windriver.com>
References: <20231122143603.85297-1-sxwjean@me.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231122143603.85297-1-sxwjean@me.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: ++++++++++++++++++++
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=none;
        spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of vbabka@suse.cz) smtp.mailfrom=vbabka@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [20.99 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_SPAM(5.10)[100.00%];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
         TO_DN_SOME(0.00)[];
         R_SPF_SOFTFAIL(4.60)[~all];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         FREEMAIL_TO(0.00)[me.com,gmail.com,kvack.org];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com,me.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(1.20)[suse.cz];
         NEURAL_SPAM_SHORT(3.00)[1.000];
         NEURAL_SPAM_LONG(3.50)[1.000];
         RCPT_COUNT_TWELVE(0.00)[13];
         DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:email,me.com:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 20.99
X-Rspamd-Queue-Id: CA73D1FD49
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/23 15:36, sxwjean@me.com wrote:
> From: Xiongwei Song <xiongwei.song@windriver.com>
> 
> Since slab allocator has already been removed. There is no users about
> slab_max_order and noaliencache, so let's remove them.
> 
> Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
> ---
> v2: Hyeonggon Yoo <42.hyeyoo@gmail.com> suggested that noaliencache should be
> removed too. Here adding this change. The patch is based on [1].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slab-remove-slab-v2r1
> 
> v1: https://lore.kernel.org/linux-mm/20231120091214.150502-1-sxwjean@me.com/T/#m55ebb45851bc86d650baf65dfe8296d33c5b1126
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 65731b060e3f..d56a5beefe24 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3740,10 +3740,6 @@
>  	no5lvl		[X86-64,RISCV] Disable 5-level paging mode. Forces
>  			kernel to use 4-level paging instead.
>  
> -	noaliencache	[MM, NUMA, SLAB] Disables the allocation of alien
> -			caches in the slab allocator.  Saves per-node memory,
> -			but will impact performance.

No question about this one, can be deleted.

> -
>  	noalign		[KNL,ARM]
>  
>  	noaltinstr	[S390] Disables alternative instructions patching
> @@ -5887,12 +5883,6 @@
>  			own.
>  			For more information see Documentation/mm/slub.rst.
>  
> -	slab_max_order=	[MM, SLAB]
> -			Determines the maximum allowed order for slabs.
> -			A high setting may cause OOMs due to memory
> -			fragmentation.  Defaults to 1 for systems with
> -			more than 32MB of RAM, 0 otherwise.

I think here we should consider the long-term plan first. It's a bit
unfortunate (in hindsight) SLUB brought its own prefix of parameters, even
if some became interchangeable aliases later (slab/slub_nomerge), some not.
I think it would be best to unify them, and consider the string "slub" an
implementation detail of the general "slab allocator" term going forward.

So what I'd propose is that we change all parameters to accept a
"slab_$param" as a primary and documented name (and the description can
contain just [MM] tag, no [SLAB] or [SLUB] needed), with "slub_$param" is
also accepted as an alias where it exists today, and there's just a note
that the slub_$param name is also accepted in the description of the
canonical parameter, not in a separate description. Then maybe in a few
years we can mark the old names as deprecated and start issuing low-key
warnings (while still accepting them), and in 10 years maybe remove them
completely. Thoughts?

> -
>  	slub_debug[=options[,slabs][;[options[,slabs]]...]	[MM, SLUB]
>  			Enabling slub_debug allows one to determine the
>  			culprit if slab objects become corrupted. Enabling


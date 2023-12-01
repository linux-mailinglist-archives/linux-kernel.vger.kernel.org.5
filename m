Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6338008B7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378332AbjLAKoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378309AbjLAKoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:44:21 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E33210D8;
        Fri,  1 Dec 2023 02:44:27 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8E28B1FD69;
        Fri,  1 Dec 2023 10:44:24 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E0DA1379A;
        Fri,  1 Dec 2023 10:44:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id KFRiHgi5aWUUZwAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Fri, 01 Dec 2023 10:44:24 +0000
Message-ID: <f0353b3e-9cb3-4009-9c2e-4e0912f28dc2@suse.cz>
Date:   Fri, 1 Dec 2023 11:44:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] docs: admin-guide: remove obsolete advice related to SLAB
 allocator
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231130095515.21586-1-lukas.bulwahn@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231130095515.21586-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: +++++++++
X-Spam-Score: 9.73
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of vbabka@suse.cz) smtp.mailfrom=vbabka@suse.cz;
        dmarc=none
X-Rspamd-Queue-Id: 8E28B1FD69
X-Spamd-Result: default: False [9.73 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(1.20)[suse.cz];
         R_SPF_SOFTFAIL(4.60)[~all];
         RCPT_COUNT_FIVE(0.00)[5];
         RCVD_COUNT_THREE(0.00)[3];
         NEURAL_SPAM_SHORT(1.34)[0.448];
         MX_GOOD(-0.01)[];
         BAYES_HAM(-3.00)[100.00%];
         NEURAL_SPAM_LONG(3.50)[1.000];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
         FREEMAIL_TO(0.00)[gmail.com,lwn.net,vger.kernel.org];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/23 10:55, Lukas Bulwahn wrote:
> Commit 1db9d06aaa55 ("mm/slab: remove CONFIG_SLAB from all Kconfig and

Note that's a -next (from slab/for-next) commit which might still change at
this point.

> Makefile") removes the config SLAB and makes the SLUB allocator the only
> default allocator in the kernel. Hence, the advice on reducing OS jitter
> due to kworker kernel threads to build with CONFIG_SLUB instead of
> CONFIG_SLAB is obsolete.
> 
> Remove the obsolete advice to build with SLUB instead of SLAB.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

But due to above, maybe it's best to wait after the removal goes through.

> ---
>  .../admin-guide/kernel-per-CPU-kthreads.rst      | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-per-CPU-kthreads.rst b/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
> index 993c2a05f5ee..b6aeae3327ce 100644
> --- a/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
> +++ b/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
> @@ -243,13 +243,9 @@ To reduce its OS jitter, do any of the following:
>  3.	Do any of the following needed to avoid jitter that your
>  	application cannot tolerate:
>  
> -	a.	Build your kernel with CONFIG_SLUB=y rather than
> -		CONFIG_SLAB=y, thus avoiding the slab allocator's periodic
> -		use of each CPU's workqueues to run its cache_reap()
> -		function.
> -	b.	Avoid using oprofile, thus avoiding OS jitter from
> +	a.	Avoid using oprofile, thus avoiding OS jitter from
>  		wq_sync_buffer().
> -	c.	Limit your CPU frequency so that a CPU-frequency
> +	b.	Limit your CPU frequency so that a CPU-frequency
>  		governor is not required, possibly enlisting the aid of
>  		special heatsinks or other cooling technologies.  If done
>  		correctly, and if you CPU architecture permits, you should
> @@ -259,7 +255,7 @@ To reduce its OS jitter, do any of the following:
>  
>  		WARNING:  Please check your CPU specifications to
>  		make sure that this is safe on your particular system.
> -	d.	As of v3.18, Christoph Lameter's on-demand vmstat workers
> +	c.	As of v3.18, Christoph Lameter's on-demand vmstat workers
>  		commit prevents OS jitter due to vmstat_update() on
>  		CONFIG_SMP=y systems.  Before v3.18, is not possible
>  		to entirely get rid of the OS jitter, but you can
> @@ -274,7 +270,7 @@ To reduce its OS jitter, do any of the following:
>  		(based on an earlier one from Gilad Ben-Yossef) that
>  		reduces or even eliminates vmstat overhead for some
>  		workloads at https://lore.kernel.org/r/00000140e9dfd6bd-40db3d4f-c1be-434f-8132-7820f81bb586-000000@email.amazonses.com.
> -	e.	If running on high-end powerpc servers, build with
> +	d.	If running on high-end powerpc servers, build with
>  		CONFIG_PPC_RTAS_DAEMON=n.  This prevents the RTAS
>  		daemon from running on each CPU every second or so.
>  		(This will require editing Kconfig files and will defeat
> @@ -282,12 +278,12 @@ To reduce its OS jitter, do any of the following:
>  		due to the rtas_event_scan() function.
>  		WARNING:  Please check your CPU specifications to
>  		make sure that this is safe on your particular system.
> -	f.	If running on Cell Processor, build your kernel with
> +	e.	If running on Cell Processor, build your kernel with
>  		CBE_CPUFREQ_SPU_GOVERNOR=n to avoid OS jitter from
>  		spu_gov_work().
>  		WARNING:  Please check your CPU specifications to
>  		make sure that this is safe on your particular system.
> -	g.	If running on PowerMAC, build your kernel with
> +	f.	If running on PowerMAC, build your kernel with
>  		CONFIG_PMAC_RACKMETER=n to disable the CPU-meter,
>  		avoiding OS jitter from rackmeter_do_timer().
>  


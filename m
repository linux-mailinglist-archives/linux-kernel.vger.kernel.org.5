Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E080B7F9F34
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbjK0MCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbjK0MCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:02:30 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C13F8F;
        Mon, 27 Nov 2023 04:02:33 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B496F20363;
        Mon, 27 Nov 2023 12:02:31 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 949D41379A;
        Mon, 27 Nov 2023 12:02:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id 6RnMI1eFZGVudgAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Mon, 27 Nov 2023 12:02:31 +0000
Message-ID: <2f8e8e28-28d4-b0a4-11a8-639f78c319c3@suse.cz>
Date:   Mon, 27 Nov 2023 13:02:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] Documentation: kernel-parameters: remove
 slab_max_order and noaliencache
Content-Language: en-US
To:     "Song, Xiongwei" <Xiongwei.Song@windriver.com>,
        "sxwjean@me.com" <sxwjean@me.com>,
        "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc:     "cl@linux.com" <cl@linux.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231122143603.85297-1-sxwjean@me.com>
 <7512b350-4317-21a0-fab3-4101bc4d8f7a@suse.cz>
 <PH0PR11MB51929193317D75141C28059BECBEA@PH0PR11MB5192.namprd11.prod.outlook.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <PH0PR11MB51929193317D75141C28059BECBEA@PH0PR11MB5192.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: ++++++
X-Spam-Score: 6.19
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of vbabka@suse.cz) smtp.mailfrom=vbabka@suse.cz;
        dmarc=none
X-Rspamd-Queue-Id: B496F20363
X-Spamd-Result: default: False [6.19 / 50.00];
         ARC_NA(0.00)[];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com,me.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(1.20)[suse.cz];
         R_SPF_SOFTFAIL(4.60)[~all:c];
         MID_RHS_MATCH_FROM(0.00)[];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         BAYES_HAM(-3.00)[100.00%];
         RCPT_COUNT_TWELVE(0.00)[13];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         FREEMAIL_TO(0.00)[windriver.com,me.com,gmail.com,kvack.org];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/23 08:25, Song, Xiongwei wrote:
> Hi Vlastimil,
> 
>> -----Original Message-----
>> From: Vlastimil Babka <vbabka@suse.cz>
>> Sent: Friday, November 24, 2023 7:24 PM
>> To: sxwjean@me.com; 42.hyeyoo@gmail.com; linux-mm@kvack.org
>> Cc: cl@linux.com; penberg@kernel.org; rientjes@google.com; iamjoonsoo.kim@lge.com;
>> akpm@linux-foundation.org; roman.gushchin@linux.dev; corbet@lwn.net; linux-
>> doc@vger.kernel.org; linux-kernel@vger.kernel.org; Song, Xiongwei
>> <Xiongwei.Song@windriver.com>
>> Subject: Re: [PATCH v2] Documentation: kernel-parameters: remove slab_max_order and
>> noaliencache
>> 
>> 
>> On 11/22/23 15:36, sxwjean@me.com wrote:
>> > From: Xiongwei Song <xiongwei.song@windriver.com>
>> >
>> > Since slab allocator has already been removed. There is no users about
>> > slab_max_order and noaliencache, so let's remove them.
>> >
>> > Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
>> > ---
>> > v2: Hyeonggon Yoo <42.hyeyoo@gmail.com> suggested that noaliencache should be
>> > removed too. Here adding this change. The patch is based on [1].
>> >
>> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slab-remove-
>> slab-v2r1
>> >
>> > v1: https://lore.kernel.org/linux-mm/20231120091214.150502-1-
>> sxwjean@me.com/T/#m55ebb45851bc86d650baf65dfe8296d33c5b1126
>> > ---
>> >  Documentation/admin-guide/kernel-parameters.txt | 10 ----------
>> >  1 file changed, 10 deletions(-)
>> >
>> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-
>> guide/kernel-parameters.txt
>> > index 65731b060e3f..d56a5beefe24 100644
>> > --- a/Documentation/admin-guide/kernel-parameters.txt
>> > +++ b/Documentation/admin-guide/kernel-parameters.txt
>> > @@ -3740,10 +3740,6 @@
>> >       no5lvl          [X86-64,RISCV] Disable 5-level paging mode. Forces
>> >                       kernel to use 4-level paging instead.
>> >
>> > -     noaliencache    [MM, NUMA, SLAB] Disables the allocation of alien
>> > -                     caches in the slab allocator.  Saves per-node memory,
>> > -                     but will impact performance.
>> 
>> No question about this one, can be deleted.
>> 
>> > -
>> >       noalign         [KNL,ARM]
>> >
>> >       noaltinstr      [S390] Disables alternative instructions patching
>> > @@ -5887,12 +5883,6 @@
>> >                       own.
>> >                       For more information see Documentation/mm/slub.rst.
>> >
>> > -     slab_max_order= [MM, SLAB]
>> > -                     Determines the maximum allowed order for slabs.
>> > -                     A high setting may cause OOMs due to memory
>> > -                     fragmentation.  Defaults to 1 for systems with
>> > -                     more than 32MB of RAM, 0 otherwise.
>> 
>> I think here we should consider the long-term plan first. It's a bit
>> unfortunate (in hindsight) SLUB brought its own prefix of parameters, even
>> if some became interchangeable aliases later (slab/slub_nomerge), some not.
>> I think it would be best to unify them, and consider the string "slub" an
>> implementation detail of the general "slab allocator" term going forward.
>> 
>> So what I'd propose is that we change all parameters to accept a
>> "slab_$param" as a primary and documented name (and the description can
>> contain just [MM] tag, no [SLAB] or [SLUB] needed), with "slub_$param" is
>> also accepted as an alias where it exists today, and there's just a note
>> that the slub_$param name is also accepted in the description of the
>> canonical parameter, not in a separate description. Then maybe in a few
>> years we can mark the old names as deprecated and start issuing low-key
>> warnings (while still accepting them), and in 10 years maybe remove them
>> completely. Thoughts?
> 
> Sorry, I didn't know the SLUB history, thanks for the comments and proposal. 
> 
> Did you mean the rough diff below?
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 65731b060e3f..db6d2ebe7c7d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5871,10 +5871,12 @@
>          slram=          [HW,MTD]
> 
>          slab_merge      [MM]
> +       slub_merge      [MM]
>                          Enable merging of slabs with similar size when the
>                          kernel is built without CONFIG_SLAB_MERGE_DEFAULT.

I'd hope the result look more like this, so the duplicate names are not
so prominent.

        slab_merge      [MM]
                        Enable merging of slabs with similar size when the
                        kernel is built without CONFIG_SLAB_MERGE_DEFAULT.
                        (slub_merge also accepted as an alias)

Note that it's not just a Documentation change anymore, as many of the
parameters don't have the slab_ variants yet wired up.

> 
>          slab_nomerge    [MM]
> +       slub_nomerge    [MM]
>                          Disable merging of slabs with similar size. May be
>                          necessary if there is some reason to distinguish
>                          allocs to different slabs, especially in hardened
> @@ -5887,12 +5889,6 @@
>                          own.
>                          For more information see Documentation/mm/slub.rst.
> 
> -       slab_max_order= [MM, SLAB]
> -                       Determines the maximum allowed order for slabs.
> -                       A high setting may cause OOMs due to memory
> -                       fragmentation.  Defaults to 1 for systems with
> -                       more than 32MB of RAM, 0 otherwise.
> -
>          slub_debug[=options[,slabs][;[options[,slabs]]...]      [MM, SLUB]
>                          Enabling slub_debug allows one to determine the
>                          culprit if slab objects become corrupted. Enabling
> @@ -5901,13 +5897,15 @@
>                          last alloc / free. For more information see
>                          Documentation/mm/slub.rst.
> 
> -       slub_max_order= [MM, SLUB]
> +       slab_max_order= [MM]
> +       slub_max_order= [MM]
>                          Determines the maximum allowed order for slabs.
>                          A high setting may cause OOMs due to memory
>                          fragmentation. For more information see
>                          Documentation/mm/slub.rst.
> 
> -       slub_min_objects=       [MM, SLUB]
> +       slab_min_objects=       [MM]
> +       slub_min_objects=       [MM]
>                          The minimum number of objects per slab. SLUB will
>                          increase the slab order up to slub_max_order to
>                          generate a sufficiently large slab able to contain
> @@ -5916,18 +5914,12 @@
>                          and the less frequently locks need to be acquired.
>                          For more information see Documentation/mm/slub.rst.
> 
> -       slub_min_order= [MM, SLUB]
> +       slub_min_order= [MM]
> +       slab_min_order= [MM]
>                          Determines the minimum page order for slabs.
> Must be
>                          lower than slub_max_order.
>                          For more information see Documentation/mm/slub.rst.
> 
> -       slub_merge      [MM, SLUB]
> -                       Same with slab_merge.
> -
> -       slub_nomerge    [MM, SLUB]
> -                       Same with slab_nomerge. This is supported for
> legacy.
> -                       See slab_nomerge for more information.
> -
>          smart2=         [HW]
>                          Format: <io1>[,<io2>[,...,<io8>]]
> 
> If so I think we should use slab_&param in mm/slub.c. When hitting "slub_$param"
> we need to assign the value to "slab_&param" like "slab_nomerge", right?
> 
> Regards,
> Xiongwei


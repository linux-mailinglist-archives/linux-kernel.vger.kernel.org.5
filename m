Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7907E7F9EFE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjK0LwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjK0LwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:52:23 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482D8101;
        Mon, 27 Nov 2023 03:52:29 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CB9B221D12;
        Mon, 27 Nov 2023 11:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1701085947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nrobSf+3Er3g99gK4Amny1sZq4F2LlsryKeWhP499C0=;
        b=vshiPyiu+o3JNtf85M6mVSw5oHHMSalqRLOtWS2YDzjWG5giL6ye65kkExzJIG2aI0/W82
        uBj/METULwO4Y3ojU31biAB46zhXKZMgvQwGcEvN4E1mcUtVu7JdoG7LiR1chztE9mdsdb
        PbPdNPzc+9wNCro3I3zkYhKyBnYAnQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1701085947;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nrobSf+3Er3g99gK4Amny1sZq4F2LlsryKeWhP499C0=;
        b=GOO3XvsdHvyfc5kG7Lfj+uc8OV0fTpxmE8ww2CFi3gqqdA25jOEPOaF10MpLN+Agq1V2MC
        x3JotkM8rXe5jeBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD1E61379A;
        Mon, 27 Nov 2023 11:52:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id kVfqKfuCZGXScgAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Mon, 27 Nov 2023 11:52:27 +0000
Message-ID: <3cb4c839-caa4-5c6e-1672-6498124d3930@suse.cz>
Date:   Mon, 27 Nov 2023 12:52:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] Documentation: kernel-parameters: remove
 slab_max_order and noaliencache
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     sxwjean@me.com, linux-mm@kvack.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiongwei Song <xiongwei.song@windriver.com>
References: <20231122143603.85297-1-sxwjean@me.com>
 <7512b350-4317-21a0-fab3-4101bc4d8f7a@suse.cz>
 <CAB=+i9Rw2Cm1SEYJu8oLBBxy-gaTLty64buma+FHs81pkSQz6w@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAB=+i9Rw2Cm1SEYJu8oLBBxy-gaTLty64buma+FHs81pkSQz6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Score: 6.30
X-Spamd-Result: default: False [6.30 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com,me.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         BAYES_SPAM(5.10)[99.99%];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[13];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
         FREEMAIL_TO(0.00)[gmail.com];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[me.com,kvack.org,linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,lwn.net,vger.kernel.org,windriver.com];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/23 01:26, Hyeonggon Yoo wrote:
> On Fri, Nov 24, 2023 at 8:24 PM Vlastimil Babka <vbabka@suse.cz> wrote:
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
> 
> Good point, thank you for pointing them out!
> 
>> I think it would be best to unify them, and consider the string "slub" an
>> implementation detail of the general "slab allocator" term going forward.
> 
> So slab_{nomerge,min_objects,min_order, ...etc} are common to the
> concept of slab so slab_$param will be appropriate.
> 
> But if we add something like slub_nocmpxchg later, it would be slub_nocmpxchg
> as it's an implementation-specific feature.

Hm but we're going to have only one implementation and I hope that won't
change again (the implementation could furter evolve, even with large
changes, but not split into separate selection again). So I'd rather use
slab_$thing even for parameters that look like implementation specific.

>> So what I'd propose is that we change all parameters to accept a
>> "slab_$param" as a primary and documented name (and the description can
>> contain just [MM] tag, no [SLAB] or [SLUB] needed), with "slub_$param" is
>> also accepted as an alias where it exists today, and there's just a note
>> that the slub_$param name is also accepted in the description of the
>> canonical parameter, not in a separate description.
> 
> No reason not to do it.
> 
>> Then maybe in a few
>> years we can mark the old names as deprecated and start issuing low-key
>> warnings (while still accepting them), and in 10 years maybe remove them
>> completely. Thoughts?
> 
> That might be the safest way to remove a kernel parameter but should
> we remove them?
> Probably 1) allowing both slub_$param and slab_$param for general
> parameters (forever)

Well we can certainly try deprecate them in few years, just to avoid cruft.
But it's not critical in case that's rejected for some reason.

> and 2) only using slub_$param for slub-specific params would be enough?
> 
>> > -
>> >       slub_debug[=options[,slabs][;[options[,slabs]]...]      [MM, SLUB]
>> >                       Enabling slub_debug allows one to determine the
>> >                       culprit if slab objects become corrupted. Enabling
>>


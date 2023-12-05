Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62D7805006
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346613AbjLEKP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbjLEKPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:15:08 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4C71996;
        Tue,  5 Dec 2023 02:14:35 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 735DE1FB8B;
        Tue,  5 Dec 2023 10:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1701771273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bhZrWsCVSRl3/gNFhL1HvzTeirgk1o9QDebzo7iN2f0=;
        b=G2QcMBNaFbkYiqEoLI+v9gtth7Z6pWGLDRBZlRwY8Tqr6xZH3SiKviMeZY8q2ymKKAwwum
        7auG/tVfNVG/DUwBagjvYjt2g6DuqroW6FcnxizcNzrD8Y5qHdAcAlvFvMQ0uk/tM+jmCy
        GUbi8Igs0GYaWRfLq2/KSXc3gKQeo3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1701771273;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bhZrWsCVSRl3/gNFhL1HvzTeirgk1o9QDebzo7iN2f0=;
        b=nKSF9RgdltsqRjNxDbSwRfjmM8y2M3an5vqZL2UdihBAhYEz94R8/Y9WoVkF5jnvWlHoKA
        xFwidgwOKf5ZrCAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45C35136CF;
        Tue,  5 Dec 2023 10:14:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id tYCWEAn4bmWAZwAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Tue, 05 Dec 2023 10:14:33 +0000
Message-ID: <93a8a67c-9cb7-0d36-6b14-ce15a30bea3f@suse.cz>
Date:   Tue, 5 Dec 2023 11:14:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 02/21] mm/slab: remove CONFIG_SLAB from all Kconfig and
 Makefile
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
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
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
 <20231120-slab-remove-slab-v2-2-9c9c70177183@suse.cz>
 <ZW6j6aTpuJF0keS7@localhost.localdomain>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZW6j6aTpuJF0keS7@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.60
X-Spamd-Result: default: False [-2.60 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-3.00)[99.99%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         RCPT_COUNT_TWELVE(0.00)[23];
         FREEMAIL_TO(0.00)[gmail.com];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[google.com,linux.com,kernel.org,lge.com,linux-foundation.org,linux.dev,gmail.com,arm.com,cmpxchg.org,chromium.org,kvack.org,vger.kernel.org,googlegroups.com];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
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

On 12/5/23 05:15, Hyeonggon Yoo wrote:
> On Mon, Nov 20, 2023 at 07:34:13PM +0100, Vlastimil Babka wrote:
> 
> Looks good to me,
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks.

> Nit:
> 
> - Some arch configs enables DEBUG_SLAB
> - Some documentations refers to {DEBUG_,}SLAB config (i.e. "enable
> DEBUG_SLAB for debugging", or "use SLUB instead of SLAB for reducing OS
> jitter", ... etc)
> - fs/orangefs/orangefs-kernel.h uses #if (defined CONFIG_DEBUG_SLAB)
> 
> $ git grep DEBUG_SLAB arch/
> arch/arm/configs/ep93xx_defconfig:CONFIG_DEBUG_SLAB=y
> arch/arm/configs/tegra_defconfig:CONFIG_DEBUG_SLAB=y
> arch/microblaze/configs/mmu_defconfig:CONFIG_DEBUG_SLAB=y
> 
> $ git grep SLAB Documentation/
> 
> [... some unrelated lines removed ...]

Yep, I've wrote in the cover letter that to keep the series reasonable and
limit Ccing other subsystems on some patches, not everything is cleaned up
thoroughly, and is left for further work (some already started coming in
from others) that can be submitted to relevant subsystems.

> Documentation/admin-guide/cgroup-v1/cpusets.rst:PFA_SPREAD_SLAB, and appropriately marked slab caches will allocate
> Documentation/admin-guide/cgroup-v1/memory.rst:  pages allocated by the SLAB or SLUB allocator are tracked. A copy
> Documentation/admin-guide/kernel-per-CPU-kthreads.rst:          CONFIG_SLAB=y, thus avoiding the slab allocator's periodic
> Documentation/admin-guide/mm/pagemap.rst:   The page is managed by the SLAB/SLUB kernel memory allocator.
> Documentation/dev-tools/kasan.rst:For slab, both software KASAN modes support SLUB and SLAB allocators, while
> Documentation/dev-tools/kfence.rst:of the sample interval, the next allocation through the main allocator (SLAB or
> Documentation/mm/slub.rst:The basic philosophy of SLUB is very different from SLAB. SLAB
> Documentation/mm/slub.rst:                      Sorry SLAB legacy issues)
> Documentation/process/4.Coding.rst: - DEBUG_SLAB can find a variety of memory allocation and use errors; it
> Documentation/process/submit-checklist.rst:    ``CONFIG_DEBUG_SLAB``, ``CONFIG_DEBUG_PAGEALLOC``, ``CONFIG_DEBUG_MUTEXES``,
> Documentation/scsi/ChangeLog.lpfc:        CONFIG_DEBUG_SLAB set).
> Documentation/translations/it_IT/process/4.Coding.rst: - DEBUG_SLAB può trovare svariati errori di uso e di allocazione di memoria;
> Documentation/translations/it_IT/process/submit-checklist.rst:    ``CONFIG_DEBUG_SLAB``, ``CONFIG_DEBUG_PAGEALLOC``, ``CONFIG_DEBUG_MUTEXES``,
> Documentation/translations/ja_JP/SubmitChecklist:12: CONFIG_PREEMPT, CONFIG_DEBUG_PREEMPT, CONFIG_DEBUG_SLAB,
> Documentation/translations/zh_CN/dev-tools/kasan.rst:对于slab，两种软件KASAN模式都支持SLUB和SLAB分配器，而基于硬件标签的
> Documentation/translations/zh_CN/process/4.Coding.rst: - DEBUG_SLAB 可以发现各种内存分配和使用错误；它应该用于大多数开发内核。
> Documentation/translations/zh_CN/process/submit-checklist.rst:    ``CONFIG_DEBUG_SLAB``, ``CONFIG_DEBUG_PAGEALLOC``, ``CONFIG_DEBUG_MUTEXES``,
> Documentation/translations/zh_TW/dev-tools/kasan.rst:對於slab，兩種軟件KASAN模式都支持SLUB和SLAB分配器，而基於硬件標籤的
> Documentation/translations/zh_TW/process/4.Coding.rst: - DEBUG_SLAB 可以發現各種內存分配和使用錯誤；它應該用於大多數開發內核。
> Documentation/translations/zh_TW/process/submit-checklist.rst:    ``CONFIG_DEBUG_SLAB``, ``CONFIG_DEBUG_PAGEALLOC``, ``CONFIG_DEBUG_MUTEXES``,
> 
> --
> Hyeonggon


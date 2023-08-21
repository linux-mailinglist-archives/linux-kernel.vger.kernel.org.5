Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B70782107
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 03:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjHUBNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 21:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjHUBNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 21:13:11 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149D899
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 18:13:10 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5231410ab27so3539514a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 18:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692580388; x=1693185188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cd4uReI0FD9gttAYzEGkqMidc3xQd6d6Ip+eVtIwMWE=;
        b=YAs6/WLahY1fK7C+kFryxufJ7p1lXXG9emRHtgrHbqhz+6Uhqb31y8vBj3tUkeBrwS
         YWMUEZ9EVkgL/Npzh041mo8Ep6mfy4+hHR8ibQtlJbdM7/u3YAMp2F2PRIM/dCxkUgKD
         asRb56n/O1ncFgTGS5rTkGWvuTNsv3IW5LVw0vGM5KpGE77PSIWQleg3mZYt4F+5ndla
         EfH6x68P4ndfVwtAgMm2qzAHBHYStEEMO2H7hI4qdfBVTpqKrlVm7BXt/kerZP+IylhM
         Gg+v+8pvan1W1PC/4Cro+7Ht+sZdNdtQYW5eRGoONJHLn4sZrDgjD+QijWeLdtXro2HS
         3WRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692580388; x=1693185188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cd4uReI0FD9gttAYzEGkqMidc3xQd6d6Ip+eVtIwMWE=;
        b=TGAKJUfoIbRDmZygoIIN2sJ9yJLg+SSpxlfS4JED/FPLtptOOIfWkK7KlEgOac3lpE
         c7z+UuSEk6mullhk9f9cYuNREjTbAJznoBPKUKcqX6srNf7+3ib7sEWZIChrgT5Lhp3h
         JjPcRUFNkrSajpefAR+AEbNi5a/kjKgBUOo4Ei2/J9egFJX0fjgU6vy9XK2gFug7Xn71
         ZJPQpS8dRdftNCrDEchCaCsLYKtZ3ZGD+/OWNpJetdw1vEvkXZ2lXPgSNeQq7+y+eyQ3
         i4FRN/KWIx86NhrsBH6HS7qki8YjHQ24T0Tp/LGwvFz7JdO5c3UVSVWEgHOTtlPJy4cZ
         dblw==
X-Gm-Message-State: AOJu0YzPFSXkah3ugLwpTT69QTMBqRocIji135RE0j7aemibu6BKBdW9
        ETkKKvgxwL88IG5VtISf2EE=
X-Google-Smtp-Source: AGHT+IEpYpor4uwMDHfscJ7+Vym89dWDF7RQQ5EHRPDBXLLu5UczDDC6HHUH4oQIABilPua/y0S+fw==
X-Received: by 2002:a17:907:2bca:b0:99d:f778:b8e5 with SMTP id gv10-20020a1709072bca00b0099df778b8e5mr4044845ejc.28.1692580388274;
        Sun, 20 Aug 2023 18:13:08 -0700 (PDT)
Received: from f (cst-prg-27-89.cust.vodafone.cz. [46.135.27.89])
        by smtp.gmail.com with ESMTPSA id h4-20020a1709060f4400b00988f168811bsm5595393ejj.135.2023.08.20.18.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 18:13:07 -0700 (PDT)
Date:   Mon, 21 Aug 2023 03:13:03 +0200
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: remove unintentional voluntary preemption in
 get_mmap_lock_carefully
Message-ID: <20230821011303.hoeqjbmjaxajh255@f>
References: <20230820104303.2083444-1-mjguzik@gmail.com>
 <ZOJXgFJybD1ljCHL@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZOJXgFJybD1ljCHL@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 07:12:16PM +0100, Matthew Wilcox wrote:
> On Sun, Aug 20, 2023 at 12:43:03PM +0200, Mateusz Guzik wrote:
> > Found by checking off-CPU time during kernel build (like so:
> > "offcputime-bpfcc -Ku"), sample backtrace:
> >     finish_task_switch.isra.0
> >     __schedule
> >     __cond_resched
> >     lock_mm_and_find_vma
> >     do_user_addr_fault
> >     exc_page_fault
> >     asm_exc_page_fault
> >     -                sh (4502)
> 
> Now I'm awake, this backtrace really surprises me.  Do we not check
> need_resched on entry?  It seems terribly unlikely that need_resched
> gets set between entry and getting to this point, so I guess we must
> not.
> 
> I suggest the version of the patch which puts might_sleep() before the
> mmap_read_trylock() is the right one to apply.  It's basically what
> we've done forever, except that now we'll be rescheduling without the
> mmap lock held, which just seems like an overall win.
> 

I can't sleep and your response made me curious, is that really safe
here?

As I wrote in another email, the routine is concerned with a case of the
kernel faulting on something it should not have. For a case like that I
find rescheduling to another thread to be most concerning.

That said I think I found a winner -- add need_resched() prior to
trylock.

This adds less work than you would have added with might_sleep (a func
call), still respects the preemption point, dodges exception table
checks in the common case and does not switch away if the there is
anything fishy going on.

Or just do that might_sleep.

I'm really buggering off the subject now.

====

mm: remove unintentional voluntary preemption in get_mmap_lock_carefully

Should the trylock succeed (and thus blocking was avoided), the routine
wants to ensure blocking was still legal to do. However, might_sleep()
used ends up calling __cond_resched() injecting a voluntary preemption
point with the freshly acquired lock.

__might_sleep() instead with the lock, but check for preemption prior to
taking it.

Found by checking off-CPU time during kernel build (like so:
"offcputime-bpfcc -Ku"), sample backtrace:
    finish_task_switch.isra.0
    __schedule
    __cond_resched
    lock_mm_and_find_vma
    do_user_addr_fault
    exc_page_fault
    asm_exc_page_fault
    -                sh (4502)
        10

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 mm/memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 1ec1ef3418bf..6dac9dbb7b59 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5258,8 +5258,8 @@ EXPORT_SYMBOL_GPL(handle_mm_fault);
 static inline bool get_mmap_lock_carefully(struct mm_struct *mm, struct pt_regs *regs)
 {
 	/* Even if this succeeds, make it clear we *might* have slept */
-	if (likely(mmap_read_trylock(mm))) {
-		might_sleep();
+	if (likely(!need_resched() && mmap_read_trylock(mm))) {
+		__might_sleep(__FILE__, __LINE__);
 		return true;
 	}
 
-- 
2.39.2

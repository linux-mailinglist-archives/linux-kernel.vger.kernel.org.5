Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0329781DEC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 15:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjHTND6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 09:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjHTNDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 09:03:51 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D14173E
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 06:00:11 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9a828c920so39216071fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 06:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692536410; x=1693141210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HPSbgyhLc5Q7B4ZbRBJPVcxIZMDQI6ZiPnGnQ/TPqWo=;
        b=AgciMjmSed47bauV5RemSXWwunpQAzO1Gx+83mn3oWeEd3+tRW89aaGP0dOBOoPG2N
         UQ1ZWl4JMGYcmhrZoN5VEj41OTx9KOW6uu0nZWW34/2fKMCYdvXa+7Ax8JCEKdEXMU11
         iWw1QRcAe/HhZ1QCPbE3aFR50V11/R5sDqLfmBHAHxgDIQOL/P91/uyaMBaHqo1RQZGN
         a76sqjk9zqsUJxydGRcqM7i0/HJnq2AbDdgI/WQ3ATYwIQCIvaN4++cz2yxd93A9m1XV
         0mkq7GlzBlsBcVSVDQXob8Xtei1vi7nz1SQM+mhmpQG6g6JVs2WH/TcoUAV7PW8pev6f
         poPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692536410; x=1693141210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPSbgyhLc5Q7B4ZbRBJPVcxIZMDQI6ZiPnGnQ/TPqWo=;
        b=MhyXopv5wuh+ktoZSS3LamqNzkpfX2A61ptG5lw/rqXsFzUw6bzXQgu5vHlbszprKd
         rZ5ydkumtX4K+ab4Fdg1+v0giktXiARCTmhxpnTSHQvB/V3kpHFTT/HT6sDVY6KH0/pW
         muXTjQFX64YQw0dQopQU3LiWwYyYmvC6ESwCf1jVKKn1nN4MQFfdYIAjzQ54DnOIx+GI
         h5Iogj1vtRMl2zeyZijiqda1l+1a71Xp1pnPNnxnBEgITCNrm5pBnTm+6nn+FsxjXkUR
         eC7KZicsXpxSnDfT9W3IrfzzqtvE6aqpwzey4mr+A+y1i+P5FBH4FtzoqznnfNQdsFtW
         vFcw==
X-Gm-Message-State: AOJu0YzIfHgBZmp2eVAkKgoOAFEArtRsxSW5vsVg2zYxICoE67I9ahLe
        rS6+qO9SVCRegmMyRDKXz+U=
X-Google-Smtp-Source: AGHT+IHAM2G/YTBj7smE4cITzuV1oplz/ydV3jspEPYU8z45TQRqiN4V7vx6ePD2G3WrWv+QMzXh6w==
X-Received: by 2002:a05:6512:3e19:b0:4f8:7513:8cac with SMTP id i25-20020a0565123e1900b004f875138cacmr3894582lfv.48.1692536409674;
        Sun, 20 Aug 2023 06:00:09 -0700 (PDT)
Received: from f (cst-prg-27-89.cust.vodafone.cz. [46.135.27.89])
        by smtp.gmail.com with ESMTPSA id n17-20020a056402061100b0052338f5b2a4sm4248953edv.86.2023.08.20.06.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 06:00:09 -0700 (PDT)
Date:   Sun, 20 Aug 2023 15:00:04 +0200
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: remove unintentional voluntary preemption in
 get_mmap_lock_carefully
Message-ID: <20230820130004.knx42tyeshps4vdg@f>
References: <20230820104303.2083444-1-mjguzik@gmail.com>
 <ZOH62Zi/yao/oC8y@casper.infradead.org>
 <CAGudoHG3OxoYKSwDmJYEDOj6LmDMsQDs3SD5nBdrzA5Vc1_H0A@mail.gmail.com>
 <CAHk-=wh=cECn7SLr31VXwtJq-wYnt5+VcERnvAmEVktdEKqR=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wh=cECn7SLr31VXwtJq-wYnt5+VcERnvAmEVktdEKqR=w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 02:47:41PM +0200, Linus Torvalds wrote:
> On Sun, 20 Aug 2023 at 14:41, Mateusz Guzik <mjguzik@gmail.com> wrote:
> > My first patch looked like this:
> 
> Well, that's disgusting and strange.
> 
> > -               might_sleep();
> > +#if defined(CONFIG_DEBUG_ATOMIC_SLEEP)
> > +               __might_sleep(__FILE__, __LINE__);
> > +#endif
> 
> Why would you have that strange #ifdef? __might_sleep() just goes away
> without that debug option anyway.
> 
> But without that odd ifdef, I think it's fine.
> 

Heh, I wrote the patch last night and I could swear it failed to compile
without the ifdef.

That said I think it looks more than disgusting and I'm happy to confirm
it does build both ways.

That said:

mm: remove unintentional voluntary preemption in get_mmap_lock_carefully

Should the trylock succeed (and thus blocking was avoided), the routine
wants to ensure blocking was still legal to do. However, might_sleep()
ends up calling __cond_resched() injecting a voluntary preemption point
with the freshly acquired lock.

__might_sleep() instead to only get the asserts.

Found while checking off-CPU time during kernel build (like so:
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
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 1ec1ef3418bf..d82316a8a48b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5259,7 +5259,7 @@ static inline bool get_mmap_lock_carefully(struct mm_struct *mm, struct pt_regs
 {
 	/* Even if this succeeds, make it clear we *might* have slept */
 	if (likely(mmap_read_trylock(mm))) {
-		might_sleep();
+		__might_sleep(__FILE__, __LINE__);
 		return true;
 	}
 
-- 
2.39.2

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164C477CFEA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 18:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238440AbjHOQJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 12:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238432AbjHOQJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:09:15 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AC41733
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 09:09:13 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-76c4890a220so436660585a.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 09:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692115753; x=1692720553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a7C9/8y+U58yo9ZvAFzzO1UqKJUAwnM6b0NzrYmnGpo=;
        b=mvDMKIcZgcK17e9juJTBM1HOO6PNEZrWe7eP2pzdOs4HsP5XTeKNBqD1GRlg58HEhX
         MaLRc+vSgK3qPfpEhPIeoBoz0RmOv0emmq7MDqbgQSNqGruIPUVRO2SDtwRZoZk16nTQ
         rbX33pTKk8g3K+eivsboBRF5Ed0lr+V+4SDOZI4R7NLDTTmv6qShAmGA7NYrbpiiV1oq
         OlzHUF9tot4iKOgeQB3O35rjpcA3cV8PazvgdD/Nrh8I1mEr0opyGDA7xBAFPy93VWoy
         FzaMP401uCzbFBr6WiUamZKx7BTFCX8oO1O7yMOpSoxqxTODSeYQx2KdXLE99scvi7yy
         HqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692115753; x=1692720553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7C9/8y+U58yo9ZvAFzzO1UqKJUAwnM6b0NzrYmnGpo=;
        b=WvpaJNzkAsxKmwatOcyvIX6E2Ul5f6O39IKvWKgXbN7KWPkn4O6ltdbSKmTVYvApNx
         /cyXkrO/3R8NvEmA/Y6NZJz7FzsNxYbGOJaP+6vCrQU1FKRm/nThNbhjc8eU/R5x4qzX
         6P2nba0dO799RkeIdzxEHeR280F6XXitmfB7VpMniQIIF7I1hxWY5sOp/HEn86MHaD6I
         FtwgWgRjI6adkTMGlUHKd3uUTkAfnd9IzvPEcO5Yy4KJT4cu0xf3REnPMw33J/t4IJN5
         TkfM2fO9snYTnMBcY3ViNdR9CyOnzVsH1Z5ED0IfGmTaOEBN9DPZe2U9ATjTCq6ojgwB
         NmVA==
X-Gm-Message-State: AOJu0YxBMviRiB0y8KzslzuemiQJj5QawpxflnQxQH3jsO+8CGWWfxta
        pbkzzNxAwf5YKTYSZcGDeQ4cjQJiqc0=
X-Google-Smtp-Source: AGHT+IG0axrB7/devO/26FRZZWAcuvA50Ii95TbGO/5I3HhyO9HJaobhSyv6EQimQSFFQtGg25yFcQ==
X-Received: by 2002:a37:e310:0:b0:767:dbe5:1f2f with SMTP id y16-20020a37e310000000b00767dbe51f2fmr10923922qki.35.1692115752784;
        Tue, 15 Aug 2023 09:09:12 -0700 (PDT)
Received: from localhost (98-159-221-50.static.firstlight.net. [98.159.221.50])
        by smtp.gmail.com with ESMTPSA id g3-20020a05620a13c300b0075cd80fde9esm3837610qkl.89.2023.08.15.09.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 09:09:12 -0700 (PDT)
Date:   Tue, 15 Aug 2023 09:09:10 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 1/4] genirq/irq_sim: dispose of remaining mappings before
 removing the domain
Message-ID: <ZNujJhy9fmCFwwLK@yury-ThinkPad>
References: <20230812194457.6432-1-brgl@bgdev.pl>
 <20230812194457.6432-2-brgl@bgdev.pl>
 <ZNtVuUWTZa0gLwXz@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNtVuUWTZa0gLwXz@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 01:38:49PM +0300, Andy Shevchenko wrote:
> On Sat, Aug 12, 2023 at 09:44:54PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > 
> > If the device providing simulated interrupts is unbound (real life
> > example: gpio-sim is disabled with users that didn't free their irqs)
> > and removes the simulated domain while interrupts are still requested,
> > we will hit memory issues when they are eventually freed and the
> > mappings destroyed in the process.
> > 
> > Specifically we'll access freed memory in __irq_domain_deactivate_irq().
> > 
> > Dispose of all mappings before removing the simulator domain.
> 
> ...
> 
> > +#include <linux/list.h>
> 
> Maybe ordered?
> 
> >  #include <linux/irq.h>
> >  #include <linux/irq_sim.h>
> >  #include <linux/irq_work.h>
> 
> ...
> 
> > @@ -16,12 +17,14 @@ struct irq_sim_work_ctx {
> >  	unsigned int		irq_count;
> >  	unsigned long		*pending;
> >  	struct irq_domain	*domain;
> > +	struct list_head	irqs;
> >  };
> >  
> >  struct irq_sim_irq_ctx {
> >  	int			irqnum;
> >  	bool			enabled;
> >  	struct irq_sim_work_ctx	*work_ctx;
> 
> > +	struct list_head	siblings;
> 
> You can reduce the code size by moving this to be the first member.
> Not sure about struct irq_sim_work_ctx, you can play with bloat-o-meter.

Pahole you meant?

  yury:linux$ pahole -C irq_sim_irq_ctx /sys/kernel/btf/vmlinux
  struct irq_sim_irq_ctx {
  	int                        irqnum;               /*     0     4 */
  	bool                       enabled;              /*     4     1 */
  
  	/* XXX 3 bytes hole, try to pack */
  
  	struct irq_sim_work_ctx *  work_ctx;             /*     8     8 */
  
  	/* size: 16, cachelines: 1, members: 3 */
  	/* sum members: 13, holes: 1, sum holes: 3 */
  	/* last cacheline: 16 bytes */
  };

In this particular case, there will be no hole because list head
position (16) will be aligned to sizeof(struct list_head) == 16.

But as Bartosz said in the other email, "it's just good practice
resulting from years of" kernel coding to have:
 - members declared strongly according to the logic of the code, and
   if no strong preference: 
 - list head be the first element of the structure, to let compiler
   avoid generating offsets when traversing lists;
 - put elements of greater size at the beginning, so no holes will be
   emitted like in the example above.

So I'd suggest:

  struct irq_sim_irq_ctx {
     struct list_head        siblings;
     struct irq_sim_work_ctx *work_ctx;
     int                     irqnum;
     bool                    enabled;
  }
  
Again, if there's NO ANY reason to have the irq number at the
beginning.

While here, I wonder, why irqnum is signed? Looking at the very first
random function in kernel/irq/irq_sim.c, I see that it's initialized
from a function returning unsigned value:

  static void irq_sim_handle_irq(struct irq_work *work)
  {
          struct irq_sim_work_ctx *work_ctx;
          unsigned int offset = 0;
          int irqnum;
  
          work_ctx = container_of(work, struct irq_sim_work_ctx, work);
  
          while (!bitmap_empty(work_ctx->pending, work_ctx->irq_count)) {
                  offset = find_next_bit(work_ctx->pending,
                                         work_ctx->irq_count, offset);
                  clear_bit(offset, work_ctx->pending);
                  irqnum = irq_find_mapping(work_ctx->domain, offset);
                  handle_simple_irq(irq_to_desc(irqnum));
          }
  }

Thanks,
Yury

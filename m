Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2F280950E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 23:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444035AbjLGWH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 17:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjLGWHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 17:07:24 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB62122
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 14:07:27 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5d226f51f71so13351817b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 14:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701986847; x=1702591647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q0AOHa6WOyvMqCDqQv4ZeeVrDvAZWQXGwSAgV4Zp2Sc=;
        b=J5qqksZnmm4aPlefwdPzdaRx94rL6aPm2wsTCHjpDf57JWA4YXFeu09kEXWfWFgaiQ
         8lcReNMfNqjoZTQ5BPRHUhbGPKNSmfRvmLc9AmJCMOQlDbCBtiXW/oYOOmY5Mue0fnIr
         yN1lJCjmzX0ojDnq7YU3OgHrH4NhlTKn4EA7pOtgm4pkhvBJjZ1Sj3zAg+97ulKuF7iG
         B3zUo6U6D8v8oOVJahSctNw0Hk8Z8et+RoQF5bywCF9SbJ7WpUw6JUL1aUeeOGgmt7+w
         CXxG01ybqYBJU3xBSIDueb9swWDHyILusyU+Yd53AVZX7ysez4JnopFYLOrs9Hu05saH
         869w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701986847; x=1702591647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0AOHa6WOyvMqCDqQv4ZeeVrDvAZWQXGwSAgV4Zp2Sc=;
        b=Qyh8BMgSmallfy17WLaWk+UMyjSG7DsG+y5GmUaZ6Vi+98dCbD7BR0iWd6f8RSs+xM
         qu093O1bXIDQd2S23T4uYWAYjKxs3ncTUfIuo0pKJ0pqggOwGWOUG+fMq00PPANweovB
         US8VS1gjAv7D3F8/2hvxWsQwuYHA9gwUQVu4edmvHkurN/JzjdZiT+tM1yn0gpRs8Xkb
         3cOQyyKzEH8Ap8LNOM9Cm9OHtbma4TYWOfL2nuEz5nQ/5bJqZwx7A8hL09+NbMYQfPM6
         2wE+nlsRTfaNmg2HzKBpP5VHpxr2+GJnJfIPXf4KD2ZKJWce0Rn6HRBjbbo2oshTbG01
         BaoA==
X-Gm-Message-State: AOJu0YxDVlOhjCDhQViU5PdxYLd7ItYJUwH1B/SFX/cercZRcdb+VfFZ
        ZqVYAsvJ4H5UX7yrsnLgTZeOPLDrCFg=
X-Google-Smtp-Source: AGHT+IGbK7L45qaSOWLr52dnBqHPtMbvUg5tzv36wIwlEokysyQlvFvzyTrtGG48d6YQlThHI1yWYQ==
X-Received: by 2002:a0d:d7c5:0:b0:5d7:1940:dd90 with SMTP id z188-20020a0dd7c5000000b005d71940dd90mr3044674ywd.102.1701986846831;
        Thu, 07 Dec 2023 14:07:26 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:8f7f:efcd:5388:af4f])
        by smtp.gmail.com with ESMTPSA id x125-20020a817c83000000b005a4da74b869sm191507ywc.139.2023.12.07.14.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 14:07:26 -0800 (PST)
Date:   Thu, 7 Dec 2023 14:07:25 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 3/6] lib/group_cpus: optimize inner loop in
 grp_spread_init_one()
Message-ID: <ZXJCHTphZ+0niIQB@yury-ThinkPad>
References: <20231207203900.859776-1-yury.norov@gmail.com>
 <20231207203900.859776-4-yury.norov@gmail.com>
 <20231207134521.c921cb0bb1ab7487d78aeb07@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207134521.c921cb0bb1ab7487d78aeb07@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 01:45:21PM -0800, Andrew Morton wrote:
> On Thu,  7 Dec 2023 12:38:57 -0800 Yury Norov <yury.norov@gmail.com> wrote:
> 
> > The loop starts from the beginning every time we switch to the next
> > sibling mask. This is the Schlemiel the Painter's style of coding
> > because we know for sure that nmsk is clear up to current CPU, and we
> > can just continue from the next CPU.
> > 
> > Also, we can do it nicer if leverage the dedicated for_each() iterator.
> > 
> > --- a/lib/group_cpus.c
> > +++ b/lib/group_cpus.c
> > @@ -30,13 +30,13 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
> >  
> >  		/* If the cpu has siblings, use them first */
> >  		siblmsk = topology_sibling_cpumask(cpu);
> > -		for (sibl = -1; cpus_per_grp > 0; ) {
> > -			sibl = cpumask_next(sibl, siblmsk);
> > -			if (sibl >= nr_cpu_ids)
> > -				break;
> 
> I assume this test goes away because the iterator takes care of it?

Yes, correct.

> 
> > +		sibl = cpu + 1;
> > +
> > +		for_each_cpu_and_from(sibl, siblmsk, nmsk) {
> >  			__cpumask_clear_cpu(sibl, nmsk);
> >  			__cpumask_set_cpu(sibl, irqmsk);
> > -			cpus_per_grp--;
> > +			if (cpus_per_grp-- == 0)
> > +				return;
> >  		}
> >  	}
> >  }

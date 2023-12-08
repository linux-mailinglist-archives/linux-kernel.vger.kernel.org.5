Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1979680997F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573017AbjLHCtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573005AbjLHCtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:49:17 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150EF171D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:49:23 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5d6b9143782so14070527b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 18:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702003762; x=1702608562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dquzv7jzRzKGgvvbPlmxTtpqaQbVlWisPG1/idaZq48=;
        b=ilVBt+9G63Z8C2Lo9gsmG659r57em+qUlhmYJdIIXtBqJZ5GpXn8dOY/ik4pTcE+7T
         qH1VYNMKaxYD8nGeQKJE7Wti2lh52JhL5v02SF9WqSECWZ5IVZH+YiaLMINGw8+tCDqO
         LDHdgxp4NabK9yfnZjXVa95CX8nKAFdZ/gQTe7lyutsZLPErR4aRuDOo4RUAkFpOzPcJ
         ziqbDYguFXXoaDue5ntiHN8YsVay0wQq2BdjUkKNwaoU0mLtlV+TQmskLy/KA7UaZM7W
         OtQUaoDFUOTyTZk5GoYSQ4VLN4Iqv2S/agv8xBLa+ljVSVQQVJOR5NZ6Grgx2dvCTM4I
         i0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702003762; x=1702608562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dquzv7jzRzKGgvvbPlmxTtpqaQbVlWisPG1/idaZq48=;
        b=fyWJKR01xuPBSK4TDa00ITe+jsVg6TyeZp07Xg7g5iyLSzxyfgnV1XLSBnqnXM4t6W
         GD946Gsa9heJlv+jD+4+6ue5lWDYDE1tZmCQ5Oy2EUQYmgn57hMOKB0oMCKv/sIqLzXZ
         ec2cqTAk4L3Sqsd3xd50zCnRr6uYGtJJ9Kmcihg+0DFvPLh6dC/JRVlvVGWeudmYso+G
         qjXpBsFnZx91CV97U5q7mMZqIbXMqBsowrZE0gN+1dXcbHRKsNAI2P+RBE4MXO4SsTTd
         Ug41+S8837LVvDocm/3a2+godAz0O6EIn937dkb7Oka5gL53Ivjmv2+Iks+CAuNb2MXN
         DVQw==
X-Gm-Message-State: AOJu0Yy8hMXXCQWtfUOpJigHYcn1Xpb6xF8ZMW/SnE+2uTtLhTZr/JBS
        DLmXb+P8Fi0eA1nNj6VuUow=
X-Google-Smtp-Source: AGHT+IHAXSzhOF6WaGMIWVZF5Ae80ZyySF2cib23dxPI1rPLcktBoczncv4O7CEPI3il8ue6W0pSHQ==
X-Received: by 2002:a81:4846:0:b0:5d6:c5e6:fa4d with SMTP id v67-20020a814846000000b005d6c5e6fa4dmr3435202ywa.31.1702003762101;
        Thu, 07 Dec 2023 18:49:22 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cd3e:7dc3:93ad:7de2])
        by smtp.gmail.com with ESMTPSA id m141-20020a0dca93000000b005d997db3b2fsm356173ywd.23.2023.12.07.18.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 18:49:21 -0800 (PST)
Date:   Thu, 7 Dec 2023 18:49:20 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 2/6] lib/group_cpus: relax atomicity requirement in
 grp_spread_init_one()
Message-ID: <ZXKEMJZRPrPDOKV/@yury-ThinkPad>
References: <20231207203900.859776-1-yury.norov@gmail.com>
 <20231207203900.859776-3-yury.norov@gmail.com>
 <ZXJx72/YOGn0l4pI@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXJx72/YOGn0l4pI@fedora>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 09:31:27AM +0800, Ming Lei wrote:
> On Thu, Dec 07, 2023 at 12:38:56PM -0800, Yury Norov wrote:
> > Because nmsk and irqmsk are stable, extra atomicity is not required.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  lib/group_cpus.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> > index ee272c4cefcc..8eb18c6bbf3b 100644
> > --- a/lib/group_cpus.c
> > +++ b/lib/group_cpus.c
> > @@ -24,8 +24,8 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
> >  		if (cpu >= nr_cpu_ids)
> >  			return;
> >  
> > -		cpumask_clear_cpu(cpu, nmsk);
> > -		cpumask_set_cpu(cpu, irqmsk);
> > +		__cpumask_clear_cpu(cpu, nmsk);
> > +		__cpumask_set_cpu(cpu, irqmsk);
> >  		cpus_per_grp--;
> >  
> >  		/* If the cpu has siblings, use them first */
> > @@ -34,9 +34,8 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
> >  			sibl = cpumask_next(sibl, siblmsk);
> >  			if (sibl >= nr_cpu_ids)
> >  				break;
> > -			if (!cpumask_test_and_clear_cpu(sibl, nmsk))
> > -				continue;
> > -			cpumask_set_cpu(sibl, irqmsk);
> > +			__cpumask_clear_cpu(sibl, nmsk);
> > +			__cpumask_set_cpu(sibl, irqmsk);
> >  			cpus_per_grp--;
> 
> Here the change isn't simply to remove atomicity, and the test
> part of cpumask_test_and_clear_cpu() is removed, so logic is changed,
> I feel the correct change should be:
> 
> 	if (cpumask_test_cpu(sibl, nmsk)) {
> 		__cpumask_clear_cpu(sibl, nmsk);
> 		__cpumask_set_cpu(sibl, irqmsk);
>   		cpus_per_grp--;
> 	}

Ohh. My mistake is that I put this patch prior to the #3, so people
bisecting the kernel may hit this problem... 

You're right here, but check the following patch: it switches the
for() loop to for_each_cpu_and_from(sibl, siblmsk, nmsk), and it means
that inside the loop sibl indexes set bits in both siblmsk and nmsk.

Now, because both masks are stable when the grp_spread_init_one() is
called, there's no chance to get nmks.sibl cleared suddenly, and it
means we can just drop the check.

Does this makes sense to you?

I can send v3 with a proper order of patches, if needed.

Thanks,
Yury

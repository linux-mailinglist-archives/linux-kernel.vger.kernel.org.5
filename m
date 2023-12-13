Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F2F811A56
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbjLMRDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjLMRDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:03:15 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70089B3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:03:21 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5d2d0661a8dso73086027b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702487000; x=1703091800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=da2+Ei0XbvCEF/RIgh1CyB3A1CY6CaQf2SnXWjO6ruE=;
        b=D1RPo9zNyp7f2fidI+j/fMwjcZFpymgwHBWzw1DSo538UPGCkMknNByZqFwnNzU2Vj
         h6waXRtipFiBfpD4JJ7hoVa38DgUygqVSkcWZv70aCz878FILH1vPGTdvtwY7+YjNIH6
         lnscKaOtrSpVM8CDlgc3CMH8YaJXEQcLWheN3gdzNPItMbrppTeUPvhMNHiKeNp63nLk
         OMfJCGvqWcExdJbE83NGhuG9gVGZl+clDHQhtLx9kq7jPS/1SCEW+ftbwY0DekLXJOtP
         AKsJc0Iy1yPrNiYSkiirIoBHoKC2IYuhVKLICsaFNxv5n8ddNcNaIKUyaaiWyird0Dep
         J6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702487000; x=1703091800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=da2+Ei0XbvCEF/RIgh1CyB3A1CY6CaQf2SnXWjO6ruE=;
        b=UDL9bFdd+jeOUEWkJGnIqsJroTBbKaUA9O0DV27DXjLvqabmNvD6nyfYNW4qnF572g
         xKXwKnkTLk3xh+exO0rLusBU0weVLv+esGi9fjmobMmkjd8EnRm4ywtqMwITRjQYFwlF
         r2UDqW2/TdBI6xkG7EKyDQg66WCZb2es/k16MfEoyNlbOJ5ktI4dhBsaH8vKoF3rL63M
         ZhScmo4TdZjljkpGveKE8dKLA96t1X2yXS4H9ceFABEk8wzhiH9BfllsWeSAYOJKIiON
         oRKzOg0T5+0vfhdtXonWvnTsfwJ36OarafxG7elFoO6Rwj/CLN1KT1XBRQzpd9VI4d4u
         YYCg==
X-Gm-Message-State: AOJu0YywS2hb3o6Aa11Twj8Mt9/v45vZ+ob6idRli3QF7V3BPwv6OWEH
        LsztBxbuYprmIfoxz3cLxF0=
X-Google-Smtp-Source: AGHT+IGAWoyabaf/RqLP6c8QcSmQcc7MkCXyPzViAidlwrIkSt3NCBMOBMbRGre8YBKwCt5r8H5IzA==
X-Received: by 2002:a81:73c6:0:b0:5d7:1940:b395 with SMTP id o189-20020a8173c6000000b005d71940b395mr7074465ywc.97.1702487000412;
        Wed, 13 Dec 2023 09:03:20 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:e69d:88a7:9ea:4f0b])
        by smtp.gmail.com with ESMTPSA id ff9-20020a05690c320900b005e184771849sm1872201ywb.93.2023.12.13.09.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 09:03:18 -0800 (PST)
Date:   Wed, 13 Dec 2023 09:03:17 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v3 3/7] lib/group_cpus: relax atomicity requirement in
 grp_spread_init_one()
Message-ID: <ZXnj1WhpSgdMXSfS@yury-ThinkPad>
References: <20231212042108.682072-1-yury.norov@gmail.com>
 <20231212042108.682072-4-yury.norov@gmail.com>
 <ZXgszD9tIKY1tC9r@fedora>
 <ZXiPvgzZvXyWfarS@yury-ThinkPad>
 <ZXj3deNs91Ga471c@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXj3deNs91Ga471c@fedora>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 08:14:45AM +0800, Ming Lei wrote:
> On Tue, Dec 12, 2023 at 08:52:14AM -0800, Yury Norov wrote:
> > On Tue, Dec 12, 2023 at 05:50:04PM +0800, Ming Lei wrote:
> > > On Mon, Dec 11, 2023 at 08:21:03PM -0800, Yury Norov wrote:
> > > > Because nmsk and irqmsk are stable, extra atomicity is not required.
> > > > 
> > > > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > > > ---
> > > >  lib/group_cpus.c | 8 ++++----
> > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> > > > index 10dead3ab0e0..7ac94664230f 100644
> > > > --- a/lib/group_cpus.c
> > > > +++ b/lib/group_cpus.c
> > > > @@ -24,8 +24,8 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
> > > >  		if (cpu >= nr_cpu_ids)
> > > >  			return;
> > > >  
> > > > -		cpumask_clear_cpu(cpu, nmsk);
> > > > -		cpumask_set_cpu(cpu, irqmsk);
> > > > +		__cpumask_clear_cpu(cpu, nmsk);
> > > > +		__cpumask_set_cpu(cpu, irqmsk);
> > > >  		cpus_per_grp--;
> > > >  
> > > >  		/* If the cpu has siblings, use them first */
> > > > @@ -33,8 +33,8 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
> > > >  		sibl = cpu + 1;
> > > >  
> > > >  		for_each_cpu_and_from(sibl, siblmsk, nmsk) {
> > > > -			cpumask_clear_cpu(sibl, nmsk);
> > > > -			cpumask_set_cpu(sibl, irqmsk);
> > > > +			__cpumask_clear_cpu(sibl, nmsk);
> > > > +			__cpumask_set_cpu(sibl, irqmsk);
> > > 
> > > I think this kind of change should be avoided, here the code is
> > > absolutely in slow path, and we care code cleanness and readability
> > > much more than the saved cycle from non atomicity.
> > 
> > Atomic ops have special meaning and special function. This 'atomic' way
> > of moving a bit from one bitmap to another looks completely non-trivial
> > and puzzling to me.
> > 
> > A sequence of atomic ops is not atomic itself. Normally it's a sing of
> > a bug. But in this case, both masks are stable, and we don't need
> > atomicity at all.
> 
> Here we don't care the atomicity.
> 
> > 
> > It's not about performance, it's about readability.
> 
> __cpumask_clear_cpu() and __cpumask_set_cpu() are more like private
> helper, and more hard to follow.

No that's not true. Non-atomic version of the function is not a
private helper of course.
 
> [@linux]$ git grep -n -w -E "cpumask_clear_cpu|cpumask_set_cpu" ./ | wc
>     674    2055   53954
> [@linux]$ git grep -n -w -E "__cpumask_clear_cpu|__cpumask_set_cpu" ./ | wc
>      21      74    1580
> 
> I don't object to comment the current usage, but NAK for this change.

No problem, I'll add you NAK.

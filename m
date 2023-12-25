Return-Path: <linux-kernel+bounces-11129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF15181E1C9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 18:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43AB828252D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 17:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A3252F87;
	Mon, 25 Dec 2023 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgXmlNGu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB0351C36
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dbe165485d4so56123276.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 09:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703525897; x=1704130697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+qVYfNb+ln88k2U8sDJhGRbrHOCr6KMYYSe1kdUIoOQ=;
        b=MgXmlNGuIHbsGFKwqLbGEkup41RdZXo9/2VTEWfVn3UwvgxEi7O932ltRypM2oDWSy
         /k0OJF/sIWHs1xFIgoL8byuIwJVMzzZm2RjSdbGtE2iHkoV7wego6KEiDfr8OCooRRJJ
         cb8Vxv6y61ZtLfHtYhsyYsggoCoW8l/UjDRgoEg4iVImVI//tuIlgm0lh0+jth5gRvDI
         mLi0liiW7pgDhH1UKBmvcXEgG1A/8sAlAyPtYCTz2hB16uDKy2jMpK6Hn4udIIdwyTmX
         rDhgaq+gCWFXCNtzJcr/jXhiU963m6R1DWhA4VZUlAb42eJELRLS1viNAk2izPyJQxIw
         JArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703525897; x=1704130697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qVYfNb+ln88k2U8sDJhGRbrHOCr6KMYYSe1kdUIoOQ=;
        b=MyUz+sAR/4qSIcaJV61LryUmUrXO33AumunBCSQ/SaBCEEiZ5vUOUs0kL6fmdvrqlb
         8fLywrgXrm9YmKxfogN+ss80f2YiFzZnSv95INASzHcotcIPla7WvP0j2MokhLFdhitN
         V/i7LrveOhEdZZ6sCfQVzRssSa8Z2EyTE4hEa85vQzkovylDz9jpECtfc4+ybVSUqoXY
         CE0objH0AUj4j8mDEDfLxjFJs5WXsY3OgfYMoxLPBJ0hWV4qZ7I1umeYzd33NLergCxk
         vsYB8ICvHlXtPC3o7gNxW9D8KQkImU2FiHikmdplO1BHEBAbq+Fuf+4vuk+IRxn2clgK
         lFlQ==
X-Gm-Message-State: AOJu0YwvqMlCOFF4kc+BIjYNdTXpi/J0HOSU2LGgjJujmLEvK4tH/+KP
	Pz0tNTrTc45f+pnDMVfB08Q7V7nJMCE=
X-Google-Smtp-Source: AGHT+IGb2bnivbva6Krwe+FHUjAACqT0ftn2lC0hbe4UAiLyWzXW7cFZ4l8r+PZG+Mg1X4EHqLsYFg==
X-Received: by 2002:a05:690c:290b:b0:5e9:fa4a:fd56 with SMTP id eg11-20020a05690c290b00b005e9fa4afd56mr2133759ywb.13.1703525897109;
        Mon, 25 Dec 2023 09:38:17 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:3e97:6886:45bb:11c4])
        by smtp.gmail.com with ESMTPSA id gz1-20020a05690c470100b005eae538dd1asm2640058ywb.27.2023.12.25.09.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 09:38:16 -0800 (PST)
Date: Mon, 25 Dec 2023 09:38:15 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v3 2/7] lib/group_cpus: optimize inner loop in
 grp_spread_init_one()
Message-ID: <ZYm+B2m9gOTLOedE@yury-ThinkPad>
References: <20231212042108.682072-1-yury.norov@gmail.com>
 <20231212042108.682072-3-yury.norov@gmail.com>
 <ZXgsDcM21H/2BTck@fedora>
 <ZXiSk9J2ZBdsTnk0@yury-ThinkPad>
 <ZXj1mGAKz5cWy+Nr@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXj1mGAKz5cWy+Nr@fedora>

On Wed, Dec 13, 2023 at 08:06:48AM +0800, Ming Lei wrote:
> On Tue, Dec 12, 2023 at 09:04:19AM -0800, Yury Norov wrote:
> > On Tue, Dec 12, 2023 at 05:46:53PM +0800, Ming Lei wrote:
> > > On Mon, Dec 11, 2023 at 08:21:02PM -0800, Yury Norov wrote:
> > > > The loop starts from the beginning every time we switch to the next
> > > > sibling mask. This is the Schlemiel the Painter's style of coding
> > > > because we know for sure that nmsk is clear up to current CPU, and we
> > > > can just continue from the next CPU.
> > > > 
> > > > Also, we can do it nicer if leverage the dedicated for_each() iterator,
> > > > and simplify the logic of clearing a bit in nmsk.
> > > > 
> > > > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > > > ---
> > > >  lib/group_cpus.c | 13 ++++++-------
> > > >  1 file changed, 6 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> > > > index ee272c4cefcc..10dead3ab0e0 100644
> > > > --- a/lib/group_cpus.c
> > > > +++ b/lib/group_cpus.c
> > > > @@ -30,14 +30,13 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
> > > >  
> > > >  		/* If the cpu has siblings, use them first */
> > > >  		siblmsk = topology_sibling_cpumask(cpu);
> > > > -		for (sibl = -1; cpus_per_grp > 0; ) {
> > > > -			sibl = cpumask_next(sibl, siblmsk);
> > > > -			if (sibl >= nr_cpu_ids)
> > > > -				break;
> > > > -			if (!cpumask_test_and_clear_cpu(sibl, nmsk))
> > > > -				continue;
> > > > +		sibl = cpu + 1;
> > > 
> > > It doesn't have to 'cpu + 1', see below comment.
> > > 
> > > > +
> > > > +		for_each_cpu_and_from(sibl, siblmsk, nmsk) {
> > > > +			cpumask_clear_cpu(sibl, nmsk);
> > > >  			cpumask_set_cpu(sibl, irqmsk);
> > > > -			cpus_per_grp--;
> > > > +			if (cpus_per_grp-- == 0)
> > > 
> > > 			if (--cpus_per_grp == 0)
> >  
> > That's right, I'll send a new version this weekend.
> > 
> > > > +				return;
> > > 
> > > I think for_each_cpu_and() should work just fine, cause cpu has been cleared
> > > from nmsk, so the change can be something like, then patch 1 isn't
> > > necessary.
> >  
> > It works just fine except that it's O(N^2), where O(N) is easily
> > achievable. Again, it's not about performance, it's about coding
> > habits.
> 
> Both for_each_cpu_and() and for_each_cpu_and_from() are O(N), aren't
> they? Given both two are based on find_next_and_bit().

for_each_cpu_and() is the same Schlemiel the Painter's code, as the
plain for() was.
 
> for_each_cpu_and() is simpler and more readable, and more
> importantly, we can save one single-user public helper.
> 
> >  
> > > 		for_each_cpu_and(sibl, siblmsk, nmsk) {
> > > 			cpumask_clear_cpu(sibl, nmsk);
> > >   			cpumask_set_cpu(sibl, irqmsk);
> > > 			if (--cpus_per_grp == 0)
> > > 				return;
> > > 		}
> 
> 
> Thanks,
> Ming


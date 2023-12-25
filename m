Return-Path: <linux-kernel+bounces-11137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC4681E1EE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 19:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FF4BB2181E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 18:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A209C52F9F;
	Mon, 25 Dec 2023 18:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDHXyI6G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A774152F97
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bb8f3d9f98so2622880b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 10:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703527393; x=1704132193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TTwwJ8tmN6j1NykotOVTgc9yQ5nXK90UxGlg99Sewz8=;
        b=LDHXyI6GPng0zTfx1/B7I5H9lrotHm1v/Pdq6+2vpW44+ZCobC9R+zztw4v94jV6LQ
         sEh9gE7F/lCv1YWeUbd3XvVaAosoiWDh2inXjqjaj0tJdCTx5TDjlwgljGs5o/4NoqTs
         p2NE5M//rCNdD/lrFurZ3VTf2vz+/gMto277Zjheb1OD3t920HWXyHGmyve20KXrf7Ty
         qH85RH1PS8jAPqJ9Qtfq2V/H2rHG8kcdqQJ38LA6P5b4Bn2HnB+qaX15eFQ9M7g+wHPs
         fRaXIEuXgw4Jo2Htf56ACuwCbzfqTCQ5YpTEStgk1W1Pxn2tzPb/nkyJbOq7iFpmWR0u
         O7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703527393; x=1704132193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTwwJ8tmN6j1NykotOVTgc9yQ5nXK90UxGlg99Sewz8=;
        b=tOMKLUJ9IdZiXR8mToMfG80tk0HISwPdWNFpUByW92wLBI79fzW6oao9gpV4FrjTVa
         ZNuJzRLDpTmt7GSAdIYMDCsLRAU+JkkrJGHFFQkcVbW3B0DQnKHwMwYur3ZjWJyvEXNM
         Cm8ktJMHgWEWV6j1iXh6/Zq+IgPpcZvbuEij/Yg8XZ+oBNshAvsfVB/o9XLnLbK5CBjh
         dnGKQzkmWkPvpSBd33QOH0yU58ZPGTQelvlB/dVUfuLIkrf6eWZul/aYypQzmbBc4X1j
         0KwC3PL9aojCZuFDnlNJCFq2mmoFJMNDLtthEr7kTGa41F3kqC0hWVzW2xaY7nxxb/cR
         4Q3w==
X-Gm-Message-State: AOJu0Yy50qCANnrgamJZA8D3Gt2+tw1WT8PNqM4cxM0bkPU8lNxtGu7H
	qSG/DY59rvVjAPfc89RSpQhC6oAFk7w=
X-Google-Smtp-Source: AGHT+IEBcEvGgpfPnLoayYVKt+gVBj2XOTjle9Bi8rnf00otM84CKc847xXzFPObObxXzIUtVxguIg==
X-Received: by 2002:a05:6808:1285:b0:3b8:44e3:dfda with SMTP id a5-20020a056808128500b003b844e3dfdamr9520006oiw.3.1703527393462;
        Mon, 25 Dec 2023 10:03:13 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:3e97:6886:45bb:11c4])
        by smtp.gmail.com with ESMTPSA id g17-20020a25b111000000b00dbdbcb37e81sm3936465ybj.31.2023.12.25.10.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 10:03:12 -0800 (PST)
Date: Mon, 25 Dec 2023 10:03:12 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v3 7/7] lib/group_cpus: simplify grp_spread_init_one()
 for more
Message-ID: <ZYnD4Bp8R9oIz19s@yury-ThinkPad>
References: <20231212042108.682072-1-yury.norov@gmail.com>
 <20231212042108.682072-8-yury.norov@gmail.com>
 <ZXkDhBqtLAg054ub@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXkDhBqtLAg054ub@fedora>

On Wed, Dec 13, 2023 at 09:06:12AM +0800, Ming Lei wrote:
> On Mon, Dec 11, 2023 at 08:21:07PM -0800, Yury Norov wrote:
> > The outer and inner loops of grp_spread_init_one() do the same thing -
> > move a bit from nmsk to irqmsk.
> > 
> > The inner loop iterates the sibling group, which includes the CPU picked
> > by outer loop. And it means that we can drop the part that moves the bit
> > in the outer loop.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  lib/group_cpus.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> > 
> > diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> > index 664a56171a1b..7aa7a6289355 100644
> > --- a/lib/group_cpus.c
> > +++ b/lib/group_cpus.c
> > @@ -18,14 +18,8 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
> >  	int cpu, sibl;
> >  
> >  	for_each_cpu(cpu, nmsk) {
> > -		__cpumask_clear_cpu(cpu, nmsk);
> > -		__cpumask_set_cpu(cpu, irqmsk);
> > -		if (cpus_per_grp-- == 0)
> > -			return;
> > -
> > -		/* If the cpu has siblings, use them first */
> >  		siblmsk = topology_sibling_cpumask(cpu);
> > -		sibl = cpu + 1;
> > +		sibl = cpu;
> >  
> >  		for_each_cpu_and_from(sibl, siblmsk, nmsk) {
> >  			__cpumask_clear_cpu(sibl, nmsk);
> 
> Correctness of the above change requires that 'cpu' has to be included
> into topology_sibling_cpumask(cpu), however, not sure it is always true,
> see the following comment in Documentation/arch/x86/topology.rst
> 
> `
>   - topology_sibling_cpumask():
> 
>     The cpumask contains all online threads in the core to which a thread
>     belongs.
> `

It's kind of nontrivial to spread IRQs on offline CPUs, but
technically the above seems correct. I'll drop the patch then.


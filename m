Return-Path: <linux-kernel+bounces-5530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A53B2818BBE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F30C1F23512
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4325A1D539;
	Tue, 19 Dec 2023 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7Doi5+M"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADFE1D13C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d075392ff6so32396865ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 08:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703001646; x=1703606446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lU/xIQD40Nx1IILlXSAWoTy6NdNE76mzC5mKDdKyu0A=;
        b=S7Doi5+MXXSPfwEav8XwUPcf8kh01V1QuoUQnhAZMoUZdQoGu2GTgdeBw6GyVimMsT
         OcVGapRG3t2UbIWkv7RUJbebaYen8Rr0U+D/jlcbuyymiYv4/MatcyluWYYyzq6v1BpF
         GfCS+wiAwyBQkDK13cUVmsaWApalN4L91DoQ3WlaAJXp6QQTYHZqcqKDFtW2Fy8bRR+a
         6TXuFZ8skAQQerqdGE+/Tun55yeDT+4xepDTFqB6EXW5YYGS9cBJKwUrJK+n2AHAmNeh
         5pHYDtVcFqAHYBqebQzHG7xy0qrNh9eTD281DlDOC/KQXrD8DbGLKtag8VVq/R2I5avK
         P/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703001646; x=1703606446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lU/xIQD40Nx1IILlXSAWoTy6NdNE76mzC5mKDdKyu0A=;
        b=b/C3p4URkE9D+RrfTbSrbvtuEhQOBJ9+JZPS+CNuXGJfhKlQK1vpbxoGS+pqKt+Gig
         C8OAFHvKiII5lAjcttJ/YnVpbrO5oLTN2xWwbxTupAB0vdxTj43VF/q2THOyDkeWrHGH
         WEPMy8Z+ExTfsKlKG9W5gPoBiUqOGufSReJ6SwrMHDvrXv/ZgvI/PTbfTeKb8NTP5auv
         FqkMY6kk8jPdDTOASAvPTuLsSmUXsQibgLK6AO7D+F3ph0ZJW+oxzF26pWj0jHSElC6m
         vhFYcLYggIEmKAwOakX4i1DVr0VqrdxpHg69vhLHnTa8mHRrp/sV0MOEKPW0Y03nVHgu
         9uJQ==
X-Gm-Message-State: AOJu0YygkI19tDbwWGgNiD6iRI3jTlfjtjTdlCUHduotGIU2Ckdemwqf
	AKG99/qUFgSBdEkD55WpSLk=
X-Google-Smtp-Source: AGHT+IFaCR+UxMW1GwIzY4Cf0e5DLDTY/2Ufuz/6B18FozvWEa28zS8ChjlUDWe4vZSx7YdngezoDw==
X-Received: by 2002:a17:903:41c6:b0:1d0:6ffd:611c with SMTP id u6-20020a17090341c600b001d06ffd611cmr1790831ple.62.1703001645772;
        Tue, 19 Dec 2023 08:00:45 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id v23-20020a170902e8d700b001d08e080042sm21181544plg.43.2023.12.19.08.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 08:00:45 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: bhe@redhat.com
Cc: akpm@linux-foundation.org,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	dyoung@redhat.com,
	hbathini@linux.ibm.com,
	hpa@zytor.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	seanjc@google.com,
	tglx@linutronix.de,
	tiwai@suse.de,
	vgoyal@redhat.com,
	x86@kernel.org,
	ytcoode@gmail.com
Subject: Re: [PATCH 2/2] crash_core: fix out-of-bounds access check in crash_exclude_mem_range()
Date: Wed, 20 Dec 2023 00:00:35 +0800
Message-ID: <20231219160035.104391-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZYGnN2hKuXGbusNV@MiWiFi-R3L-srv>
References: <ZYGnN2hKuXGbusNV@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 19 Dec 2023 22:22:47 +0800, Baoquan He <bhe@redhat.com> wrote:

> On 12/19/23 at 12:31pm, Yuntao Wang wrote:
> > On Tue, 19 Dec 2023 11:32:02 +0800, Baoquan He <bhe@redhat.com> wrote:
> > > Hi Yuntao,
> > > 
> > > On 12/19/23 at 10:02am, Yuntao Wang wrote:
> > > > On Mon, 18 Dec 2023 09:29:02 -0800, Andrew Morton <akpm@linux-foundation.org> wrote:
> > > > 
> > > > > On Mon, 18 Dec 2023 16:19:15 +0800 Yuntao Wang <ytcoode@gmail.com> wrote:
> > > > > 
> > > > > > mem->nr_ranges represents the current number of elements stored in
> > > > > > the mem->ranges array, and mem->max_nr_ranges represents the maximum number
> > > > > > of elements that the mem->ranges array can hold. Therefore, the correct
> > > > > > array out-of-bounds check should be mem->nr_ranges >= mem->max_nr_ranges.
> > > > > > 
> > > > > 
> > > > > This does not apply after your own "crash_core: fix and simplify the
> > > > > logic of crash_exclude_mem_range()".  What should be done?
> > > > 
> > > > Hi Andrew,
> > > > 
> > > > I actually prefer the "crash_core: fix and simplify the logic of
> > > > crash_exclude_mem_range()" patch as it makes the final code more concise and
> > > > clear, and less prone to errors.
> > > > 
> > > > The current code is too strange, I guess no one can understand why there is
> > > > a break in the for loop when they read this code for the first time.
> > > > 
> > > > Moreover, I think the current code is too fragile, it relies on callers using
> > > > this function correctly to ensure its correctness, rather than being able to
> > > > guarantee the correctness on its own. I even feel that this function is very
> > > > likely to have bugs again as the code evolves.
> > > > 
> > > > However, Baoquan also has his own considerations, he suggests keeping the code
> > > > as it is.
> > > > 
> > > > The link below is our detailed discussion on this issue:
> > > 
> > > There's misunderstanding here.
> > > 
> > > Firstly I said I have concern about the patch, I didn't NACK or reject the patch.
> > > 
> > > [PATCH 3/3] crash_core: fix and simplify the logic of crash_exclude_mem_range()
> > > 
> > > Usually, when people said he/she had concern, you may need to
> > > investigate and resolve it or explain why it's not need be cared about.
> > > 
> > > E.g on above [PATCH 3/3], we can add below code change to stop scanning
> > > when the left ranges are all above the excluded range, assume the passed
> > > in cmem has a ascending order of ranges. Say so because I checked code
> > > and found that crash_exclude_mem_range() is called in arch arm64, ppc,
> > > riscv and x86. Among them, arm64 and ppc create the cmem from memblock,
> > > riscv and x86 create cmem from iomem. All of them should be in ascending
> > > ordr. The below code change based on your patch 3/3 looks safe to me.
> > > What do you think?
> > > 
> > > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > > index aab342c2a5ee..39b6c149dc80 100644
> > > --- a/kernel/crash_core.c
> > > +++ b/kernel/crash_core.c
> > > @@ -574,9 +574,12 @@ int crash_exclude_mem_range(struct crash_mem *mem,
> > >  		p_start = mstart;
> > >  		p_end = mend;
> > >  
> > > -		if (p_start > end || p_end < start)
> > > +		if (p_start > end)
> > >  			continue;
> > >  
> > > +		if (p_end < start)
> > > +			break;
> > > +
> > >  		/* Truncate any area outside of range */
> > >  		if (p_start < start)
> > >  			p_start = start;
> > > 
> > > Secondly, I welcome people who are interested kexec/kdump code, and raise
> > > issues or post patches to fix bug, clean up code. I like these patches.
> > > They can help improve kexec/kdump code and solve problem in advance.
> > > I would like to review and make the patches acceptable and merged
> > > inally. And I also hope people can follow the later issue reported by
> > > other people or LKP if their merged patch caused that.
> > > 
> > > Lastly, people are encouraged to help review other people's patch
> > > and give suggestes to improve the code change. If patch author don't
> > > respond for a long while or the work has been suspended for long time, we
> > > can add comment to tell and take over the work to continue.
> > > 
> > > These are my personal understanding and thought about kexec/kdump patch
> > > reviewing and maintance. So cheer up.
> > > 
> > > > 
> > > > https://lore.kernel.org/lkml/20231214163842.129139-3-ytcoode@gmail.com/t/#mfd78a97e16251bcb190b0957a0b6cb4b0a096b54
> > > > 
> > > > The final decision on whether to apply that patch is up to you and Baoquan, if
> > > > you choose to apply that patch, this patch can be ignored. But if you decide not
> > > > to apply that patch, then this patch must be applied, as it fixes a bug in the
> > > > crash_exclude_mem_range() function.
> > > > 
> > > > Sincerely,
> > > > Yuntao
> > 
> > Hi Baoquan,
> > 
> > I must clarify that I was not complaining about you. On the contrary, I am
> > grateful to everyone who takes time to review code for others, because I know
> > it is a lot of work.
> > 
> > I'm relatively new to the Linux community and still learning the various rules
> > of the community. I'm very sorry that I didn't fully grasp your previous intention.
> > 
> > Regarding the method you suggested to add a 'break', I did consider it initially
> > but later decided against it because the memory ranges obtained from iomem may
> > overlap, so I chose a safer way instead.
> 
> In iomem, parent range includes children's range, while
> walk_system_ram_res() traverses ranges not overlapped with each otehr.
> From code in __walk_iomem_res_desc() and find_next_iomem_res(), it
> clearly shows that.
> 
> walk_system_ram_res()
>   -->__walk_iomem_res_desc()
>      -->find_next_iomem_res()
> 

I revisited the relevant code, and yes, you are correct. The memory ranges
obtained from iomem do not overlap.

The reason why I thought these memory ranges would overlap was that I saw
that in the find_next_iomem_res() function, after traversing a parent node,
it starts to traverse its child nodes. If all these nodes meet our
requirements, then the memory ranges they represent will overlap.

However, I overlooked a very important point, which is that after finding a
valid node, the __walk_iomem_res_desc() function will update the start value.
This means that if a parent node is a valid node, all of its child nodes
will be skipped. This ultimately ensures that the memory ranges obtained
from iomem will not overlap.

I will post another patch later, optimizing crash_exclude_mem_range() using
your approach.

> 
> > 
> > Finally, I would like to apologize again if my previous response offended you.
> > That was not my intention.
> 
> No offence felt at all, and no worry about this. In upstream, argument
> is normal, it's fine as long as your intention is making things better,
> not against person. Meantime, let's be kind and friendly to each other,
> we will have a great time.


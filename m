Return-Path: <linux-kernel+bounces-67673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CF0856EF3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 867FAB2575E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6431213B2BC;
	Thu, 15 Feb 2024 20:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTWdWTFO"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EB26A349;
	Thu, 15 Feb 2024 20:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708030516; cv=none; b=KM3svwPKGBaIMeMnJBqlL3PXknvT+C1OEWGxX3hwbnC/9Zc3hfK5e6GJMTVS6csRM7QrEZSvL6NES8mKS3l9hdfHOUITGHE0zGagWBrddu4yDrNu6Pdtmfw8vbUzWxtIIZSeRFYhZWwvTq0EofFTWULNyH7veRxaut8OYH76hho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708030516; c=relaxed/simple;
	bh=+BMQn3bOtWH+FWUM64l+j3RtIw016nUn+Jnnh0s+X2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kn5N8qmlAAxRZhIhoiJYPfJS2Jd4OmSPffCJ5GDw1XGFjibs3FKOm/q5y5VXdn1fJqoLAKutgIt0NlYvaUejuUkj6tS8VFaYHCSdyd8q+p/opSDVJdMi/5LZTHpPuu1TQWoyd4lXha6nziNWT9ztaGn89oGFAIXO3xQ6KvUsm0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTWdWTFO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d7232dcb3eso10822795ad.2;
        Thu, 15 Feb 2024 12:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708030514; x=1708635314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7KeUmQ5rtQIKjg5bbnS3xkReICqYXg+NK0gShllzn0=;
        b=XTWdWTFO41LkP3ajBo/IfnkDBaOM5TO5ob3AWl+3iQV4d5UYxfDsbgb0k+KDwBSM7l
         CxrJUFNFm9LOs1ls15BwoQdwRPRBOq4FVf+sc+Tp2+DpbCGWMOB+JiVpj0aFv51oFEyW
         QvFo/JS+azW0zR/IDebriZJt3WbdkvLnXHpbM4tgFCuEVaywTez9hTtHYZEu7XRh6M9A
         JhKo/W04HXExW1pTVxZ6pHFOVmzB45sVuefClgs+4A6CxtSOBVIUtgPKXmNjXum/sbS2
         e+fu5sTzQ/JpTWdg4L61AaYV86MLiqEWGnfEsLG0UkUAM7lABG0C6djWjngrpdQ6kzMR
         7lcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708030514; x=1708635314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r7KeUmQ5rtQIKjg5bbnS3xkReICqYXg+NK0gShllzn0=;
        b=ex6hmhtN9VItBU7/i/z2gOxbJaOnKXX9pOZjAl4xkhr7+uzRy8zKPKtPgszDHG8Hl7
         +kyKvGOlZKMAFf00bbvHYduGl4ZjbM2X+7wp+9wNEcHtrxX+f9bJBO1pLIQCjCryb7gt
         F8CYp8yk8DSGBdj5q8dRUHeWag8VQo4anscYNcTBx1JdDrolLBe4BTmTeeCLHS9Jw+Nb
         ciT2feyuVOQVLlmRKJmpgz+EXdcdCqJ/Ng9jtj8RYmEID4GFXOz6ryVss/x+x0H8lSm4
         e+KuONewq8JY/iKdv+KQXlS7QjOhtOshrmVFxnF9GzOofrgzBHB6MC46MER9jofaQSgQ
         1fzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLtgHCAFKsMercILbrOjNCoOLRLKHO0dKVW3ck6erSNf4+XycaPSt5ReYD8Ns3Lzd8UR7GQbyTr/9P3IFHM1LcsuOzFRmTKPDcLwQRPfFonykvkd0NsVY2pf2E1E+r9BoSiYCL
X-Gm-Message-State: AOJu0YwK6oXof1NNG7Nk6WZig3pCXParU237DjeGqvcM8gGLKuP0ExK4
	0ZHOCTEcvJWNsKLBqeJZKXUPtEAZ6HrBOmJUSSpVwOVzv8VOVYnY
X-Google-Smtp-Source: AGHT+IF7vFLlsC6PM38G1zfNCpMrYhgcMQQS0vF9cRox0azJFhgKB3VSOd4zEVDtNy7j0rmcWMxpwg==
X-Received: by 2002:a17:902:7c01:b0:1d9:f495:cfa4 with SMTP id x1-20020a1709027c0100b001d9f495cfa4mr2658373pll.62.1708030514195;
        Thu, 15 Feb 2024 12:55:14 -0800 (PST)
Received: from google.com ([2620:0:1000:8411:9dc5:487d:7c08:30bb])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902e04900b001db561fa164sm1671380plx.25.2024.02.15.12.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 12:55:13 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Thu, 15 Feb 2024 12:55:11 -0800
From: Minchan Kim <minchan@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>,
	Yu Zhao <yuzhao@google.com>, Barry Song <v-songbaohua@oppo.com>,
	SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>, Yosry Ahmed <yosryahmed@google.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/swap: fix race when skipping swapcache
Message-ID: <Zc56L6oL4JmxqaFN@google.com>
References: <20240206182559.32264-1-ryncsn@gmail.com>
 <1d259a51-46e6-4d3b-9455-38dbcc17b168@redhat.com>
 <CAMgjq7Cy3njsQzGi5Wa_JaM4NaO4eDGO5D8cY+KEB0ERd_JrGw@mail.gmail.com>
 <4c651673-132f-4cd8-997e-175f586fd2e6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c651673-132f-4cd8-997e-175f586fd2e6@redhat.com>

Hi David,

On Thu, Feb 15, 2024 at 09:03:28PM +0100, David Hildenbrand wrote:

< snip >

> > > 
> > > We would detect later, that the PTE changed, but we would temporarily
> > > mess with that swap slot that we might no longer "own".
> > > 
> > > I was thinking about alternatives, it's tricky because of the concurrent
> > > MADV_DONTNEED possibility. Something with another fake-swap entry type
> > > (similar to migration entries) might work, but would require more changes.
> > 
> > Yeah, in the long term I also think more work is needed for the swap subsystem.
> > 
> > In my opinion, for this particular issue, or, for cache bypassed
> > swapin, a new swap map value similar to SWAP_MAP_BAD/SWAP_MAP_SHMEM
> > might be needed, that may even help to simplify the swap count release
> > routine for cache bypassed swapin, and improve the performance.
> 
> The question is if we really want to track that in the swapcache and not
> rather in the page table.
> 
> Imagine the following:
> 
> (1) allocate the folio and lock it (we do that already)
> 
> (2) take the page table lock. If the PTE is still the same, insert a new
> "swapin_in_process" fake swp entry that references the locked folio.
> 
> (3) read the folio from swap. This will unlock the folio IIUC. (we do that
> already)
> 
> (4) relock the folio. (we do that already, might not want to fail)
> 
> (4) take the PTE lock. If the PTE did not change, turn it into a present PTE
> entry. Otherwise, cleanup.
> 
> 
> Any concurrent swap-in users would spot the new "swapin_in_process" fake swp
> entry and wait for the page lock (just like we do with migration entries).
> 
> Zap code would mostly only clear the "swapin_in_process" fake swp entry and
> leave the cleanup to (4) above. Fortunately, concurrent fork() is impossible
> as that cannot race with page faults.
> 
> There might be one minor thing to optimize with the folio lock above. But in
> essence, it would work just like migration entries, just that they are
> installed only while we actually do read the content from disk etc.

That's a great idea. I was thinking to have the synchronization in the
page table but couldn't reach to the other non_swap_entry idea.

Only concern of the approach is that it would be harder to have the fix
in the stable tree. If there isn't strong objection, I prefer the
Kairui's orginal solution(with some tweak of scheduler if it's
necessary) first and then pursue your idea on latest tree.


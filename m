Return-Path: <linux-kernel+bounces-26298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D6B82DE39
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769F21C21EC6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEC717C7B;
	Mon, 15 Jan 2024 17:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9SZ7GCK"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B937917C6D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 17:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cd17a979bcso100688451fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 09:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705338698; x=1705943498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqN1HXQI0vB7XDw+H37JNuIh2GbV9Tph7FvOP9587hA=;
        b=S9SZ7GCKS15KY7cZ7vfOODL6vjMnS3RDrykIyjUqtH/u6nxnKTZrwLEUhjzyMHwjrn
         66mGimnqVxEEUY3c4uxH2NQ7Jp1m7PgVxpmj+cOWgc4/2vWwrL2vm+XHjPUwUU38muUU
         DTHPAQmEbzj5T/a1mWxpvlzqyzyDi20goLWZLuJEOx500oxDjz/vnddzu0ToiXJyMHg4
         sSmLs07Sjf350gh6r+vFSvLJG+XYpbH38YPZYz8+xbJlWwJTJ1EatZzQ+ZGkWLq/uUhp
         CDg5LWsg0fdvxMyGjHrE+DP2zDotwpgCl+UBdS/02FRFKVZHrb7MmuWGGYUE3EwigNCV
         0HCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705338698; x=1705943498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqN1HXQI0vB7XDw+H37JNuIh2GbV9Tph7FvOP9587hA=;
        b=wf02yBapzSLSOYt4LDuZtTSi0XZjTFHYrf3bewOMtufeqbreLuYjsn+/+EpNvOj8TA
         X959BUeHARC0XYwnEE3vM0tGOYbzmqVuyaURd7oiRB4it3r+gDLts+oj5mbooUE87Zlu
         f38E6wqpiKhr7/F66oMO2Iy1WD63UxuSiF7mbNvijMTTZ7bMw5wY63cG/6tYl3AuwFpd
         vt9bdwsAPgQuArpDQFBb/IBVVvFavilaqreKpZ459FyxGoqaBphTlRZp+9CERYeUthhr
         GOcS8es2HlMLZmPJ71dmMac1iDllQsNqrIxTwsJPVHsq1O1fLOAasMeRspghuSEhA2E+
         W2CQ==
X-Gm-Message-State: AOJu0YwvIJIw6J5gLKLSqrJsV/KtOFE74cse4PLCGnnsmxe/JkEpSKVf
	LuNHfVBU//ZlUns9Jhcd6xHhtjiq9/CExqTIC78=
X-Google-Smtp-Source: AGHT+IGlpmbMQuPBilgG6GN7fTDb4D57XTy6h2ucDyxAnRhFvZyEVIOSP/T/tlkXZXjnDy2lNOIc6ac0PIVq5yaMWjQ=
X-Received: by 2002:a2e:9e97:0:b0:2cc:606b:fcfd with SMTP id
 f23-20020a2e9e97000000b002cc606bfcfdmr1229911ljk.167.1705338697681; Mon, 15
 Jan 2024 09:11:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102175338.62012-1-ryncsn@gmail.com> <20240102175338.62012-7-ryncsn@gmail.com>
 <87a5pg9qno.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAMgjq7Ce6sCSTRd==N3ihrAcvVd2ggszdZuTwxDbFYcBWzcE_g@mail.gmail.com>
 <87wmsb1ia8.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87wmsb1ia8.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 16 Jan 2024 01:11:20 +0800
Message-ID: <CAMgjq7BERdjq5JESbvgNXteC1JCnSR2faM9OLY=1TaGz-PZxrA@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] mm/swap: handle swapcache lookup in swapin_entry
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Huang, Ying <ying.huang@intel.com> =E4=BA=8E2024=E5=B9=B41=E6=9C=8815=E6=97=
=A5=E5=91=A8=E4=B8=80 09:47=E5=86=99=E9=81=93=EF=BC=9A
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > Huang, Ying <ying.huang@intel.com> =E4=BA=8E2024=E5=B9=B41=E6=9C=888=E6=
=97=A5=E5=91=A8=E4=B8=80 16:28=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> Kairui Song <ryncsn@gmail.com> writes:
> >>
> >> > From: Kairui Song <kasong@tencent.com>
> >> >
> >> > Since all callers of swapin_entry need to check the swap cache first=
, we
> >> > can merge this common routine into swapin_entry, so it can be shared=
 and
> >> > optimized later.
> >> >
> >> > Also introduce a enum to better represent possible swap cache usage,=
 and
> >> > add some comments about it, make the usage of swap cache easier to
> >> > understand.
> >>
> >> I don't find any benefit to do this.  The code line number isn't
> >> reduced.  The concept of swap cache isn't hided either.
> >
> > Hi Ying
> >
> > Thanks for the comments.
> >
> > Maybe I should squash this with the following commit? The following
> > commit want to do cache lookup in swapin_entry to avoid a redundant
> > shadow lookup, it can help to improve the performance by about 4% for
> > swapin path.
>
> It's good to improve performance.  But I don't think we must put
> swap_cache_get_folio() in swapin_entry() to do that.  We can just get
> "shadow" from swap_cache_get_folio() and pass it to swapin_entry().

Good idea. My only concern is, if the argument list is getting too
long (7 args if we added all mpol, ilx, shadow here), will that cause
issue for readability or performance?


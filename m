Return-Path: <linux-kernel+bounces-47410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ACD844D9B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D039B22C8B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAD11110;
	Thu,  1 Feb 2024 00:08:04 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBD137A
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 00:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706746084; cv=none; b=KFa3Hvqf/qhWFBnUIX6QBJHrvC1OZAH3ILH3A3wG9rZniCTqD6xBa689OzLfJtvGooh630WjZo3vDb5Q+aGq2vm1rafiqJFPnYhmmWI0HDPBiiMNbUODDhIa2WTiKOurwmuYvmTB/x9bNJmrf1I5aCgV11kqf9Yhy3m0nfVGvKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706746084; c=relaxed/simple;
	bh=38P365134+J9VPA+zhc8aLgUCIaPw0JB4YMCk+7cmFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=may6KoRbiWsT5pu/ZXsUx76aoK8SaIXyV1uEQnnWaLzX/pJQfWmKdxt+WA0NWYWPimWLNpjyOwb6QnzLmReA/NqRMKkkKlpIE+tsCaUIKdQxBxFeny0I7QrBQUYDRo/6BJw5S3+OoE9OPqYYiJS8SCk+F2kjopKs8v3tNkzxNyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-68c3a14c6e7so1838696d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 16:08:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706746081; x=1707350881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrs2I23dhH0mTURdgAb5k5EfiOmRT2De1cDkKW/nTGE=;
        b=HHUHTIYKqPhUek/9OPYZ7Ewq30Ixd/79JEfD0qwJBFxHbeWDjoXrjimvTEVUYB1opd
         4P/hYn5nkJDHp9dfT7qbgv8IWHwTxyafPy7g+Kz2nvDd7/ClmboLoBaRBaUkDVacbjY0
         PwWnI/uVTVl2NvpyZbt1LzuUroBbk+5Wpkgx0/RInMCwYlZM+1MTP102iqJE7SpbKisj
         +rD+RwsL52Cjh2eR52ZAZK9+vbCuVQR5W92w6Daf/wMkkXbTm/ip0RfissmvOlF6c4V5
         lL/5hZ9yddAirpjp/7fQrRcKhFeiJAQi3FkWpZ3dP/BS1t1Va2u58c/4IA5719B9iGYe
         3uhQ==
X-Gm-Message-State: AOJu0Yw+Nz260kx+0LajWfRi4c0YJikfjF/hGXv0TuKbYyRNQsE4QSvh
	/scWKkOKsajxb3xlVnWdnDHFWGHT8PQ1VC3hkd5ddTPHZ4FlEM2kz3oXuzu/TA==
X-Google-Smtp-Source: AGHT+IEe3YqJohRcAR1VwoxJkrEhnRReH5b/r+upsva+yD3zxs9J8V7tz0UiYmRaCPklzW0kkC04PA==
X-Received: by 2002:a05:6214:4105:b0:68c:5d76:2ed7 with SMTP id kc5-20020a056214410500b0068c5d762ed7mr964043qvb.46.1706746081232;
        Wed, 31 Jan 2024 16:08:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXrW6E1QlCIEvdGVX53QLZt5ZxVN2lYtBdrwhU8x8EI350kfPWELndRJ9m3hjLrqF+OA/jmM3H433A6hI5canmqO5rNjU3V95LIVKL6r5bvMVucwZxjY7Wzn2rcDvGDRxumln2g6oX7csjzoMbiqW/eCVi5sErdBf16+SKQ8SY1sxd7+bPHOq0VAavE6BO5lo2F48H3ALmH8KxSXpUrjDb+z0hd0IBkZv5QxSXXm7wR9UfEyNOTJUBWCZ4cLl9NtY7aZLRhXZ0MWKYPYkznsLZg1emSIWIvH3Ve86QFjMtSR/nq29VR77c9OMtXj2RRM3nSay4IPh9wOmWV38a0pTd7XTaFvNETUlj+cs4k0igz3oC8gTNu2VEwG7nBTPlc+N2LOI/JiPsM51rCXhQvxizYKrDABHRCsJqH2yVYnuwFN8G6fbw6IDH1sa+Bnw==
Received: from localhost ([107.173.73.29])
        by smtp.gmail.com with ESMTPSA id pc4-20020a056214488400b0068c6d0c3f5esm265608qvb.58.2024.01.31.16.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 16:08:00 -0800 (PST)
Date: Wed, 31 Jan 2024 19:07:57 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	ignat@cloudflare.com, damien.lemoal@wdc.com, bob.liu@oracle.com,
	houtao1@huawei.com, peterz@infradead.org, mingo@kernel.org,
	netdev@vger.kernel.org, allen.lkml@gmail.com, kernel-team@meta.com,
	Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH 8/8] dm-verity: Convert from tasklet to BH workqueue
Message-ID: <Zbrg3aRFkgS7XCFE@redhat.com>
References: <20240130091300.2968534-1-tj@kernel.org>
 <20240130091300.2968534-9-tj@kernel.org>
 <c2539f87-b4fe-ac7d-64d9-cbf8db929c7@redhat.com>
 <Zbq8cE3Y2ZL6dl8r@slm.duckdns.org>
 <CAHk-=wjMz_1mb+WJsPhfp5VBNrM=o8f-x2=6UW2eK5n4DHff9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjMz_1mb+WJsPhfp5VBNrM=o8f-x2=6UW2eK5n4DHff9g@mail.gmail.com>

On Wed, Jan 31 2024 at  6:19P -0500,
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 31 Jan 2024 at 13:32, Tejun Heo <tj@kernel.org> wrote:
> >
> > I don't know, so just did the dumb thing. If the caller always guarantees
> > that the work items are never queued at the same time, reusing is fine.
> 
> So the reason I thought it would be a good cleanup to introduce that
> "atomic" workqueue thing (now "bh") was that this case literally has a
> switch between "use tasklets' or "use workqueues".
> 
> So it's not even about "reusing" the workqueue, it's literally a
> matter of making it always just use workqueues, and the switch then
> becomes just *which* workqueue to use - system or bh.

DM generally always use dedicated workqueues instead of the system.

The dm-crypt tasklet's completion path did punt to the workqueue
otherwise there was use-after-free of the per-bio-data that included
the tasklet. And for verity there was fallback to workqueue if
tasklet-based verification failed. Didn't inspire confidence.

> In fact, I suspect there is very little reason ever to *not* just use
> the bh one, and even the switch could be removed.
>
> Because I think the only reason the "workqueue of tasklet" choice
> existed in the first place was that workqueues were the "proper" data
> structure, and the tasklet case was added later as a latency hack, and
> everybody knew that tasklets were deprecated.

Correct, abusing tasklets was a very contrived latency optimization.
Happy to see it all go away! (hindsight: it never should have gone in).

Mike


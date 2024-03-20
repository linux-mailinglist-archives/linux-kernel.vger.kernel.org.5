Return-Path: <linux-kernel+bounces-109341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC0A8817D2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39AAC2831C2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A1E8563A;
	Wed, 20 Mar 2024 19:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4uwQfLMO"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350E76AFAE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 19:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710962914; cv=none; b=VtNlypYaD9oHBj/M9FyDxOhTDzUGLaROgDQh5mFz/DVU3abw6QVtkMqAQvoRxu0kguefCN04pdzbJSLbHEyRDS9yeS9f1eTU2vg7YFOqKsxZJzkV0emKnA5OE2M7vpHIF9FWmMRlMvH03WB4M80UES6S/V8uJatIN6qava4d0/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710962914; c=relaxed/simple;
	bh=mDuVEhUMYtJTDQ94mEG7xFcUqs3IDM9EbARDdeAsOIE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nRRDQbmgaqwCdsGCjSxMOidtrTf4jG+yVDfE0PO3l0xENoVmtKq+qNZc2VLHUWegWHaESUMH0T31dbTKPZjaub4wB3IZLruPaSaktEqWe3PR19UibrMbtsAN/+oLjIrZutxLZLyMXrmpg67pj7BmvK0CoRstOt0rxLL/hfdIHJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4uwQfLMO; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcf22e5b70bso235010276.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 12:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710962912; x=1711567712; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h4SyzynV5kX7MGboSnnV/iVwc1cNoxGH6Rcm33p1x8Q=;
        b=4uwQfLMOr16D87KFtFpggKSQ3QKx4671uOpGxv35YLSD3ornAc+s7b31qUm8lzdCOL
         6d3T22heRywErbvg2ZL/Yex+CrfBFvptyTPjHU4Hs+aURGzG3M/YJk0GdF3kp/+6+91/
         HK/iyJg0lg2M2BTg0RiGQ8jPaZtResPpLdayfVzFq1CjF0xrYWfNROp/KaH7DloAYtJh
         MqhBL/eNpYQ6paaYqvx6XnDuFKHyK3WV8OMbGZavBMkr32LcABDl69l+Y8sEm0kd5yXC
         EA695mrJ7z0xbmObRYQOMlDjtcUoDtdYJ9Mq4Y1lXMTK/N/llp1GAwpSLANqZPFmgAZu
         QLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710962912; x=1711567712;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h4SyzynV5kX7MGboSnnV/iVwc1cNoxGH6Rcm33p1x8Q=;
        b=WAeNPZnoQvBO4gzw6JBe5pd52+DDhlR3HFniA6H7erD4Wy+WKyeWQOKPy4jMbYTyhE
         X6to1AM/+wEzChS/blrvcPv3no2VKJAYvNoEdNMQLB/v66WxzkLSRBJUt+u1b4KrWM4j
         PwPAVfdGInXVkW+K2oJt1z6EWBVLLzodoBw6h6TyhLtNehTs9KJqhoE6POw2ss3tn7gw
         +LzPHACgx5el3J7af/VQYnnzLFQVndZd/ipHNkUeTQZz/57YA0eeu6fHNr+kdODVHZSk
         Ylq3WwFo2EevZ+vcdhx6nMrQwVbZGsKae/gpDJE1hMB2q3l2dPyJlDOs+0e9XeoYBwd8
         w2xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy8DDUZzniHMDhQYhft73kc5hxyhFvtm4RdcDta3OQhceL3jo5nTELZS9IEvVr+ICmAuZuLlIiy+Gogmd/adcNxtbKLE8GRLAv3KAK
X-Gm-Message-State: AOJu0YwU6NwFv16HgiYxysx8ebPN5d5PXxAUst5jWl93ZUhWht3RGSSA
	hUkSEHw/VPXYURXQbLcmfM/fkxgFW9WJ2S1u2qXeTGqKIrb1MDBrDGW+0NxReYQoH7CM5VWmUnv
	OutVkirNdIRNm1S3cdA==
X-Google-Smtp-Source: AGHT+IH3a2dQUxC4TJSM4dA/PWt+9z6duiRiapgfOcxtEUugqqSLV6X19kmuyZEz4bKbMgETq97MM2uua0qVf8fu
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:200b:b0:dc8:27e6:cde1 with
 SMTP id dh11-20020a056902200b00b00dc827e6cde1mr1029333ybb.5.1710962912296;
 Wed, 20 Mar 2024 12:28:32 -0700 (PDT)
Date: Wed, 20 Mar 2024 19:28:30 +0000
In-Reply-To: <20240320095053.GA294822@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240320020823.337644-1-yosryahmed@google.com> <20240320095053.GA294822@cmpxchg.org>
Message-ID: <Zfs43iLE0RNcQPSj@google.com>
Subject: Re: [PATCH 1/2] mm: zswap: increase shrinking protection for zswap
 swapins only
From: Yosry Ahmed <yosryahmed@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Mar 20, 2024 at 05:50:53AM -0400, Johannes Weiner wrote:
> On Wed, Mar 20, 2024 at 02:08:22AM +0000, Yosry Ahmed wrote:
> > Currently, the number of protected zswap entries corresponding to an
> > lruvec are incremented every time we swapin a page.
> 
> Correct. This is the primary signal that the shrinker is being too
> aggressive in moving entries to disk and should slow down...?

Right, I think that's where I was confused. See below :)

> 
> > This happens regardless of whether or not the page originated in
> > zswap. Hence, swapins from disk will lead to increasing protection
> > on potentially stale zswap entries. Furthermore, the increased
> > shrinking protection can lead to more pages skipping zswap and going
> > to disk, eventually leading to even more swapins from disk and
> > starting a vicious circle.
> 
> How does shrinker protection affect zswap stores?
> 
> On the contrary, I would expect this patch to create a runaway
> shrinker. The more aggressively it moves entries out to disk, the
> lower the rate of zswap loads, the more aggressively it moves more
> entries out to disk.

I think I found the source of my confusion. As you described, the
intention of the protection is to detect that we are doing writeback
more aggressively than we should. This is indicated by swapins
(especially those from disk).

However, this assumes that pages swapped in from disk had gone there by
shrinking/writeback. What I was focused on was pages that end up on disk
because of the zswap limit. In this case, a disk swapin is actually a
sign that we swapped hot pages to disk instead of putting them in zswap,
which probably indicates that we should shrink zswap more aggressively
to make room for these pages.

I guess the general assumption is that with the shrinker at play, pages
skipping zswap due to the limit becomes the unlikely scenario -- which
makes sense. However, pages that end up on disk because they skipped
zswap should have a higher likelihood of being swapped in, because they
are hotter by definition.

Ideally, we would be able to tell during swapin if this page was sent
to disk due to writeback or skipping zswap and increase or decrease
protection accordingly -- but this isn't the case.

So perhaps the answer is to decrease the protection when pages skip
zswap instead? Or is this not necessary because we kick off a background
shrinker anyway? IIUC the latter will stop once we reach the acceptance
threshold, but it might be a good idea to increase shrinking beyond
that under memory pressure.

Also, in an ideal world I guess it would be better to distinguish
swapins from disk vs. zswap? Swapins from disk should lead to a bigger
increase in protection IIUC (assuming they happened due to writeback).

Sorry if my analysis is still off, I am still familiarizing myself with
the shrinker heuristics :)

> 
> > Instead, only increase the protection when pages are loaded from zswap.
> > This also has a nice side effect of removing zswap_folio_swapin() and
> > replacing it with a static helper that is only called from zswap_load().
> > 
> > No problems were observed in practice, this was found through code
> > inspection.
> 
> This is missing test results :)

I intentionally wanted to send out the patch first to get some feedback,
knowing that I probably missed something. In retrospect, this should
have been an RFC patch. Patch 2 should be irrelevant tho, I only
bundled them because they touch the same area.


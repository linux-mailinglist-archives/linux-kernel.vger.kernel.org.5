Return-Path: <linux-kernel+bounces-121866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9015088EEBC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD691C34220
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E28114F9D4;
	Wed, 27 Mar 2024 18:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="hfd9afpQ"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167E75227
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 18:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565866; cv=none; b=ZzEH9lROblWqOW0RwPEP8GX0nG8oUdFYh2dcEcSgPJoxoggYuVZ2saCjOGyY8sX8klotNG+u5Maxt8hpnIHv5agdluZ/7zFwoW1i9HT68C2wtv6LDv3gYqoih680Q6fR1QMVaQp+af7vx3011YIKpptWS82195Pa9e5XthJ8hcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565866; c=relaxed/simple;
	bh=UWlb39rNnhJICWDTAJ4u/xML15Uxsp5ZaVNujtpwBcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uww1OADKEm7vXyG5EFWoJ3XjzSNGwuJ9snS8HBJ5oW/vU0dsuilBUbOf7HmvxUx2wQtvfGMizgpoOl8wQvghF3ooQrX4duVa+RVrEqTUM5DJdNBGBEPxK4is+ceuLWTlZskHK0ccc3z2oFluDq0OKDiSUl/iYarSRWxSPyVTlx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=hfd9afpQ; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-69699fecccdso1245206d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1711565862; x=1712170662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1l8LwEAqTqzUC45r7vgbxldnGKxvJq2VhJB7bphMGJc=;
        b=hfd9afpQ2WhEHjxSIUBZWTPlae2Q7WJCmyjmY/f3PfTB7qSLWtK0ZjlRCQWWAsEl36
         DgU9XeqZN2COxOhd35mLPkTZyooeMbzRJyhyz2udfBghHoeqPf4hVGLJ9g0KJXcBVR8A
         hHOo+CGUFKTJI2AEEFV9y0/wEwUYejTTWY369nt4oCTfnSR1uqosGDnW83DCaoGFR1pm
         Mbi/itoiurfNEVzll+1+rDxmNOvXiFHMR2sU0iL1+MUuwy+Z5MkOGDWeePafbFctlh/L
         Wtgky7YilqXhQK+L9PtlSNfRhrZcdE9rUvzgHuvu0oCmnG4yOV0M0AzcP2wPiW8xUYCM
         2LGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711565862; x=1712170662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1l8LwEAqTqzUC45r7vgbxldnGKxvJq2VhJB7bphMGJc=;
        b=S3PTEwWDQUc5XrTlK7ZPpPNvLzNp0WoxisHzYF0oWQC/b8vRtT85NJ1EOyRT5dOjGt
         zMtVgp1Y5P2vqBufs+M2rRFo3rxLBtaxPAUQgF7XHX2e7N05ijLu+KmTu24qztIVvUs0
         +F7c9HKDOzmF8SbxB7lrtHUGN7MF4jcmuAZsQBcPpsjRLcP3n+PRwcX6IRWy039sQ0Km
         pgbksCTsjSxkRbxviN+RKeJYv7x5ytelc7+8wtGVnBWr3cvyniLu4ylBjEcDTma2CDgs
         SemDADYT7fqE5GX8Fm6bZQQ8rh2G4xNDG5GKGIZAeM99qDA/DRJJSHjs1tLoK2sFNY1U
         kKQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKXFupwKejTkNAP9O59T1EKazcXVzcLG9f6EawXBHtWzyc9ezDLYxuu1fdfV9vRDHWAw3mo8FpfKM/qsiow/U2g3w2Cgwr8RSGdVv5
X-Gm-Message-State: AOJu0YzgiOn4b6GU9R9FoI8h1z9aJbWN4IJev3UiejfkSasCha/HVjCL
	i2tClw8MNEWO/T6LbU7KhV4hdaAGvwrG8jq3X0fINjmyesV2YIE8LG2YN0F+UgA=
X-Google-Smtp-Source: AGHT+IEN8/WSSGf+HicRD3a4NBcuHxxIchLwLgRERsJP0K+obubQTmVi3qnRCMwz70vMLWE9Bgcvgw==
X-Received: by 2002:a05:6214:519b:b0:691:57c4:b918 with SMTP id kl27-20020a056214519b00b0069157c4b918mr461268qvb.37.1711565861450;
        Wed, 27 Mar 2024 11:57:41 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id fo15-20020ad45f0f000000b0069680284380sm4737449qvb.56.2024.03.27.11.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 11:57:41 -0700 (PDT)
Date: Wed, 27 Mar 2024 14:57:36 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mm: page_alloc: consolidate free page accounting fix
Message-ID: <20240327185736.GA7597@cmpxchg.org>
References: <20240320180429.678181-1-hannes@cmpxchg.org>
 <20240320180429.678181-11-hannes@cmpxchg.org>
 <b5b09acc-8bca-4e8c-82d4-6542fc7e9aec@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5b09acc-8bca-4e8c-82d4-6542fc7e9aec@suse.cz>

On Wed, Mar 27, 2024 at 09:54:01AM +0100, Vlastimil Babka wrote:
> > @@ -252,7 +252,8 @@ static void unset_migratetype_isolate(struct page *page, int migratetype)
> >  		 * Isolating this block already succeeded, so this
> >  		 * should not fail on zone boundaries.
> >  		 */
> > -		WARN_ON_ONCE(!move_freepages_block_isolate(zone, page, migratetype));
> > +		WARN_ON_ONCE(!move_freepages_block_isolate(zone, page,
> > +							   migratetype));
> >  	} else {
> >  		set_pageblock_migratetype(page, migratetype);
> >  		__putback_isolated_page(page, order, migratetype);
> 
> Looks like a drive-by edit of an extra file just to adjust identation.

Andrew, can you please fold the following fixlet?

From fa8dae0b39c5acfd4c0035c5a25b706b3a105497 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Wed, 27 Mar 2024 12:19:17 -0400
Subject: [PATCH 1/3] mm: page_alloc: consolidate free page accounting fix

undo unrelated drive-by line wrap

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_isolation.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 914a71c580d8..042937d5abe4 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -252,8 +252,7 @@ static void unset_migratetype_isolate(struct page *page, int migratetype)
 		 * Isolating this block already succeeded, so this
 		 * should not fail on zone boundaries.
 		 */
-		WARN_ON_ONCE(!move_freepages_block_isolate(zone, page,
-							   migratetype));
+		WARN_ON_ONCE(!move_freepages_block_isolate(zone, page, migratetype));
 	} else {
 		set_pageblock_migratetype(page, migratetype);
 		__putback_isolated_page(page, order, migratetype);
-- 
2.44.0


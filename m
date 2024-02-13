Return-Path: <linux-kernel+bounces-64423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DADF853E27
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24424295D60
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D51765BA4;
	Tue, 13 Feb 2024 22:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="U6bGLUkR"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28066634E2
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861914; cv=none; b=TKm21AcnlIVidivAeTVvOtjeORI7zd3yQ87TTR0jXuGzc5qlkf7/bq4LDo4FRSEwfKRnZuN62YI9cu2MYsofqPupJel5O/qFiP3bxCzgg1c7fEMKEixL61aACCUbRL2QK0SAq8wIr5s+SukEGWf+mWZXK6HW1RcF960rDyLek7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861914; c=relaxed/simple;
	bh=suItsco9lbw8hJoRDqg16N7pxhcLhGSZp1ZWz5pz2sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0DHBct6KZWo4hTIiE3qgiZ06CDelR/7bBfgY/142yAwQSCgWOmK+Fl0UyqAogQfugSLdQVuGWWmqn+U28dwe7jmNSrQLzB/8Axl6HaKPg22UKF1VhWignNAzNDOQffYfOICfnIQxGyPn3VM5yHkMvARSFVXRXA5PgrUWM8UrPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=U6bGLUkR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d93edfa76dso39174465ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707861912; x=1708466712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zxTPnHMwho/QvBEAp6J5gSJOcoigdJFb8fFY0i0+CiE=;
        b=U6bGLUkRnXzfKBPYYdyJYo2poB8fvKblHB8jllg66OB0P/YTeMp2EPK9pFZG+NLpea
         KzPz3j6wW9Ja2Afz8UsTb5vM4YPa85IdCyI8QRslbbrkvo5+yU1vwXH0+jg/0oHWMCa3
         FyQ3AMbtqIls9wHq34lWJ3ZuZATtUjlQRHpbdIhrqvw2NpW5TZGjM3C+BqCqV1YzTDxv
         j0SQ+6rtvrsc+cbRP3qG/Sdi2T0ZrKQ1Gx2IXCLKcD+u5TjMaaf+t+6Kszg9w5r9dDuE
         9T1Mokkt3jkYnMmbe6vUl2UIem89tA/AW3MQ/arxJ9Dd9a5JfCsN27GHSgEoIeUpvDBc
         AbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707861912; x=1708466712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxTPnHMwho/QvBEAp6J5gSJOcoigdJFb8fFY0i0+CiE=;
        b=ZesT5vxG+46Gb/Ie/5CP6U7O6j/PCWoicwEB8XjayQDSM2w5yzqKI4lXnvWI+FxZQ7
         uv00vavtwEPks1+5cx1iohPUmbT/pN6dEBVV2T4P8vT3izo/I8gOcQDErvUHMMvZS0To
         BVKNg4s67vWXSTcBf6lMaKKllUiWUbmuznbtdygFndz4j78E4jsEUGp+gsEwTi7XNx9z
         dWf2Me56aF4wcQC9ZDvd0PglKf53lX3mqAxAQKjUplhUPBx9ZKZR1FAsnMyARWMLmFRE
         7Frhg7nBvrEhWKw3bKK3Hu8UVcvmAc+y2tFKL9oPAreEToPWMREFwsPVFzu1uXwK47/+
         AN/w==
X-Forwarded-Encrypted: i=1; AJvYcCWPut/O17M5IepOcsPhMDemFSxr02LaDdE9mzCblUtTpZD/GDM1D32vKvYGdSym0LLkIWzaY0LvWthmbG2BINJ1o+WQ9g8Zu1xKkhk0
X-Gm-Message-State: AOJu0YyTiwSMpnXx/JwHbWLmpqwMdoYy6geLrXAacBgFrqDdr8Ep1P3Q
	Ba56SBCW6vnbwK1aFzexxxf74LgrB09MKPM7teU5ecdM5p0UDaRxkEx1x2xHIwc=
X-Google-Smtp-Source: AGHT+IF82en1msSr2UUhz5P7myVs3qqnSdr1YnVJOITnYKQsqXLIAKVz29FyzyRjKRLmgtgEUGksBg==
X-Received: by 2002:a17:902:f54e:b0:1da:2122:be72 with SMTP id h14-20020a170902f54e00b001da2122be72mr877913plf.62.1707861912460;
        Tue, 13 Feb 2024 14:05:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWNVslcy2CAz1NRb/5d+KN3jJLtTQJtXWrTgq/ta8v3FFRBl6CGiVGbsxOxKDs8m422Tfcq+8vCkdU+sYP7LGeX++phm+S55+t26MXMMsndkwwqRnwnU9xZg2Qgi6m/5l3O0VrPOkw9FbLFt1NWtZtryQlowAELa9JkEnPBQ0GrygFTReZIowO/4rLg8f+I7l1HA95NVGHE4YTrLE3iFDiZRboLYSS3YKTsLLA5LbBk5iueCIQUVyhOpfkINgrxD5PSHWE8B015H9REUdxQPXoU+/tVqkS/QdjvmhXJCcsP+ArU7MDdjrOz+M0pX6gIUqgmKcXNXBZldPXK2iPEWrJRrtcgd+kEbeCr9M6oVZWH5bQhn3BU7NRnNRHGSprdqdBbZ3K6qah/usHW1tB+c0gBSzP7rhQ6IlGVzUA=
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id l4-20020a170903004400b001db45bae92dsm1056308pla.74.2024.02.13.14.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:05:11 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1ra0tp-0067eX-1P;
	Wed, 14 Feb 2024 09:05:09 +1100
Date: Wed, 14 Feb 2024 09:05:09 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org,
	kbusch@kernel.org, djwong@kernel.org, chandan.babu@oracle.com,
	p.raghav@samsung.com, linux-kernel@vger.kernel.org, hare@suse.de,
	willy@infradead.org, linux-mm@kvack.org
Subject: Re: [RFC v2 03/14] filemap: use mapping_min_order while allocating
 folios
Message-ID: <ZcvnlfyaBRhWaIzD@dread.disaster.area>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-4-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213093713.1753368-4-kernel@pankajraghav.com>

On Tue, Feb 13, 2024 at 10:37:02AM +0100, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> filemap_create_folio() and do_read_cache_folio() were always allocating
> folio of order 0. __filemap_get_folio was trying to allocate higher
> order folios when fgp_flags had higher order hint set but it will default
> to order 0 folio if higher order memory allocation fails.
> 
> As we bring the notion of mapping_min_order, make sure these functions
> allocate at least folio of mapping_min_order as we need to guarantee it
> in the page cache.
> 
> Add some additional VM_BUG_ON() in page_cache_delete[batch] and
> __filemap_add_folio to catch errors where we delete or add folios that
> has order less than min_order.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  mm/filemap.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 323a8e169581..7a6e15c47150 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -127,6 +127,7 @@
>  static void page_cache_delete(struct address_space *mapping,
>  				   struct folio *folio, void *shadow)
>  {
> +	unsigned int min_order = mapping_min_folio_order(mapping);
>  	XA_STATE(xas, &mapping->i_pages, folio->index);
>  	long nr = 1;
>  
> @@ -135,6 +136,7 @@ static void page_cache_delete(struct address_space *mapping,
>  	xas_set_order(&xas, folio->index, folio_order(folio));
>  	nr = folio_nr_pages(folio);
>  
> +	VM_BUG_ON_FOLIO(folio_order(folio) < min_order, folio);
>  	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);

If you are only using min_order in the VM_BUG_ON_FOLIO() macro, then
please just do:

	VM_BUG_ON_FOLIO(folio_order(folio) < mapping_min_folio_order(mapping),
			folio);

There is no need to clutter up the function with variables that are
only used in one debug-only check.

> @@ -1847,6 +1853,10 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  		fgf_t fgp_flags, gfp_t gfp)
>  {
>  	struct folio *folio;
> +	unsigned int min_order = mapping_min_folio_order(mapping);
> +	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
> +
> +	index = round_down(index, min_nrpages);

	index = mapping_align_start_index(mapping, index);

The rest of the function only cares about min_order, not
min_nrpages....

-Dave.
-- 
Dave Chinner
david@fromorbit.com


Return-Path: <linux-kernel+bounces-156290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3F28B00DB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78AA3283EA5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B129154BFB;
	Wed, 24 Apr 2024 05:12:06 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CF315445E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 05:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713935525; cv=none; b=WLqzhh+cl37Gtd8eiwHu9m/Ix86zV1HNME9bjqfpSktKOigspvBo9ODNgFNSwC7Wk+RGOYzFkIUTIhv/PPa8+Ki+n9XVvTEb5umCAxz+AcMABNBfHG085U4VbwTbkKONGUi1v0vg1/bjvIqkeSRIw2PLOy7KDLLOiFDtyx6aLYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713935525; c=relaxed/simple;
	bh=R2VJh8WiIXUQUQbuDawRD/f7e6jb55B4s0cBMzFgifw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6sqVq1LV/HX8qrT/lmxKYMHaT/Tyg1QQ8tbBxaX7amcv2kkX41QfBYgOb2nefz/Qf0GOme4ii+Ca7DSkoLrseqBTU+Q/+qU7VGVfNNZgiyRP/js7tGnRMC5brO7eOPDbgZ17S/atklqFVYxjSuGIs3/a+fzKy1AkLxDA7CZpdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e834159f40so48222445ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 22:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713935524; x=1714540324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDsmPvXYsnOtt5Kv84eWPCrAOOb+S3KIJ6SkIHs9ZVU=;
        b=tAXBbgAjA5s+lf3eN6IdPT7Lv5jyjrETJt7ZDmcA9IPdsCw1L5uXfIRm4qZlhCf7Op
         Kk5lACc+FLY9R8tWyqCkHgCl92EoAG9LJ2EzFLC7jQzcb69h0XQ1bl9mGWFVDo8xMYd+
         xCfg0zNNgwa+EMiairSoLma9FCDHrbbj3vyCS7OfmVppKkopm3iBwjlAZWBpoKlNecwq
         ctlzeEnYgv48Djsenn6NA8RuSMF0gz2WI0/v6o4ScYBkxpxmjiLKI0ZS13A6IuescHZ8
         z0h9RUaUGnBwq98YodPHczh9sRTreCueDAkAxvtgenCI5Fquy45MVe9vo0G+tdL1Vw2j
         4Uvw==
X-Gm-Message-State: AOJu0Ywan9SQbVP1UTtq0uWFBkudAPm7QuclqGQYFXSJHbvb374ESPIz
	Cf6TlyaZYlIVxPKPANwsPiutYSuxZ+uITeeNsvfuhadhsGrk3L1rzqkE6Vja
X-Google-Smtp-Source: AGHT+IGmkXYemexS4loGDKRSU/g337VvbawBhB5/b6t7EYjyxLimmh8skLxbTrskKmDNHnk/zRmtrQ==
X-Received: by 2002:a17:902:f551:b0:1e4:3321:21e9 with SMTP id h17-20020a170902f55100b001e4332121e9mr1509243plf.48.1713935523628;
        Tue, 23 Apr 2024 22:12:03 -0700 (PDT)
Received: from snowbird ([136.25.84.117])
        by smtp.gmail.com with ESMTPSA id ku13-20020a170903288d00b001e403970ec0sm10891540plb.277.2024.04.23.22.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 22:12:03 -0700 (PDT)
Date: Tue, 23 Apr 2024 22:12:00 -0700
From: Dennis Zhou <dennis@kernel.org>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] percpu: simplify the logic of pcpu_alloc_first_chunk()
Message-ID: <ZiiUoC5NokdpvDgN@snowbird>
References: <20240423135525.36872-1-ytcoode@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423135525.36872-1-ytcoode@gmail.com>

Hi Yuntao,

On Tue, Apr 23, 2024 at 09:55:25PM +0800, Yuntao Wang wrote:
> In the logic for hiding the end of the bitmap, there are several places
> where the same value 'region_bits - offset_bits' is calculated over and
> over again using different methods. Eliminate these redundant calculations
> to improve code readability.
> 
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> ---
>  mm/percpu.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 4e11fc1e6def..2a051f00f68d 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -1421,15 +1421,13 @@ static struct pcpu_chunk * __init pcpu_alloc_first_chunk(unsigned long tmp_addr,
>  	if (chunk->end_offset) {
>  		/* hide the end of the bitmap */
>  		offset_bits = chunk->end_offset / PCPU_MIN_ALLOC_SIZE;
> -		bitmap_set(chunk->alloc_map,
> -			   pcpu_chunk_map_bits(chunk) - offset_bits,
> -			   offset_bits);
> -		set_bit((start_offset + map_size) / PCPU_MIN_ALLOC_SIZE,
> -			chunk->bound_map);
> +		start_offset = region_bits - offset_bits;

Generally I think this makes sense, but I'm less inclined to mix the
start_offset variable name in here.

A helper function might make this cleaner, consolidating the
start_offset and end_offset logic.

static void pcpu_chunk_hide_region(chunk, bit_off, bits);

Thanks,
Dennis

> +
> +		bitmap_set(chunk->alloc_map, start_offset, offset_bits);
> +		set_bit(start_offset, chunk->bound_map);
>  		set_bit(region_bits, chunk->bound_map);
>  
> -		pcpu_block_update_hint_alloc(chunk, pcpu_chunk_map_bits(chunk)
> -					     - offset_bits, offset_bits);
> +		pcpu_block_update_hint_alloc(chunk, start_offset, offset_bits);
>  	}
>  
>  	return chunk;
> -- 
> 2.44.0
> 



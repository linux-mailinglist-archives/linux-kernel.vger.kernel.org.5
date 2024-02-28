Return-Path: <linux-kernel+bounces-85739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DA086BA24
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407002879F8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015E070049;
	Wed, 28 Feb 2024 21:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="UuCARKF+"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF93970023
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 21:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709156667; cv=none; b=Q7FW5hpPPOp71hvfaZwYq6dKE/zUIDQgBNjc5MS/L5OYSF/QujFDOn9MCXkD/KfBKlbOolapB6XG83vYNXeN2yt5C3Fxf4E+HBQdv45oALBggx17+9zGnzFhxathfKhTqImsbueitDNwxtqjIWTSmiZ3o86c6trNNco3qzbgChI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709156667; c=relaxed/simple;
	bh=nFoJDv80EHehKpiT+Htmgr8+aowz1fRe5XI0qtqlXP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwS509yiXpFNru8uuAFe6919uYcWJX7rhhgZPOYXLmIpAKIYsOC/8Dr2GzA/T9GrordcLZHyd9Cn2Khvo8ecXNYShWY86vDnJgZ6q4kpA+cPp/Zcg7fUHIkvTWGKF1KV/XzVhblXBxLo47aVtmHYb5Xhvu2ui0P78e30hoKrE58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=UuCARKF+; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42e8a130ebcso8930011cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1709156662; x=1709761462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uZklOSUieULDemWZ+oNQMLtEXHZHkGyXS/OFBbqQnog=;
        b=UuCARKF+5YCkKrOqSSJt0PA2MzxqDQsOr2HrrB7HqgeB5z2GL3l6UIW9isao6fIgWb
         MBebnKGmiV519REoSHjuUwsVGKOqZBT0Z0rzzu0+IU7XYY2xBpSv4k6BbRh/tBsj8XsH
         RM0qMaruBMW0kGszM9AHg5YwO/DL3r6nLFRxdIFp5wpqq/7r5RYu1VSM8bv7nSh02hKw
         XJedS6vAiYOyJYmDQqCAN3VEUUySzeHSX+eMNnbXn4fEgAnScwZ5FZ/TaZNrPiRFU5NT
         wO3ZVSxK670tEooWb3dF+tOByY4q/4XWQnANDQ+A19Ur4ZCzK9MVJCF3abrujbEYjgS5
         qr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709156662; x=1709761462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZklOSUieULDemWZ+oNQMLtEXHZHkGyXS/OFBbqQnog=;
        b=rvXoNPZHBO5IJCY+iZ2RfycMZ+lav9Jp10KCyOuVPtW4g6z9gz8XNHpIvHBGCTytoB
         rFV7WY6QUMpLznMHMQFpJW3Fbciv5cM/G65+XOVLC+4FkHmxgZpmomrvgwT3MmW8LnBE
         O6HzIkvYqaDi+7gnwmVzjwEEecOZTcskYeubDqnsarF6MdNF8k68eaHuKQdc7vv1COMR
         SzIhfUUtKzCJMEd9dxDeDwJaUpLQTn4D4q0Sq9WyaYBP9OtwgQ0GWm3QSp/g37gAyNHk
         JvVKULZlt1zHlsY3lh25ivMMSKJn4JdlkWgemvxYShHbVMkpR8aIWVUAu6bDwQG2uEi1
         RX8w==
X-Forwarded-Encrypted: i=1; AJvYcCXA9I+sElTihWwSsFfmZjwEqtrL/EUZ/yDaFqNT5rlpsbh2gEJ8K1ADPaRki5YDbms1fsigHaV7FdABC93RcP/JP/z9ZQ8pJ8cIX8vB
X-Gm-Message-State: AOJu0YzedDBYRjz5EU8CXS8vhN5XHs3/7hI60LLFRnDiIiJlrGhExgXg
	sS3+sef+gx80MZzqK2xV4P8IDi+cyDUb2GgFJ9vxRSMOd+x/8bcjhGmQ1Ocsk5zc1o/WgoqdDk5
	z
X-Google-Smtp-Source: AGHT+IFssyts4QE2YmPDJt+vm+uwcfNQbPvJ8bBJfQ9VFSUi0fyzRV6qkzW8l5C7Vlz6slB10sOD2g==
X-Received: by 2002:a05:622a:30f:b0:42e:7b49:f3d with SMTP id q15-20020a05622a030f00b0042e7b490f3dmr869543qtw.34.1709156662485;
        Wed, 28 Feb 2024 13:44:22 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id vy22-20020a05620a491600b0078597896394sm31677qkn.51.2024.02.28.13.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 13:44:21 -0800 (PST)
Date: Wed, 28 Feb 2024 16:44:20 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Byungchul Park <byungchul@sk.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com
Subject: Re: [PATCH] mm/vmscan: simplify the calculation of fractions for
 SCAN_FRACT
Message-ID: <20240228214420.GA50163@cmpxchg.org>
References: <20240228015500.52452-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228015500.52452-1-byungchul@sk.com>

On Wed, Feb 28, 2024 at 10:55:00AM +0900, Byungchul Park wrote:
> The current way to calculate fractions for SACN_FRACT is little readable
> and more complicated than it should be.  It also performs unnecessary
> division and adjustment to avoid zero operands.  Prune away by
> multiplying the fractions by 'anon_cost * file_cost / (3 * total_cost)':
> 
> where:
>    total_cost = sc->anon_cost + sc->file_cost
>    anon_cost = total_cost + sc->anon_cost
>    file_cost = total_cost + sc->file_cost
> 
> before:
>    fraction[0] = swappiness * 3 * total_cost / anon_cost
>    fraction[1] = (200 - swappiness) * 3 * total_cost / file_cost
> 
> after:
>    fraction[0] = swappiness * file_cost
>    fraction[1] = (200 - swappiness) * anon_cost
> 
> Worth noting that this patch doesn't change the formula.
> 
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  mm/vmscan.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4657440854db..7b33fcc1cbdc 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2339,7 +2339,6 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>  	u64 fraction[ANON_AND_FILE];
>  	u64 denominator = 0;	/* gcc */
>  	enum scan_balance scan_balance;
> -	unsigned long ap, fp;
>  	enum lru_list lru;
>  
>  	/*
> @@ -2416,17 +2415,10 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>  	total_cost = sc->anon_cost + sc->file_cost;
>  	anon_cost = total_cost + sc->anon_cost;
>  	file_cost = total_cost + sc->file_cost;
> -	total_cost = anon_cost + file_cost;
>  
> -	ap = swappiness * (total_cost + 1);
> -	ap /= anon_cost + 1;
> -
> -	fp = (200 - swappiness) * (total_cost + 1);
> -	fp /= file_cost + 1;
> -
> -	fraction[0] = ap;
> -	fraction[1] = fp;
> -	denominator = ap + fp;
> +	fraction[0] = swappiness * file_cost;
> +	fraction[1] = (200 - swappiness) * anon_cost;

Unfortunately, I don't think that

anon = swappiness * file_cost
file = (200 - swappiness) * anon_cost

is more readable. Sure it's the same, but I think it's clearer to
actually see that `anon = total_cost / anon_cost` ratio in the code.


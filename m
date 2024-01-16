Return-Path: <linux-kernel+bounces-28294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE9282FCA3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499CE1C253C5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD9A20309;
	Tue, 16 Jan 2024 21:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pa4l/4jb"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B8A2E838
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 21:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705440348; cv=none; b=EEJ2SjTUb+8fHpOiFu5GweDp3KzfQc4mRWfdgQlLSrOa3BOU+u+8MDDLCQgvwB2+i+0hLCeK7l9ZIWgEAi7nxWLliFKq0lnfZmGiU9LmeOWCtDtYRrHxYU4XHUvQiMtNGJQ2jmORErUpzy5BboDAdMVCsaM+yZeWXT7746EYj3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705440348; c=relaxed/simple;
	bh=cTjaRffZLcdMx559tIlNBKaL3/5s/glalFdFLVPX+g0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hv3eaV0qK0npWcCQ+F4uZQjK5kpQcU9rhvTT9fu/w3SLIq+vyxUJpYVQnSaBxvIvxitRuYPxnDt8wTIcEWqNa7SgoRkREt5quP0FeCcat3G+eKEqzw0RBEPLzhoGexyqeROxcL5i80yiixqUOQJSsmJXLsdT29QuEzaR/eFfWN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pa4l/4jb; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3368b9bbeb4so9187381f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705440345; x=1706045145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ucvEqlwX+aOdzo8fM1tdvFKFaldc4mizPJaj9Q2q6P8=;
        b=Pa4l/4jbNZBWmIxS9DcbZy5oInrhX7wifog2FBHrgbSZnm5LwfP2UypzBhemaJsH1y
         a24eLEveqcwNtUL1hT29HlCI2iHjPiaVGvPjAwwJtWVTn2rl/yK5dekgd39x30kKez89
         WacJFlU9cRY73yWPZC5cDymWwpHNW3MwBZyglioFafMo7uHSwHU+KKt5VBb2uxk45sjH
         JLk3ATAJ5Tj2GvLof6RxRgJmmuHPh9VMvFbmeyPlgYV+1DMJktQ+BHNI1Y5kscpMWcco
         iTFfs4GNWs3iAJ5ZVEVmCKGvpzKZQku8a7TFTsRoY8haZVIa6pcmzY8MZkQVmVcIqROn
         REnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705440345; x=1706045145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucvEqlwX+aOdzo8fM1tdvFKFaldc4mizPJaj9Q2q6P8=;
        b=TRkcXyhFZ1ZHzcb+tPAEZLL81I5vttDvVXMPWd5FUHm5PtfNigW3LWR4RJc5W32fGT
         e5891B9EN1XCV5G/amW5SU//6o99wBuI1+Xp+15EBi+qrEiDU9FymdfRlClcxvIczIfF
         qXV7nnkXBtzs8TCbU6rWD9+fSNyva6PQ3PAagMudS/CB7IDk8pF+Ia7NaNc97FqhSpkR
         4q/ijuD11T/xxQ//GTvm+3FdxpgX28ZHUhGjNxNkwHpn6uZRkcdfkBT8JVOrQQ0Q/4c5
         tZYJZQk2sHJrNFUETyuI1HPzyVQLpt7xqQv9sMXZTOxaQLL5s2xl/m12+ydKBG14B5tJ
         s+3w==
X-Gm-Message-State: AOJu0YyDm54DhnK5kXdHVbE4NmyjMzeUrEtkbJ3z6Wd1PApZc13p/zPF
	A7S22/ys1M5HXvdU/Lbasl0=
X-Google-Smtp-Source: AGHT+IGUpm4v0VccrEqtEaIXaoB4qyH5YiZh+EJc9iAON3+YhDLhkYnJlXUSQ/phXyCl9ja9j7qAbg==
X-Received: by 2002:a5d:6d05:0:b0:337:8bc6:dc5 with SMTP id e5-20020a5d6d05000000b003378bc60dc5mr2657084wrq.165.1705440345062;
        Tue, 16 Jan 2024 13:25:45 -0800 (PST)
Received: from localhost (host86-162-136-255.range86-162.btcentralplus.com. [86.162.136.255])
        by smtp.gmail.com with ESMTPSA id z6-20020a056000110600b003367a5b6b69sm61968wrw.106.2024.01.16.13.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 13:25:43 -0800 (PST)
Date: Tue, 16 Jan 2024 21:23:29 +0000
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Dave Chinner <david@fromorbit.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/1] mm: vmalloc: Mark vmap_init_free_space() with __init
 tag
Message-ID: <6d09807d-0476-4d9d-8753-dd6520c9a2eb@lucifer.local>
References: <20240111132628.299644-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111132628.299644-1-urezki@gmail.com>

On Thu, Jan 11, 2024 at 02:26:28PM +0100, Uladzislau Rezki (Sony) wrote:
> The vmap_init_free_space() function is called only once
> therefore tag it with __init. Apart of that it access the
> "vmlist" variable that is located in ".init.data" section.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401112056.I41bELL4-lkp@intel.com/
> Fixes: 86817057732 ("mm: vmalloc: remove global vmap_area_root rb-tree")
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 43a6608e1397..257981e37936 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4834,7 +4834,7 @@ module_init(proc_vmalloc_init);
>
>  #endif
>
> -static void vmap_init_free_space(void)
> +static void __init vmap_init_free_space(void)
>  {
>  	unsigned long vmap_start = 1;
>  	const unsigned long vmap_end = ULONG_MAX;
> --
> 2.39.2
>

Looks good to me too. Feel free to add:

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>


Return-Path: <linux-kernel+bounces-89758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0452186F52A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81000284F4C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2BB548E1;
	Sun,  3 Mar 2024 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xbo95VRU"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C90566D
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709473139; cv=none; b=t5cZN1WOOke5H9qafEpBsL/rf2NhO3FOjmYC/qNnUBlp/UFO2UoWREKk77OM/jW1/ud0cmi5xoUdHiPdtF6gOK6BMt/TF2YY7NnzOeMEPYcG2/KQ+pdLPLWTLP2bbAT+Qq/DmBkw4j4fPttPp/E5Vj5kxZ6YMAFJzvkbq+QiC/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709473139; c=relaxed/simple;
	bh=u+VLJpzpqT1+0pLTOvmbqH+wEH8WeQLz4rBd86XNMfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0pXvLCjETfI5RFIpa1kjDjBAc9TL7VjQFyuB4ggToCi33J55o+trkjDyrq+fe5h2CizMFwAqk4Y30fBBI3nbenGY+TjvyhDcVB1hdg18lMgjUY2f27ALbjxULUUDwPEw4CKGMr2jEOBcSnL5H34VocouArU4PLnFD6Ym/wO9fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xbo95VRU; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33d146737e6so2605319f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 05:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709473136; x=1710077936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AaYg+84UpnvI55N5mXLGMaC2OyI6mbvpzT3hDzv5rt4=;
        b=Xbo95VRU1lOg66buFemKcvayhrMXEDal0x3FHlj81+UbhU66SjqmhtyOyl/RpE8iY6
         Mbv/yh65utXmS6UkLt/UTxrpyNoZIeGxhzaQFSwJdyQrUUzbfk96MPS9MHFYHrkbG4fw
         zEiRXS8t+Wr/DSiiIVn4a12iX97QYRnoDmeF0Dm7rK7/i5mfnTATwLuYscNX/3oIqHLz
         1CavBIZ4kV6ws8gNna7EkjDW4v7LUZ0gD7AjJJEeDSwWdPD85KMdbKoCZpOp8ZueMYj5
         frkfBwP/kyHSnixCVAPJAtG9Nd5tW8F+sYJAVPbWT7lb5NxtJgwkTeqVfNoR/bkOTT3o
         p4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709473136; x=1710077936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaYg+84UpnvI55N5mXLGMaC2OyI6mbvpzT3hDzv5rt4=;
        b=jUwnxraERC76SW6zDYnnqcpBi3LCVCvp6QpkckVhBgPwGRWd49zVs5aIu45uDusFS/
         mUSkk1LY8/J1ADOYojpPxwG3ntuh1/6osNhhauxVSx+Tb7eHEGU8yn1GCapJ7ynk42Y/
         TyEZYkv3bSIY13CJqUmqXpgPD0V1VNv3fWrj4ifCKoNZFX/kteCobc5TC/bSg030rLae
         Fbqk1qaH2HDOW6ynCGexP8QIsh/voPvcuGe4K5rmE7h6Ydsajr9tSzIB/hYNZItfQfyM
         We4ub40QCbzcZgYMatLUQVdYaf10yESkAhFei4bZeIouOMuZ17vRCJqqwdyMlX7eNRcv
         EJSg==
X-Forwarded-Encrypted: i=1; AJvYcCXaXh54EGBBk/671QXOfuZlR3tvw7xEOQ8HAgXDgdRR/JQ/jT8NHYBlddibwjKaprw92zEgqKKFbBj5J7pNlu9wY2XKpgYnNGd+7gSI
X-Gm-Message-State: AOJu0Yx4VV8jYOY+R40IVwLdJmmUzTZo75Z+bHGrEvK+BnFcvOI6kiGg
	PbZqUm6DNT969q7kKum8xQUs47fUMIpQTTDQZmN+ElIKX+ALGeJ+
X-Google-Smtp-Source: AGHT+IFthyF5TNsuEzVwVMUwg/w4D4t4uutNeGyoI6GV5XWVhkwUl1GFo9urWwnSfjlAD2zRoxCzpw==
X-Received: by 2002:adf:cc06:0:b0:33e:6ac:691b with SMTP id x6-20020adfcc06000000b0033e06ac691bmr4913224wrh.9.1709473136200;
        Sun, 03 Mar 2024 05:38:56 -0800 (PST)
Received: from localhost ([2a00:23cc:d20f:ba01:bb66:f8b2:a0e8:6447])
        by smtp.gmail.com with ESMTPSA id az23-20020adfe197000000b0033d97bd5ddasm9822234wrb.85.2024.03.03.05.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 05:38:55 -0800 (PST)
Date: Sun, 3 Mar 2024 13:38:54 +0000
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Yue Sun <samsun1006219@gmail.com>
Subject: Re: [PATCH] mm: memory: fix shift-out-of-bounds in
 fault_around_bytes_set
Message-ID: <bb0e1cd5-7e44-44cd-a359-3f2c7bef36ee@lucifer.local>
References: <20240302064312.2358924-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240302064312.2358924-1-wangkefeng.wang@huawei.com>

On Sat, Mar 02, 2024 at 02:43:12PM +0800, Kefeng Wang wrote:
> The rounddown_pow_of_two(0) is undefined, so val = 0 is not allowed in
> the fault_around_bytes_set(), and leads to shift-out-of-bounds,
>
> UBSAN: shift-out-of-bounds in include/linux/log2.h:67:13
> shift exponent 4294967295 is too large for 64-bit type 'long unsigned int'
> CPU: 7 PID: 107 Comm: sh Not tainted 6.8.0-rc6-next-20240301 #294
> Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
> Call trace:
>  dump_backtrace+0x94/0xec
>  show_stack+0x18/0x24
>  dump_stack_lvl+0x78/0x90
>  dump_stack+0x18/0x24
>  ubsan_epilogue+0x10/0x44
>  __ubsan_handle_shift_out_of_bounds+0x98/0x134
>  fault_around_bytes_set+0xa4/0xb0
>  simple_attr_write_xsigned.isra.0+0xe4/0x1ac
>  simple_attr_write+0x18/0x24
>  debugfs_attr_write+0x4c/0x98
>  vfs_write+0xd0/0x4b0
>  ksys_write+0x6c/0xfc
>  __arm64_sys_write+0x1c/0x28
>  invoke_syscall+0x44/0x104
>  el0_svc_common.constprop.0+0x40/0xe0
>  do_el0_svc+0x1c/0x28
>  el0_svc+0x34/0xdc
>  el0t_64_sync_handler+0xc0/0xc4
>  el0t_64_sync+0x190/0x194
> ---[ end trace ]---
>
> Fix it by setting the minimum val to PAGE_SIZE.
>
> Reported-by: Yue Sun <samsun1006219@gmail.com>
> Closes: https://lore.kernel.org/all/CAEkJfYPim6DQqW1GqCiHLdh2-eweqk1fGyXqs3JM+8e1qGge8w@mail.gmail.com/
> Fixes: 53d36a56d8c4 ("mm: prefer fault_around_pages to fault_around_bytes")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/memory.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index abd4f33d62c9..e17669d4f72f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4776,7 +4776,8 @@ static int fault_around_bytes_set(void *data, u64 val)
>  	 * The minimum value is 1 page, however this results in no fault-around
>  	 * at all. See should_fault_around().
>  	 */
> -	fault_around_pages = max(rounddown_pow_of_two(val) >> PAGE_SHIFT, 1UL);
> +	val = max(val, PAGE_SIZE);
> +	fault_around_pages = rounddown_pow_of_two(val) >> PAGE_SHIFT;
>
>  	return 0;
>  }
> --
> 2.27.0
>

Thanks, this was an oversight on my part, this fix looks good:

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>


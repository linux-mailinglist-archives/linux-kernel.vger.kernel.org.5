Return-Path: <linux-kernel+bounces-127005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 545E18945A7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9A23B216A5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE12535CE;
	Mon,  1 Apr 2024 19:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDmf2EUy"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309E942056
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 19:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712000881; cv=none; b=rsd2DKtRZIvVci1ViQLLusUNVE6hnOY7/V95w0odLOpLPutYM1dWTuX0DZvADL+ZmMwxqN2oHzhtkJQUtGjR/Bsmd3W8p4oJLVZ2pd9tiNLMKCUmM0WpfBElzG0muUoARyPpQg8wHv5UEo7MjN8zJGe4X3rMaDbwwV/bfQtU5KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712000881; c=relaxed/simple;
	bh=lnar+0o7dLIVFJzKrV98YGj2n80M98LUV4BiC3ifQZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VybK7Bn0Wot5bNpLSmnKXIumoWZokq9svKR6wq4muFgLAv/7LR7xldz5UXwzg3PuGhBOc8rspiu7GiQjWgrtdNk0ydFj30lUp3RLskrqIEWdbzZTIU7cCikdrSuHG/jnQp+nP+/ZJJ7dUFPsgngOqdfeUlB7tEFFy+q9fYVpxTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDmf2EUy; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3416a975840so3472449f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 12:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712000878; x=1712605678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i+aKdwQrYSYkzio8WwLCV972xl0lvZDetZCMBr85V4g=;
        b=mDmf2EUycpZCKTod3Go887aPFmG2okicCngiTNgjXLCyJzVo07y69I0sFBBgUgxaMd
         Cn9jD3A0tvmNp0yHDBuAlB+ol8tV98S5m3sdrnhPWmlTKUgaOIUx8LtnzYDkYkfkZWDa
         O3cCrmaXYV9PB8di8209fHdBYoBaRXcxRViuzdFYKTcaPdA9TJ9SufbBKbEzl4sM5W1a
         h6CJgAPwsejDh5U1q3uFVhvWIOG64gOYY1BjYv9fQAtw/u+dDlAwhsp+DsNKUNNsPua0
         FaVixP37QNBLAsKJNEwS5T7zp6SjW47teDo4YxAPjbu2ySpJSJnD5I+tEvWoyQRayiR9
         YecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712000878; x=1712605678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+aKdwQrYSYkzio8WwLCV972xl0lvZDetZCMBr85V4g=;
        b=u7du8mCwcIjE/qbDlAs5Zasy1u3UhPeEFubSHziVSWk12CzfY2XMSnas6ELmdalNfl
         9vuhJ0Tv+42kOEIX5mDu7zqjlWwwZz4R9iPqJaet6BovkVvWwyLaRUOn1BeqUYRJ6dNW
         sQJGXjUJ59aIIiW6XA5cRxUHQ4Nc/QjyjerwHPV8MhqAlw8voiMfO6h0KXlcd1oPsxC0
         kK7pOsKRLOecGwmu/DQJ5X2Epg4bG5L1vE9v07f6LYfBEcFcZ6WO+zyTNhuy2xcAYBLs
         E4RY/H158lLvhxv9dHUoLr8EUczLrelOdiemEnU361skH2o/XDTClkfiNhIMRl6RiSa3
         2XgA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ89SY8BcM02nAfKzKMQ4bjz6v6YC0CQRkWvbF5wdF7EY8V+3zhPXyxuhU5FrYDdDFrsK6ainx5Tros3HA0/BffpzabwRaUlNQdehG
X-Gm-Message-State: AOJu0YzN1E7U+NOwhlmsbUCTt9nqv4z99qeKtIXnwmKdXH8WhNlmJkwD
	Bc0DMTJNDDJW0UOrKuGv45DWrm22QmKZEfju6HMOEY4jjw7h+pgs5os4Wcaqi0w=
X-Google-Smtp-Source: AGHT+IFMNEfCpuQjJ8WPz+6uM3yEpezsYLuHC2wVq7juE0ooOQEgeuAu2jh/5KYIiQvvkCP2EftuwA==
X-Received: by 2002:adf:ea50:0:b0:33e:7fbc:caea with SMTP id j16-20020adfea50000000b0033e7fbccaeamr6898410wrn.34.1712000878354;
        Mon, 01 Apr 2024 12:47:58 -0700 (PDT)
Received: from localhost (host86-170-129-184.range86-170.btcentralplus.com. [86.170.129.184])
        by smtp.gmail.com with ESMTPSA id l2-20020a5d4bc2000000b0033e7e9c8657sm12297256wrt.45.2024.04.01.12.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 12:47:57 -0700 (PDT)
Date: Mon, 1 Apr 2024 20:45:42 +0100
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, stable@vger.kenrel.org,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH] mm, mmap: remove vma_merge()
Message-ID: <38b67f6a-6c64-43db-85fb-027efac9d9d6@lucifer.local>
References: <20240401192623.18575-2-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401192623.18575-2-vbabka@suse.cz>

On Mon, Apr 01, 2024 at 09:26:24PM +0200, Vlastimil Babka wrote:
> With SLAB gone I was looking for what I could delete next, and then it
> dawned on me - it should be vma_merge(). It's simply an unmaintainable
> mess.
>
> The code is extremely hard to follow. There has been a number of recent
> attempts to made it more readable, by Liam, Lorenzo and myself. Almost
> every time this only resulted in subtle embarassing bugs [1] [2] [3] [4]
> [5]. For many of the bugs the only reliable testcase we have is the rpm
> process running in the Open Build Service. Which is worrying, as that
> clearly makes vma_merge() a potential supply chain attack vector for
> planting backdoors.
>
> Thus simply remove vma_merge() and all the related code, and adjust all
> callers to take the path as if merging was attempted and failed.
> The only downside is that there might now be more vmas and maple tree
> nodes due to no merging. To extensively validate that, I've booted the
> kernel with virtme-ng before and after the change and checked slabinfo
> for the number of active objects:
>
> before:
> maple_node          1159
> vm_area_struct      1538
>
> after:
> maple_node          1113
> vm_area_struct      1861
>
> Yeah there's more vma's but interestingly, less maple tree nodes. I
> believe it's worth it. The larger number of smaller vmas could even help
> with better parallelism thanks to per-vma locking. So the conclusion is
> obvious - we should have never tried merging vmas in the first place,
> hence the tags on this patch.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d014cd7c1c35
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4c6759967826
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7e7757876f25
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1419430c8abb
> [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fc0c8f9089c2
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: <stable@vger.kenrel.org> # CVE mandatory
> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Singed-off-by-one: Vlastimil Babka <vbabka@suse.cz>
> ---

[snip]

This is a beautiful patch and about as perfect a clean up as one could imagine
(I mean #thebestcodeisnocode right?), but as we have now eradicated VMA merging,
I can't be a hypocrite and advocate for patch merging.

As a result, sadly I must:

Hope-Liam-Nacks-It-By: Lorenzo Stoakes <lstoakes@gmail.com>


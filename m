Return-Path: <linux-kernel+bounces-82380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D62586837C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E108B1F236FC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429DF131E3C;
	Mon, 26 Feb 2024 22:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VA1ePOC1"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2EC1EA72;
	Mon, 26 Feb 2024 22:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708985268; cv=none; b=raEKoP0zDU6vCqR8AadYgUWkbLpQIo0HiZZ+jOD/lc0GsN1tFrBNYZ0Mm35DzSuj3r9dJxVjiqwV5yqPCBgITiwe5t5im5Qs8m3iyPQdPNMTHX5gTTIv/Nwpmvcqs5LbsbmYHIiWA4h+kjWmHsXJIDx5YyZ/5RtZS5jeJGe8+zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708985268; c=relaxed/simple;
	bh=3bj+zZCVpfp7NxPeaeA8ZeRn6O/0o+N/z5ULqJofpEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlBb01uzs1rNPt99OjhoBOpA8k3z17rXcr3LA3yc8aQA7McyZS8d6VoenJKH9Ti/wzdQkoj8/T/d7nTQh/thhUpsb56iE8hF4zzYAL87LPdPTvpHiKJMr1Pora0UkerNOlyRIW0WGnoklzBKu6EXEIFZHjxzW9+bc6rNfviUemA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VA1ePOC1; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-512fcef91d4so1983485e87.3;
        Mon, 26 Feb 2024 14:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708985265; x=1709590065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHEg/PobD24tdsAcn0OzUyhowswPKvxcAqmhC1J0GNY=;
        b=VA1ePOC1XlEZKyk4NBNenIRFl1x8dkw1TisKQo5VYnS1w6lS2pKdXcPjoIKTAaztuH
         Y3krDQTzC/1ulUuucnKeNT9HYmtPnYXufKWs5OJ+6ye9jHOH8rLs8eQrl7QVQgU90YU6
         vTeeNXvEyWSSycg3vYKPwl1x2j5OPc5iBYqIX77uL+rmPPkUDFN1oNszFqoRg7yWv6nt
         mFRYNcMFprl/rX3gH5f/d2pfpGe/rGDGmaQ/TZf/jDpi8ryJbkgHo2ZGkxcfv4Zi4jmR
         eDiHccgoeX83VFJ0qEFyP1qs0x3PV3g+MBPA67Pf1iBv922T4cUMnIlcALBHLtJiKnKG
         aOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708985265; x=1709590065;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pHEg/PobD24tdsAcn0OzUyhowswPKvxcAqmhC1J0GNY=;
        b=AiJVZGkVk90UyVBmB9ZxEKFgq2fFTz0bjrxTy56FdfweCbZkNBOZRXLdWl1caNTF+B
         orvEh/eVzi0vOdz7++0caA5sRMSwitTzsY20rcBQBzoUOlk3BSKXJRzl9LO7xanW948N
         e/KnZiEzQT5trSRKmgp2ryBhT2BxHO2y7+UhAmH6vEAbF6hIlzs7UZBBSrUEM852BlHz
         fnTzBtppERfQBxUgzR2dKAbXPfmn/Y0oW7YWrlhNA616wZnhCYTiDy2o043X84DZACqd
         CpWOulsTWDXWJVbjDq8rBClcJXhlsYQ0YWVD6Dk/CiIoQYNB9UeC7cAeV+XeWwY/gF4S
         OWqw==
X-Forwarded-Encrypted: i=1; AJvYcCX3zo+NhDPQOJFIVoGU+417tw4n5LihoC79jPiC00GRAOWRaVzlQKxi1NtIlRxhProR25qQ7LXtRwxHa9NtqrBI4HGv9vSO/8fRvQt5KeyAxhQ9SOJB4GjwfJ6699gD1fB5DyYZQb8lio8z
X-Gm-Message-State: AOJu0YxhW2Rz7SFs4i1IaoQY+AZxNgKdDVjYt9q6v4WAtmY0oTz9EMIy
	scOVlUdiPVEZM/q9THKH1xVdV65Ppwe/QfG7HTv/vNloXBiEVU/B
X-Google-Smtp-Source: AGHT+IGz0v9kfZ8Pryt+LljBAadvtBLU3DXwhJnm4Yo8WhLtfZT8YFLtxKyvtv7wmiR80zXDE5VPcw==
X-Received: by 2002:a05:6512:b0f:b0:512:b71d:3283 with SMTP id w15-20020a0565120b0f00b00512b71d3283mr6197335lfu.67.1708985264849;
        Mon, 26 Feb 2024 14:07:44 -0800 (PST)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id w4-20020a19c504000000b00512fe237508sm446024lfe.27.2024.02.26.14.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 14:07:44 -0800 (PST)
Date: Tue, 27 Feb 2024 01:05:30 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Corentin Labbe <clabbe.montjoie@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Ovidiu Panait <ovidiu.panait@windriver.com>,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: Re: [PATCH] crypto: sun8i-ce - Fix use after free in unprepare.
Message-ID: <Zd0LKrryWNs15zxi@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Corentin Labbe <clabbe.montjoie@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Ovidiu Panait <ovidiu.panait@windriver.com>,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>
References: <20240226215358.555234-1-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240226215358.555234-1-andrej.skvortzov@gmail.com>

On 24-02-27 00:53, Andrey Skvortsov wrote:
> sun8i_ce_cipher_unprepare should be called before
> crypto_finalize_skcipher_request, because client callbacks may
> immediately free memory, that isn't needed anymore. But it will be
> used by unprepare after free. Before removing prepare/unprepare
> callbacks it was handled by crypto engine in crypto_finalize_request.

And potentially rk3288_crypto driver is affected by the similar
problem.

https://elixir.bootlin.com/linux/v6.8-rc6/source/drivers/crypto/rockchip/rk3288_crypto_ahash.c#L339

> 
> Usually that results in a pointer dereference problem during a in
> crypto selftest.
>  Unable to handle kernel NULL pointer dereference at
>                                       virtual address 0000000000000030
>  Mem abort info:
>    ESR = 0x0000000096000004
>    EC = 0x25: DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>    FSC = 0x04: level 0 translation fault
>  Data abort info:
>    ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>    CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>  user pgtable: 4k pages, 48-bit VAs, pgdp=000000004716d000
>  [0000000000000030] pgd=0000000000000000, p4d=0000000000000000
>  Internal error: Oops: 0000000096000004 [#1] SMP
> 
> This problem is detected by KASAN as well.
>  ==================================================================
>  BUG: KASAN: slab-use-after-free in sun8i_ce_cipher_do_one+0x6e8/0xf80 [sun8i_ce]
>  Read of size 8 at addr ffff00000dcdc040 by task 1c15000.crypto-/373
> 
>  Hardware name: Pine64 PinePhone (1.2) (DT)
>  Call trace:
>   dump_backtrace+0x9c/0x128
>   show_stack+0x20/0x38
>   dump_stack_lvl+0x48/0x60
>   print_report+0xf8/0x5d8
>   kasan_report+0x90/0xd0
>   __asan_load8+0x9c/0xc0
>   sun8i_ce_cipher_do_one+0x6e8/0xf80 [sun8i_ce]
>   crypto_pump_work+0x354/0x620 [crypto_engine]
>   kthread_worker_fn+0x244/0x498
>   kthread+0x168/0x178
>   ret_from_fork+0x10/0x20
> 
>  Allocated by task 379:
>   kasan_save_stack+0x3c/0x68
>   kasan_set_track+0x2c/0x40
>   kasan_save_alloc_info+0x24/0x38
>   __kasan_kmalloc+0xd4/0xd8
>   __kmalloc+0x74/0x1d0
>   alg_test_skcipher+0x90/0x1f0
>   alg_test+0x24c/0x830
>   cryptomgr_test+0x38/0x60
>   kthread+0x168/0x178
>   ret_from_fork+0x10/0x20
> 
>  Freed by task 379:
>   kasan_save_stack+0x3c/0x68
>   kasan_set_track+0x2c/0x40
>   kasan_save_free_info+0x38/0x60
>   __kasan_slab_free+0x100/0x170
>   slab_free_freelist_hook+0xd4/0x1e8
>   __kmem_cache_free+0x15c/0x290
>   kfree+0x74/0x100
>   kfree_sensitive+0x80/0xb0
>   alg_test_skcipher+0x12c/0x1f0
>   alg_test+0x24c/0x830
>   cryptomgr_test+0x38/0x60
>   kthread+0x168/0x178
>   ret_from_fork+0x10/0x20
> 
>  The buggy address belongs to the object at ffff00000dcdc000
>   which belongs to the cache kmalloc-256 of size 256
>  The buggy address is located 64 bytes inside of
>   freed 256-byte region [ffff00000dcdc000, ffff00000dcdc100)
> 
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> Fixes: 4136212ab18e ("crypto: sun8i-ce - Remove prepare/unprepare request")

-- 
Best regards,
Andrey Skvortsov


Return-Path: <linux-kernel+bounces-111121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EB388682D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13A13B233E3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE98017575;
	Fri, 22 Mar 2024 08:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KetGvfJk"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39299171C9;
	Fri, 22 Mar 2024 08:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711096073; cv=none; b=JjcSTaMhJwjGwTtHx9nOJdGjQfY1XGcxkHxqgNSgqOnFuxZPe2lA/2mSLBxggxrsqYdwBiPR7hu5rHv3lwNtZEIronrx7v72umxuITKrGwuyhKanzMrhxbuWDq8hnvC+UzEslD37x38xv67PzBvBFkF9Pe8XA3ULL8Up2hsCEqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711096073; c=relaxed/simple;
	bh=E/NSmTIAyqBh/+/9Aae+2dRHFOZbYkOhLVxDcJNfSeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gW6gDZm4VQEdwYzT0llg5G2dRe8pGSf0Sm9R3pWrWU7hL8PDkA1lhSIw2oQbhrlomLRtxIotw2y4CNbYTMKqs6zO4902L5x43pdHzoYR8jrWjzlk8XhHd+7WntdWChseHhIX48Cz8c1cvHVjmmu7ZkSPfGR6WWaCvdU8mVXdyFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KetGvfJk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-414775b1cacso8249285e9.3;
        Fri, 22 Mar 2024 01:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711096069; x=1711700869; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zr+XUqwA0CHqxnSCgayp4Aa3jADCAmxoEHkuAHYePu0=;
        b=KetGvfJkQ8vnrwNU5ddyjHgoBjXc7tcTz6/VOhxrDY42qcW6sAnwqGDCNyNjm9zIx4
         rY2IAwCcDilMhJoi2yLR0DPUB2NTmpH7YIIqLUZ6wjVGWyUGRUUR1yz7biIL8qEtzECU
         XuxNko53qwiLCUbFd/B60Kq9k+lYV4jSjJua01oVxZ8wJXTxvJL3NdGYYhLuibBo/fSa
         Y95vefNWuxfFevDLVtafUAOziY0QoAXAUKgGyoUoW7Y8wlM3yuQqCpS99rdyR/G3uB0G
         98tvn3kXOfDwxQYtHrD10IBEzP8cbC31OFOzyKlLWyjOL3YJwGo1jFQhfIN2j4O8s5mM
         Verw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711096069; x=1711700869;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zr+XUqwA0CHqxnSCgayp4Aa3jADCAmxoEHkuAHYePu0=;
        b=CNqOSnM67NQLS5/1RB8yVg8PzBPzMNLJsA8yn9OH3fLFigwMFB763NeRWn6LTqw0uz
         H+4i4K9SZ/A8GJdYXmuPLDpw5Ygjx2Qyll0kLR+BjAytnyuPy/W4up7IyZKy3sKAteFq
         YTpMwPbVH1E8kNaVYyBXGfg4Q15mCOQKm1yMb3MYVKmHzbSAoN4P51cFUi4S5QA2FjJK
         OENyBZ24WUQtxyhrsRdqZ6jJfl+yQgh8Bf3YtQOw7O0qOdwnCvoNoCbvhmkGWQKKT2SF
         e8QlTmSAedqiyeu8+IxJTQLguzKvCma/EP9CQrBpZQ75auMxP95TfvBqStEFjIVCY8Mp
         bmSA==
X-Forwarded-Encrypted: i=1; AJvYcCU/mPt5gK8KLaRVYiqQfpzTgnRMo4gaMMdcaB8TQKBzA1etKsNTPp1RQBc2YQnfIMOYX+DKf/yLg7Qm9jJg0x5/O0BZW5NOX5ENAhGY6ObFIepab+eVoGvnEWHIu5F2wOASvn20PX055iYKv+DM1xr1eHHyXtkm/rqHTKyFTzR4wGsn7TaLEg==
X-Gm-Message-State: AOJu0YzFdjVTBID6QVE8GV5QUSGayc+H8vGxIL5ffqdr6x61xCpnINQo
	AgKUrJmLomwgTjzCOHmf9MUFSPzrQCnVogS8qBt7SNiff9Sz1q5F
X-Google-Smtp-Source: AGHT+IHF6weDCPs1iJNBsZtU/cT8b1lCliqN4i6j9hmH230LshT6I6zLwsAUrSpFE24jIFx+LELVpQ==
X-Received: by 2002:a05:600c:1f81:b0:414:a6d:52d8 with SMTP id je1-20020a05600c1f8100b004140a6d52d8mr1008838wmb.17.1711096069294;
        Fri, 22 Mar 2024 01:27:49 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id o7-20020a05600c4fc700b004141250b36fsm2333681wmq.11.2024.03.22.01.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 01:27:48 -0700 (PDT)
Date: Fri, 22 Mar 2024 09:27:46 +0100
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: neil.armstrong@linaro.org, clabbe@baylibre.com,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, vadim.fedorenko@linux.dev,
	linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@salutedevices.com
Subject: Re: [PATCH v5 09/21] drivers: crypto: meson: process more than
 MAXDESCS descriptors
Message-ID: <Zf1BAlYtiwPOG-Os@Red>
References: <20240301132936.621238-1-avromanov@salutedevices.com>
 <20240301132936.621238-10-avromanov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240301132936.621238-10-avromanov@salutedevices.com>

Le Fri, Mar 01, 2024 at 04:29:24PM +0300, Alexey Romanov a écrit :
> 1. The old alhorithm was not designed to process a large
> amount of memory, and therefore gave incorrect results.
> 
> 2. Not all Amlogic SoC's use 3 KEY/IV descriptors.
> Add keyiv descriptors count parameter to platform data.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  drivers/crypto/amlogic/amlogic-gxl-cipher.c | 441 ++++++++++++--------
>  drivers/crypto/amlogic/amlogic-gxl-core.c   |   1 +
>  drivers/crypto/amlogic/amlogic-gxl.h        |   2 +
>  3 files changed, 280 insertions(+), 164 deletions(-)
> 

Hello

I have started to test by adding patch one by one and when testing this one I got:
[   21.674995] gxl-crypto c883e000.crypto: will run requests pump with realtime priority
[   21.679686] gxl-crypto c883e000.crypto: will run requests pump with realtime priority
[   21.704366] ------------[ cut here ]------------
[   21.704480] DMA-API: gxl-crypto c883e000.crypto: device driver tries to sync DMA memory it has not allocated [device address=0x000000000264c000] [size=48 bytes]
[   21.717684] WARNING: CPU: 1 PID: 263 at kernel/dma/debug.c:1105 check_sync+0x1d0/0x688
[   21.725512] Modules linked in: meson_rng meson_gxbb_wdt rng_core amlogic_gxl_crypto(+) meson_canvas libphy(+) watchdog ghash_generic gcm xctr xts cts essiv authenc cmac xcbc ccm
[   21.741211] CPU: 1 PID: 263 Comm: c883e000.crypto Not tainted 6.8.0-rc1-00052-g595d4248b127 #24
[   21.749834] Hardware name: Libre Computer AML-S905X-CC (DT)
[   21.755353] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   21.762252] pc : check_sync+0x1d0/0x688
[   21.766047] lr : check_sync+0x1d0/0x688
[   21.769842] sp : ffff8000820fbb40
[   21.773119] x29: ffff8000820fbb40 x28: 0000000000000000 x27: 0000000000000000
[   21.780192] x26: ffff800081d639d0 x25: 0000000000001327 x24: ffff00000288b010
[   21.787265] x23: 0000000000000050 x22: 0000000000001327 x21: ffff800081c23a20
[   21.794336] x20: ffff800080fe0bb8 x19: ffff8000820fbbc0 x18: 0000000000000006
[   21.801410] x17: 645b206465746163 x16: 6f6c6c6120746f6e x15: ffff8000820fb540
[   21.808482] x14: 000000000000000b x13: ffff800081002748 x12: 0000000000000249
[   21.815554] x11: 00000000000000c3 x10: ffff80008105a748 x9 : ffff800081002748
[   21.822626] x8 : 00000000ffffefff x7 : ffff80008105a748 x6 : 80000000fffff000
[   21.829700] x5 : ffff00007d9abb08 x4 : 0000000000000000 x3 : 0000000000000027
[   21.836772] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff00000b314ec0
[   21.843844] Call trace:
[   21.846260]  check_sync+0x1d0/0x688
[   21.849710]  debug_dma_sync_single_for_device+0xb8/0xc0
[   21.854885]  dma_sync_single_for_device+0xc0/0x11c
[   21.859628]  meson_handle_cipher_request+0x49c/0x7c4 [amlogic_gxl_crypto]
[   21.866356]  crypto_pump_work+0x160/0x2ac
[   21.870324]  kthread_worker_fn+0xe4/0x300
[   21.874291]  kthread+0x11c/0x120
[   21.877483]  ret_from_fork+0x10/0x20
[   21.881020] irq event stamp: 9880
[   21.884296] hardirqs last  enabled at (9879): [<ffff800080988834>] _raw_spin_unlock_irqrestore+0x6c/0x70
[   21.893698] hardirqs last disabled at (9880): [<ffff800080987ca0>] _raw_spin_lock_irqsave+0x84/0x88
[   21.902668] softirqs last  enabled at (5638): [<ffff800080010674>] __do_softirq+0x494/0x4dc
[   21.910947] softirqs last disabled at (5627): [<ffff8000800161f0>] ____do_softirq+0x10/0x1c
[   21.919227] ---[ end trace 0000000000000000 ]---

Regards


Return-Path: <linux-kernel+bounces-12084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7149E81EFC7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12C8AB214B3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455EF4596F;
	Wed, 27 Dec 2023 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8HAWJKN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5112745023;
	Wed, 27 Dec 2023 15:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bbb9f39e30so1092119b6e.3;
        Wed, 27 Dec 2023 07:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703691049; x=1704295849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zve6FoVIDYfJ1vycizlXMGVD5IchFezMONqqxtJKrpo=;
        b=X8HAWJKNlkmVkyUhvTEAI+nH1cpuoqWKrMSn5y0W+U0Wux1RLZs8vtUnYh8FTASfnh
         u8MPOqrFhPRCXgb9maeP4YMP2Ilk3WVCfK4AO+x58lsXeTRU2CmmvS7DuIZ0dLeDdjrN
         WODI/Kkg4+czspJjZdSBJY5e0AA6/mjFWPH9+yVrJc+P6nxC967M0mEb8QHAH6nemzV+
         oymm3wxV25uhwoHZXkZ1gYWHe1/oRRbDLPsnZN+hZ4uc5EZTqc+r2gjCJ0hxb2CdFNAk
         B9Bkn8EYVE777p181lN94R2mKy1kAv1s6HwNRoLOJjpacoprMy1Ixy16o/KVH+BOrtvL
         F4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703691049; x=1704295849;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zve6FoVIDYfJ1vycizlXMGVD5IchFezMONqqxtJKrpo=;
        b=iK9hP97LVaCKrz1NV8qzMQ1jDnfBT6j7P1MYbDAjrCJTHg6Jy4+JTwE62bbJVkDURV
         Rzi2FR70hWHlPHwha7ZOz0qcdsIO8SaH2hkwGGTdfEgi7ATvaxVjFIm8BMBiONuaaNkZ
         I90GFZBU/w/7nHK5rJRTHVLkVKVh1MCIWyKBxGWmIEKUgI3kFkVQJXS/wS0se8IilfwQ
         W/hzgSU2L22pDiBZ8ZjDRQB0CPaXaI6YvhhusOiR+8nytyuGGKhMhmIpsALaxnJcQLHm
         038Fc6DGFBAIZcy5juIJOTplJqsSmLJIY02V4ZC+YmguttNFzo96LB/84pUVMwMUf3qF
         /lbw==
X-Gm-Message-State: AOJu0YzMZst931/gBCQRqrLh5vBiqQTTlmlutBEIxfZVtBYpsV3ev0fA
	dJZFyXXpTFYuNYerQYgp/E0=
X-Google-Smtp-Source: AGHT+IHIWnffX0LVocuElj3J/Vwwj56wUbX71nSv9vRLzH4pzm8aH6WWl5wGu+eCdjfRPowBy8p+ug==
X-Received: by 2002:a05:6808:ec2:b0:3b8:b72c:cbaf with SMTP id q2-20020a0568080ec200b003b8b72ccbafmr8365592oiv.101.1703691049182;
        Wed, 27 Dec 2023 07:30:49 -0800 (PST)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id i5-20020ad44105000000b0067f24a93556sm5584825qvp.52.2023.12.27.07.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 07:30:48 -0800 (PST)
Date: Wed, 27 Dec 2023 10:30:48 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Larysa Zaremba <larysa.zaremba@intel.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <658c4328425f7_a33e629412@willemb.c.googlers.com.notmuch>
In-Reply-To: <20231223025554.2316836-6-aleksander.lobakin@intel.com>
References: <20231223025554.2316836-1-aleksander.lobakin@intel.com>
 <20231223025554.2316836-6-aleksander.lobakin@intel.com>
Subject: Re: [PATCH RFC net-next 05/34] idpf: convert header split mode to
 libie + napi_build_skb()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Alexander Lobakin wrote:
> Currently, idpf uses the following model for the header buffers:
> 
> * buffers are allocated via dma_alloc_coherent();
> * when receiving, napi_alloc_skb() is called and then the header is
>   copied to the newly allocated linear part.
> 
> This is far from optimal as DMA coherent zone is slow on many systems
> and memcpy() neutralizes the idea and benefits of the header split.

Do you have data showing this?

The assumption for the current model is that the headers will be
touched shortly after, so the copy just primes the cache.

The single coherently allocated region for all headers reduces
IOTLB pressure.

It is possible that the alternative model is faster. But that is not
trivially obvious.

I think patches like this can stand on their own. Probably best to
leave them out of the dependency series to enable XDP and AF_XDP.

> Instead, use libie to create page_pools for the header buffers, allocate
> them dynamically and then build an skb via napi_build_skb() around them
> with no memory copy. With one exception...
> When you enable header split, you except you'll always have a separate
> header buffer, so that you could reserve headroom and tailroom only
> there and then use full buffers for the data. For example, this is how
> TCP zerocopy works -- you have to have the payload aligned to PAGE_SIZE.
> The current hardware running idpf does *not* guarantee that you'll
> always have headers placed separately. For example, on my setup, even
> ICMP packets are written as one piece to the data buffers. You can't
> build a valid skb around a data buffer in this case.
> To not complicate things and not lose TCP zerocopy etc., when such thing
> happens, use the empty header buffer and pull either full frame (if it's
> short) or the Ethernet header there and build an skb around it. GRO
> layer will pull more from the data buffer later. This W/A will hopefully
> be removed one day.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>


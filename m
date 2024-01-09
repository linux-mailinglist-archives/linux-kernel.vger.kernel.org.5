Return-Path: <linux-kernel+bounces-20927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E07082877C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27CD81F25603
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE9739853;
	Tue,  9 Jan 2024 13:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePEaYJhs"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FAA38FBB;
	Tue,  9 Jan 2024 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78104f6f692so241039085a.1;
        Tue, 09 Jan 2024 05:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704808768; x=1705413568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zbwLQvCGi9ayqIqzz1ygZ1oEKO7pDe3S64K7yitgQ0=;
        b=ePEaYJhspVqzmTmxEkAm9U4segPzUmfrJ4+49viIDJ7CscrC+xxJIkuQFFUAqowX6g
         d7VmePvYwd101z8Doxu+WXtaYGENTirSxJ0peKKAUaa6Bs4mY3dRSZdOK85pICg9y6CQ
         VZCiyLpjgpqprKnYAbTZb7YQI3mUrSods7sm5CcFByxfzxr4k0YYHpuFYckypjJPVepi
         2iwncRG0xurpaHRxnPiELRlWAXXQMzROoZAtzsgl0rWj97X5WNo05PLSmQsKoKigcUK0
         dNK/AMUZklL3ujoXLa4NXP8bLp4Vox0STs9UMjUafAtJXIklGJC6mfW9sGSrRjenwm5Q
         HCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704808768; x=1705413568;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1zbwLQvCGi9ayqIqzz1ygZ1oEKO7pDe3S64K7yitgQ0=;
        b=RGO/3ATU5lPLVBDlNLV4/WUKYEIJHVvzNiRs/Przh643WJbClgl25NkAclAj1I+1vx
         GVBOFdVL719v8tRkhzyJQl61Bvp3ZId2A7xHlkhkY/K6ejgC5utDBipsTuz0T3fQTzq/
         VUAzpo/IcfvMVXlCwXysOQAx+dOQOlUrqOrhcVNGNM2GRjgXT4Xk1HSyYgIukm1Wo/G+
         zhumonLMQwC+Fq2fgkQ63IRZdRgQTyYQqj1KwI7GG7w89mdTCEypjox49DMgf4jQDMcs
         ynG3CGDyoW9NGX4l/Woo0DgYk2t+/ednj2/3SaeOPiPfEXOGQpNzkyWLBcYwS4otlrJb
         wdVA==
X-Gm-Message-State: AOJu0YxgjPQkc3mF/SpdMMm1Px1PcdxQIMJ6LOhyCohKuZo07givpco9
	OY4uudbsI1l4A+SnyrOvRgA=
X-Google-Smtp-Source: AGHT+IEp3BCu3ZUnezV9NlJAZ4Av/aGNhE95t0mHb+RdY60yS9YRLqg9GZv6zhC84yBE+s+uuyLI4Q==
X-Received: by 2002:a37:c20d:0:b0:781:21c6:83a6 with SMTP id i13-20020a37c20d000000b0078121c683a6mr1019863qkm.12.1704808767992;
        Tue, 09 Jan 2024 05:59:27 -0800 (PST)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id b2-20020a05620a118200b0076db5b792basm806838qkk.75.2024.01.09.05.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 05:59:27 -0800 (PST)
Date: Tue, 09 Jan 2024 08:59:27 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Larysa Zaremba <larysa.zaremba@intel.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <659d513f5c0f6_161283294f5@willemb.c.googlers.com.notmuch>
In-Reply-To: <c4afc32c-e9c7-47de-9bc4-243df95644a3@intel.com>
References: <20231223025554.2316836-1-aleksander.lobakin@intel.com>
 <20231223025554.2316836-6-aleksander.lobakin@intel.com>
 <658c4328425f7_a33e629412@willemb.c.googlers.com.notmuch>
 <c4afc32c-e9c7-47de-9bc4-243df95644a3@intel.com>
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
> From: Willem De Bruijn <willemdebruijn.kernel@gmail.com>
> Date: Wed, 27 Dec 2023 10:30:48 -0500
> 
> > Alexander Lobakin wrote:
> >> Currently, idpf uses the following model for the header buffers:
> >>
> >> * buffers are allocated via dma_alloc_coherent();
> >> * when receiving, napi_alloc_skb() is called and then the header is
> >>   copied to the newly allocated linear part.
> >>
> >> This is far from optimal as DMA coherent zone is slow on many systems
> >> and memcpy() neutralizes the idea and benefits of the header split.
> > 
> > Do you have data showing this?
> 
> Showing slow coherent DMA or memcpy()?
> Try MIPS for the first one.
> For the second -- try comparing performance on ice with the "legacy-rx"
> private flag disabled and enabled.
> 
> > 
> > The assumption for the current model is that the headers will be
> > touched shortly after, so the copy just primes the cache.
> 
> They won't be touched in many cases. E.g. XDP_DROP.
> Or headers can be long. memcpy(32) != memcpy(128).
> The current model allocates a new skb with a linear part, which is a
> real memory allocation. napi_build_skb() doesn't allocate anything
> except struct sk_buff, which is usually available in the NAPI percpu cache.
> If build_skb() wasn't more effective, it wouldn't be introduced.
> The current model just assumes default socket traffic with ~40-byte
> headers and no XDP etc.
> 
> > 
> > The single coherently allocated region for all headers reduces
> > IOTLB pressure.
> 
> page_pool pages are mapped once at allocation.
> 
> > 
> > It is possible that the alternative model is faster. But that is not
> > trivially obvious.
> > 
> > I think patches like this can stand on their own. Probably best to
> > leave them out of the dependency series to enable XDP and AF_XDP.
> 
> You can't do XDP on DMA coherent zone. To do this memcpy(), you need
> allocate a new skb with a linear part, which is usually done after XDP,
> otherwise it's too much overhead and little-to-no benefits comparing to
> generic skb XDP.
> The current idpf code is just not compatible with the XDP code in this
> series, it's pointless to do double work.
> 
> Disabling header split when XDP is enabled (alternative option) means
> disabling TCP zerocopy and worse performance in general, I don't
> consider this.

My concern is if optimizations for XDP might degrade the TCP/IP common
path. XDP_DROP and all of XDP even is a niche feature by comparison.

The current driver behavior was not the first for IDPF, but arrived
at based on extensive performance debugging. An earlier iteration used
separate header buffers. Switching to a single coherent allocated
buffer region significantly increased throughput / narrowed the gap
between header-split and non-header-split mode.

I follow your argument and the heuristics are reasonable. My request
is only that this decision is based on real data for this driver and
modern platforms. We cannot regress TCP/IP hot path performance.





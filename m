Return-Path: <linux-kernel+bounces-48617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8808C845EE4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B5C1C27249
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FABF7C6FE;
	Thu,  1 Feb 2024 17:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="bX9Pn82J"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985D17C6F4
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809765; cv=none; b=hmeC3TgJHOqdKOG5pqOKpG8UO2OXU6/1iG5/DR9ARRl6z6eWgYBbOKD6v2MiTrxUXxdSVQqEMfIyTTlhLUJXXw653+jllHBhOxRcHJG5DQ8Jqx/aYCY06VfjdMFkUNBcbNd9K5OEwd5DnRU6OaQVsFaumKPxF5ynsTWjE4husCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809765; c=relaxed/simple;
	bh=zKaKQE1ZEzzzkIUOKj0+/c8nzHwzMYNjzduYv1fMct0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1A1txMaT/u6/c4pDIg3qgRyZXamw82HVqaa75m/qr4iMCVpPV9zegtiBa2+TJGIArK7HxXjP1T2/dtLyuCDn0TeqnUTuox2+DooStnNLzqNSt7r95sGTpR8g8F9yhnd6TVmBWeJyqIeoShkOlOAItt9qw9gK1V18jGU1wRU86A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=bX9Pn82J; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-783dc658bd9so70411785a.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 09:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706809760; x=1707414560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t7PJgJejHBbCDLDpmDHfhU7gmy6DEpfV5jBLmr4xdnE=;
        b=bX9Pn82JgJk58ClF7EQVTGsRAZcMZfzVsw1k3ilFH49Y6AbQQFXOEZXGB4oElT2FfW
         C+5KcUJIiFwjLDx4hR4xsSsEACJWBTov214M0JhSeyetPQIriqzrNQh5E08ZSRs1dP58
         2FMIUSUwHXpNtNOH+i8EM1u1SOdtHdciqpZzsdSafflt0D0ijsxPPZrEQd/eNFweXPz5
         cEPKJMb8ta5rL/aJ3j/phpjTcqb0MVn0nvtkbPZ0z8MvquiQszJcog9vuACuomcxQhjZ
         ACcnd9f3n2UIvpGu8ghnou4lMzrNxAwN5DBk1AltAeBjmtucTR18IlSDxBwo52cHQUjG
         ozaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706809760; x=1707414560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7PJgJejHBbCDLDpmDHfhU7gmy6DEpfV5jBLmr4xdnE=;
        b=kz+S0m/gZ5Mrmb4I/ozJe/YgAd02VqirW5ZNyRG1xJVVieZp2yBWJr5BJlWADq3AHe
         tYsbgqrFYQbSjN1NNSp+xaiXtfWqve+DBWNn23CiGg9TdITpZG4+aoqLMDi+naS6EIPZ
         K27PN+FSgJYu9fQ2gNg/wSEQHDTk83ozSVNPUQcGg6AhX72wfSH1WInX3xp4ACV3mnmM
         kZKrpaoyFicC4VGGB32WWmPA/btfiEK0Xvd3iHaB/plCy03+osANYRpO/NUTVjcz3OZU
         7n5QQr6zqX4Anzd9Dk5uYY8t6EF5PR6nS8FhS1OCaTVNph5RhNGefa7n4x5yepCS71tB
         kclQ==
X-Gm-Message-State: AOJu0YyjiO+MHfeQPMwwnBORJhtnLyXyXxolJHttpo2Yl6m3GFG+D02t
	FKd4lyDmq04NxWlQgER1no8RGq10R6W7c31hg0U7eGqdU+LHBJ3ZKbm/Nj6Tvk8=
X-Google-Smtp-Source: AGHT+IGOIDHv9aaqvKgFw3T0dExvr2in4Rlg0aVEgXQ/NjqK/q6n91gvWCWGJNgtwgIesFdWzfD0Iw==
X-Received: by 2002:a05:620a:1da8:b0:783:bd02:c037 with SMTP id pj40-20020a05620a1da800b00783bd02c037mr3426605qkn.47.1706809760421;
        Thu, 01 Feb 2024 09:49:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUB8bboZyAQWn5xy/zsC6LGTuzfr7hahXajhntZ+AE2LNat0RgO2UbC+iHWziZw8hDcSIv23Q+fbxXwGMr/JYh+L0vYWHrxQaKdLpUMUOPXa1fiRrgvlmeFQo3i6jhkAJEnN8i58LSakGOhMBZEEP/ayNicQnEoTc0ehobrA+eZTfuJQ6p1BhhHhbAmbQjCiSzsag==
Received: from localhost (2603-7000-0c01-2716-97cf-7b55-44af-acd6.res6.spectrum.com. [2603:7000:c01:2716:97cf:7b55:44af:acd6])
        by smtp.gmail.com with ESMTPSA id g9-20020ae9e109000000b007832961ff29sm12950qkm.4.2024.02.01.09.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 09:49:19 -0800 (PST)
Date: Thu, 1 Feb 2024 12:49:18 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/6] mm/zswap: invalidate zswap entry when swap entry free
Message-ID: <20240201174918.GB321148@cmpxchg.org>
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
 <20240201-b4-zswap-invalidate-entry-v1-2-56ed496b6e55@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201-b4-zswap-invalidate-entry-v1-2-56ed496b6e55@bytedance.com>

On Thu, Feb 01, 2024 at 03:49:02PM +0000, Chengming Zhou wrote:
> During testing I found there are some times the zswap_writeback_entry()
> return -ENOMEM, which is not we expected:
> 
> bpftrace -e 'kr:zswap_writeback_entry {@[(int32)retval]=count()}'
> @[-12]: 1563
> @[0]: 277221
> 
> The reason is that __read_swap_cache_async() return NULL because
> swapcache_prepare() failed. The reason is that we won't invalidate
> zswap entry when swap entry freed to the per-cpu pool, these zswap
> entries are still on the zswap tree and lru list.
> 
> This patch moves the invalidation ahead to when swap entry freed
> to the per-cpu pool, since there is no any benefit to leave trashy
> zswap entry on the tree and lru list.
> 
> With this patch:
> bpftrace -e 'kr:zswap_writeback_entry {@[(int32)retval]=count()}'
> @[0]: 259744
> 
> Note: large folio can't have zswap entry for now, so don't bother
> to add zswap entry invalidation in the large folio swap free path.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Great catch.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>


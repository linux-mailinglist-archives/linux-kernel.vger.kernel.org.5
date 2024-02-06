Return-Path: <linux-kernel+bounces-55597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE2384BEAA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640651F26DF5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7950817BCF;
	Tue,  6 Feb 2024 20:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="omSH9yjP"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4496D1798A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 20:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707251190; cv=none; b=C4/4e6ZdINgKOxE1iN5gJTuLyUZAx5wqUP6QK3MUidXk4GJf3nu3efq1VwBC9ddjh3H8U3YqWxENJUMffhh4Lp4bftYUowhqWkMrhmyZunoHxiHQJO/DyaxgcNpm2hylg+v8B1HkWVNoccULgQph9DLTaUltl+4rqloUHkEhErM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707251190; c=relaxed/simple;
	bh=TeToKRLqHwGPheV9Y/TZxamway7IArC0Hy+zgck7zgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czcBsrNpkrKVn+Wmq7OkRkol2xqhO/rOhn/5VHdzn6ZzkL67HCzhFCelcUqa1p7sWIKQP6EvccGpO3FPb8DwfM0+wBXbCA9m9gmkjQg+DKc2qQ+BwhzTJWujCEzftLlegxNA0Bp5MUqfKReYclspRi26tXzBNlzoJXRb7R1CF5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=omSH9yjP; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a37721e42feso401171966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 12:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1707251186; x=1707855986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v/0RXbqJk3p+Iy+ZevOvYx7kyIE4q+v2z/wExgGiYBE=;
        b=omSH9yjPL2OzLvGaQdNQF1wQQxkCEk74albq+JphN+Fay1E/H/94nBshUN2PieWb3f
         0W3InvrG2Tj8A9n0Vhh5PNZqN+ok/UfBTYBHhI2nX01ycCnD8GFac6EHRee4SvjAkQOM
         a3CaAqwU29CkmSh89bbE0c0YKrqmHQxXelLwHQYhzeTPFoDaEoTubkvvoAco32Vg5tIi
         YxsY7aP11CRG9Ttr+U1kWquGMdeCAHez5meWuY8h85IxC58K4qVwWQKPXyKMGfG8pvUR
         eeLLaznBK2JPIMUJwuJuuUZhUfwhqWQ4uQb9z4h4/ZZbuBMZYyEtHci3cPx312Grb5qc
         iVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707251186; x=1707855986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/0RXbqJk3p+Iy+ZevOvYx7kyIE4q+v2z/wExgGiYBE=;
        b=EGI9MJaE0AgWKjN7BwsKlkxwVnX3RNWt1GjWix+HaJl7MNsuQjogOyExTVP5vT06Ym
         oUcf8XtGkkPv6K7qZLauUnsrS4dlbcgqqmLKGxO9dpQtwx8EWie45EhQQs9qybcW5yLA
         Bd/njpSCFEeg8WUcYcksu4tBPCZwEoOeRrsOcwj/wJZHPQH3IsCJyFJYlskHxcC4vJh8
         Mu6/8TxegO7f7T/gCYPs10rF56HylReTUXt2qlKkJSDAl0BhW/TqWl+XYVJDl6B5v/Gy
         uIvZt/VonCAMlxLWfNBB5k+2eridh996asLL2uftkyY3CYZVgJWhfX8jdX8GaGreiGuD
         SXeA==
X-Gm-Message-State: AOJu0YxYmdoKUPcF75b37/js5VlE9JV2ncXh7J6qsbRE/f7f87PGg5zB
	PwQgKVwKAAwRpP/Yjevn/SxYLn2cuuS3UZCRxgd15Jttzkp0Mu3jFG0ldRe2w2UuJdMCadYDkO/
	elOI=
X-Google-Smtp-Source: AGHT+IGlf0h5hR3ebwa84oWSt4Vyp+yJlpHBqVgGpofDyr/NtnwI0wtjMu24VolDm8r9zz67dOyedg==
X-Received: by 2002:a17:906:f0cc:b0:a36:696f:3e20 with SMTP id dk12-20020a170906f0cc00b00a36696f3e20mr2839376ejb.66.1707251186226;
        Tue, 06 Feb 2024 12:26:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU1bzhouKHDP+zXjwff86wa4JNDF8ywWc/udqyxFsOWza+5byAnBTqZ8wqNrJBmOpBRHDhuofCYj7q4xnG6dthHYLoS6CilTEQBMRtoTS3lkydMBqasqg8H33ARs3bb9QnoFy/VrCnHFpdnHahrWR7ndr9SY/71NABiNNKogGZp0CDBmkYzL/spU1MuRVe/7lE1SCr+XdiraFtlARnPdUKeB4U/KPQ0iQ==
Received: from localhost ([2a02:8071:6401:180:f8f5:527f:9670:eba8])
        by smtp.gmail.com with ESMTPSA id hu15-20020a170907a08f00b00a38103bfa29sm1373785ejc.174.2024.02.06.12.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 12:26:25 -0800 (PST)
Date: Tue, 6 Feb 2024 21:26:24 +0100
From: Johannes Weiner <hannes@cmpxchg.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev,
	yosryahmed@google.com, linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/swap_state: update zswap LRU's protection range
 with the folio locked
Message-ID: <20240206202624.GC97483@cmpxchg.org>
References: <20240206180855.3987204-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206180855.3987204-1-nphamcs@gmail.com>

On Tue, Feb 06, 2024 at 10:08:55AM -0800, Nhat Pham wrote:
> When a folio is swapped in, the protection size of the corresponding
> zswap LRU is incremented, so that the zswap shrinker is more
> conservative with its reclaiming action. This field is embedded within
> the struct lruvec, so updating it requires looking up the folio's memcg
> and lruvec. However, currently this lookup can happen after the folio is
> unlocked, for instance if a new folio is allocated, and
> swap_read_folio() unlocks the folio before returning. In this scenario,
> there is no stability guarantee for the binding between a folio and its
> memcg and lruvec:
> 
> * A folio's memcg and lruvec can be freed between the lookup and the
>   update, leading to a UAF.
> * Folio migration can clear the now-unlocked folio's memcg_data, which
>   directs the zswap LRU protection size update towards the root memcg
>   instead of the original memcg. This was recently picked up by the
>   syzbot thanks to a warning in the inlined folio_lruvec() call.
> 
> Move the zswap LRU protection range update above the swap_read_folio()
> call, and only when a new page is allocated, to prevent this.
> 
> Reported-by: syzbot+17a611d10af7d18a7092@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/000000000000ae47f90610803260@google.com/
> Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

With the fixlet applied,

Acked-by: Johannes Weiner <hannes@cmpxchg.org>


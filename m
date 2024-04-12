Return-Path: <linux-kernel+bounces-142900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C30F18A31D5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D85D28487A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3E2147C7B;
	Fri, 12 Apr 2024 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="xSfN24eT"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879011482E2
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934673; cv=none; b=ioJJ1rFBywefxM90utcTODSqceFiDicdqEkamyWG8nawVC9enSYzL4F2F9cxPmDuLxCEe5LEuqexksKmB+x77/Sz7EcgTs2vNIWAVi6ymcZTdpP+pfU11pFHvtLHRE++PfxxCT4uFWWMDV9/9PFfSVX3IuoZyztqHQwHcckAVLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934673; c=relaxed/simple;
	bh=/SNKWHzb8Q8lo/dsYSxKZd6OF82LMq9s5w+1CP+/6aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4r4yjeJwTtdyPgsMOxA4vFv980mvJ5QLA+PD2oU6m+U4jXHEtvbwWlqnWExKmtuhgmxuDweBWUPhR8fu/T7zX/HJ3NKivs/nYKSyJexqa9HentSXuUXxgTFqmrxliMJq5vHfX8M3/pmT/W10hcHKEhm9NTfwjmzAosSFF4Rfg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=xSfN24eT; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6ea1d2c1d58so536858a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1712934669; x=1713539469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=umYWg6DJW6vGydBITxbBeNK9gyCVaIMoQCthI2KA6Yo=;
        b=xSfN24eT7mjdX7bqOgymJMWBwwzaDeM+TZH6PRO5AIYc1SI7p14rdHJkcTYF1qqk1f
         w5znOL19w4zVVpQ9CI8TRXHH/vQEsIu+KJcTbM7lKxOhC4XySpz7Wp93xrzdxI0TSgcC
         D0VqyHwVsyL4egz+J4VotvMpzEZC8coOvl9vvReVNCuAWzyN2lu+84ecvNwuPFUg6McE
         bFoEEgfkOvUxjk0RA70L3E0y5Q2vOmptyUGuwILedYkS1onV8/DfX0wwR0ZcXKt9gHlM
         EPYZNDotDDJRBWA5z6GGWZIBUsjQ+lJGaqgGb4K3hF0o0Cuk28x4eIL/r1UhNn9bgofw
         l5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712934669; x=1713539469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umYWg6DJW6vGydBITxbBeNK9gyCVaIMoQCthI2KA6Yo=;
        b=kOL3nBinwiJul9O8mKwcZAYMw7otImpyYxsage3MZ8Viu9YV/RjH3r+tHswhdujFqb
         G5Q5EN8Wn+HylwbfAyfRaf/6KPN66YjTu0N7Ui0WMvA2OIGmoJVQBsxnMvHUPaMWdQB1
         pG2qgGk1gGNAUYdzeMb9xb5zhhPSllyNT6NCUgsV7Tsfk6kIB6woQmLHgbgHoK1e/M5K
         xL+g6UHK54LsCHBjeWCInrcRXueaPtzJYAkrtnWtCB5PP5lEkIDAHNFHdxvtExcBH19Y
         fHKqSuQUMoAuuBvE6a8lDHRuHgmQGjUhmKX9GzSG/co+7r5Kz/FAO+Qm6c75AL/HsGOr
         EusA==
X-Forwarded-Encrypted: i=1; AJvYcCVJALYKcVmp57ewwbOBbX5O3y+zhI7EeUvafHxvruFoSkPTqIPuxODZb73Yw5Ks6Z2hdut4W29IftqldvdyAeK02aafyCYzSOXDc7Lb
X-Gm-Message-State: AOJu0Yxw8fF41oxPnPNYiF8EK5oSVpVnetXiks7POZDYM0ACzdcA2MCn
	JZ0RUp4GrzKRySwn0p5AdIc/Tw4PN0XOZyJ/7Bj99LpgKZZ11a0b5SNZjPrwCWI=
X-Google-Smtp-Source: AGHT+IH8VjvxvoOuI9oRW3wzeKIZYBUeeDX4Nq7/enxBathOGDvn8PN/mjqLDARs62zMSmQu/ewSkg==
X-Received: by 2002:a05:6870:f10e:b0:22e:cd76:9cc3 with SMTP id k14-20020a056870f10e00b0022ecd769cc3mr3344623oac.29.1712934669537;
        Fri, 12 Apr 2024 08:11:09 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id r10-20020ac85e8a000000b004347d76f43csm2317757qtx.79.2024.04.12.08.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:11:08 -0700 (PDT)
Date: Fri, 12 Apr 2024 11:11:04 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, mgorman@techsingularity.net, vbabka@suse.cz,
	21cnbao@gmail.com, ryan.roberts@arm.com, david@redhat.com,
	ying.huang@intel.com, ziy@nvidia.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: page_alloc: allowing mTHP compaction to capture the
 freed page directly
Message-ID: <20240412151104.GA2955562@cmpxchg.org>
References: <8118a5d66a034736a48433beddaca60ed78577c4.1712892329.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8118a5d66a034736a48433beddaca60ed78577c4.1712892329.git.baolin.wang@linux.alibaba.com>

On Fri, Apr 12, 2024 at 11:27:04AM +0800, Baolin Wang wrote:
> Currently, compaction_capture() does not allow lower-order allocations to
> directly capture the movable free pages, even though lower-order allocations
> might also be requesting movable pages, that can lead to more compaction
> scanning. And, with the enablement of mTHP, such situations will become more
> common.
> 
> Thus allowing lower-order (mTHP) allocations of movable page types directly
> capture the movable free pages can avoid unnecessary compaction scanning,
> meanwhile that won't pollute the movable pageblock. With testing 1M mTHP
> compaction, it can be seen that compaction scanning is significantly reduced.
> 
>                                    mm-unstable       patched
> Ops Compaction pages isolated      116598741.00   120946702.00
> Ops Compaction migrate scanned    1764870054.00  1488621550.00
> Ops Compaction free scanned       7707879039.00  4986299318.00
> Ops Compact scan efficiency               22.90          29.85
> Ops Compaction cost                    73797.69       72933.48
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Letting a movable request into a partially compacted movable block
seems reasonable.

The only advantage of not doing so that I could imagine would be to
avoid mixing old with new pages, such that reclaim is more likely to
free blocks due to improved LRU grouping. But that seems
far-fetched. Notably, __compact_finished() will also stop once the
requested MOVABLE order becomes available; so not capturing at that
point likely just results in stolen work and compaction restarts.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>


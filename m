Return-Path: <linux-kernel+bounces-23670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA1282AFDB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95BDE1C237E4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A28D18639;
	Thu, 11 Jan 2024 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="Md1WfQW3"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD2C1802D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78333ad3a17so221936285a.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 05:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1704980487; x=1705585287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OrNtFKBOME8koezo+hwmifmOEhoB9oiYKEx7YwjL4r0=;
        b=Md1WfQW3oPsFkg6vpOhZrmtHl5kDxwloz/s5glmryxJQTCqbzWBUpgzGH0Wnyrkby6
         wFeNIK8EexuR+4vP7g9Titz22eV4L6VXvDWiAakFfJNr2PBnxvYelFWOXV+2+6QDcW8b
         89uB6CiAtfgdH6ik8/eS4YqWAfzwNR/P1O8JI0nH5kKF3qTvQCgfIxTJ4/5YU7HdQnSD
         uMcIklSEN8FUGu3zSMHSyiQTA+JcnL/63HExfZG6O41SGjIuDykS81moiDT6KRQnTw28
         EA4YXB9462mweNselERLKCm8P9so2odlxUuQqAHPGpQbPd8y0CvwPCeM9+xFkYaKcpnP
         0VVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704980487; x=1705585287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrNtFKBOME8koezo+hwmifmOEhoB9oiYKEx7YwjL4r0=;
        b=vwKSg18vhtZOgg56u+lH/WQOrBAFFKwAYF1oS6G2GSB39NnhQ3jjrH5aupg3B4sKtO
         9DGgIoPfiLf5hHW+kn8DHrQo0LjDUPsMbPxg5WPxQN2usIR2nhDWl9EWcVtjuB04V2Xb
         11nFEnN7uuzLPzHoCmjjBAg1c/m0KqEPMDXYB/9zD92baXWaOFny8b7YP80EZ5j7dOrj
         p+1m3vQnhVm6WnBUUhqjvWAH/z53H/gjLrEmusgdATlc04dtVF3zwmD+Tv/6jAgpC/2/
         0KLA51aO9ZkvqtcFtlQJKkIAJCmCm1cba5DLqEIbY7Ypj6snQOu/G9UNR31+2UBfZ06A
         xFzA==
X-Gm-Message-State: AOJu0YxivcblaALTl8wQvwDYfInhDkCxogzyv/Dtx0MMO65ooV9cqbx4
	sI0PpFAHJzaFN7ElPJlAWZ2co9E9HHyIlw==
X-Google-Smtp-Source: AGHT+IHP/0R6MwUAt5y6EpV/5jC07uWw3Cph7B1QeRfXaXAn8J6x9jo5Bti06WxZXF+eIILMOH5DPg==
X-Received: by 2002:a05:620a:8082:b0:781:62f6:6786 with SMTP id ef2-20020a05620a808200b0078162f66786mr1335682qkb.127.1704980486804;
        Thu, 11 Jan 2024 05:41:26 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id ay13-20020a05620a178d00b0078318dac889sm345703qkb.19.2024.01.11.05.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 05:41:26 -0800 (PST)
Date: Thu, 11 Jan 2024 08:41:25 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Zhiguo Jiang <justinjiang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, Chris Li <chrisl@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>, Yue Zhao <findns94@gmail.com>,
	Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1 1/2] mm:vmscan: fix workingset eviction memcg issue
Message-ID: <20240111134125.GA390292@cmpxchg.org>
References: <20240111122451.682-1-justinjiang@vivo.com>
 <20240111122451.682-2-justinjiang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111122451.682-2-justinjiang@vivo.com>

On Thu, Jan 11, 2024 at 08:24:50PM +0800, Zhiguo Jiang wrote:
> The parameter of target_memcg is NULL in workingset_eviction(), and
> the lruvec obtained by mem_cgroup_lruvec(target_memcg, pgdat) is always
> root_mem_cgroup->lruvec, rather than the lruvec of mem_cgroup where
> folio is actually located.

WTF? No!

	/*
	 * The memory cgroup that hit its limit and as a result is the
	 * primary target of this reclaim invocation.
	 */
	struct mem_cgroup *target_mem_cgroup;

The cgroup that is stored in the eviction cookie is the one whose
limit triggered the reclaim cycle. This is often several levels above
the cgroups that own the pages. Subsequent refaults need to be
evaluated at the eviction level:

	/*
	 * The activation decision for this folio is made at the level
	 * where the eviction occurred, as that is where the LRU order
	 * during folio reclaim is being determined.
	 *
	 * However, the cgroup that will own the folio is the one that
	 * is actually experiencing the refault event.
	 */

> Fix target_memcg to the memcg obtained by folio_memcg(folio).
> 
> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>

Nacked-by: Johannes Weiner <hannes@cmpxchg.org>

Please take more time to read into the code you're proposing to
change. You made it sound like a trivial simplification, but this
totally screws up aging and pressure detection in containers.


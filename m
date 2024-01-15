Return-Path: <linux-kernel+bounces-26479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CECE82E1D1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1F7EB220CB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDD21B274;
	Mon, 15 Jan 2024 20:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1DmDGwhG"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DA11B263
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3607d27bbbcso388235ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 12:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705350727; x=1705955527; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OxMu6+f21gcj2Sin7K/qBMfwvBm8T9Fem82HAKovjpA=;
        b=1DmDGwhGdPZydnlsQeGzp1KDLBjG9TDYVhhmNftV5Y4XJwCGjtlfkecMroKNfw4SRK
         AE+zRANRqjibbtMln3UpnsIzh2NSwoWwh43DZ/aA4OuH95A8CiiFqVEYetC75PTcLoIQ
         rwRT5l1e0kYR+NGxxBdocMmvBZxFZ0mY7ip08oQiidQhEwIhK6i/+ijvo09CL7UbaDIu
         TJkD/cfZJqfRakQ4CqXuk1qztAUw1aiOJ9+ez6pdV0WYoLdul1HKGmmsv2bv6+fbxORC
         RlnGTkK4q6S6oIQi7OEsQ5B9DalD1HFXUIlM93VEedy9U/F4N0qxHpZerr5P88qjth8h
         GlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705350727; x=1705955527;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OxMu6+f21gcj2Sin7K/qBMfwvBm8T9Fem82HAKovjpA=;
        b=L6KdgrSPus7J5p78q4caMO2l+WpMRYlUBoCdg9PROJ0KlN5Jn2tGKAmUwHDTgbIgyW
         FWvMg+Gj0QZIrDRJQYFCnMqE81NbULnSIT1ZWggv3soeMlrgvy/nvNlNtRxwHsS0c+M5
         1iHE9aUgNhIosEDTSvRjjXYkh7bM4SXT/i5d+mQGnwqvehdST9qpkYE7uI4XqG4ArG9x
         LxEe1+gVBzsi2Y6IlgxqR9FaxOs4XI4XkMXSQG5RFtxPgqDeYp2eq8kOyXRzU243vxei
         w/ml8hicQnnEj0Ou20MthPuQkbV4R7KtBcfJYDkPSEooidokxd9R2G1i0Odfo95Yk0K2
         7i8Q==
X-Gm-Message-State: AOJu0YwKfP8KYxZ3RgcloAoqeN3uCvdEBhzDNe6myNzMNfJtu/XP7H90
	2IrOy7zH5QabhrUM7jUa9RlGb+v9sSpNKUPGTEULjsjYTmIo
X-Google-Smtp-Source: AGHT+IE1rzV20Xfsnr/R9oeHCX5RNKf+U6Qj7Q5wO9hrKbNnyj+eTA8FPpnnqSYVkfxE/hM+TDJfkw==
X-Received: by 2002:a05:6e02:1be6:b0:361:8079:2843 with SMTP id y6-20020a056e021be600b0036180792843mr14274ilv.18.1705350726644;
        Mon, 15 Jan 2024 12:32:06 -0800 (PST)
Received: from [2620:0:1008:15:fa9e:3266:a147:d436] ([2620:0:1008:15:fa9e:3266:a147:d436])
        by smtp.gmail.com with ESMTPSA id hy10-20020a056a006a0a00b006d9b345092dsm7992052pfb.156.2024.01.15.12.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 12:32:05 -0800 (PST)
Date: Mon, 15 Jan 2024 12:32:05 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Vern Hao <haoxing990@gmail.com>
cc: mgorman@techsingularity.net, akpm@linux-foundation.org, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, Xin Hao <vernhao@tencent.com>
Subject: Re: [PATCH RFC v1 0/2] mm, pcp: add high order page info in
 /proc/zoneinfo
In-Reply-To: <20240115093437.87814-1-vernhao@tencent.com>
Message-ID: <3550dfef-af8c-b76c-4f4d-6ec790864359@google.com>
References: <20240115093437.87814-1-vernhao@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 15 Jan 2024, Vern Hao wrote:

> From: Xin Hao <vernhao@tencent.com>
> 
> With /proc/zoneinfo we can simply get the number of pages used each cpu,
> but we can't get more detailed information about the distribution of
> those pages, such as the count of high order pages, through these
> patches, we can know the usage of each order page in detail, which will
> be helpful for us to analyze the pcp memory usage of application on the
> related cpus.
> 

Could you elaborate on the use case for this?

I'm not exactly sure what is meant by analyzing the pcp memory usage of an 
application; this would be a property of page allocations and freeing on 
individual cpus for orders that have pcp lists.  That's traditionally not 
a property of an individual application.

> By the way, on my intel 32 cores machine, i found that the 'struct
> per_cpu_pages' size increases 64 bytes, it seems like a bad news,
> i did some tests like stress-ng, but it did not see any performance
> degradation, and maybe use 'pcp->list' is also a possible way to get
> high order pages count, but it will increase the /proc/zoneinfo query
> time, so any meaningful suggestions are welcome!
> 
> Xin Hao (2):
>   mm, pcp: rename pcp->count to pcp->total_count
>   mm, pcp: add more detail info about high order page count
> 
>  include/linux/mmzone.h |  3 ++-
>  mm/page_alloc.c        | 46 +++++++++++++++++++++++-------------------
>  mm/show_mem.c          |  6 +++---
>  mm/vmstat.c            | 22 ++++++++++++--------
>  4 files changed, 44 insertions(+), 33 deletions(-)
> 
> -- 
> 2.31.1
> 
> 
> 


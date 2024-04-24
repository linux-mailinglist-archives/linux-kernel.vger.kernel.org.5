Return-Path: <linux-kernel+bounces-156278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D45AA8B00B1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787BC1F23446
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21DA153823;
	Wed, 24 Apr 2024 04:51:23 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC1923CB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 04:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713934283; cv=none; b=JoqnEiD0gX4mzT2bdu9dDFz13uoo4FVdqtByNW1oHsFDT0qV7I/KwlbVC48yUI6ghho2MSomFBs1SmtJzextqb8Z5JOnSo9pFXLXapdc+54wMtrB9ti2bS+P7mWkT0Nbwc7bvDDmWTJ0+qshsm0E1Gfhum4RoTSN2bn/xjz9Ruk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713934283; c=relaxed/simple;
	bh=RzlmXUZUpT2UJiLdlmyNWLbsXapDtDmbJXSzLVotPi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCUOmLCS9lbkYehXqVbNOhDSskWvymaplxUWi6gloeHOlM0Sx9m94cGuDtlgtHZ4Nc5Bs5QKx+K3UGJfFjb9sMpm0Mh5RLu7wkZKDFOv93F42wHouxa6jHL4RjmO44CKT4xaxZMl52AmjcopEukgSp+HrX2LVDSJ4wLKzHRBTbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ee0642f718so407735b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 21:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713934280; x=1714539080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMKVJVRwPvOaVaYn4i+6e+fLoFdeQpNGOLfBdX27JlY=;
        b=Laqq7YsOvPtxM8eUVkCPLPMh5erMsvBwchWkZ2XQ+4BaSJAM5FibkcHCv12mziIpv1
         3UhIOR4P9LW7YIiHiNthutc8KJt9RasG61gh+PWv/hKCdRNkxu6qyk2YP/MTJj02tgSd
         cyB1WlrwPCweSHn+hEKAN4VTk1TVIax6ZmzeAd+hjsnOcHDWiNC/9AFHL/V3Tbq1jr6n
         PMroG2b5/sjF7qULNHcE3s5sddtrTL8INd9PXryQEmk9upcgCziDE0irMq6CIQpmF642
         aHrZ0BD6Dz9EyA9Owz5o19+WNaKcrz1gSRtXbLZ4ZvI99bVlF4m4waCGt4UZEUd73UKy
         Yz/w==
X-Forwarded-Encrypted: i=1; AJvYcCUwNjnULEVxhAyAIis6f6f5cnyqM0oJAXBO8pBVKwFEj6ndp4wT/Psw6CB79zM8tGnSt+yYVSpPrJdE5EFILYJBlMTI8dbGkxcU+C4Q
X-Gm-Message-State: AOJu0Yyoy0X8CvbNKIYVFa2mObOrhLF5XdPZIlWfwsgVhp5r3s+45zBu
	/zsEDD/r9gZ7D+2G8SuD6Mu7xLt48dKy6Ho34fhuwvK7TcFoPb73
X-Google-Smtp-Source: AGHT+IFcNvTYVfMUXy2rrlzMfPImlK2xqErx5gMSEKPPWuzQxxL5Ruw/lUZzXC6vU1M2kYR/z2bPKA==
X-Received: by 2002:a05:6a20:a127:b0:1ac:df6b:1501 with SMTP id q39-20020a056a20a12700b001acdf6b1501mr6828109pzk.27.1713934280393;
        Tue, 23 Apr 2024 21:51:20 -0700 (PDT)
Received: from snowbird ([136.25.84.117])
        by smtp.gmail.com with ESMTPSA id j28-20020a63fc1c000000b005e83b3ce8d9sm10323645pgi.8.2024.04.23.21.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 21:51:19 -0700 (PDT)
Date: Tue, 23 Apr 2024 21:51:17 -0700
From: Dennis Zhou <dennis@kernel.org>
To: "zhangpeng (AS)" <zhangpeng362@huawei.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, shakeelb@google.com, jack@suse.cz,
	surenb@google.com, kent.overstreet@linux.dev, mhocko@suse.cz,
	vbabka@suse.cz, yuzhao@google.com, yu.ma@intel.com,
	wangkefeng.wang@huawei.com, sunnanyong@huawei.com
Subject: Re: [RFC PATCH v2 0/2] mm: convert mm's rss stats to use atomic mode
Message-ID: <ZiiPxfN9jVPwXE6j@snowbird>
References: <20240418142008.2775308-1-zhangpeng362@huawei.com>
 <0145f5db-1adf-46d1-1a2e-41230ab1e462@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0145f5db-1adf-46d1-1a2e-41230ab1e462@huawei.com>

Hi Peng,

On Wed, Apr 24, 2024 at 12:29:25PM +0800, zhangpeng (AS) wrote:
> On 2024/4/18 22:20, Peng Zhang wrote:
> 
> Any suggestions or opinions are welcome. Could someone please review
> this patch series?
> Thanks!
> 

Sorry, I haven't been very active lately. This is what I remember
discussing a while back. I'll take a close look tomorrow.

Thanks,
Dennis

> > From: ZhangPeng <zhangpeng362@huawei.com>
> > 
> > Since commit f1a7941243c1 ("mm: convert mm's rss stats into
> > percpu_counter"), the rss_stats have converted into percpu_counter,
> > which convert the error margin from (nr_threads * 64) to approximately
> > (nr_cpus ^ 2). However, the new percpu allocation in mm_init() causes a
> > performance regression on fork/exec/shell. Even after commit 14ef95be6f55
> > ("kernel/fork: group allocation/free of per-cpu counters for mm struct"),
> > the performance of fork/exec/shell is still poor compared to previous
> > kernel versions.
> > 
> > To mitigate performance regression, we delay the allocation of percpu
> > memory for rss_stats. Therefore, we convert mm's rss stats to use
> > percpu_counter atomic mode. For single-thread processes, rss_stat is in
> > atomic mode, which reduces the memory consumption and performance
> > regression caused by using percpu. For multiple-thread processes,
> > rss_stat is switched to the percpu mode to reduce the error margin.
> > We convert rss_stats from atomic mode to percpu mode only when the
> > second thread is created.
> > 
> > After lmbench test, we can get 2% ~ 4% performance improvement
> > for lmbench fork_proc/exec_proc/shell_proc and 6.7% performance
> > improvement for lmbench page_fault (before batch mode[1]).
> > 
> > The test results are as follows:
> >               base           base+revert        base+this patch
> > 
> > fork_proc    416.3ms        400.0ms  (3.9%)    398.6ms  (4.2%)
> > exec_proc    2095.9ms       2061.1ms (1.7%)    2047.7ms (2.3%)
> > shell_proc   3028.2ms       2954.7ms (2.4%)    2961.2ms (2.2%)
> > page_fault   0.3603ms       0.3358ms (6.8%)    0.3361ms (6.7%)
> > 
> > [1] https://lore.kernel.org/all/20240412064751.119015-1-wangkefeng.wang@huawei.com/
> > 
> > ChangeLog:
> > v2->v1:
> > - Convert rss_stats from atomic mode to percpu mode only when
> >    the second thread is created per Jan Kara.
> > - Compared with v1, the performance data may be different due to
> >    different test machines.
> > 
> > ZhangPeng (2):
> >    percpu_counter: introduce atomic mode for percpu_counter
> >    mm: convert mm's rss stats to use atomic mode
> > 
> >   include/linux/mm.h             | 50 +++++++++++++++++++++++++++++-----
> >   include/linux/percpu_counter.h | 43 +++++++++++++++++++++++++++--
> >   include/trace/events/kmem.h    |  4 +--
> >   kernel/fork.c                  | 18 +++++++-----
> >   lib/percpu_counter.c           | 31 +++++++++++++++++++--
> >   5 files changed, 125 insertions(+), 21 deletions(-)
> > 
> -- 
> Best Regards,
> Peng
> 


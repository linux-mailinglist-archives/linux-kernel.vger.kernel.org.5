Return-Path: <linux-kernel+bounces-26934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C584482E812
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 04:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A5BD1F23992
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 03:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC9F6FD1;
	Tue, 16 Jan 2024 03:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="fS3TEv0X"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422056FA8
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 03:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6ddeb7b4366so4090829a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 19:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1705374450; x=1705979250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wL0qBWiBkCN64t0DJlGpnsYnRQAkrBhetdbdjTFLd2M=;
        b=fS3TEv0X4xNlKlZuBXhWLVooRk8QDCxuAeptR4kldn3LV0bp9Q4+CXvpmZjP+LJG9u
         GJkMIFwP9T5z2XqTyo8NtYJnOJd9rDMxq0popwtB1PSMSXeDExbMnHYvN9wITD15J4Gq
         XuANeL2rUSj8jcL/WVE4NOHiGs/i9uF6y7+DczrMMMlsuzNrHBsqQGy39ZX28gB69aZ3
         z+qZAKTwMC+VWHrQnUYwd/ptU3hcJ7VoVXfeQr4+JmTusTfyWfWgN01+eJ2btJ2z8Y9x
         9STtk3lsOOGxYgxGzDCYqNokC8LtfYZGcVF+h24PJJICeVm4FhSiVR8YZ4uiBLCrqOAd
         +i2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705374450; x=1705979250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wL0qBWiBkCN64t0DJlGpnsYnRQAkrBhetdbdjTFLd2M=;
        b=MI3tFfmxCI+sooZ+AdNH7oeVRVndXpLpATDPEHa0YPC7jCelqhmXGWRnXCYGhwx45T
         ijUex148PzNeBKNtrix03QgdZsIYK7iD0cU5snyZPAaqCtuUhYYugr0cW6aK3Z32Lidd
         77Fcl6QhTersizeEJNQ1BC7tMdOtsjP6Gfrs5daUm3NSK+1P2gwE2wBHs0tw5pFieZ7f
         l5J6wqil1vBHd8yez5DhVXZk1ENuwDmv3AFrTBS0HVlw6BT4y8rDuEevR/VcO2P40doc
         CH84wyZfdwX7kb9/SsB3X6ACy8EutPvS4qiUhQMA5QXxb/5dVz4W4Djuy1L1TfMiPUPN
         BVSA==
X-Gm-Message-State: AOJu0YzCXe9NiorQE3xvPTFraeVH2HLo5WKHRFqDi3JzvQZvGlrsuBCp
	gPVzxCuj+ZZJi+vBz8aCJq6lA57STsGOGA==
X-Google-Smtp-Source: AGHT+IEWcK2VO4aACKAStgCaiUMFDJ1mIYf5m1oD1S9Q7oOM/p128nW2OuN92AxZuuHzvtISGtog3Q==
X-Received: by 2002:a9d:6519:0:b0:6dd:eb24:9d1d with SMTP id i25-20020a9d6519000000b006ddeb249d1dmr5267455otl.72.1705374449847;
        Mon, 15 Jan 2024 19:07:29 -0800 (PST)
Received: from dread.disaster.area (pa49-180-249-6.pa.nsw.optusnet.com.au. [49.180.249.6])
        by smtp.gmail.com with ESMTPSA id e26-20020a65679a000000b005cddfe17c0csm7789779pgr.92.2024.01.15.19.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 19:07:29 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rPZnS-00AxzI-1m;
	Tue, 16 Jan 2024 14:07:26 +1100
Date: Tue, 16 Jan 2024 14:07:26 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Chandan Babu R <chandan.babu@oracle.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 0/3] Remove the XFS mrlock
Message-ID: <ZaXy7uKOvtiTadCr@dread.disaster.area>
References: <20240111212424.3572189-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111212424.3572189-1-willy@infradead.org>

On Thu, Jan 11, 2024 at 09:24:21PM +0000, Matthew Wilcox (Oracle) wrote:
> XFS has an mrlock wrapper around the rwsem which adds only the
> functionality of knowing whether the rwsem is currently held in read
> or write mode.  Both regular rwsems and rt-rwsems know this, they just
> don't expose it as an API.  By adding that, we can remove the XFS mrlock
> as well as improving the debug assertions for the mmap_lock when lockdep
> is disabled.
> 
> I have an ack on the first patch from Peter, so I would like to see this
> merged through the XFS tree since most of what it touches is XFS.

With the minor nits that have already been noticed fix up, the whole
series looks good to me.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com


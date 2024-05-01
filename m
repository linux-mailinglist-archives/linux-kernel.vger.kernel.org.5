Return-Path: <linux-kernel+bounces-165107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CECA28B882D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8083B1F23DBB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CEA4F898;
	Wed,  1 May 2024 09:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="S6KtYL8k"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A5C645
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 09:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714556412; cv=none; b=f76Ucyq65ZPjuCwkJg9InnxoQWjkCl+jx7UfFk/6AiufJA3tRBSjRY66vAjcxAwe6UYDeU8a4SDput5mwjN+E8022mqV1jtY3GJCwye7ORftiGTvNkCFVLOdXVt5juam4+ZbNDNGo1WwRMNTGYInpngf4lmbfCm9mwdw2KMm7Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714556412; c=relaxed/simple;
	bh=8bkvwyzVgHvGpzRRyZA+OUum8mDLE0skINvxj/Xrkcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jqz6NZ+WQh8h0IlSXxuIy5uRZ5NXE0biKHzUoCh3BvHyGeYp15tRShzN7gLcRf/H7061iQiAYzZl0JQUqrTrGonXBTSEE9jLdz9bM8PaBoJ8gcYiswKilBsd7bP/M98lvbdNXYSpV/5CMnDP5L+9rc9By6B1tWRPpKQ/D59FWhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=S6KtYL8k; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2a2d248a2e1so480736a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 02:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1714556409; x=1715161209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wT6FpY3G8icgSQcw7GLJpHBZGPLegu0OyLVBane8oNQ=;
        b=S6KtYL8kxy+kmbtasi3Jab54ebIxYuwh3m1q3bMtpY7leKLOBORXoPul3ASVc0MJQR
         JMHKUPA5eVWbEAfSQPcKT6ZzjBbIPrJT4SyDbi8Nj5fb/4MD51Zt9/0M9ryqX0YxTnkF
         NoyBqM4KFx3oGRp5oN8L6VdC/TBvq/GZmCPa1i1vO37QFwrt1cWsg2yWSR/5h0jKpKtC
         Cq1G7wHRswtuCNm//BuBQ7zVY+kePC59pyUMTykV0ahcWIblNmv0aIh1oluwGtTSZukB
         SsMB20VV/7YY8N35q7fvy87aeXXwAACgaIIZF1++IriVRCfabPqekt1Slqhu1U3IdwuA
         aMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714556409; x=1715161209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wT6FpY3G8icgSQcw7GLJpHBZGPLegu0OyLVBane8oNQ=;
        b=K6ljz31FysUKRdNKhe/w8jyUygFkQsLKZGGUXU9cWoavpqYfYH7LWs6mXqQbtLNhfM
         JkLDllRI5cIlGqGLEssZFfkOYNmBl/+FLVnwK+XyZz+nBvqZRjmBmNo2YJO0f0KLtSGT
         4bhPUxzc1CNlokpx8dhaJpdo5GKt0zdYFJ9/aQFP5qyPsEBr5EktZkcyZ3yzCuRmZSD2
         QUEkrxRTsDNmV3Vv5F2r4CuDtrr5JpXHX3Vj/FxISZT1/wEnzSInawlxzITqx4vPTST0
         JB7gxUol3OM7QYI7b3yBuW+XxbDrOeyyQR7Erzr3ZqxQkCVRR+FXwMcyxO9xsdmHUZ2I
         0MaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX15qgBWYxI12F5YHLE1QMz2qd+uuUwrWk1xGx6Wym4X5joeH9Rg78a9UG7IwH8HaMLSM9Uw+xOMHW1mr8f3gPtKdR3/LPj1mPt2x8
X-Gm-Message-State: AOJu0Ywqud9uCRP6F5KDp6ZoV/dcfGehsgT9P/CU4kRx0sAmY7sq/zID
	ZJCJQ+miaitt/kco4g/YmgQ8mNe8OA+YjoQro42I8vwxXj6caGt4WvKyrvLKo5I=
X-Google-Smtp-Source: AGHT+IEaOpqOneqIif2Te/uo4KR9GvWB9QZnymHXhoZDlcycKWWY9JInC0Qe5XsLY7mFCgHMhhrjpg==
X-Received: by 2002:a17:90b:605:b0:2a2:fec9:1bbd with SMTP id gb5-20020a17090b060500b002a2fec91bbdmr7291676pjb.17.1714556409282;
        Wed, 01 May 2024 02:40:09 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id bk8-20020a17090b080800b002a51dcecc49sm968664pjb.38.2024.05.01.02.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 02:40:08 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s26Ra-00HDgc-2Q;
	Wed, 01 May 2024 19:40:06 +1000
Date: Wed, 1 May 2024 19:40:06 +1000
From: Dave Chinner <david@fromorbit.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	hch@infradead.org, djwong@kernel.org, willy@infradead.org,
	zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH v4 27/34] ext4: implement zero_range iomap path
Message-ID: <ZjIN9nuV6SaNODfE@dread.disaster.area>
References: <20240410142948.2817554-1-yi.zhang@huaweicloud.com>
 <20240410142948.2817554-28-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410142948.2817554-28-yi.zhang@huaweicloud.com>

On Wed, Apr 10, 2024 at 10:29:41PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Add ext4_iomap_zero_range() for the zero_range iomap path, it zero out
> the mapped blocks, all work have been done in iomap_zero_range(), so
> call it directly.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/ext4/inode.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 9d694c780007..5af3b8acf1b9 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4144,6 +4144,13 @@ static int __ext4_block_zero_page_range(handle_t *handle,
>  	return err;
>  }
>  
> +static int ext4_iomap_zero_range(struct inode *inode,
> +				 loff_t from, loff_t length)
> +{
> +	return iomap_zero_range(inode, from, length, NULL,
> +				&ext4_iomap_buffered_read_ops);
> +}

Zeroing is a buffered write operation, not a buffered read
operation. It runs though iomap_write_begin(), so needs all the
stale iomap detection stuff to be set up for correct operation.

-Dave.
-- 
Dave Chinner
david@fromorbit.com


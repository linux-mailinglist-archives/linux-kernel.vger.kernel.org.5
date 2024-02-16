Return-Path: <linux-kernel+bounces-68073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2868575A2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D409C1C22B92
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F39134CE;
	Fri, 16 Feb 2024 05:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYk41q+X"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655AD12E5D;
	Fri, 16 Feb 2024 05:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708061490; cv=none; b=SoJxg2jKgThgm3yBJ4qTpKpNr4+R0bKh1a0MRIEbtzuGP1kgcVMvIwBVZuvMyVb/F/r/NY+wEuRblxxoEDZhWcThizjVI97brMPvESIFT+VbTbvpoFN9iYswfUQ2oZfemAHF19EDnnH/S201u8OQnfpFF9BkPXS6+WF4TyTXOrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708061490; c=relaxed/simple;
	bh=IO6wXrWgnOjdRNHYOyVqjCgY14opWEM+FIcIepTxP2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlCl4B4P+ip47/mzFdPIgnkxjsoG3Scqc+TuIGgbPFYgUJ910FCrnNDjmMG+lG44glB33yHaLpfYwCtkW2aY7iz9nykT0wiH9NgKnqnn6dCwiC2FKKa61s8vr6dUprB2ecsueixEPiKgC33DJL+hdxUj1Ow3qsFrMffzdeMstCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYk41q+X; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29080973530so1336033a91.1;
        Thu, 15 Feb 2024 21:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708061489; x=1708666289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tjqvFkfM5Lfa1Uthf+wvZFrrDCYAGzM+X3+/QDBtjEM=;
        b=CYk41q+XMi7pEKFm5ccZKryI1/CHhTiA7ESChp5L3AErW7lk+c6fwAlDxdq0QA2Ziu
         Wq783wrwrhBm2ql3TTt2eYxeYsQYusCD//alGnMcBRn33hZin5Ki2tbdKnvj8jtVou+F
         lhphAjHoZYV2+O9FnhAo/8BbGWh+pcLIt3FU8Fg3SE5sd5lpge2VsZOW0ilLyaBEi1QC
         NEb+XQUJ/DW6gd3BPFVVUn+RF8r4E7QXHyJMxgNp9gj0hA8UEtAqkNzC71PRqQe7l9x+
         bh0Qiy7wnzUNkc6fFp9hBB+gX0f9h9lx5FuBp8sKfXuj0Qu0802jdPJZV/o3VRj2fQb2
         t0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708061489; x=1708666289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjqvFkfM5Lfa1Uthf+wvZFrrDCYAGzM+X3+/QDBtjEM=;
        b=HR7kWmDHH4q5HyxWEjUGkObw+LKQETEY3i/Flsi+5WjXKAHKLOuzEX+3KP1nOe9thb
         JLg5ogYbJq0tInZ3/owStAFcUf+iEPnCh7m2gFdM4YFBkyAKRv1p/wtjyIB09UorLc12
         8Me6Yi5M/A7xiLw/Ds+f8KyKvwSCr4Q9GWGT4C7IcZQga+7Arhiiezy2BtOurQHKtIWA
         vtUCnVXcYiuFO90FOOh+mAfLZWEHPKh0RN2g55wfXg33cLsnEw6lTU8i87qrxp+nB6gV
         gU10zsSu96OEeYXc/BKTAJZK5ZxfwVqsTlmliEKygs0p5GF851HrMOC2Y/q4ZspLqYBM
         lGCA==
X-Forwarded-Encrypted: i=1; AJvYcCV2LLl/Vc2tJSsHqqbQ9q/Sf/0O1Co53K4ifxlZgdKJwuBYaJvJ/6ai+fckKg5NISDKhxg/iX83yj12DkwwbGyfzVxGKxq5
X-Gm-Message-State: AOJu0Yx22YpN8iIWUREUPawBtTK9D0y5/UrsRIlyZRaGy5WGvWjox4S6
	N7jbOfIk4L4M3cVxJ2YRbsIEHoSI6XJ9YBQ/sg8Kt6GFibSscm5K
X-Google-Smtp-Source: AGHT+IF3YmN1qawIPxNBZ267l/ivRrJxf0WqB2STpKTxG3GPCe2BMlVFVyRTIk7pohrmWgR5uF5SPQ==
X-Received: by 2002:a17:90b:fca:b0:299:3007:ad13 with SMTP id gd10-20020a17090b0fca00b002993007ad13mr1404504pjb.32.1708061488696;
        Thu, 15 Feb 2024 21:31:28 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id t22-20020a17090a1c9600b00298e639d17esm2647645pjt.22.2024.02.15.21.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 21:31:28 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 15 Feb 2024 19:31:26 -1000
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org, mpatocka@redhat.com
Cc: linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	msnitzer@redhat.com, ignat@cloudflare.com, damien.lemoal@wdc.com,
	bob.liu@oracle.com, houtao1@huawei.com, peterz@infradead.org,
	mingo@kernel.org, netdev@vger.kernel.org, allen.lkml@gmail.com,
	kernel-team@meta.com, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, David Wei <davidhwei@meta.com>
Subject: Re: [PATCH 6/8] net: tcp: tsq: Convert from tasklet to BH workqueue
Message-ID: <Zc7zLsEhDzGkCH9m@slm.duckdns.org>
References: <20240130091300.2968534-1-tj@kernel.org>
 <20240130091300.2968534-7-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130091300.2968534-7-tj@kernel.org>

Hello,

On Mon, Jan 29, 2024 at 11:11:53PM -1000, Tejun Heo wrote:
> The only generic interface to execute asynchronously in the BH context is
> tasklet; however, it's marked deprecated and has some design flaws. To
> replace tasklets, BH workqueue support was recently added. A BH workqueue
> behaves similarly to regular workqueues except that the queued work items
> are executed in the BH context.
> 
> This patch converts TCP Small Queues implementation from tasklet to BH
> workqueue.
> 
> Semantically, this is an equivalent conversion and there shouldn't be any
> user-visible behavior changes. While workqueue's queueing and execution
> paths are a bit heavier than tasklet's, unless the work item is being queued
> every packet, the difference hopefully shouldn't matter.
> 
> My experience with the networking stack is very limited and this patch
> definitely needs attention from someone who actually understands networking.

On Jakub's recommendation, I asked David Wei to perform production memcache
benchmark on the backported conversion patch. There was no discernible
difference before and after. Given that this is likely as hot as it gets for
the path on a real workloal, the conversions shouldn't hopefully be
noticeable in terms of performance impact.

Jakub, I'd really appreciate if you could ack. David, would it be okay if I
add your Tested-by?

Thanks.

-- 
tejun


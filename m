Return-Path: <linux-kernel+bounces-100842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264E8879DF4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E8E2B21FF6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2B0143C71;
	Tue, 12 Mar 2024 21:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNMTFNkp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6811B14372D;
	Tue, 12 Mar 2024 21:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710280518; cv=none; b=k7PoirrDTcbjRcTIA0dpDuvMilgA61stMpbmX0NOiVz7W3i+2UGoTmEp5YwTTTW27CgeHt1C59ZiITAcsOoU8u6Nhx4m9LAn3L8iEaxx2XKVU7LHtCRSBidg/51QaTlf7LP+BswzxUbTiRsVuI89TKwYiSjLJOY+E6pzj7mnzwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710280518; c=relaxed/simple;
	bh=rWyBCaABM7BjP+jsKhkBAhIamVuOWhkDoE+2oVJFpyE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ntGeb0gwJ021EDTUKHnKhxiP/tZnEqP3cIW8+TP92CzoXGorP0wOY1CO2ldQoNqmwRply9j9fxcGvn8ZKLJw9RFN2ed9xxPa2d8/oeHalT9VQZ63PgzDHzkhqy3gNdgVEzTcOhG0xYkwjx5QGD6jD6cmOTRikA8XYm27ufbFA5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNMTFNkp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914D9C433C7;
	Tue, 12 Mar 2024 21:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710280518;
	bh=rWyBCaABM7BjP+jsKhkBAhIamVuOWhkDoE+2oVJFpyE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eNMTFNkpuAX9/+aM/SM9R6Z9B0iaqnJSlXIC9sTDZ5yRZc93MmrFK5e+NLh+KMf6o
	 86Mfd2UphZdGS1M7YlxbxQl2UIR3mGA3VR08pDJp80KSRAwh20JQLMiBC3n69bkrRl
	 kVxg3P9ibpBw3NvVvGN8LAiBXc/Pm8Y4lVeepG7loh5UoXAvDlWfQloKGnQijMPJkA
	 NsJH10QQ+nG9IzHIxUZI8Pszsg1W1bhU4F34xVb44mdbMBMIrkNf/6AhpbNM/qAW+z
	 g1jRWvx01L7fICIuHJzzqi5qamNsr+9lSb4t9yW9LViRlGez56kDAvBKTyKPVHTijv
	 MjQDWuGhkYrTw==
Date: Tue, 12 Mar 2024 14:55:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Thumshirn
 <johannes.thumshirn@wdc.com>, davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com, bpf@vger.kernel.org, Tejun
 Heo <tj@kernel.org>
Subject: Re: [GIT PULL] Networking for v6.9
Message-ID: <20240312145455.403b713f@kicinski-fedora-PC1C0HJN>
In-Reply-To: <20240312144806.5f9c5d8e@kernel.org>
References: <20240312042504.1835743-1-kuba@kernel.org>
	<CAHk-=wgknyB6yR+X50rBYDyTnpcU4MukJ2iQ5mQQf+Xzm9N9Dw@mail.gmail.com>
	<20240312133427.1a744844@kernel.org>
	<20240312134739.248e6bd3@kernel.org>
	<CAHk-=wiOaBLqarS2uFhM1YdwOvCX4CZaWkeyNDY1zONpbYw2ig@mail.gmail.com>
	<39c3c4dc-d852-40b3-a662-6202c5422acf@kernel.dk>
	<20240312144806.5f9c5d8e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Mar 2024 14:48:06 -0700 Jakub Kicinski wrote:
> > index 9a85bfbbc45a..646b50e1c914 100644
> > --- a/block/blk-iocost.c
> > +++ b/block/blk-iocost.c
> > @@ -1044,7 +1044,7 @@ static void ioc_now(struct ioc *ioc, struct ioc_now *now)
> >  	unsigned seq;
> >  	u64 vrate;
> >  
> > -	now->now_ns = blk_time_get_ns();
> > +	now->now_ns = ktime_get_ns();
> >  	now->now = ktime_to_us(now->now_ns);
> >  	vrate = atomic64_read(&ioc->vtime_rate);  
> 
> Let me try this, 'cause doing the revert while listening to some
> meeting is beyond me :)

That fixes the crash for me!


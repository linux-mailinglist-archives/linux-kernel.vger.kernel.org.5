Return-Path: <linux-kernel+bounces-124080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 135768911E8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 447B91C23DCB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBA238DF9;
	Fri, 29 Mar 2024 03:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OtQjlA2w"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3FD38DF1
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 03:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711682577; cv=none; b=n5Ez3RJhMD4QbIAuEjzi2YRdBKXSQ368TF7IqVp8AkSn9z0MvqTp2LlA+H+UfIJOXBnyNzaf4zqtAT8cOuTZtkKMJgiU9xoUuHf9OgfxYsb9Yi6+YygK1JtFj31bnYg0dXlXbglmJ++LB4Injt+5cHy6/fw13ZhMdtZb0F/87r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711682577; c=relaxed/simple;
	bh=UosmYOUW6SFDi8mgKmO6rGO2sEvym91GqVw7p/qL1QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSD1E8YpTeQZMDlwUOjEdYqC91oDl2SZMd6YXDgNyk1r/Dy3woUOscNMBZn35Kh5aYZwU6ZAvrjrqjoaF7i/AGcPiNF6+gTCwCfkdC5rkgrLkc5whQGHNSMI3MGgy5Ga5BI0iblMDX15PIpoK3Olve7GBP8xBuBg6snrfa6+Yg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OtQjlA2w; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UGdFzpICfaV+8ThE51KHdHGqQoHRD+rUD1E0BFvJSjc=; b=OtQjlA2wcXmFa4WpVrnV/bgs7T
	MF5Q4CH/EHzNJQSJ0rTPqETPMI0uW+9itD2kHn1zHJO/MG/SAmkXQWXTaLtF8+a2G5vavsbMEpuIX
	nuIoB0PcnOtv8Jd1fWZY1h3w0rO5IGBokBQRI3skTmKFUmEqcz5qFqNKmNxaJHCyRRJ344CYOXpkc
	MNrJXplL3KIGHtfrtaz296XVeiQo/3UuFwmEHy17PTxrqoIuO2vuR2GGLrxh/ylcTyVMZuK06WsPl
	E3MAQP2V4XPH2r1+SRCwQE7AuZm+sjw39eehvYFylSRvwTp2in2FJ26OT1ysshMi8Zpytz3iq2e9o
	OSA5Lr8A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rq2pN-00000007sQx-05mP;
	Fri, 29 Mar 2024 03:22:49 +0000
Date: Fri, 29 Mar 2024 03:22:48 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] mempool: Modify mismatched function name
Message-ID: <ZgY0CGZGgV7kgehP@casper.infradead.org>
References: <20240329030118.68492-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329030118.68492-1-jiapeng.chong@linux.alibaba.com>

On Fri, Mar 29, 2024 at 11:01:18AM +0800, Jiapeng Chong wrote:
> No functional modification involved.
> 
> mm/mempool.c:245: warning: expecting prototype for mempool_init(). Prototype was for mempool_init_noprof() instead.
> mm/mempool.c:271: warning: expecting prototype for mempool_create_node(). Prototype was for mempool_create_node_noprof() instead.

Please stop.  This is being fixed differently.


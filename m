Return-Path: <linux-kernel+bounces-144788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA63C8A4AB9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68892B26529
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D789F3B18D;
	Mon, 15 Apr 2024 08:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lDZIzck4"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162DE39856;
	Mon, 15 Apr 2024 08:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170783; cv=none; b=eH5+F8qXSOI3CpO2eTSf8joiDn0zzRHLWzApi69SUmup6fJ+swljFSJjnnpUdD8HzRd2/aDkNtgMNZEZWtjH/vZyygirbw5MUsrByFzFYHJeCgaQSHKewU0fQBVZgdee6h6AWAvaGYLN1TFPTRb8Ceh2s0jBnZlWRmaQo94++dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170783; c=relaxed/simple;
	bh=cPXg3aPIXYU2ij/Q5bT/qYLiuY6yQzabqRA3oLzr0x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtLtTdj1HLyPJrz+L97iM8jET9RgsUavYzxn97w5IvZDoPsIuhANIfVHh7oYJNzrDVE3bW3xX9rBrI099ihMpVy9NAnv95xemRR9qp1rtygY91XLPdH7ZBnLCmBUVHPfgyS7dx5cL5UJYSUbi/xhQ8Uvx03o+589LFjj1yhipB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lDZIzck4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/YX6USCWJSVZiip4uuo05Pgl5yLVCXv3+OwpmFbpW20=; b=lDZIzck4gsUveDH5ZPPkHWpRM2
	7AXDgH2y/ktk2EAWhjpS5SYvHXyJo6YJ/5XM/qYf/0XFrOTVtUr9/wEzl1SUkEQpgI7893ycyIp1m
	oy9HC2kVOJ6AHE1PcFvU1ThJ2MNVnkZRFRMEOeqACfTP7Ex2f1BxP1Ev4o5C3M8Ce8rHeJ5xLHAMu
	smr3AQqcLzLrszlF/6D1vxW3rq2nwYGz3RKjeOHwtD5P40WiI7cvImvL4pt5zca7tDUpJoOmOjuCr
	x5vjv/GOz+j4sp/y4an+SQaVQPnM+kT4EvaedTp5ekyO8fzwl4l9J7wODdtEalKFK2YF7DgQzsfqM
	ohpcAmbA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwHym-00000007b7Y-22mH;
	Mon, 15 Apr 2024 08:46:20 +0000
Date: Mon, 15 Apr 2024 01:46:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, Alex Elder <elder@linaro.org>,
	corbet@lwn.net, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: coding-style: don't encourage WARN*()
Message-ID: <ZhzpXOUeldwAzXxY@infradead.org>
References: <20240414170850.148122-1-elder@linaro.org>
 <ZhzgTeEHFF19N3UZ@infradead.org>
 <2024041544-fester-undead-7949@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024041544-fester-undead-7949@gregkh>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 15, 2024 at 10:35:21AM +0200, Greg KH wrote:
> On Mon, Apr 15, 2024 at 01:07:41AM -0700, Christoph Hellwig wrote:
> > No, this advice is wronger than wrong.  If you set panic_on_warn you
> > get to keep the pieces.  
> > 
> 
> But don't add new WARN() calls please, just properly clean up and handle
> the error.  And any WARN() that userspace can trigger ends up triggering
> syzbot reports which also is a major pain, even if you don't have
> panic_on_warn enabled.

Important distinction here:  WARN_ON_ONCE is for internal error
checking and absolutely intentional, and does not replace error
handling, that's why it passes the error value through.  OF course
it should not be trigger by user action.

> And I think the "do not use panic_on_warn" recommendation has been
> ignored, given the huge use of it by vendors who have enabled it (i.e.
> all Samsung phones and cloud servers).

Sucks for them.



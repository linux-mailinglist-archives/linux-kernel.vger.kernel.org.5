Return-Path: <linux-kernel+bounces-58887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D50384EE24
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 01:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC32D288303
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4784A2D;
	Fri,  9 Feb 2024 00:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UZHjRzVX"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AD646B8E
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 00:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707436809; cv=none; b=Kn1r/NzhLQEwCZtnpnRZj7puONNUJwWr9oUBqGkdhwpSX0niYG648e/lYDlMjtBrFO5fxNxCyajAKJLRDH78d42WrJhCwYlHXpZPWdsLd8wvK3dgNxSPrjZxGNYSKFPV5FaElVg+dEB13i8Yjn8PRpQ/tTAEmaq0q1W3RALf83U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707436809; c=relaxed/simple;
	bh=JxMfeZjaML7SdYJ1E4A0DGEf/Kj9v2i0W7aFGWzHIWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaVhKgXPwrUPQmnBbE/B1ZM2D0OfbSYnIOn6FP6OIhvjmZ57Rzbd5Xv89miiOWXYAj2gNvWKRKhAF9ksXpdxfoJ2yjmIGO6qOuMft5pojQnxlHxgRufM4Ji7BOmz8tqPvu+/8wh97hCvEGpjwbmN4PiI/jswJzCUgIGZoFi1nH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UZHjRzVX; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 8 Feb 2024 18:59:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707436805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zWJhXqv1t7z5bjOKHqSFLqTyKM1+d6jY2IACUfrBfW0=;
	b=UZHjRzVX5Zd8JvQ7b5lVaW/l9B06Z7JWKZ42cqku20j/C+wMUuMDDBKJtBhvHPoOQH4foz
	VfZitGJV//8WwgUF0prhU1ZEAFOnYLQwMEHmlPF/tb5u5Zp5xlKQIkCLl4iG3Mv1DbM6Go
	a/TNgDDC8NSyXc8igmXjQltFpgtxsoU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: linux-next: build failure after merge of the bcachefs tree
Message-ID: <cxqtdu5d55vwnngvkah7wy5ts4wximmqvra5rmcwtvv4vw3zqi@mwwh2ygbwh6c>
References: <20240207115755.338828db@canb.auug.org.au>
 <20240209094615.5acd86fc@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209094615.5acd86fc@canb.auug.org.au>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 09, 2024 at 09:46:15AM +1100, Stephen Rothwell wrote:
> > Caused by commit
> > 
> >   cfca113ae06c ("mean_and_variance: put struct mean_and_variance_weighted on a diet")
> > 
> > I have used the bcachefs tree from next-20240206 for today.
> 
> I am still getting this failure.

Apologies - should be fixed now


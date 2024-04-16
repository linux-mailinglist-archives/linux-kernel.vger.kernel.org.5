Return-Path: <linux-kernel+bounces-146812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68798A6B58
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98DF0282F6C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FCA12BE9F;
	Tue, 16 Apr 2024 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QQGzc+Mp"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A750E5A10B;
	Tue, 16 Apr 2024 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271368; cv=none; b=VBJmFZK9+bayQJkUM91U6c0Kp4KFz4QRIK2IVzodp4FB7FwDXKyoBQmfgXw+1/97JaXIUM9IQgW49FyKKz8ubKh5uRxZchXsjMrxhs+8wy+lyjfUZUbU73NIHCLoUMGDqmqpRWaQSBrXHSjYiVK2c4RcwjKdjfrFHc/ErxddE/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271368; c=relaxed/simple;
	bh=Z3o1gq2t45hd4yKUnY31ORnnTVLdx9F+031CERXTE7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDapsonlfoXgXQ+W5rrMTmnkYJnIMN2bb01BGfdYTvu+/5b3iigrmA3oJOEAkV16RwITwjy5aD3JQq/urTYCmlLB69mKeXJ65DiENaNHfLMF9WEEsu9F33xF9VmXNo2XgRo9L0enkG1e6GzeV+XwlILaaJl+yltVEA48KdIrvOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QQGzc+Mp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rwMZO2/Y6uI015RjY4LWSZjpMG9RdmPidaij9Dl9ie4=; b=QQGzc+Mpx13NNdeAl7gUw1fego
	1k3n+hFo2wl66H1YaxklPhPIMNhdBC8YgnrPACB4BVxtIN7CoX0pmDMPqsrqSL8BTfZiWL7dBFjt3
	JXYFGSRz1pU7PeBdi+Z264uEVZL4zlqzyhNFA9xyW5tEt3vqXqEzuoI9oWB9wfPe7a+Un+dsRqSuf
	blCJVyj6/nG1r7dYAjbb1AMmLbD7de1zBiwXUc/4UFbYmjEQUaI0KWXkBcCv2QAPHMFy1sYcWXx1u
	L4Fq9Ts/iKpHOk87X5XFUQTms3kMlmKffHw+E3c8c7dKgSZUyC/6uQx8ZZvxKpEal5kMuIScIcNkN
	VLJ8ofeg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwi95-00000000Urw-3u4i;
	Tue, 16 Apr 2024 12:42:44 +0000
Date: Tue, 16 Apr 2024 13:42:43 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k: bitops: Fix typo in comment
Message-ID: <Zh5yQ6cIK3Rw7O-I@casper.infradead.org>
References: <20240416122155.313400-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416122155.313400-2-thorsten.blum@toblux.com>

On Tue, Apr 16, 2024 at 02:21:56PM +0200, Thorsten Blum wrote:
> s/Coldfire/ColdFire/

do you have nothing better to do?

Also, there are 37 lines with the word "Coldfire" in them, many visible
to the user.  Why change just this one?


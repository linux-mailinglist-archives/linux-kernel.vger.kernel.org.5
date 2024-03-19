Return-Path: <linux-kernel+bounces-106964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8CD87F616
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3FB8B21722
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAF37BB13;
	Tue, 19 Mar 2024 03:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dNVhPe6i"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99207BAFE;
	Tue, 19 Mar 2024 03:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710819377; cv=none; b=gUPKws4DTb3N+jBFhcyyAHwtm340wHc+aYMCbqs7yCobMl9olmn7iQjHNbiL/qGLizpF4zAUOlzEo+EJX65K+PnANZTJ4AftVfF1252WbxPepol1Cxq9HA3lYpZh3KZdgUOB0waTC/jiG82l/2exLS4MA975M/7Fo2Fmd0KpJoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710819377; c=relaxed/simple;
	bh=PIMd915W0emXrQYLUN+Za9tUakfwaMpNV5zYx8sLhHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyrubgR6t+K6OkGW/oBF5jodtM18l9dgjpwPZFGiZ9r0jne/yQL8EbFZ6CM0IaXlQ0mcQc5kq7+UwvFxwzDxnHwpPHFw4ncX8hotXf53nLvViZfO9MTfACtUNE4nFoqRqDwaAXTbJVfHg1yCpbFOShNIF0ga9ZHfdjPXYQ2b90s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dNVhPe6i; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W8KZHTSLAN0wl+H8+4zmrE83z+KBXbAgNIQBfal0lFw=; b=dNVhPe6iXVHQJXXI3coTifOxdJ
	NRydG42UdVSGuxKv83JXqqiVImQDsX92tziT9nkeVrs4TXjtBa3X/gN18dDIq3Au6EoJbMJ0I25PX
	A8pdFbYi2p5Xr1+P35UGoGR4hWILitD1+ScZQ5ombPP1SSjt1ojx8Gj8Ds3HD8hb8QYwfbI+Y/NGH
	3o2eTL34Q2NyAXvc77rb6ZD1fchDHYsrYZ2clOrjgANSOyien2TOZg0AmUO1PIfaCzV7PmCFV4IH5
	+wmIz0Rd7NZnRD/96zwYLmOJ2wOH2M2fzYSXSWz8hvX+VB2dWo+sRyP/3LGexJEHAtMkOiqCGEObN
	Bv9b4BUA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmQGo-000000013M1-3aIY;
	Tue, 19 Mar 2024 03:36:10 +0000
Date: Tue, 19 Mar 2024 03:36:10 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Dmitry Mastykin <dmastykin@astralinux.ru>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	thellstrom@vmware.com, mastichi@gmail.com
Subject: Re: docs: bug in "Krefs and RCU" example
Message-ID: <ZfkIKnu_xBQa59b4@casper.infradead.org>
References: <20240318112744.12400-1-dmastykin@astralinux.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318112744.12400-1-dmastykin@astralinux.ru>

On Mon, Mar 18, 2024 at 02:27:44PM +0300, Dmitry Mastykin wrote:
> Hello all,
> It seems there is a problem in "Krefs and RCU" example, that may cause
> a crash.
> I marked the place between two problem lines with "problem is here" comment.
> If list_del_rcu() will be called between these lines, and list will become
> empty, then q.next will not point to a valid struct my_data.
> entry->refcount will also be invalid.
> Instead, q.next must be read first, and then compared with q to check
> list's emptiness (for example like in list_for_each_entry_rcu macro).

I agree you've identified a problem, but there's no way we should apply
this patch that adds "problem is here"!  Instead we should show the
proper usage, which is a call to list_first_or_null_rcu().


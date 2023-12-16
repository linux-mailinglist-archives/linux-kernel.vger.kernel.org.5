Return-Path: <linux-kernel+bounces-1984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A36728156B7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 517BA2860FC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 03:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5F51FCB;
	Sat, 16 Dec 2023 03:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="thEZbMM8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7491C2E
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 03:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zvGx6PP/uRDz9dSF69qI0IfQy2mDB445jARJru4hM9E=; b=thEZbMM8tE+gqTe19eS8twWfyo
	DJxfdx8KapmltVHgpYmGeZSKu7GOkrrnsKXmRJABYAxLagjkJgj6DWGt0dxj0c/on8NPg9nw6xPEa
	rYhWCDqs1qes9uYU54zK5usRZYl8kdfQIHg+ptO1VgSoYFlXNV/KVJAgva2N6bDByrinhcvLO0gSk
	/CFBnVJWP2k0lavnekQ5reH6FuGjNAXuMazGaW5CSTxa4PpZquYyljbUAsjpFDNOQIGLurIH5XVdQ
	jYyKwx9V7oboYwNjzLDtWdTFVAOmPE3RHhfQGYm5WaCFYTk9k9gB1HcC6SBrKZcmg/PO09M+0pEMJ
	T19p/LCA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rELHB-0067r7-7f; Sat, 16 Dec 2023 03:23:41 +0000
Date: Sat, 16 Dec 2023 03:23:41 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: page_alloc: Simplify __free_pages_ok()
Message-ID: <ZX0YPb40TXCFsZzd@casper.infradead.org>
References: <20231216030503.2126130-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231216030503.2126130-1-yajun.deng@linux.dev>

On Sat, Dec 16, 2023 at 11:05:03AM +0800, Yajun Deng wrote:
> There is redundant code in __free_pages_ok(). Use free_one_page()
> simplify it.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>


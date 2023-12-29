Return-Path: <linux-kernel+bounces-13146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B3482004E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 16:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115791F22D0F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 15:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FC5125B8;
	Fri, 29 Dec 2023 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="udNjXux4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBE4125AD
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MMUixECVcqZI6/mrGqfR1zbER3vh+C3mM3cXKwGEL8s=; b=udNjXux4MUMTrSoC+YQQIhhvXc
	LrhlUHntT/e8YWgJ7h0BN5WXGP4LttWNJ3PgRTV6XR5hqI2MzN1/Y5XxrstdxNFtPJNleTAp+WAcn
	E3OIuoO6CXGseHGk+UdvvvbwJz3I7CDFEnXIs6GG2kO+rqFK9h1immV7yx7KGVE4FdhhvFJ3XR/ZZ
	jxQnAEn/z4CgqaRnMFpr0/S/s3MfwS5aaUKQVTIkUA+9NCHHZsAAgiVeBe0iXW0+bECFRMq4R0hpE
	+eCrDVdryXV/KzeJhKYlf0Y5YJJLD8Uzzm2vSedJGBAZni74fM/6tOxxEGkIeudd+RD7x7tYTDWfA
	QNCDrwnQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rJEwb-006J3z-Qo; Fri, 29 Dec 2023 15:38:41 +0000
Date: Fri, 29 Dec 2023 15:38:41 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Malkoot Khan <engr.mkhan1990@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/cma: Move opening brace to next line for coding
 style
Message-ID: <ZY7oAR7l4HYxJ8y3@casper.infradead.org>
References: <20231229153238.153627-1-engr.mkhan1990@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231229153238.153627-1-engr.mkhan1990@gmail.com>

On Fri, Dec 29, 2023 at 03:32:37PM +0000, Malkoot Khan wrote:
> Move the opening brace of a function definition 'cma_for_each_area'
> to the next line which resolved the error

What error?  This seems like the _wrong_ coding style to me.

> Signed-off-by: Malkoot Khan <engr.mkhan1990@gmail.com>
> ---
>  mm/cma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index 2b2494fd6b59..01ccd26e8bc2 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -579,6 +579,7 @@ bool cma_release(struct cma *cma, const struct page *pages,
>  }
>  
>  int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data)
> +
>  {
>  	int i;
>  
> -- 
> 2.34.1
> 
> 


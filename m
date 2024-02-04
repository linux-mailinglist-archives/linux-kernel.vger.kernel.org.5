Return-Path: <linux-kernel+bounces-51919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 911698490E1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 22:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3B301C20DBA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A5D286BD;
	Sun,  4 Feb 2024 21:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gqqzhyud"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FCB24B59;
	Sun,  4 Feb 2024 21:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707083155; cv=none; b=OAhOQn3FSuYN4S9ZFlEewv5/GsQKq67Hct602nuKJilOdWET/IrSSf7fCQGlWqneeM03YHiXTQ1IAh+tsNxcQ3LjbKC4JlrPK3dZI5gxFdVLXiRp+3mo/Uoi47jWaDBmxr+1QALJYqzhpcQ1U2L366uO0DO+Gy9APRuF0lrZkwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707083155; c=relaxed/simple;
	bh=1xR0XCuhHV7Qt85YM7ZzqnkQZvb/TtMcA7Rs3jW+xwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1IzhWBrX3+/jDRSrK0kLF0LFsbSkEHlRYfo7W4FdKqCxF9h9aQ0lO5aVoImz5jKt4YZwdt664bskESZOnjt49otLSBTuy3H7pvf/k4InaawKQRgKECKtb4gzQ+f/sa+bnWXM+0ON3lenmpb9ulyqgaeoPGn5Gko7Kmj0qCXEIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gqqzhyud; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AKbpPpC2KNpScrnHiKXdj9IxWOEj5wHKkrks2mrCPiU=; b=gqqzhyudN01z4ekGep5cOqAso4
	XBlE+5onefRofuoUNZwIyod4pDnyJwOJwptlQEcv8curRiEQ1ANyXptamBqGroyGWyoEmPdxkYXki
	sdbTQkWvSdxmbzah6f8Nj6tinkk/S17u/dJ/V+cEamU9R6V50FixYJ9F1yKJFiLPgR0aVvZyzJona
	9mKAn98kZYZru4iaTFFPF8F+tUWfrUrr64yT+Hwv7zK4bl5+t0a/DCyvU/gxmpNqoWlJO6Q4oxxr5
	KyR1A1gVrYghfTJu22t+4+TJOIiGxYC6Ca/slkD+I6llhWSia0DH92/KPWDsVEOX3YY8P0b1q1zUR
	sDpQWhng==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWkJ9-00000007eox-3Vb0;
	Sun, 04 Feb 2024 21:45:47 +0000
Date: Sun, 4 Feb 2024 21:45:47 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: multiple .rst files: Fix grammar and more
 consistent formatting
Message-ID: <ZcAFi9ZW07fOLQaW@casper.infradead.org>
References: <20240203215345.4396-1-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203215345.4396-1-thorsten.blum@toblux.com>

On Sat, Feb 03, 2024 at 10:53:45PM +0100, Thorsten Blum wrote:
> @@ -63,8 +63,7 @@ Image output
>  ------------
>  
>  The kernel documentation build system contains an extension that
> -handles images on both GraphViz and SVG formats (see
> -:ref:`sphinx_kfigure`).
> +handles images on both GraphViz and SVG formats (see :ref:`sphinx_kfigure`).

This should have been "in", not "on" in the original ... feel free to
fix that as a separate patch.  Or send a v2.  Whichever suits you better.


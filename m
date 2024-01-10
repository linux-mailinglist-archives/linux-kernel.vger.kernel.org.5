Return-Path: <linux-kernel+bounces-21702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB2B8292F7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 05:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A73BC288183
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 04:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EA263A7;
	Wed, 10 Jan 2024 04:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="S4Xm4orK"
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9692653A6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 04:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=default; t=1704859903;
	bh=EZ/DTkzCHZtvzFXU9l8OijHHr4aC9eWi+q22ZSxjG3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S4Xm4orKXtoRV4Odc9SmF8zlAybjoW3WlzRf9yIfDN7oDGQw1rrOLRXX1xxue4+gi
	 1b+Q8NnVXKDAz3rK0TUePL44wMCw+YVOQdV6+NaUFrwNbej7Cs4iH5d4BoipOeq+Ui
	 TGiMZ9WGC5idCzRKEQPGgsbMGKPOTA3UnbesHb1lA0WaLwZpgLpEFGdoonAIWG1TwT
	 i5MRMwWZ7r9pMr+cddIzAyoV2GapGV9uhtUmPKH8spMzTMwDhoJ0JiLF7WqjU6dF08
	 oBRvHDuT/T9oxyybsvrxV87h+nfwFnY8FJZsHCapQ5hEWlMX7N61CkYEq4SkBuobDE
	 mUs8j9bWPBx/g==
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.126.223])
	by gnuweeb.org (Postfix) with ESMTPSA id C5C7D24C32B;
	Wed, 10 Jan 2024 11:11:41 +0700 (WIB)
Date: Wed, 10 Jan 2024 11:11:37 +0700
From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
To: Brennan Xavier McManus <bxmcmanus@gmail.com>
Cc: Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools/nolibc/stdlib: fix memory error in realloc()
Message-ID: <ZZ4Y+dak5LC6LTg7@biznet-home.integral.gnuweeb.org>
References: <ZZ3aQv3bKk30kKZA@mizu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ3aQv3bKk30kKZA@mizu>
X-Bpl: hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1

On Tue, Jan 09, 2024 at 06:44:02PM -0500, Brennan Xavier McManus wrote:
> Pass user_p_len to memcpy() instead of heap->len to prevent realloc()
> from copying an extra sizeof(heap) bytes from beyond the allocated
> region.
> 
> Signed-off-by: Brennan Xavier McManus <bxmcmanus@gmail.com>
> ---
> 
> All tests from Ammar's original test program pass:
> https://gist.github.com/ammarfaizi2/db0af6aa0b95a0c7478bce64e349f021
> This fix was tested with the following added test for realloc():
> https://github.com/brennan913/nolibc-test/blob/main/nolibc_test.c#L73-L120

Hello Brennan,

Thank you for the fix!

Cc: stable@vger.kernel.org
Reviewed-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Fixes: 0e0ff638400be8f497a35b51a4751fd823f6bd6a ("tools/nolibc/stdlib: Implement `malloc()`, `calloc()`, `realloc()` and `free()`")

-- 
Ammar Faizi



Return-Path: <linux-kernel+bounces-21744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C69138293A6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79DA61F26DCC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 06:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164CA32C75;
	Wed, 10 Jan 2024 06:19:20 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79DF2A1D3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 06:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by mail.home.local (8.17.1/8.17.1/Submit) id 40A6HqdI006376;
	Wed, 10 Jan 2024 07:17:52 +0100
Date: Wed, 10 Jan 2024 07:17:52 +0100
From: Willy Tarreau <w@1wt.eu>
To: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc: Brennan Xavier McManus <bxmcmanus@gmail.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools/nolibc/stdlib: fix memory error in realloc()
Message-ID: <ZZ42kAxNA0ogdMAF@1wt.eu>
References: <ZZ3aQv3bKk30kKZA@mizu>
 <ZZ4Y+dak5LC6LTg7@biznet-home.integral.gnuweeb.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ4Y+dak5LC6LTg7@biznet-home.integral.gnuweeb.org>

Hi,

On Wed, Jan 10, 2024 at 11:11:37AM +0700, Ammar Faizi wrote:
> On Tue, Jan 09, 2024 at 06:44:02PM -0500, Brennan Xavier McManus wrote:
> > Pass user_p_len to memcpy() instead of heap->len to prevent realloc()
> > from copying an extra sizeof(heap) bytes from beyond the allocated
> > region.
> > 
> > Signed-off-by: Brennan Xavier McManus <bxmcmanus@gmail.com>
> > ---
> > 
> > All tests from Ammar's original test program pass:
> > https://gist.github.com/ammarfaizi2/db0af6aa0b95a0c7478bce64e349f021
> > This fix was tested with the following added test for realloc():
> > https://github.com/brennan913/nolibc-test/blob/main/nolibc_test.c#L73-L120
> 
> Hello Brennan,
> 
> Thank you for the fix!
> 
> Cc: stable@vger.kernel.org
> Reviewed-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> Fixes: 0e0ff638400be8f497a35b51a4751fd823f6bd6a ("tools/nolibc/stdlib: Implement `malloc()`, `calloc()`, `realloc()` and `free()`")

Thanks both for the fix and the review! I've pushed it to the "fixes"
branch. Thomas, for now I updated the branch to match "next" (which just
got merged) so as to preserve patch ordering, we'll just rebase it once
6.8-rc1 is out.

Willy


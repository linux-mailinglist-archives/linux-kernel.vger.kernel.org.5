Return-Path: <linux-kernel+bounces-31-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB785813AFE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78311C20FD7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF28B6D1A8;
	Thu, 14 Dec 2023 19:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="zEGNEeQh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B1A6A322
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 19:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D73DC433C7;
	Thu, 14 Dec 2023 19:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1702583268;
	bh=S9MtnhM5Wt/9RJVea0EaRq8s8fxP0MolnOCDOicLfYM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=zEGNEeQhvXLAYZxSXx4lmsUiBLYwLO0ocVijBQIDGpcBNWJifABtTvH6KvLmnAQNP
	 xesW57sWIBiqJuQitwewwooCYTonKIJrkV2Au6Xzj12gq1YZN2a6qZ33Sw7EZOin+W
	 fk7ICyZXWxum2Tp6eBnqeY4R9waw7j8TRwKBhkZw=
Date: Thu, 14 Dec 2023 11:47:47 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "Fabio M. De Francesco" <fabio.maria.de.francesco@intel.com>, Ira Weiny
 <ira.weiny@intel.com>
Subject: Re: [PATCH] mm/memory: Replace kmap() with kmap_local_page()
Message-Id: <20231214114747.ddd42a1e567d2bd0f95f2095@linux-foundation.org>
In-Reply-To: <20231214081039.1919328-1-fabio.maria.de.francesco@linux.intel.com>
References: <20231214081039.1919328-1-fabio.maria.de.francesco@linux.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
> ...
> From: "Fabio M. De Francesco" <fabio.maria.de.francesco@intel.com>
> 
> ...
>
> Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>

We get a complaint from checkpatch (and possibly from Stephen Rothwell)
that the From: and Signed-off-by: email addresses differ.

I tentatively rewrote your explicit From: to @linux.intel.com, which
may have been unwelcome.  What can we do here?



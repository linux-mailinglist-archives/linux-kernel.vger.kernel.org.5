Return-Path: <linux-kernel+bounces-14359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CE9821C13
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB25F1F22044
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A3BFBEF;
	Tue,  2 Jan 2024 12:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KbVlq6Se"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8032FBE4;
	Tue,  2 Jan 2024 12:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704200048; x=1735736048;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b9ZtFWya/borF20E2dsQXsGQe8PlDKzqEuLfQAbaE4A=;
  b=KbVlq6SerJ2Q2FVE0s8eZePzclvJtVLQF4ZpvjziOScfJJtZtSkCjD9R
   T8knFuwp+ByZ713qmEJV5H0MMyLb9vZWQ5DiNkT8KW8vXalQhTBGUEbhF
   qyH6ISRUG0sbr6G+dBTaBYHP8yK47ow+aQ/xhnhsKg/CxG83Nf5+ntv4K
   /B72jxkD4ejx12LldZAo9oSfk89elCRnjnln5KwFBXraA+I8D2USidcdx
   44IYH9Zqf4vtXs1hPQy2+u8WprN7SktjOwc6Y9S0xNvTMHROrS7tOnE0R
   kAllNHI13AoNAjNUcyLAgZ+XZZtVXdWxHcRkLz40Z9Bw2FOE1g7xrICVT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="3713336"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="3713336"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 04:54:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="28056210"
Received: from rmuntslx-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.36.81])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 04:54:05 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id C4FDE10A568; Tue,  2 Jan 2024 15:54:02 +0300 (+03)
Date: Tue, 2 Jan 2024 15:54:02 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the mm tree
Message-ID: <20240102125402.g4i23a757sak3ai2@box.shutemov.name>
References: <20240102164040.2ea3e1f0@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102164040.2ea3e1f0@canb.auug.org.au>

On Tue, Jan 02, 2024 at 04:40:40PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mm tree, today's linux-next build (htmldocs) produced
> this warning:
> 
> Documentation/admin-guide/kdump/vmcoreinfo.rst:193: WARNING: Title underline too short.
> 
> (zone.free_area, NR_PAGE_ORDERS)
> -------------------------------
> 
> Introduced by commit
> 
>   bfbd51786990 ("mm, treewide: introduce NR_PAGE_ORDERS")

The fixup:

https://lore.kernel.org/all/20240101111512.7empzyifq7kxtzk3@box/

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


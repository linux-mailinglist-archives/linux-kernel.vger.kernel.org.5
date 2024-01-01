Return-Path: <linux-kernel+bounces-13855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628A4821395
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 12:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D444EB215C3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 11:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A2929A0;
	Mon,  1 Jan 2024 11:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PFo07lhl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1959B20E8
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 11:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704107718; x=1735643718;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fHXsGbF5MZ+5cHq7r9X1ZNH+Ze3wVEBzW7CBaZKF1V4=;
  b=PFo07lhlnnSoTptTZDmGavc1A83dGa7x6qeh+oWxV5qjHFgA6yuVBxCY
   j9zVyaefEA0kOsQoxA+GZg7L6Ct6QXUpEiNqtnivMWsV6Z262CMxD4vFD
   La4DdBR5qD5HFaWOLIPxErlLYCOYJ+pgm1qaqlXxBvizSGe/BwnQW7wu9
   uuTZOzWK2cAwdi4urda5ZG0Nk0y1+u9fCHQoi6fXHqVeK1iyO3BXE7nPY
   4GQRkDh+7JfC1pKraFLVF+pMgf3j1Zghlbqw/F+UUf0hmR3Br8e1r0q9E
   8zCPNeVWB/eSaCOTavGrxO0DjvFUhGMr7QfH68JQHh+iMZ07vhqI/ocRd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="376938872"
X-IronPort-AV: E=Sophos;i="6.04,321,1695711600"; 
   d="scan'208";a="376938872"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 03:15:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,321,1695711600"; 
   d="scan'208";a="13916465"
Received: from rzlatano-mobl1.amr.corp.intel.com (HELO box.shutemov.name) ([10.249.36.72])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 03:15:16 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id F0064109941; Mon,  1 Jan 2024 14:15:12 +0300 (+03)
Date: Mon, 1 Jan 2024 14:15:12 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: kernel test robot <lkp@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH, REBASED 1/2] mm, treewide: Introduce NR_PAGE_ORDERS
Message-ID: <20240101111512.7empzyifq7kxtzk3@box>
References: <20231228144704.14033-1-kirill.shutemov@linux.intel.com>
 <202312300143.DOaFj2Yb-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312300143.DOaFj2Yb-lkp@intel.com>

On Sat, Dec 30, 2023 at 01:47:55AM +0800, kernel test robot wrote:
> All warnings (new ones prefixed by >>):
> 
> >> Documentation/admin-guide/kdump/vmcoreinfo.rst:193: WARNING: Title underline too short.

Fixup for the warning:

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 8246f94ca307..bced9e4b6e08 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -190,7 +190,7 @@ information. Makedumpfile gets the start address of the vmalloc region
 from this.
 
 (zone.free_area, NR_PAGE_ORDERS)
--------------------------------
+--------------------------------
 
 Free areas descriptor. User-space tools use this value to iterate the
 free_area ranges. NR_PAGE_ORDERS is used by the zone buddy allocator.
-- 
  Kiryl Shutsemau / Kirill A. Shutemov


Return-Path: <linux-kernel+bounces-155520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C96328AF37C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691B11F2316E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B4D13D638;
	Tue, 23 Apr 2024 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EOYsaRka"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420A013D603
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888410; cv=none; b=DsBzhUKb1qto+bGRcqwgI06PVCxDYBoRRvyqhxMgoeB3KqIlJ+5x08q9LR/QkeotykbOVY1zflSrFpYrTuv0tAa/sy6lR6pfX6J32zVrbMrQjEK282SYxOfssG6fh7MkKMlefUG3vmpL+DvaCi60GHfP8Cwye0XDsPk137tM7iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888410; c=relaxed/simple;
	bh=+GPI8MYmRHggMkNqqlNDqdxueKptVdz/4mNIdvW70SU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNSSIx6nuIHiRReuTktR9ctx5+76yxOLG9BN/aoI5+vjuL0R1jkbQPWBAB3I0tAHwyXZwKblg3kqJjtayejsPG7TrGAq7r6tDJLyfHH2/E/8lVpm65RuG+PeF/ippkzXm4rZXa6LRCguC1A8grEkqOXMQAnIzsiUkE5E9kOQofE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EOYsaRka; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713888409; x=1745424409;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=+GPI8MYmRHggMkNqqlNDqdxueKptVdz/4mNIdvW70SU=;
  b=EOYsaRka1Vg1pvqMpQQFz8NSEFnxWfSSMvKlRQrppKVuwrSBZsnfyr0c
   3Z5Twx3nis9/l7dE1JZlDsbV64/csyVpA0m/5LXBgrZCSMNyBC8GdEx3n
   WLWbwlwYTFi+L3tQxxvE7Ri7rP7O3ybGrhPeqnAflq1BYHkZD8A3EePud
   uuBbP9nNJzDly7EjUZiqCa561xcMVbK5V3M5GrJxmlXoPgiHy3MfRxTyS
   0zqj8pemKGlh3rWfq5IQBt/s/jqkusfC13QUOSekhZBuFw/rDK5oqnH0O
   iiblRlUpH7H/TWIp28CWdgecdW9dqnONewgZIA5CN81FaKC3v6hY8NBdO
   Q==;
X-CSE-ConnectionGUID: bG3rGonXRU2IUjiFbLiXCQ==
X-CSE-MsgGUID: tjdpuARjTqWoBQoGgqRkXw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="26940102"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="26940102"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 09:06:48 -0700
X-CSE-ConnectionGUID: CsZkNFG2Q1aASJYgHTE/vw==
X-CSE-MsgGUID: XGIvMRGoTaa6Cio7AGICug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24932596"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 09:06:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzIfM-00000000Nzz-2Qij;
	Tue, 23 Apr 2024 19:06:44 +0300
Date: Tue, 23 Apr 2024 19:06:44 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mm: page_alloc: Avoid defining unused function
Message-ID: <ZifclKTgLDujzufz@smile.fi.intel.com>
References: <20240423150622.2526825-1-andriy.shevchenko@linux.intel.com>
 <f3qr7e7nmith6i4dbffsxvm63wappv4nl4d7nuto4432mpcec3@t74zh4amndir>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3qr7e7nmith6i4dbffsxvm63wappv4nl4d7nuto4432mpcec3@t74zh4amndir>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 23, 2024 at 11:55:49AM -0400, Liam R. Howlett wrote:
> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [240423 11:06]:
> > In some configurations I got
> > mm/page_alloc.c:656:20: warning: unused function 'add_to_free_list' [-Wunused-function]
> > Becuase the only user is guarged with a certain ifdeffery,
> > do the same for add_to_free_list().

> Why not relocate it within the existing CONFIG_MEMORY_FAILURE block?

No objections, I'm not familiar with the idea behind this helper.

-- 
With Best Regards,
Andy Shevchenko




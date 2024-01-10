Return-Path: <linux-kernel+bounces-22301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A97F829BFE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1DEB1F20F71
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D344B5A4;
	Wed, 10 Jan 2024 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J5IfoyvQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB9848797;
	Wed, 10 Jan 2024 14:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704895508; x=1736431508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SWsVBP9cH1tPvG/nm5K35e0TZLa1y3pyiKzTVosVQgs=;
  b=J5IfoyvQj8rfI1q3F64ikezYOc9WmxMkjRU8pBJ7l/+VubWzKpTJDE18
   XkdIvEcwt5Cy4GB4K1uiSSdgwZY0MZwkTXk9qdYv3vQmzosvmubEFJY8J
   xt950ebP5QpwaXpWSlNYkuPxi/FeNNtCncOflfsxvr7oRzPPFBUm5M6+9
   xbDZwKC+ZreqKffG2VXFctwhTuDOwBFJn3hXLyn34xPiyJaBr0/QOmLgl
   3H/fEtmyABxzhuADGI1I6MNVGCY1Kvdh4ITXdT7XfgPSabgwnMJGNUu5I
   w2mfrHtNfLmR0LPf1XRce2blvZ0f2aHkIvzQ7g+lNF7yf+bJGIkWXrShD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="397382779"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="397382779"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 06:05:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="905546712"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="905546712"
Received: from kpurta-mobl.ger.corp.intel.com (HELO localhost) ([10.252.37.105])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 06:05:05 -0800
Date: Wed, 10 Jan 2024 15:05:01 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM <linux-pm@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] PM: sleep: Restore asynchronous device resume
 optimization
Message-ID: <ZZ6kDVD3p4KdR9Cs@linux.intel.com>
References: <10423008.nUPlyArG6x@kreacher>
 <ZZ5zcBBEv7qupIdE@linux.intel.com>
 <CAJZ5v0gp6uETgLNHxDnSd4h_0ois7J2AC7soJJVv18B99GmxcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gp6uETgLNHxDnSd4h_0ois7J2AC7soJJVv18B99GmxcQ@mail.gmail.com>

On Wed, Jan 10, 2024 at 01:33:07PM +0100, Rafael J. Wysocki wrote:
> > I would consider different naming just to make clear this
> > is regarding async call, in_progress looks too generic for me.
> 
> OK, what about async_in_progress?
Sure, that better.

Regards
Stanislaw


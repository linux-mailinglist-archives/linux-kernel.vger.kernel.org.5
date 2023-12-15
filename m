Return-Path: <linux-kernel+bounces-1557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E5081500D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7EAE1C20EDB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC753FE2C;
	Fri, 15 Dec 2023 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bZK2dLB6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3620930127
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702667664; x=1734203664;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t23//pQf+cTyScObljMZUm9xS7JK1PSNe0qGgABMhc4=;
  b=bZK2dLB6C6tDyyCcQwc2FhvgvndpikEld/9/zKvPj+vsla/me0Mr/8zT
   6sh5UdJY96M06oz6slDLPl9bnSiN8tmCNU3qtlNULzPlOBV5zcIccg4h+
   qKFIQ4vLvwLovR8/RGtKkVRgWrzrHNAIBG45825P+FBtRmp0R2LQiSVwh
   wAFDq9SIZnNywAcQHma4wWC936oIiQ6efwQo8s/lOiVCatv7vSDqeD7ii
   yx83L20i64jbJ4CEge8XGicAoeVtX2YClOvZLcFO38P9I0kB9jPiAI1xM
   OZjfMXrY3UzZFG9Xjm1BunGQ1DpWvymrKnGAAPrKMRl7B8JtJluVarW8g
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="399154755"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="399154755"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 11:14:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="1022027672"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="1022027672"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 11:14:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rEDdc-00000006Cyg-0jHS;
	Fri, 15 Dec 2023 21:14:20 +0200
Date: Fri, 15 Dec 2023 21:14:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 0/2] bitmap-str: A couple of fixes
Message-ID: <ZXyliw1ougOO2Vha@smile.fi.intel.com>
References: <20231215184218.2005611-1-andriy.shevchenko@linux.intel.com>
 <ZXyieGvEDXLqHxhn@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXyieGvEDXLqHxhn@yury-ThinkPad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 15, 2023 at 11:01:12AM -0800, Yury Norov wrote:
> On Fri, Dec 15, 2023 at 08:41:07PM +0200, Andy Shevchenko wrote:
> > Imtended to be folded into original code, hence no proper commit messages.
> 
> s/Imtended/Intended
> 
> Didn't understand why you didn't write commit messages. It breaks the
> very basic rule. Can you elaborate?

I expected you to rebase your original commit.
Or based on my understanding of your comments I can submit a revert, if you wish.

-- 
With Best Regards,
Andy Shevchenko




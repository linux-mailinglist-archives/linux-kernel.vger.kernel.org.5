Return-Path: <linux-kernel+bounces-7108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237DD81A1BE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56AFD1C20BF2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9D43FB11;
	Wed, 20 Dec 2023 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bcuvbqw7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0C646427
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703084392; x=1734620392;
  h=resent-from:resent-date:resent-message-id:resent-to:date:
   from:to:cc:subject:message-id:references:mime-version:
   in-reply-to;
  bh=dYVnPf9oHskhTHAwIlHPPxyaHADOhxmPpVIoHmI88Zw=;
  b=Bcuvbqw7LBMnErZDD5UOLEamYdWzgLVchqrIyIeqg4nqZ0VSwYru+EIt
   WmOks/8R0MfOph1ms4k8yGWzFNxOEk92mnVWiiV3H4HIzHRRygW4KIAjt
   WmMUNBf65a48fi9H13vIZzWPi+vwZXsEX2qXIBF/Y/2yggp4gEO2IlvLF
   q1uFs8nCkimLlXER16wFiUfjfFq+k7kyYuQw+d5UF72djxPIkpcKrXZJN
   EwTvkHw5YlIVQPcKCA5HaFikWdpZuIWKxqC/vcxHp2VceDseS5JecX1av
   NaVAGqnvlIAkVVpSN/kaodJANqUpDTB4QIDNmsZja0ls3T3lA4JOx58LH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="375978487"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="375978487"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 06:59:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="805288083"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="805288083"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 06:59:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rFxwv-00000007Z63-3Z99;
	Wed, 20 Dec 2023 16:53:29 +0200
Resent-From: Andy Shevchenko <andriy.shevchenko@intel.com>
Resent-Date: Wed, 20 Dec 2023 16:53:29 +0200
Resent-Message-ID: <ZYL_6WKoX2wWyAjJ@smile.fi.intel.com>
Resent-To: wqu@suse.com, adobriyan@gmail.com, akpm@linux-foundation.org,
	christophe.jaillet@wanadoo.fr, linux-kernel@vger.kernel.org
Date: Wed, 20 Dec 2023 16:16:43 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Qu Wenruo <wqu@suse.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-btrfs@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] lib/strtox: introduce kstrtoull_suffix() helper
Message-ID: <ZYL3Sg85PyTOvjiW@smile.fi.intel.com>
References: <b3ae8802-b4e0-4542-8fe0-e2d169944ac0@p183>
 <cb6fe9e6-6869-46d5-8826-19ed5b5c439f@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb6fe9e6-6869-46d5-8826-19ed5b5c439f@suse.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 20, 2023 at 08:31:09PM +1030, Qu Wenruo wrote:
> On 2023/12/20 20:24, Alexey Dobriyan wrote:
> > > Just as mentioned in the comment of memparse(), the simple_stroull()
> > > usage can lead to overflow all by itself.
> > 
> > which is the root cause...
> > 
> > I don't like one char suffixes. They are easy to integrate but then the
> > _real_ suffixes are "MiB", "GiB", etc.
> > 
> > If you care only about memparse(), then using _parse_integer() can be
> > arranged. I don't see why not.
> 
> Well, personally speaking I don't think we should even support the suffix at
> all, at least for the only two usage inside btrfs.
> 
> But unfortunately I'm not the one to do the final call, and the final call
> is to keep the suffix behavior...
> 
> And indeed using _parse_integer() with _parse_interger_fixup_radix() would
> be better, as we don't need to extend the _kstrtoull() code base.


My comment on the first patch got vanished due to my MTA issues, but I'll try
to summarize my point here.


First of all, I do not like the naming, it's too vague. What kind of suffix?
Do we suppose to have suffix in the input? What will be the behaviour w/o
suffix?  And so on...

Second, if it's a problem in memparse(), just fix it and that's all.

Third, as Alexey said, we have metric and byte suffixes and they are different.
Supporting one without the other is just adding to the existing confusion.

Last, but not least, we do NOT accept new code in the lib/ without test cases.

So, that said here is my formal NAK for this series (at least in this form).

P.S> The Subject should start with either kstrtox: or lib/kstrtox.c.

-- 
With Best Regards,
Andy Shevchenko




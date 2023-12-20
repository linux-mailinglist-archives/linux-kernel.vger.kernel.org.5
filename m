Return-Path: <linux-kernel+bounces-7031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A249581A0B1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DA4928C963
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503F038DD6;
	Wed, 20 Dec 2023 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFCACBXf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78C438DD9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 14:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703081206; x=1734617206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FXt9o85Q7uEvTfQ1NLI9yeZgFO9/slgh99dOMa+Vk+I=;
  b=aFCACBXfg9xJLNEaOnUveZIDZXztzrswKq89PCGZEUDixp41SGMAfM5n
   Srfp9JtTJC/4z2cxuiqBcee/URQ+3YS/D4Fdgom1YixEIXgnEPuc0srOT
   asmCwR7UfpFXGRRqDg4GofMLkeMaSoyTlPp9QMczZ5oSJ740C3721FuXC
   5WNxK5u5pX49+Unxshtk5aXmeCDKeoNqwHjBsYsVOaYO9F2yuvFXkRZ8F
   uYT0ChIMn4uGJ/VRJNILTcg1Sd0KOFnl1W6sRT7Y3dwnUfOw+yPO3rQt0
   kFpkStiMom3iN9vyoWlIydmSfUQUgnczFhzjq+oPsod3radHFOCBGQNMu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="2657452"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="2657452"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 06:06:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="779862550"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="779862550"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 06:06:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rFxDX-00000007YN2-2Dr8;
	Wed, 20 Dec 2023 16:06:35 +0200
Date: Wed, 20 Dec 2023 16:06:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Yury Norov <yury.norov@gmail.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [RESEND PATCH v2 0/4] genirq/irq_sim: misc updates
Message-ID: <ZYL06wR4vanbvTdC@smile.fi.intel.com>
References: <20231115165915.2936349-1-brgl@bgdev.pl>
 <CAMRc=MfoE93Aum4s-pweeb_idqYgUG-DBpXnhT5UW_WhVkLwHw@mail.gmail.com>
 <CAMRc=Md6fCbXco-VOZeDM=cAy_a6HGjM8N5jse5OM7AXSha4dw@mail.gmail.com>
 <CAMRc=MeLCUQ1dGT2RsgrWMBMbGmjQ9tGwEWJ7nBCOss9TfvvGw@mail.gmail.com>
 <CAMRc=MdibLmNYTk6eO7GUu20aaOmsVVX8bHCug8r8yR6EYSefg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdibLmNYTk6eO7GUu20aaOmsVVX8bHCug8r8yR6EYSefg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 19, 2023 at 09:17:38PM +0100, Bartosz Golaszewski wrote:
> On Mon, Dec 11, 2023 at 10:14 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > On Mon, Dec 4, 2023 at 9:47 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > On Wed, Nov 29, 2023 at 10:18 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > > On Wed, Nov 15, 2023 at 5:59 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

...

> > > > It's been two weeks since this submission and ~2.5 months since the
> > > > first one so I guess, a gentle ping is in order. This is not a very
> > > > controversial series - can this be applied?
> > >
> > > Another ping...
> >
> > Is there any formal reason why this cannot be processed?
>
> Ping.

Instead you can now just say that you are going to apply this via your tree,
if there won't be objections, e.g., within a week (or two as it's a holiday
season).

In the PR to Linus you can explain why it's taken like this.

-- 
With Best Regards,
Andy Shevchenko




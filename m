Return-Path: <linux-kernel+bounces-5414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 533BC818A77
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797911C20A6C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8DD1C289;
	Tue, 19 Dec 2023 14:51:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFA71C280;
	Tue, 19 Dec 2023 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="460009862"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="460009862"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 06:51:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="866656687"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="866656687"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 06:51:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1rFbQx-00000007Hy1-0mGB;
	Tue, 19 Dec 2023 16:50:59 +0200
Date: Tue, 19 Dec 2023 16:50:58 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: xiongxin <xiongxin@kylinos.cn>, hoan@os.amperecomputing.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v3] gpio: dwapb: mask/unmask IRQ when disable/enale it
Message-ID: <ZYGt0vbI0NHzvjod@smile.fi.intel.com>
References: <20231219013751.20386-1-xiongxin@kylinos.cn>
 <7zdg5ujizncarxvdyahnusojiq44rzxx2zybqj4kzsonzr27gq@fm5wj7npqsk3>
 <CAHp75VceVAZYTNsJaYYRN+EMExFZSQARsJowd-CvDLRtuOPKSg@mail.gmail.com>
 <euhbczna4hk5sacb23i2xwqh2jewlek7cfceprfslpsiijhwk3@3d6vtybmgag5>
 <ZYGsRXJUcrLKEzUn@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZYGsRXJUcrLKEzUn@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 19, 2023 at 04:44:22PM +0200, Andy Shevchenko wrote:
> On Tue, Dec 19, 2023 at 05:31:38PM +0300, Serge Semin wrote:
> > On Tue, Dec 19, 2023 at 04:17:16PM +0200, Andy Shevchenko wrote:
> > > On Tue, Dec 19, 2023 at 11:14 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> > > > On Tue, Dec 19, 2023 at 09:37:51AM +0800, xiongxin wrote:

...

> > > > Also note all the tags you've already got must be preserved on the
> > > > next patch revisions. One more time:
> > > 
> > > I recommend using `b4` for that.
> > > 
> > > it harvests tags from the email thread, so no need to care about
> > > possible misses.
> > 
> > AFAICS it doesn't pick up the tags from the previous revisions at
> > least if the new patch wasn't submitted as in-reply-to the prev one.
> 
> ???

Ah, I see what you mean now. Yes, the flow I suggested has to always be
followed, gaps are not permitted.

-- 
With Best Regards,
Andy Shevchenko




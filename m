Return-Path: <linux-kernel+bounces-5409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86328818A5E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3436128F958
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F5B1C284;
	Tue, 19 Dec 2023 14:44:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ECD1B29A;
	Tue, 19 Dec 2023 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="375157592"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="375157592"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 06:44:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="775998710"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="775998710"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 06:44:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1rFbKY-00000007Hta-0ZWB;
	Tue, 19 Dec 2023 16:44:22 +0200
Date: Tue, 19 Dec 2023 16:44:21 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: xiongxin <xiongxin@kylinos.cn>, hoan@os.amperecomputing.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v3] gpio: dwapb: mask/unmask IRQ when disable/enale it
Message-ID: <ZYGsRXJUcrLKEzUn@smile.fi.intel.com>
References: <20231219013751.20386-1-xiongxin@kylinos.cn>
 <7zdg5ujizncarxvdyahnusojiq44rzxx2zybqj4kzsonzr27gq@fm5wj7npqsk3>
 <CAHp75VceVAZYTNsJaYYRN+EMExFZSQARsJowd-CvDLRtuOPKSg@mail.gmail.com>
 <euhbczna4hk5sacb23i2xwqh2jewlek7cfceprfslpsiijhwk3@3d6vtybmgag5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <euhbczna4hk5sacb23i2xwqh2jewlek7cfceprfslpsiijhwk3@3d6vtybmgag5>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 19, 2023 at 05:31:38PM +0300, Serge Semin wrote:
> On Tue, Dec 19, 2023 at 04:17:16PM +0200, Andy Shevchenko wrote:
> > On Tue, Dec 19, 2023 at 11:14 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> > > On Tue, Dec 19, 2023 at 09:37:51AM +0800, xiongxin wrote:
> > 
> > ...
> > 
> > > Also note all the tags you've already got must be preserved on the
> > > next patch revisions. One more time:
> > 
> > > Acked-by: Serge Semin <fancer.lancer@gmail.com>
> > 
> > I recommend using `b4` for that.
> > 
> > it harvests tags from the email thread, so no need to care about
> > possible misses.
> 
> AFAICS it doesn't pick up the tags from the previous revisions at
> least if the new patch wasn't submitted as in-reply-to the prev one.

???

> Just tested it on v3. b4 found my new ab-tag only and no yours rb-tag.
> Did you mean something other than I thought you did?

Grabbing thread from lore.kernel.org/all/mdogxxro42ymeaykrgqpld2kqbppopbywcm76osskuf3df72sl@5jalt26vzcv4/t.mbox.gz
Analyzing 4 messages in the thread
Checking attestation on all messages, may take a moment...
---
  [PATCH v2] gpio: dwapb: mask/unmask IRQ when disable/enale it
    + Reviewed-by: Andy Shevchenko <andy@kernel.org>
    + Acked-by: Serge Semin <fancer.lancer@gmail.com> (✓ DKIM/gmail.com)

The flow you need to follow is that

	git checkout $BASE # gpio/for-next in this case
	b4 am ... # as above
	git am ...
	...address comments...
	git commit -a -s --amend
	git format-patch ... -1 HEAD~0
	git send-email ...

-- 
With Best Regards,
Andy Shevchenko




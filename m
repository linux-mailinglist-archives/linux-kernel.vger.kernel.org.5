Return-Path: <linux-kernel+bounces-19225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16351826A00
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CD51B21EAD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53168D310;
	Mon,  8 Jan 2024 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KFmQqo3U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F3B11707;
	Mon,  8 Jan 2024 08:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704704384; x=1736240384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UD2WeMpSp+j8qkJF1AjMx4z2wT9q6XOgcAc12cmsxlA=;
  b=KFmQqo3UaFKU/fX0cImq56tIS6+8JYxaV5gvw59xQPKDBTVZkRqhEy7C
   SkSZnz7GDwuKa0iKLquku50arfZi/TWxceA59LcHARBmGSsLSnEvH7m2+
   E8xZbi/artwnum8U2C4dG8SGELQEapMzKFhNd2Ou6uYsvHM/iVI1hyyzl
   TU4b9DQdfFrznTvZu++JHhPUXTz97pceLg+hWXt0xdSnNn/O6qBWjTVcR
   iZs46QW0i/RR7XXD4LI57Kd/Ho/YnJgf7uJjidoZwiKDYDV3W49/80tRE
   gPVxwNkUzyWv4fU8BCh8u/BJ3UTB0O0ZxexJkah/+rmg+yVYLe8h/mKow
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="16427111"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="16427111"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 00:59:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="871816985"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="871816985"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 00:59:40 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 7623E11F8DE;
	Mon,  8 Jan 2024 10:59:37 +0200 (EET)
Date: Mon, 8 Jan 2024 08:59:37 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Hidenori Kobayashi <hidenorik@chromium.org>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: staging: ipu3-imgu: Set fields before
 media_entity_pads_init()
Message-ID: <ZZu5ech4h2SSyZ1D@kekkonen.localdomain>
References: <20231228093926.748001-1-hidenorik@chromium.org>
 <27f1c487-78cc-4e56-ba79-1434aba131fd@moroto.mountain>
 <20240105021856.wpzmwtyzxzqfznrp@google.com>
 <a6f9ff72-421a-42c6-b24a-3dbf5a55e631@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6f9ff72-421a-42c6-b24a-3dbf5a55e631@moroto.mountain>

Hi Dan, Hidenori,

On Fri, Jan 05, 2024 at 10:34:20AM +0300, Dan Carpenter wrote:
> On Fri, Jan 05, 2024 at 11:19:23AM +0900, Hidenori Kobayashi wrote:
> > On Thu, Jan 04, 2024 at 01:04:27PM +0300, Dan Carpenter wrote:
> > > On Thu, Dec 28, 2023 at 06:39:25PM +0900, Hidenori Kobayashi wrote:
> > > > The pad's flags is checked in media_entity_pads_init(), so it has to be
> > > > initialized beforehand. The ops initialization is also moved together
> > > > for readability.
> > > > 
> > > 
> > > How does this bug look like to a user?  What is the Fixes tag?  Does
> > > this need to be backported to stable?
> > 
> > I suppose I should have included those in the commit message.
> > 
> > 1) To a user, the imgu driver fails to probe with the following message:
> > 
> > [   14.596315] ipu3-imgu 0000:00:05.0: failed initialize subdev media entity (-22)
> > [   14.596322] ipu3-imgu 0000:00:05.0: failed to register subdev0 ret (-22)
> > [   14.596327] ipu3-imgu 0000:00:05.0: failed to register pipes (-22)
> > [   14.596331] ipu3-imgu 0000:00:05.0: failed to create V4L2 devices (-22)
> > 
> 
> Yeah.  This is super useful information.
> 
> > 2) Re Fixes tag, I see that the first commit of imgu driver already
> > initializes the flags after media_entity_pads_init(). The documentation
> > of this API ( "Drivers must set the direction of every pad ... before
> > calling media_entity_pads_init") predates the first commit. So, I guess
> > 
> > Fixes: a0ca1627b450 ("media: staging/intel-ipu3: Add v4l2 driver based on media framework")
> > 
> > 3) Re stable, I was not sure. The probe failure only appears after a
> > check was added by Commit deb866f9e3a45ae058b21765feeffae6aea6a193. That
> > check is not in linux-6.6.y branch. So I was not sure if this counts as
> > "a real bug that bothers people" mentioned in the document.
> 
> Hm...  I don't know either.  Wait for a day and see if anyone else has
> an opinion then listen to your gut and resend with whatever your gut
> says?

The suggested commit message seems good to me, the Fixes: line is
important. Thanks for digging this up! The patch should go to v6.7, too, so
please add Cc: stable (for v6.7).

-- 
Kind regards,

Sakari Ailus


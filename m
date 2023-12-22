Return-Path: <linux-kernel+bounces-9868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0280F81CC90
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5AD1F232ED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1C2241F8;
	Fri, 22 Dec 2023 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rlsmdvdo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53707241E0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=m8EClbiaoJC+n72HF4xWtGZXGPRPjizL4VMPtrfABkE=; b=RlsmdvdoR2uYN4BcALz2ieUOqm
	lzrUTbLy4cUpw4/c2K5LHEH6hvGtdgBEJc1kgnIBdo37ghgkP6U+L2k3CcGSK3R/30/4zyka7wzKM
	yKiJck4cRvqmnDZb7kdrHCUomjeUahnwWOveZ/D2Y0G55YALhY0WQbV1Feu+XaVGNQlxCMynSOXqG
	2USSpjORbSLXpsogprOuksz1TUQ1yjGoyd6bAW54DJdgv/BAm1+x7ucinApFPqq4x4AQHA95fXj62
	/yGV8XeTVnYj9lc1zoRXLupaMXuhFu4iwFP0KWyBo2JIMVLks3N2lv/9JhomYDIS2Oc7e/S5w0sbF
	KmxBCvmw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rGi7X-008RO1-S3; Fri, 22 Dec 2023 16:11:31 +0000
Date: Fri, 22 Dec 2023 16:11:31 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	John Garry <john.garry@huawei.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Zhichang Yuan <yuanzhichang@hisilicon.com>
Subject: Re: [resend, PATCH v1 1/1] logic_pio: Use RESOURCE_SIZE_MAX
 definition
Message-ID: <ZYW1M0hrNEm1zB6t@casper.infradead.org>
References: <20231016132611.1201402-1-andriy.shevchenko@linux.intel.com>
 <ZVuVDBW3grRB-Cto@smile.fi.intel.com>
 <ZYWlJCFhr53eU4jX@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYWlJCFhr53eU4jX@smile.fi.intel.com>

On Fri, Dec 22, 2023 at 05:03:00PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 20, 2023 at 07:19:08PM +0200, Andy Shevchenko wrote:
> > On Mon, Oct 16, 2023 at 04:26:11PM +0300, Andy Shevchenko wrote:
> > > Use a predefined limit instead of hardcoding it.
> > 
> > Any comments on this?
> 
> It's month passed, can this be applied if no further comments?

Maybe you should cc someone who knows about and cares about the
code instead of someone who did a driveby patch recently?
get_maintainer.pl is not a replacement for using your brain.


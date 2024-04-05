Return-Path: <linux-kernel+bounces-133416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99F689A36B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20734283724
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B866171667;
	Fri,  5 Apr 2024 17:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DfVrLC7X"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760FE6AB6;
	Fri,  5 Apr 2024 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712337556; cv=none; b=ggPl61ihm3rtMCm+Qnud/Ke+Ezq+6sehnJ7Pf4hw/tpEIOklagynHTsmNKij/4RQdAC/SEqSUXlNkVQ0i5Uakf5LF9XNbOtHaXZHVFqjq57vf+c7UAvUc1RGe01g1Swjk2lplfvK83Qh8x2ePDTtbHvkRVkms6KSflwm4jA7+SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712337556; c=relaxed/simple;
	bh=QRMeVHlXFsGyPck1GAXCXiTs+tmUSKXsHHrqCVNReVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nMgXpVyMZdTJ7VJBtVx2RFDet2MttT0oh7epnw4RVxBPyCVNAJZpro3ZUQQ9o/yjsrzYELFmUIeeDZNLLqksXQM/SN8eZo9RQ5dg+Vk4ZHTeRoWgaWTQBT3CShtsMs/IeC3OLZs32cY7dBFv6FZ2GzwE0n3iuUVgZMGEjxi8M04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DfVrLC7X; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=7n33e9TOqfHdPSOxwwAXF/+bIY86Q75KlStQt98tMCM=; b=DfVrLC7XkfKVXbfbHth4Q1ve5o
	YHsGv6kKKy1Cq3igmNMC3xwNRsFOWrbnS2OF7XKrNOpnLgknEGab+XA7+vLtWVInSlftOi1r8+C2W
	yP41B4MqLaG/HJ4ZfmO6vtLB6KCN9KvqE0SmlYcBEmf2tnjnpDVIxcI/hRAxOdqCttZc/8jy6DCv7
	bYRmOuc5eRI21661mlnb/UWYf+AM0yFTR3lkvLr2vcBG2PWvdruoF1Z/BcWPTf3OTRYLZyky9y0Zy
	B9+Ht8InRco1L4cMbCmtCcrMmITwZKNVpQPZ+pz09RQdrG+Gk4Mjjn37t3teX9HEDVc/s0I4yVJg5
	gdivTJ6g==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsnDZ-00000008CaJ-29Yd;
	Fri, 05 Apr 2024 17:19:09 +0000
Message-ID: <1536720f-7fba-4c47-8708-bfa80b701e7a@infradead.org>
Date: Fri, 5 Apr 2024 10:19:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Add MO(mod objs) variable to process ext modules with
 subdirs
To: Valerii Chernous <vchernou@cisco.com>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>
Cc: xe-linux-external@cisco.com, Jonathan Corbet <corbet@lwn.net>,
 linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240405165610.1537698-1-vchernou@cisco.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240405165610.1537698-1-vchernou@cisco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Valerii,

On 4/5/24 9:56 AM, Valerii Chernous wrote:
> The change allow to build external modules with nested makefiles.
> With current unofficial way(using "src" variable) it is possible to build
> external(out of tree) kernel module with separate source and build
> artifacts dirs but with nested makefiles it doesn't work properly.
> Build system trap to recursion inside makefiles, artifacts output dir
> path grow with each iteration until exceed max path len and build failed.
> Providing "MO" variable and using "override" directive with declaring
> "src" variable solves the problem
> Usage example:
> make -C KERNEL_SOURCE_TREE MO=BUILD_OUT_DIR M=EXT_MOD_SRC_DIR modules
> 
> Cc: xe-linux-external@cisco.com
> Cc: Valerii Chernous <vchernou@cisco.com>
> Signed-off-by: Valerii Chernous <vchernou@cisco.com>
> ---
>  Documentation/kbuild/kbuild.rst  | 14 +++++++++++++-
>  Documentation/kbuild/modules.rst | 16 +++++++++++++++-
>  Makefile                         | 17 +++++++++++++++++
>  scripts/Makefile.build           |  7 +++++++
>  4 files changed, 52 insertions(+), 2 deletions(-)
> 

I can read it now. There are still a few small things that I would
change, but they aren't a big deal.

I'll leave it for Masahiro or others to comment on.

Thanks.
-- 
#Randy


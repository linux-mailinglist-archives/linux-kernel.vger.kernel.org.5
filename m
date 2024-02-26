Return-Path: <linux-kernel+bounces-81316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2782D86742B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD77FB2665B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7325A7AC;
	Mon, 26 Feb 2024 11:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VqGhCwMT"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE155A7B3
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948672; cv=none; b=TVXpzndNPtckRPigGxIA7oArlozUqAJRz9sXthOB3V/IfrlBa8T1gocWwequku3gaVBye+nhjShxuXtC6Gn5OifyzHl0lvva29xmer9mz+mtoftwP4qycqWOzSaYggFf+5Xm+XSwsolbonHndEwAxVkAXIpEziuJHzDDJwkVQF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948672; c=relaxed/simple;
	bh=REpuWPsYJOuAj2YEzPdny5TFtQbhyT34ijcZuqcWDi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrr3am1hfOktlHfOFRqFc65tCghQzi9xDpt4fnXF5NslS1642V1t8S2s4TGzYJCFAO6BrDxJ9FYG4Pq+tH1IMBKlGyz3qhegokLujnA7jfqLOuyU2lH2B/foxr+bfCaBTyWFxIuZ8nURbrouZJyw6fnc44w3dk36R2ZbCyblgTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VqGhCwMT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=D0Cpl1dRF49bF8jEtTlvGAeloBKS8mPZTSqjERNiUkI=; b=VqGhCwMTOy09jD9FqIdHEICFAP
	Y5PagkXK2hMIYd6SnSIH/U9aQlTxUxJxMU2d3egO83lxj7sepDCuA00c/fKvSA7e2jMblT+8dh9An
	F9m/7M0itqVriXErD9Thk1g9dweTUBRT9Btt+aRiUF3fvPTaxBleOV5pcf74y9hL4ZmokLDY0eWJO
	+0If7KDRSnbayGQ2iCQ2q2D8v/WWVTwjy4pobsdLVYIdyXIMUz+SyRX5F0V+OFmJ8yS8R4OJdnTOV
	ZFL7yC8q3lo40V7SVun0GHEUAPEdnYdmlvV8TrDT/pyazaE9r7zf/r17/H6357AEIP0YjjCtKg7yv
	gSBKnS1A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37602)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1reZby-0003Cq-0H;
	Mon, 26 Feb 2024 11:57:34 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1reZbt-0006PH-St; Mon, 26 Feb 2024 11:57:29 +0000
Date: Mon, 26 Feb 2024 11:57:29 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: 20240223063608.2605736-1-liuyongqiang13@huawei.com
Cc: liuyongqiang13@huawei.com, arnd@arndb.de, keescook@chromium.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	m.szyprowski@samsung.com, rppt@linux.ibm.com, sunnanyong@huawei.com,
	wangkefeng.wang@huawei.com, willy@infradead.org,
	yanaijie@huawei.com, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH v2] arm: flush: check if the folio is reserved for
 no-mapping addresses
Message-ID: <Zdx8qZLyjh4pO+vx@shell.armlinux.org.uk>
References: <20240223063608.2605736-1-liuyongqiang13@huawei.com>
 <788c8a64-09ed-96fd-9878-ed126b09c683@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <788c8a64-09ed-96fd-9878-ed126b09c683@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 26, 2024 at 02:38:58PM +0800, Jinjiang Tu wrote:
> Since some abuses of pfn_valid() have been reported, I check all the use of
> pfn_valid(), and find some suspicious cases.

I do get really tired of kernel interfaces migrating to become something
different from what they were when code was originally written, and then
having users of that interface labelled as "suspicious" or an "abuse".

I don't follow MM stuff, so I can't comment on the rights or wrongs of
this, but what I understood was that pfn_valid() is there to check that
for a given PFN, pfn_to_page() would return a valid pointer to a struct
page. Given that we only have struct page's for memory which the kernel
is managing, this seems entirely correct.

There may be other RAM in the system which is being managed via
different mechanisms, and because those won't have a struct page
associated with them, pfn_valid() should be returning false (which
means memory carved out for e.g. other processors etc) won't be mapped
cacheable.

Or at least that's how things used to be - because 32-bit Arm's
pfn_valid() was implemented by checking memblock for memory, and
stolen memory _was_ removed from memblock.memory (see
arm_memblock_steal) or quite simply these areas were not passed to
the kernel as memory.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


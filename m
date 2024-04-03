Return-Path: <linux-kernel+bounces-130176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098B58974F2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A89A1C27702
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB46014F11C;
	Wed,  3 Apr 2024 16:13:27 +0000 (UTC)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877973D96B;
	Wed,  3 Apr 2024 16:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160807; cv=none; b=MwLJqFrPMp6SG2Bcl1ouO+sg1VhBonULxIlhFxR+JbSHCPrBb+QTONKbXnXANPFNeNhi5tAmQT+sKsPP19MsdqGmShkBEn5a/zvFEZwObN3h+na3bb0+8CLQYTCMyjI8ZpTYFoq5L3yYIfazztoNvssV7eoRAZoZKb5sEA6AUDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160807; c=relaxed/simple;
	bh=U2g+9sCqmUZQJJQi6TnXCI2sXHoZ1gVewHiZfEHydQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKHgPCcBgx3XT40q0HO60ZZXHBl+VpONUhlCeMAA33LtFn0D7F3NpB+AePZGt6Ko4PCmDagmdd0cGCdiadTeI16CzvWjfCt/QlQT7XsDwanV5Xh2OtIKu7aSZH3GOnS3CC0trn1sW5Lc5RigIqnCvQ00I2Gfq91sRJybX6UXnl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz12t1712160713tbgjzf
X-QQ-Originating-IP: +cdGCqhc9XLXPV1xZHXG+yJaAHZ4lfeDteMTgsseDHM=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 04 Apr 2024 00:11:52 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: DoD8xN2rKow7K9mxo9zdVlLyDzzKK6iu8xNUc/iF96AuScOXF4+/sBdF/a9hz
	IhLjBwMhjiYP2CQE+gZvlO3r0le/JduQCVeA1LslTnrTZ3mxRqr6Hrblcl5Nl6sP81I35UI
	2mr6A9kWQR2TzF4iFX47dR1pUfybV23GVonLPgJYQZC6WATR0qBO7vF2rz15Hp3aEwV6RVl
	Rw4HExZVMEy012Z/EoWKRl4JXk/LJkvTuHW/BCGOHnhAqPyQqvwUZ1iEAS5w+26tkyYujg0
	AnR/BfrBs9jlbtHtsV4OH/rL46183JtGluUDwM6yAmTnMyh8VVDNgMJr38rD06wqZJrzHcv
	Wot9SLoaSTD6ABtuqrtpW+oRTNnBBdEVf/5H3AaskpwLD7/1r9x/ffLlSY2SA==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 13472035299235303404
Date: Thu, 4 Apr 2024 00:11:51 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: Mark Rutland <mark.rutland@arm.com>
Cc: will@kernel.org, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	yangyicong@hisilicon.com, jonathan.cameron@huawei.com,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 00/10] perf: Avoid placing cpumask var on stack
Message-ID: <5BCB924A8FA6320A+Zg1/xw9C493rZ868@centos8>
References: <20240403125109.2054881-1-dawei.li@shingroup.cn>
 <Zg1qgxqrEi3sX3CA@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg1qgxqrEi3sX3CA@FVFF77S0Q05N>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi Mark,

On Wed, Apr 03, 2024 at 03:41:07PM +0100, Mark Rutland wrote:
> On Wed, Apr 03, 2024 at 08:50:59PM +0800, Dawei Li wrote:
> > Hi all,
> 
> Hi,
> 
> > This is v2 of [1] and [2] which basically eliminate cpumask var allocation
> > on stack for perf subsystem.
> > 
> > Change since v1:
> > - Change from dynamic allocation to a temporary var free helper:
> >   cpumask_any_and_but().	[Mark]
> > 
> > - Some minor coding style improvements, reverse chrismas tree e.g.
> > 
> > - For cpumask_any_and_but() itself:
> >   - Moved to cpumask.h, just like other helpers.
> >   - Return value converted to unsigned int.
> >   - Remove EXPORT_SYMBOL, for obvious reason.
> 
> Thanks for this!
> 
> The logic all looks good; if you can spin a v3 with the updated commit messages
> I reckon we can queue this up shortly.

Thanks for review.

v3 respinned:
https://lore.kernel.org/lkml/20240403155950.2068109-1-dawei.li@shingroup.cn/

If it's going through perf tree, do we need Acked-by from bitmap
maintainers for patch[1]?

Thanks,

    Dawei

> 
> Mark.
> 
> > 
> > [1]:
> > https://lore.kernel.org/lkml/20240402105610.1695644-1-dawei.li@shingroup.cn/
> > 
> > [2]:
> > https://lore.kernel.org/lkml/1486381132-5610-1-git-send-email-mark.rutland@arm.com/
> > 
> > Dawei Li (9):
> >   perf/alibaba_uncore_drw: Avoid placing cpumask var on stack
> >   perf/arm-cmn: Avoid placing cpumask var on stack
> >   perf/arm_cspmu: Avoid placing cpumask var on stack
> >   perf/arm_dsu: Avoid placing cpumask var on stack
> >   perf/dwc_pcie: Avoid placing cpumask var on stack
> >   perf/hisi_pcie: Avoid placing cpumask var on stack
> >   perf/hisi_uncore: Avoid placing cpumask var on stack
> >   perf/qcom_l2: Avoid placing cpumask var on stack
> >   perf/thunderx2: Avoid placing cpumask var on stack
> > 
> > Mark Rutland (1):
> >   cpumask: add cpumask_any_and_but()
> > 
> >  drivers/perf/alibaba_uncore_drw_pmu.c    | 10 +++-------
> >  drivers/perf/arm-cmn.c                   | 10 +++++-----
> >  drivers/perf/arm_cspmu/arm_cspmu.c       |  8 +++-----
> >  drivers/perf/arm_dsu_pmu.c               | 19 ++++++-------------
> >  drivers/perf/dwc_pcie_pmu.c              | 10 ++++------
> >  drivers/perf/hisilicon/hisi_pcie_pmu.c   |  9 ++++-----
> >  drivers/perf/hisilicon/hisi_uncore_pmu.c |  6 ++----
> >  drivers/perf/qcom_l2_pmu.c               |  8 +++-----
> >  drivers/perf/thunderx2_pmu.c             | 10 +++-------
> >  include/linux/cpumask.h                  | 23 +++++++++++++++++++++++
> >  10 files changed, 56 insertions(+), 57 deletions(-)
> > 
> > Thanks,
> > 
> >     Dawei
> > 
> > -- 
> > 2.27.0
> > 
> 


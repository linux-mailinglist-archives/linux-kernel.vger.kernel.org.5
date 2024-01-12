Return-Path: <linux-kernel+bounces-24707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E613A82C11C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984C61F259C3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A39E6D1BA;
	Fri, 12 Jan 2024 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3QPwCi8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859AC6A038;
	Fri, 12 Jan 2024 13:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D5AC433F1;
	Fri, 12 Jan 2024 13:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705067418;
	bh=2GBsmlDMuRrcjc2Hma/6Rsppr8bfpOi1zXgsvajbU7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b3QPwCi8lSUlKn9lVR7v8i0+OSGblLUhqlsqZKv6AReHbWezDzAbl5Ek0HuC1CMbH
	 hn/K732i14ODy4j2Gz5t8iq1wiVIrk3MHXTxnaaTe4Io23MZhxn1BkFS0xUqAwdZHg
	 Vz6QIeDaCfTzD9YbJgKaCHyNxhIMTmMuWDE+DJ3FgKiZPEPzEeUOKGALfd1OgO60AN
	 cFFoMfQYsZFxQAZCdn/15HZoag1q5sVA2/btsTQxSYdhbfTLInbvYY8Xc7ABrVUw9/
	 zwYQM6+8NRSDNSlwnhPXE+pdEGVIQVKm32r90zeT7MyJ/h93VrME76gBc61jsp553F
	 LDNABLAzw/HEg==
Date: Fri, 12 Jan 2024 13:50:09 +0000
From: Will Deacon <will@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Raag Jadav <raag.jadav@intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Fabio Estevam <festevam@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Kevin Hilman <khilman@baylibre.com>, Andy Gross <agross@kernel.org>,
	NXP Linux Team <linux-imx@nxp.com>, linux-arm-msm@vger.kernel.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Frank Li <Frank.li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jiucheng Xu <jiucheng.xu@amlogic.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 00/18] perf: Convert to platform remove callback
 returning void
Message-ID: <20240112135009.GA16771@willie-the-truck>
References: <cover.1702648124.git.u.kleine-koenig@pengutronix.de>
 <vlnl6og3bts5hcdjw5h7c4km7zolzuf6h7cwyfymjzan3uqjwy@rsra3lqdhou7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <vlnl6og3bts5hcdjw5h7c4km7zolzuf6h7cwyfymjzan3uqjwy@rsra3lqdhou7>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Uwe,

On Wed, Jan 10, 2024 at 09:56:26AM +0100, Uwe Kleine-König wrote:
> On Fri, Dec 15, 2023 at 02:59:00PM +0100, Uwe Kleine-König wrote:
> > this series converts all drivers below drivers/perf to use
> > .remove_new(). See commit 5c5a7680e67b ("platform: Provide a remove
> > callback that returns no value") for an extended explanation and the
> > eventual goal. The TL;DR; is to make it harder for driver authors to
> > leak resources without noticing.
> > 
> > I based the patches on today's next, I had to revert commits 
> > 3115ee021bfb ("arm64: perf: Include threshold control fields in
> > PMEVTYPER mask") and 816c26754447 ("arm64: perf: Add support for event
> > counting threshold") to compile test on ARCH=arm (this is a problem in
> > next, not in my patch series).
> > 
> > This is merge window material. All patches are pairwise independent of
> > each other so they can be applied individually. Still it would be great
> > to let them go in all together.
> 
> I wonder if this series is still on someone's radar. It didn't appear in
> next up to now, so I guess it's too late for 6.8-rc1?!

This came in during the holiday period so, by the time I saw it, it was
too late to land for this merge window. I can pick it up for 6.9 in a few
weeks, though. I usually start queueing stuff at -rc3.

Will


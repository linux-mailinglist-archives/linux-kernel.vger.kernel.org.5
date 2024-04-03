Return-Path: <linux-kernel+bounces-129040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0E48963A3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7EA3284B14
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 04:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796D645976;
	Wed,  3 Apr 2024 04:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Cn68qSYi"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338BB2AE8E;
	Wed,  3 Apr 2024 04:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712119546; cv=none; b=jkXXzxfJT1a2W1u43e0mIPqq5OXaDbcb7iAlkdwtp7dCGNU46TDBogm4ch4bRT43+FeRLx/UGoTo4NhX6F3uPEnpukCNvWRQR/ufK65EYFD0PuNcfIhYTPMDSdRioPf4+/FORWge4eAqV8S5HDl7WqXonqoJhkilnmTVxpHAAcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712119546; c=relaxed/simple;
	bh=RKRjGazQgi9/wy1ZAhmHmX3W2MvlUVydC1Fm+Jjp4lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBsjXgydKw4s6rN5DLYGBYve5cED4UoDJbhHCmeFYNM0hfIjA8c3RnM24tIx3N7KkAvSqna6vt52hfdutFJK7vZtDvG/d1ITnzWzAI1oVFchPB3MlmYdH+5Uby0tMuE+PSWRwtIicxdcm5YB44tmibqOPxFGAYW1wfNMBJvUsTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Cn68qSYi; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=uqX62Bf+JcrmBQv01/Vx3mbSrOugBLWbo5yWq5zhEF0=;
	b=Cn68qSYiu/cNf66cDzMKChseMZEtIq+6n/0ljmod+U1HDeD/QZo0TYcSi/xUvT
	/GkgzXYtXAzlJumWi1KSd5uQXdkTO1ibihOj4bp+JXJQmZR12YkuV41qb/2fnlGU
	At/deTB46fkinM5OX5MH6DDalYzfmNzY2muIVT/BQ/wwY=
Received: from dragon (unknown [223.68.79.243])
	by smtp2 (Coremail) with SMTP id C1UQrACH7xjG3gxmxeC1Ag--.47054S3;
	Wed, 03 Apr 2024 12:44:55 +0800 (CST)
Date: Wed, 3 Apr 2024 12:44:54 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.li@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	Philippe Schenker <philippe.schenker@toradex.com>,
	Max Krummenacher <max.krummenacher@toradex.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Joakim Zhang <qiangqing.zhang@nxp.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/7] arm64: dts: imx8-ss-lsio: fix pwm lpcg indices
Message-ID: <ZgzexmiPVXJjEFRe@dragon>
References: <20240401-dts_fix-v1-0-8c51ce52d411@nxp.com>
 <20240401-dts_fix-v1-1-8c51ce52d411@nxp.com>
 <CAOMZO5AJrQ5jyV4A-tvX93-R0_nEWpEO9YY3f5DpeXaAFO4cSA@mail.gmail.com>
 <ZgwfnZJDRYmYy7Qt@lizhi-Precision-Tower-5810>
 <ZgyzxmuMIK87C2nW@dragon>
 <ZgzIjziArPh8wnHA@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZgzIjziArPh8wnHA@lizhi-Precision-Tower-5810>
X-CM-TRANSID:C1UQrACH7xjG3gxmxeC1Ag--.47054S3
X-Coremail-Antispam: 1Uf129KBjvdXoWruF18tw45AF1xAw4kJF1DKFg_yoWktFbEga
	1kZrs2yr1Du3ZrJan5Ar4rJ3yDJa4qkr15Xr95Wr17XasxJ34UJF1UKry8ZrW7GFZxtrn8
	JFnxJFWYq3ySvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0CJmUUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBR+1ZVsVCbh9qgABsj

On Tue, Apr 02, 2024 at 11:10:07PM -0400, Frank Li wrote:
> On Wed, Apr 03, 2024 at 09:41:26AM +0800, Shawn Guo wrote:
> > On Tue, Apr 02, 2024 at 11:09:17AM -0400, Frank Li wrote:
> > > On Mon, Apr 01, 2024 at 08:04:56PM -0300, Fabio Estevam wrote:
> > > > On Mon, Apr 1, 2024 at 7:25 PM Frank Li <Frank.Li@nxp.com> wrote:
> > > > >
> > > > > lpcg's arg0 should use clock indices instead of index.
> > > > >
> > > > > pwm0_lpcg: clock-controller@5d400000 {
> > > > >         ...                                                // Col1  Col2
> > > > >         clocks = <&clk IMX_SC_R_PWM_0 IMX_SC_PM_CLK_PER>,  // 0     0
> > > > >                  <&clk IMX_SC_R_PWM_0 IMX_SC_PM_CLK_PER>,  // 1     1
> > > > >                  <&clk IMX_SC_R_PWM_0 IMX_SC_PM_CLK_PER>,  // 2     4
> > > > >                  <&lsio_bus_clk>,                          // 3     5
> > > > >                  <&clk IMX_SC_R_PWM_0 IMX_SC_PM_CLK_PER>;  // 4     6
> > > > >         clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>,
> > > > >                         <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_5>,
> > > > >                         <IMX_LPCG_CLK_6>;
> > > > > };
> > > > >
> > > > > Col1: index, which exited dts try to get.
> > > > 
> > > > I cannot understand this sentence, sorry.
> > > 
> > > This base on downstream dts code.  Downstream code use index in 'Col1' to
> > > get clock.
> > 
> > So s/exited/existing you meant?
> 
> Yes, sorry for typo. 

I fixed the typo and applied the series, thanks!

Shawn



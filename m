Return-Path: <linux-kernel+bounces-128949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFC689622E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A021F2780C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDE51B27D;
	Wed,  3 Apr 2024 01:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="aD38luKq"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0631BC4B;
	Wed,  3 Apr 2024 01:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712108526; cv=none; b=k4UzvXG+P2McOa6C4FVuxmHZazS4gIXg3RDpCsYSIdjjeYveeR1bLH5FrICVI51zoY6bJt5j9aiRpDl1lDvMdl6gL14KF8DQQn1aNID2R0Yx7MZI1w11lSGypiMkPYCfh4bOe4hl/jNEXTm4hVFZ7jfW/7nIGpfrwdOlItrxI+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712108526; c=relaxed/simple;
	bh=apm/cyErWPKZfHanGyHQ8pZ64PmEZzN6lIff+v3a0bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRMiBitcENFTsw0HrIDZprclc4T64PuzkNrr4eOQJ6qeH6WeQNG9/QZ/+Xgejwd4ZjQgkjtuzVagvG8bXZDqynCrrI1WegtgjCg+qId2y3FJMlMKZCBPe3l5ptnYJLZxx+OuhfJBj38plYiK6cg9H9fsyJ7Y4kCikandgwCQUKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=aD38luKq; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Mbtxsma7yyIkq9ySu8dVUD5R+zMrmAtoSbh78F9Br7k=;
	b=aD38luKqCmv3cW5ZHyJcYv1DB+sQshRn7hTUuUAx1aDSBQiE5aaFBbK7h4JFP8
	+lRq5gOYBXXAH+LgVINRaXcPd/EGJy1wSrpgwG+Q7L6gQiPf71Bh2yEQXj8NpBm6
	qiDtZ0EdIJEnuFsIWbWOHwbbhorjt4dt0wiQDyRSy0rus=
Received: from dragon (unknown [223.68.79.243])
	by smtp2 (Coremail) with SMTP id C1UQrADXPhjGswxmoDmzAg--.46730S3;
	Wed, 03 Apr 2024 09:41:27 +0800 (CST)
Date: Wed, 3 Apr 2024 09:41:26 +0800
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
Message-ID: <ZgyzxmuMIK87C2nW@dragon>
References: <20240401-dts_fix-v1-0-8c51ce52d411@nxp.com>
 <20240401-dts_fix-v1-1-8c51ce52d411@nxp.com>
 <CAOMZO5AJrQ5jyV4A-tvX93-R0_nEWpEO9YY3f5DpeXaAFO4cSA@mail.gmail.com>
 <ZgwfnZJDRYmYy7Qt@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZgwfnZJDRYmYy7Qt@lizhi-Precision-Tower-5810>
X-CM-TRANSID:C1UQrADXPhjGswxmoDmzAg--.46730S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw4Duw18XrWfZF17CFW7urg_yoWfuFXEgw
	4kZFs3tr1Duwn3Jan5Ar4rJ3yDJa4q9r45Xr95Ww17Xas8W3yUGF1UWa48ZrW7GFZaqrn8
	JFnrJFWqq34SvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0CJmUUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiGAm1ZV6Nnqo1hQAAsW

On Tue, Apr 02, 2024 at 11:09:17AM -0400, Frank Li wrote:
> On Mon, Apr 01, 2024 at 08:04:56PM -0300, Fabio Estevam wrote:
> > On Mon, Apr 1, 2024 at 7:25 PM Frank Li <Frank.Li@nxp.com> wrote:
> > >
> > > lpcg's arg0 should use clock indices instead of index.
> > >
> > > pwm0_lpcg: clock-controller@5d400000 {
> > >         ...                                                // Col1  Col2
> > >         clocks = <&clk IMX_SC_R_PWM_0 IMX_SC_PM_CLK_PER>,  // 0     0
> > >                  <&clk IMX_SC_R_PWM_0 IMX_SC_PM_CLK_PER>,  // 1     1
> > >                  <&clk IMX_SC_R_PWM_0 IMX_SC_PM_CLK_PER>,  // 2     4
> > >                  <&lsio_bus_clk>,                          // 3     5
> > >                  <&clk IMX_SC_R_PWM_0 IMX_SC_PM_CLK_PER>;  // 4     6
> > >         clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>,
> > >                         <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_5>,
> > >                         <IMX_LPCG_CLK_6>;
> > > };
> > >
> > > Col1: index, which exited dts try to get.
> > 
> > I cannot understand this sentence, sorry.
> 
> This base on downstream dts code.  Downstream code use index in 'Col1' to
> get clock.

So s/exited/existing you meant?

Shawn



Return-Path: <linux-kernel+bounces-50593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4937C847B5B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F204C28CCD3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DE012C7FB;
	Fri,  2 Feb 2024 21:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbPykI0F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC2082C60;
	Fri,  2 Feb 2024 21:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706908022; cv=none; b=WV0sfvojY6MbjB0XSwBNT93aYa+ED1QWzsatsWoO6ffhk+eLwjVBGy4YI8tX4/KDS4adK+lr5bg4qTGD8YcjQyHOZ1Dx0C/SF0YSu0BNg1PYKWZ/+vKS6FbqmaAAfd5LGIk4flE72SDXtlib7hcL+piCNmz1QDn+Yyef8r/oE/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706908022; c=relaxed/simple;
	bh=pOT08KJNuS1sfLS3vZwggchfB5iy1EZEG3QY463HBfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRFD6l8jKHkR4mkBzLQY7xjtHVQWcTDSRSZwTlx3dm1yyxV8FmGPFO6drQhMElbgkiZEQuV9WZ4sNa4V5n114BkbYsPH49JedUk8TIgl1qRfZO8RjWqDAyGg9MAWj9tyEyltISdzmZFaCUavhOSuWmjcBsFsWdryTUjCoV9yYrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbPykI0F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB44C433F1;
	Fri,  2 Feb 2024 21:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706908022;
	bh=pOT08KJNuS1sfLS3vZwggchfB5iy1EZEG3QY463HBfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lbPykI0FhQTq9PNUjiMoVTYdWNs6UbKW/swId0j174aITvgl3tBPi8qYaffrMpRp8
	 2TWv85F6hmYtkqHK2DtRq2sDgzXXr8hokdNGKd7c2z4dcsN458XXRF/2mPb0gaRax4
	 bQsCGq3mnBO1Yq7TPCK5JDfQsjUKd7FDdSvX1kSZqjKLqy965ow9LIQymRYzSfw6nZ
	 nsjkt/rCCBbwHeCWDeLmAblaBCutOvOe+IO5clMXGIQ027Vm5stwXZ240h+hvqsXkd
	 0a7aMUYhskZjh2Jc9UFOFbtnjZdt3c3Id8O87s/sxBGpM2WJA3b0WRvUmnh29Xt9N3
	 PZUPfqyqORNzA==
Date: Fri, 2 Feb 2024 15:06:59 -0600
From: Rob Herring <robh@kernel.org>
To: Brandon Brnich <b-brnich@ti.com>
Cc: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Darren Etheridge <detheridge@ti.com>
Subject: Re: [PATCH v2] dt-bindings: media: Add sram-size Property for Wave5
Message-ID: <20240202210659.GA1390727-robh@kernel.org>
References: <20240201184238.2542695-1-b-brnich@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201184238.2542695-1-b-brnich@ti.com>

On Thu, Feb 01, 2024 at 12:42:38PM -0600, Brandon Brnich wrote:
> Wave521c has capability to use SRAM carveout to store reference data with
> purpose of reducing memory bandwidth. To properly use this pool, the driver
> expects to have an sram and sram-size node. Without sram-size node, driver
> will default value to zero, making sram node irrelevant.

The mmio-sram binding already defines how to carve up shared SRAM.

Also, sram-size here is property, not a node.

Rob


Return-Path: <linux-kernel+bounces-48959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 528CA8463CA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85D41F28AEE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7882945BF6;
	Thu,  1 Feb 2024 22:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hn4+2HDY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE0B4643B;
	Thu,  1 Feb 2024 22:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706827730; cv=none; b=EWW+cDNQniT0Jpmtf56KInfPPkoxlJ7w2XBCeOoI4w6mbzknvb0NH7aBsbElDDitWfjhA5yXyh3rO5WAxrkqPyPLTTDiwSXDQhVz0a9HI7d86G3k+RARndokAF+RQEsqXDF/ZtW9uRkL7p+COU0xO1OM1pUzf2JYz+DUh1N/8sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706827730; c=relaxed/simple;
	bh=e8x2BkkjxYMoP713pO7VA7If6AbOHEDo8GQsevRtfDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgXnA5Tv/KOwCjKGZCmYg9T8FHFGO+XxaAoC1uh4rNdJ4CLG+VJsVxw2DGpND1TqHoQ3zaxBJbbeaQY6i/DSc4wpP7ZF73zqHaw6HJ7Wt1PYIpFPBkyj7YfJmJF+ZKQE+3+oqmERDI3Xre64+AU51LphfHUXM2uo+IyEHs16T8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hn4+2HDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09752C433F1;
	Thu,  1 Feb 2024 22:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706827730;
	bh=e8x2BkkjxYMoP713pO7VA7If6AbOHEDo8GQsevRtfDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hn4+2HDY+u4MutWr8+gG2cnzJpisRMQFKWk+rzNs48SqxrZbbZ+CRY8MP+/HkmOob
	 CXi3dBwibYjzrJSuVfk0MZ6ZYjEBjZ+X7RaN9hwes6S189lkFfGj5wkEnSY02mCJbq
	 j3p1bPYLAWh7500uWUT/uNd8SzvAfkzOY/jq3J3zkO+6Mq+XJ/4k8jxgKamSTBuMWz
	 vFdXQ/6J8q15MQrnvFJVWZBRZoSM5AHAIxDv28GdOu4hTNPlBBF7X/hgYIZos4dwJ0
	 v6GlFScpfhAz8MDzUn4eGQi9mmy4YlZk7fdXQRCPUMhMXKvBtbZhRz7bTUVCOvMjMR
	 3253Y8EQHpPPQ==
Date: Thu, 1 Feb 2024 16:48:47 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Svyatoslav <clamor95@gmail.com>, Conor Dooley <conor@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kees Cook <keescook@chromium.org>,
	Maxim Schwalm <maxim.schwalm@gmail.com>, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v1 1/4] dt-bindings: vendor-prefixes: add LG Electronics,
 Inc. prefix
Message-ID: <20240201224847.GA1875713-robh@kernel.org>
References: <20240131105153.8070-1-clamor95@gmail.com>
 <20240131105153.8070-2-clamor95@gmail.com>
 <20240131-elderly-passover-341b89f65189@spud>
 <656FDD69-D7B1-4910-B848-108CB985AAAC@gmail.com>
 <20240131-tractor-roundish-f6f90b5bd640@spud>
 <BCBF1994-C5AE-4D2B-B645-C3C67BE19000@gmail.com>
 <e77ac513-3f8c-4979-b887-f6b9aff6963f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e77ac513-3f8c-4979-b887-f6b9aff6963f@linaro.org>

On Thu, Feb 01, 2024 at 09:48:28AM +0100, Krzysztof Kozlowski wrote:
> On 31/01/2024 17:06, Svyatoslav wrote:
> > 
> > 
> > 31 січня 2024 р. 18:02:31 GMT+02:00, Conor Dooley <conor@kernel.org> написав(-ла):
> >> On Wed, Jan 31, 2024 at 05:30:58PM +0200, Svyatoslav wrote:
> >>>
> >>>
> >>> 31 січня 2024 р. 17:28:49 GMT+02:00, Conor Dooley <conor@kernel.org> написав(-ла):
> >>>> On Wed, Jan 31, 2024 at 12:51:50PM +0200, Svyatoslav Ryhel wrote:
> >>>>> Add missing LG Electronics, Inc. prefix used by some older devices.
> >>>>
> >>>> Is it? You're only adding these devices now as far as I can see.
> >>>>
> >>>
> >>> Hammerhead (LG Nexus 5)
> >>
> >> I have absolutely no idea what this means. Please link me the in-tree
> >> devicetree of the user (or the patchset adding it).
> >>
> >> Thanks,
> >> Conor
> >>
> > 
> > Sure, here you go
> > <https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts?h=linux-6.4.y#n11>
> > 
> > So devices I have sent are not the first.
> 
> Please look for existing work doing the same...

Took me a minute to parse this.

I believe what Krzysztof means is look at the link he posted and follow 
the suggestion there. Fix the one case, lge,hammerhead, to use 'lg'.

Rob


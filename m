Return-Path: <linux-kernel+bounces-158412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB648B1F95
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC8B286838
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA43122625;
	Thu, 25 Apr 2024 10:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grUwHalg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96581CFA9;
	Thu, 25 Apr 2024 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714042057; cv=none; b=foVWXwpcNiV/MRd/CsG4nZS2xk+ukhboEIaWCEt1L9SyL/+QcJYunNYFE1Ccq2BxVRdKRDXTYc7fWOZ8b6zfpCCrlPIzRLGQqWUj7uM+Ci/mYSceI9d38HMeV/2X0Gjjq8K0zhHt0Kh2iMm2IuNwdXk4NQ1riBOFNxw+Oy6bpMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714042057; c=relaxed/simple;
	bh=l2oN0apwOiempgVQoJgZseQpsSAT0VXcChaYnxGf5No=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EdT8w1ZR3bwJ1uYnwnWnvYbWRWnqVsIufb0Tgn+DgWR8I2A6OGb7OwfqUeMgQCnGlcDgyxwqWlr/C+l1EdepmoKQ4IH0rYyHtKfhfXcfnsYBir1SvxGyGqGsmEsvE+u8TX/nYeDsaIr9vQE1aXNgU5AvBSqW2/Ug/+rPuoSbI5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grUwHalg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8685C2BBFC;
	Thu, 25 Apr 2024 10:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714042056;
	bh=l2oN0apwOiempgVQoJgZseQpsSAT0VXcChaYnxGf5No=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=grUwHalgTFeirub4RVOOgYoOFWiFJT7ZuWldcDOCNt/9OhA6Q9AISETZbg+78W3Nh
	 bqUz4vpDhUmJqN/rkNOAwc/4WmkDGQoD7Y9Bq1pqbGmrG3jqU+9N61epUzUSbslHoi
	 p4hln/h3yFHopxYsWvz0s2rpQ8py14u5d0aRXAzv+6FAxbmWVhqiobYAz/dy6pFlyB
	 smPcuITe3RCuIcxgRvzgv5N0Bj+JArZb2GhOgEYRS92kG+IEENBPEQ08jX/6FVWF+p
	 wJmWkVvBvrfrUaR0v34xA5/agrcXEPWTmiiulr+m1pI32Gt30TsmSHHBZ2mAXsvtBa
	 UyZVMyl2bdg5A==
Message-ID: <97b173c3-052f-498c-b0f9-58e60e9f29cf@kernel.org>
Date: Thu, 25 Apr 2024 12:47:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] HSI2, UFS & UFS phy support for Tensor GS101
To: Peter Griffin <peter.griffin@linaro.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
 kishon@kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
 bvanassche@acm.org, s.nawrocki@samsung.com, cw00.choi@samsung.com,
 jejb@linux.ibm.com, martin.petersen@oracle.com,
 James.Bottomley@hansenpartnership.com, ebiggers@kernel.org,
 linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, tudor.ambarus@linaro.org,
 andre.draszik@linaro.org, saravanak@google.com, willmcvicker@google.com
References: <20240423205006.1785138-1-peter.griffin@linaro.org>
 <1c6f5984-7f9f-47e3-98c3-3c3671512675@kernel.org>
 <CADrjBPq_0nUYRABKpskRF_dhHu+4K=duPVZX==0pr+cjSL_caQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CADrjBPq_0nUYRABKpskRF_dhHu+4K=duPVZX==0pr+cjSL_caQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/04/2024 12:31, Peter Griffin wrote:
> Hi Krzysztof,
> 
> On Thu, 25 Apr 2024 at 08:08, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 23/04/2024 22:49, Peter Griffin wrote:
>>> Hi James, Martin, Alim, Bart, Krzysztof, Vinod, all
>>>
>>> Firstly, many thanks to everyone who reviewed and tested v1.
>>>
>>> This series adds support for the High Speed Interface (HSI) 2 clock
>>> management unit, UFS controller and UFS phy calibration/tuning for GS101
>>> found in Pixel 6.
>>>
>>> With this series applied, UFS is now functional on gs101. The SKhynix
>>> HN8T05BZGKX015 can be enumerated, partitions mounted etc. This allows us to
>>> move away from the initramfs rootfs we have been using for development so far.
>>>
>>> Merge Strategy
>>> 1) UFS driver/bindings via UFS/SCSI tree (James / Martin / Alim)
>>> 2) GS101 DTS/DTSI should go via Krzysztofs Exynos SoC tree
>>> 3) Clock driver/bindings via Clock tree (Krzysztof / Stephen)
>>> 4) PHY driver/bindings via PHY tree (Vinod)
>>>
>>> The v2 series has been rebased on next-20240422, as such all the phy parts
>>> which were already queued by Vinod have been dropped. Two new phy patches
>>> are added to address review feedback received after the patches were queued.
>>>
>>> The series is broadly split into the following parts:
>>> 1) dt-bindings documentation updates
>>> 2) gs101/oriole dts & dtsi updates
>>> 3) Prepatory patches for ufs-exynos driver
>>> 4) GS101 ufs-exynos support
>>> 5) gs101 phy fixes
>>>
>>
>> I asked to split, otherwise please explain why PHY and UFS depends on
>> DTS and clk.
> 
> Seems I misunderstood your feedback. I thought you just want me to
> make clear who was merging what from the series via which tree. But
> you want separate series?
> 
> 1) ufs host dt bindings & driver
> 2) minor phy fixes series (most patches got applied already for phy)
> 
> What do you want for cmu_hsi2 clocks and dts/dtsi? The device tree
> depends on the clock bindings to compile

This is not specific to Samsung Soc, Qualcomm soc or any other arm-soc.
Independent patches for different subsystems should not be put together
in one patchset. You create false impression of dependencies, grow CC
list, cause issues when applying (I cannot just apply entire set with
one command, but need to run multiple commands (!!!), plus certain
subsystems will reject your patchset because they take everything or
nothing) and possible bisection issues (because patches which should be
tested independently, are put together so testing does not uncover
undocumented dependencies).

Almost never combine independent patches which are targeted to entirely
different subsystems. There are exceptions, but regular feature work is
not one of them.

Subsystem is everything in top level of drivers/ and drivers/soc/ (or
kind of arch/arm64/boot/dts/, but that tricky because
Tesla/Google/Exynos are one subsystem). Or whatever is there in
MAINTAINERS file.

I don't know, we keep repeating this over multiple times, so it could be
added to some docs, but people do not read docs...

1. Drivers and driver bindings go to subsystems.
2. DTS and board compatibles go to soc.
a. Any dependency on driver is a near-NAK.
b. Any dependency on headers must be clearly expressed, because headers
cannot be back-merged from subsystem tree to DTS tree.
c. Any usage or usage of bindings from other sets must be clearly
expressed (linked).
3. drivers/soc go to soc.

Things from list above targeting the same maintainer tree, can be
combined in one series, with dependencies expressed in patch changelogs
or cover letter.

Best regards,
Krzysztof



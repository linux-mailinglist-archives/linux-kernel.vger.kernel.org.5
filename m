Return-Path: <linux-kernel+bounces-164235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC3A8B7B32
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3892854C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40F214374A;
	Tue, 30 Apr 2024 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7hD6Zux"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2549E152799;
	Tue, 30 Apr 2024 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489797; cv=none; b=XINAyCCleothHE6rfYlIr0PnA+gNVlmBblxhLYR0FP2BJhCbmB+T6HESTUFLwz01/LiTSxQn2pQDH7D+rpDTHwOAq8R2s5SveFsmCnz1CorXvgAqCK/ubU8mlToCvoaj0P/1YhjhY+IJdUY3uX21fYK2i3T/FdAycd13VQYIuLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489797; c=relaxed/simple;
	bh=21NNPMBdF38yzR1UgW+l4G83qO/y+s6ncZ0pzt/V2rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kI+M6wEeKYXrQO9U5t2tcY1sYaUbaT59/eetuRB+DNNXGyoQ1WAUGAaQMlGlgXz95DphFP7MkxgwVV2KxhkmHQgoZiKHMoD2pZ7hGs9OAw9lgWU0iwY6kUwCrsGDDO2fcq5OK974D+2dE0q9OiuzcrU2XOZEny6Zj1RNDa7HM4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7hD6Zux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F306FC4AF1D;
	Tue, 30 Apr 2024 15:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714489796;
	bh=21NNPMBdF38yzR1UgW+l4G83qO/y+s6ncZ0pzt/V2rU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a7hD6ZuxY9/dNmI6Px0Te5atkU9V2hIHyI59zJ5m5wRRnL+/2lF+DIfw0GDp+WtpD
	 wmO67+OI9lZpuOI2z0KqA8EWs+rjE7sdEFtu1PYNf3WfwPba/dMYlFnCOG6L5QzSts
	 /Swhl70kuANqKMNfErsyiA45dG4q7BwP1z6kQyTGwXNx83VHNGo5kWKB2tziPpPwjN
	 9wBIGzthlMp8MOe0aJxy/rl1rX6s3PYem8Ks5tv8qcl2gi2dbkg3hd2E9aomUkxtAO
	 f8/+RcikzEtXoPguI+Eke8RcwNFRucFbuecZoUvNJGwRW0esbF14qDK2RXKnPmbTkY
	 F8xIrn+gYY0+w==
Date: Tue, 30 Apr 2024 16:09:50 +0100
From: Will Deacon <will@kernel.org>
To: Tanmay Jagdale <tanmay@marvell.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, nicolinc@nvidia.com,
	mshavit@google.com, baolu.lu@linux.intel.com,
	thunder.leizhen@huawei.com, set_pte_at@outlook.com,
	smostafa@google.com, sgoutham@marvell.com, gcherian@marvell.com,
	jcm@jonmasters.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 0/2] iommu/arm-smmu-v3: Add support for ECMDQ register
 mode
Message-ID: <20240430150950.GD14187@willie-the-truck>
References: <20240425144152.52352-1-tanmay@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425144152.52352-1-tanmay@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Apr 25, 2024 at 07:41:50AM -0700, Tanmay Jagdale wrote:
> Resending the patches by Zhen Lei <thunder.leizhen@huawei.com> that add
> support for SMMU ECMDQ feature.
> 
> Tested this feature on a Marvell SoC by implementing a smmu-test driver.
> This test driver spawns a thread per CPU and each thread keeps sending
> map, table-walk and unmap requests for a fixed duration.
> 
> Using this test driver, we compared ECMDQ vs SMMU with software batching
> support and saw ~5% improvement with ECMDQ. Performance numbers are
> mentioned below:
> 
>                    Total Requests  Average Requests  Difference
>                                       Per CPU         wrt ECMDQ
> -----------------------------------------------------------------
> ECMDQ                 239286381       2991079
> CMDQ Batch Size 1     228232187       2852902         -4.62%
> CMDQ Batch Size 32    233465784       2918322         -2.43%
> CMDQ Batch Size 64    231679588       2895994         -3.18%
> CMDQ Batch Size 128   233189030       2914862         -2.55%
> CMDQ Batch Size 256   230965773       2887072         -3.48%

These are pretty small improvements in a targetted micro-benchmark. Do
you have any real-world numbers showing that this is worthwhile? For
example, running something like netperf.

Will


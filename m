Return-Path: <linux-kernel+bounces-92328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFD9871E7E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E4021C23E37
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA3359B6D;
	Tue,  5 Mar 2024 12:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJaYYVJm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEFF56472;
	Tue,  5 Mar 2024 12:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640217; cv=none; b=lSuoWYGiLBXmYL9LX9DG4McIwBApt+T6/njMxw4EIbMqwk3UsJLxXdRrJn3CjHLUgq+X/ei7JJAcAEapUw6VBylhFLGKqyfVbyF9SAWm6ceyFks28OQ2DqQfg9ohvk0Ge8mmDxLneTK3L5uozHiQxCY89Uye9sp1zgIGd9cmeh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640217; c=relaxed/simple;
	bh=jfljaek+m3Ap9dl376hPV7PcXvPEZz52T/u690ABKQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TffidkYIPKHwVQvKeewtemYs+65C1BbBXNE/Z9Jw/jXnWKOIZgRzWNppSTfrWTq2a96RQcrWltbXfokH27rRMiOODKAJ9A5/4jEKWNaketllfNWdBK4BqOZNFciV8AB3NjQE0eFTaRdHBRrw3aEd2C59hQUBwzPKgULCPu42PiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJaYYVJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DE9C433F1;
	Tue,  5 Mar 2024 12:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709640216;
	bh=jfljaek+m3Ap9dl376hPV7PcXvPEZz52T/u690ABKQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LJaYYVJmd+BQI90hCE5IGOQx3mNuwtL19HHj8s9WHQtoNbUw76JdRHh2UAVm2CcnK
	 rOs0gM9oJ/6UblDDB7jvpCn+0CARwSZQDn92RceNcXPEPd6P0BHV2+gFdVPe/uGNe4
	 LO1R9f7+eCALo9vGr1El2dFgrJZ2D0sSRj+Jv3XRvCF/u7Sk5QYuKlWdDf+5ofKvz9
	 UCW8Kt2DUU1Lb/Y3KJwlRpGGx4LRebhRN15z/XRubQ2PJ/BsRSRZyboOr9rPIYNWuB
	 OVWrs9nsCLpQERhZTu81cGXZPhiVQSHP600vIxCUIHpS11vali3+uK8IsA2dfq2dj4
	 zJMk6tzbGPFZg==
Date: Tue, 5 Mar 2024 12:03:32 +0000
From: Will Deacon <will@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Junhao He <hejunhao3@huawei.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the arm-perf tree
Message-ID: <20240305120331.GA22097@willie-the-truck>
References: <20240305151035.22c6f7bd@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305151035.22c6f7bd@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Mar 05, 2024 at 03:10:35PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the arm-perf tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> Documentation/admin-guide/perf/hisi-pcie-pmu.rst:48: ERROR: Unexpected indentation.
> Documentation/admin-guide/perf/hisi-pcie-pmu.rst:49: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Introduced by commit
> 
>   89a032923d4b ("docs: perf: Update usage for target filter of hisi-pcie-pmu")

Thanks, Stephen. I'll fix that up.

Will


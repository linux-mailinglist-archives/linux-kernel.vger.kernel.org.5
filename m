Return-Path: <linux-kernel+bounces-32754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D1E835FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9971F27B4E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C41E3A1BD;
	Mon, 22 Jan 2024 10:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdDXnFgK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609C93A8C3;
	Mon, 22 Jan 2024 10:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705919390; cv=none; b=Earr6tDD4wsI8ao8zdypvxGGlj5zcj1YV0hjy6jTLwMIARFYPBE6xiEl4teRXOLnV3kpt8eaAWdlhqIHZGjJD3PmjCa/fOqaAu/FtrId2Re6ftYNkWJPXlzlpDluAyPpQxOi7xgb3L9bnRdmd/qwKmkYwVS4GF2GlowYsd+9mYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705919390; c=relaxed/simple;
	bh=jDLFyl1iKiEHyp5Pcbub/gZ1AielXM8NVmAdEUhcoHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RCRzN8Ox+tSRPt+fHEpk8PxMMxQTs5rvQl2qAh2Q2kcg3Uql5LO1zkIMluFLRTEcWd2h5abcrMkORUoQ9VY4PTpnZIwZul8MlD7qXx2gsj2N9/IHv4NUW0Uy7UTBd0ICtFWQZ4+B8V0UrjtTnWfMdTFnexxzqIAHTnjcrTMjxX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdDXnFgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A311C43390;
	Mon, 22 Jan 2024 10:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705919389;
	bh=jDLFyl1iKiEHyp5Pcbub/gZ1AielXM8NVmAdEUhcoHI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NdDXnFgKzqNeKOercLqiY5oPy4XmqEdQizooiSNTMa1ncAx7HFkVKZd9TE4mJ0wvW
	 ySGi1O/UKt11Dk+uMshzLNibAR905+qbEEdu0OUeMDHw47naSfnP2S93CuFZZSekdG
	 uFMD7sZ3HcA80BWjuggxGiZjag+P86CVQGN2OdEuzoDFW35UABYXjrFkTN4g46xVl0
	 nq2TldAyMErFwU3mzXhTI+DWJdAUT4DemoDsbJ2CVE4rZz9SaG4ableqi20K20ETTi
	 gknA5H6jLtzRzuJWqsaXld4XEQ9d3/g74CqI5cGxWdtWfpO01NzTUs3BHa2RI7xwnj
	 hYxSrCocuzSQQ==
Message-ID: <74c3f9b7-1215-4216-bf56-c20e40acdeb8@kernel.org>
Date: Mon, 22 Jan 2024 19:29:48 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ata: ahci_ceva: add missing enable regulator API for
 Xilinx GT PHY support
Content-Language: en-US
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, cassel@kernel.org,
 richardcochran@gmail.com, piyush.mehta@xilinx.com, axboe@kernel.dk,
 michal.simek@amd.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, git@amd.com,
 Piyush Mehta <piyush.mehta@amd.com>
References: <1705604904-471889-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1705604904-471889-3-git-send-email-radhey.shyam.pandey@amd.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <1705604904-471889-3-git-send-email-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/19/24 04:08, Radhey Shyam Pandey wrote:
> From: Piyush Mehta <piyush.mehta@amd.com>
> 
> The regulators API are disabled and enabled, during suspend and resume,
> respectively. The following warning notice shows up on the initial suspend
> because the enable regulators API is unaddressed in the probe:
> 
> regulator-dummy: Underflow of regulator enable count
> 
> Added the ahci_platform_enable_regulators API in probe to maintain the
> regulator enabled and disabled ref count.
> 
> Fixes: 9a9d3abe24bb ("ata: ahci: ceva: Update the driver to support xilinx GT phy")
> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research



Return-Path: <linux-kernel+bounces-38686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4850783C417
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B9F2973C4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09875B5B2;
	Thu, 25 Jan 2024 13:49:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A265B1FF;
	Thu, 25 Jan 2024 13:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706190586; cv=none; b=PkDfi5z8KSpVhoMfMFbXXRbyZqIQMn8i4itjBato38EkZXek271zPWEjRW1T/KOCHmXrzSg7bnvr8rpundTre/g2u6ePWGlf28oQMA5cMwQXWBFYHXjK/BgrPZAKanAVhrWHUG2p8MqQ7zCQFN7QYaKUwbf93Sk2BCBUCIDVUaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706190586; c=relaxed/simple;
	bh=6iy/6WiekLaKinGKMQjSK9tWQ4cBT+O71xHlgaPxvqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXL3lHg0pNZUDD4uBeY6dhueAt4rI4RAX+a096N59SDpbENuLn/uSHSmcV8xTQczQ+K8xPqDG84Ri2/hPjuVkki9yu6StN0+Zxx6Q81OfTWiBpixJrrn/4cSaog9k/M6kptk/OIzCFHk8cbOd7uGazQLgyrD8cTz6FSDwOTTPmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A58CFEC;
	Thu, 25 Jan 2024 05:50:28 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01F9C3F5A1;
	Thu, 25 Jan 2024 05:49:42 -0800 (PST)
Date: Thu, 25 Jan 2024 13:49:40 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edmund Grimley-Evans <edmund.grimley-evans@arm.com>
Subject: Re: [PATCH v2 2/4] arm64/sme: Fix cut'n'paste in ABI document
Message-ID: <ZbJm9J0QuE6Rx9ba@e133380.arm.com>
References: <20240124-arm64-sve-sme-doc-v2-0-fe3964fb3c19@kernel.org>
 <20240124-arm64-sve-sme-doc-v2-2-fe3964fb3c19@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124-arm64-sve-sme-doc-v2-2-fe3964fb3c19@kernel.org>

On Wed, Jan 24, 2024 at 06:12:36PM +0000, Mark Brown wrote:
> The ABI for SME is very like that for SVE so bits of the ABI were copied
> but not adequately search and replaced, fix that.
> 
> Reported-by: Edmund Grimley-Evans <edmund.grimley-evans@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  Documentation/arch/arm64/sme.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/arch/arm64/sme.rst b/Documentation/arch/arm64/sme.rst
> index 3d0e53ecac4f..3133d0e91b48 100644
> --- a/Documentation/arch/arm64/sme.rst
> +++ b/Documentation/arch/arm64/sme.rst
> @@ -238,12 +238,12 @@ prctl(PR_SME_SET_VL, unsigned long arg)
>        bits of Z0..Z31 except for Z0 bits [127:0] .. Z31 bits [127:0] to become
>        unspecified, including both streaming and non-streaming SVE state.
>        Calling PR_SME_SET_VL with vl equal to the thread's current vector
> -      length, or calling PR_SME_SET_VL with the PR_SVE_SET_VL_ONEXEC flag,
> +      length, or calling PR_SME_SET_VL with the PR_SME_SET_VL_ONEXEC flag,
>        does not constitute a change to the vector length for this purpose.
>  
>      * Changing the vector length causes PSTATE.ZA and PSTATE.SM to be cleared.
>        Calling PR_SME_SET_VL with vl equal to the thread's current vector
> -      length, or calling PR_SME_SET_VL with the PR_SVE_SET_VL_ONEXEC flag,
> +      length, or calling PR_SME_SET_VL with the PR_SME_SET_VL_ONEXEC flag,
>        does not constitute a change to the vector length for this purpose.

Reviewed-by: Dave Martin <Dave.Martin@arm.com>



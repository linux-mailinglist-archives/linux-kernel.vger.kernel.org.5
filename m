Return-Path: <linux-kernel+bounces-35595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE6A8393DC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50B28B27920
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0094604B6;
	Tue, 23 Jan 2024 15:51:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C2F5FEE4;
	Tue, 23 Jan 2024 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025062; cv=none; b=m+iKDR2XwUGRzrkGgd+s0jgTubT1ZChkXBO+GT6OhlCR+NhBg2sfZVaCShK9dnHInXKkc8UZjlgzLArmPZ6V3wFjtpn0ehY3OSolqpYLJkkC1n3SnK59t9MqR4VKouP4aiITq/d4Q7GZ2HZ0gb4n9mDYTLyKmuV9jcTa+/zG70Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025062; c=relaxed/simple;
	bh=hmj2ce1GyqvbDEkeN/1Zuzv0pi/tXoRZpbBg/gTM25c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkiyRbKdFfZGVprZ8fPqdbjl8dj2rMsO5iO/evZ5UahiMe2ijrb6q1WzuSCLYZZZk5oijYkZSA1XO+rDGXY5nas7U2xf2SvQ7rBPiWPLtZLGmKZrjSfq3EvMkL326qJKQ3aiakFk1TnrFIv2e4Yv7W4viQb+fiiLvcM/APQxWm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78AE41FB;
	Tue, 23 Jan 2024 07:51:45 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D8253F5A1;
	Tue, 23 Jan 2024 07:50:59 -0800 (PST)
Date: Tue, 23 Jan 2024 15:50:56 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edmund Grimley-Evans <edmund.grimley-evans@arm.com>
Subject: Re: [PATCH 4/4] arm64/sme: Remove spurious 'is' in SME documentation
Message-ID: <Za/gYAmTeCNQ0VWA@e133380.arm.com>
References: <20240122-arm64-sve-sme-doc-v1-0-3d492e45265b@kernel.org>
 <20240122-arm64-sve-sme-doc-v1-4-3d492e45265b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122-arm64-sve-sme-doc-v1-4-3d492e45265b@kernel.org>

On Mon, Jan 22, 2024 at 08:41:54PM +0000, Mark Brown wrote:
> Just a typographical error.
> 
> Reported-by: Edmund Grimley-Evans <edmund.grimley-evans@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>

FWIW (just to break my duck),

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> ---
>  Documentation/arch/arm64/sme.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/arch/arm64/sme.rst b/Documentation/arch/arm64/sme.rst
> index ba0a5e5b2523..bc9855e599c8 100644
> --- a/Documentation/arch/arm64/sme.rst
> +++ b/Documentation/arch/arm64/sme.rst
> @@ -75,7 +75,7 @@ model features for SME is included in Appendix A.
>  2.  Vector lengths
>  ------------------
>  
> -SME defines a second vector length similar to the SVE vector length which is
> +SME defines a second vector length similar to the SVE vector length which
>  controls the size of the streaming mode SVE vectors and the ZA matrix array.
>  The ZA matrix is square with each side having as many bytes as a streaming
>  mode SVE vector.
> 
> -- 
> 2.30.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


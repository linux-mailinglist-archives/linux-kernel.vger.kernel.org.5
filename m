Return-Path: <linux-kernel+bounces-35584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC78B8393AE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1C27B20DDF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AE7604B7;
	Tue, 23 Jan 2024 15:44:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B335C5FF07;
	Tue, 23 Jan 2024 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024672; cv=none; b=ZXQ84dO1Ia2jcgGhYOuSZGl/igBobDiuVlMHfK6utD/aWvqRyaoy34bc4WzUyfvifi/u7jX1SqVhEzi5+Cq0BjAIeneKoBG56cH6VXG8TvFFyFBE4yihW9CavAJuW1UqGZk4+lbhLmqpiVR2gItgltu5vTOM31fBPIvg17MyaGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024672; c=relaxed/simple;
	bh=+UBMBwqjM4LUVFP6+vP3hZIWmeh/+RFBlTBKRI4wpMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ii/HgVgFQwn9JzHVmOGDqZzJYvbFtkdWLowQ+Co2A8l6w0teJhcXS95ZmcoAKC5rjV++O1Kmfprjoq7AI7XxC3acvnLtNDxV7yL2r5zOJiyyZ/MDNHtg5num2DNkbH3W+xLA/Qm8HqyuGNJ1cqjRe+5nup4xrAuby7qGjtEHpgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 178871FB;
	Tue, 23 Jan 2024 07:45:12 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC65E3F5A1;
	Tue, 23 Jan 2024 07:44:25 -0800 (PST)
Date: Tue, 23 Jan 2024 15:44:23 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edmund Grimley-Evans <edmund.grimley-evans@arm.com>
Subject: Re: [PATCH 1/4] arm64/sve: Remove bitrotted comment about syscall
 behaviour
Message-ID: <Za/e15zUOEaa1b7d@e133380.arm.com>
References: <20240122-arm64-sve-sme-doc-v1-0-3d492e45265b@kernel.org>
 <20240122-arm64-sve-sme-doc-v1-1-3d492e45265b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122-arm64-sve-sme-doc-v1-1-3d492e45265b@kernel.org>

On Mon, Jan 22, 2024 at 08:41:51PM +0000, Mark Brown wrote:
> When we documented that we always clear state not shared with FPSIMD we

Where / when?

> didn't catch all of the places that mentioned that state might not be
> cleared, remove a lingering reference.
> 
> Reported-by: Edmund Grimley-Evans <edmund.grimley-evans@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  Documentation/arch/arm64/sve.rst | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/Documentation/arch/arm64/sve.rst b/Documentation/arch/arm64/sve.rst
> index 0d9a426e9f85..b45a2da19bf1 100644
> --- a/Documentation/arch/arm64/sve.rst
> +++ b/Documentation/arch/arm64/sve.rst
> @@ -117,11 +117,6 @@ the SVE instruction set architecture.
>  * The SVE registers are not used to pass arguments to or receive results from
>    any syscall.
>  
> -* In practice the affected registers/bits will be preserved or will be replaced
> -  with zeros on return from a syscall, but userspace should not make
> -  assumptions about this.  The kernel behaviour may vary on a case-by-case
> -  basis.
> -

This was originally an intentionally conservative statement, to allow
the kernel the flexibility to relax the register zeroing behaviour in
the future.  It would have permitted not always disabling a task's SVE
across a syscall, for example.  There were some concerns about security
and testability that meant that we didn't use this flexibility to begin
with.

If we are making an irrevocable commitment not to use this flexibility
ever, then this comment can go, but if we're not totally sure then I
think it would be harmless to keep it (?)

(Feel free to point me to the relevant past discussion that I may have
missed.)

[...]

Cheers
---Dave


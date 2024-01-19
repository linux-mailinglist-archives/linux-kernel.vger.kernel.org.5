Return-Path: <linux-kernel+bounces-31363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0464832D39
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2561C241B0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327E94F1FA;
	Fri, 19 Jan 2024 16:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8YDHL8Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6F51F60B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705682050; cv=none; b=KSN/pSpJhj9iUJc80l6hNspPo7TSQneApjNFFH7Wqt14BNyqlwafAe9kBztkG9iPX/tVtlswKRrZ6c8bLeoAv1hmL9QD0n+NzIMNn1vUlwK9HWlSBKFM8bTWCXPUelci7NoPiUrcbhqJuCLKuOn+UswU5lc+fuF/+zy1Q9sbg3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705682050; c=relaxed/simple;
	bh=rOnjjf8fI4jZQooTEJ2NyQy2pywFx1MKV3IZYwS1vJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/KfFnx7mNoETfnjvKJASraW6h6wFIbcQIBTC+TtNDGwhc0K6O8Mmi4ap49YHaZ5GzbEkAFuBDDuqR3fZ63Zl1MsOgdcNSheYOv5OBJEbOIdnraY1S+Ul/v3QOYI61s1rC6fnylw13yEvRuuOrKBqDghDhshw/urLB7+yQVbnws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8YDHL8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A194C433F1;
	Fri, 19 Jan 2024 16:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705682050;
	bh=rOnjjf8fI4jZQooTEJ2NyQy2pywFx1MKV3IZYwS1vJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M8YDHL8QAiAJgeig7sJSmJCWOSvh+4xnc1G0AZKmqlGWm+i1HYdj9a4b74D3S4ZkK
	 ez1dRi60Il+mIVFZNU+rL3yL+LeZNwi8ZZJ++difwiB8dE+8yIIBhPSeaOxAaj/LFV
	 cfO2NSKrQmu5C7EtdJ4wXGYksyYJ3/8uOpH3/qdop3ofVsVKbaQboNi8nzMqcepLO+
	 uKErXk35yogxayb1LLJfaP06Z9CSg3VH5/5scGfzUfsgPv62tVwPjXPoJqqMwEfJDr
	 1bSJxT4ehdUPb45QtwspKfvgssGz7av2ZMkQSgRFQqWknIqFJxOGD/GpXfG4Uim8s9
	 fxgvMP/xdKQJw==
Date: Fri, 19 Jan 2024 10:34:08 -0600
From: Rob Herring <robh@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: torvalds@linux-foundation.org, catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [GIT PULL] arm64 fixes for -rc1
Message-ID: <20240119163408.GA468084-robh@kernel.org>
References: <20240119160528.GA5336@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119160528.GA5336@willie-the-truck>

On Fri, Jan 19, 2024 at 04:05:28PM +0000, Will Deacon wrote:
> Hi Linus,
> 
> Please pull these arm64 fixes for -rc1. I think the main one is fixing
> the dynamic SCS patching when full LTO is enabled (clang was silently
> getting this horribly wrong), but it's all good stuff. Rob just pointed
> out that the fix to the workaround for erratum #2966298 might not be
> necessary, but in the worst case it's harmless and since the official
> description leaves a little to be desired here, I've left it in.
> 
> Cheers,
> 
> Will
> 
> --->8
> 
> The following changes since commit db32cf8e280b46726065c518e90761bb0229bacf:
> 
>   Merge branch 'for-next/fixes' into for-next/core (2024-01-04 12:32:33 +0000)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
> 
> for you to fetch changes up to 1b20d0486a602417defb5bf33320d31b2a7a47f8:
> 
>   arm64: Fix silcon-errata.rst formatting (2024-01-18 11:15:43 +0000)
> 
> ----------------------------------------------------------------
> arm64 fixes for -rc1
> 
> - Fix shadow call stack patching with LTO=full
> 
> - Fix voluntary preemption of the FPSIMD registers from assembly code
> 
> - Fix workaround for A520 CPU erratum #2966298 and extend to A510
> 
> - Fix SME issues that resulted in corruption of the register state
> 
> - Minor fixes (missing includes, formatting)
> 
> ----------------------------------------------------------------
> Ard Biesheuvel (2):
>       arm64: scs: Work around full LTO issue with dynamic SCS
>       arm64: fpsimd: Bring cond_yield asm macro in line with new rules
> 
> Mark Brown (3):
>       arm64/ptrace: Don't flush ZA/ZT storage when writing ZA via ptrace
>       arm64/fpsimd: Remove spurious check for SVE support
>       arm64/sme: Always exit sme_alloc() early with existing storage
> 
> Mark Rutland (2):
>       arm64: entry: fix ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD

I've commented on the patch, but this doesn't fix anything. The original 
work-around was fine.

Rob


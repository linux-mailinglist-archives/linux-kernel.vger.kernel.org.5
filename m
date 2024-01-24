Return-Path: <linux-kernel+bounces-37321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A5F83AE34
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72BF41C23CBE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496227E577;
	Wed, 24 Jan 2024 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="rK3w1FWZ"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECAD7CF2E;
	Wed, 24 Jan 2024 16:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706113113; cv=none; b=tonjrWYx+dhfbesFaQ8IaNL7NVBvmpweqTdv8WXE4L3TWDkaTscAakxP7XotyVGk0c0HmceJQt3BpHqb6Hx+j9g/9ULphbqqPDh9Cu4Oek2SgJ6B2oMQ3jtmoHBS8BL55hrPTL1GF1SYNUQSwC3DDWuNqeZCUp3w1DWMkDYK2/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706113113; c=relaxed/simple;
	bh=fdb4Zk8kpS57cz7UQOaWOD8Gc/oHuCpHnm87tMS4JXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NiId801Y+yDJb08oIZ3IAs80xcCYxy9D4pfs3SdOSplR0R8dMA3ieK2bw34XlyLemyKJfvaF0llaMZ/o+Y0NdUDFpBtnXnhHR3cjzgH4AXMlZRhgJAPrzZlFevlmhAcUU3oOxgrIA+SUdsMzQEdJum3Nx2RQknypKXtm4nCk7CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=rK3w1FWZ; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706113110;
	bh=fdb4Zk8kpS57cz7UQOaWOD8Gc/oHuCpHnm87tMS4JXQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rK3w1FWZECH8ewCqknoAwEohXevMn+PQBx7pEAb01wOihiY3/DfpbEPyknog+SkAg
	 QLMn7tFVyTz8pw96EfO5j6yk6p4o0U6uDWs1mCVPZiBlvJGrvLV7tMrLx9nCBlmzwQ
	 scxJB91Do6jit+Nm4xDCcHMunRlwKYUIqmO5par4mrEKfjAQY2ziQ06cxSxJ4EZDXp
	 kGCODRxkCuQ6Rng7lBEfiZ8mxCP5E52W/GqsXedcKvqMgk7FkmTUeo12L6g9fCrwss
	 K+lPAEyZDvxMLUk/AWq4mPOnVmVFOBEExUSHaSfCyzjhfyIIvl3DEhWpdGjHkpYS2t
	 R72AnGsc8e+Mw==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TKpzV2MbBzV72;
	Wed, 24 Jan 2024 11:18:30 -0500 (EST)
Message-ID: <aabea058-0088-41bb-822a-402669f348bb@efficios.com>
Date: Wed, 24 Jan 2024 11:18:30 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] membarrier: riscv: Provide core serializing
 command
Content-Language: en-US
To: Andrea Parri <parri.andrea@gmail.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, paulmck@kernel.org, corbet@lwn.net
Cc: mmaas@google.com, hboehm@google.com, striker@us.ibm.com,
 charlie@rivosinc.com, rehn@rivosinc.com, linux-riscv@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240110145533.60234-1-parri.andrea@gmail.com>
 <20240110145533.60234-5-parri.andrea@gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240110145533.60234-5-parri.andrea@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-10 09:55, Andrea Parri wrote:
[...]
> 
> diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> index d96b778b87ed8..a163170fc0f48 100644
> --- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> +++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> @@ -10,6 +10,22 @@
>   # Rely on implicit context synchronization as a result of exception return
>   # when returning from IPI handler, and when returning to user-space.
>   #
> +# * riscv
> +#
> +# riscv uses xRET as return from interrupt and to return to user-space.
> +#
> +# Given that xRET is not core serializing, we rely on FENCE.I for providing
> +# core serialization:
> +#
> +#  - by calling sync_core_before_usermode() on return from interrupt (cf.
> +#    ipi_sync_core()),
> +#
> +#  - via switch_mm() and sync_core_before_usermode() (respectively, for
> +#    uthread->uthread and kthread->uthread transitions) to go back to
> +#    user-space.

I don't quite get the meaning of the sentence above. There seems to be a
missing marker before "to go back".

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com



Return-Path: <linux-kernel+bounces-46721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A0A844329
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13885290757
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D19D12A16A;
	Wed, 31 Jan 2024 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="lPSfX5mK"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCA712A14F;
	Wed, 31 Jan 2024 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706715242; cv=none; b=JyoiK1LwONhuq6z82LcfDW+GQqoc3JouVhK4m8okrV+cDdKZw2b3x2DMxmtL7kKiQUuRUp1DmlXZ2O4JojWTHf4rVN4S3rRYsaBcmiDJhVm3hLMBwcKzGgXSmfdkiOv9BG2VTi23T0nwo5UiueWEqiz+Lm1dQHGp5yyf27LKLyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706715242; c=relaxed/simple;
	bh=JvE4wxUL3PufVxrqn37IX2VRkyiWvVzHahoJOEeAAN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U3KtuWkV5Xlv27ziF/rWLnEqVOASDzj2tka9Hv3FbdXhGqHohvbvJWFvgkKo3fUyB7Q46rFX2CoL5hmlTbS22fAE7/QLKpm+59cHhRIwf8127bVY/gmwrxBzqYvDplUguxHJ9eS2N86J6aZhI2Rft50FBEz1aHiwJfsdEkMs/RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=lPSfX5mK; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706715240;
	bh=JvE4wxUL3PufVxrqn37IX2VRkyiWvVzHahoJOEeAAN0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lPSfX5mKN8KAdjUyhp4wQqLXqMyQtU4oXSSaIK93ceIbBz3nqA+xyShSZ63eNMUEY
	 4ltH4cpctRQ2bKBh2jPUz7YzlckoykLXBXL1iKZGhjEsqitBuZDmZyJzJykroyGZYI
	 UBRzcNKyl0x3ztSsfJ0bzfrYwiCZy2rcArsz5GTC+j1RVGNmPtBcLry/HUkANuRMO7
	 COWdL0YdaUce34kcdlXBa1wur1kg1WwGiV7ZRfpL1fu8Ts2gaEHLM78D8xZmtK+QV5
	 D2TwH4bbt7gA4rZTlIw2qNkrfTkpwniCn8FOD4uTIYdA+HjQ3EqofTYkLu5XDgPZiF
	 wGhhl/Jzf6dQg==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TQ5fv5JhHzVrW;
	Wed, 31 Jan 2024 10:33:59 -0500 (EST)
Message-ID: <8325617c-51a4-4747-8082-befe9ff1c0f3@efficios.com>
Date: Wed, 31 Jan 2024 10:33:59 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] membarrier: riscv: Provide core serializing
 command
Content-Language: en-US
To: Andrea Parri <parri.andrea@gmail.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, paulmck@kernel.org, corbet@lwn.net
Cc: mmaas@google.com, hboehm@google.com, striker@us.ibm.com,
 charlie@rivosinc.com, rehn@rivosinc.com, rdunlap@infradead.org,
 sorear@fastmail.com, linux-riscv@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240131144936.29190-1-parri.andrea@gmail.com>
 <20240131144936.29190-5-parri.andrea@gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240131144936.29190-5-parri.andrea@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-31 09:49, Andrea Parri wrote:
> RISC-V uses xRET instructions on return from interrupt and to go back
> to user-space; the xRET instruction is not core serializing.
> 
> Use FENCE.I for providing core serialization as follows:
> 
>   - by calling sync_core_before_usermode() on return from interrupt (cf.
>     ipi_sync_core()),
> 
>   - via switch_mm() and sync_core_before_usermode() (respectively, for
>     uthread->uthread and kthread->uthread transitions) before returning
>     to user-space.
> 
> On RISC-V, the serialization in switch_mm() is activated by resetting
> the icache_stale_mask of the mm at prepare_sync_core_cmd().
> 
> Suggested-by: Palmer Dabbelt <palmer@dabbelt.com>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com



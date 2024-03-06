Return-Path: <linux-kernel+bounces-94520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2BA8740F6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC289287DE7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AD0140E37;
	Wed,  6 Mar 2024 20:00:52 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F78140386
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755252; cv=none; b=msrSqIOzgPB0O8xjZVKmivH3rOpQRGthJT0F0GoHAYA5XM1RlP1K0w8iInV05yxYXi9OYMc9XnRhsWEn3KBiupA++YPYaVS2GrxCTzUCoOzbpFV/ZpoO0eEYZ3snnYFY/GLk0qdgZnGsowKBEf3EwXaU1lK9GrODiew0a1m1TsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755252; c=relaxed/simple;
	bh=ThBic/H+/99AwjUove3ckV4qt59NoORjigFxFZ2oRh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pU5LjO5KZr7fZEtE9vX3hUQ24CfkOUeJHXkxOeBZenhxvvq0f9ukab+lLjuE5XugtdBn+SkF+2xWY+Ns1wCDaVdBw8Usi+E+NGqriXsNb4k6cOgQwVXUDtaHEtKSIhY8q46bWfbTVYS2DKB2we8f0PwpCjCw6ayUlEtnQfFYJ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id A9C3620007;
	Wed,  6 Mar 2024 20:00:44 +0000 (UTC)
Message-ID: <048b4cff-9f3e-48aa-8c17-043261888ad5@ghiti.fr>
Date: Wed, 6 Mar 2024 21:00:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: compat_vdso: align VDSOAS build log
Content-Language: en-US
To: Masahiro Yamada <masahiroy@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
References: <20231117125843.1058553-1-masahiroy@kernel.org>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20231117125843.1058553-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Masahiro,

On 17/11/2023 13:58, Masahiro Yamada wrote:
> Add one more space after "VDSOAS" for better alignment in the build log.
>
> [Before]
>
>    LDS     arch/riscv/kernel/compat_vdso/compat_vdso.lds
>    VDSOAS arch/riscv/kernel/compat_vdso/rt_sigreturn.o
>    VDSOAS arch/riscv/kernel/compat_vdso/getcpu.o
>    VDSOAS arch/riscv/kernel/compat_vdso/flush_icache.o
>    VDSOAS arch/riscv/kernel/compat_vdso/note.o
>    VDSOLD  arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg
>    VDSOSYM include/generated/compat_vdso-offsets.h
>
> [After]
>
>    LDS     arch/riscv/kernel/compat_vdso/compat_vdso.lds
>    VDSOAS  arch/riscv/kernel/compat_vdso/rt_sigreturn.o
>    VDSOAS  arch/riscv/kernel/compat_vdso/getcpu.o
>    VDSOAS  arch/riscv/kernel/compat_vdso/flush_icache.o
>    VDSOAS  arch/riscv/kernel/compat_vdso/note.o
>    VDSOLD  arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg
>    VDSOSYM include/generated/compat_vdso-offsets.h
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>   arch/riscv/kernel/compat_vdso/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/compat_vdso/Makefile b/arch/riscv/kernel/compat_vdso/Makefile
> index 62fa393b2eb2..3df4cb788c1f 100644
> --- a/arch/riscv/kernel/compat_vdso/Makefile
> +++ b/arch/riscv/kernel/compat_vdso/Makefile
> @@ -74,5 +74,5 @@ quiet_cmd_compat_vdsold = VDSOLD  $@
>                      rm $@.tmp
>   
>   # actual build commands
> -quiet_cmd_compat_vdsoas = VDSOAS $@
> +quiet_cmd_compat_vdsoas = VDSOAS  $@
>         cmd_compat_vdsoas = $(COMPAT_CC) $(a_flags) $(COMPAT_CC_FLAGS) -c -o $@ $<


Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex



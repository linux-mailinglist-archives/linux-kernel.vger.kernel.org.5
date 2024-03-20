Return-Path: <linux-kernel+bounces-108278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D66B68808B1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13D9F1C215BD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703D75CA1;
	Wed, 20 Mar 2024 00:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="r2On/Zmp"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B40522F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710895691; cv=none; b=Yow3YDADJKRIxFGJUhU3oCPn7ON+CDw9NTm8wLjBX3a4QjjYJe5YYjh7bBVeGYjVq7HP3q3YY0DDur4o6x5jF5bhMIFuAMZ4XTn8Eqb7ClNPTF98AV244J3u3Luh3Lk5I9ns+01CI9CmaxPDlt26hR+dzk+kpVu5Gs9rW0lo3gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710895691; c=relaxed/simple;
	bh=QommcP164/JlJlWZtE3t454lJW9YitPOHCbKBWmJV0s=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=tl7YIGu8XtXPoCbG6Dnx7Iaht6BynTbrmazwj/9c0ZkUKB+XFlUR2HXareO+jDtg0TeCBclKFJxYTinXqNEKhQ5XQXpl6191cdIySVQY/7LhtD69zagbNkABiNkUGh7Y7T0Dv2rwH39XSmUfQCBlnhaVDAJKaWBRMAf9GNBznKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=r2On/Zmp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1def2a1aafaso31858965ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1710895689; x=1711500489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A1BsYh4Oeo/EXB+SJKi8cVJUla+OGiDIMCVUpv9M9MY=;
        b=r2On/ZmpBo56eLquhbQqlg7WTT4fOOOeuO9jul6ePT8nvFecXeV0uw9KbAzvhc/8JV
         dZzXWs+khlLtbEoL+jq7TD3JYlMc/azFNCfjJVIVElLwP+ynZrLfHx8g1+RsYLvNzqbY
         Rssl3j8l/bk5jkPkXieFKRExU6mt5MPlOlLdkdfGJ+47nU3aFj5G3e2uqZrkNwogpe1p
         mXsnWEmZCLSJL3oTaAt9zgRZwdxgJooS2PvhZeFLASKAf5QfEk1RfdsB48rD0oaSasoV
         m42VoFlXef1dcbTUgWsnyaHAtvdaPMuxiimvP9RJJG6j1PyYT/PzUdLbpZ3F4ReDxDLH
         zMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710895689; x=1711500489;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1BsYh4Oeo/EXB+SJKi8cVJUla+OGiDIMCVUpv9M9MY=;
        b=sr22/cLwd4wlpLMGJGbLlVbmIyWfTM0jwOJFWomnaiUeVCcLQF7AxTo98Sop0BiYgO
         PVeGjZIBxwobnwBUzAEZna8C2DYb+EWqHP8zN/NwQ7KBGri3ypb87PWq/8aEnpty0BsP
         sbr7PMVeX2ErawOZ42lZ0p6SKWIU6RifOsyW2HYwjswi+XEZ7gNYO4lWaYPFsNDvFCer
         JYxFFixb2hsQiU+0L+e/pSMzsIh6mCEjMXZIzWck78QvRQnLgIruheTNgpG0BCRS0t9I
         l7eljpQW5gwSEsdZmDnx2NZbGp3tfOhOp5pbMSdqkklCSq6opGadBRVr/+qtvhzxO3F9
         JT8g==
X-Forwarded-Encrypted: i=1; AJvYcCWImJYFYNH5k3Rm3NAY3F4Kj4FmEF2XqzPG37m091IL9zGVOn5cwR66g7phW2Z2DpaqZDCGpOusrpiIIcCfh2YlZq8Vo5MyQ+4UMS5n
X-Gm-Message-State: AOJu0Yy8RR0Om9s3JqCthiSeza42Yvp4niEjBgmYZ9uVh25dMeZ/uSRg
	0TkEx+bbWYC97nEoBa/52TnAxcKB9bcWqa1rwkC6S6QBOwEdELInP83g/K9A2rs=
X-Google-Smtp-Source: AGHT+IH7vs7fj6C8C1fDW6ALbMxHKGDjjyKi+kbxP1SdfGtU9JwsqQfjYZ6lM1/3DMCXj7XvwbTB8A==
X-Received: by 2002:a17:903:41ca:b0:1e0:6a:1c01 with SMTP id u10-20020a17090341ca00b001e0006a1c01mr10511673ple.52.1710895688740;
        Tue, 19 Mar 2024 17:48:08 -0700 (PDT)
Received: from localhost ([50.213.54.97])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b001dd6290283fsm12354071plb.248.2024.03.19.17.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 17:48:08 -0700 (PDT)
Date: Tue, 19 Mar 2024 17:48:08 -0700 (PDT)
X-Google-Original-Date: Tue, 19 Mar 2024 17:48:06 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: only flush icache when it has VM_EXEC set
In-Reply-To: <tencent_6D851035F6F2FD0B5A69FB391AE39AC6300A@qq.com>
CC: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, alexghiti@rivosinc.com,
  Conor Dooley <conor.dooley@microchip.com>, jszhang@kernel.org, Andrew Waterman <andrew@sifive.com>, cyy@cyyself.name
From: Palmer Dabbelt <palmer@dabbelt.com>
To: cyy@cyyself.name
Message-ID: <mhng-3e79924e-d965-4156-836d-19cc8fb8cafe@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 09 Jan 2024 10:48:59 PST (-0800), cyy@cyyself.name wrote:
> As I-Cache flush on current RISC-V needs to send IPIs to every CPU cores
> in the system is very costly, limiting flush_icache_mm to be called only
> when vma->vm_flags has VM_EXEC can help minimize the frequency of these
> operations. It improves performance and reduces disturbances when
> copy_from_user_page is needed such as profiling with perf.
>
> For I-D coherence concerns, it will not fail if such a page adds VM_EXEC
> flags in the future since we have checked it in the __set_pte_at function.
>
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> ---
>  arch/riscv/include/asm/cacheflush.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
> index 3cb53c4df27c..915f532dc336 100644
> --- a/arch/riscv/include/asm/cacheflush.h
> +++ b/arch/riscv/include/asm/cacheflush.h
> @@ -33,8 +33,11 @@ static inline void flush_dcache_page(struct page *page)
>   * so instead we just flush the whole thing.
>   */
>  #define flush_icache_range(start, end) flush_icache_all()
> -#define flush_icache_user_page(vma, pg, addr, len) \
> -	flush_icache_mm(vma->vm_mm, 0)
> +#define flush_icache_user_page(vma, pg, addr, len)	\
> +do {							\
> +	if (vma->vm_flags & VM_EXEC)			\
> +		flush_icache_mm(vma->vm_mm, 0);		\
> +} while (0)
>
>  #ifdef CONFIG_64BIT
>  #define flush_cache_vmap(start, end)	flush_tlb_kernel_range(start, end)

I'm not super worried about the benchmarks, I think we can just 
open-loop assume this is faster by avoiding the flushes.  I do think we 
need a hook into at least tlb_update_vma_flags(), though, to insert the 
fence.i when upgrading a mapping to include VM_EXEC.


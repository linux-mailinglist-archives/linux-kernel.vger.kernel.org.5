Return-Path: <linux-kernel+bounces-9294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A522081C38D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 583041F25A96
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 03:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A9D184C;
	Fri, 22 Dec 2023 03:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mei7bXyd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD7C63A4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 03:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703216119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y8TmxaP4mrskjqZXgi+cBjlEzOM/y71ITq0aMJjTxko=;
	b=Mei7bXydxAFW/SjVO3HDGouA5x18lOvtyWCFJrpgWGyrDMV8p4O144GSU7A6rDDdE31amV
	UmG/cDzfnU0kjksDK5NJahzDokWaCFvVv/2F8JbodWYQ5rRw/9G+CfRytmhQIpQAXZr6oD
	GVJOZjtpkU16oSWjGKHK4sSpgS2VWjg=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-7nKI2TIyO9e7XRbrpJfyyw-1; Thu, 21 Dec 2023 22:35:17 -0500
X-MC-Unique: 7nKI2TIyO9e7XRbrpJfyyw-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5c6bd30ee89so1347767a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 19:35:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703216116; x=1703820916;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y8TmxaP4mrskjqZXgi+cBjlEzOM/y71ITq0aMJjTxko=;
        b=dPG3/NAhE1Go5mCMBQmzasGBGS17WzQjBbEdI19WIhzk0X3QiJsY79m4N8tc/X6KCl
         R2h7FAauLsAXXtjVpfxppXleMRzbrdJQ0hgxej96++dXjYXbX6uFO3lQmcI8DJzqTUmA
         iPxt7w/NgJsAeGrtlp146/G0D64zP5DoULoiJAaF3HehEayLEUmnmU/MWJzbWeyhJLN3
         fAhBzcvj1Clc15i5/9UrHnGx5ykQCjxlv31eJFBQtU74K/Dx6w1/gPjyOA8GiutQzoqz
         yq92tsGSP1okXSEDYMETOQxhBoSq5ZtTyZk/l68KN8w4MDdRfoxdIwAxYjtUQSaPg0AN
         iopQ==
X-Gm-Message-State: AOJu0YxO0esI2Ne3F1t1KA0juDodt3qokq1U2zqrMok1EW3ds91bkWkW
	PiM3YBzr37L2FITbwZkxGVrHyBuXwP2fm2+8YBiRL1APhgkkAlfnMx9JDURtwcD1yBUmMN9C3Do
	13OVXwLYh1BZneeQlMByEIWoMKLD71rgd
X-Received: by 2002:a05:6a20:3947:b0:18f:f359:bca5 with SMTP id r7-20020a056a20394700b0018ff359bca5mr914879pzg.64.1703216116071;
        Thu, 21 Dec 2023 19:35:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqO36BVnV3pzvB8GMCCtjZUoRDM68B3iwcPsT+deqxYS7JKss4F1R+kLGypmArdvd1klJX/Q==
X-Received: by 2002:a05:6a20:3947:b0:18f:f359:bca5 with SMTP id r7-20020a056a20394700b0018ff359bca5mr914855pzg.64.1703216115792;
        Thu, 21 Dec 2023 19:35:15 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a802:7496:88a7:1b1a:a837:bebf])
        by smtp.gmail.com with ESMTPSA id r16-20020a17090ad41000b0028b03f9107asm6270280pju.55.2023.12.21.19.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 19:35:15 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: guoren@kernel.org
Cc: Leonardo Bras <leobras@redhat.com>,
	linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	alexghiti@rivosinc.com,
	charlie@rivosinc.com,
	xiao.w.wang@intel.com,
	david@redhat.com,
	panqinglin2020@iscas.ac.cn,
	rick.p.edgecombe@intel.com,
	willy@infradead.org,
	bjorn@rivosinc.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	linux-riscv@lists.infradead.org,
	Guo Ren <guoren@linux.alibaba.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH V2 2/4] riscv: mm: Fixup compat arch_get_mmap_end
Date: Fri, 22 Dec 2023 00:34:56 -0300
Message-ID: <ZYUD4C1aXWt2oFJo@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221154702.2267684-3-guoren@kernel.org>
References: <20231221154702.2267684-1-guoren@kernel.org> <20231221154702.2267684-3-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Dec 21, 2023 at 10:46:59AM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> When the task is in COMPAT mode, the arch_get_mmap_end should be 2GB,
> not TASK_SIZE_64. The TASK_SIZE has contained is_compat_mode()
> detection, so change the definition of STACK_TOP_MAX to TASK_SIZE
> directly.

ok

> 
> Cc: stable@vger.kernel.org
> Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39,sv48,sv57")
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/include/asm/processor.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index f19f861cda54..1f538fc4448d 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -16,15 +16,13 @@
>  
>  #ifdef CONFIG_64BIT
>  #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
> -#define STACK_TOP_MAX		TASK_SIZE_64
> +#define STACK_TOP_MAX		TASK_SIZE

It means STACK_TOP_MAX will be in 64BIT:
- TASK_SIZE_32 if compat_mode=y
- TASK_SIZE_64 if compat_mode=n

Makes sense for me.

>  
>  #define arch_get_mmap_end(addr, len, flags)			\
>  ({								\
>  	unsigned long mmap_end;					\
>  	typeof(addr) _addr = (addr);				\
> -	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
> -		mmap_end = STACK_TOP_MAX;			\
> -	else if ((_addr) >= VA_USER_SV57)			\
> +	if ((_addr) == 0 || (_addr) >= VA_USER_SV57)		\
>  		mmap_end = STACK_TOP_MAX;			\
>  	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
>  		mmap_end = VA_USER_SV48;			\


I don't think I got this change, or how it's connected to the commit msg.

Before:
- addr == 0, or addr > 2^57, or compat: mmap_end = STACK_TOP_MAX
- 2^48 < addr < 2^57: mmap_end = 2^48
- 0 < addr < 2^48 : mmap_end = 2^39

Now:
- addr == 0, or addr > 2^57: mmap_end = STACK_TOP_MAX
- 2^48 < addr < 2^57: mmap_end = 2^48
- 0 < addr < 2^48 : mmap_end = 2^39

IIUC compat mode addr will be < 2^32, so will always have mmap_end = 2^39 
if addr != 0. Is that desireable? 
(if not, above change is unneeded)

Also, unrelated to the change:
- 2^48 < addr < 2^57: mmap_end = 2^48
Is the above correct?
It looks like it should be 2^57 instead, and a new if clause for 
2^32 < addr < 2^48 should have mmap_end = 2^48.

Do I get it wrong?

(I will send an RFC 'fixing' the code the way I am whinking it should look 
like)

Thanks, 
Leo





> -- 
> 2.40.1
> 



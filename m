Return-Path: <linux-kernel+bounces-9340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B7981C451
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B6A1C24F20
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73FE539F;
	Fri, 22 Dec 2023 04:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LOEhZqli"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2CB4680
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 04:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703220572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9vfCqZrbXnu5yi8/YqW3EBsQpMR0fcCm9TF9vlDRItY=;
	b=LOEhZqliUqAswVrCHzKvCeyf5R2W7zv1SfoqRDRU2CSHo3FzGOdgkjnw1IL9NPo9VEhksR
	brGXRVvdMO5eT3F/a4V00hSsv+3lpVapTzwOEmr9Uxz3gc3HMTWxmclvoH15EKB8S6ttrj
	DXmuPLO8okys7tvqfysHEO0wuhKTqB8=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-myaLnN66OKyHMqkBUkiTHQ-1; Thu, 21 Dec 2023 23:49:31 -0500
X-MC-Unique: myaLnN66OKyHMqkBUkiTHQ-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-591bd0709ecso1540574eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:49:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703220570; x=1703825370;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9vfCqZrbXnu5yi8/YqW3EBsQpMR0fcCm9TF9vlDRItY=;
        b=vaCuZimT2YrqtjAf/CdOdiVF9DXirEU/pDMeKDySZ5hx4qatRz9EJQDE3IBrp+trjB
         cRpSiFKSuYV1LNErMU2R8/xR+yuKWl0jlWAr1sjmMH99+VfxN+ImUjdH52N+ymag/OsN
         i4A27T0BVInsW+HcriKhBmaYwqY7x1gZ4usB8qWms+Mi89SOYOBKDu+gPAn+3sLwIIAB
         qm6USVFqsWNpkBcwsU2JHo48Bzks+w2NcEWoHvxFdVtymZFwc78RYULRhJ5QLtrhF/2A
         AfxijYhbfVY6APDAoVPlZZWg2ceE7Nj7jIkrFZmJXzUauXjtNfcdd30Lvld78zwC02xt
         Q4rA==
X-Gm-Message-State: AOJu0YwXCth+mK15D5cZMQmoyxzC1BBrdyABlvmYxhnaavqpPExYv8oX
	rI7qSV+B27/BDHD2u/PEyW8cVTq3nWQjJWDsUYXtKYSQpNbxplKr7/U/2H0m5VXaelZZs5jH55n
	alrJlLdowg8kULfMgeUtRB3l/K5iw81r/
X-Received: by 2002:a05:6358:948c:b0:172:d79f:1841 with SMTP id i12-20020a056358948c00b00172d79f1841mr837822rwb.7.1703220570282;
        Thu, 21 Dec 2023 20:49:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEY7uMU6tQ6yQZ0W8K7Tvw7mp7kvFSDzkp8X9G+PFkXwA4djJ44RpOkZdZf4Xn0yD0J+O6flA==
X-Received: by 2002:a05:6358:948c:b0:172:d79f:1841 with SMTP id i12-20020a056358948c00b00172d79f1841mr837796rwb.7.1703220569870;
        Thu, 21 Dec 2023 20:49:29 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a802:7496:88a7:1b1a:a837:bebf])
        by smtp.gmail.com with ESMTPSA id n15-20020aa7984f000000b006d539fad917sm2425917pfq.65.2023.12.21.20.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 20:49:29 -0800 (PST)
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
	Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V2 3/4] riscv: mm: Remove unused TASK_SIZE_MIN
Date: Fri, 22 Dec 2023 01:49:16 -0300
Message-ID: <ZYUVTFqvIIqv7D9O@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221154702.2267684-4-guoren@kernel.org>
References: <20231221154702.2267684-1-guoren@kernel.org> <20231221154702.2267684-4-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Dec 21, 2023 at 10:47:00AM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Remove TASK_SIZE_MIN because it's not used anymore.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/include/asm/pgtable.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 74ffb2178f54..e415582276ec 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -878,7 +878,6 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>   */
>  #ifdef CONFIG_64BIT
>  #define TASK_SIZE_64	(PGDIR_SIZE * PTRS_PER_PGD / 2)
> -#define TASK_SIZE_MIN	(PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
>  
>  #ifdef CONFIG_COMPAT
>  #define TASK_SIZE_32	(_AC(0x80000000, UL))
> @@ -890,7 +889,6 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>  
>  #else
>  #define TASK_SIZE	FIXADDR_START
> -#define TASK_SIZE_MIN	TASK_SIZE
>  #endif
>  
>  #else /* CONFIG_MMU */
> -- 
> 2.40.1
> 

On torvalds/master:

$git grep TASK_SIZE_MIN
arch/loongarch/include/asm/processor.h:23:#define TASK_SIZE_MIN TASK_SIZE
arch/loongarch/include/asm/processor.h:36:#define TASK_SIZE_MIN TASK_SIZE32
arch/riscv/include/asm/pgtable.h:881:#define TASK_SIZE_MIN      (PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
arch/riscv/include/asm/pgtable.h:893:#define TASK_SIZE_MIN      TASK_SIZE

I can only see definitions, without any usage, so agreed on removing them.

FWIW:
Reviewed-by: Leonardo Bras <leobras@redhat.com>

I would also send a patch for loongarch, since they are in the same boat :)

Thanks!
Leo



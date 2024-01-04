Return-Path: <linux-kernel+bounces-16236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FBD823B4C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 05:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E58EB24DFF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 04:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7AF18EBE;
	Thu,  4 Jan 2024 04:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dWrhb35A"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243C518C29
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 04:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704340828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TBYuqGL01aH65sRzp3Rsp7NBWvcHS/OIZjseRKkmKSE=;
	b=dWrhb35AcrgXyVv7VgnMwoTb9XXRUfy+XmuNN111TPs0fjuVSd51UGeahaZdvo4qkGEXRm
	cVH57vH5PYjPA0e9k9C3NX3VYbfDHpjk2ecb+9aDpcw6y48M/h8noXFQqVNnuzU+nK7b/d
	aV9ASXMgfkj4Egk0K6/n7Yub+zF/3Jo=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-HDkCGfoRPu-6Q79JSrEOyA-1; Wed, 03 Jan 2024 23:00:26 -0500
X-MC-Unique: HDkCGfoRPu-6Q79JSrEOyA-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6dc85c2fb26so153007a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 20:00:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704340826; x=1704945626;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TBYuqGL01aH65sRzp3Rsp7NBWvcHS/OIZjseRKkmKSE=;
        b=INgbSZV0ysy/i4UMPbxN+6qlsDIfQZvhLBsoYcZc1HLjhMVx3Lm5BhPpoTZ6LQOviS
         c2LPOqxtvjTOMLDgxilmoGN3A+nfzw2PsOQU7Rvs8DiP25+QCaLowOOL2EUNjaF7DFaM
         Tm+IfFJsSGDgo+xS52fRUuozyra4r5S9gKrmj0gWQJ2HNyMF+6MnrS0HaMW1MQ2z7gQu
         WOs960kUGLXWauEOHvu5IFro2jsDCi22WG1dPhFLWhjTi++h2YP3Vxy0yw7dZFRIhLTg
         03zpNejsADha3U6p+KrFiyhuobwcpepanqIB4bFxh+3guBIV1UJQbNnOkyhYjDVMlK+F
         U6LA==
X-Gm-Message-State: AOJu0YweEVPh936rmPRmiDzWIudoq7k8RQOyVAR/NLxuU9wvbEE4K81M
	8sjuEs6GaJBgslWOzB5gO1nTIi70BEZliNUVeU8bChXb+MuSgIkyaWxfxWly+aYPJ4cI62EQGDa
	Iea/upHIHQzUTdnN6B5M9KUzr2BOMkC42
X-Received: by 2002:a9d:6195:0:b0:6dc:386:a236 with SMTP id g21-20020a9d6195000000b006dc0386a236mr82603otk.47.1704340826145;
        Wed, 03 Jan 2024 20:00:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYCFaNNcVbXHq19hlObccAYpVr3fPXzM+NW7eJa+gC+TOtT2xTCMbEvFLXeyLlWyifJIETXg==
X-Received: by 2002:a9d:6195:0:b0:6dc:386:a236 with SMTP id g21-20020a9d6195000000b006dc0386a236mr82593otk.47.1704340825954;
        Wed, 03 Jan 2024 20:00:25 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7ec:911:6911:ca60:846:eb46])
        by smtp.gmail.com with ESMTPSA id x9-20020a63db49000000b005ccf10e73b8sm23041671pgi.91.2024.01.03.20.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 20:00:25 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: guoren@kernel.org
Cc: Leonardo Bras <leobras@redhat.com>,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	panqinglin2020@iscas.ac.cn,
	bjorn@rivosinc.com,
	conor.dooley@microchip.com,
	peterz@infradead.org,
	anup@brainfault.org,
	keescook@chromium.org,
	wuwei2016@iscas.ac.cn,
	xiaoguang.xing@sophgo.com,
	chao.wei@sophgo.com,
	unicorn_wang@outlook.com,
	uwu@icenowy.me,
	jszhang@kernel.org,
	wefu@redhat.com,
	atishp@atishpatra.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V12 03/14] riscv: errata: Move errata vendor func-id into vendorid_list.h
Date: Thu,  4 Jan 2024 01:00:14 -0300
Message-ID: <ZZYtTryGpoMk7Gt8@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231225125847.2778638-4-guoren@kernel.org>
References: <20231225125847.2778638-1-guoren@kernel.org> <20231225125847.2778638-4-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Dec 25, 2023 at 07:58:36AM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Move errata vendor func-id definitions from errata_list into
> vendorid_list.h. Unifying these definitions is also for following
> rwonce errata implementation.
> 
> Suggested-by: Leonardo Bras <leobras@redhat.com>
> Link: https://lore.kernel.org/linux-riscv/ZQLFJ1cmQ8PAoMHm@redhat.com/
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/include/asm/errata_list.h   | 18 ------------------
>  arch/riscv/include/asm/vendorid_list.h | 18 ++++++++++++++++++
>  2 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index 83ed25e43553..31bbd9840e97 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -11,24 +11,6 @@
>  #include <asm/hwcap.h>
>  #include <asm/vendorid_list.h>
>  
> -#ifdef CONFIG_ERRATA_ANDES
> -#define ERRATA_ANDESTECH_NO_IOCP	0
> -#define ERRATA_ANDESTECH_NUMBER		1
> -#endif
> -
> -#ifdef CONFIG_ERRATA_SIFIVE
> -#define	ERRATA_SIFIVE_CIP_453 0
> -#define	ERRATA_SIFIVE_CIP_1200 1
> -#define	ERRATA_SIFIVE_NUMBER 2
> -#endif
> -
> -#ifdef CONFIG_ERRATA_THEAD
> -#define	ERRATA_THEAD_PBMT 0
> -#define	ERRATA_THEAD_CMO 1
> -#define	ERRATA_THEAD_PMU 2
> -#define	ERRATA_THEAD_NUMBER 3
> -#endif
> -
>  #ifdef __ASSEMBLY__
>  
>  #define ALT_INSN_FAULT(x)						\
> diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/asm/vendorid_list.h
> index e55407ace0c3..c503373193d2 100644
> --- a/arch/riscv/include/asm/vendorid_list.h
> +++ b/arch/riscv/include/asm/vendorid_list.h
> @@ -9,4 +9,22 @@
>  #define SIFIVE_VENDOR_ID	0x489
>  #define THEAD_VENDOR_ID		0x5b7
>  
> +#ifdef CONFIG_ERRATA_ANDES
> +#define ERRATA_ANDESTECH_NO_IOCP	0
> +#define ERRATA_ANDESTECH_NUMBER		1
> +#endif
> +
> +#ifdef CONFIG_ERRATA_SIFIVE
> +#define	ERRATA_SIFIVE_CIP_453 0
> +#define	ERRATA_SIFIVE_CIP_1200 1
> +#define	ERRATA_SIFIVE_NUMBER 2
> +#endif
> +
> +#ifdef CONFIG_ERRATA_THEAD
> +#define	ERRATA_THEAD_PBMT 0
> +#define	ERRATA_THEAD_CMO 1
> +#define	ERRATA_THEAD_PMU 2
> +#define	ERRATA_THEAD_NUMBER 3
> +#endif
> +
>  #endif
> -- 
> 2.40.1
> 

LGTM:
Reviewed-by: Leonardo Bras <leobras@redhat.com>



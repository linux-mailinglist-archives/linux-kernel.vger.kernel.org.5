Return-Path: <linux-kernel+bounces-16255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF77A823BB3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 06:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9585C1C24D05
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 05:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734051A594;
	Thu,  4 Jan 2024 05:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WgCPoPf0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022D518647
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 05:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704345079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P1vihmddHtSZ99/zq0fZBdm+zeXPC115N0eCs1YPKg8=;
	b=WgCPoPf0DHOTInW2th0z9/Eyfddgc6CAnHIgIYJ2tKdFStqtmF5x9UxXwIhCDSJBeySusM
	02KOkagv9W8K+2qKVynDnZfEqx8vuqpLTXiZuz8ViLjd16NOZfMSU8sPSjpbWe3eVSC4Xa
	ut93RR8DOONmywNDY7VjrafI9zVjTwg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-YEjT0ImDP8KBfgFhe53-lA-1; Thu, 04 Jan 2024 00:11:17 -0500
X-MC-Unique: YEjT0ImDP8KBfgFhe53-lA-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1d3fa2e42cdso913715ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 21:11:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704345076; x=1704949876;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1vihmddHtSZ99/zq0fZBdm+zeXPC115N0eCs1YPKg8=;
        b=nxapk1mLA8P49TGxtU1UgSiOzwd/Y3X6natLWXMuQFtVl5y1pUSwcjOZvcIpl+wsAB
         pf3uWW8cBsZ6hksl6ru2vLYJxGODe2XIsQMS4q36w8kWTMDBSk/hSnXM0cBuL/kAsnXw
         kThd39zfKowB0J4lS8R12qvcteQseQ0B7RtZX7qg6QErXqJJyFzmyO3r6u3flAywCz6o
         FWinzY76+2fysnTB3sfVZeHhDIzY4Au39ff+Euj2eC8WxHxDpffD0NjPEXS/cr7Vstjo
         6KGe5ZFkuV+7ZmFnUWnF6Y2oBsqjNeKNoF1V1kFW8ci1N3PXdsMsQnaFa6o5LXjNj0DM
         SvXA==
X-Gm-Message-State: AOJu0YyDfcSK1DROadeVziT+I+cPZ8JFDNod7yNYvc6M/zw8LJVTS5ow
	bLoyo3CWXci9Y/plMUZ9jxs0TvBPDbJiwFk/luxbw6O8Seakr3i7KeJ9UTZ/vlI8+KeAMq4QhOf
	2/OdDHnocpsoagGcpk93EjpG+5jtpyBVc
X-Received: by 2002:a17:902:da86:b0:1d4:d140:8171 with SMTP id j6-20020a170902da8600b001d4d1408171mr52088plx.41.1704345076615;
        Wed, 03 Jan 2024 21:11:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpSlvwWfbHMFG7wHdD03jmH2na3W8ssbNhKgAkQNbMSxmoAlh0aAjbmolGPOik5IenAoMbcg==
X-Received: by 2002:a17:902:da86:b0:1d4:d140:8171 with SMTP id j6-20020a170902da8600b001d4d1408171mr52085plx.41.1704345076326;
        Wed, 03 Jan 2024 21:11:16 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:431:c7ec:911:6911:ca60:846:eb46])
        by smtp.gmail.com with ESMTPSA id u15-20020a17090341cf00b001d3ecbccb52sm24427284ple.213.2024.01.03.21.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 21:11:15 -0800 (PST)
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
Subject: Re: [PATCH V12 08/14] riscv: qspinlock: Force virt_spin_lock for KVM guests
Date: Thu,  4 Jan 2024 02:11:05 -0300
Message-ID: <ZZY96U3CzvDhu3BL@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231225125847.2778638-9-guoren@kernel.org>
References: <20231225125847.2778638-1-guoren@kernel.org> <20231225125847.2778638-9-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Dec 25, 2023 at 07:58:41AM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Force to enable virt_spin_lock when KVM guest, because fair locks
> have horrible lock 'holder' preemption issues.
> 
> Suggested-by: Leonardo Bras <leobras@redhat.com>
> Link: https://lkml.kernel.org/kvm/ZQK9-tn2MepXlY1u@redhat.com/
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/include/asm/sbi.h | 8 ++++++++
>  arch/riscv/kernel/sbi.c      | 2 +-
>  arch/riscv/kernel/setup.c    | 6 +++++-
>  3 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 0892f4421bc4..8f748d9e1b85 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -51,6 +51,13 @@ enum sbi_ext_base_fid {
>  	SBI_EXT_BASE_GET_MIMPID,
>  };
>  
> +enum sbi_ext_base_impl_id {
> +	SBI_EXT_BASE_IMPL_ID_BBL = 0,
> +	SBI_EXT_BASE_IMPL_ID_OPENSBI,
> +	SBI_EXT_BASE_IMPL_ID_XVISOR,
> +	SBI_EXT_BASE_IMPL_ID_KVM,
> +};
> +
>  enum sbi_ext_time_fid {
>  	SBI_EXT_TIME_SET_TIMER = 0,
>  };
> @@ -276,6 +283,7 @@ int sbi_console_getchar(void);
>  long sbi_get_mvendorid(void);
>  long sbi_get_marchid(void);
>  long sbi_get_mimpid(void);
> +long sbi_get_firmware_id(void);
>  void sbi_set_timer(uint64_t stime_value);
>  void sbi_shutdown(void);
>  void sbi_send_ipi(unsigned int cpu);
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 5a62ed1da453..4330aedf65fd 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -543,7 +543,7 @@ static inline long sbi_get_spec_version(void)
>  	return __sbi_base_ecall(SBI_EXT_BASE_GET_SPEC_VERSION);
>  }
>  
> -static inline long sbi_get_firmware_id(void)
> +long sbi_get_firmware_id(void)
>  {
>  	return __sbi_base_ecall(SBI_EXT_BASE_GET_IMP_ID);
>  }
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 0bafb9fd6ea3..e33430e9d97e 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -281,6 +281,9 @@ DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
>  
>  static void __init virt_spin_lock_init(void)
>  {
> +	if (sbi_get_firmware_id() != SBI_EXT_BASE_IMPL_ID_KVM)
> +		no_virt_spin = true;
> +
>  	if (no_virt_spin)
>  		static_branch_disable(&virt_spin_lock_key);
>  	else
> @@ -290,7 +293,8 @@ static void __init virt_spin_lock_init(void)
>  
>  static void __init riscv_spinlock_init(void)
>  {
> -	if (!enable_qspinlock) {
> +	if ((!enable_qspinlock) &&
> +	    (sbi_get_firmware_id() != SBI_EXT_BASE_IMPL_ID_KVM)) {
>  		static_branch_disable(&combo_qspinlock_key);
>  		pr_info("Ticket spinlock: enabled\n");
>  	} else {
> -- 
> 2.40.1
> 

LGTM:
Reviewed-by: Leonardo Bras <leobras@redhat.com>



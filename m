Return-Path: <linux-kernel+bounces-11738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C386881EB06
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 01:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E969B1C21171
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 00:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0282109;
	Wed, 27 Dec 2023 00:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+Ip32ZQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5651F20E3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 00:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703638016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KHfYsdkqhGpgTtAjWcLobs1JbxYurYRnCXUAjSNGEuY=;
	b=D+Ip32ZQmI0kNJqgJk0PGtv5hqnosJD/7wZIIF95iayiqqhoHM14g2CDf9ebQnjrk9Z+S/
	o7/8pDufsMUT2Qjo19DX9u32Euoz/5qQOEKPeL8UYWfylVxs60gasMQRaSs/Dcv+xl02JM
	ud157IphIgSimCNZep1Pr5zA1ow1bAY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-mlKy2b4tPo6OebJPeRHa4A-1; Tue,
 26 Dec 2023 19:46:51 -0500
X-MC-Unique: mlKy2b4tPo6OebJPeRHa4A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E40638143A5;
	Wed, 27 Dec 2023 00:46:51 +0000 (UTC)
Received: from localhost (unknown [10.72.116.16])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A49B3C31;
	Wed, 27 Dec 2023 00:46:50 +0000 (UTC)
Date: Wed, 27 Dec 2023 08:46:46 +0800
From: Baoquan He <bhe@redhat.com>
To: Youling Tang <youling.tang@outlook.com>, akpm@linux-foundation.org
Cc: Huacai Chen <chenhuacai@loongson.cn>, linux-kernel@vger.kernel.org,
	Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH v2] kdump: Remove redundant DEFAULT_CRASH_KERNEL_LOW_SIZE
Message-ID: <ZYtz9hyniU3Llqa0@MiWiFi-R3L-srv>
References: <MW4PR84MB3145459ADC7EB38BBB36955B8198A@MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR84MB3145459ADC7EB38BBB36955B8198A@MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 12/27/23 at 07:46am, Youling Tang wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
> 
> Remove duplicate definitions, no functional changes.
> 
> Reported-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
>  include/linux/crash_core.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index 5126a4fecb44..9eaeaafe0cad 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -87,12 +87,6 @@ Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
>  			  void *data, size_t data_len);
>  void final_note(Elf_Word *buf);
>  
> -#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> -#ifndef DEFAULT_CRASH_KERNEL_LOW_SIZE
> -#define DEFAULT_CRASH_KERNEL_LOW_SIZE  (128UL << 20)
> -#endif
> -#endif

Good catch, thx.

Acked-by: Baoquan He <bhe@redhat.com>

> -
>  int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
>  		unsigned long long *crash_size, unsigned long long *crash_base,
>  		unsigned long long *low_size, bool *high);
> -- 
> 2.40.0
> 



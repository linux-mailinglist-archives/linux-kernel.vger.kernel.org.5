Return-Path: <linux-kernel+bounces-75903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A347A85F076
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F0DB2830F6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72671388;
	Thu, 22 Feb 2024 04:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlZfSV4f"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA9610E5
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 04:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708576592; cv=none; b=H6ez4AwClBXTEZrCHImqzPV2FpT3srNPRqhlkRNeCJ7JTxhH7NWqmJyEtqHiEzrZ+B/M1X/Z4tIlLDlCoKaZXTeSXsLsxkfwYEAi9aFJXau4CgJK8LCSUVnDyA+V9RqKhcZeC6ghuk3gr2mwhxCL6vvDoh9l3tPc85C75moW2jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708576592; c=relaxed/simple;
	bh=/te6BUN5uNGb3X5VKlBOeewCkUInzQPYhE0UrDEOiJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvMrxsXgt5gPDMmrp4yNQDUEhdOS/zNeOFl9sYaLFiLdMQP21ZAGb8eknm0CyI8sz5o1F23NzJWmGLTK50Vv9gdo2xqmvLLfLTlL/0e+U2ZfOdDQGeEBJKijIOXN3Mhc+9YjfBIoVmMweQtm0JRN8DgKyDuOhrqrq63lrDpzaZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlZfSV4f; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78725b62cf2so363244985a.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 20:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708576589; x=1709181389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wj82xEL3MXTSUC7EkK9OL5XKxFUXCZ97I1b2wdmhvE=;
        b=MlZfSV4f8P0EYrlY86nLs9xlCk0bfZPFYGHFSW4qcAHBTs/LmWS9D6P8LBuK6vJ+pw
         XEZugNqQn/hV5c6MRSvghBEYKjdQZCQRTTx90XSvb6GanDNPNbWT3LDShAk4Ft9eyctU
         PyvYpglndC0X0j0lOP3BSFlweM1awTB+/74SDgLMPFdw/xgZRyRR3z9qS0U9OJNoFScK
         3Sp+nD3XcF1TB8w74QIdn3V0QLVzDNZN8qwPqeiyaL4EcwZxkQWBPUsohibV+s6bxdqX
         asNgwN8c9xvCUZXJo7ArlBv3s6XKUcD0XBdfFUT4dIOS8hYILEccDSRQG5wB2WmJvRGp
         yDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708576589; x=1709181389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wj82xEL3MXTSUC7EkK9OL5XKxFUXCZ97I1b2wdmhvE=;
        b=EaS5daCMkG9Hy0vBbCnJA3NuhBAwYqS1nppZcNjWIu3cqCPy5IJPJ1gSVv7xmB9MRJ
         He6H9kIfNz/mFEcchGBUIrX3svJt8NY0HEeDxZ0NU4fxBp/p2FOjrG2+BVExAs8bHO2B
         97ufjrA88aSMX+RZlFyyKgLxVc1bi5t8ext2sjEsb3DVyei3cID4KADFGh1O+uMmTbPW
         /lHgP2Y5EQndegtCiHx3ZmKMvVdgmccOefYF7gOO+TWDDj98WfGrFxNiTJmbVzd81JsJ
         HS9rFSJ/v7KjHfXvq6IKcxDrcDv/GucVIQ/YIwLSqU8TT53sRHpAbQltctGTr8w2Acfl
         kHqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgL0Uoy/Brsc/j+bFkICXEnE0oNTlCTOeBOgcfDBwGS2GOArOgZXtgHjllgCVC+HSSmx9y1oUaVsm4prrGTNBcGoADNVITS0C8FZQr
X-Gm-Message-State: AOJu0YwxCtIfvULI64SdpXpdkOUuQZLkZ3BezPg0xZex82brn6+cws2e
	8A8BFxWT+zMRZonUTO67IgFy16Sp9skqQq82abwNscOIL9YcP2dh
X-Google-Smtp-Source: AGHT+IGTT+ZtO31I2bVygnmpS3RxMRkbe0updWAXzmCjZgGcSoOrGB9oHZx3tgRMo8/wMk/SvSNTvA==
X-Received: by 2002:a05:620a:470c:b0:787:94b6:a97d with SMTP id bs12-20020a05620a470c00b0078794b6a97dmr2229446qkb.54.1708576589473;
        Wed, 21 Feb 2024 20:36:29 -0800 (PST)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id u8-20020a05620a084800b0078783b32229sm1275370qku.7.2024.02.21.20.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 20:36:29 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfauth.nyi.internal (Postfix) with ESMTP id A73F41200043;
	Wed, 21 Feb 2024 23:36:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 21 Feb 2024 23:36:28 -0500
X-ME-Sender: <xms:TM_WZTIpyypMwzU17vUlc92fKMtZGqqa99ybYV3xaYZZ8PSYMeVJxQ>
    <xme:TM_WZXKSkV0wwFXTVKZH3EqDfgpggYDUIwSurssqe_j_0TxpNmKdr2l76Z5WEfpUc
    qA7OMtYzHxYdsgMyQ>
X-ME-Received: <xmr:TM_WZbseBnVH6BHDI-bjvPsqj0vlge_heb-jkLRVtKWg05shOHy4AlGn8439kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:TM_WZcaDfhazMZ-7Uzt2otggzeYYw9WobI0plgjD_XjxKRr8xAcz6A>
    <xmx:TM_WZabDDam6zYsjwfjAO6B-TCNLEtPryIrEyozc6BuikQIawhfDsQ>
    <xmx:TM_WZQAOkipDdOFkuvnsZmntpkTqdtcv0OQYDg8zAiMxHL5F7ZaMdQ>
    <xmx:TM_WZS6dLPMRtFUxAqX9MWhzhkXNKz35gWh3nY4k8G06LRChOjus6Bh3Cfg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 23:36:27 -0500 (EST)
Date: Wed, 21 Feb 2024 20:36:05 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	George Stark <gnstark@salutedevices.com>
Subject: Re: [PATCH 4/4] locking/rwsem: Make DEBUG_RWSEMS and PREEMPT_RT
 mutually exclusive
Message-ID: <ZdbPNV1qa2GBF8rj@boqun-archlinux>
References: <20240213031656.1375951-1-longman@redhat.com>
 <20240213031656.1375951-5-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213031656.1375951-5-longman@redhat.com>

On Mon, Feb 12, 2024 at 10:16:56PM -0500, Waiman Long wrote:
> The debugging code enabled by CONFIG_DEBUG_RWSEMS will only be
> compiled in when CONFIG_PREEMPT_RT isn't set. There is no point to
> allow CONFIG_DEBUG_RWSEMS to be set in a kernel configuration where
> CONFIG_PREEMPT_RT is also set. Make them mutually exclusive.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  lib/Kconfig.debug | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 975a07f9f1cc..cb695bc76d30 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1303,7 +1303,7 @@ config PROVE_LOCKING
>  	select DEBUG_SPINLOCK
>  	select DEBUG_MUTEXES if !PREEMPT_RT
>  	select DEBUG_RT_MUTEXES if RT_MUTEXES
> -	select DEBUG_RWSEMS
> +	select DEBUG_RWSEMS if !PREEMPT_RT
>  	select DEBUG_WW_MUTEX_SLOWPATH
>  	select DEBUG_LOCK_ALLOC
>  	select PREEMPT_COUNT if !ARCH_NO_PREEMPT
> @@ -1426,7 +1426,7 @@ config DEBUG_WW_MUTEX_SLOWPATH
>  
>  config DEBUG_RWSEMS
>  	bool "RW Semaphore debugging: basic checks"
> -	depends on DEBUG_KERNEL
> +	depends on DEBUG_KERNEL && !PREEMPT_RT
>  	help
>  	  This debugging feature allows mismatched rw semaphore locks
>  	  and unlocks to be detected and reported.
> -- 
> 2.39.3
> 


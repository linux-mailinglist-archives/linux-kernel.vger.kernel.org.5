Return-Path: <linux-kernel+bounces-77205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D59CB8601F9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC8E1C2673C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B6913791A;
	Thu, 22 Feb 2024 18:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WC59J1CU"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B6C125CE;
	Thu, 22 Feb 2024 18:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627955; cv=none; b=lY+pWwl4VEhmkKOdDxIlTsV99DkUXrLFSe3q2BTbynjSFcxsyAu3v4gGX1V9Um9OpnwsD3LDIyUS3aFtd0WeMiq1+CRqBv/fwVVDHdgOjuNVCnKv3VSDHEQwHcZc6sYE6wWjLzCQofATUFsxwFUDXfvNUSYrdghPT7LCqa4204I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627955; c=relaxed/simple;
	bh=qFHsc/9NAkYXAV27PGFm/SEzb1sXW7fFVpJitCHk1YY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuPt9Vvzyvk1Ur64SiwUifmsNN/dTDI1z3CZ05n4GjeUrSYu2dMi8nPZ9ON+MVYIQXTVm6+Mv+8e5t/81s1r/pDxOnDHPTK9SUn9iALqV2Sln8EHrlUTw1dpMXRoHzij/hXa4nZt2+OZp4U3ZuOnmM8vLaZR5ahVIq/VLjkRlzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WC59J1CU; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso24950a12.0;
        Thu, 22 Feb 2024 10:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708627953; x=1709232753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1yj780hLgcxxRzFrQjiMYOMZDjxU/tRVcygbZgcLUyg=;
        b=WC59J1CUaCzFiQXzSb49dL6AxbFuVXQaxUR9yCFlo6T4R4y0n2crpWnAanrUgAe4oD
         2vZZGZbg4jTuohdMHdZmskxFBt+1SHmwEBhOWr4I8u6Vw7Qktovr3Iutnv+gBDhdJbNL
         VKt2lcKKwKnXsdC+abgVQigoZHZTZdD+/E2txo5o2tFg4XvFv0lQYGgPyq0ZTsxhu+xH
         PqmD3MBHBy7RrNtQ7hCcZiMYDzAFblkp4+SupChRYiiy3YlV9CCeE1YLu4LyKGXHGmVr
         REjhggSbTQPfu8DDj6r1uqxMhSG5nfWH4wvmX1y3nuAJPPi1ZaRvAu2AN6RKrWt++XC1
         BMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708627953; x=1709232753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yj780hLgcxxRzFrQjiMYOMZDjxU/tRVcygbZgcLUyg=;
        b=VoJOo5NYOoUHB+djvWUx+/xiR1X/+F0MNx87mAV/1n7tW/FgjRrihlpOnKxPOZqPH7
         6XDTHIAZUWces6R2V+rZWbbiqXK6cf9FX+jHwTR7uQDl/ZP58jv5j5CcJAWJZNUtFigj
         w+bQkdDgYj5vU3QRYt+RmYSP2cRNxyW+W+gcB/ZHUdIes81tpZbf2fxWnIbenY1hf1Bc
         Y5VVQV5JdbyltmlIx45ExMqOXRcjmWnfXDt6v7qerW+AMqCMqahWFOhqeurn0DMDW+dG
         DOQ3/DNF9i7wsnsz/iP6gVUN34/g7gcqNHmJS+VRSSn24k8Afi5iYYR5DQUZ7JYamoct
         v33g==
X-Forwarded-Encrypted: i=1; AJvYcCUliS2Y86fhOoP7sPgu1Hs4UmFWtNmWwiR1gz5U3ZC46brGWIGB6s35uc1c5ZfMSvJ72pXMRd5wRMBP/yEHGKrOhEE77dbNPhbgqFcVx1qDgQQxCSJ5M6sIsFk4u0a5IS7m79bUhx0+
X-Gm-Message-State: AOJu0YwKC+0Z1eUD3vMmzE0drQWEGquVj1uz4nSYj+aRVi5CYWR5Hvv5
	YeEOXnicfCr6kuz5E2jZUka4ktDa5Wf4/za0xzmDRY/y29FscNLC
X-Google-Smtp-Source: AGHT+IHVxW4m7RkjhOqkIYdRdH6o807fm7UYiDq9BbKCjHZgfKL8U49QJCkZ2vuA3+7MHLUM3JsXOw==
X-Received: by 2002:a05:6a21:3994:b0:19e:bff0:c8fc with SMTP id ad20-20020a056a21399400b0019ebff0c8fcmr26701483pzc.56.1708627952779;
        Thu, 22 Feb 2024 10:52:32 -0800 (PST)
Received: from debian ([2601:641:300:14de:f32d:6b5:d03a:44f])
        by smtp.gmail.com with ESMTPSA id w16-20020aa78590000000b006e34e1aeee8sm10687511pfn.88.2024.02.22.10.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 10:52:32 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Thu, 22 Feb 2024 10:52:28 -0800
To: Ira Weiny <ira.weiny@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/trace: Fix uncorrectable macro spelling
Message-ID: <ZdeX7KRZmm35qwCY@debian>
References: <20240221-fix-correctable-macro-v1-1-6e6ab8b8aa39@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221-fix-correctable-macro-v1-1-6e6ab8b8aa39@intel.com>

On Wed, Feb 21, 2024 at 08:52:28PM -0800, Ira Weiny wrote:
> Uncorrectable is spelled with two r's.
> 
> Fix the macro spelling.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  drivers/cxl/core/trace.h     | 4 ++--
>  tools/testing/cxl/test/mem.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index bdf117a33744..577a01954f71 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -267,11 +267,11 @@ TRACE_EVENT(cxl_generic_event,
>   * General Media Event Record - GMER
>   * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
>   */
> -#define CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT		BIT(0)
> +#define CXL_GMER_EVT_DESC_UNCORRECTABLE_EVENT		BIT(0)
>  #define CXL_GMER_EVT_DESC_THRESHOLD_EVENT		BIT(1)
>  #define CXL_GMER_EVT_DESC_POISON_LIST_OVERFLOW		BIT(2)
>  #define show_event_desc_flags(flags)	__print_flags(flags, "|",		   \
> -	{ CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,		"UNCORRECTABLE_EVENT"	}, \
> +	{ CXL_GMER_EVT_DESC_UNCORRECTABLE_EVENT,	"UNCORRECTABLE_EVENT"	}, \
>  	{ CXL_GMER_EVT_DESC_THRESHOLD_EVENT,		"THRESHOLD_EVENT"	}, \
>  	{ CXL_GMER_EVT_DESC_POISON_LIST_OVERFLOW,	"POISON_LIST_OVERFLOW"	}  \
>  )
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 35ee41e435ab..c0c1e6b4db75 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -380,7 +380,7 @@ struct cxl_test_gen_media gen_media = {
>  			.related_handle = cpu_to_le16(0),
>  		},
>  		.phys_addr = cpu_to_le64(0x2000),
> -		.descriptor = CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,
> +		.descriptor = CXL_GMER_EVT_DESC_UNCORRECTABLE_EVENT,
>  		.type = CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,
>  		.transaction_type = CXL_GMER_TRANS_HOST_WRITE,
>  		/* .validity_flags = <set below> */
> 
> ---
> base-commit: a2cd3520e6085b0f9145d9c5e3d1bfa9cce4c3be
> change-id: 20240102-fix-correctable-macro-2847ce932c9c
> 
> Best regards,
> -- 
> Ira Weiny <ira.weiny@intel.com>
> 


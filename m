Return-Path: <linux-kernel+bounces-59681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 573CE84FA4C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA97128C3CA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53D97EF1B;
	Fri,  9 Feb 2024 16:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXxGrBbs"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938877E595
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497609; cv=none; b=QJ7beqAYZrbaj8O0NRLWLpZXenE1YA4kZgjsVzkLlcyJfkdDU9kMPGuyGpI5kRSngp0jMCzWnzhT1vEeSJNjGv4HnXPHW0hkp4Oe1jmX+/9owsezS4HrxmL1JGAzktUOrLOfQf6wLMXL4v6FlSbFFNDnr/qKHMayOgEuB4f+puw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497609; c=relaxed/simple;
	bh=uO5kYoC3bo7xTwFBFRcn43+lmo5ezhNGD0tC7gWALPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnfyFPsmHazyVZFOlQeLgYfeGhh2usTLbEiZnUcDAocKgaC30TWWYEg/FDxMjoznmLBvS7R4Ft3fw0o3WXaizGkbYF+FX7fZ5bNwrOvNCVSx9cpmWytvBppheXAuhf7w914sNqJiNPa8IZ0AC4Nyhf+CrBI5P4Jkd6qNZku4kK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXxGrBbs; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-60499a12ca0so12422947b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707497606; x=1708102406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0YeJ1Scdeu8JC0fSedQWunMCPmGv7Rv5FN5QxfX78yE=;
        b=QXxGrBbsEaVSUKLvCh9vY9nswvo5xRM9hUpjTWiaHZaQ/1NAwNw2/O3nfVuNWMmah2
         24b87eQL9OKv/SWt4wa+WXuP4qTc9CtVFsD/O6w2IqX9Z4uUb0aYFLxl+RS4K/BXv+Wr
         q8XL00p87gqqT52ZZO/bxeP6MFnTZwoRVkv0aPxVogbZTWM8T+En0sRwnOGMIC6U3o27
         2QtQ76U9l5iKb5WxWcOGQnzhlLGWBDd8GZMVJwyxBHh5DHLrjg7FkN4G7thKmcxlIrn2
         Gzx+FDLdvkpcJAtRrQ7QtbKQxxkj2KOHAg2RHn/RjGQZWwIOiP50eUidm99fbDwnBHRN
         M0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707497606; x=1708102406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YeJ1Scdeu8JC0fSedQWunMCPmGv7Rv5FN5QxfX78yE=;
        b=IbYaNyDzy31ONLDUqza2xeQMfaxr1L7UxMqrYtXHltjTWVj4U+qrukIWjlvWyW2TMu
         bsDjjkp8JGgmXDrRkZXPihTQMFgXySq4Jy3JUhtMRz51Ut/Q2s/6As7DcyjHn3g1kuIP
         FCrh+qCM0f8SRCKzKwazKmWwyjVJGxnlj2VbOvIRSdXYhfQvDVl3qzbj+V7HjU4pdkqO
         RQSovjWscePYFnQ7s3spgrQ4UChQ260BYUaz17ZGLGOYFOD0lpYdcIJk1LIBbQZrYKha
         mu2xL8NnHmiZorPYbv83b0pz0QWzKm+wzBV4M/bLztixVh0n9E4LtFhsSp52keQ4w4Gq
         57CA==
X-Gm-Message-State: AOJu0YxNYU59MLZAADCo3ghdRlHjxJSNaHJY8kgrCtGrlkMcC0YXCCLU
	PxgX8mkEgV8NsD17uVXIpgQudhyhdla2rn1CmE7cVi/cvxMDftZx
X-Google-Smtp-Source: AGHT+IHrF/8wgQd8JNTUcMtQGIGtbwT7TsJq0XQLER+HELEUGnHbgwEyGR8OSowd2xtSlMfgTxJ8oA==
X-Received: by 2002:a81:8541:0:b0:604:aaac:99f7 with SMTP id v62-20020a818541000000b00604aaac99f7mr1933729ywf.37.1707497606183;
        Fri, 09 Feb 2024 08:53:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUm/ZAq2lpYcT7dz8z8nZVu6F1n/rO1gEfLAC5EvkaTQlVEvagzv67AwSjqvZ2iBWBS6mgBykFYKG5VO7aeJhbTvhEuFSLJJ6q2ZyizC2xlwYJSNYNlTqR8rFAuxG2r71EiJu4fl2YHgkcKSORZ5MZ+U/t5ozjwe8m2eDJjwQAWIFy6XhRCB22wMTK5oeEcsJoSXFwITHJmf7AFR3Vnnqnm3Kdhkyd8G5XqPvv+cHpTcegoufYgIzK2Wg1+h95DlLusLABVfgwftTwwTkrrZNH5okindowqDagtKUTQReqod4NiM52SmLw=
Received: from localhost ([2601:344:8301:57f0:be3a:6fd4:1110:3284])
        by smtp.gmail.com with ESMTPSA id x7-20020a814a07000000b006040a13db84sm384525ywa.48.2024.02.09.08.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:53:25 -0800 (PST)
Date: Fri, 9 Feb 2024 08:53:25 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v3 2/3] bits: Introduce fixed-type BIT
Message-ID: <ZcZYhZbLyzSXX8PU@yury-ThinkPad>
References: <20240208074521.577076-1-lucas.demarchi@intel.com>
 <20240208074521.577076-3-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208074521.577076-3-lucas.demarchi@intel.com>

On Wed, Feb 07, 2024 at 11:45:20PM -0800, Lucas De Marchi wrote:
> Implement fixed-type BIT() to help drivers add stricter checks, like was
> done for GENMASK.
> 
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> Acked-by: Jani Nikula <jani.nikula@intel.com>

So I get v1 from Jan.23 in my mailbox, and this one is v3. Did I miss
a v2? Anyways, please bear my reviewed-by from v1 for this patch.

Thanks,
Yury

> ---
>  include/linux/bits.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/include/linux/bits.h b/include/linux/bits.h
> index bd56f32de44e..811846ce110e 100644
> --- a/include/linux/bits.h
> +++ b/include/linux/bits.h
> @@ -24,12 +24,16 @@
>  #define GENMASK_INPUT_CHECK(h, l) \
>  	(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>  		__is_constexpr((l) > (h)), (l) > (h), 0)))
> +#define BIT_INPUT_CHECK(type, b) \
> +	((BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> +		__is_constexpr(b), (b) >= BITS_PER_TYPE(type), 0))))
>  #else
>  /*
>   * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
>   * disable the input check if that is the case.
>   */
>  #define GENMASK_INPUT_CHECK(h, l) 0
> +#define BIT_INPUT_CHECK(type, b) 0
>  #endif
>  
>  /*
> @@ -54,4 +58,17 @@
>  #define GENMASK_U32(h, l)	__GENMASK(u32, h, l)
>  #define GENMASK_U64(h, l)	__GENMASK(u64, h, l)
>  
> +/*
> + * Fixed-type variants of BIT(), with additional checks like __GENMASK().  The
> + * following examples generate compiler warnings due to shift-count-overflow:
> + *
> + * - BIT_U8(8)
> + * - BIT_U32(-1)
> + * - BIT_U32(40)
> + */
> +#define BIT_U8(b)		((u8)(BIT_INPUT_CHECK(u8, b) + BIT(b)))
> +#define BIT_U16(b)		((u16)(BIT_INPUT_CHECK(u16, b) + BIT(b)))
> +#define BIT_U32(b)		((u32)(BIT_INPUT_CHECK(u32, b) + BIT(b)))
> +#define BIT_U64(b)		((u64)(BIT_INPUT_CHECK(u64, b) + BIT(b)))
> +
>  #endif	/* __LINUX_BITS_H */
> -- 
> 2.43.0


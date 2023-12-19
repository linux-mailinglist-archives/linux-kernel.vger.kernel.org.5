Return-Path: <linux-kernel+bounces-5711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A664818E73
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CC83B22765
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0152D347BA;
	Tue, 19 Dec 2023 17:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+6S1bPD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD7C31755;
	Tue, 19 Dec 2023 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6d7f1109abcso1563124b3a.3;
        Tue, 19 Dec 2023 09:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703007855; x=1703612655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mVKQ0en2H6Uqfs9Vm0NJFXhFRX26npxXU+VQ3IHe6pk=;
        b=P+6S1bPD8lEDxTHBT4hoUYq9VFeY34c8byLXnyJYzemfruniFxl6xqNJfjL8tflrn7
         mO8iA/3a8CNpxCxoqUffyAvOxuSssEa8DyqQy6rOEsesSFUjAubFknnOqjxRkZ/z2MKy
         3drWMV2afhS7meMEs6JvulD7tedwtS/6oxfzxiHiaYb1LK2w+fb0fOSkcIYQAsiZLHaD
         QV6kugfyGNyELk1QAmBSCArzTy9DU8ESrlfErkiFE+Yh9UqN6MaRWgLfIAoMw8G8ktXw
         Jcmlf3apoGq3S12rdTxvOrZzCuvuKAif1eZ1opw0YkKEsRR87HNWD9hUOl0VK2yrwkWT
         nWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703007855; x=1703612655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVKQ0en2H6Uqfs9Vm0NJFXhFRX26npxXU+VQ3IHe6pk=;
        b=gcsxj4qeMRTTIBst92yKulh1O3Qy+fasD7yTkbkf+yVRo3dYX/H8jN4m5NsxLUERYM
         T/vB5Urd6GqqKdBkZHl4MzVU9NE2xcu+T+ykGqEfGeFC2B2VW1keUe7Y2LNlFqdme6Pq
         MSyiWv9Rq7tAPPoQlNZ7rZqR8xd5mbVkrvr9hGci5Na6Wx5ckZVT0YhE+24IbG14Mll4
         BMLAmMQZOERD7HLbJYcNm3bFi3EtzRUBhpFdIVXpsPHAiGEPxyL8CUZUfdDCtHNkJ6pO
         +Y1ZYRHlt9qmLO9tzBLxY97tB07dDXot99UtVChEWFhneeRjfuRwYIwtihDVawvq8B4v
         pBMA==
X-Gm-Message-State: AOJu0YyV8MsYc38UC7OHVtUZqj6AC6H2KOxUMBpYnhbftvQSAgRNIwTS
	bCwH0QqIgh63P2y7QfddPCc=
X-Google-Smtp-Source: AGHT+IFYdtftIPLeSHPVTQNtvdr5UqL4QFgCkNyrOljNzgG46TSDzLcuhIcmDPH+g32MS7JYUmbILQ==
X-Received: by 2002:aa7:8b12:0:b0:6d2:65bd:a16a with SMTP id f18-20020aa78b12000000b006d265bda16amr4273532pfd.18.1703007855268;
        Tue, 19 Dec 2023 09:44:15 -0800 (PST)
Received: from debian ([177.240.14.150])
        by smtp.gmail.com with ESMTPSA id h14-20020a056a00218e00b006d7dd95064fsm3816052pfi.220.2023.12.19.09.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:44:14 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 19 Dec 2023 09:44:06 -0800
To: Ira Weiny <ira.weiny@intel.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Fan Ni <nifan.cxl@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
Subject: Re: [PATCH v2 1/2] cxl/cdat: Handle cdat table build errors
Message-ID: <ZYHWZjsnQwcBEDpd@debian>
References: <20231117-fix-cdat-cs-v2-0-715399976d4d@intel.com>
 <20231117-fix-cdat-cs-v2-1-715399976d4d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117-fix-cdat-cs-v2-1-715399976d4d@intel.com>

On Wed, Nov 29, 2023 at 05:33:03PM -0800, Ira Weiny wrote:
> The callback for building CDAT tables may return negative error codes.
> This was previously unhandled and will result in potentially huge
> allocations later on in ct3_build_cdat()
> 
> Detect the negative error code and defer cdat building.
> 
> Fixes: f5ee7413d592 ("hw/mem/cxl-type3: Add CXL CDAT Data Object Exchange")
> Cc: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  hw/cxl/cxl-cdat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
> index 639a2db3e17b..24829cf2428d 100644
> --- a/hw/cxl/cxl-cdat.c
> +++ b/hw/cxl/cxl-cdat.c
> @@ -63,7 +63,7 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
>      cdat->built_buf_len = cdat->build_cdat_table(&cdat->built_buf,
>                                                   cdat->private);
>  
> -    if (!cdat->built_buf_len) {
> +    if (cdat->built_buf_len <= 0) {
>          /* Build later as not all data available yet */
>          cdat->to_update = true;
>          return;
> 

The fix looks good to me. Just curious how to really build cdat table
again when an error occurs, for example, the memory allocation fails.

Fan
> -- 
> 2.42.0
> 


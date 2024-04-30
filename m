Return-Path: <linux-kernel+bounces-164784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B320C8B82D0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 00:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524F01F23F30
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA35A86126;
	Tue, 30 Apr 2024 22:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NV7bh0xT"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDDA1B806;
	Tue, 30 Apr 2024 22:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714517773; cv=none; b=XSkV6CkW2Ye3pjExi3GsVM39ZM/Iku9lJffoT667aXhGOMQ6eWj4ZA86lv1ziSHgMD3aR73c+LEAm2KWUziytTeGJMplWBZqAixAqc1PulMIHcBsjX0QfnRBNiIsxMH6e2/dUJ0Jq19NBrEOnCvm7tVcOMXA+dSIn0ICGNnX3z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714517773; c=relaxed/simple;
	bh=7CoAfxPnaArb0ZA8kJv4JzOFvKITr9J3FcOwlllSr8w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WG2mmZb3BkmaUTxj8cvYjpLtJ5B5On+uachsPG3wUcOC3tBiUyOXka44WzXYMjWjmPaZZU1mpG+caBW4O30sEfGe0jPGl9FHQeiZ0Ty0Bge7sughwiNVUl3k56beCfvYOn6w9dt+G0uMBoNxNW8LVFm1YHZTfKQcF6B3KMjKxao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NV7bh0xT; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ec4dd8525cso9761335ad.3;
        Tue, 30 Apr 2024 15:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714517771; x=1715122571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Veyz6JUTol4w3y2OGMosN5q47FoqpORfwva9+IEnyHk=;
        b=NV7bh0xTK5PlfoYq9xWIxF8cS/J4hEagsfmmLd4MD6rnJ4mHCt1Q6BDrhvvI/p/2ct
         WnqbPlv6z2HP49D3SK0MTzZk7BreP9Tj4FKXj7w1PmqyAUvPUEXKETaqdCJ+7iHG8YQS
         8wDkuXR/iaWIhFp6RV2HR0UYTcNLi9SlsRD7G5xAqJypJoT2OoJMPtbPHBq9dAq7xB9O
         W5arXIn+hQ/b6UWAlt5FNUqidkdqVWhUgQ7RlhZSVP0HOls47hWVQoptBz6tNLzmWi5u
         AmvZWOTMI4d9Pn9OYQOecfoBJ0xNoY3aRK0jW4OV4Z6JPSXI0Dj47XabIGN1y0n/itNT
         o63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714517771; x=1715122571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Veyz6JUTol4w3y2OGMosN5q47FoqpORfwva9+IEnyHk=;
        b=iti5fFQCR2g7FFHC4gphp9+XlYaKK2aP8yJsG2938X0JSSTL+DShsm4JtLdFl+A8DS
         KXxZiS+xKFesQC+xxBbwfrwn1LbW5dBmEKpz43BGU21m9cH8ynvTkZ+Pzq9qpGDDlwJJ
         S9U8tY0J6niKqzqf7QjrJGF6Ofv9n3dgk7XgSnk9Jj6kX5NN96QjjfGuRSOW2rHK0QBl
         L9D636H1/7UdLLvb9fOoA32trKkmmqCD+++om0ETVRaW2OhHzere0X7/tYDnhTJRsl4M
         h3HbZFMq/DK1gJosnskyzBtICEG/nknJH5SjS/nKF7ESmEzxM/OUD7SyQWl1X4aPvr8d
         Jx1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSE2XkndadtPHeSFnYvSxvSHVC0w+Lzy50b5U/mZocFNbJA8L6m4D0nIy9iB4aODMeE6De/1hhpf0rS0N0+j5wxuzajAPeDMGkocb436iipoux5UsQvrEvhqZmjqILnBrbNjdx9YN9
X-Gm-Message-State: AOJu0Yxhf4kEzO2M+dpjzwmCWIqfFwBWJDGXMCFvFQkXtXqclQIN9+Ll
	SOJ3H34mJNC+CKpVulmakL6e4tILs6ISNjF7jdgltQHXSMngt9H2
X-Google-Smtp-Source: AGHT+IFk3FGttA19d4bBfU+VBMedCxAAEOTaH+klHLjfQ1aQ+VqJ4YWLp2T/ZlCdTJAjzA7nGb7Pbw==
X-Received: by 2002:a17:902:d38d:b0:1e7:b6f4:971 with SMTP id e13-20020a170902d38d00b001e7b6f40971mr753885pld.27.1714517771009;
        Tue, 30 Apr 2024 15:56:11 -0700 (PDT)
Received: from debian ([2601:641:300:14de:9960:3485:279e:a1e0])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902bd8500b001db8145a1a2sm22847272pls.274.2024.04.30.15.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 15:56:10 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 30 Apr 2024 15:55:59 -0700
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/region: Fix cxlr_pmem leaks
Message-ID: <ZjF2_0epRVOrgtV-@debian>
References: <20240428030748.318985-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428030748.318985-1-lizhijian@fujitsu.com>

On Sun, Apr 28, 2024 at 11:07:48AM +0800, Li Zhijian wrote:
> Before this error path, cxlr_pmem pointed to a kzalloc() memory, free
> it to avoid this memory leaking.
> 
> Fixes: f17b558d6663 ("cxl/pmem: Refactor nvdimm device registration, delete the workqueue")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  drivers/cxl/core/region.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 5c186e0a39b9..812b2948b6c6 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2719,6 +2719,7 @@ static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
>  		if (i == 0) {
>  			cxl_nvb = cxl_find_nvdimm_bridge(cxlmd);
>  			if (!cxl_nvb) {
> +				kfree(cxlr_pmem);
>  				cxlr_pmem = ERR_PTR(-ENODEV);
>  				goto out;
>  			}
> -- 
> 2.29.2
> 


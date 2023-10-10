Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4517BFDA2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjJJNgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjJJNgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:36:47 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBE2CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:36:45 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-406619b53caso52544775e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696945004; x=1697549804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BmUolm1QSdNeTrqOVAQPrq9kGFBVTiJa2lpVnk3jmBI=;
        b=B5QN1hjqEHaEa6rlCC6sKZZhpOH4S/c+rQsg1Wwf5mPoZB5RJSZwZR+XCNQ1mYKMal
         Ap9acoUDBqiQYz/Er5TGYMb4hdQr5sv5WOi9nH5bSPuQ1MAW9XjPdg/sCc+CAsD/IEPk
         8lGrOSZrp8TDLmHBZGAD7GFYLqgQAu6oe3FusgeVuafzD34Vgx4J1nOdq1NzYWHOIX7m
         3O9AEg8g6qHICKHkpUabrsCLVKm5XBpre6bLQUtBjL5P+5lhD46KVGwFAokfm79SEuHW
         yVmQdGDhT3EsfgPf3K6IU48gpGXXZUjSD1QZGG/mVAaxjCAu6Yl4uBMZNZfuf4SJg/fI
         SCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696945004; x=1697549804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmUolm1QSdNeTrqOVAQPrq9kGFBVTiJa2lpVnk3jmBI=;
        b=AoDNCG6vdW1b8Tc2/not1DTnwjmypGYHpExpn2a+o7bH8npBu9YDwAyX9IUTSzbK3C
         CXjYG9pJKpgu3IzcOiZcjS/A0nq4MO4z2t5qb37nKeCw9IvyOBtXDqZHnzbt+Lr6pszg
         9tRQGufkG5HspFnFSppmSdPG3GhLRqovEkOSGpqcSxzKeNrpaCILVilChaxkNyuwj2hl
         /iBXiH2kMNCLjPHjv9EAQ7fpgTfITzUiIIjHInlVDhunNnLm1cH0eCiASb0TZGhaEVRt
         1k8BzLurlraBXIlmw5EiGawnpPHfR6Y1aaxh0cw5VFvzMr56ilxQBe78ZgT8NK8JPjQd
         u2mw==
X-Gm-Message-State: AOJu0YxFL9JzuPqM4Deg0PnNvz1sa//QY85EJZrdROrhdLqIJQgWHa6y
        JAHhFSEsk6Iqk7mL/JIpwtrGBg==
X-Google-Smtp-Source: AGHT+IHXwKtrRxLqgdq4AfzMyWp6S9vbUS+FM9ayQpgPUAK4Eah+7xzWBZhlrzBTdjuZoJ3DKx6Icw==
X-Received: by 2002:a05:600c:224a:b0:3fe:dcd0:2e32 with SMTP id a10-20020a05600c224a00b003fedcd02e32mr15632141wmm.19.1696945003617;
        Tue, 10 Oct 2023 06:36:43 -0700 (PDT)
Received: from myrica ([2a02:c7c:7290:b00:fd32:2b31:6755:400c])
        by smtp.gmail.com with ESMTPSA id z7-20020a7bc7c7000000b003fee567235bsm16493195wmk.1.2023.10.10.06.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 06:36:43 -0700 (PDT)
Date:   Tue, 10 Oct 2023 14:36:49 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] iommu/virtio: Add __counted_by for struct
 viommu_request and use struct_size()
Message-ID: <20231010133649.GA2902909@myrica>
References: <ZSRFW0yDlDo8+at3@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSRFW0yDlDo8+at3@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 12:24:27PM -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> While there, use struct_size() helper, instead of the open-coded
> version, to calculate the size for the allocation of the whole
> flexible structure, including of course, the flexible-array member.
> 
> This code was found with the help of Coccinelle, and audited and
> fixed manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/virtio-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 17dcd826f5c2..379ebe03efb6 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -85,7 +85,7 @@ struct viommu_request {
>  	void				*writeback;
>  	unsigned int			write_offset;
>  	unsigned int			len;
> -	char				buf[];
> +	char				buf[] __counted_by(len);
>  };
>  
>  #define VIOMMU_FAULT_RESV_MASK		0xffffff00
> @@ -230,7 +230,7 @@ static int __viommu_add_req(struct viommu_dev *viommu, void *buf, size_t len,
>  	if (write_offset <= 0)
>  		return -EINVAL;
>  
> -	req = kzalloc(sizeof(*req) + len, GFP_ATOMIC);
> +	req = kzalloc(struct_size(req, buf, len), GFP_ATOMIC);
>  	if (!req)
>  		return -ENOMEM;
>  
> -- 
> 2.34.1
> 

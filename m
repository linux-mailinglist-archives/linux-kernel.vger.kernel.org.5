Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D87F7FE0F4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbjK2U0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbjK2U0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:26:11 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79C0D7F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:26:17 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1f03d9ad89fso61228fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701289577; x=1701894377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x6z49foDTI0A8Rsez/QUHUM8NOSZc6Sqb1M2eWkhgNk=;
        b=Z5UYTm/JjnG8RL34ads3YenjU9zKPt5R1iIECDvPOAWJKQbiYyZeEJwq4nc7a7aoCc
         meT0ru+roVoQc55D8wwhTjhMj5K6jzTK/Lki+LGtjt7uty7hzW59ENx0J8yTxp4EhAyU
         JRkK3PhBXlNv5Ej0pUaTMJOHziEHq2WgdmhE7hwFIRkJWwFmUvH+3LrkrungtvJ/XvFd
         15ove8Z8aK0idhFK19JJgLxKuNnOC9vGMmlvql8STiig8coQvsE/W7TC20xnZKdx7saA
         N0QgjENtDlDcwAmnCAxU6CRda/QIUmIK2P3cJiHw4D/xzDPpWhgiLxSCb+NL5yFAS8Ok
         qgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701289577; x=1701894377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6z49foDTI0A8Rsez/QUHUM8NOSZc6Sqb1M2eWkhgNk=;
        b=QtbpEsu+P5dDkoM1QPdYeQPe1tKXGHo/4Saf/j5WeAhH5DDgpFblFex1GfDgegpgb8
         ZOuKFxkBZIEayb9MXFxqh9EjRyaZ4mPEjNGSaeZhnkrAWu1m7X+jkzlbQ1wNPuAiEmQk
         xsv4bKBfoaNKv5Zvx2y4TtvmHCgns6IkQmMcz4U32zHGnaycaVDDWiP06Yk+pmlBYPTo
         tkAR1XqUQqfdjFHR40XGPyFwDMPdhlCId6kJgtixRg5O4tgAV1924EVxpDHdi/Sm61lL
         C7afXWC6EJRXxw5HyWy6782bxha2iPvyoeoTwGzboKibpJtx2EsW+4VSbklcC8AhvEgX
         zHEw==
X-Gm-Message-State: AOJu0YxY2TFA2Il57GwQl1Ief3unZUCrc5O+XPXU3/C01oPWhxvs5YIl
        Z/ysQuGVH35qsD4HWnxj7OaZeA==
X-Google-Smtp-Source: AGHT+IFVTteECB+xmpu720088oIMXevUkET4BohI67g+jhntOHO27CDgUE+PEhM0GKWy+AP5H7nPKQ==
X-Received: by 2002:a05:6870:b05:b0:1fa:31a1:487c with SMTP id lh5-20020a0568700b0500b001fa31a1487cmr20181244oab.47.1701289577175;
        Wed, 29 Nov 2023 12:26:17 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id be5-20020a056830350500b006d6496747b6sm2115087otb.80.2023.11.29.12.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 12:26:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r8R8R-005pZh-Up;
        Wed, 29 Nov 2023 16:26:15 -0400
Date:   Wed, 29 Nov 2023 16:26:15 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] iommu/vt-d: Add support for static identity domain
Message-ID: <20231129202615.GN1312390@ziepe.ca>
References: <20231120112944.142741-1-baolu.lu@linux.intel.com>
 <20231120112944.142741-5-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120112944.142741-5-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 07:29:43PM +0800, Lu Baolu wrote:

> @@ -2311,6 +2316,13 @@ static int device_def_domain_type(struct device *dev)
>  			return IOMMU_DOMAIN_IDENTITY;
>  	}
>  
> +	/*
> +	 * Hardware does not support the passthrough translation mode.
> +	 * Always use a dynamaic mapping domain.
> +	 */
> +	if (!ecap_pass_through(iommu->ecap))
> +		return IOMMU_DOMAIN_DMA;
> +

Doesn't this return from def_domain_type completely prevent using an
identity domain?

I thought the point of this was to allow the identity domain but have
it be translating?

Jason

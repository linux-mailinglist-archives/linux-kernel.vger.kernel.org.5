Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F98F811D49
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379128AbjLMSs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjLMSsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:48:25 -0500
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434FBE4;
        Wed, 13 Dec 2023 10:48:32 -0800 (PST)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d35dc7e1bbso5244025ad.1;
        Wed, 13 Dec 2023 10:48:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702493311; x=1703098111;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mgP80Yyu6IvFK797HjxiOfl5XynuTDj7ZNa6KXUx8cI=;
        b=ktdZTHfwEv+bA0TgZ7zJGQ8ma2s5oIYtrDSMYzYfwLPl7Sv6M+Vy/b695rFLtpSf+v
         H/co8NvXeq+MTPJnZD6BPRP35qrqpyxE/fnVqfTylTnPVuMm4gJzxHSSI3+loyGyCkcX
         R9BWPvOeQHkwwcOzkUuZ9Juu5WzUyMZClKwp2FhaIK1YQdwS5PYDQeN6uCsdtG3H3Vie
         gzGkN8wcqnCfkyCo1WxOlkwEtcrUaCYzecN0RUDk8h55uNzmyMLHqt1fhfBREWkBYc+Z
         tpICZoPzhkbkGG8RHq40kTgUOiqPGRB8S4HlDmUxJg4wP4/XoCezZpLtNR5Gbiq+S+h9
         VMhA==
X-Gm-Message-State: AOJu0Yz/s7kDI93cS9qBp3yWZF3cs6i9n4VOKKVYamQl/3ICoxYocCK8
        meKvKazUd68H0N99whfW/z0=
X-Google-Smtp-Source: AGHT+IEzlIEd9Q6eLCCZLjW8OK193jqfOJ0Gqr0iKW0nJNMRppuRTXGR720gnDCd+2nqnislHC1Peg==
X-Received: by 2002:a17:902:ec8a:b0:1d0:d18c:bc5a with SMTP id x10-20020a170902ec8a00b001d0d18cbc5amr10203494plg.121.1702493311471;
        Wed, 13 Dec 2023 10:48:31 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709027fce00b001cf8c062610sm11107415plb.127.2023.12.13.10.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 10:48:30 -0800 (PST)
Date:   Thu, 14 Dec 2023 03:48:29 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, kishon@kernel.org, bhelgaas@google.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] PCI: epf-mhi: Enable MHI async read/write support
Message-ID: <20231213184829.GA924726@rocinante>
References: <20231127124529.78203-1-manivannan.sadhasivam@linaro.org>
 <20231127124529.78203-7-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231127124529.78203-7-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Manivannan, you will be taking this through the MHI tree, correct?

> Now that both eDMA and iATU are prepared to support async transfer, let's
> enable MHI async read/write by supplying the relevant callbacks.
> 
> In the absence of eDMA, iATU will be used for both sync and async
> operations.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/endpoint/functions/pci-epf-mhi.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> index 3d09a37e5f7c..d3d6a1054036 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -766,12 +766,13 @@ static int pci_epf_mhi_link_up(struct pci_epf *epf)
>  	mhi_cntrl->raise_irq = pci_epf_mhi_raise_irq;
>  	mhi_cntrl->alloc_map = pci_epf_mhi_alloc_map;
>  	mhi_cntrl->unmap_free = pci_epf_mhi_unmap_free;
> +	mhi_cntrl->read_sync = mhi_cntrl->read_async = pci_epf_mhi_iatu_read;
> +	mhi_cntrl->write_sync = mhi_cntrl->write_async = pci_epf_mhi_iatu_write;
>  	if (info->flags & MHI_EPF_USE_DMA) {
>  		mhi_cntrl->read_sync = pci_epf_mhi_edma_read;
>  		mhi_cntrl->write_sync = pci_epf_mhi_edma_write;
> -	} else {
> -		mhi_cntrl->read_sync = pci_epf_mhi_iatu_read;
> -		mhi_cntrl->write_sync = pci_epf_mhi_iatu_write;
> +		mhi_cntrl->read_async = pci_epf_mhi_edma_read_async;
> +		mhi_cntrl->write_async = pci_epf_mhi_edma_write_async;
>  	}

Looks good!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof

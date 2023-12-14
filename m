Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BCC8126DB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 06:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443167AbjLNFTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 00:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443171AbjLNFTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 00:19:22 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15711113
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 21:19:28 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b9e2d50e61so5384669b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 21:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702531167; x=1703135967; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ebgC6Es1TWLTrA7P861m7mbGtvNZNIYlwsAipKfKxek=;
        b=isAl+ThAtprMNGNTOz2hovcbI39ECXCm7OFgUmiSqR43kkR0Q7NY8JmymvKK+zDpRQ
         kFMGP0FwhszabqZJtZ9VRl/Izjnl3yuWJqvrs40P6VXPoFPtAy7V22sW/wB13eqIE6/B
         6+KkGHkZdsvsNjDWuFEmkc72rXOiq3uW7K4O0mc60wZlpo8AJqQ2ewmPtoGDJBIJK4B4
         rD+1PJzq5zGsB8xpiT6rx0JjHqnuiBKY7gF6gGdsFZpq5p3tQ2XDhT+9Ex4hg7Q4LWcs
         4S5wqa4+MpZSkU+sx91h3LL7VsHtIcA388q735okyZEnuXljsZYvPn0HPHFwE1liPY2k
         9a/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702531167; x=1703135967;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ebgC6Es1TWLTrA7P861m7mbGtvNZNIYlwsAipKfKxek=;
        b=kWP4ul31yAT5hXg1n/otyy86obXJSkmm+XXAWiMibkonSymHJKUuKtCwIDdT2ewV4N
         sRLQ2meK4gVKQUbVae/K86QTv84rTfpofk0E9pdRYV3+4QhKfD3Deg3Kfy6l9iSLhnjE
         AflgLp0yTQ8ukKniRuUT9FPw2BR8v5R+QYg8mCnYyI2Aobu088BqX1fs7HrehCPChDCS
         ukBMbQ+eMgH5JkYtynh0Tn8wX2r3EzDpL59KzG2uvf3qSOWZ+tkrC0SWcfhEkF5cL99J
         qhgFWHAsZEEnhD5SvS5JsrY7JUEyk/BCatBzqUW+k1ukf0qJbLbgUCQE40imclfcQfra
         9SVg==
X-Gm-Message-State: AOJu0Yzy4KdXJGJMDEsgC3L2Sb6/xh+Syhj+GPQgJaSO/2NQhTFBsLrl
        7jOViitljdD/ozeO6SKhdRIdApRzNnm8zvo4mw==
X-Google-Smtp-Source: AGHT+IGW3pZ0FDvERci6/aHUcc+KUUP8SedVgnuilbHTJ7cbeMfPq5P/+/TASqLl0smV5t/gXrvQNA==
X-Received: by 2002:a05:6808:1686:b0:3b2:c242:aaee with SMTP id bb6-20020a056808168600b003b2c242aaeemr11190614oib.42.1702531167246;
        Wed, 13 Dec 2023 21:19:27 -0800 (PST)
Received: from thinkpad ([117.213.102.12])
        by smtp.gmail.com with ESMTPSA id sm5-20020a17090b2e4500b002867f87d103sm12049902pjb.50.2023.12.13.21.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 21:19:26 -0800 (PST)
Date:   Thu, 14 Dec 2023 10:49:19 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     lpieralisi@kernel.org, kishon@kernel.org, bhelgaas@google.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] PCI: epf-mhi: Enable MHI async read/write support
Message-ID: <20231214051919.GE2938@thinkpad>
References: <20231127124529.78203-1-manivannan.sadhasivam@linaro.org>
 <20231127124529.78203-7-manivannan.sadhasivam@linaro.org>
 <20231213184829.GA924726@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231213184829.GA924726@rocinante>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 03:48:29AM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> Manivannan, you will be taking this through the MHI tree, correct?
> 

Yes, to avoid conflict with other MHI patches, I'm taking this series through
MHI tree.

> > Now that both eDMA and iATU are prepared to support async transfer, let's
> > enable MHI async read/write by supplying the relevant callbacks.
> > 
> > In the absence of eDMA, iATU will be used for both sync and async
> > operations.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-mhi.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > index 3d09a37e5f7c..d3d6a1054036 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > @@ -766,12 +766,13 @@ static int pci_epf_mhi_link_up(struct pci_epf *epf)
> >  	mhi_cntrl->raise_irq = pci_epf_mhi_raise_irq;
> >  	mhi_cntrl->alloc_map = pci_epf_mhi_alloc_map;
> >  	mhi_cntrl->unmap_free = pci_epf_mhi_unmap_free;
> > +	mhi_cntrl->read_sync = mhi_cntrl->read_async = pci_epf_mhi_iatu_read;
> > +	mhi_cntrl->write_sync = mhi_cntrl->write_async = pci_epf_mhi_iatu_write;
> >  	if (info->flags & MHI_EPF_USE_DMA) {
> >  		mhi_cntrl->read_sync = pci_epf_mhi_edma_read;
> >  		mhi_cntrl->write_sync = pci_epf_mhi_edma_write;
> > -	} else {
> > -		mhi_cntrl->read_sync = pci_epf_mhi_iatu_read;
> > -		mhi_cntrl->write_sync = pci_epf_mhi_iatu_write;
> > +		mhi_cntrl->read_async = pci_epf_mhi_edma_read_async;
> > +		mhi_cntrl->write_async = pci_epf_mhi_edma_write_async;
> >  	}
> 
> Looks good!
> 
> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
> 

Thanks!

- Mani

> 	Krzysztof

-- 
மணிவண்ணன் சதாசிவம்

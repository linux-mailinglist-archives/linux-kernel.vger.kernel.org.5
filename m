Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC18812C86
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443551AbjLNKJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443503AbjLNKJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:09:37 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FABBD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:09:43 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6cebcf8a48aso6715023b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702548583; x=1703153383; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WWNR+uChpD2XCXHiRI7apkxqBy405ej3EqIXUwuAYoY=;
        b=JMKhkrudGBgnElxQGlQTxUO2CM6RMZzBPWNxIl3d1beMbjshgWsQMUMMciYIQc6uOx
         LvpUqdMW/CLRrG0uRxKT8PCAz4SkiN44dN6gLO3EXEpUjsOblZULrMEzmPc0c+vh++iU
         dWQPKJD/oKfWh2r8wSC/DICoVyoZmjfvIDOzSpdVGrKzclcGaxOxh+KwhJo3pNtqjKIs
         Fw0rH6JGw7qJ/gUMcQW9fd3tAxPcrkWqDxv9oFK+3+wSGP210smgcBdnXc4JZoXwWajV
         2ccAr9OyCyCc+xP5OnpE0Pqgr4l9vwAYkHP13eg6C3wR8Ro3GN0GWnZ4NDMfW66dljV7
         fLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702548583; x=1703153383;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WWNR+uChpD2XCXHiRI7apkxqBy405ej3EqIXUwuAYoY=;
        b=VRsAuAF2Vz6+nQx9qr2VFqKvf8hMK7SVlJr6CJfbY72aWxE28YfJEf1KC1mcOGplvq
         bjXAxHcr4aAEgiOCyEK+DL1qiho1ibmCs6O965m/FNCU4rywtAdWgPwMqzgnEW1C3ZTs
         6b4sBS8+FfGNZtFCOPexQV6I+F+bxiNf05vHO3GUGQVXoJD8OXZtvgGR9Z1qb6qDESHx
         lKeXNR6Q3A8IyQFa+JDCPuRqGUkXgyyFqQqOrRKZNxT+qQDB0OMbja2ZfdauipD9kAlw
         E9aUCEyfUyVW/kTqQwHLNNqJ+94z5hcebx+hiVWmxPszEBkU7wOV0+8G6PVIdbBS0W0G
         UfAw==
X-Gm-Message-State: AOJu0YzM9nG/tZeIErqXIDOrBAA2uyYhfHo62ihloB05gpPFY+qv0BKS
        kZtleFcA8Em9PC8qlDLy9u2n
X-Google-Smtp-Source: AGHT+IFoBTL8upshvJpDsA2gdrqL9OnkLrHFDhbqOefDhz6lfrJvqtCI/Af60s/auvjujU8gBjKneQ==
X-Received: by 2002:a05:6a00:2195:b0:6ce:6518:702f with SMTP id h21-20020a056a00219500b006ce6518702fmr11386629pfi.28.1702548583327;
        Thu, 14 Dec 2023 02:09:43 -0800 (PST)
Received: from thinkpad ([117.216.120.87])
        by smtp.gmail.com with ESMTPSA id ca40-20020a056a0206a800b005897bfc2ed3sm9703702pgb.93.2023.12.14.02.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:09:42 -0800 (PST)
Date:   Thu, 14 Dec 2023 15:39:36 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, kishon@kernel.org,
        bhelgaas@google.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] PCI: epf-mhi: Enable MHI async read/write support
Message-ID: <20231214100936.GI2938@thinkpad>
References: <20231127124529.78203-1-manivannan.sadhasivam@linaro.org>
 <20231127124529.78203-7-manivannan.sadhasivam@linaro.org>
 <feb4ed1b-ed74-aebe-0ab8-dec123fe0a31@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <feb4ed1b-ed74-aebe-0ab8-dec123fe0a31@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 03:10:01PM +0530, Krishna Chaitanya Chundru wrote:
> 
> On 11/27/2023 6:15 PM, Manivannan Sadhasivam wrote:
> > Now that both eDMA and iATU are prepared to support async transfer, let's
> > enable MHI async read/write by supplying the relevant callbacks.
> > 
> > In the absence of eDMA, iATU will be used for both sync and async
> > operations.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   drivers/pci/endpoint/functions/pci-epf-mhi.c | 7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > index 3d09a37e5f7c..d3d6a1054036 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > @@ -766,12 +766,13 @@ static int pci_epf_mhi_link_up(struct pci_epf *epf)
> >   	mhi_cntrl->raise_irq = pci_epf_mhi_raise_irq;
> >   	mhi_cntrl->alloc_map = pci_epf_mhi_alloc_map;
> >   	mhi_cntrl->unmap_free = pci_epf_mhi_unmap_free;
> > +	mhi_cntrl->read_sync = mhi_cntrl->read_async = pci_epf_mhi_iatu_read;
> > +	mhi_cntrl->write_sync = mhi_cntrl->write_async = pci_epf_mhi_iatu_write;
> >   	if (info->flags & MHI_EPF_USE_DMA) {
> >   		mhi_cntrl->read_sync = pci_epf_mhi_edma_read;
> >   		mhi_cntrl->write_sync = pci_epf_mhi_edma_write;
> > -	} else {
> > -		mhi_cntrl->read_sync = pci_epf_mhi_iatu_read;
> > -		mhi_cntrl->write_sync = pci_epf_mhi_iatu_write;
> > +		mhi_cntrl->read_async = pci_epf_mhi_edma_read_async;
> > +		mhi_cntrl->write_async = pci_epf_mhi_edma_write_async;
> 
> I think the read_async & write async should be updated inside the if
> condition where MHI_EPF_USE_DMA flag is set.
> 

That's what being done here. Am I missing anything?

- Mani

> - Krishna Chaitanya.
> 
> >   	}
> >   	/* Register the MHI EP controller */

-- 
மணிவண்ணன் சதாசிவம்

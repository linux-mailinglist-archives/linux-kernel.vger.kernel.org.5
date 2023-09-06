Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1974D793C9E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 14:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240427AbjIFM0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 08:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236885AbjIFM0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:26:20 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624B0170D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 05:26:16 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5654051b27fso2478678a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 05:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694003176; x=1694607976; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kjnnzDLUDo2+D27D03H2YWRaB12AVyK4xgoDBE0WK78=;
        b=ygKQwRjKCVD+dfLm+tbjGg/m8JA3TgLbpihCkjPju/ASPe+/AAtsmJgtTfN2xDnFaH
         rf9ZmF592F9sLZFZ4U1HFk5W00934PS7JqDSCp9FYht50eLhOI/nO02bcbYfK7e15UrE
         RpgAzOWDZKQXXLFNwwcc0xUDGb0J41md5yvpgiSiL3oe1Bie5I/kw8e18qjUMkQZrWE5
         W1r0C5fddqUqLgdIIL7S6wfh31CnqbmXjy8bzNEWZHsJ884vrglbSouXYCPIBRcG2SmK
         gVI3HOdw1V1wCk9qaGDAk2sqw7C+eij4cOoMq8cvYO9ne/ovjY9nWMV3D192iSFPXiWL
         ZB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694003176; x=1694607976;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kjnnzDLUDo2+D27D03H2YWRaB12AVyK4xgoDBE0WK78=;
        b=duESM7HobrMCXEgq2ZcZWKsrckCvdVdN/UgHzdhDjMg1Ar1r8GZBV94gYz5PxsTWbN
         MfI1emMMa1DxVlx8bge4kiKDdo5mDQ7g02cfuuEd0lnOTDpU+a9gchMxR80nLWuhDCY9
         QdtNI02OYM3T1594dbKirGyKrTE7BbVjI+xPUVCHR9jxk9Pku1UnbzMaj75htaIcnQ/t
         LXC0EPkk2XqJaIC4NueCkD+l3FukIOpaBUyNScXmKwKxVyth8xaxeDVZmwbTsYLV22Oa
         icVQCEOTGo9ysAWYRCTaVDH5vUqmT2WQTh9EHRsd4JPnWd4mP0QZY7hTp2gR0iJ4vR7W
         LBMQ==
X-Gm-Message-State: AOJu0YzB6n4lsVsBKjBRsXAVRLpqZl5MGh8TrzizzsPEQ5xjdyg7PYvU
        4eHI1LkOQ0al0TOA3LaRNpNq
X-Google-Smtp-Source: AGHT+IFRy+f9cPt6hImhbeLHiudZgHv2ne6+5hiV0JlI5JP4oipQdy+eixxMA2W/+788/8cEth4xNw==
X-Received: by 2002:a17:90b:fc8:b0:26f:2c5a:bbb3 with SMTP id gd8-20020a17090b0fc800b0026f2c5abbb3mr14027269pjb.40.1694003175797;
        Wed, 06 Sep 2023 05:26:15 -0700 (PDT)
Received: from thinkpad ([120.138.12.139])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a199900b002693505391csm13493081pji.37.2023.09.06.05.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 05:26:15 -0700 (PDT)
Date:   Wed, 6 Sep 2023 17:56:05 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.li@nxp.com>
Cc:     tglx@linutronix.de, aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        kishon@ti.com, krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, maz@kernel.org,
        ntb@lists.linux.dev, peng.fan@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH 1/3] PCI: endpoint: Add RC-to-EP doorbell support using
 platform MSI controller
Message-ID: <20230906122605.GB5930@thinkpad>
References: <20230426203436.1277307-1-Frank.Li@nxp.com>
 <20230426203436.1277307-2-Frank.Li@nxp.com>
 <20230902045214.GA2913@thinkpad>
 <20230902045328.GB2913@thinkpad>
 <ZPf/EkffMC51iLQ/@lizhi-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZPf/EkffMC51iLQ/@lizhi-Precision-Tower-5810>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 12:24:50AM -0400, Frank Li wrote:
> On Sat, Sep 02, 2023 at 10:23:28AM +0530, Manivannan Sadhasivam wrote:
> > On Sat, Sep 02, 2023 at 10:22:25AM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, Apr 26, 2023 at 04:34:34PM -0400, Frank Li wrote:
> > > > This commit introduces a common method for sending messages from the Root Complex
> > > > (RC) to the Endpoint (EP) by utilizing the platform MSI interrupt controller,
> > > > such as ARM GIC, as an EP doorbell. Maps the memory assigned for the BAR region
> > > > by the PCI host to the message address of the platform MSI interrupt controller
> > > > in the PCI EP. As a result, when the PCI RC writes to the BAR region, it triggers
> > > > an IRQ at the EP. This implementation serves as a common method for all endpoint
> > > > function drivers.
> > > > 
> > > > However, it currently supports only one EP physical function due to limitations
> > > > in ARM MSI/IMS readiness.
> > > > 
> > > 
> > > I've provided generic comments below, but I will do one more thorough review
> > > after seeing epf-test driver patch.
> > > 
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >  drivers/pci/endpoint/pci-epf-core.c | 109 ++++++++++++++++++++++++++++
> > > >  include/linux/pci-epf.h             |  16 ++++
> > > >  2 files changed, 125 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> > > > index 355a6f56fcea..94ac82bf84c5 100644
> > > > --- a/drivers/pci/endpoint/pci-epf-core.c
> > > > +++ b/drivers/pci/endpoint/pci-epf-core.c
> > > > @@ -6,10 +6,12 @@
> > > >   * Author: Kishon Vijay Abraham I <kishon@ti.com>
> > > >   */
> > > >  
> > > > +#include <linux/irqreturn.h>
> > > 
> > > Why is this needed?
> > > 
> > > >  #include <linux/device.h>
> > > >  #include <linux/dma-mapping.h>
> > > >  #include <linux/slab.h>
> > > >  #include <linux/module.h>
> > > > +#include <linux/msi.h>
> > > >  
> > > >  #include <linux/pci-epc.h>
> > > >  #include <linux/pci-epf.h>
> > > > @@ -300,6 +302,113 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(pci_epf_alloc_space);
> > > >  
> > > > +static enum irqreturn pci_epf_interrupt_handler(int irq, void *data)
> > > 
> > > static irqreturn_t
> > > 
> > > s/pci_epf_interrupt_handler/pci_epf_doorbell_handler
> > > 
> > > > +{
> > > > +	struct pci_epf *epf = data;
> > > > +
> > > > +	if (epf->event_ops && epf->event_ops->doorbell)
> > > > +		epf->event_ops->doorbell(epf, irq - epf->virq_base);
> > > > +
> > > > +	return IRQ_HANDLED;
> > > > +}
> > > > +
> > > > +static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> > > > +{
> > > > +	struct pci_epc *epc = container_of(desc->dev, struct pci_epc, dev);
> > > > +	struct pci_epf *epf;
> > > > +
> > > > +	/* Todo: Need check correct epf if multi epf supported */
> > > > +	list_for_each_entry(epf, &epc->pci_epf, list) {
> > > > +		if (epf->msg && desc->msi_index < epf->num_msgs)
> > > > +			epf->msg[desc->msi_index] = *msg;
> > > > +	}
> > > > +}
> > > > +
> > > > +int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_msgs)
> > > > +{
> > > > +	struct irq_domain *domain;
> > > > +	struct pci_epc *epc;
> > > > +	struct device *dev;
> > > > +	int virq;
> > > > +	int ret;
> > > > +	int i;
> > > > +
> > > > +	epc = epf->epc;
> > > > +	dev = &epc->dev;
> > > 
> > > "epc_dev" to make it explicit
> 
> All other place use 'dev', I think better keep the consistent.
> 
> Frank
> > > 
> > > > +
> > > > +	/*
> > > > +	 * Current only support 1 function.
> > > 
> > > What does this mean exactly? Even a single EPC can support multiple EPFs
> > > 
> > 
> > Please ignore above comment.
> > 
> > - Mani
> > 
> > > > +	 * PCI IMS(interrupt message store) ARM support have not been
> > > > +	 * ready yet.
> > > 
> > > No need to mention platform irq controller name.
> 
> what's means?
> 

"PCI IMS ARM support" is not needed. Just say that only one EPF is supported.

> > > 
> > > > +	 */
> > > > +	if (epc->function_num_map != 1)
> > > 
> > > Why can't you use, epf->func_no?
> > > 
> > > > +		return -EOPNOTSUPP;
> > > > +
> > > > +	domain = dev_get_msi_domain(dev->parent);
> > > > +	if (!domain)
> > > > +		return -EOPNTSUPP;
> > > 
> > > Newline
> > > 
> > > > +	dev_set_msi_domain(dev, domain);
> > > > +
> > > > +	/* use parent of_node to get device id information */
> > > > +	dev->of_node = dev->parent->of_node;
> > > > +
> > > 
> > > Why do you need of_node assignment inside EPF core?
> 
> GIC need it to allocate a MSI irq to platform devices.
> I think it may improve if IMS support.
> 

Can't you assign it in the EPF driver itself? I do not want any OF reference in
the EPF core since it has no OF support.

- Mani

> Frank
> 
> > > 
> > > > +	epf->msg = kcalloc(num_msgs, sizeof(struct msi_msg), GFP_KERNEL);
> > > > +	if (!epf->msg)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	epf->num_msgs = num_msgs;
> > > > +
> > > 
> > > Move this to the start of the function, after checks.
> > > 
> > > > +	ret = platform_msi_domain_alloc_irqs(dev, num_msgs, pci_epf_write_msi_msg);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Can't allocate MSI from system MSI controller\n");
> > > 
> > > "Failed to allocate MSI"
> > > 
> > > > +		goto err_mem;
> > > 
> > > err_free_mem
> > > 
> > > > +	}
> > > > +
> > > > +	for (i = 0; i < num_msgs; i++) {
> > > > +		virq = msi_get_virq(dev, i);
> > > > +		if (i == 0)
> > > > +			epf->virq_base = virq;
> > > > +
> > > > +		ret = request_irq(virq, pci_epf_interrupt_handler, 0,
> > > > +				  "pci-epf-doorbell", epf);
> > > 
> > > IRQ name should have an index, otherwise all of them will have the same name.
> > > 
> > > > +
> > > > +		if (ret) {
> > > > +			dev_err(dev, "Failure request doorbell IRQ\n");
> > > 
> > > "Failed to request doorbell"
> > > 
> > > > +			goto err_irq;
> > > 
> > > err_free_irq
> > > 
> > > > +		}
> > > > +	}
> > > > +
> > > > +	epf->num_msgs = num_msgs;
> > > 
> > > Newline
> > > 
> > > > +	return ret;
> > > > +
> > > > +err_irq:
> > > > +	platform_msi_domain_free_irqs(dev);
> > > > +err_mem:
> > > > +	kfree(epf->msg);
> > > > +	epf->msg = NULL;
> > > > +	epf->num_msgs = 0;
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
> > > > +
> > > > +void pci_epf_free_doorbell(struct pci_epf *epf)
> > > > +{
> > > > +	struct pci_epc *epc;
> > > > +	int i;
> > > > +
> > > > +	epc = epf->epc;
> > > > +
> > > > +	for (i = 0; i < epf->num_msgs; i++)
> > > > +		free_irq(epf->virq_base + i, epf);
> > > > +
> > > > +	platform_msi_domain_free_irqs(&epc->dev);
> > > > +	kfree(epf->msg);
> > > > +	epf->msg = NULL;
> > > > +	epf->num_msgs = 0;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(pci_epf_free_doorbell);
> > > > +
> > > >  static void pci_epf_remove_cfs(struct pci_epf_driver *driver)
> > > >  {
> > > >  	struct config_group *group, *tmp;
> > > > diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> > > > index b8441db2fa52..e187e3ee48d2 100644
> > > > --- a/include/linux/pci-epf.h
> > > > +++ b/include/linux/pci-epf.h
> > > > @@ -75,6 +75,7 @@ struct pci_epf_ops {
> > > >  struct pci_epc_event_ops {
> > > >  	int (*core_init)(struct pci_epf *epf);
> > > >  	int (*link_up)(struct pci_epf *epf);
> > > > +	int (*doorbell)(struct pci_epf *epf, int index);
> > > >  };
> > > >  
> > > >  /**
> > > > @@ -173,6 +174,9 @@ struct pci_epf {
> > > >  	unsigned long		vfunction_num_map;
> > > >  	struct list_head	pci_vepf;
> > > >  	const struct pci_epc_event_ops *event_ops;
> > > > +	struct msi_msg *msg;
> > > > +	u16 num_msgs;
> > > > +	int virq_base;
> > > >  };
> > > >  
> > > >  /**
> > > > @@ -216,4 +220,16 @@ int pci_epf_bind(struct pci_epf *epf);
> > > >  void pci_epf_unbind(struct pci_epf *epf);
> > > >  int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);
> > > >  void pci_epf_remove_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);
> > > > +int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 nums);
> > > > +void pci_epf_free_doorbell(struct pci_epf *epf);
> > > > +
> > > > +static inline struct msi_msg *epf_get_msg(struct pci_epf *epf)
> > > > +{
> > > > +	return epf->msg;
> > > > +}
> > > > +
> > > > +static inline u16 epf_get_msg_num(struct pci_epf *epf)
> > > > +{
> > > > +	return epf->num_msgs;
> > > > +}
> > > 
> > > I don't see a need for these two functions as they are doing just dereferences.
> > > 
> > > - Mani
> > > 
> > > >  #endif /* __LINUX_PCI_EPF_H */
> > > > -- 
> > > > 2.34.1
> > > > 
> > > 
> > > -- 
> > > மணிவண்ணன் சதாசிவம்
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

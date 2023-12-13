Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB44280EA3C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346342AbjLLLTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346329AbjLLLTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:19:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D385FEB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:19:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E49EC433C8;
        Tue, 12 Dec 2023 11:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702379998;
        bh=wMeP7zt1EIlnBjj2On4ldk4xqwfR7vzMZdJCgjDqPhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l4w1RbhZTJq1hPS1YbIpyoowbGlBrDcwQ/sNjMl99Uxkk2T1ciKbIGZDXm5lfQDcY
         d9eT9oRncCc6Qx3KsFFwRoXuGYEwu1zZ2SNbOO70yMrbF7PisXpU1YS1SDm8Z6942o
         icImNol6zdFl4LarMzYEvT5sQqo+68jt9AXFPEEOS9RvrSVyNsgBvBkSEij67H/FAy
         nQdhVFJNofSX1edqYm7O0F1/4DN/bb+JepidRYnwkmRoaYbnoBRbbldXynk/nzx29j
         C09JDqHU7P96+oO4rzc3jTx9og1bWYZN9TxwGQHKj/asfWdTrLsEnFAMwGiwy2ALsb
         Eblv5dKN+wTRA==
Date:   Tue, 12 Dec 2023 12:19:50 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v12 15/21] PCI: microchip: Add event IRQ domain ops to
 struct plda_event
Message-ID: <ZXhB1kKpElgKx8vm@lpieralisi>
References: <20231206105839.25805-1-minda.chen@starfivetech.com>
 <20231206105839.25805-16-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206105839.25805-16-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 06:58:33PM +0800, Minda Chen wrote:
> For lack of an MSI controller, The new added PCIe interrupts have to be
> added to global interrupt event field. PolarFire event domain ops can not
> be re-used.

I don't understand what this means, please explain and I will
add it to the commit log.

> PLDA event domain ops instances will be implemented in later patch.

Future patches don't exist, each commit log is a logical change
that must make sense on its own, I will remove this sentence.

Lorenzo

> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/pci/controller/plda/pcie-microchip-host.c | 6 ++++--
>  drivers/pci/controller/plda/pcie-plda.h           | 1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
> index f5e7da242aec..e6dcc572b65b 100644
> --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> @@ -821,13 +821,15 @@ static const struct plda_event_ops mc_event_ops = {
>  };
>  
>  static const struct plda_event mc_event = {
> +	.domain_ops        = &mc_event_domain_ops,
>  	.event_ops         = &mc_event_ops,
>  	.request_event_irq = mc_request_event_irq,
>  	.intx_event        = EVENT_LOCAL_PM_MSI_INT_INTX,
>  	.msi_event         = EVENT_LOCAL_PM_MSI_INT_MSI,
>  };
>  
> -static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
> +static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port,
> +				      const struct irq_domain_ops *ops)
>  {
>  	struct device *dev = port->dev;
>  	struct device_node *node = dev->of_node;
> @@ -941,7 +943,7 @@ static int plda_init_interrupts(struct platform_device *pdev,
>  		return -EINVAL;
>  	}
>  
> -	ret = plda_pcie_init_irq_domains(port);
> +	ret = plda_pcie_init_irq_domains(port, event->domain_ops);
>  	if (ret) {
>  		dev_err(dev, "failed creating IRQ domains\n");
>  		return ret;
> diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
> index df1729095952..820ea16855b5 100644
> --- a/drivers/pci/controller/plda/pcie-plda.h
> +++ b/drivers/pci/controller/plda/pcie-plda.h
> @@ -129,6 +129,7 @@ struct plda_pcie_rp {
>  };
>  
>  struct plda_event {
> +	const struct irq_domain_ops *domain_ops;
>  	const struct plda_event_ops *event_ops;
>  	int (*request_event_irq)(struct plda_pcie_rp *pcie,
>  				 int event_irq, int event);
> -- 
> 2.17.1
> 

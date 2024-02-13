Return-Path: <linux-kernel+bounces-63820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0838C8534DC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71FE41F2AAA9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAD95EE75;
	Tue, 13 Feb 2024 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nOHqXeQf"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA9B5DF26
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838701; cv=none; b=TeNUkNkwGr4rwgYkRv5fAvUBaveylC/9WdBDwc0nX4elWd1XhF9O9XYvlbkUk/+/ZT0H5geFtCniwE+f7qq+zo2+CP/iQhvjHOGLefBQfmfMRqMYPL6xFNTnCXy6mxO3M+oBcdk/hmWe76/rDpxJqmm/v6R6LL+MD98PKZM3sgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838701; c=relaxed/simple;
	bh=R/PIz0dmSoBARaPtfEZzOeEWJp99ALWMBVYnlckJ/3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czKHf/Eew9Vg6pkQILl2dcXjJRg5Y8SgW7loyAyYRzdLySBw93nK544osII5ycTqbrSlWxDDB9iXKbjwgg2WLC5+nbjQ7Um49hl+PBRetEX5bYzulVuKVv96GPXleRyzDHsblwByN212P2nKHHb3wuXJdSZ/aN4Z+RtdYEZX7fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nOHqXeQf; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3d1d085384so37507966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 07:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707838698; x=1708443498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnXQ4qxGwQr7q5GWes7/A5mpaC/moLlsxNk7QmOMeyM=;
        b=nOHqXeQf7zGIRTu0BLSEgUlcor3dzNsSFDmRm8c/GuJ3F53mGbd68v3zYmSM2jlV4g
         or1zsX+TPU17hzgU7A+EIYZENy4Tqy6YGZCBv63J4J2m/XFd3Cp+iTGo9edJJu5dQL4D
         1BmT40FE5We/G7XaVyvNQIeFROG+FXE6bssSdEoPqrUbHHr0mL3PxVCbL5HSnAni+1d8
         WaJ1R1GCpvOxjd+4+3IHxTVWD77GQzLi/+LjaBE3GsRCYM/YXnPccRoNZHvakFLinXiY
         /pBDqZOh1NLjv0Gm5+jDPiJ7UukD0NbzfDZI4BW00EBcZZ9xILa6g+HKmWL2niuhr+ML
         m4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707838698; x=1708443498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnXQ4qxGwQr7q5GWes7/A5mpaC/moLlsxNk7QmOMeyM=;
        b=fuPlowOwTki51Cx27qLZnMv8PDlCt6BcIicYeryV0LDXbh333ptcwOsjz/UFGmgX+6
         z3zRyMqf8PSwTWWfB0jmNLPdtuWcHPdAqyWlC/cuMY4iTCc27VUkO15YrccLsOL26fpv
         qwTB2e0gUR+/750IxVl3A+L0VcHYdRE1PSv01AnrtFM7eaQb49JPEqb1mMTwidtj+wxU
         Lb3rkAZHTLFA5RansQp4B1ZjRxmTaamjvUfLhgxf3sHDXMf4/kb9owod/GhHIuTiF8XE
         //MBBtWP2VCLokib7sKDxlm6PKDmZudo2S65LEXgcwNLMu3y0TBJi2Sm4pJh8xVvNy0y
         i5Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWbIedvVjKUmBbQldhXfU34wy2MNn4ffSG503WyIllyQdq+qvRyuCS4H6n6OmVXq5UevZfsWvRmfx6mGchAbC45wSvZYVZSYeDA2I44
X-Gm-Message-State: AOJu0Yx1UnvD0FeJaLyPnYikvpkQ+Y8TZjQA+v38PCkWuEodMLX8+ko7
	9whxYazRSNS5q/jUrbB4S1m32DenU56682iubW77QNFQm231RQtltqnfrCng2PEMX6x5y8pTjWO
	A
X-Google-Smtp-Source: AGHT+IFQPTEKE8GIeujTWJ+O7gJLgC7eeIg5F4CoqdCggtkdMtrG1xNaY7Am/TaD9442Xsd9gV9GdQ==
X-Received: by 2002:a17:906:80d8:b0:a3c:d7a3:2eb5 with SMTP id a24-20020a17090680d800b00a3cd7a32eb5mr3320186ejx.13.1707838697905;
        Tue, 13 Feb 2024 07:38:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV/Jt54FkQUGvaJcgjM5EAn1v2bu/9jkN1Lj7ipBbd8b7vQr9GOqVEmhmnkf4cbsGZpY1XTQRUPRjPzVJOIuhUBC4O5pfQ8AsFP79gtsrG24IdttNeH8rAjoyrCJFXr6DOcwI/BkBKh4ORs4E48oXm2HjaNdLOENfJE5ZYRYsSoNWLi2Ndnfzng0SgaWdxjnkUdLb9HtTYLs+EXVJL5n+NyFJcW+/nvh0+a1f6Lk2w48tyDDCbIU75Bw1S8ASIMpdgmOUO14ndWZz8J8F9f0aQtQyJ2CT/DKqdevCXGcnvY1DEBXR7Zbicfpl2CpoEn5hMIjP9smT30sVxkLv4Zo1o8ZN5zuQasvrazBLjVfoWfiMYveQ77MIxTJYnw2Cq7qRM0PovQZ4Z/+chjXR//XwB68d+7WucPhdqEDfr8m6bkIy8VMs0JCDHTsxjZl3yt4oBYgBb4pxt2f4UK27GzOxGGmPRq
Received: from linaro.org ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id tx9-20020a1709078e8900b00a3d23a4e8fdsm169762ejc.90.2024.02.13.07.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 07:38:17 -0800 (PST)
Date: Tue, 13 Feb 2024 17:38:16 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH RFC v2] spmi: pmic-arb: Add support for multiple buses
Message-ID: <ZcuM6ChFFN6pIlrf@linaro.org>
References: <20240213-spmi-multi-master-support-v2-1-b3b102326906@linaro.org>
 <3fcb9f16-61f8-4544-a319-20496d5eb106@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fcb9f16-61f8-4544-a319-20496d5eb106@linaro.org>

On 24-02-13 15:55:56, Neil Armstrong wrote:
> On 13/02/2024 15:41, Abel Vesa wrote:
> > The v7 HW supports currently 2 buses. So register each bus as a separate
> > spmi controller and adapt all ops to use the bus instead of the
> > arbitrator. Legacy mode is still supported as long as there is no child
> > node that represents a bus, instead all nodes are expected to be actual
> > slave devices.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> > Changes in v2:
> > - Reworked it so that it registers a spmi controller for each bus
> >    rather than relying on the generic framework to pass on the bus
> >    (master) id.
> 
> Thanks, I think this is better.
> 
> > - Link to v1: https://lore.kernel.org/r/20240207-spmi-multi-master-support-v1-0-ce57f301c7fd@linaro.org
> > ---
> >   drivers/spmi/spmi-pmic-arb.c | 950 ++++++++++++++++++++++++++-----------------
> >   1 file changed, 585 insertions(+), 365 deletions(-)
> > 
> > diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
> > index 9ed1180fe31f..eced35b712b4 100644
> > --- a/drivers/spmi/spmi-pmic-arb.c
> > +++ b/drivers/spmi/spmi-pmic-arb.c
> 
> <snip>
> 
> 
> > +static int spmi_pmic_arb_bus_init(struct platform_device *pdev,
> > +				  struct device_node *node,
> > +				  struct spmi_pmic_arb *pmic_arb)
> > +{
> > +	int bus_index = pmic_arb->buses_available;
> > +	struct spmi_pmic_arb_bus *bus = &pmic_arb->buses[bus_index];
> > +	struct device *dev = &pdev->dev;
> > +	struct spmi_controller *ctrl;
> > +	void __iomem *intr;
> > +	void __iomem *cnfg;
> > +	int index, ret;
> > +	u32 irq;
> > +
> > +	ctrl = devm_spmi_controller_alloc(dev, sizeof(*ctrl));
> > +	if (IS_ERR(ctrl))
> > +		return PTR_ERR(ctrl);
> > +
> > +	ctrl->cmd = pmic_arb_cmd;
> > +	ctrl->read_cmd = pmic_arb_read_cmd;
> > +	ctrl->write_cmd = pmic_arb_write_cmd;
> > +
> > +	bus = spmi_controller_get_drvdata(ctrl);
> > +	bus->spmic = ctrl;
> > +
> > +	bus->ppid_to_apid = devm_kcalloc(dev, PMIC_ARB_MAX_PPID,
> > +					 sizeof(*bus->ppid_to_apid),
> > +					 GFP_KERNEL);
> > +	if (!bus->ppid_to_apid)
> > +		return -ENOMEM;
> > +
> > +	bus->apid_data = devm_kcalloc(dev, pmic_arb->max_periphs,
> > +				      sizeof(*bus->apid_data),
> > +				      GFP_KERNEL);
> > +	if (!bus->apid_data)
> > +		return -ENOMEM;
> > +
> > +	/* Optional property for v7: */
> > +	of_property_read_u32(node, "qcom,bus-id", &bus_index);
> 
> Not sure what bindings you plan to use, but this should be the reg property.
> 

This is already part of the old bindings (and implementation) and it's
only used for cases where some platforms would have two separate DT
nodes (one for each bus, v7 only) as it would specify which bus id it
is.

None of the upstream platforms use the qcom,bus-id with any other value
than 0, currently.

TBH, I think it should be dropped entirely.

Also, just realized that if any platforms is using two separate
controller nodes for each bus, this new approach will break the second
instance as it will expect the qcom,bus-id value to still be 0.

> > +	if (bus_index != pmic_arb->buses_available) {
> > +		dev_err(dev, "wrong bus-id value");
> > +		return -EINVAL;
> > +	}
> > +
> > +	index = of_property_match_string(node, "reg-names", "cnfg");
> > +	if (index < 0) {
> > +		dev_err(dev, "cnfg reg region missing");
> > +		return -EINVAL;
> > +	}
> > +
> > +	cnfg = devm_of_iomap(dev, node, index, NULL);
> > +	if (IS_ERR(cnfg))
> > +		return PTR_ERR(cnfg);
> > +
> > +	index = of_property_match_string(node, "reg-names", "intr");
> > +	if (index < 0) {
> > +		dev_err(dev, "intr reg region missing");
> > +		return -EINVAL;
> > +	}
> > +
> > +	intr = devm_of_iomap(dev, node, index, NULL);
> > +	if (IS_ERR(intr))
> > +		return PTR_ERR(intr);
> > +
> > +	irq = of_irq_get_byname(node, "periph_irq");
> > +	if (irq < 0)
> > +		return irq;
> > +
> > +	bus->pmic_arb = pmic_arb;
> > +	bus->intr = intr;
> > +	bus->cnfg = cnfg;
> > +	bus->irq = irq;
> > +	bus->id = bus_index;
> > +
> > +	ret = pmic_arb->ver_ops->init_apid(bus, index);
> > +	if (ret)
> > +		return ret;
> > +
> > +	dev_dbg(&pdev->dev, "adding irq domain for bus %d\n", bus_index);
> > +
> > +	bus->domain = irq_domain_add_tree(dev->of_node,
> > +					  &pmic_arb_irq_domain_ops, bus);
> > +	if (!bus->domain) {
> > +		dev_err(&pdev->dev, "unable to create irq_domain\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	irq_set_chained_handler_and_data(bus->irq,
> > +					 pmic_arb_chained_irq, bus);
> > +
> > +	bus->spmic->dev.of_node = node;
> > +	dev_set_name(&bus->spmic->dev, "spmi-%d", bus_index);
> > +
> > +	ret = devm_spmi_controller_add(dev, bus->spmic);
> > +	if (ret)
> > +		return ret;
> > +
> > +	pmic_arb->buses_available++;
> > +
> > +	return 0;
> > +}
> > +
> > +static int spmi_pmic_arb_register_buses(struct spmi_pmic_arb *pmic_arb,
> > +					struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct device_node *node = dev->of_node;
> > +	struct device_node *child;
> > +	int ret;
> > +
> > +	for_each_available_child_of_node(node, child)
> > +		if (of_node_name_eq(child, "bus")) {
> 
> It seems you use "bus" subnodes, it seems you should also submit a new
> bindings scheme for v7 controllers with subnodes

Yep, will do that.

> 
> > +			ret = spmi_pmic_arb_bus_init(pdev, child, pmic_arb);
> > +			if (ret)
> > +				return ret;
> > +		}
> > +
> > +	if (!pmic_arb->buses_available)
> > +		ret = spmi_pmic_arb_bus_init(pdev, node, pmic_arb);
> > +
> > +	return ret;
> > +}
> > +
> > +static void spmi_pmic_arb_deregister_buses(struct spmi_pmic_arb *pmic_arb)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < pmic_arb->buses_available; i++) {
> > +		struct spmi_pmic_arb_bus *bus = &pmic_arb->buses[i];
> > +
> > +		irq_set_chained_handler_and_data(bus->irq,
> > +						 NULL, NULL);
> > +		irq_domain_remove(bus->domain);
> > +	}
> > +}
> > +
> 
> <snip>
> 
> Overall the patch is __huge__, could you split it ? Like move the bus handling
> then add the multi-bus support in separate patches ?

Sure thing.

> 
> But first please add new bindings first so we know what you expect from DT.

Yep, will add another example to the existing bindings schema.

> 
> Thanks,
> Neil
> 
> > 
> > ---
> > base-commit: 445a555e0623387fa9b94e68e61681717e70200a
> > change-id: 20240207-spmi-multi-master-support-832a704b779b
> > 
> > Best regards,
> 


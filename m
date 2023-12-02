Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7007801D63
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 15:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjLBOoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 09:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBOoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 09:44:01 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A95102
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 06:44:07 -0800 (PST)
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 67F4C40C54
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 14:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701528245;
        bh=r6jeVOJ8uNScbavO6oRhJDbP/R2qrE1dKTxqhisFANk=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=r/bbhO2Hv9InIQ0eXoQKVigbKPg24PzuHDEKI0tp9CAVJXzF2qzQzn5e+49GTiLIN
         D8TQlYBM5DdzU0rN9LiAVYO50KLqY2E8VsFVqu/Yr6oSVThWHB9qe49VLRYC+JZtjO
         b4aG1iFjDTTtwCjfLNu57nvfM7t8fNWVY3NcRsh19uVsS3rlSiTLiAo4BwL7CWCKWa
         hDg3EbQd5a13Pv0fJ1jpxx3Nnp/xnkx6l+QkPG6ur5Mjeg2ptlQgpbwjspbcHatELA
         YXrUAT8TMjnO49EedbQCM9rgAE2kTogFvh8QcPDDatQwJ7MjpTDeLL2Yo0pMatSY1p
         lHR5aQXW8eI8Q==
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-67a696be34cso38447316d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 06:44:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701528244; x=1702133044;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r6jeVOJ8uNScbavO6oRhJDbP/R2qrE1dKTxqhisFANk=;
        b=l4o3CAj3mGz5nAyip1SJ91tRTyLJJWp9zWP9EwLORB3qTzf8wagF30bAQQdRiDNM37
         6NcjNSqBa47/EI0kw/HFEPUEqFffpXzXNlC1CtwR4G//2KGxwS6Tq/MjROYughwAmzTN
         6trusdsgCg4d8+WM/dYyejA+mriG8PVF2WrB9tQxZ3YaSQApHih8Zgj/wUANjZXvr7ed
         CoRnfZIi6cPGISKWjp7kWhAznAx5pRDOAqBmm9aaaDF1LQuR4KdCeCP5c749llSnGTcj
         KEPJVPMvDRc/oNR6eS87d+QwfJ3ppa3zQmm+E9Olpup6ufmwo7mCpCNyWXgEbBbWMIHH
         JySg==
X-Gm-Message-State: AOJu0YwJr0CcP/M2M0/t26jz45C6x7oOukT2OSX4ln0H4TVrIhvde7ax
        acgaDWCH30SIsFBRC9w3KQz4tKa+zSgns1gpS+XqXSd4+vIFaMjTnwl5pL0nmH5R4Gokrv5Bndi
        1a0+edOoGTTuJIdt2mYMFSNMJlKHdahMdZjkVBM/uz0PxXtIqGrMrlObRVo+lVtFbdg==
X-Received: by 2002:a05:622a:86:b0:425:4043:5f41 with SMTP id o6-20020a05622a008600b0042540435f41mr1919257qtw.127.1701528244245;
        Sat, 02 Dec 2023 06:44:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfPh334flr508EAZGNmLTyM+4QVgpXEgp8thSKGdCRPDIkTWGyXFCRDmz6MtLcyELHQnAA8WedEPZYZ24lPUA=
X-Received: by 2002:a05:622a:86:b0:425:4043:5f41 with SMTP id
 o6-20020a05622a008600b0042540435f41mr1919239qtw.127.1701528243903; Sat, 02
 Dec 2023 06:44:03 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 2 Dec 2023 06:44:03 -0800
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231115114912.71448-20-minda.chen@starfivetech.com>
References: <20231115114912.71448-1-minda.chen@starfivetech.com> <20231115114912.71448-20-minda.chen@starfivetech.com>
Mime-Version: 1.0
Date:   Sat, 2 Dec 2023 06:44:03 -0800
Message-ID: <CAJM55Z8hb3vBgwOHoHuJpEPFVMNirhcs8AfZWRn4EgxbOGsq2Q@mail.gmail.com>
Subject: Re: [PATCH v11 19/20] PCI: starfive: Add JH7110 PCIe controller
To:     Minda Chen <minda.chen@starfivetech.com>,
        Conor Dooley <conor@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minda Chen wrote:
> Add StarFive JH7110 SoC PCIe controller platform driver codes, JH7110
> with PLDA host PCIe core.
>
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Co-developed-by: Kevin Xie <kevin.xie@starfivetech.com>
> Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
> ---
>  MAINTAINERS                                 |   7 +
>  drivers/pci/controller/plda/Kconfig         |  11 +
>  drivers/pci/controller/plda/Makefile        |   1 +
>  drivers/pci/controller/plda/pcie-plda.h     |  71 ++-
>  drivers/pci/controller/plda/pcie-starfive.c | 460 ++++++++++++++++++++
>  drivers/pci/pci.h                           |   7 +
>  6 files changed, 556 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pci/controller/plda/pcie-starfive.c
>

...

> +
> +static int starfive_pcie_parse_dt(struct starfive_jh7110_pcie *pcie,
> +				  struct device *dev)
> +{
> +	int domain_nr;
> +
> +	pcie->num_clks = devm_clk_bulk_get_all(dev, &pcie->clks);
> +	if (pcie->num_clks < 0)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "failed to get pcie clocks\n");

Hi Minda,

From Damian's mail I noticed that this should propagate the error from
devm_clk_bulk_get_all() properly, so -EPROBE is converted to an -ENODEV error.
Eg.

	if (pcie->num_clks < 0)
		return dev_err_probe(dev, pcie->num_clks,
				     "failed to get pcie clocks\n");

> +
> +	pcie->resets = devm_reset_control_array_get_exclusive(dev);
> +	if (IS_ERR(pcie->resets))
> +		return dev_err_probe(dev, PTR_ERR(pcie->resets),
> +				     "failed to get pcie resets");
> +
> +	pcie->reg_syscon =
> +		syscon_regmap_lookup_by_phandle(dev->of_node,
> +						"starfive,stg-syscon");
> +
> +	if (IS_ERR(pcie->reg_syscon))
> +		return dev_err_probe(dev, PTR_ERR(pcie->reg_syscon),
> +				     "failed to parse starfive,stg-syscon\n");
> +
> +	pcie->phy = devm_phy_optional_get(dev, NULL);
> +	if (IS_ERR(pcie->phy))
> +		return dev_err_probe(dev, PTR_ERR(pcie->phy),
> +				     "failed to get pcie phy\n");
> +
> +	domain_nr = of_get_pci_domain_nr(dev->of_node);
> +
> +	if (domain_nr < 0 || domain_nr > 1)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "failed to get valid pcie domain\n");
> +
> +	if (domain_nr == 0)
> +		pcie->stg_pcie_base = STG_SYSCON_PCIE0_BASE;
> +	else
> +		pcie->stg_pcie_base = STG_SYSCON_PCIE1_BASE;
> +
> +	pcie->reset_gpio = devm_gpiod_get_optional(dev, "perst",
> +						   GPIOD_OUT_HIGH);
> +	if (IS_ERR(pcie->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(pcie->reset_gpio),
> +				     "failed to get perst-gpio\n");
> +
> +	pcie->power_gpio = devm_gpiod_get_optional(dev, "enable",
> +						   GPIOD_OUT_LOW);
> +	if (IS_ERR(pcie->power_gpio))
> +		return dev_err_probe(dev, PTR_ERR(pcie->power_gpio),
> +				     "failed to get power-gpio\n");
> +
> +	return 0;
> +}

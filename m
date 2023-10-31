Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73EA7DC87D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 09:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbjJaIh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 04:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235304AbjJaIhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 04:37:05 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F87B1BD
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 01:36:02 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cc316ccc38so17392735ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 01:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698741361; x=1699346161; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CmRWz5iS/me/RMqdnaDD894cfakp+jsL2NZ95UmiyHg=;
        b=prEu3q2poVTSVjwpaPZo6mX/hhi+J/9eh6896iU+t69PYT7sgiFwRiKMtn/sGQz5Yp
         3A78cOa7ptNqhqjgW8wM/coB35JyveqVCWsLg4ZCZwpfLvQPqpTBE4mqqQj2GELAeEeN
         I17rzqljT2wjoWR6O5EQDtN5a4TleqGr7iBmuEPlUMQd15E08j9KpIVi7Xirk3DsU7x7
         hTqCs/VU/WNvPyEPOFx9WQnS9iV6yTWg1FrcyLprVVLnlw1xX1DmwXSHAzbMne6c3L3h
         OJCnPq5I7ZPnuc2cO3HtMFOXlQn38PgTxnQBUf7AJvwL+O2euasULlD1Q8Ilgp+plwkh
         cRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698741361; x=1699346161;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CmRWz5iS/me/RMqdnaDD894cfakp+jsL2NZ95UmiyHg=;
        b=W5E/J9jyQRFTsmjNlIama5estZdulLWRfudvaO68pF96VBQRe/8635k5NSw6f3Jozz
         hE5xBo26iAuRIZQo2AJT0+DyGi+CuVS69dfV5j5op85PX64TrzLvkkurRjb9/WEpEaHW
         vTlRnMCzWj4VzJ8lh0KCH1QWI3T8tM33TJS2Twjfl00TZtsmYYPZvjWzuPxFvEP0UXZL
         TnGSzum9zqlN5O/lrWSFYCTew4xb6OGUXuklNS0UwV5JIt68CTN20Cob7HyMXZKicKQw
         nKMQQ64PsWB/EQDCTcE0ALmED0wFQUPj7ax+jLumXcMvJsBZqVIsHB+DMigdv/+w/3Ki
         Koyw==
X-Gm-Message-State: AOJu0Yzf1rRxRNBMOjVKQyeZ70QF3HHA5YtoEVV1axs6oEeblli/HrPU
        DVDkqjz5Uzb/phSoFc6hM3ve
X-Google-Smtp-Source: AGHT+IHjmRCODXpSYkvrHsgbscR3NzOeJbWUsnSzsupPb3nySmVdBXTLkyuKisEduQzGXlUKwY73Rg==
X-Received: by 2002:a17:902:d50f:b0:1cc:4e9f:d27 with SMTP id b15-20020a170902d50f00b001cc4e9f0d27mr4647477plg.1.1698741361293;
        Tue, 31 Oct 2023 01:36:01 -0700 (PDT)
Received: from thinkpad ([117.193.215.92])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090282c300b001c74df14e6fsm781176plz.284.2023.10.31.01.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 01:36:00 -0700 (PDT)
Date:   Tue, 31 Oct 2023 14:05:53 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: kirin: Fix an error path in kirin_pcie_probe()
Message-ID: <20231031083553.GD11778@thinkpad>
References: <e2b83334ab204ee905fe36ac01cfc297a5a2a7be.1698654061.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2b83334ab204ee905fe36ac01cfc297a5a2a7be.1698654061.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 09:21:16AM +0100, Christophe JAILLET wrote:
> If an error occurs after a successful kirin_pcie_power_on(),
> kirin_pcie_power_off() should be called, as already done in the remove
> function.
> 

PERST# assert (gpio_id_dwc_perst) is missing from kirin_pcie_power_off(). So
first you need to add that in a separate patch and then this patch can come
next.

Also, this driver is using legacy GPIO APIs and needs cleanup too (Kudos if you
are willing to do that).

- Mani

> Fixes: fc5165db245a ("PCI: kirin: Add HiSilicon Kirin SoC PCIe controller driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Not sure of the Fixes tag.
> ---
>  drivers/pci/controller/dwc/pcie-kirin.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index 2ee146767971..0b93de9d2d06 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -813,7 +813,15 @@ static int kirin_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	return dw_pcie_host_init(&pci->pp);
> +	ret = dw_pcie_host_init(&pci->pp);
> +	if (ret)
> +		goto err_power_off;
> +
> +	return 0;
> +
> +err_power_off:
> +	kirin_pcie_power_off(kirin_pcie);
> +	return ret;
>  }
>  
>  static struct platform_driver kirin_pcie_driver = {
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

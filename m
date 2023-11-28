Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64297FB114
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 06:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbjK1FPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 00:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjK1FO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 00:14:58 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6EC1AD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 21:15:05 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b2f507c03cso3061718b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 21:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701148504; x=1701753304; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2JoDhAoTR0SgWotjuFJFh8rPqxox7iwGsvE9hRWNQRY=;
        b=BEwJczP2xyMDqYZjkXdBYH1y4/RiWsFvRoKEfR4Jj5LO1TJYus3H2lPZJhQMXMbNY5
         UBK6IT/nlPA6S9e6oJTqBvwwx/kd13rcEnHRX3KpyXSVIHDNhXTZ8/q2SHh+WooYKkvK
         b0sfrt6bPajc2f+kMzxcXvi+Nrwb9flXFi6JTYqmkzkssa5uYbH4NNE1KxR5v5ZycSW+
         7FQKSSS+otz6sSQ9sUuuTGBKmMSACh5Z77H00WVpEvxirxLztLAzQKlr/hRoefGHMvc8
         adqpGrKW1szAp0nwtzuCX9uB1Sn2ODE78jM0BLd/xfqK7dnCesgneRu8WzNqHI2d0QE+
         m7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701148504; x=1701753304;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2JoDhAoTR0SgWotjuFJFh8rPqxox7iwGsvE9hRWNQRY=;
        b=UX5f4+wu/o9RilZ0so7t31VhqHkIZhj35TTTneDl7SZ74X00FJgFeXFjrFyUpBtwrz
         Jo1/ymFrZwGsMVnFJCcGOUl8jNBLd1xp9KKg6nQ3oPNH88kSAHZEL73lP92JaAqwn0gC
         eLLML4SVfSo+I2AT5rcXQWyg0jXZLEq3LZX4s0QP9WhOfzlpWi8r83DUZhH9Z3st0cC/
         RaxZuVzFKRc5fJ6ALUK4ZI0mp5HbkXpub9sjKJDYWbrja6MBr/K9kQqb+CVd/WnbpVWs
         hBWWte16a0ZNM8zM7haaD6PRIapqmGzTrzzL7KSG3v6Cq2yU307iVS/AMrXs7jypJHJV
         Neuw==
X-Gm-Message-State: AOJu0YzCQboxegIHYRD091nYWIQkNO1K+F4PN9djLgzvKe3VM9AU9/l8
        ICzYdE5JXZpmQ+FGTyPJzr2O
X-Google-Smtp-Source: AGHT+IGyf/7KAwi2AXPmYeCIDQnKIhHc2XSuIyEGnblje0EJXhZBPY9aMi6CVPuB2Vd6usaT1FIhGA==
X-Received: by 2002:a05:6808:3209:b0:3b8:4ada:7d7b with SMTP id cb9-20020a056808320900b003b84ada7d7bmr19405065oib.28.1701148504384;
        Mon, 27 Nov 2023 21:15:04 -0800 (PST)
Received: from thinkpad ([117.213.103.241])
        by smtp.gmail.com with ESMTPSA id r24-20020a62e418000000b006cb9725f5fdsm8033842pfh.217.2023.11.27.21.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 21:15:03 -0800 (PST)
Date:   Tue, 28 Nov 2023 10:44:56 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Vignesh Raman <vignesh.raman@collabora.com>
Cc:     intel-gfx@lists.freedesktop.org, helen.koike@collabora.com,
        daniels@collabora.com, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Fix compile error
Message-ID: <20231128051456.GA3088@thinkpad>
References: <20231128042026.130442-1-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231128042026.130442-1-vignesh.raman@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 09:50:26AM +0530, Vignesh Raman wrote:
> Commit a2458d8f618a ("PCI/ASPM: pci_enable_link_state: Add argument
> to acquire bus lock") has added an argument to acquire bus lock
> in pci_enable_link_state, but qcom_pcie_enable_aspm calls it
> without this argument, resulting in below build error.
> 

Where do you see this error? That patch is not even merged. Looks like you are
sending the patch against some downstream tree.

- Mani

> drivers/pci/controller/dwc/pcie-qcom.c:973:9: error: too few arguments to function 'pci_enable_link_state'
> 
> This commit fixes the compilation error by passing the sem argument
> to pci_enable_link_state in the qcom_pcie_enable_aspm function.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 6902e97719d1..e846e3531d8e 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -970,7 +970,7 @@ static int qcom_pcie_enable_aspm(struct pci_dev *pdev, void *userdata)
>  {
>  	/* Downstream devices need to be in D0 state before enabling PCI PM substates */
>  	pci_set_power_state(pdev, PCI_D0);
> -	pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL);
> +	pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL, false);
>  
>  	return 0;
>  }
> -- 
> 2.40.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

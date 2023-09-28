Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331177B2199
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjI1Pp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjI1PpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:45:24 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B2319E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:45:21 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-4135f3d1213so74840621cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1695915921; x=1696520721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zjyiO2aerenB+L5bFFtdZmRzY+MpNJymXfUVpkxGKO4=;
        b=dwO6EE243/koFMbKulZmcycWPxT1PjywGL+koaDrv4hLiEowCLzyPBedMp7ugDDcvy
         lfRIFfgO5vf2UjKAb6LuEPisgGOMSAgfgQCvu+0B99aCduaYmaXuWCbgamV47RJnyJft
         Ppg2YcDOO3eDJ+ZV9afprcLZS5suzxQyJ8Uphz0wrt+OPrd5OuyMecgPXViEMIbvd5PM
         lADYLmx+K2DHxZtro2NtQOSZVKEsFWNQAaTiMLjohZ/4o8bFWrlf7gkG/o/ji5KwTt9s
         8DGyugOpBuvbIc6mV02fEcUmwe4nabTJyRXbL4c3bE2i63JGI1Tid5W1pe/pYalst377
         CxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695915921; x=1696520721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjyiO2aerenB+L5bFFtdZmRzY+MpNJymXfUVpkxGKO4=;
        b=L9mfW7sn89XJNyv9iyxwNj1b/iae6naol+BDwTngUeS7Ds2a+N1aH5iEAeL0uLnVD8
         yC1Eu0ShdW2bDFcCa+rBWts3Qq+AmZJVUN0TfHYEj/7PjVC5d9q7jcAfRtN+VdkEYJa1
         uvld2EZcH+PASo9jtQWgbgmn8f1mDXrLjXLgej3LZ9Ga/llm1Qe3mWk8DbQz1sN/akBK
         ewmt1v5exQP9srprbtoAtvLigrLUfuAJHqRYPw8mAcPZMQwi+OPfcFiZDBBtVF3vBkX9
         0XAbf91nOo1j9sSOIil0B/zPLiUXiVuk7b072wUj6yqGFTSJiR7y50uxqY4YXqZ4vOHv
         YTig==
X-Gm-Message-State: AOJu0YzOPydCWH0/kRKB4trvh7VjmPNSbSBYM0Av5bfZ8x1mUmLejYE+
        EaT4w2qcSvX6MXhvgQWOLmzu9g==
X-Google-Smtp-Source: AGHT+IFKFYsPa5h8pLMtcKIq+MzAXP0NgUcgCjLytQEnC2TxzCHGxJpa5mBsW/GglWjJvBke4oO7bg==
X-Received: by 2002:ac8:5885:0:b0:418:12c6:467f with SMTP id t5-20020ac85885000000b0041812c6467fmr1513741qta.3.1695915921011;
        Thu, 28 Sep 2023 08:45:21 -0700 (PDT)
Received: from dell-precision-5540 ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id r15-20020ac87eef000000b004181a3eeff4sm3076750qtc.5.2023.09.28.08.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 08:45:20 -0700 (PDT)
Date:   Thu, 28 Sep 2023 11:45:10 -0400
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     Christophe Roullier <christophe.roullier@foss.st.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/12] net: ethernet: stmmac: stm32: support the
 phy-supply regulator binding
Message-ID: <ZRWfhk0aEDwytGv5@dell-precision-5540>
References: <20230928151512.322016-1-christophe.roullier@foss.st.com>
 <20230928151512.322016-9-christophe.roullier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928151512.322016-9-christophe.roullier@foss.st.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Sep 28, 2023 at 05:15:08PM +0200, Christophe Roullier wrote:
> From: Christophe Roullier <christophe.roullier@st.com>
> 
> Configure the phy regulator if defined by the "phy-supply" DT phandle.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 51 ++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> index 72dda71850d75..31e3abd2caeaa 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
... snip ...
>  static int stm32mp1_suspend(struct stm32_dwmac *dwmac)
> @@ -455,12 +496,20 @@ static int stm32mp1_suspend(struct stm32_dwmac *dwmac)
>  	if (dwmac->enable_eth_ck)
>  		clk_disable_unprepare(dwmac->clk_eth_ck);
>  
> +	/* Keep the PHY up if we use Wake-on-Lan. */
> +	if (!device_may_wakeup(dwmac->dev))
> +		phy_power_on(dwmac, false);
> +
>  	return ret;
>  }
>  
>  static void stm32mp1_resume(struct stm32_dwmac *dwmac)
>  {
>  	clk_disable_unprepare(dwmac->clk_ethstp);
> +
> +	/* The PHY was up for Wake-on-Lan. */
> +	if (!device_may_wakeup(dwmac->dev))
> +		phy_power_on(dwmac, true);
>  }
>  
>  static int stm32mcu_suspend(struct stm32_dwmac *dwmac)

Why only turn off the regulator in suspend on the STM32MP1 and not STM32
MCUs? It seems like this could just go in stm32_dwmac_suspend/resume().

Selfishly, I have a use case for this on an STM32F746 platform, so I
would like to see support for it and would test an updated version.

> -- 
> 2.25.1
> 

Thanks, Ben

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29061773C17
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjHHQAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjHHP6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:58:35 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2FA5FFC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:44:17 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so7014039a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691509456; x=1692114256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AV7pYGODgs/vswsM71s7yBSPT97U68gXTdayAu9iSYw=;
        b=Xf6aRLHueRS1WAiVJ+fuSlaSY0N/11wp+gZ/8duhoCER2Th3+tHAHsF7g2Q9TPLZqL
         TsYxozPDwNwmAktp48EDo+f9I4gj2p1keC6tl80h33UD99QpQYG61aUof8L36mKWtHiJ
         dR6MgYU8rV6AbR2vnuGL44AuajXhJZGD4ofc/iYBOH4nTtrEVVlRoRtIYbJsL1oSs4O7
         yByKaIQ0It0yK9dmquLrlc0rq9sglY9gIf95mQpNDbYsLlqq2h4KLY9v/u9kjVSMC4qF
         uY69EuG6pO/HIk1u20ZqOoveea/Mk42YaMK+Op0jwCTVXB77DE7hHBeNxlMNsoLU3z8U
         5q+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509456; x=1692114256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AV7pYGODgs/vswsM71s7yBSPT97U68gXTdayAu9iSYw=;
        b=H2/HzO1qpj19TgfmJIG1rCcEuKDYGC4fiWWLFcdrCOc2atd/dnn8Fzfq5G+yLSByNE
         /4NoqpyKMPvUTX3G8Bx51nH7f1H2AZjetr/oLsqe8MTD4uhghpYwLxC0z6WCwe8zXU63
         a9u7hPyDjy5TPB6AK4FfZfPRVMagcEcY0M9fsigA0lgEPgznu0hteOa/2Uq2Zkxh4R/K
         ozdSQF1Obg60WLXyQIs9bLonponHIC2wprVjaY8SmPZMDNhnZWADGx8qYFnySNKWQI0C
         pcVKkuJGdWNfCezHvtKufvAN1XoNMl8+nX3WNtAqQVHYNsAhYe2pnIwGPEztOOmxaJvX
         tE7Q==
X-Gm-Message-State: AOJu0Yy0IGIMerJFkPJT8P4wRw9iddidH4zeBlAJeH7BNzhlmQMA9ryW
        Udpql3ZFCYrTUo4o2a0ndyacIpGfnVj0a4tSDF0=
X-Google-Smtp-Source: AGHT+IHi6Yp+yRsRwvN5aEzHBHFgm8hd5a3fbcIKHC1dwK0+H3FWM+RobNVM6FnNwNpUNH5BDqly7w==
X-Received: by 2002:a17:906:e:b0:99c:7134:ab6d with SMTP id 14-20020a170906000e00b0099c7134ab6dmr10266806eja.41.1691483828332;
        Tue, 08 Aug 2023 01:37:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id l17-20020a1709060e1100b009944e955e19sm6302110eji.30.2023.08.08.01.37.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 01:37:07 -0700 (PDT)
Message-ID: <c589a82d-3011-d437-7343-b52308cbc185@linaro.org>
Date:   Tue, 8 Aug 2023 10:37:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 8/9] i2c: imx-lpi2c: Use dev_err_probe in probe
 function
Content-Language: en-US
To:     Liao Chang <liaochang1@huawei.com>, andi.shyti@kernel.org,
        florian.fainelli@broadcom.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        yangyicong@hisilicon.com, aisheng.dong@nxp.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, kblaiech@nvidia.com,
        asmaa@nvidia.com, loic.poulain@linaro.org, rfoss@kernel.org,
        ardb@kernel.org, gcherian@marvell.com
Cc:     linux-i2c@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230808012954.1643834-1-liaochang1@huawei.com>
 <20230808012954.1643834-9-liaochang1@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230808012954.1643834-9-liaochang1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 03:29, Liao Chang wrote:
> Use the dev_err_probe function instead of dev_err in the probe function
> so that the printed messge includes the return value and also handles
> -EPROBE_DEFER nicely.
> 

>  	ret = devm_request_irq(&pdev->dev, irq, lpi2c_imx_isr, 0,
>  			       pdev->name, lpi2c_imx);
> -	if (ret) {
> -		dev_err(&pdev->dev, "can't claim irq %d\n", irq);
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "can't claim irq %d\n", irq);
>  

I don't think this is needed:
https://lore.kernel.org/all/20230721094641.77189-1-frank.li@vivo.com/

Best regards,
Krzysztof


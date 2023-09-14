Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8211179FF2F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236011AbjINI4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236745AbjINI4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:56:14 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED312100
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:56:07 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31f4a286ae1so557078f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694681765; x=1695286565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ptKSXFKL7hUlaoL1cb/s1P95ZG9Kvuda4CmpMRlx4cc=;
        b=qVGgcxYIWJVDxlXHemU529FOxglX1XBDW+LNZQ/eBXl8Gt2E4ND9hCYtqb+z4q9/58
         gcmBbJ0+hNNVVPrzzwrMEYWi7XqoRWanOlnBoonyNlsEi/iKRU299Hq1QDxw0W91eCC5
         fFTipUhgGDyHhRjXKLGXkWtiJMNTswNXf1KIhYImYYB+y2K350o2yhKLL6/JFB2e+pYd
         eNhpJWzg3vkTwoqNKJrvYFUl6ZrsbcDA/wQElf+UcAxHbjMIjQ920rHvOlSCR2ikuwoc
         HcZiXDyJP97virdBMgKRfrPVMjbUtSTWfpUUOfWBL9cStvorZNFNRmMXSotjhv4kGWDc
         KVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694681765; x=1695286565;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ptKSXFKL7hUlaoL1cb/s1P95ZG9Kvuda4CmpMRlx4cc=;
        b=Rre7zEHACmiFi3exlxXXkqeV4KwsKOOnojQwD5IK3OKX1zvezRxpoLIR7C9W4ZHBHE
         CyjnAXHudvlxqm5JWLb1ZjSMT8rcCFQ5oSwRdSG5FaF5zf33w/fEIeC3Q9Dc0NYAr0bK
         OVXtqur90ImCkdS9Codvzj1p8G1G63CJuA+Z5lej0M2yejV3tk+pt9q6MtXnIlKk7Vfk
         qz4G8N2hX9MGo0/oiWGXnUnH7cesoX7K6sUT58lN+TWynX48j3iQYtpJjz98PcloRT5K
         WADzpX+YPF9au/NcM9m0KM4p0Q2VQmJrSNCcbGtYzpA2gSJLuvC8AesH3/ViUnW5FBOn
         Sgpw==
X-Gm-Message-State: AOJu0Yzw8yvK7znYyS7B6WWTnRqijjqMOHMsgfyBvYPTKz/0nA8ZB7T+
        MG86es0jlNVk2wMhaaPqAHqpyg==
X-Google-Smtp-Source: AGHT+IFxM+i9nRno0Y6ZWNHABTz+IL2NvLFiF8Qm7rB7Thevu96BEPRowS1CgLyPGPbezTxD4TDAqw==
X-Received: by 2002:a5d:6952:0:b0:319:55bc:4416 with SMTP id r18-20020a5d6952000000b0031955bc4416mr4368224wrw.5.1694681765604;
        Thu, 14 Sep 2023 01:56:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id a4-20020adffb84000000b0031c5ce91ad6sm1146486wrr.97.2023.09.14.01.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 01:56:05 -0700 (PDT)
Message-ID: <48e46de0-0996-b715-9d17-e1e10c0e44be@linaro.org>
Date:   Thu, 14 Sep 2023 10:56:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/5] gpio: vf610: add i.MX8ULP of_device_id entry
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
References: <20230914-vf610-gpio-v1-0-3ed418182a6a@nxp.com>
 <20230914-vf610-gpio-v1-3-3ed418182a6a@nxp.com>
 <b97ff9b6-97df-2c62-1946-06cd4ac79c95@linaro.org>
 <CACRpkdYJFp72o=c1OxN9Kcd7-Ee-id8+O2m0ag-rrT-nfq1Srg@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CACRpkdYJFp72o=c1OxN9Kcd7-Ee-id8+O2m0ag-rrT-nfq1Srg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2023 10:48, Linus Walleij wrote:
> On Thu, Sep 14, 2023 at 7:48 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> On 14/09/2023 04:20, Peng Fan (OSS) wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> i.MX8ULP supports two interrupts, while i.MX7ULP supports one interrupt.
>>> So from hardware perspective, they are not compatible.
>>>
>>> So add entry for i.MX8ULP.
>>>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>>>  drivers/gpio/gpio-vf610.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
>>> index dbc7ba0ee72c..88f7215cdf4b 100644
>>> --- a/drivers/gpio/gpio-vf610.c
>>> +++ b/drivers/gpio/gpio-vf610.c
>>> @@ -67,6 +67,7 @@ static const struct fsl_gpio_soc_data imx_data = {
>>>  static const struct of_device_id vf610_gpio_dt_ids[] = {
>>>       { .compatible = "fsl,vf610-gpio",       .data = NULL, },
>>>       { .compatible = "fsl,imx7ulp-gpio",     .data = &imx_data, },
>>> +     { .compatible = "fsl,imx8ulp-gpio",     .data = &imx_data, },
>>
>> Why? It is the same as imx7. No need.
> 
> Because compatible = "fsl,imx7ulp-gpio" is not what is going to be in the
> device tree, but compatible = "fsl,imx8ulp-gpio"?
> 
> What am I missing here? Maybe the commit message is weird.
> 

If the devices used before and are still going to use same driver data,
they look compatible from OS point of view. Therefore usually we express
such compatibility and do not add unneeded device_id entries.

Now whether the devices are truly compatible or not, I don't know and
with some recent emails I am bit confused.

Best regards,
Krzysztof


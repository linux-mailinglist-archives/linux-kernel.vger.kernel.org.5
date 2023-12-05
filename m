Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948058053CF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442380AbjLEMH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442372AbjLEMH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:07:26 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A67EC3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:07:32 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-77dd08f75afso361859585a.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 04:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701778051; x=1702382851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fzzss/3oc7wEg7L1wA9iFADpFSvhD8QNQvMXGtF4oXc=;
        b=Ox7KS79qlUvfkW4ogM7M+Kosv/o62NMH4dmPzTafqoK8YC3ynwwdkU0lBAUBcYHXGO
         WvVmt8Zt3TCi1VK8S5OLWUUK622HGR/hcjch4rQAF0/AeTTHBwGu7IWZoaQ6jzo/H7WX
         TIVxhTXgEId4KHwDH9+xT+DWSaJw1FhNc9M5Tuuw4uBfh/ah64mRDsf4EqBqSu3YKNzC
         HeWaGkNe+DZ64MjsAri6J4yuk6rGHz1TPfNGGAcsXoPJK7W4bS4pUqWP5dCzUOFm94nf
         AIGKSVM/hinzL6MPb0SAj6O3Lx9udn/USDHSYd32diirThTMP54zTrIFlLwtBExTAP2s
         Ss6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701778051; x=1702382851;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fzzss/3oc7wEg7L1wA9iFADpFSvhD8QNQvMXGtF4oXc=;
        b=ddKnbhhj7ieQlQElHzPFONt5rLIlgYQdtL8IhrWJgkl6FSPrCHzWD/Hq2bg/l2GyFp
         Yy+nXhIbMhGN6aK16u2KFDur2OPLoW2IcZ5HLbFYRJdvyTD4esrvadq3yNX0nMO8/OMM
         RIa9vmJF63Xqu1oJTah2TxZ/nsi1tP9n85zJ3gutwwI5imdt8eS4qlssXeDdeCIH6E+O
         PwOCcVQL+ghQDq50jTb7nxrfPZ6MrOYsO8vCQSCpB37LsFrO7szqPtVvmgpUZuxuqz6H
         yUKiVGW/jkF2iZ/4dGrYGVUUoxzCt+McPT8ZfSNQhKyH/ElQvtzf5XwM57d4Y0enQI0/
         iN6g==
X-Gm-Message-State: AOJu0YzJPzctYrE5cWS0xlcW6I/OyhysTx4n2uzcIOSodTQWg4+uqPgL
        A9tStexQzlGXkjMi3ZrAOYeX3g==
X-Google-Smtp-Source: AGHT+IEQ/fwXPYm/SKTmDVSPGaitnffnHXzR6LAxf7KIzfoLTCFxCaGIqthZPP3RG1C1BnV2D3zrLg==
X-Received: by 2002:a05:620a:8883:b0:77e:fba3:938f with SMTP id qk3-20020a05620a888300b0077efba3938fmr931908qkn.113.1701778051719;
        Tue, 05 Dec 2023 04:07:31 -0800 (PST)
Received: from [172.30.204.197] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id dx9-20020a05620a608900b0077d9fdde1dcsm5045144qkb.42.2023.12.05.04.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 04:07:31 -0800 (PST)
Message-ID: <95d47311-f25d-4594-b59d-bd389e39100c@linaro.org>
Date:   Tue, 5 Dec 2023 13:07:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: qrb5165-rb5: add a pin function for
 BT enable GPIO
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20231205112311.16391-1-brgl@bgdev.pl>
 <20231205112311.16391-2-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231205112311.16391-2-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/5/23 12:23, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Set up the pin function for the Bluetooth enable GPIO.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> index ce6ae0771d34..ead0c45ba60c 100644
> --- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> @@ -1264,6 +1264,17 @@ &tlmm {
>   		"HST_WLAN_UART_TX",
>   		"HST_WLAN_UART_RX";
>   
> +	bt_en_state: bt-default-state {
> +		bt-en {
> +			pins = "gpio21";
If it's the only GPIO expected to be here, you may drop the
extra bt-en level, like the entry below

Konrad

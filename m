Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9977A3416
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 09:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjIQHfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 03:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjIQHfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 03:35:31 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20829187
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 00:35:26 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bf3f59905so457680866b.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 00:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694936124; x=1695540924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GVg4iMqyFo6GXp2VZ+N/pcY2Y8g5Wn2f/zmdGd2t3MI=;
        b=lar6a0V7EyMJdDCKr4MuzCIk4QQdplSI/2WYfIwB+1LAUsXqc4j4vbSFidTmbOq6SK
         0bpTJf+NTNSF0NJER3QS6ghdZNx7vn/IQQW6S79DNEHFX13WC7scTWa4BGJdeiHfYeiE
         di+YqMNuxXgiZm9lD7Q7Ac4PLKbl94CUpB7s9YufmL8JZ4kkZHUAytFQw/JaXE5klPaI
         DulXd09UItfiFXkGEB9Bbql/5CzTeh+usiVZ2b8el6dX1gwb3mGI3U91K2bP1Iu6buUX
         BoSx6HvFj6J4C1Ol5wZeJFgnytIF2xAm9n+ysQApemwPIlxQs8cTDiV1YNstNfktBNet
         Jcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694936124; x=1695540924;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GVg4iMqyFo6GXp2VZ+N/pcY2Y8g5Wn2f/zmdGd2t3MI=;
        b=XhGaJpUkp6NoypAf+VDz3Y1q+I6rsClx4n0cIj5d/XzXa9+67ALr1Xd+PaFkhvgPpp
         WG9BMaAYrZVZyhN69sT1CKgvjJlofOzXfcuZLowdR5XdgM++4HLlMm2d8w+4EzMvfrXg
         vng20Nv9vo+OeJiPsgYJbg8trKCNAc1+6HPxXPA38kYFvkb2CjzdCp9ooQ3RCAxd5/kF
         ZbZIk8seDDcIFTKMrwIlUEb4VQ3pa+vaTkb6DsuUjYgDUsyg58Le3gBS24uJsEI5fmlA
         vH0V1TgkHSV6xs+TrlaIXOiGMR4qpo286l5uUtNqmgpMqZRUnkj8Fei2PjEIcXwe3uh8
         Kyiw==
X-Gm-Message-State: AOJu0YxYFVS5mJ4k20VSy40FNBhOEnk+nT9jasGZ/c8CID8VyrIiR+Sf
        fccbWCfrdaMxELI5Ebyo9ZzgoQ==
X-Google-Smtp-Source: AGHT+IHV9X9GTjPS8Rpcs9R2kxN8xI/rL5gF7b1VuZpWiQozu9bvvyJUcivpO+mDfPfyOicv9EQkxw==
X-Received: by 2002:a17:907:775a:b0:9a2:16e2:353 with SMTP id kx26-20020a170907775a00b009a216e20353mr5651059ejc.6.1694936124406;
        Sun, 17 Sep 2023 00:35:24 -0700 (PDT)
Received: from [192.168.1.77] (150-140-187-31.ftth.glasoperator.nl. [31.187.140.150])
        by smtp.gmail.com with ESMTPSA id r20-20020a170906365400b0099bd1a78ef5sm4640735ejb.74.2023.09.17.00.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 00:35:23 -0700 (PDT)
Message-ID: <54fcf0c2-c8e2-6ee8-5f6c-4de914c56c19@linaro.org>
Date:   Sun, 17 Sep 2023 09:35:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 8/8] arm64: defconfig: enable interconnect and pinctrl
 for SM4450
To:     Georgi Djakov <djakov@kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Tengfei Fan <quic_tengfan@quicinc.com>, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        catalin.marinas@arm.com
Cc:     geert+renesas@glider.be, arnd@arndb.de, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl, peng.fan@nxp.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_shashim@quicinc.com,
        quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        kernel@quicinc.com
References: <20230915021509.25773-1-quic_tengfan@quicinc.com>
 <20230915021509.25773-10-quic_tengfan@quicinc.com>
 <8f2c9664-a2c8-50dc-8a1c-e50a071ebeb2@linaro.org>
 <e9ff05b3-2742-416e-b417-5e2414036008@quicinc.com>
 <0a34dd35-7aea-4655-4cdd-e7196a1ba52b@linaro.org>
 <f76e1cc8-fc48-4208-bbe4-9204d9d28363@quicinc.com>
 <b7398390-23bc-467c-5b83-411110d60f43@linaro.org>
 <01c020ae-a019-e4eb-14cb-64503bde05a6@quicinc.com>
 <212f9bfa-6d4c-bba2-60d2-272c001a4322@quicinc.com>
 <e30870d5-a0cc-4210-a2b0-c7621ea5ecfa@kernel.org>
 <accb4814-4826-ff97-3527-4e3fbadcd4ff@linaro.org>
 <c11fd3c2-770a-4d40-8cf3-d8bc81f7c480@kernel.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c11fd3c2-770a-4d40-8cf3-d8bc81f7c480@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/2023 00:55, Georgi Djakov wrote:
> Hi Krzysztof,
> 
> On 16.09.23 23:32, Krzysztof Kozlowski wrote:
>> On 16/09/2023 17:13, Georgi Djakov wrote:
>>>
>>>>
>>>> Complete list here, and it is inconsistent. Latest 8550 is also =y. Do we document
>>>> the reasons somewhere on why they are added as =y?
>>>>
>>>> CONFIG_INTERCONNECT_QCOM=y
>>>> CONFIG_INTERCONNECT_QCOM_MSM8916=m
>>>> CONFIG_INTERCONNECT_QCOM_MSM8996=m
>>>> CONFIG_INTERCONNECT_QCOM_OSM_L3=m
>>>> CONFIG_INTERCONNECT_QCOM_QCM2290=m
>>>> CONFIG_INTERCONNECT_QCOM_QCS404=m
>>>> CONFIG_INTERCONNECT_QCOM_SA8775P=y
>>>> CONFIG_INTERCONNECT_QCOM_SC7180=y
>>>> CONFIG_INTERCONNECT_QCOM_SC7280=y
>>>> CONFIG_INTERCONNECT_QCOM_SC8180X=y
>>>> CONFIG_INTERCONNECT_QCOM_SC8280XP=y
>>>> CONFIG_INTERCONNECT_QCOM_SDM845=y
>>>> CONFIG_INTERCONNECT_QCOM_SM8150=m
>>>> CONFIG_INTERCONNECT_QCOM_SM8250=m
>>>> CONFIG_INTERCONNECT_QCOM_SM8350=m
>>>> CONFIG_INTERCONNECT_QCOM_SM8450=y
>>>> CONFIG_INTERCONNECT_QCOM_SM8550=y
>>>
>>> If the device can boot (to console/initramfs) with =m, we go with that.
>>> But if something critical like the UART depends on the interconnect
>>> provider, then we make it built-in.
>>>
>>> On SM8550 for example, we have enabled bandwidth scaling support for QUP
>>> and that's why it needs to be =y.
>>>
>>> It looks like on SM4450 this should be =y too.
>>
>> I asked why SM4450 has to be =y and there was no answer. The argument
>> that SM8450 is a module, is not applicable.
> 
>  From the hardware description i see in patch 7, the serial engine depends
> on some interconnect provider. But as the serial console driver is only
> available as built-in, the interconnect provider also needs be built-in
> for the UART device to probe and register the console.
> 
> So the answer to your question should be that this is needed by the UART
> device (at least).
> 
> Such details of course deserve to be mentioned in the commit message of
> this patch.

If you mean here the debug UART with console, then it is the same valid
reason as in my change for others. This should be mentioned in commit msg.

Best regards,
Krzysztof


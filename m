Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71B27A7A77
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbjITLbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbjITLbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:31:35 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E2FA9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 04:31:28 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9a21b6d105cso856591366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 04:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695209487; x=1695814287; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sISPinFUDL5u/bpoyx1Ij7HAjgfiATRW0k6PVgeAEsw=;
        b=Gau0z9A3Gdm/I+ZRLP/nM/zUAaLnyCCd9eWOhNEHXEjAx6uI2Rw6/BdH9a9soPI5eE
         cGTuHQt4jCSVbk3G4Z7Ow84psJiYVk/7uXiJbPYsN5srjWh4cnGmPw2I1+ehnDrRm+1e
         I41z70tJ7Ok/huzpLqf6xrWnee81cxGOk3g+uitX+ECmHscCiwrkCAv5CMQsHIaRfCQx
         1t0n5Q4H8OYoi8kvi25ThpZ61JgxrqVYrd0HA6OG+FDbbRpCTMp+1HnDH/vtOfwWLg05
         OW9RUNiDvxUWbL09Rm2p9OnxVQNiCRot/7y19vnH4Nw8FQ7u6PEIGswlMO97TmikOJ+m
         SOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695209487; x=1695814287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sISPinFUDL5u/bpoyx1Ij7HAjgfiATRW0k6PVgeAEsw=;
        b=bbrRX54nFK1PRqesbst20vSEwsr2htSZCRGRx26mg9Tg1ZO9lPZ1QfpiXW7mROS5bv
         //30WOJD03xe2i/ibRGMDEaAGZh9j95allq5cLBYrDCs3URLTzl1ffG3Gzkw7+rf3Hgx
         o82CwpGOsQHhoFIjQTngvuoMd0XezNIuAB5SilPmfs1cy5Aych+E40UGdiC09PLzr9O3
         V/Stk5LMVnhtRh+fKY5GNrUGO2Ua1ZtkEAaWuMlqG7LfDoVvaYiRMDsTkOaQDF0SbQ27
         f1eMMdZbGR7eYf2qA0ZVCWtWi2uSgjszCP+tEyHMh4KHo6O2up+bxfOzVJFFfxPTMLnO
         R1CQ==
X-Gm-Message-State: AOJu0YwlYCn1O7jdJrD/T2JcztkqJKS/1Z/SK/2Szx/CpNzX+xLqRJeZ
        6y01o5IlnrPrJjiPfplrjkJOWw==
X-Google-Smtp-Source: AGHT+IHvJqMLFU0/0VeoTulP60Slvf5E2yjtSP8/g6btQDvx/25B9cI7c5ufzI5k4+V+RhB2J3IRkg==
X-Received: by 2002:a17:906:220f:b0:9a9:f09d:7c10 with SMTP id s15-20020a170906220f00b009a9f09d7c10mr1849511ejs.11.1695209486889;
        Wed, 20 Sep 2023 04:31:26 -0700 (PDT)
Received: from [172.20.24.238] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id rh1-20020a17090720e100b009ad8ba6976bsm9277668ejb.9.2023.09.20.04.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 04:31:26 -0700 (PDT)
Message-ID: <2529838c-501f-45d6-d886-558bccac98b9@linaro.org>
Date:   Wed, 20 Sep 2023 13:31:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 1/2] dt-bindings: pinctrl: qcom: Add SM4450 pinctrl
Content-Language: en-US
To:     Tengfei Fan <quic_tengfan@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_tsoni@quicinc.com, quic_shashim@quicinc.com,
        quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        kernel@quicinc.com
References: <20230920082102.5744-1-quic_tengfan@quicinc.com>
 <20230920082102.5744-2-quic_tengfan@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230920082102.5744-2-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2023 10:21, Tengfei Fan wrote:
> Add device tree binding Documentation details for Qualcomm SM4450
> TLMM device.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDCA7AF1C1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 19:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbjIZR3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 13:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234104AbjIZR3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 13:29:42 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B373B10A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 10:29:34 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99c3c8adb27so1180581166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 10:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695749373; x=1696354173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6Vhbig0nhhNfTJO4IcAt/zm7dBAJ/m7itblDhT37dyg=;
        b=AkTGNxkBgOJcUTUI9M3ouei2ZJf/eoILQ0NS869PckfcFxY9Q+Qk2w4LGbzHpPrfxz
         tDG+V0GJnIVSjANp+f9izGb6FHztrb43wtvUEiK7q4BfMba03S7wTsLPFLK5s9XhARZV
         DCLdoF4B8llnDHU2tLHVHqxIguEN9cp0fk0FawJcsq9KiE+CoUUdQTBa83JlmPO6qbmo
         cKNfFXfq2oN+RPWF9vEXKxvrCvpdCbmqcgU7Vgf9CRKaO9FvWNd6yFTIdlS0TxIdNKYd
         fYuHonNDcfKJOh9HkrMSie45l28PWwXQ2lD5LS9klp6zPwON0CBRKQmweySn4SouoI8x
         kdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695749373; x=1696354173;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Vhbig0nhhNfTJO4IcAt/zm7dBAJ/m7itblDhT37dyg=;
        b=n/rC++hHkLr40WdePTUo5WhbX3zqtCng74XIkFwpCR0tV06w4DXCUY0oqgUJiMtwV2
         TJrf6IuO/yWldx0ARfRLMDUgJR1G2iWueQUDmIzdPX95HNNF1Tbnb/KIbB3cNKcxDA2V
         pL4WQjg3q+5INjmD1ivB+6q5FKAxmwB+FUd3QWecrc9uRPnWTiwY6K0ddSJm3S3iINLC
         7cHzhcP/R8L0U6Y+FeBvSHWYaYcrgDMEjX/PBMG8DqEUGWMs77QUAhd9Xs/f9dXAwkjH
         djSmw3xqZ8GxngNHx9YRd1qEM9rJtF2dtjwx2muSyQd/uKyk99r3+0KQjmeL9721oWPG
         gJpQ==
X-Gm-Message-State: AOJu0YzTqD5P6MetbVNQH1nTKH/xIvA6UulEm1MDqoAfyfDY6ph/2A3S
        ClyTF+igHTXehzN69Ww3JiWdcg==
X-Google-Smtp-Source: AGHT+IGB9ym/8CHHY0o/7Ji55tJkJHvDjFFfY8xPcDoyEVQ+TdI7OuCiUQy0lMCAqdS20jKH/MqsFg==
X-Received: by 2002:a17:907:2cd3:b0:9a1:be5b:f4aa with SMTP id hg19-20020a1709072cd300b009a1be5bf4aamr8939397ejc.0.1695749373105;
        Tue, 26 Sep 2023 10:29:33 -0700 (PDT)
Received: from [192.168.33.189] (178235177023.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.23])
        by smtp.gmail.com with ESMTPSA id n19-20020a170906165300b009a1c05bd672sm7949359ejd.127.2023.09.26.10.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 10:29:32 -0700 (PDT)
Message-ID: <b54d43b5-89fe-4801-9eff-57bd795cfed5@linaro.org>
Date:   Tue, 26 Sep 2023 19:29:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 2/2] arm64: dts: qcom: sc7280: Add UFS host controller
 and phy nodes
To:     Nitin Rawat <quic_nitirawa@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     agross@kernel.org, andersson@kernel.org, alim.akhtar@samsung.com,
        bvanassche@acm.org, robh+dt@kernel.org, avri.altman@wdc.com,
        cros-qcom-dts-watchers@chromium.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230821094937.13059-1-quic_nitirawa@quicinc.com>
 <20230821094937.13059-3-quic_nitirawa@quicinc.com>
 <20230822070841.GA24753@thinkpad>
 <593fa9be-9f55-3649-e825-1dee31ac5c21@quicinc.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <593fa9be-9f55-3649-e825-1dee31ac5c21@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.09.2023 18:24, Nitin Rawat wrote:
> 
> 
> On 8/22/2023 12:38 PM, Manivannan Sadhasivam wrote:
>> On Mon, Aug 21, 2023 at 03:19:37PM +0530, Nitin Rawat wrote:
>>> Add UFS host controller and PHY nodes for sc7280.
>>>
>>
>> You should split this patch into 2. One for SoC and another for board.
> Updated in Latest Patchset.
> 
>>
>>> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 19 +++++++
>>>   arch/arm64/boot/dts/qcom/sc7280.dtsi     | 64 ++++++++++++++++++++++++
>>>   2 files changed, 83 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>>> index 2ff549f4dc7a..c60cdd511222 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>>> @@ -451,6 +451,25 @@
>>>       status = "okay";
>>>   };
>>>
>>> +&ufs_mem_hc {
>>> +    reset-gpios = <&tlmm 175 GPIO_ACTIVE_LOW>;
>>> +    vcc-supply = <&vreg_l7b_2p9>;
>>> +    vcc-max-microamp = <800000>;
>>> +    vccq-supply = <&vreg_l9b_1p2>;
>>> +    vccq-max-microamp = <900000>;
>>> +    vccq2-supply = <&vreg_l9b_1p2>;
>>> +    vccq2-max-microamp = <900000>;
>>> +
>>> +    status = "okay";
>>> +};
>>> +
>>> +&ufs_mem_phy {
>>> +    vdda-phy-supply = <&vreg_l10c_0p8>;
>>> +    vdda-pll-supply = <&vreg_l6b_1p2>;
>>> +
>>> +    status = "okay";
>>> +};
>>> +
>>>   &sdhc_1 {
>>>       status = "okay";
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>>> index 925428a5f6ae..d4a15d56b384 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>>> @@ -908,6 +908,70 @@
>>>               };
>>>           };
>>>
>>> +        ufs_mem_phy: phy@1d87000 {
>>
>> Please sort the nodes in ascending order.
> Updated in Latest Patchset.
> 
>>
>>> +            compatible = "qcom,sc7280-qmp-ufs-phy";
>>> +            reg = <0x0 0x01d87000 0x0 0xe00>;
>>> +            clocks = <&rpmhcc RPMH_CXO_CLK>,
>>> +                 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
>>> +                 <&gcc GCC_UFS_1_CLKREF_EN>;
>>> +            clock-names = "ref", "ref_aux", "qref";
>>> +
>>> +            resets = <&ufs_mem_hc 0>;
>>> +            reset-names = "ufsphy";
>>> +
>>> +            #clock-cells = <1>;
>>> +            #phy-cells = <0>;
>>> +
>>> +            status = "disabled";
>>> +
>>> +        };
>>> +
>>> +        ufs_mem_hc: ufs@1d84000 {
>>> +            compatible = "qcom,sc7280-ufshc", "qcom,ufshc",
>>> +                     "jedec,ufs-2.0";
>>> +            reg = <0x0 0x01d84000 0x0 0x3000>;
>>> +            interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
>>> +            phys = <&ufs_mem_phy>;
>>> +            phy-names = "ufsphy";
>>> +            lanes-per-direction = <2>;
>>> +            #reset-cells = <1>;
>>> +            resets = <&gcc GCC_UFS_PHY_BCR>;
>>> +            reset-names = "rst";
>>> +
>>> +            power-domains = <&gcc GCC_UFS_PHY_GDSC>;
>>> +            required-opps = <&rpmhpd_opp_nom>;
>>> +
>>> +            iommus = <&apps_smmu 0x80 0x0>;
>>> +            dma-coherent;
>>> +
>>> +            clock-names = "core_clk",
>>> +                      "bus_aggr_clk",
>>> +                      "iface_clk",
>>> +                      "core_clk_unipro",
>>> +                      "ref_clk",
>>> +                      "tx_lane0_sync_clk",
>>> +                      "rx_lane0_sync_clk",
>>> +                      "rx_lane1_sync_clk";
>>
>> "clocks" property should come first.
>  DT binding shows clock-names first followed by clocks.
>  Let me know if see still see concern, would update .
The dt bindings example is rarely useful.. perhaps we should
change that..

The general consensus there is to have

property
property-names

Konrad

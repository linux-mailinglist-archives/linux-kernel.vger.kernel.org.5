Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C634805167
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345079AbjLELAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbjLELAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:00:31 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EB7189
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 03:00:36 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c9f166581dso37491761fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 03:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701774035; x=1702378835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AP9Qop94IEBXngKyOrylUsXliVAP98wJ33rfRTNKdcA=;
        b=EoY6ssu319TMcjn0cN+/TANrr6CLEIztMWWMI5OwKkZhXBUGiUC0E8rzrOrt/1Y2VJ
         9E+UrneaQBeLAa7IDqBWL9PpjT0I4yPtZGrNY+qB8qEO+UIR/0jX+yp/rFDpRQ5sohJi
         dajICf+kNrJmt2K1KxiGKA0m758CJeOxXMIg8/VSFxPZNfDnYQK0RysOZzS5F0lGFH4z
         sWN5qREg5tK1GGcjkeX5I8KlWsqMbhd1T3MCaKWPaCOyQXfvTHb6hHii3WAd2xX5rrbd
         WxN/vqg0Onm5o3HlmPBkU13XTUXq3J/Hf144Sidjna1geFOMOm+/j8wyYtHC4el7dddB
         iFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701774035; x=1702378835;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AP9Qop94IEBXngKyOrylUsXliVAP98wJ33rfRTNKdcA=;
        b=co3cGUIug9zmOdEAf2eGEH8HL8i02qI4k54MvS8EmlUvDWCyASgyIIy0EQbEkqI1fB
         l1/j1xl9Yc4MzZYMd72MCNeMaIY6cCdPnfIzVPjq8mf/DS/ZKRNaVolPpOUi/9Xz16s6
         2EXeEJxlgJTF4LnfC8fm82Fo0my6iS40V8okzNt71RrFSj40/13vo462fIGljB3LRExq
         mR7ElvQ+B215fy2C4glmKybFMyEoxNVEmHGDNt9jcw3W8m3E+Pr1aOT82HPX6r19y9Ks
         lBIRLWFZsFL9DlsbGfj9587m7mwVewZlGWYjxN7pbmzl6a7l8HfUDmjY27JcmjjDBHM8
         Q9Vw==
X-Gm-Message-State: AOJu0Yx8MslrQdy0HIY/+/7cBYVNUAeasALPLYHE/tQw9bUzVpVSQqkT
        /Leuf/QnZA4/YFCtD5lK9r4giw==
X-Google-Smtp-Source: AGHT+IEoHbfIdcV3tOJvmf6eVve6ZGwhFttsf/R9u1u+bVnAJZENXKOtM3fDLCrUqp36RNptgIqSow==
X-Received: by 2002:a2e:a26b:0:b0:2ca:19e5:cf2f with SMTP id k11-20020a2ea26b000000b002ca19e5cf2fmr248964ljm.0.1701774034909;
        Tue, 05 Dec 2023 03:00:34 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::227? (dzdqv0yyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::227])
        by smtp.gmail.com with ESMTPSA id h1-20020a2ebc81000000b002ca0f151917sm312010ljf.108.2023.12.05.03.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 03:00:34 -0800 (PST)
Message-ID: <2d791b1c-283c-4f24-80e0-efaf3756955f@linaro.org>
Date:   Tue, 5 Dec 2023 13:00:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] arm64: dts: qcom: sc7280: Add UFS nodes for sc7280
 soc
Content-Language: en-GB
To:     Nitin Rawat <quic_nitirawa@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231204-sc7280-ufs-v5-0-926ceed550da@fairphone.com>
 <20231204-sc7280-ufs-v5-2-926ceed550da@fairphone.com>
 <621388b9-dcee-4af2-9763-e5d623d722b7@quicinc.com>
 <CXFJNBNKTRHH.2CS6TO2MEGJWL@fairphone.com> <20231204172829.GA69580@thinkpad>
 <2c996304-f82f-5311-3d88-d459c07ef741@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <2c996304-f82f-5311-3d88-d459c07ef741@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2023 10:45, Nitin Rawat wrote:
> 
> 
> On 12/4/2023 10:58 PM, Manivannan Sadhasivam wrote:
>> On Mon, Dec 04, 2023 at 01:21:42PM +0100, Luca Weiss wrote:
>>> On Mon Dec 4, 2023 at 1:15 PM CET, Nitin Rawat wrote:
>>>>
>>>>
>>>> On 12/4/2023 3:54 PM, Luca Weiss wrote:
>>>>> From: Nitin Rawat <quic_nitirawa@quicinc.com>
>>>>>
>>>>> Add UFS host controller and PHY nodes for sc7280 soc.
>>>>>
>>>>> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
>>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>> Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org> # QCM6490 FP5
>>>>> [luca: various cleanups and additions as written in the cover letter]
>>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>>> ---
>>>>>    arch/arm64/boot/dts/qcom/sc7280.dtsi | 74 
>>>>> +++++++++++++++++++++++++++++++++++-
>>>>>    1 file changed, 73 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi 
>>>>> b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>>>>> index 04bf85b0399a..8b08569f2191 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>>>>> @@ -15,6 +15,7 @@
>>>>>    #include <dt-bindings/dma/qcom-gpi.h>
>>>>>    #include <dt-bindings/firmware/qcom,scm.h>
>>>>>    #include <dt-bindings/gpio/gpio.h>
>>>>> +#include <dt-bindings/interconnect/qcom,icc.h>
>>>>>    #include <dt-bindings/interconnect/qcom,osm-l3.h>
>>>>>    #include <dt-bindings/interconnect/qcom,sc7280.h>
>>>>>    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>>> @@ -906,7 +907,7 @@ gcc: clock-controller@100000 {
>>>>>                clocks = <&rpmhcc RPMH_CXO_CLK>,
>>>>>                     <&rpmhcc RPMH_CXO_CLK_A>, <&sleep_clk>,
>>>>>                     <0>, <&pcie1_phy>,
>>>>> -                 <0>, <0>, <0>,
>>>>> +                 <&ufs_mem_phy 0>, <&ufs_mem_phy 1>, <&ufs_mem_phy 
>>>>> 2>,
>>>>>                     <&usb_1_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
>>>>>                clock-names = "bi_tcxo", "bi_tcxo_ao", "sleep_clk",
>>>>>                          "pcie_0_pipe_clk", "pcie_1_pipe_clk",
>>>>> @@ -2238,6 +2239,77 @@ pcie1_phy: phy@1c0e000 {
>>>>>                status = "disabled";
>>>>>            };
>>>>> +        ufs_mem_hc: ufs@1d84000 {
>>>>> +            compatible = "qcom,sc7280-ufshc", "qcom,ufshc",
>>>>> +                     "jedec,ufs-2.0";
>>>>> +            reg = <0x0 0x01d84000 0x0 0x3000>;
>>>>> +            interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
>>>>> +            phys = <&ufs_mem_phy>;
>>>>> +            phy-names = "ufsphy";
>>>>> +            lanes-per-direction = <2>;
>>>>> +            #reset-cells = <1>;
>>>>> +            resets = <&gcc GCC_UFS_PHY_BCR>;
>>>>> +            reset-names = "rst";
>>>>> +
>>>>> +            power-domains = <&gcc GCC_UFS_PHY_GDSC>;
>>>>> +            required-opps = <&rpmhpd_opp_nom>;
>>>>> +
>>>>> +            iommus = <&apps_smmu 0x80 0x0>;
>>>>> +            dma-coherent;
>>>>> +
>>>>> +            interconnects = <&aggre1_noc MASTER_UFS_MEM 
>>>>> QCOM_ICC_TAG_ALWAYS
>>>>> +                     &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>>>>> +                    <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
>>>>> +                     &cnoc2 SLAVE_UFS_MEM_CFG QCOM_ICC_TAG_ALWAYS>;
>>>>> +            interconnect-names = "ufs-ddr", "cpu-ufs";
>>>>> +
>>>>> +            clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
>>>>> +                 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
>>>>> +                 <&gcc GCC_UFS_PHY_AHB_CLK>,
>>>>> +                 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
>>>>> +                 <&rpmhcc RPMH_CXO_CLK>,
>>>>> +                 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
>>>>> +                 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
>>>>> +                 <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
>>>>> +            clock-names = "core_clk",
>>>>> +                      "bus_aggr_clk",
>>>>> +                      "iface_clk",
>>>>> +                      "core_clk_unipro",
>>>>> +                      "ref_clk",
>>>>> +                      "tx_lane0_sync_clk",
>>>>> +                      "rx_lane0_sync_clk",
>>>>> +                      "rx_lane1_sync_clk";
>>>>> +            freq-table-hz =
>>>>> +                <75000000 300000000>,
>>>>> +                <0 0>,
>>>>> +                <0 0>,
>>>>> +                <75000000 300000000>,
>>>>> +                <0 0>,
>>>>> +                <0 0>,
>>>>> +                <0 0>,
>>>>> +                <0 0>;
>>>>> +            status = "disabled";
>>>>> +        };
>>>>> +
>>>>> +        ufs_mem_phy: phy@1d87000 {
>>>>> +            compatible = "qcom,sc7280-qmp-ufs-phy";
>>>>> +            reg = <0x0 0x01d87000 0x0 0xe00>;
>>>>> +            clocks = <&rpmhcc RPMH_CXO_CLK>,
>>>>> +                 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
>>>>> +                 <&gcc GCC_UFS_1_CLKREF_EN>;
>>>>> +            clock-names = "ref", "ref_aux", "qref";
>>>>> +
>>>>> +            power-domains = <&gcc GCC_UFS_PHY_GDSC>;
>>>
>>> Hi Nitin,
>>>
>>>>
>>>> GCC_UFS_PHY_GDSC is UFS controller GDSC. For sc7280 Phy we don't 
>>>> need this.
>>>
>>> In the current dt-bindings the power-domains property is required.
>>>
>>> Is there another power-domain for the PHY to use, or do we need to
>>> adjust the bindings to not require power-domains property for ufs phy on
>>> sc7280?
>>>
>>
>> PHYs are backed by MX power domain. So you should use that.
>>
>>> Also, with "PHY" in the name, it's interesting that this is not for the
>>> phy ;)
>>>
>>
>> Yes, confusing indeed. But the controllers (PCIe, UFS, USB etc...) are 
>> backed by
>> GDSCs and all the analog components (PHYs) belong to MX domain since 
>> it is kind
>> of always ON.
>>
>> I'll submit a series to fix this for the rest of the SoCs.
>>
>> - Mani
>>
> 
> Hi Mani,
> 
> UFS Phy is a passive driver and its resource enable/disable is 
> controlled by UFS controller driver.
> 
> Since PHY belongs to MX domain which is always on. IMO, there is no need 
> for explicitly voting for MX domain for sc7280 and older targets.
> 
> Only starting SM8550, we have a separate UFS PHY GDSC which needs to be 
> voted for enabling or disabling and hence we need to have power-domain 
> property for SM8550.
> 
> Hence, I feel updating the binding to reflect that power-domains is not 
> a required field would be more correct.

The bindings should describe the hardware. We model the MX domain, so 
the MX domain should be used in cases where the device is powered by 
that domain.

> 
> 
> Regards,
> Nitin
> 
> 
> 
>>> Regards
>>> Luca
>>>
>>>>
>>>>> +
>>>>> +            resets = <&ufs_mem_hc 0>;
>>>>> +            reset-names = "ufsphy";
>>>>> +
>>>>> +            #clock-cells = <1>;
>>>>> +            #phy-cells = <0>;
>>>>> +
>>>>> +            status = "disabled";
>>>>> +        };
>>>>> +
>>>>>            ipa: ipa@1e40000 {
>>>>>                compatible = "qcom,sc7280-ipa";
>>>>>
>>>
>>
> 

-- 
With best wishes
Dmitry


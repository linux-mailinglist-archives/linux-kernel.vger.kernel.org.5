Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C97A7548A7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 15:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjGONMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 09:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjGONMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 09:12:49 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FA73A94
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 06:12:45 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fc8049fd8bso4660769e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 06:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689426764; x=1692018764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4eGHxScHEvemEIgA9KvVuBuOI7kQeuQRmBiKcVy7mLY=;
        b=P5BESiPJev29zt7nzjeqN4sXekX8VFia8mjRbrj53Mvi/YuYp4GN/w+ybfItZANoOG
         KqH/1b5d+Hr9bIgtfXOi8hLF3N5d0p++K6EO8IWWrJOKhAmfbatfkz+yW6RUkdfag4q7
         MCinPH+Or2te/diPAjaSDf4morV5AkURyVhw04mr7F/HrkDg87MRcJFWbCcceCgbxznV
         zWnRCn5+z+fbD9KlMMBnY2PKQ+hNxMIELjQdVZI6RtOc5sJApSIwvDa8IBeGa6cORFGL
         PO1OoDeDzKcjj9M4UiZ37JbCBAW6kNlYYKfTX2HJAQF+YwmzRN8p1wJaB3FaWDenJjY7
         0rSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689426764; x=1692018764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4eGHxScHEvemEIgA9KvVuBuOI7kQeuQRmBiKcVy7mLY=;
        b=CnuloQvZhKZBkkL+ZWppnrLjWrt3bhk9hyZuAk+zXoZHnx4vUBJVOvhhUehAXZMqAY
         NtHLxXAzd4DNCmj/aC1s0+M+IiqvNzcdQv1Y8IYe5bJ1lHl+oXVDXOddJ+CdpFqIrF+L
         ToP/ch0AP0k2qv5bywZIrsh2mo92LSrkigNzoINdJjt6yszbkL2u5LxYMpqi3oNJTOph
         gFCwErMYXMvk9Evd2kVwpi+XT2pOEXxE1BXLNcl1Ni/E/yB2yW16gRVj5AzDWcsOQ+j0
         op15tYscVdgIGpRRZsbeyM1OfxcHw56BiOhNZZ1wnb2lu7Fos99mizBAyJf+t2iAZGXz
         N4gw==
X-Gm-Message-State: ABy/qLaxjWRcIoHSc9IWD5TCQ3lD5l8kMJNlk9Tb8Kwi7xXEeLL1TWgP
        lYtb58ogUpfWuKfHhBPyllrrpQ==
X-Google-Smtp-Source: APBJJlF0hB1hPss5cHKImGlHO56rIgO53eciTo2/8mE+pSx5a+s7ZuKSdpL7NUdak9VPvCqh5pwbXA==
X-Received: by 2002:ac2:5de2:0:b0:4fb:772a:af17 with SMTP id z2-20020ac25de2000000b004fb772aaf17mr5334407lfq.37.1689426764118;
        Sat, 15 Jul 2023 06:12:44 -0700 (PDT)
Received: from [192.168.1.101] (abxi167.neoplus.adsl.tpnet.pl. [83.9.2.167])
        by smtp.gmail.com with ESMTPSA id d4-20020a05651221c400b004fbb1bc1ae0sm1891090lft.163.2023.07.15.06.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 06:12:43 -0700 (PDT)
Message-ID: <1270b1e9-7fa7-3612-0143-ec9eeaf58218@linaro.org>
Date:   Sat, 15 Jul 2023 15:12:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 12/14] arm64: dts: qcom: sdm845: Add interconnect paths to
 UFSHC
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
 <20230712103213.101770-15-manivannan.sadhasivam@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230712103213.101770-15-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.07.2023 12:32, Manivannan Sadhasivam wrote:
> UFS host controller requires interconnect path configuration for proper
> working. So let's specify them for SDM845 SoC.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
Duplicate of patch 11

Konrad
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index e04a3cbb1017..2ea6eb44953e 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -2607,6 +2607,11 @@ ufs_mem_hc: ufshc@1d84000 {
>  				<&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
>  
>  			operating-points-v2 = <&ufs_opp_table>;
> +
> +			interconnects = <&aggre1_noc MASTER_UFS_MEM 0 &mem_noc SLAVE_EBI1 0>,
> +					<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_UFS_MEM_CFG 0>;
> +			interconnect-names = "ufs-ddr", "cpu-ufs";
> +
>  			status = "disabled";
>  
>  			ufs_opp_table: opp-table {

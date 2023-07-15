Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4526F7548A3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 15:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjGONMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 09:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjGONM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 09:12:29 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AB03A84
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 06:12:28 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fb73ba3b5dso4824660e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 06:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689426746; x=1692018746;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=obDUffjTF2zRBMvLiGVPVDGsQ4MqX71EFjXjfxceF88=;
        b=drCGM8XUvG+PkDCVSHDeEZ4FlI4Kqh8AvEHYtEU1kKiOiKPtykvL/Z+LlzQrkiVga/
         omIBf29M576/3zynvsIiY+E5rZG7xKlG6ZsQSN8dKDGvbnMTlRlHcpKKxRHxwFnmpHwZ
         KePcAm7vB+ejRedicS9DtvjfC8u+d6GPzB16rn8j5O7bjucWJa2j8mjijgOzy4qP9lsa
         KIhR0nsIl6EzXYjgDx2ltZhqETCs/qAWCjNHiLGZoU4ntt1uhp0grIIKeMlv46+bEs5m
         GxlYfVR/b2HrfLsy6wxu6qeLZG9ouhj9eQg7w5m3jMRgbfSj2ZCF/TAWaJZM5NV8duP0
         RNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689426746; x=1692018746;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obDUffjTF2zRBMvLiGVPVDGsQ4MqX71EFjXjfxceF88=;
        b=NTnarGT51EmYLNyJXhniD4N0iJQmRks5lnNZ8oJ36BHYDCSds7OquDOrdaN4RM3ogz
         ExNPJdMUaM35cqUM7r+pitxamGVuwusohecalFX2YmFXUV/AaTUdyGPFlFqNfDFKgm5y
         x8PAdOIOo4PFDPKmLDcwOl7D2tEoGXY0iNUIDMUmWpXbXlLR5hB5+aV86xYMLL502NFk
         MBzFBursWWCnZ5hg23WUb+8c/E/PodmOPlgXdb0Q+NCW3EOul1resUHL22dzB4WFC9Ng
         +KmJZe5b3KEj1kz47BjgP0MH7E696GixKZBVMRivlVRhBek9Vh4wq3ioJmQVEflS7eNF
         Y2wQ==
X-Gm-Message-State: ABy/qLZX4zi47bvIWz6kjcbFWsBgfRiS21pkgRvHdPMpGXidvdi9vZS7
        aCXGatDBbv/4/3lGM+tEkn1EaQ==
X-Google-Smtp-Source: APBJJlE8XDJli3tUl9UaORSKozUioC+k7HlH9S/5Q/brZimYM0tJsVC+RVZTsqtwP7NSuS8xlpCBYQ==
X-Received: by 2002:a05:6512:3143:b0:4f8:67a5:94df with SMTP id s3-20020a056512314300b004f867a594dfmr4925508lfi.15.1689426746394;
        Sat, 15 Jul 2023 06:12:26 -0700 (PDT)
Received: from [192.168.1.101] (abxi167.neoplus.adsl.tpnet.pl. [83.9.2.167])
        by smtp.gmail.com with ESMTPSA id p12-20020a19f00c000000b004fb7359ab83sm1884308lfc.80.2023.07.15.06.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 06:12:25 -0700 (PDT)
Message-ID: <3176ac93-da55-f3f3-756a-46d0d33901a7@linaro.org>
Date:   Sat, 15 Jul 2023 15:12:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 11/13] arm64: dts: qcom: sdm845: Add interconnect paths to
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
 <20230712103213.101770-13-manivannan.sadhasivam@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230712103213.101770-13-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

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

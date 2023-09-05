Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145777924C8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbjIEP7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 11:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353647AbjIEHCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:02:42 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7921DCCB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 00:02:37 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-986d8332f50so327374766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 00:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693897356; x=1694502156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wElbC8XfctBuRgr5ePtm4H+5YKr2KuwZN20exhxXdW8=;
        b=ZkbT7MXO1xKlDHUzbt7+8PZIAtXUmGbdFkwOdB7rjZ9Y+rHqHct08E/20Y0OlK1NMA
         JMpBTM821HiOHSCU1YDnm8tpts61fGS4GM6Xg81lBP28yBu6DUKWsGDquqwASSVal36q
         U+AQscySg87PSjXgl8tyJAGTqE1tQt2B8xM7PUVwgzu0xHYGcfcE0TTw7cmsuCwfKB76
         h+8dLgYGdiwU7bEZt+WIWVFbRbTS8IwgtG9RCuDkjQP34dgzOMQ4TK3/5WI3/JdFsa44
         YtHxSCZc2JFm7rD8UY4W+qRsPfP3tIkgnJRe6EltMXluDFaWhjnWSEVP57Vw6BcTZjVI
         sSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693897356; x=1694502156;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wElbC8XfctBuRgr5ePtm4H+5YKr2KuwZN20exhxXdW8=;
        b=KeXqkJ8Dgp0NiItOtSVNA9hAbF6QyOVH3hgyY/wW0eNblYuFVJZJxgxjvpp00tQQuj
         fBncwiE+f1GuoeaLI+/A81qCJ6wgSuLB5zA1LL5YTK7m4FwImA8Qxo3ULJL9os9uqukp
         J3Flf7Py6L4Y3YCAjhgZUceRN8lT8hd7Ff95Q0j8QH2z+C2dj2aLeIaxqVWga0RR1AGg
         XEiyBS2xgTuNla91bALMy9NpAnHfDSJmDCG75Ce/GIr4Vlb8KniD9z7jAXpY3cY+9juD
         zQ4DizZ2Lr1l8FNmgvoFfQ473nxZWesPJTMUArFhlHIkpODD8lDKVAOetrrk0AE/xv3+
         3A2Q==
X-Gm-Message-State: AOJu0Yx3Tg3P6zgO2ASYg0emFFxSdxmgDxCkOjW6jbYMzUoiSF4X/9/s
        MgKc6IUrXhWFjN3bR9LYRz+J+A==
X-Google-Smtp-Source: AGHT+IHxxGC5YKgGBmdlTmXb/K0ebj7hQvYI0Muv2z9d81aCbHywKXfToAJc/9PfA62pmLi7cv2CaQ==
X-Received: by 2002:a17:907:a04d:b0:9a5:cab0:b050 with SMTP id gz13-20020a170907a04d00b009a5cab0b050mr7895529ejc.13.1693897355841;
        Tue, 05 Sep 2023 00:02:35 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id rl21-20020a170907217500b0099315454e76sm7105834ejb.211.2023.09.05.00.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 00:02:35 -0700 (PDT)
Message-ID: <4388cb18-ada2-656b-ff1d-e75bf1e8b82d@linaro.org>
Date:   Tue, 5 Sep 2023 09:02:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] interconnect: qcom: Add SDX75 interconnect provider
 driver
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com
References: <1693889975-19122-1-git-send-email-quic_rohiagar@quicinc.com>
 <1693889975-19122-3-git-send-email-quic_rohiagar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1693889975-19122-3-git-send-email-quic_rohiagar@quicinc.com>
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

On 05/09/2023 06:59, Rohit Agarwal wrote:
> Add driver for the Qualcomm interconnect buses found in SDX75.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>

...

> +
> +static struct qcom_icc_bcm *system_noc_bcms[] = {

Please do not copy your code from downstream, but work on upstream. We
changed this long time ago, so you clearly used some old or obsolete
file as template.

> +	&bcm_ce0,
> +	&bcm_cn0,
> +	&bcm_sn0,
> +	&bcm_sn1,
> +	&bcm_sn2,
> +};
> +
> +static struct qcom_icc_node *system_noc_nodes[] = {
> +	[MASTER_AUDIO] = &qhm_audio,
> +	[MASTER_GIC_AHB] = &qhm_gic,
> +	[MASTER_PCIE_RSCC] = &qhm_pcie_rscc,
> +	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
> +	[MASTER_QPIC] = &qhm_qpic,
> +	[MASTER_QUP_0] = &qhm_qup0,
> +	[MASTER_ANOC_SNOC] = &qnm_aggre_noc,
> +	[MASTER_GEM_NOC_CNOC] = &qnm_gemnoc_cnoc,
> +	[MASTER_GEM_NOC_PCIE_SNOC] = &qnm_gemnoc_pcie,
> +	[MASTER_SNOC_CFG] = &qnm_system_noc_cfg,
> +	[MASTER_PCIE_ANOC_CFG] = &qnm_system_noc_pcie_cfg,
> +	[MASTER_CRYPTO] = &qxm_crypto,
> +	[MASTER_IPA] = &qxm_ipa,
> +	[MASTER_MVMSS] = &qxm_mvmss,
> +	[MASTER_EMAC_0] = &xm_emac_0,
> +	[MASTER_EMAC_1] = &xm_emac_1,
> +	[MASTER_QDSS_ETR] = &xm_qdss_etr0,
> +	[MASTER_QDSS_ETR_1] = &xm_qdss_etr1,
> +	[MASTER_SDCC_1] = &xm_sdc1,
> +	[MASTER_SDCC_4] = &xm_sdc4,
> +	[MASTER_USB3_0] = &xm_usb3,
> +	[SLAVE_ETH0_CFG] = &ps_eth0_cfg,
> +	[SLAVE_ETH1_CFG] = &ps_eth1_cfg,
> +	[SLAVE_AUDIO] = &qhs_audio,
> +	[SLAVE_CLK_CTL] = &qhs_clk_ctl,
> +	[SLAVE_CRYPTO_0_CFG] = &qhs_crypto_cfg,
> +	[SLAVE_IMEM_CFG] = &qhs_imem_cfg,
> +	[SLAVE_IPA_CFG] = &qhs_ipa,
> +	[SLAVE_IPC_ROUTER_CFG] = &qhs_ipc_router,
> +	[SLAVE_CNOC_MSS] = &qhs_mss_cfg,
> +	[SLAVE_ICBDI_MVMSS_CFG] = &qhs_mvmss_cfg,
> +	[SLAVE_PCIE_0_CFG] = &qhs_pcie0_cfg,
> +	[SLAVE_PCIE_1_CFG] = &qhs_pcie1_cfg,
> +	[SLAVE_PCIE_2_CFG] = &qhs_pcie2_cfg,
> +	[SLAVE_PCIE_RSC_CFG] = &qhs_pcie_rscc,
> +	[SLAVE_PDM] = &qhs_pdm,
> +	[SLAVE_PRNG] = &qhs_prng,
> +	[SLAVE_QDSS_CFG] = &qhs_qdss_cfg,
> +	[SLAVE_QPIC] = &qhs_qpic,
> +	[SLAVE_QUP_0] = &qhs_qup0,
> +	[SLAVE_SDCC_1] = &qhs_sdc1,
> +	[SLAVE_SDCC_4] = &qhs_sdc4,
> +	[SLAVE_SPMI_VGI_COEX] = &qhs_spmi_vgi_coex,
> +	[SLAVE_TCSR] = &qhs_tcsr,
> +	[SLAVE_TLMM] = &qhs_tlmm,
> +	[SLAVE_USB3] = &qhs_usb3,
> +	[SLAVE_USB3_PHY_CFG] = &qhs_usb3_phy,
> +	[SLAVE_A1NOC_CFG] = &qns_a1noc,
> +	[SLAVE_DDRSS_CFG] = &qns_ddrss_cfg,
> +	[SLAVE_SNOC_GEM_NOC_SF] = &qns_gemnoc_sf,
> +	[SLAVE_SNOC_CFG] = &qns_system_noc_cfg,
> +	[SLAVE_PCIE_ANOC_CFG] = &qns_system_noc_pcie_cfg,
> +	[SLAVE_IMEM] = &qxs_imem,
> +	[SLAVE_SERVICE_PCIE_ANOC] = &srvc_pcie_system_noc,
> +	[SLAVE_SERVICE_SNOC] = &srvc_system_noc,
> +	[SLAVE_PCIE_0] = &xs_pcie_0,
> +	[SLAVE_PCIE_1] = &xs_pcie_1,
> +	[SLAVE_PCIE_2] = &xs_pcie_2,
> +	[SLAVE_QDSS_STM] = &xs_qdss_stm,
> +	[SLAVE_TCU] = &xs_sys_tcu_cfg,
> +};
> +
> +static struct qcom_icc_desc sdx75_system_noc = {

Come on... we fixed it.

There could be more issues because you used old file as template. Start
from scratch from new file.

Best regards,
Krzysztof


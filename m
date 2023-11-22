Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07997F496B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344009AbjKVOwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjKVOwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:52:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA602DD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:52:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3537C433C8;
        Wed, 22 Nov 2023 14:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700664760;
        bh=sAcyOaQD3H8yNNyICEEcQesIVItkS+W3nQU7LOMsA5Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=H2nLHfrlVrecaRMxljeGrGPPA1/Bs/RYZ9Ev2x/KsNSFbFCgd/Qa2eOI1Ow7fQDFv
         2HslTgqlcfn1snthG3a2Yd2eXCyOo8jw02pp3VrnMIvRNPuZovk5YjLdStnmd6c/TT
         02mXMVlEVH055S1KG/3Yrj+Mk47dUePHMWbXZka/pWJULz2U5vPAfQveM9rBrtOBNg
         zegujGhydRKuiORCgoNcobzs4mvum0pUjynIpc8upA+9Zpr+Qon06kn69aswrJSbxg
         vFmyNhsFD/hQvgpXgVGthf+Vk+si05oI3aSM0UGm118ezb3EP3NoEa35IX9IMdU9eM
         YWRLWvt1a1G7A==
Message-ID: <77f39971-6d8a-4e1a-b7e6-bffb5fbf74db@kernel.org>
Date:   Wed, 22 Nov 2023 16:52:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] dt-bindings: interconnect: Add Qualcomm X1E80100
 SoC
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     agross@kernel.org, conor+dt@kernel.org, quic_rjendra@quicinc.com,
        abel.vesa@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_tsoni@quicinc.com,
        neil.armstrong@linaro.org
References: <20231117103035.25848-1-quic_sibis@quicinc.com>
 <20231117103035.25848-2-quic_sibis@quicinc.com>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20231117103035.25848-2-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sibi,

On 17.11.23 12:30, Sibi Sankar wrote:
> From: Rajendra Nayak <quic_rjendra@quicinc.com>
> 
> The Qualcomm X1E80100 SoC has several bus fabrics that could be controlled
> and tuned dynamically according to the bandwidth demand.
> 
> Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> v2:
> * Update the part number from sc8380xp to x1e80100.
> * Fixup required property ordering [Krzysztof]
> * Pickup Rbs.
> 
>   .../interconnect/qcom,x1e80100-rpmh.yaml      |  83 +++++++
>   .../interconnect/qcom,x1e80100-rpmh.h         | 207 ++++++++++++++++++
>   2 files changed, 290 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,x1e80100-rpmh.yaml
>   create mode 100644 include/dt-bindings/interconnect/qcom,x1e80100-rpmh.h

[..]

> +#define MASTER_AV1_ENC				0
> +#define MASTER_CAMNOC_HF			1
> +#define MASTER_CAMNOC_ICP			2
> +#define MASTER_CAMNOC_SF			3
> +#define MASTER_EVA				4
> +#define MASTER_MDP				5
> +#define MASTER_VIDEO				6
> +#define MASTER_VIDEO_CV_PROC			7
> +#define MASTER_VIDEO_V_PROC			8
> +#define MASTER_CNOC_MNOC_CFG			9
> +#define SLAVE_MNOC_HF_MEM_NOC			10
> +#define SLAVE_MNOC_SF_MEM_NOC			11
> +#define SLAVE_SERVICE_MNOC			12
> +#define MASTER_MDP_DISP				13
> +#define SLAVE_MNOC_HF_MEM_NOC_DISP		14
> +
> +#define MASTER_CDSP_PROC			0
> +#define SLAVE_CDSP_MEM_NOC			1
> +
> +#define MASTER_PCIE_NORTH			0
> +#define MASTER_PCIE_SOUTH			0

This duplicate index looks like a typo?

> +#define SLAVE_ANOC_PCIE_GEM_NOC			3
> +#define MASTER_PCIE_NORTH_PCIE			4
> +#define MASTER_PCIE_SOUTH_PCIE			5
> +#define SLAVE_ANOC_PCIE_GEM_NOC_PCIE		6
[..]

Thanks,
Georgi


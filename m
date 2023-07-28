Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3707766825
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbjG1JGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbjG1JGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:06:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E440997;
        Fri, 28 Jul 2023 02:06:10 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S8graT013450;
        Fri, 28 Jul 2023 09:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dDr+mZ5n/+jifFglNaPwWUcpxSJ9ZKrPvbO7Mr0GJ/Q=;
 b=jHLGOfjfJe75dVcfVMwLO6mv4JYVXvVoLeFxA+RwkepHzEnG8GBvIhRhewyCzRPD/sHr
 rL62VI3EBRIvSWDXCdV/IqdT158NSGm2Sb6RNCloztp5KXfxEl+MhlUqdAOop3/rpvHH
 0A4v3fceGl420yfVixwd2cTqoghC+F3uQUc7dWy8PNqynOGlhu8CoAtw9F5kjeMsODyJ
 82CZu3AR2uwwCPHHdZBVTlXM14/I2H/JIcSdnU2DDdJPYRDVIDQg5CRTBtJst22r+XGY
 khAd2yKOXRcDZ7LnDA+WqM5h0DclU8NjUWJ8DM8fnWAbveB0Y4eGJJOWQDG6+2YRWm7q uA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s3k7u31cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 09:06:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36S95wZU009730
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 09:05:58 GMT
Received: from [10.50.49.240] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 28 Jul
 2023 02:05:53 -0700
Message-ID: <0ec5202e-02c0-2df4-42bf-e4faa824f243@quicinc.com>
Date:   Fri, 28 Jul 2023 14:35:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] media: venus: Fix firmware path for resources
Content-Language: en-US
To:     Patrick Whewell <patrick.whewell@sightlineapplications.com>
CC:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        William Gray <william.gray@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <6afa314b-ca5e-a924-de2f-f1db90770623@linaro.org>
 <20230719214943.22641-1-patrick.whewell@sightlineapplications.com>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20230719214943.22641-1-patrick.whewell@sightlineapplications.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0nGPh5Wounlo5MCKK0yHyfKTKBOET5l-
X-Proofpoint-ORIG-GUID: 0nGPh5Wounlo5MCKK0yHyfKTKBOET5l-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 clxscore=1011 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307280082
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/2023 3:19 AM, Patrick Whewell wrote:
> The firmware path for some of the resources is still the old format. This
> fixes the path to address the firmware correctly using the new .mbn
> format.
> 
> Signed-off-by: Patrick Whewell <patrick.whewell@sightlineapplications.com>
> ---

the changes look good to me.

Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>

> I've updated all .fwname to match the .mbn format. There is a
> qcom/venus-4.4/venus.mdt for the sdm660 that still remains but the linux-firmware
> package does not contain that firmware file anymore, so i left as is.
> 
>  drivers/media/platform/qcom/venus/core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 2ae867cb4c48..2d62669d99e1 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -548,7 +548,7 @@ static const struct venus_resources msm8916_res = {
>  	.vmem_size = 0,
>  	.vmem_addr = 0,
>  	.dma_mask = 0xddc00000 - 1,
> -	.fwname = "qcom/venus-1.8/venus.mdt",
> +	.fwname = "qcom/venus-1.8/venus.mbn",
>  };
>  
>  static const struct freq_tbl msm8996_freq_table[] = {
> @@ -581,7 +581,7 @@ static const struct venus_resources msm8996_res = {
>  	.vmem_size = 0,
>  	.vmem_addr = 0,
>  	.dma_mask = 0xddc00000 - 1,
> -	.fwname = "qcom/venus-4.2/venus.mdt",
> +	.fwname = "qcom/venus-4.2/venus.mbn",
>  };
>  
>  static const struct freq_tbl sdm660_freq_table[] = {
> @@ -688,7 +688,7 @@ static const struct venus_resources sdm845_res = {
>  	.vmem_size = 0,
>  	.vmem_addr = 0,
>  	.dma_mask = 0xe0000000 - 1,
> -	.fwname = "qcom/venus-5.2/venus.mdt",
> +	.fwname = "qcom/venus-5.2/venus.mbn",
>  };
>  
>  static const struct venus_resources sdm845_res_v2 = {
> @@ -717,7 +717,7 @@ static const struct venus_resources sdm845_res_v2 = {
>  	.cp_size = 0x70800000,
>  	.cp_nonpixel_start = 0x1000000,
>  	.cp_nonpixel_size = 0x24800000,
> -	.fwname = "qcom/venus-5.2/venus.mdt",
> +	.fwname = "qcom/venus-5.2/venus.mbn",
>  };
>  
>  static const struct freq_tbl sc7180_freq_table[] = {
> @@ -760,7 +760,7 @@ static const struct venus_resources sc7180_res = {
>  	.vmem_size = 0,
>  	.vmem_addr = 0,
>  	.dma_mask = 0xe0000000 - 1,
> -	.fwname = "qcom/venus-5.4/venus.mdt",
> +	.fwname = "qcom/venus-5.4/venus.mbn",
>  };
>  
>  static const struct freq_tbl sm8250_freq_table[] = {
> @@ -814,7 +814,7 @@ static const struct venus_resources sm8250_res = {
>  	.vmem_size = 0,
>  	.vmem_addr = 0,
>  	.dma_mask = 0xe0000000 - 1,
> -	.fwname = "qcom/vpu-1.0/venus.mdt",
> +	.fwname = "qcom/vpu-1.0/venus.mbn",
>  };
>  
>  static const struct freq_tbl sc7280_freq_table[] = {

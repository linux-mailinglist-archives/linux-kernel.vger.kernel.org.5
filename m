Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D7676E9A7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbjHCNML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236079AbjHCNLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:11:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D387E49D6;
        Thu,  3 Aug 2023 06:10:14 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373BsqhK007959;
        Thu, 3 Aug 2023 13:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ucUxDSwxnrBpRrHDljPUeC6KW5nBI61F9ncRRJ1iEf0=;
 b=ir8EakGDy6zLsP0WmnXiZajbv4DVc8cEyrLSFy77a0OCllC+ueGoFGRnxwwJRj08DfTa
 BzyM7oq/JHUJcB2qvIremrsZrEJVwEJAGBrlFlBycq2l8+4EluTD1ABTXgePhgLgyGZy
 w3di7ICEqB5Eem3qUFiecwSMUMgmd/mhm1qkNMW3C1fRnsYrHZ0XiN4YYYKxvaHE+82s
 n0QXtGfycvH0jyydBFWFtZG0w3/vAlxVVZWsAZLgY2/j5w2jKZcLdaD/7neYh/fAbn9r
 l7sc3i3uewzA4SaznYWf+KVLwGBH+BAh93gsWT+c7iUTMPM04C9K/sJ47ZgzO1k+9oUe WA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s7vxsspsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 13:09:23 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 373D9Mvk010971
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Aug 2023 13:09:22 GMT
Received: from [10.216.37.36] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 3 Aug
 2023 06:09:17 -0700
Message-ID: <c25456de-4d5a-033f-3328-6183c754b08f@quicinc.com>
Date:   Thu, 3 Aug 2023 18:39:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 6/6] soc: qcom: llcc: Add QDU1000 and QRU1000 LLCC
 support
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230802091429.20892-1-quic_kbajaj@quicinc.com>
 <20230802091429.20892-7-quic_kbajaj@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230802091429.20892-7-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZXQLIAt4PJ-iDGhJQHjoxLCMsysaH--s
X-Proofpoint-GUID: ZXQLIAt4PJ-iDGhJQHjoxLCMsysaH--s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_12,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308030119
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/2023 2:44 PM, Komal Bajaj wrote:
> Add LLCC configuration data for QDU1000 and QRU1000 SoCs.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>   drivers/soc/qcom/llcc-qcom.c | 67 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 67 insertions(+)
> 
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 315f7a1b90aa..8e1b2399700d 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -366,6 +366,36 @@ static const struct llcc_slice_config sm8550_data[] =  {
>   	{LLCC_VIDVSP,   28,  256, 4, 1, 0xFFFFFF, 0x0,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
>   };
> 
> +static const struct llcc_slice_config qdu1000_data_2ch[] = {
> +	{ LLCC_MDMHPGRW, 7, 512, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
> +	{ LLCC_MODHW,    9, 256, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
> +	{ LLCC_MDMPNG,  21, 256, 0, 1, 0x3,   0x0, 0, 0, 0, 1, 0, 0, 0 },
> +	{ LLCC_ECC,     26, 512, 3, 1, 0xffc, 0x0, 0, 0, 0, 0, 1, 0, 0 },
> +	{ LLCC_MODPE,   29, 256, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
> +	{ LLCC_APTCM,   30, 256, 3, 1, 0x0,   0xc, 1, 0, 0, 1, 0, 0, 0 },
> +	{ LLCC_WRCACHE, 31, 128, 1, 1, 0x3,   0x0, 0, 0, 0, 0, 1, 0, 0 },
> +};
> +
> +static const struct llcc_slice_config qdu1000_data_4ch[] = {
> +	{ LLCC_MDMHPGRW, 7, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
> +	{ LLCC_MODHW,    9, 512,  1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
> +	{ LLCC_MDMPNG,  21, 512,  0, 1, 0x3,   0x0, 0, 0, 0, 1, 0, 0, 0 },
> +	{ LLCC_ECC,     26, 1024, 3, 1, 0xffc, 0x0, 0, 0, 0, 0, 1, 0, 0 },
> +	{ LLCC_MODPE,   29, 512,  1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
> +	{ LLCC_APTCM,   30, 512,  3, 1, 0x0,   0xc, 1, 0, 0, 1, 0, 0, 0 },
> +	{ LLCC_WRCACHE, 31, 256,  1, 1, 0x3,   0x0, 0, 0, 0, 0, 1, 0, 0 },
> +};
> +
> +static const struct llcc_slice_config qdu1000_data_8ch[] = {
> +	{ LLCC_MDMHPGRW, 7, 2048, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
> +	{ LLCC_MODHW,    9, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
> +	{ LLCC_MDMPNG,  21, 1024, 0, 1, 0x3,   0x0, 0, 0, 0, 1, 0, 0, 0 },
> +	{ LLCC_ECC,     26, 2048, 3, 1, 0xffc, 0x0, 0, 0, 0, 0, 1, 0, 0 },
> +	{ LLCC_MODPE,   29, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
> +	{ LLCC_APTCM,   30, 1024, 3, 1, 0x0,   0xc, 1, 0, 0, 1, 0, 0, 0 },
> +	{ LLCC_WRCACHE, 31, 512,  1, 1, 0x3,   0x0, 0, 0, 0, 0, 1, 0, 0 },
> +};
> +
>   static const struct llcc_edac_reg_offset llcc_v1_edac_reg_offset = {
>   	.trp_ecc_error_status0 = 0x20344,
>   	.trp_ecc_error_status1 = 0x20348,
> @@ -432,6 +462,37 @@ static const u32 llcc_v2_1_reg_offset[] = {
>   	[LLCC_COMMON_STATUS0]	= 0x0003400c,
>   };
> 
> +static const struct qcom_llcc_config qdu1000_cfg[] = {
> +	{
> +		.sct_data       = qdu1000_data_8ch,
> +		.size		= ARRAY_SIZE(qdu1000_data_8ch),
> +		.need_llcc_cfg	= true,
> +		.reg_offset	= llcc_v2_1_reg_offset,
> +		.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
> +	},
> +	{
> +		.sct_data       = qdu1000_data_4ch,
> +		.size           = ARRAY_SIZE(qdu1000_data_4ch),
> +		.need_llcc_cfg  = true,
> +		.reg_offset     = llcc_v2_1_reg_offset,
> +		.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
> +	},
> +	{
> +		.sct_data       = qdu1000_data_4ch,
> +		.size           = ARRAY_SIZE(qdu1000_data_4ch),
> +		.need_llcc_cfg  = true,
> +		.reg_offset     = llcc_v2_1_reg_offset,
> +		.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
> +	},
> +	{
> +		.sct_data       = qdu1000_data_2ch,
> +		.size           = ARRAY_SIZE(qdu1000_data_2ch),
> +		.need_llcc_cfg  = true,
> +		.reg_offset     = llcc_v2_1_reg_offset,
> +		.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
> +	},
> +};
> +
>   static const struct qcom_llcc_config sc7180_cfg[] = {
>   	{
>   		.sct_data	= sc7180_data,
> @@ -553,6 +614,11 @@ static const struct qcom_llcc_config sm8550_cfg[] = {
>   	},
>   };
> 
> +static const struct qcom_sct_config qdu1000_cfgs = {
> +	.llcc_config	= qdu1000_cfg,
> +	.num_config	= 4,

looks like you missed to take konrad suggestion here

https://lore.kernel.org/lkml/2a68b891-b855-1998-3eaf-a21473da0851@linaro.org/

-Mukesh

> +};
> +
>   static const struct qcom_sct_config sc7180_cfgs = {
>   	.llcc_config	= sc7180_cfg,
>   	.num_config	= ARRAY_SIZE(sc7180_cfg),
> @@ -1171,6 +1237,7 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>   }
> 
>   static const struct of_device_id qcom_llcc_of_match[] = {
> +	{ .compatible = "qcom,qdu1000-llcc", .data = &qdu1000_cfgs},
>   	{ .compatible = "qcom,sc7180-llcc", .data = &sc7180_cfgs },
>   	{ .compatible = "qcom,sc7280-llcc", .data = &sc7280_cfgs },
>   	{ .compatible = "qcom,sc8180x-llcc", .data = &sc8180x_cfgs },
> --
> 2.41.0
> 

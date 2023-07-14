Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996BE753111
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbjGNFUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbjGNFUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:20:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0E42708;
        Thu, 13 Jul 2023 22:19:59 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36E58iLr016249;
        Fri, 14 Jul 2023 05:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mAK+nMiSDYYDFPw1jANolZTo85kOM5LA/GlpGJ8tLLY=;
 b=a78aEyav64993u5TbbeUFdKBtPgBHJg+RshlP+ZqRacn4kBm1cP7s8sZC9P7L/cVmyvy
 N5Eq7DSe1s2iIYRZ/dIDAVSSE0Cext2ltDKaNFV86DF+fSIVz5IcySHz57YvensMiQ2j
 +6VoTqdcKAR1uOmN6E6IkbKtmXpUOkLN8DT8Tq6yLgsTC60Hb5zjzSsBBbhDeoYHV6nc
 gvH/f5/9sAizTG7QKB2xB+qsXCTwfULXN33aIoXWJB9O4F3lC0ApcuPoD3lN055nJbiK
 SI0TMvfwCg4S+gnBC7gngjRi2r8FohaNb6pQwv8pAW+FPaBBv3CfO4H86lhqt8+o5yFn ig== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtpub8wkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 05:19:55 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36E5JsJa028068
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 05:19:54 GMT
Received: from [10.216.27.244] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 13 Jul
 2023 22:19:47 -0700
Message-ID: <0019f59c-236f-4db9-825d-51bb9d655542@quicinc.com>
Date:   Fri, 14 Jul 2023 10:49:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V3 6/6] clk: qcom: gcc-qdu1000: Update the RCGs ops
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230706105045.633076-1-quic_imrashai@quicinc.com>
 <20230706105045.633076-7-quic_imrashai@quicinc.com>
 <fa24eaa0-c363-0694-76be-c14eba6999a1@linaro.org>
Content-Language: en-US
From:   Imran Shaik <quic_imrashai@quicinc.com>
In-Reply-To: <fa24eaa0-c363-0694-76be-c14eba6999a1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DedRZOuI1EZUVU5ZY0PaP7vjQZEn3eRY
X-Proofpoint-GUID: DedRZOuI1EZUVU5ZY0PaP7vjQZEn3eRY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_02,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140048
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/6/2023 7:46 PM, Dmitry Baryshkov wrote:
> On 06/07/2023 13:50, Imran Shaik wrote:
>> Update the SDCC clock RCG ops to floor_ops to avoid overclocking issues
> 
> Split, please.
> 

Sure, will split this patch in next series.

>> and remaining RCGs to shared_ops to park them at safe clock(XO) during
>> disable.
> 
> Why are you doing this, is there any issue? Previously we had only a 
> several clocks implemented this way, which were really shared with other 
> subsystems (this is the where name _shared_ops comes from).
> 

 From our clock hardware side, the expectation is to park the RCGs at XO 
for most of the clocks and the shared_ops is the closest implementation 
for the same. Hence updating the RCG ops to clk_rcg2_shared_ops.

Thanks,
Imran

>>
>> Co-developed-by: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>> Changes since v2:
>>   - None
>> Changes since v1:
>>   - Newly added
>>
>>   drivers/clk/qcom/gcc-qdu1000.c | 62 +++++++++++++++++-----------------
>>   1 file changed, 31 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/clk/qcom/gcc-qdu1000.c 
>> b/drivers/clk/qcom/gcc-qdu1000.c
>> index 718c34dca6e8..de35cdc93732 100644
>> --- a/drivers/clk/qcom/gcc-qdu1000.c
>> +++ b/drivers/clk/qcom/gcc-qdu1000.c
>> @@ -475,7 +475,7 @@ static struct clk_rcg2 
>> gcc_aggre_noc_ecpri_dma_clk_src = {
>>           .name = "gcc_aggre_noc_ecpri_dma_clk_src",
>>           .parent_data = gcc_parent_data_4,
>>           .num_parents = ARRAY_SIZE(gcc_parent_data_4),
>> -        .ops = &clk_rcg2_ops,
>> +        .ops = &clk_rcg2_shared_ops,
>>       },
>>   };
>> @@ -495,7 +495,7 @@ static struct clk_rcg2 
>> gcc_aggre_noc_ecpri_gsi_clk_src = {
>>           .name = "gcc_aggre_noc_ecpri_gsi_clk_src",
>>           .parent_data = gcc_parent_data_5,
>>           .num_parents = ARRAY_SIZE(gcc_parent_data_5),
>> -        .ops = &clk_rcg2_ops,
>> +        .ops = &clk_rcg2_shared_ops,
>>       },
>>   };
>> @@ -514,7 +514,7 @@ static struct clk_rcg2 gcc_gp1_clk_src = {
>>           .name = "gcc_gp1_clk_src",
>>           .parent_data = gcc_parent_data_1,
>>           .num_parents = ARRAY_SIZE(gcc_parent_data_1),
>> -        .ops = &clk_rcg2_ops,
>> +        .ops = &clk_rcg2_shared_ops,
>>       },
>>   };
>> @@ -528,7 +528,7 @@ static struct clk_rcg2 gcc_gp2_clk_src = {
>>           .name = "gcc_gp2_clk_src",
>>           .parent_data = gcc_parent_data_1,
>>           .num_parents = ARRAY_SIZE(gcc_parent_data_1),
>> -        .ops = &clk_rcg2_ops,
>> +        .ops = &clk_rcg2_shared_ops,
>>       },
>>   };
>> @@ -542,7 +542,7 @@ static struct clk_rcg2 gcc_gp3_clk_src = {
>>           .name = "gcc_gp3_clk_src",
>>           .parent_data = gcc_parent_data_1,
>>           .num_parents = ARRAY_SIZE(gcc_parent_data_1),
>> -        .ops = &clk_rcg2_ops,
>> +        .ops = &clk_rcg2_shared_ops,
>>       },
>>   };
>> @@ -561,7 +561,7 @@ static struct clk_rcg2 gcc_pcie_0_aux_clk_src = {
>>           .name = "gcc_pcie_0_aux_clk_src",
>>           .parent_data = gcc_parent_data_3,
>>           .num_parents = ARRAY_SIZE(gcc_parent_data_3),
>> -        .ops = &clk_rcg2_ops,
>> +        .ops = &clk_rcg2_shared_ops,
>>       },
>>   };
>> @@ -581,7 +581,7 @@ static struct clk_rcg2 
>> gcc_pcie_0_phy_rchng_clk_src = {
>>           .name = "gcc_pcie_0_phy_rchng_clk_src",
>>           .parent_data = gcc_parent_data_0,
>>           .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -        .ops = &clk_rcg2_ops,
>> +        .ops = &clk_rcg2_shared_ops,
>>       },
>>   };
>> @@ -600,7 +600,7 @@ static struct clk_rcg2 gcc_pdm2_clk_src = {
>>           .name = "gcc_pdm2_clk_src",
>>           .parent_data = gcc_parent_data_0,
>>           .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -        .ops = &clk_rcg2_ops,
>> +        .ops = &clk_rcg2_shared_ops,
>>       },
>>   };
>> @@ -622,7 +622,7 @@ static struct clk_init_data 
>> gcc_qupv3_wrap0_s0_clk_src_init = {
>>       .name = "gcc_qupv3_wrap0_s0_clk_src",
>>       .parent_data = gcc_parent_data_0,
>>       .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -    .ops = &clk_rcg2_ops,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap0_s0_clk_src = {
>> @@ -638,7 +638,7 @@ static struct clk_init_data 
>> gcc_qupv3_wrap0_s1_clk_src_init = {
>>       .name = "gcc_qupv3_wrap0_s1_clk_src",
>>       .parent_data = gcc_parent_data_0,
>>       .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -    .ops = &clk_rcg2_ops,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap0_s1_clk_src = {
>> @@ -654,7 +654,7 @@ static struct clk_init_data 
>> gcc_qupv3_wrap0_s2_clk_src_init = {
>>       .name = "gcc_qupv3_wrap0_s2_clk_src",
>>       .parent_data = gcc_parent_data_0,
>>       .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -    .ops = &clk_rcg2_ops,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap0_s2_clk_src = {
>> @@ -670,7 +670,7 @@ static struct clk_init_data 
>> gcc_qupv3_wrap0_s3_clk_src_init = {
>>       .name = "gcc_qupv3_wrap0_s3_clk_src",
>>       .parent_data = gcc_parent_data_0,
>>       .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -    .ops = &clk_rcg2_ops,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap0_s3_clk_src = {
>> @@ -686,7 +686,7 @@ static struct clk_init_data 
>> gcc_qupv3_wrap0_s4_clk_src_init = {
>>       .name = "gcc_qupv3_wrap0_s4_clk_src",
>>       .parent_data = gcc_parent_data_0,
>>       .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -    .ops = &clk_rcg2_ops,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap0_s4_clk_src = {
>> @@ -707,7 +707,7 @@ static struct clk_init_data 
>> gcc_qupv3_wrap0_s5_clk_src_init = {
>>       .name = "gcc_qupv3_wrap0_s5_clk_src",
>>       .parent_data = gcc_parent_data_0,
>>       .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -    .ops = &clk_rcg2_ops,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap0_s5_clk_src = {
>> @@ -723,7 +723,7 @@ static struct clk_init_data 
>> gcc_qupv3_wrap0_s6_clk_src_init = {
>>       .name = "gcc_qupv3_wrap0_s6_clk_src",
>>       .parent_data = gcc_parent_data_0,
>>       .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -    .ops = &clk_rcg2_ops,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap0_s6_clk_src = {
>> @@ -739,7 +739,7 @@ static struct clk_init_data 
>> gcc_qupv3_wrap0_s7_clk_src_init = {
>>       .name = "gcc_qupv3_wrap0_s7_clk_src",
>>       .parent_data = gcc_parent_data_0,
>>       .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -    .ops = &clk_rcg2_ops,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap0_s7_clk_src = {
>> @@ -755,7 +755,7 @@ static struct clk_init_data 
>> gcc_qupv3_wrap1_s0_clk_src_init = {
>>       .name = "gcc_qupv3_wrap1_s0_clk_src",
>>       .parent_data = gcc_parent_data_0,
>>       .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -    .ops = &clk_rcg2_ops,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap1_s0_clk_src = {
>> @@ -771,7 +771,7 @@ static struct clk_init_data 
>> gcc_qupv3_wrap1_s1_clk_src_init = {
>>       .name = "gcc_qupv3_wrap1_s1_clk_src",
>>       .parent_data = gcc_parent_data_0,
>>       .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -    .ops = &clk_rcg2_ops,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap1_s1_clk_src = {
>> @@ -787,7 +787,7 @@ static struct clk_init_data 
>> gcc_qupv3_wrap1_s2_clk_src_init = {
>>       .name = "gcc_qupv3_wrap1_s2_clk_src",
>>       .parent_data = gcc_parent_data_0,
>>       .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -    .ops = &clk_rcg2_ops,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap1_s2_clk_src = {
>> @@ -803,7 +803,7 @@ static struct clk_init_data 
>> gcc_qupv3_wrap1_s3_clk_src_init = {
>>       .name = "gcc_qupv3_wrap1_s3_clk_src",
>>       .parent_data = gcc_parent_data_0,
>>       .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -    .ops = &clk_rcg2_ops,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap1_s3_clk_src = {
>> @@ -819,7 +819,7 @@ static struct clk_init_data 
>> gcc_qupv3_wrap1_s4_clk_src_init = {
>>       .name = "gcc_qupv3_wrap1_s4_clk_src",
>>       .parent_data = gcc_parent_data_0,
>>       .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -    .ops = &clk_rcg2_ops,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap1_s4_clk_src = {
>> @@ -835,7 +835,7 @@ static struct clk_init_data 
>> gcc_qupv3_wrap1_s5_clk_src_init = {
>>       .name = "gcc_qupv3_wrap1_s5_clk_src",
>>       .parent_data = gcc_parent_data_0,
>>       .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -    .ops = &clk_rcg2_ops,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap1_s5_clk_src = {
>> @@ -851,7 +851,7 @@ static struct clk_init_data 
>> gcc_qupv3_wrap1_s6_clk_src_init = {
>>       .name = "gcc_qupv3_wrap1_s6_clk_src",
>>       .parent_data = gcc_parent_data_0,
>>       .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -    .ops = &clk_rcg2_ops,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap1_s6_clk_src = {
>> @@ -867,7 +867,7 @@ static struct clk_init_data 
>> gcc_qupv3_wrap1_s7_clk_src_init = {
>>       .name = "gcc_qupv3_wrap1_s7_clk_src",
>>       .parent_data = gcc_parent_data_0,
>>       .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -    .ops = &clk_rcg2_ops,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap1_s7_clk_src = {
>> @@ -903,7 +903,7 @@ static struct clk_rcg2 gcc_sdcc5_apps_clk_src = {
>>           .name = "gcc_sdcc5_apps_clk_src",
>>           .parent_data = gcc_parent_data_8,
>>           .num_parents = ARRAY_SIZE(gcc_parent_data_8),
>> -        .ops = &clk_rcg2_ops,
>> +        .ops = &clk_rcg2_floor_ops,
>>       },
>>   };
>> @@ -922,7 +922,7 @@ static struct clk_rcg2 gcc_sdcc5_ice_core_clk_src = {
>>           .name = "gcc_sdcc5_ice_core_clk_src",
>>           .parent_data = gcc_parent_data_2,
>>           .num_parents = ARRAY_SIZE(gcc_parent_data_2),
>> -        .ops = &clk_rcg2_ops,
>> +        .ops = &clk_rcg2_floor_ops,
>>       },
>>   };
>> @@ -936,7 +936,7 @@ static struct clk_rcg2 gcc_sm_bus_xo_clk_src = {
>>           .name = "gcc_sm_bus_xo_clk_src",
>>           .parent_data = gcc_parent_data_2,
>>           .num_parents = ARRAY_SIZE(gcc_parent_data_2),
>> -        .ops = &clk_rcg2_ops,
>> +        .ops = &clk_rcg2_shared_ops,
>>       },
>>   };
>> @@ -955,7 +955,7 @@ static struct clk_rcg2 gcc_tsc_clk_src = {
>>           .name = "gcc_tsc_clk_src",
>>           .parent_data = gcc_parent_data_9,
>>           .num_parents = ARRAY_SIZE(gcc_parent_data_9),
>> -        .ops = &clk_rcg2_ops,
>> +        .ops = &clk_rcg2_shared_ops,
>>       },
>>   };
>> @@ -975,7 +975,7 @@ static struct clk_rcg2 
>> gcc_usb30_prim_master_clk_src = {
>>           .name = "gcc_usb30_prim_master_clk_src",
>>           .parent_data = gcc_parent_data_0,
>>           .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -        .ops = &clk_rcg2_ops,
>> +        .ops = &clk_rcg2_shared_ops,
>>       },
>>   };
>> @@ -989,7 +989,7 @@ static struct clk_rcg2 
>> gcc_usb30_prim_mock_utmi_clk_src = {
>>           .name = "gcc_usb30_prim_mock_utmi_clk_src",
>>           .parent_data = gcc_parent_data_0,
>>           .num_parents = ARRAY_SIZE(gcc_parent_data_0),
>> -        .ops = &clk_rcg2_ops,
>> +        .ops = &clk_rcg2_shared_ops,
>>       },
>>   };
>> @@ -1003,7 +1003,7 @@ static struct clk_rcg2 
>> gcc_usb3_prim_phy_aux_clk_src = {
>>           .name = "gcc_usb3_prim_phy_aux_clk_src",
>>           .parent_data = gcc_parent_data_3,
>>           .num_parents = ARRAY_SIZE(gcc_parent_data_3),
>> -        .ops = &clk_rcg2_ops,
>> +        .ops = &clk_rcg2_shared_ops,
>>       },
>>   };
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E717F72A8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 12:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344808AbjKXLZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 06:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjKXLZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 06:25:03 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467AA10F1;
        Fri, 24 Nov 2023 03:25:09 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AO65kVg030441;
        Fri, 24 Nov 2023 11:25:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cU3i0if0uj1/U3YTw/bULzJG89OYtknDdvsSeSeTMFQ=;
 b=VsaGrL97RnHw5QlYg3jWT/LhBUCK4pGxvpJyUxcA5RbH6kKOhUic8bnpU6u5wr+Qw2/C
 hywESInjIqZXl6ib1VUeP42uhK5NXGnVHL9SGVoigF0h+3DrAIaTb7AIcuUyrQ5Ic2NS
 13arb7dLmMEko3m3OlRfzwfEGggXeGnSxosEkqv4/+hwF+twZtPOzY8NJAKrIdycbYJR
 8KghOQwCMOuJRv5SK2DPe4YzJg46avQqh5iuZo3w6P5PUCnY4n9nrs1vjuY1/IXhjV4r
 gsOWzyKWgfthw92S99AijzZXRdRYnaNaTsH2E7TPU0MFCeOl1O4YZhflMd3xstVGO4fN gg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ujp8x0vd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 11:25:04 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AOBP3GJ001801
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 11:25:03 GMT
Received: from [10.218.19.46] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 24 Nov
 2023 03:25:00 -0800
Message-ID: <a2137dac-9660-53ae-8950-4902c05a3f66@quicinc.com>
Date:   Fri, 24 Nov 2023 16:54:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] clk: qcom: gpucc-sm8150: Update the gpu_cc_pll1 config
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231122042814.4158076-1-quic_skakitap@quicinc.com>
 <2b619607-1219-46db-a439-0f087b8b5d3b@linaro.org>
From:   "Satya Priya Kakitapalli (Temp)" <quic_skakitap@quicinc.com>
In-Reply-To: <2b619607-1219-46db-a439-0f087b8b5d3b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ydM-1n_1jOPXzMw-NiIRuY0MrpUlZy96
X-Proofpoint-ORIG-GUID: ydM-1n_1jOPXzMw-NiIRuY0MrpUlZy96
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=537 clxscore=1015 spamscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311240089
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/22/2023 9:32 PM, Konrad Dybcio wrote:
>
>
> On 11/22/23 05:28, Satya Priya Kakitapalli wrote:
>> Update the test_ctl_hi_val and test_ctl_hi1_val of gpu_cc_pll1
>> as per latest HW recommendation.
> IIRC there is SM8150 v2.1 that's there on most devices and v2.2
> that was used on the Microsoft Duo (or v2.0 and v2.1 respectively,
> not sure, don't have any device on hand to read it back), do these
> settings apply to both? Are they different for mobile vs auto?
>

Yes these settings apply to all v2.x devices, also they are same for 
auto and mobile.


> Konrad

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FC1798401
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 10:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240755AbjIHI11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 04:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbjIHI10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:27:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8460173B;
        Fri,  8 Sep 2023 01:27:22 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38861vnW009023;
        Fri, 8 Sep 2023 08:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=H3IHBoAbaYpHx/KPzKw5/tL5DYBjBx4c9td7Z4bv+Ys=;
 b=FaCUdqG7Xw0pk0/OWEgPcJ9DQHehtbOTTqpaEUdXIdC0/tTbSn3X9/eZjsckCawpM6Yz
 nTcn5CiO7a1kFm1avak9n/M2yNjDyauwIJq+13Yn1tGh4pCbnn3+cSqyB0argRACVAo+
 hMOtW7YBrwoCMSo03SJD/8hhbnnuse0wKb4VjEabVyD1KsQlo2CGyqCisakfLmgegPFV
 w6e9oC/KIthu49KJpW+96npw/av9i9VdBcBCwIqleY9xNPYfOc/9mIHdZy3TlQCIC05e
 bw+13FoqNW9Ee5bqUr9xxnZaYGrygEPyga3nq9Iqzpr47zylyAirG2JwvNaHcVa8Tmst Xg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3syf5c25q2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 08:26:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3888QvwO029165
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 08:26:57 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 8 Sep
 2023 01:26:49 -0700
Message-ID: <edc7df5b-0853-4bd9-aef8-6a37b2a5eb36@quicinc.com>
Date:   Fri, 8 Sep 2023 16:26:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] interconnect: qcom: Add SM4450 interconnect provider
 driver
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <djakov@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <arnd@arndb.de>, <geert+renesas@glider.be>,
        <nfraprado@collabora.com>, <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_tsoni@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tdas@quicinc.com>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <kernel@quicinc.com>
References: <20230908064427.26999-1-quic_tengfan@quicinc.com>
 <20230908064427.26999-3-quic_tengfan@quicinc.com>
 <d78b19ef-0fb7-4fc3-bf01-58c10b4fd1cd@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <d78b19ef-0fb7-4fc3-bf01-58c10b4fd1cd@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DEdgzWvoRsg7TsOp2ChAHQHPlfEIKctS
X-Proofpoint-ORIG-GUID: DEdgzWvoRsg7TsOp2ChAHQHPlfEIKctS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_05,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 9/8/2023 4:16 PM, Konrad Dybcio 写道:
> On 8.09.2023 08:44, Tengfei Fan wrote:
>> Add driver for the Qualcomm interconnect buses found in SM4450 based
>> platforms. The topology consists of several NoCs that are controlled
>> by a remote processor that collects the aggregated bandwidth for each
>> master-slave pairs.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
> [...]
> 
>> +++ b/drivers/interconnect/qcom/sm4450.c
>> @@ -0,0 +1,1848 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>> + *
> Stray blank line
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/interconnect.h>
>> +#include <linux/interconnect-provider.h>
>> +#include <linux/io.h>
> Is this necessary?
> 
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +#include <dt-bindings/interconnect/qcom,sm4450.h>
>> +
> [...]
> 
>> +static struct qcom_icc_node * const mmss_noc_nodes[] = {
>> +	[MASTER_CAMNOC_HF] = &qnm_camnoc_hf,
>> +	[MASTER_CAMNOC_ICP] = &qnm_camnoc_icp,
>> +	[MASTER_CAMNOC_SF] = &qnm_camnoc_sf,
>> +	[MASTER_MDP] = &qnm_mdp,
>> +	[MASTER_CNOC_MNOC_CFG] = &qnm_mnoc_cfg,
>> +	[MASTER_VIDEO_P0_MMNOC] = &qnm_video0,
>> +	[MASTER_VIDEO_PROC_MMNOC] = &qnm_video_cpu,
>> +	[SLAVE_MNOC_HF_MEM_NOC] = &qns_mem_noc_hf,
>> +	[SLAVE_MNOC_SF_MEM_NOC] = &qns_mem_noc_sf,
>> +	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
>> +	[MASTER_MDP_DISP] = &qnm_mdp_disp,
>> +	[SLAVE_MNOC_HF_MEM_NOC_DISP] = &qns_mem_noc_hf_disp,
> Please drop the _DISP paths, upstream will handle these with icc
> tags.
sure, will handle this.
> 
> [...]
> 
>> +
>> +static const struct of_device_id qnoc_of_match[] = {
>> +	{ .compatible = "qcom,sm4450-aggre1-noc",
>> +	  .data = &sm4450_aggre1_noc},
> Nit, but please:
> 
> - make these one line, like this:
> { .compatible = "qcom,sm4450-aggre1-noc", .data = &sm4450_aggre1_noc },
> 
> - add the missing space before '}'
sure, will handle this.
> 
> Konrad

-- 
Thx and BRs,
Tengfei Fan

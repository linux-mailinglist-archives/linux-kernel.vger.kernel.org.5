Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C8E7A5733
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 04:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjISCAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 22:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjISCAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 22:00:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53187114;
        Mon, 18 Sep 2023 19:00:12 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38J1WVQY019731;
        Tue, 19 Sep 2023 02:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zsCirX1ttDWrfi/3MDW7a7BIKkKlRpavbxSBZngcSA8=;
 b=M4xgUugSEFAYbKzEc/oFw5QmfXbGcTO54Q3aAdezvQexmEI0rx1F0ksfj7hilsoMlwDl
 d9sdAmbG+SB485qRqX484ZEkFCWtuZRsZHC10X1vAMd47o7zaV1Zb4ElMRP7YjTvGj73
 HfHAjogk80GR0k0FnCXeq5/KKYwGuY5DwO8KaRRBFJJdStjnlsUERA/Viz38zzz+jGX5
 KJ98j7LQ2cUo5tuj0CGogKZXFCpyWpUlpcXbCl37FifsAfSha0fc8PkD6jhY08hY41zb
 G+pWyeDifXkHnq3d1yn8Ks+1WBE+LCGbP3wE0+UGOR05sZXgsAVTx2P5muGO4A+pOFHe XQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t54f14fa2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 02:00:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38J2035u005706
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 02:00:03 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 18 Sep
 2023 18:59:57 -0700
Message-ID: <73a90202-1127-4469-a46d-7986343c51b1@quicinc.com>
Date:   Tue, 19 Sep 2023 09:59:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] interconnect: qcom: Add SM4450 interconnect
 provider driver
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <djakov@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tsoni@quicinc.com>, <quic_shashim@quicinc.com>,
        <quic_kaushalk@quicinc.com>, <quic_tdas@quicinc.com>,
        <quic_tingweiz@quicinc.com>, <quic_aiquny@quicinc.com>,
        <kernel@quicinc.com>
References: <20230915020129.19611-1-quic_tengfan@quicinc.com>
 <20230915020129.19611-3-quic_tengfan@quicinc.com>
 <dc209ac7-7a06-449b-a198-ce6fb3ba7ff7@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <dc209ac7-7a06-449b-a198-ce6fb3ba7ff7@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZarM56oypwTRNjIaGPWSafD1tdQdkzSN
X-Proofpoint-GUID: ZarM56oypwTRNjIaGPWSafD1tdQdkzSN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_11,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=821 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190015
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 9/15/2023 8:43 PM, Konrad Dybcio 写道:
> On 15.09.2023 04:01, Tengfei Fan wrote:
>> Add driver for the Qualcomm interconnect buses found in SM4450 based
>> platforms. The topology consists of several NoCs that are controlled
>> by a remote processor that collects the aggregated bandwidth for each
>> master-slave pairs.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
> [...]
> 
>> +static struct qcom_icc_bcm bcm_acv_disp = {
>> +	.name = "ACV",
>> +	.num_nodes = 1,
>> +	.nodes = { &ebi_disp },
>> +};
>> +
>> +static struct qcom_icc_bcm bcm_mc0_disp = {
>> +	.name = "MC0",
>> +	.num_nodes = 1,
>> +	.nodes = { &ebi_disp },
>> +};
>> +
>> +static struct qcom_icc_bcm bcm_mm0_disp = {
>> +	.name = "MM0",
>> +	.num_nodes = 1,
>> +	.nodes = { &qns_mem_noc_hf_disp },
>> +};
>> +
>> +static struct qcom_icc_bcm bcm_sh0_disp = {
>> +	.name = "SH0",
>> +	.num_nodes = 1,
>> +	.nodes = { &qns_llcc_disp },
>> +};
>> +
>> +static struct qcom_icc_bcm bcm_sh1_disp = {
>> +	.name = "SH1",
>> +	.num_nodes = 1,
>> +	.nodes = { &qnm_pcie_disp },
>> +};
> """
> v1 -> v2:
>    - remove DISP related paths
> """
> 
> you sure?
> 
> + I still see _disp nodes..
> 
> Konrad

Hi Konrad,
only removed SLAVE_MNOC_HF_MEM_NOC_DISP related code actually as V1 comment.

-- 
Thx and BRs,
Tengfei Fan

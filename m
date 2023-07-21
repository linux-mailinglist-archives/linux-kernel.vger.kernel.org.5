Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120EF75BEEE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjGUGdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjGUGdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:33:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CE9113;
        Thu, 20 Jul 2023 23:33:34 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L5CcY2007317;
        Fri, 21 Jul 2023 06:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DC9f/AkivRyWRdBHdTX5l53MGYWeEg55d7aFIfliLU4=;
 b=CzW6FL7kunTgHMIr/YgwnYTacjh+loh3/jLihsPvwrtFeaEzq2AV36durAbNtzL2A005
 RVUxLy3xtwmWLMnJQqR1UeA3OmGUWJsE+lJvDll6NH5Ah3qjrvRxhVKaV69l8hcizEhm
 B9pGDG4L5FeCV09WkjBLSqyEcviEQLHjyqNd/HZTaEnvimGaCaNePhJbARvcCw9Uh35m
 5IUU2MnyBmcsaK0oyCuTIb38Zr2VTMV0E7EZ0HSNJ9HSRK94X7U2vEWj5IogbW7QMcbc
 gErC0rC6LVMnf8FuV2NEVsWL0nF3Xd9IsoZY2P5jlChTn0ZYrbLG7+IQXjVXq95edxWJ EA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ry6pv1w57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 06:33:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36L6XRVV004827
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 06:33:27 GMT
Received: from [10.216.60.229] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 23:33:20 -0700
Message-ID: <4af1abfb-9889-af13-7460-903eb94833bf@quicinc.com>
Date:   Fri, 21 Jul 2023 12:03:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [V3,09/11] remoteproc: qcom: Add Hexagon based multipd rproc
 driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_eberman@quicinc.com>, <kvalo@kernel.org>,
        <loic.poulain@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>
References: <20230718120501.3205661-1-quic_mmanikan@quicinc.com>
 <20230718120501.3205661-10-quic_mmanikan@quicinc.com>
 <c53c8fc5-a898-df1d-4626-696ffd990796@linaro.org>
Content-Language: en-US
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <c53c8fc5-a898-df1d-4626-696ffd990796@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YufzpMDROCJY4mesvDq7i8qydn3kb4O9
X-Proofpoint-ORIG-GUID: YufzpMDROCJY4mesvDq7i8qydn3kb4O9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_03,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 mlxlogscore=727
 impostorscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210058
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/2023 6:43 PM, Krzysztof Kozlowski wrote:
> On 18/07/2023 14:04, Manikanta Mylavarapu wrote:
>> It adds support to bring up remoteproc's on multipd model.
>> Pd means protection domain. It's similar to process in Linux.
>> Here QDSP6 processor runs each wifi radio functionality on a
>> separate process. One process can't access other process
>> resources, so this is termed as PD i.e protection domain.
> 
> ...
> 
>> + * User pd boot-info format mentioned below
>> + * <Version> <No of elements passing over smem> <Header type> <Header Length>
>> + * <Process Id> <Load address> <firmware mem Size>
>> + *
>> + * Returns 0 on success else negative value on failure.
>> + */
>> +static int share_upd_bootinfo_to_q6(struct rproc *rproc)
>> +{
>> +	int ret;
>> +	size_t size;
>> +	u16 cnt = 0, version;
>> +	void *ptr;
>> +	struct q6_wcss *wcss = rproc->priv, *upd_wcss;
>> +	struct device_node *upd_np;
>> +	struct platform_device *upd_pdev;
>> +	struct rproc *upd_rproc;
>> +	struct userpd_boot_info upd_bootinfo = {0};
>> +	const struct firmware *fw;
>> +
>> +	ret = qcom_smem_alloc(REMOTE_PID, UPD_BOOT_INFO_SMEM_ID,
>> +			      UPD_BOOT_INFO_SMEM_SIZE);
>> +	if (ret && ret != -EEXIST) {
>> +		dev_err(wcss->dev,
>> +			"failed to allocate q6 bootinfo smem segment\n");
>> +		return ret;
>> +	}
>> +
>> +	ptr = qcom_smem_get(REMOTE_PID, UPD_BOOT_INFO_SMEM_ID, &size);
>> +	if (IS_ERR(ptr) || size != UPD_BOOT_INFO_SMEM_SIZE) {
>> +		dev_err(wcss->dev,
>> +			"Unable to acquire smp2p item(%d) ret:%ld\n",
>> +			UPD_BOOT_INFO_SMEM_ID, PTR_ERR(ptr));
>> +		return PTR_ERR(ptr);
>> +	}
>> +
>> +	/* print physical address */
>> +	dev_info(wcss->dev,
>> +		 "smem phyiscal address:0x%lX\n",
>> +		 (uintptr_t)qcom_smem_virt_to_phys(ptr));
> 
> One more thought. Why do you need it? Even if this is not a kernel or
> user-space address, why would like to disclose the memory layout? I
> think this is contradictory to the kptr_restrict concept.
> 

Sure, I will remove.

Thanks & Regards,
Manikanta.

>> +
>> +	/*Version*/
> 
> 
> 
> Best regards,
> Krzysztof
> 

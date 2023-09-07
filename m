Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4436B797EB6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 00:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbjIGWcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 18:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjIGWck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 18:32:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4DA1BC7;
        Thu,  7 Sep 2023 15:32:36 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387MMhcw007068;
        Thu, 7 Sep 2023 22:32:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6F+DQoDUe0Wh4jBEZEoSBtB0wVZJMrv7jHU5op/krs4=;
 b=PQIUSmLWA6CpyCvjt7Mtv4GO+c4J8USmf4abzh9m2imkmtjsk9o4plIlGrVsy954IYkh
 nAOlubAiOPHt6YQC4KFTBG5GdSIX80AjPGE62g0u9VkcN2qJc8b9KrjHUxhCD8F0l4zi
 99D16TYeWEWNP0NuoLJ8t9rRyiLQ5gIbXZobzpO5qdiq9Jbl2znYTvB3dh0Yr9DFU7VR
 xInBpihc7sBlo9VKVz5EA2jw0USx7dPum8JU+Sjq3xugLVThxKa7GyGd4w7X0WUaJiOv
 i+pNQJjpk34Pr5OogcV049y+9468C5kdAl64hXLi7+Ve6+HRJMpqqehKOkuLjv2hlpUw ng== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sy951j2ch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 22:32:24 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 387MWN12020795
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Sep 2023 22:32:23 GMT
Received: from [10.110.56.75] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 7 Sep
 2023 15:32:22 -0700
Message-ID: <73b91770-f7f4-3a04-77a9-86eb3332d202@quicinc.com>
Date:   Thu, 7 Sep 2023 15:32:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/2] Add qcom hvc/shmem transport
To:     Konrad Dybcio <konradybcio@kernel.org>, <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <3cc438c8-295e-461b-a842-c6d0f268fe9e@kernel.org>
Content-Language: en-US
From:   Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <3cc438c8-295e-461b-a842-c6d0f268fe9e@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NEfPHLwN3_sCrmO36fO53jQaXl9oZJXE
X-Proofpoint-ORIG-GUID: NEfPHLwN3_sCrmO36fO53jQaXl9oZJXE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=977 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070200
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/7/2023 9:16 AM, Konrad Dybcio wrote:
> On 18.07.2023 18:08, Nikunj Kela wrote:
>> This change introduce a new transport channel for Qualcomm virtual
>> platforms. The transport is mechanically similar to ARM_SCMI_TRANSPORT_SMC.
>> The difference between the two transports is that a parameter is passed in
>> the hypervisor call to identify which doorbell to assert. This parameter is
>> dynamically generated at runtime on the device and insuitable to pass via
>> the devicetree.
>>
>> The function ID and parameter are stored by firmware in the shmem region.
>>
>> This has been tested on ARM64 virtual Qualcomm platform.
> What can we test it on?
>
> Konrad
This is being developed for SA8775p platform.

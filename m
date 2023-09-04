Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72B4791B18
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 18:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353282AbjIDQDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 12:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjIDQDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 12:03:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3BB1B9;
        Mon,  4 Sep 2023 09:03:12 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 384FrgwO018441;
        Mon, 4 Sep 2023 16:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1oinIisGDKcccUB6YSwO/UclkDuoNOEnKF5LMZowPdI=;
 b=f6CuBwft+GOge1bnE+3w+4GJDCFgJFKP2JzSyLMYj9JK6rJ1lv3wpfK1Xoe9H7LndOLH
 Pz+m/IKsTrdWIoR27FeVqBAn0k7tm2H218hG4EXLXBpRv/p7J4uWzw9HIFF6DRQ1JINB
 dSzhyiA/I3YDGJVCjDiu9MRPzuzGhYbKmzHGZ7Om0o7XRaP6j8YdgaHhp7Sw1zCgXIyC
 9ye9JhRzD6i0Pd8bsMeEKTr47fiVvdG3WpEMhZVRGDZyRahM9wTe4CCffbNGq8Ecu068
 xPomSMq5BqUJMJAW61r5iUtmOh0BRuTjCOjzL1xWmahV/DuHa4zjy70l44gM+j46wtFV Jw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suw99c9gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 16:03:04 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 384G33Jp001477
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Sep 2023 16:03:03 GMT
Received: from [10.50.40.93] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 4 Sep
 2023 09:02:58 -0700
Message-ID: <f914c4fa-d314-4ae7-a143-1785a8c02f04@quicinc.com>
Date:   Mon, 4 Sep 2023 21:32:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: Fix hwlock index for SMEM for IPQ
 platforms
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>
References: <20230904063344.4144086-1-quic_viswanat@quicinc.com>
 <9febd543-0de4-40f4-8e5a-4ad89b86eebf@linaro.org>
Content-Language: en-US
From:   Vignesh Viswanathan <quic_viswanat@quicinc.com>
In-Reply-To: <9febd543-0de4-40f4-8e5a-4ad89b86eebf@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8Y77u2fDHGNN0bjkQkhM2p6iP6-IMYgL
X-Proofpoint-ORIG-GUID: 8Y77u2fDHGNN0bjkQkhM2p6iP6-IMYgL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_09,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 bulkscore=0 mlxlogscore=580 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309040143
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/2023 9:27 PM, Konrad Dybcio wrote:
> On 4.09.2023 08:33, Vignesh Viswanathan wrote:
>> SMEM uses lock index 3 of the TCSR Mutex hwlock for allocations
>> in SMEM region shared by the Host and FW.
>>
>> Fix the SMEM hwlock index to 3 for IPQ5332, IPQ6018, IPQ8074 and IPQ9574.
>>
>> Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
>> ---
> Please make it a separate patch for each one. Somebody trying to revert
> this in the future will have to potentially resolve 4 conflicts in this
> current form.
> 
Ack, will split with Fixes tag in V2.

Thanks,
Vignesh

> Konrad

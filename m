Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CE876C8E6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjHBJAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjHBJAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:00:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53FF115;
        Wed,  2 Aug 2023 02:00:40 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3724Y6ej022364;
        Wed, 2 Aug 2023 09:00:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=n2H3++VwuuWxG88O+gvsJuTcEr7Ar4wIkbAH5+PfnRM=;
 b=S2qZg6u5yOeVpjj4xSwdGfA404dymU00N5Hhpdwx93a1rSTCXFCs8D+DyeqjpVo9Z5lp
 gfl/AVdjDB7j9WfJPIIPNl3CiP2jYgm+kgwCa20C1XNLJUUXK5Z2OKqzMCiNBrOwAfEj
 8caCBzAG+DEs3hhdFYnz3pMpWgrNNUCQl2kesfN+VksJKO7Au1jlX4Bpq8H234Ui0JC/
 iGb7NNsTLPbIkJh1+vHPyFbp1Cp7NSgF/j7uifOsbMqVgto0eK9MzhD/cNRG6KgBbwWM
 m95jA2IfhTI3sYdvR0+OBX08vp0pL2T6nmzRaybdblyMtuYFGdNg0+wqYmbKU9+63mCv Ww== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s75b31xcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 09:00:37 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37290a9u017179
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 09:00:36 GMT
Received: from [10.214.67.128] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 2 Aug
 2023 02:00:32 -0700
Message-ID: <3ed4b1c1-bd1d-3b88-49ad-4eeb0fd6b83d@quicinc.com>
Date:   Wed, 2 Aug 2023 14:30:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 6/6] soc: qcom: llcc: Add QDU1000 and QRU1000 LLCC
 support
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230724084155.8682-1-quic_kbajaj@quicinc.com>
 <20230724084155.8682-7-quic_kbajaj@quicinc.com>
 <34868b94-abe3-aa67-fb76-35d9a2481cfd@quicinc.com>
 <2a68b891-b855-1998-3eaf-a21473da0851@linaro.org>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <2a68b891-b855-1998-3eaf-a21473da0851@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: flAgz96zKyghite3BKYb1qkvjCvnp5mT
X-Proofpoint-ORIG-GUID: flAgz96zKyghite3BKYb1qkvjCvnp5mT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_03,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 mlxlogscore=798 bulkscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020079
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/2023 6:25 PM, Konrad Dybcio wrote:
> On 24.07.2023 14:45, Mukesh Ojha wrote:
>>
>> On 7/24/2023 2:11 PM, Komal Bajaj wrote:
>>> Add LLCC configuration data for QDU1000 and QRU1000 SoCs.
>>>
>>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>>> ---
> [...]
>
>>>    static const struct qcom_sct_config sc7180_cfgs = {
>>>        .llcc_config    = sc7180_cfg,
>>>        .num_cfgs    = 1,
>>> @@ -611,6 +672,11 @@ static const struct qcom_sct_config sm8550_cfgs = {
>>>        .num_cfgs    = 1,
>>>    };
>>>    +static const struct qcom_sct_config qdu1000_cfgs = {
>>> +    .llcc_config    = qdu1000_cfg,
>>> +    .num_cfgs    = 1,
>>
>> Should not this be 4 ?
> Even better, use ARRAY_SIZE(name_of_arr)

Yes, Thanks for suggesting it.

-Komal

>
> Konrad


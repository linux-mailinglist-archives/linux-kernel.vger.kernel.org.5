Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3707A1755
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjIOH0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjIOH0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:26:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB04170E;
        Fri, 15 Sep 2023 00:26:26 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38F5m0pM022659;
        Fri, 15 Sep 2023 07:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Q2y1vB9/nEJ316+CPedZ4jQOttq3EObW8nIvIUnXxs0=;
 b=k5yS6RKtnsdZx4k2aqlMEouwwsEUA5x26pvYy2GD2iydkFt5RQBe5o4ihhOWNZA95sIZ
 7ZqXfig6l6GDSycnGgWKurgzQtSGicll+ML7mnsCJJmMOW8iGbc9Cg2xIWC+W2SzXSIP
 zn9VF5sDgrCE14hHI5RmVOlzn6ImG/ikOx/mZ1AiKTggfhGIXwcnfNjPSVMChxoQx9RK
 PrxU87sQNgH0rzy6SlByfhmrIfMV76+SmgSriV+8T8pJHnMZqRjLjI9+2QhTucC9B8JV
 S5HZSTx7PmNUZV1VPjrPuOnLRj+cis2DN2ZBDgP5+bqHjcHA6bDUx9U0TgCAHgnBgjMs Sw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4fwn0cu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 07:26:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38F7QAh5012377
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 07:26:10 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 15 Sep
 2023 00:26:03 -0700
Message-ID: <f683eb4a-f48e-4214-a700-92c171d512fa@quicinc.com>
Date:   Fri, 15 Sep 2023 15:26:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: interconnect: Add Qualcomm SM4450
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tsoni@quicinc.com>, <quic_shashim@quicinc.com>,
        <quic_kaushalk@quicinc.com>, <quic_tdas@quicinc.com>,
        <quic_tingweiz@quicinc.com>, <quic_aiquny@quicinc.com>,
        <kernel@quicinc.com>
References: <20230915020129.19611-1-quic_tengfan@quicinc.com>
 <20230915020129.19611-2-quic_tengfan@quicinc.com>
 <a48d1d09-e967-3226-7173-4e2a58ffae1d@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <a48d1d09-e967-3226-7173-4e2a58ffae1d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jDhv8GE9QwzX6iEM8o6qSepsIfAF8g8d
X-Proofpoint-ORIG-GUID: jDhv8GE9QwzX6iEM8o6qSepsIfAF8g8d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_05,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 spamscore=0 mlxlogscore=758 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150064
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 9/15/2023 3:17 PM, Krzysztof Kozlowski 写道:
> On 15/09/2023 04:01, Tengfei Fan wrote:
>> The Qualcomm SM4450 SoC has several bus fabrics that could be controlled
>> and tuned dynamically according to the bandwidth demand.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
> 
> qcom,sm4450-rpmh.example.dtb: interconnect@1700000: reg: [[0, 24117248],
> [0, 200832]] is too long
> 
> Did you test it before sending? No, you did not. Eh :(
> 
> Best regards,
> Krzysztof
> 
I did test, maybe miss this warning, will test again and update.

-- 
Thx and BRs,
Tengfei Fan

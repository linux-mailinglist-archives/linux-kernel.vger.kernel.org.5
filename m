Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F55C7F0E55
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjKTJAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjKTJAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:00:41 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7FDA4;
        Mon, 20 Nov 2023 01:00:36 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK7UsT4005271;
        Mon, 20 Nov 2023 09:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ImZ/n8GsSZ5bTYTGhlLv233vn4tN8DfN0BIWCHbNEvk=;
 b=GPqCbXQQRMT40iAKaF1Hshfsp5TAyOHjtnZSAva9dZ0g/jLDLUi8P53QMeq4q20bogC+
 u9Lo7Y+Yi0EnA1b3xroxekriDbUBb3kOUiWqDTKPDz4jRlcKMpTBqrS2g/X1K0q49AK2
 sc4nOt+JqYQEs8Bic23IwUqT/1G9tjD0+/hhF3TsAXp/nr7njhdqZxtKho+QiEhSCelc
 w1CaBsN2Z9XTyTOqna2AkurRsWXgJkueHNGKW+OeKGxlJqUJlyLzxaBuPG3+6gWdCQzZ
 n0EbUY+c4B9DmNnM5x5nYCVNfflLkrDDjong1zf8eeAqo0RrIpYXyOFcBpN1er9XTnDI BQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ug34u0550-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 09:00:21 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AK90KTi028454
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 09:00:20 GMT
Received: from [10.253.8.221] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 20 Nov
 2023 01:00:15 -0800
Message-ID: <2d4818f6-3935-4621-bf96-d84747cbefa3@quicinc.com>
Date:   Mon, 20 Nov 2023 17:00:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] dt-bindings: net: ipq4019-mdio: Document ipq5332
 platform
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <robert.marko@sartura.hr>,
        <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20231115032515.4249-1-quic_luoj@quicinc.com>
 <20231115032515.4249-10-quic_luoj@quicinc.com>
 <834cbb58-3a88-4ba6-8db6-10440a4d0893@linaro.org>
 <76e081ba-9d5a-41df-9c1b-d782e5656973@quicinc.com>
 <2a9bb683-da73-47af-8800-f14a833e8ee4@linaro.org>
 <386fcee0-1eab-4c0b-8866-a67821a487ee@quicinc.com>
 <77a194cd-d6a4-4c9b-87f5-373ed335528f@linaro.org>
 <de4fa95e-4bc7-438a-94bb-4b31b1b89704@quicinc.com>
 <6e10604f-d463-499b-b00a-57ef22a936bb@lunn.ch>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <6e10604f-d463-499b-b00a-57ef22a936bb@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IZbdL7Cw6EyPK_TPVWMlvGauFNWvvZcm
X-Proofpoint-GUID: IZbdL7Cw6EyPK_TPVWMlvGauFNWvvZcm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_06,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=987 malwarescore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/18/2023 11:36 PM, Andrew Lunn wrote:
>> The clock arguments are provided in the later part as below. i will also
>> provide more detail clock names for the new added clocks for the ipq5332
>> platform in description.
>>
>>    - if:
>>
>>        properties:
>>
>>          compatible:
>>
>>            contains:
>>
>>              enum:
>>
>>                - qcom,ipq5332-mdio
>>
>>      then:
>>
>>        properties:
>>
>>          clocks:
>>
>>            items:
>>
>>              - description: MDIO clock source frequency fixed to 100MHZ
>>
>>              - description: UNIPHY0 AHB clock source frequency fixed to
>> 100MHZ
>>              - description: UNIPHY0 SYS clock source frequency fixed to 24MHZ
>>              - description: UNIPHY1 AHB clock source frequency fixed to
>> 100MHZ
>>              - description: UNIPHY1 SYS clock source frequency fixed to 24MHZ
> 
> As i said before, the frequency of the clocks does not matter
> here. That appears to be the drivers problem. I assume every board
> design, with any sort of PHY, needs the same clock configuration?
> 
>        Andrew

Yes, Andrew, no matter what kind of PHY is connected, these clocks are
fix clocks, the clock rates are same as mentioned above, which are the 
SOC clock configurations.


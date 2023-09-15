Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7497A1E9E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbjIOMYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbjIOMYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:24:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6356E2700;
        Fri, 15 Sep 2023 05:24:09 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FCF1q4012224;
        Fri, 15 Sep 2023 12:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8Vd+K9n1PVwRK4FuNYfUllChVpBqkOW/4dZQ2MnciNw=;
 b=ISp6nPZNiXOv1zfA1ydg0gliyuS6+Ag9ZJ7oMX5CxgX4FhQyvFnABXm35objh5USRFXU
 Ge1GU69M/BKxEICv31GESMpg+OPhNhuSRiw3LMdsKrQgZDp242i1Yye96kvRszIr8juN
 weToUfHZYUvWQUbCY9qzrYiezdIvlFZOuEGRWfDjTWcMPxS4q609s620DipR5sYD1lhP
 TO3lMkh3GoxYhV3YwpiKzlgdwNP51ZZ7qzEdafKxj77THmFHPxHrvvwL2ICzzmgBTtOw
 sSkG3pOA/lk9RZtXLMJxDp7b7IJeBv9B8i9GpjnmR4gqjlBWLTcK3RNsEtpwg2LYgmt9 tw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4dvqs8mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 12:23:58 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38FCNwB0021132
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 12:23:58 GMT
Received: from [10.201.2.147] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 15 Sep
 2023 05:23:54 -0700
Message-ID: <9a723cc7-bc85-7dac-8923-e4e1974ded85@quicinc.com>
Date:   Fri, 15 Sep 2023 17:53:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 4/5] dt-bindings: firmware: qcom,scm: document IPQ5018
 compatible
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Robert Marko <robimarko@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <computersforpeace@gmail.com>
References: <20230815140030.1068590-1-robimarko@gmail.com>
 <20230815140030.1068590-4-robimarko@gmail.com>
 <0bb12177-e8f0-1873-4ffb-9a0df0a9f24d@linaro.org>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <0bb12177-e8f0-1873-4ffb-9a0df0a9f24d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tmIHGmuJc52SZS761NiCy6k2vKmle1SJ
X-Proofpoint-ORIG-GUID: tmIHGmuJc52SZS761NiCy6k2vKmle1SJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_08,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=905 phishscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150110
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/16/2023 11:40 AM, Krzysztof Kozlowski wrote:
> On 15/08/2023 15:59, Robert Marko wrote:
>> It seems that IPQ5018 compatible was never documented in the bindings.
>>
>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>> ---
>>   Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

  I earlier posted this here, [1]

  [1] https://www.spinics.net/lists/linux-mmc/msg77015.html


Regards,
  Sricharan


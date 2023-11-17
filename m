Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316717EEF29
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235789AbjKQJri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235798AbjKQJrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:47:13 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130BDD75;
        Fri, 17 Nov 2023 01:44:32 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AH6Zubf011447;
        Fri, 17 Nov 2023 09:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Nzl53A6Ojw58hiwRHky2IDpvZAfop6W4exn3T6bQhDU=;
 b=jZ9cW8hNI+pOhn9EpQImjvx/GYQg3jwg0jD5pWc2YD2lqPJDupizcrUko1CZrjsYcLCk
 qaV+hDOCJzzj3DV4M/L8WD2bwMYkhKMFiXQWgA7v4gKcqlHLs2BGxy8N8hkl9r5L9AFs
 +0Ug1budM0Yq6l8tpE2SCvk8fuLuEJ/xkh5skULgd3JaYKW2DQ3eqB0un4nzvrVA/QX4
 kZwxjvhb0bASnfjqSgQ+Lu8mJ3vV/iw0ZtH9m3u0w1FSsXaM20co7oviW8H5NUwvFiLk
 lV9UIRPo08rAGr+AEQCN4OyO1f7+ZATbdxAqXWgvelOdQMkqGrhtAjNNlmjuiV3IB2Hg sA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3udmw42afx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 09:44:15 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AH9iESh005756
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 09:44:14 GMT
Received: from [10.253.8.81] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 17 Nov
 2023 01:44:10 -0800
Message-ID: <5103699f-375d-4752-bcb0-9abeb0a86fbe@quicinc.com>
Date:   Fri, 17 Nov 2023 17:44:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] dt-bindings: net: ethernet-controller: add
 10g-qxgmii mode
To:     Conor Dooley <conor@kernel.org>
CC:     <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <20231116112437.10578-1-quic_luoj@quicinc.com>
 <20231116112437.10578-3-quic_luoj@quicinc.com>
 <20231116-flier-washed-eb1a45481323@squawk>
Content-Language: en-US
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <20231116-flier-washed-eb1a45481323@squawk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Cv7HkOtzsQ3YuNaZP_jp_-b9y1wY-gs7
X-Proofpoint-ORIG-GUID: Cv7HkOtzsQ3YuNaZP_jp_-b9y1wY-gs7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_07,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=972
 clxscore=1015 suspectscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170071
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/16/2023 10:22 PM, Conor Dooley wrote:
> On Thu, Nov 16, 2023 at 07:24:33PM +0800, Luo Jie wrote:
>> Add the new interface mode 10g-qxgmii, which is similar to
>> usxgmii but extend to 4 channels to support maximum of 4
>> ports with the link speed 10M/100M/1G/2.5G.
>>
> 
>> This patch is separated from Vladimir Oltean's previous patch
>> <net: phy: introduce core support for phy-mode = "10g-qxgmii">.
> 
> This belongs in the changelog under the --- line.

will move out these two lines.

> 
>>
>> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> Are you missing a from: line in this patch?

will modify the author in the next patch set.

> 
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> 
> Otherwise,
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Cheers,
> Conor.
> 
>> ---
>>   Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
>> index d14d123ad7a0..0ef6103c5fd8 100644
>> --- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
>> +++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
>> @@ -104,6 +104,7 @@ properties:
>>         - usxgmii
>>         - 10gbase-r
>>         - 25gbase-r
>> +      - 10g-qxgmii
>>   
>>     phy-mode:
>>       $ref: "#/properties/phy-connection-type"
>> -- 
>> 2.42.0
>>

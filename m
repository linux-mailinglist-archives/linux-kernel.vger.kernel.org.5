Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7046C7F5D2F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344796AbjKWLCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjKWLCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:02:32 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6028F1BD;
        Thu, 23 Nov 2023 03:02:38 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ANAr9W6009461;
        Thu, 23 Nov 2023 11:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FdozfHkDVrzZihwpfJj8ZM55TKBnM7FMsHV8eXoLC2Y=;
 b=BijWvNksqBaXKz+8Z2aW2FsbOQ4Ssw88CptVYOGFPNuZK6Izz26OH75HnsFo/zViDbqO
 9f+8I1MZp5sv2j1bUTEeD7zDFSyTn3il85bcIME2pR4slkiS04UZcmOhQqVuZmieBwE6
 GXX80po7+1fiLKUYuNCNJ7dTJUGAtLKhiPXChYSWADpmMdbNSLzsmp+Dd2i1xzU1oa/V
 yD79nHliscCX+q76abPg5jHWWMWe/pOdkWP400UsKIZchRVTNAFlPT9v1Xx1vFCf7Aq/
 UWZL5JHnU2bG2qGpytZi8r0WA1lDglt0L71s/OlHoXs+mv8FTx1cs7AmmfTLCjn8UTbx Cw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uhkfntd2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 11:02:27 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ANB2Qnt028025
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 11:02:26 GMT
Received: from [10.253.33.181] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 23 Nov
 2023 03:02:21 -0800
Message-ID: <82992471-cb5c-4351-9c19-31347f937940@quicinc.com>
Date:   Thu, 23 Nov 2023 19:02:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] net: mdio: ipq4019: Enable the clocks for ipq5332
 platform
To:     Andrew Lunn <andrew@lunn.ch>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <robert.marko@sartura.hr>,
        <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20231115032515.4249-1-quic_luoj@quicinc.com>
 <20231115032515.4249-3-quic_luoj@quicinc.com>
 <10dc0fff-fc00-4c1f-97cf-30c5e5e8f983@linaro.org>
 <9acace07-d758-4d5d-8321-de75ee53355d@quicinc.com>
 <187a148d-39af-4000-825d-63ca3e3a23b1@lunn.ch>
Content-Language: en-US
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <187a148d-39af-4000-825d-63ca3e3a23b1@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tLNr2KPb3XJbN8kL-veNwyXoQKOHKJuN
X-Proofpoint-ORIG-GUID: tLNr2KPb3XJbN8kL-veNwyXoQKOHKJuN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_09,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311230078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/2023 10:04 PM, Andrew Lunn wrote:
> On Tue, Nov 21, 2023 at 06:28:54PM +0800, Jie Luo wrote:
>>
>>
>> On 11/20/2023 10:22 PM, Konrad Dybcio wrote:
>>> On 15.11.2023 04:25, Luo Jie wrote:
>>>> For the platform ipq5332, the related GCC clocks need to be enabled
>>>> to make the GPIO reset of the MDIO slave devices taking effect.
>>>>
>>>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>>> [...]
>>>
>>>>    static int ipq4019_mdio_wait_busy(struct mii_bus *bus)
>>>> @@ -212,6 +231,38 @@ static int ipq_mdio_reset(struct mii_bus *bus)
>>>>    	u32 val;
>>>>    	int ret;
>>>> +	/* For the platform ipq5332, there are two uniphy available to connect the
>>>> +	 * ethernet devices, the uniphy gcc clock should be enabled for resetting
>>>> +	 * the connected device such as qca8386 switch or qca8081 PHY effectively.
>>>> +	 */
>>>> +	if (of_device_is_compatible(bus->parent->of_node, "qcom,ipq5332-mdio")) {
>>> Would that not also be taken care of in the phy driver?
>>>
>>> Konrad
>>
>> Hi Konrad,
>> These clocks are the SOC clocks that is not related to the PHY type.
>> no matter what kind of PHY is connected, we also need to configure
>> these clocks.
> 
> Hi Jie
> 
> You can avoid lots of these questions by making your commit message
> better. Assume the reader does not know the clock tree for this
> device. With a bit of experience, you can guess what reviewers are
> going to ask, and answer those questions in the commit message.
> 
>        Andrew

Hi Andrew,
Got it, will take more attention on the commit message to make the
code clearly in future patches, thanks for the suggestion.


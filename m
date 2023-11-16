Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63867EDEBF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345045AbjKPKpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345040AbjKPKp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:45:29 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027F91B2;
        Thu, 16 Nov 2023 02:45:25 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGATVWg029452;
        Thu, 16 Nov 2023 10:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=m23/cK5i1Cg40I/9cBqsgsRUlGecEx+/SCgploWIU3s=;
 b=bBxRxcUpEJyVExzX92fMP3sGXBdmbEdlU38b6pEVrzgbx57VPUDkH4pdgoYgMZCo6p8U
 QuUH/CMi8qfCk3rGuLjnAX1YCsfRXzCSQn4RANHCNFo1LkYD7hzK3HpEcbp4m8lxZxLU
 b8E6nVTvnv6SPxgDKrVUPllUbzCQinZX6WuaX6zfOfsu6isvVq63nWnlwBEWGPUN44oK
 kNWCx8WRJ3Xlz5XehI2LfPJ26AS/rOjiozUqcMWIjzhmJ6EWFauAE0lMUO+XAttUTaR+
 vFW9IaCT6iTA5ANd++UQnl7e5rK/u/rKZGqSCyr4trtqFDlwF1lyyPdCf0e04GmLIBaH Mg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucu27u3c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 10:45:13 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AGAjCPA020603
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 10:45:12 GMT
Received: from [10.253.72.184] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 16 Nov
 2023 02:45:08 -0800
Message-ID: <d677e73a-5ca2-4034-9b4b-1e6140601066@quicinc.com>
Date:   Thu, 16 Nov 2023 18:45:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] net: mdio: ipq4019: add qca8084 configurations
Content-Language: en-US
To:     Robert Marko <robert.marko@sartura.hr>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Andrew Lunn <andrew@lunn.ch>, <agross@kernel.org>,
        <andersson@kernel.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <linux-arm-msm@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>
References: <20231115032515.4249-1-quic_luoj@quicinc.com>
 <20231115032515.4249-9-quic_luoj@quicinc.com>
 <a1954855-f82d-434b-afd1-aa05c7a1b39b@lunn.ch>
 <cb4131d1-534d-4412-a562-fb26edfea0d1@linaro.org>
 <CA+HBbNGnEneK8S+dZM6iS+C8jFnEtg4Wpe2tBBoP+Y_H0ZmyWA@mail.gmail.com>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <CA+HBbNGnEneK8S+dZM6iS+C8jFnEtg4Wpe2tBBoP+Y_H0ZmyWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -Pmi1yOGF26K2sh-JzE56hA-2ceYXk4Q
X-Proofpoint-ORIG-GUID: -Pmi1yOGF26K2sh-JzE56hA-2ceYXk4Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_09,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 spamscore=0
 mlxlogscore=774 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160085
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/16/2023 1:03 AM, Robert Marko wrote:
> On Wed, Nov 15, 2023 at 6:01 PM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>>
>> On 11/15/23 17:20, Andrew Lunn wrote:
>>> On Wed, Nov 15, 2023 at 11:25:14AM +0800, Luo Jie wrote:
>>>> The PHY & PCS clocks need to be enabled and the reset
>>>> sequence needs to be completed to make qca8084 PHY
>>>> probeable by MDIO bus.
>>>
>>> Is all this guaranteed to be the same between different boards?
>> No, this looks like a total subsystem overreach, these should be
>> taken care of from within clk framework and consumed with the clk
>> APIs.
>>
>> Konrad
> 
> There are patches for QCA8084 clocks:
> https://patchwork.kernel.org/project/linux-arm-msm/cover/20231104034858.9159-1-quic_luoj@quicinc.com/
> 
> I guess all of the clocking should be done there, it isn't really a MDIO issue.
> 
> Regards,
> Robert
> 

Thanks Robert for the link of this patch.

Yes, the clock driver of qca8084 is probed as the MDIO device, the
configuration sequence here to lighten the qca8084 PHY need to
be completed before the clock APIs available to call.

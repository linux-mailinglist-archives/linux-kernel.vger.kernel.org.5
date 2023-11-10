Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724357E811B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345398AbjKJSXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345261AbjKJSW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:22:58 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE62572A2;
        Thu,  9 Nov 2023 22:29:27 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA4YPUL006265;
        Fri, 10 Nov 2023 05:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Z/PCIpcg9xojQy51MB+VWId2kfAlISsC4S8iqeSNADY=;
 b=K6BFdncG9QJ2nseJ53B9H8m0YtpBEzthKZwhyt6n7K11phYFKM5nvoXVSZgUNPVjbWY4
 JQyZWxFODTtnPkyE56WbUwMQf/Q67EU22Wf7B/OdOBsmFKuZKBYXLy0i1irLUwtUKr/k
 970Wp/cxC8wqb6QlWAl+QwSeP/W71FQUKrIE17c5Rtt5jW8Y23JEza4n9QCJ1zLiq37t
 9c4KRkh6WuF9BtTbwc9j/JELuNv8tmtMFyYwe40QmGs53nAtsyp12FixjJr2d7U6OCZH
 H8nltvjgK9B3HPLicF1qwavqdeDcM6YIHId4mXrW9LX0io1703HvUJwZ5B/U0rfy6CxW XA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u8u2ttrn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 05:03:20 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AA53J2l013913
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 05:03:19 GMT
Received: from [10.218.10.86] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 9 Nov
 2023 21:03:11 -0800
Message-ID: <b40a74f4-1605-d3a1-2c6a-845c41419442@quicinc.com>
Date:   Fri, 10 Nov 2023 10:33:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 2/2] arm64: dts: qcom: sa8775p: Add ep pcie1 controller
 node
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mani@kernel.org>, <robh+dt@kernel.org>,
        <quic_shazhuss@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nayiluri@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <robh@kernel.org>,
        <quic_krichai@quicinc.com>, <quic_vbadigan@quicinc.com>,
        <quic_parass@quicinc.com>, <quic_schintav@quicinc.com>,
        <quic_shijjose@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        "Kishon Vijay Abraham I" <kishon@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
References: <1699362294-15558-1-git-send-email-quic_msarkar@quicinc.com>
 <1699362294-15558-3-git-send-email-quic_msarkar@quicinc.com>
 <i3yum3wbko33jwn7tfbcflpcxe5k5j5ituhyxtucx6gk2bs3gz@7ncewfmepnai>
 <19f32f8e-dfe2-410b-9a4d-80e24a888d65@linaro.org>
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
In-Reply-To: <19f32f8e-dfe2-410b-9a4d-80e24a888d65@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8TreDiKchctsydpgz_pSNbtifUBxzsor
X-Proofpoint-GUID: 8TreDiKchctsydpgz_pSNbtifUBxzsor
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_01,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 adultscore=0 clxscore=1011 spamscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311100041
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/8/2023 3:24 AM, Konrad Dybcio wrote:
>
>
> On 11/7/23 19:37, Andrew Halaney wrote:
>> On Tue, Nov 07, 2023 at 06:34:53PM +0530, Mrinmay Sarkar wrote:
>>> Add ep pcie dtsi node for pcie1 controller found on sa8775p platform.
>>> It supports gen4 and x4 link width. Limiting the speed to Gen3 due to
>>> stability issues.
>>
>> I wouldn't mind a bit more information on what "stability" issues
>> entails! I'm a sucker for details in a commit message.
> Yep, giving us a bit more than "doesnt work" may help us help you!
Actually if I enable gen4 some time I am getting link down and sometime
link getting establish at gen1. I am not getting stable gen4, may be we
need to program some register to get stable gen4 that I am checking.
>>> +
>>> +        interrupts = <GIC_SPI 518 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>;
> Looks like the indentation is off?
>
>>> +
>>> +        interrupt-names = "global", "doorbell", "dma";
>>> +
>>> +        interconnects = <&pcie_anoc MASTER_PCIE_1 0 &mc_virt 
>>> SLAVE_EBI1 0>,
>>> +                <&gem_noc MASTER_APPSS_PROC 0 &config_noc 
>>> SLAVE_PCIE_1 0>;
>>
>> I keep seeing Konrad requesting that we use the #define instead of a raw
>> number 0, i.e. something like QCOM_ICC_TAG_ALWAYS (although if I'm
>> reading that correctly QCOM_ICC_TAG_ALWAYS doesn't evaluate to 0, so
>> make sure you pick the appropriate one).
> No it doesn't, but if you look at the code, tag being non-existent
> assigns QCOM_ICC_TAG_ALWAYS which is a workaround for DTBs from back
> when interconnect tags were not a thing
>
>>
>>> +        interconnect-names = "pcie-mem", "cpu-pcie";
>>
>> This is nitpicky, but unless someone told you to do the whitespace
>> between some of these properties I'd get more consistent. i.e. reg and
>> reg-names has no newline between them, but clocks and clock-names does,
>> and then interconnects/interconnect-names does not.
> :)
I don't think there is any rule to add those white spaces, in next patch
I will align these white spaces with other pcie nodes.
>
> Konrad

Thanks,
Mrinmay


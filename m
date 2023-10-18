Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5B57CDB15
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjJRL5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjJRL5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:57:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EF2114;
        Wed, 18 Oct 2023 04:57:50 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39I70Xa2002870;
        Wed, 18 Oct 2023 11:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ysNYIQ/Zi0jfiz1sdI12w6m3V0yJAk77TlAx2uz/ZxI=;
 b=DpFlCSQXyxNa+tDPlv5SLX6BYQu8BzItHUmuYKoQfRlYaRQNkfYZ6f/9B1YfRC+tModD
 rHjvatR6Bffir4sT+gOas+u3HKdBz+m6nmjiuplN3VP88L8by0NDL1knnVqwFICUUp03
 KqbQhmyaDr1nwOioO1E44ZUI+WYjQYuNX9QARrU3zshX3amkKUuZM5FMouqYwlDS+yH3
 Ul3wMTAX8lXs7MwNYk+UbwxoItjNzNtl2XJE3xBbum9vFmvz1v0UNN5R5ZnyJ8C5/AM6
 DWtzoNFMEju1BCFULWhiEMtUx4CKhJfBPQdtAotKTO4N3RYUG3CjzxYMBMDNfNy4n8wy GQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsv0v2nev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 11:57:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39IBvW3Q001045
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 11:57:32 GMT
Received: from [10.216.30.229] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 18 Oct
 2023 04:57:26 -0700
Message-ID: <4293617a-f6a7-444f-b6f8-ac7297d9e9b1@quicinc.com>
Date:   Wed, 18 Oct 2023 17:27:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 08/10] arm64: dts: qcom: sc8280xp: Add multiport
 controller node for SC8280
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "Wesley Cheng" <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <20231007154806.605-9-quic_kriskura@quicinc.com>
 <467dd1cc-64af-43d7-93ca-be28043e2765@linaro.org>
 <cceab5a9-ac0f-4ecd-9aa5-0ede5615a13d@quicinc.com>
Content-Language: en-US
In-Reply-To: <cceab5a9-ac0f-4ecd-9aa5-0ede5615a13d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PMQY6-Tg_CmBeGvoPCNHn4GijJTX08sp
X-Proofpoint-GUID: PMQY6-Tg_CmBeGvoPCNHn4GijJTX08sp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_09,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=705
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180098
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2023 10:32 PM, Krishna Kurapati PSSNV wrote:
> 
> 
> On 10/12/2023 10:10 PM, Konrad Dybcio wrote:
>>
>>
>> On 10/7/23 17:48, Krishna Kurapati wrote:
>>> Add USB and DWC3 node for tertiary port of SC8280 along with multiport
>>> IRQ's and phy's. This will be used as a base for SA8295P and SA8295-Ride
>>> platforms.
>>>
>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>> ---
>> [...]
>>
>>> +
>>> +            interconnects = <&aggre1_noc MASTER_USB3_MP 0 &mc_virt 
>>> SLAVE_EBI1 0>,
>>> +                    <&gem_noc MASTER_APPSS_PROC 0 &config_noc 
>>> SLAVE_USB3_MP 0>;
>> Please use QCOM_ICC_TAG_ALWAYS from 
>> include/dt-bindings/interconnect/qcom,icc.h (like in sa8775p)
>>
>> With that I think it's good to go :)
>>
> Hi Konrad. Thanks for the review.
> 
> I see that the tags are used fr spi/i2c but not usb. So to maintain 
> uniformity, wanted to keep the same here.
> 

Hi Konrad,

  Even in sa8775p.dtsi, the interconnect nodes have 0 & 1 instead of 
macros. So wouldn't it be disturbing the uniformity if we use ICC_TAG's 
here. Let me know your thoughts on this.

Regards,
Krishna,

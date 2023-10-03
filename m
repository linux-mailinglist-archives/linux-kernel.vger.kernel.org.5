Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7677B6C06
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240155AbjJCOrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240106AbjJCOrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:47:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EE0AD;
        Tue,  3 Oct 2023 07:46:56 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393EHIIV026514;
        Tue, 3 Oct 2023 14:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tfLOe0VjA/rPVml+32m2VjdMp1XlyYfrkQaY6Acrs8o=;
 b=RVZapUYXEprjyDsX0sZsebjBBO2JFOD0ZR/rmGI17mArmJCawd3irDq4c/VCS5sccvWO
 vVhsJzFFcp6uMQMqUhmiqdFvpFiYoHjc0DlRhoFy+SDyGHzTY2PAskhoKTPnfxkhrC0u
 iEj/layxNpAvP5IVDYMzVDccW0YDB8THLVfhUeLrug65TJxfydijqUap0Cib0FXCwx4q
 ce90TLMT9/eLD3ppYeDrmUu0Xl6tEP+/HJUg2D6tW4Y21Wh7XD5k5mJAaSO61vOiY3AO
 REI8fmUuiAC3FgOnNQoM44rygQXYRv+pKTuG7MO60ecwRhzFGeSSLRAMCVPh7is0fPvI dQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3teb0se8us-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 14:46:36 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 393EkA4O032041
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Oct 2023 14:46:10 GMT
Received: from [10.216.32.208] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 3 Oct
 2023 07:46:00 -0700
Message-ID: <8eaec03f-40c1-4285-9b86-c39bda251c61@quicinc.com>
Date:   Tue, 3 Oct 2023 20:15:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] arm64: dts: qcom: ipq5332: Add clocks for USB
 Super-Speed
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>,
        <geert+renesas@glider.be>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <u-kumar1@ti.com>, <peng.fan@nxp.com>, <quic_wcheng@quicinc.com>,
        <quic_varada@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_kathirav@quicinc.com>, <quic_nsekar@quicinc.com>,
        <quic_srichara@quicinc.com>
References: <20230929084209.3033093-1-quic_ipkumar@quicinc.com>
 <20230929084209.3033093-6-quic_ipkumar@quicinc.com>
 <356a4f97-a483-4202-a6da-b48351d9b209@linaro.org>
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <356a4f97-a483-4202-a6da-b48351d9b209@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: a85uTrtq1TBPcd8x4djM9PzJ3ohD8rPG
X-Proofpoint-ORIG-GUID: a85uTrtq1TBPcd8x4djM9PzJ3ohD8rPG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_11,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=768
 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 clxscore=1015 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030109
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/2023 10:55 PM, Dmitry Baryshkov wrote:
> On 29/09/2023 11:42, Praveenkumar I wrote:
>> Add aux and lfps clocks in USB node for Super-Speed support.
>>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq5332.dtsi | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi 
>> b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> index b08ffd8c094e..1813b9fa4bb5 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> @@ -336,11 +336,16 @@ usb: usb@8af8800 {
>>               clocks = <&gcc GCC_USB0_MASTER_CLK>,
>>                    <&gcc GCC_SNOC_USB_CLK>,
>>                    <&gcc GCC_USB0_SLEEP_CLK>,
>> -                 <&gcc GCC_USB0_MOCK_UTMI_CLK>;
>> +                 <&gcc GCC_USB0_MOCK_UTMI_CLK>,
>> +                 <&gcc GCC_USB0_AUX_CLK>,
>> +                 <&gcc GCC_USB0_LFPS_CLK>;
>
> This looks like a strange change. Usually the DTB is considered to be 
> the ABI, so older DTBs should continue to work with newer kernels. Is 
> there a reason why the AUX and LFPS clocks were not a part of the 
> original submission?
This AUX and LFPS clocks are required only when USB controller uses the 
UNIPHY and works in 3.0. Original change added 2.0 support and used m31-phy.
>
>> +
>>               clock-names = "core",
>>                         "iface",
>>                         "sleep",
>> -                      "mock_utmi";
>> +                      "mock_utmi",
>> +                      "aux",
>> +                      "lfps";
>>                 resets = <&gcc GCC_USB_BCR>;
>
--
Thanks,
Praveenkumar

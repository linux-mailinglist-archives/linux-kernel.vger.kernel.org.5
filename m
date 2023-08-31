Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F5D78ECDE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346199AbjHaMPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 08:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjHaMPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:15:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00B4E43;
        Thu, 31 Aug 2023 05:15:36 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37V9FPxw024020;
        Thu, 31 Aug 2023 12:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rSCXqtKlx7gJr8jIeaQfsRco9uXPb8O3IwsCKX2yLQo=;
 b=KitO1WXHjvRRVpWDEY+oDFWVhhu6D/K7/aZhjDiawtnindQ0Ns8F2UFq4GGzWqZ2gGQ+
 Xg59vk/Wc31F8zk0ewGogDQ9kTZXUkbCTLHZJjYYfs6KaTEyAxH5G23UuJM45FODh3+B
 XutDn6jnIiNb95cO9FPRoSLcrh7d4m75mxZUkPLKhA3h489lwrp5vH3xgrRKfc7zF1gY
 ICqE25HPyT+RVxag7oVMPRPIfKzLZjOqu0Luxn3sDavNb9PTNjBgjlUyO/rYPL5DkMk5
 Rj1ufpfev6gTuZJ1jtywHbS3lhhdgqCR6CxXurEKrfSTy7fyjBq07rRz/0Ti8t+JlNwf 3g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3stks5ruhp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 12:14:42 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37VCENIl017429
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 12:14:23 GMT
Received: from [10.201.3.91] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 31 Aug
 2023 05:14:15 -0700
Message-ID: <2c9aeb22-d3e9-463c-9985-f489f9bcacb9@quicinc.com>
Date:   Thu, 31 Aug 2023 17:44:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] Enable USB3 for IPQ5332
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <robert.marko@sartura.hr>, <luka.perkov@sartura.hr>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <quic_varada@quicinc.com>
References: <20230829135818.2219438-1-quic_ipkumar@quicinc.com>
 <92d97b12-48ba-13c9-de9e-70b6eb330904@linaro.org>
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <92d97b12-48ba-13c9-de9e-70b6eb330904@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HEVg23D_oTPpSrayK0KHJb6Kc-uMFm_Q
X-Proofpoint-ORIG-GUID: HEVg23D_oTPpSrayK0KHJb6Kc-uMFm_Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_10,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 impostorscore=0 clxscore=1011 malwarescore=0 bulkscore=0
 mlxlogscore=851 suspectscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310110
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/29/2023 10:37 PM, Krzysztof Kozlowski wrote:
> On 29/08/2023 15:58, Praveenkumar I wrote:
>> IPQ5332 has UNIPHY for USB and PCIe which is similar to the UNIPHY
>> present in IPQ4019. Few extra settings like clock, reset delay, mux
>> selection and voltage regulator are required for IPQ5332. Hence
>> repurposed the IPQ4019 PHY driver for IPQ5332 UNIPHY. Few more Qualcomm
>> SoCs are also having the UNIPHY which can use the same driver for both
>> USB and PCIe PHY.
>>
>> Praveenkumar I (9):
>>    dt-bindings: phy: qcom,uniphy: Rename ipq4019 usb PHY to UNIPHY
>>    phy: qcom: uniphy: Rename ipq4019 USB phy driver to UNIPHY driver
>>    phy: qcom: uniphy: Update UNIPHY driver to be a common driver
>>    dt-bindings: phy: qcom,uniphy: Add ipq5332 USB3 SS UNIPHY
>>    dt-bindings: usb: dwc3: Update IPQ5332 compatible
>>    arm64: dts: qcom: ipq5332: Add USB3 related nodes
>>    arm64: dts: qcom: ipq5332: Enable USB SS UNIPHY
> DTS does not go before drivers. DTS should be sent separately or as the
> last patches. If you stuff it in the middle, means your patchset has
> dependencies which it cannot have. Thus it is broken.

Sorry, I ordered it wrongly. Will correct in the next patches.

-  Praveenkumar

>
> Best regards,
> Krzysztof
>

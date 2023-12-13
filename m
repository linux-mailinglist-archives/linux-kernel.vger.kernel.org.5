Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA4281190D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377624AbjLMQTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbjLMQTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:19:08 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F26106;
        Wed, 13 Dec 2023 08:19:13 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BDEQLKL015880;
        Wed, 13 Dec 2023 16:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        qcppdkim1; bh=YXZ0gTJLcXRK80R/QdLUiDkkAhr39zUqg+imbXMMADs=; b=jo
        LQ/K6hqlFwmZKeD4dfiV5QBttJYWTMnKOLbJ0B2Hs8Gm8W6i9/17wOY25qQzOi6u
        EIEbEfoMhUBrOO1MvxWvLMfs3jJHNN8M3Pd3Rb40NsMxR48lWwgu3dLcIt6jmBB3
        qvpYVFdas5SRhmNdNXE1kXNGn3monN+Ylj1uIWpoc63LCOPXFnXONubKrbOnBDUI
        FTMnrfkE3glkLOPxPdYYVW4K27ZNn4Dfc+9nm/GccD8hXN8dxCYMpjphSDrkg13y
        Rp7/3avpAfKNElr7GQrY/CzHNwx4PH+16Dz33sz8JRSCUKYbpToWzj9DjoLuaVdG
        uD81DSsnuGmE1farQ9rg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uyec5r9cg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 16:19:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BDGJ6ts023703
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 16:19:06 GMT
Received: from [10.216.40.169] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Dec
 2023 08:19:00 -0800
Message-ID: <c5d85c84-3783-4262-a379-1f28e13ae4ce@quicinc.com>
Date:   Wed, 13 Dec 2023 21:48:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: usb: dwc3: Clean up hs_phy_irq in
 bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
References: <20231211121124.4194-1-quic_kriskura@quicinc.com>
 <20231211121124.4194-2-quic_kriskura@quicinc.com>
 <24fb0b25-0139-4370-864c-839ae931f847@linaro.org>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <24fb0b25-0139-4370-864c-839ae931f847@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4ZVhg3XykqQzlODK8lYcj2XIQHMOsVYK
X-Proofpoint-GUID: 4ZVhg3XykqQzlODK8lYcj2XIQHMOsVYK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=733 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312130115
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/2023 12:45 PM, Krzysztof Kozlowski wrote:
> On 11/12/2023 13:11, Krishna Kurapati wrote:
>> The high speed related interrupts present on QC targets are as follows:
>>
>> dp/dm irq's
>> These IRQ's directly reflect changes on the DP/DM pads of the SoC. These
>> are used as wakeup interrupts only on SoCs with non-QUSB2 targets with
>> exception of SDM670/SDM845/SM6350.
>>
>> qusb2_phy irq
>> SoCs with QUSB2 PHY do not have separate DP/DM IRQs and expose only a
>> single IRQ whose behavior can be modified by the QUSB2PHY_INTR_CTRL
>> register. The required DPSE/DMSE configuration is done in
>> QUSB2PHY_INTR_CTRL register of phy address space.
>>
>> hs_phy_irq
>> This is completely different from the above two and is present on all
>> targets with exception of a few IPQ ones. The interrupt is not enabled by
>> default and its functionality is mutually exclusive of qusb2_phy on QUSB
>> targets and DP/DM on femto phy targets.
>>
>> The DTs of several QUSB2 PHY based SoCs incorrectly define "hs_phy_irq"
>> when they should have been "qusb2_phy_irq". On Femto phy targets, the
>> "hs_phy_irq" mentioned is either the actual "hs_phy_irq" or "pwr_event",
>> neither of which would never be triggered directly are non-functional
>> currently. The implementation tries to clean up this issue by addressing
>> the discrepencies involved and fixing the hs_phy_irq's in respective DT's.
>>
>> Classiffy SoC's into four groups based on whether qusb2_phy interrupt
>> or {dp/dm}_hs_phy_irq is used for wakeup in high speed and whether the
>> SoCs have hs_phy_irq present in them or not.
>>
>> The ss_phy_irq is optional interrupt because there are mutliple SoC's
>> which either support only High Speed or there are multiple controllers
>> within same Soc and the secondary controller is High Speed only capable.
>>
>> This breaks ABI on targets running older kernels, but since the interrupt
>> definitions are given wrong on many targets and to establish proper rules
>> for usage of DWC3 interrupts on Qualcomm platforms, DT binding update is
>> necessary.
> 
> This still does not explain why missing property has to be added as
> first one, causing huge reordering of everything here and in DTS.
> 
> If pwr_event is required and we already break the ABI, reduce the impact
> of the change by putting it after all required interrupts. Otherwise
> please explain here and in commit msg why different approach is taken.
> 

Hi Krzysztof. I don't know much about the effect of the ordering on ABI. 
I will try to learn up on it. Would the series be good if we just move 
the pwr_event to the end and keep everything in v3 as it is, and push v4 
for now ?

Regards,
Krishna,

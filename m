Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9299580E79E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345828AbjLLJaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLLJaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:30:14 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2F6D2;
        Tue, 12 Dec 2023 01:30:19 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BC7ga3q028772;
        Tue, 12 Dec 2023 09:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        qcppdkim1; bh=CKm/3xL+1KN3jFbIu0q3bENZbD/pAYxnXVYmTsZSXKM=; b=AQ
        zqdmXo8SdHDgRzC19Eb27JRatNUrV1lDMnHmRs+bdY/4/CFFhtr9R9MTlrmUyph2
        v6dymZeBywgLqKst7lwyFDVrv8eesORhahv7iBy+erydbPjBj7OXCYtrb+jXVV2h
        U88wNQU3FHEAsHve+viL/YW0aM7LVPrJidmpriqlBTNrRm8eAhASCxAbl3dgnrKg
        NvioJbxxTN5cOt4d2leowHNyBEe3FsOYNZ8U/+zYhv22Zf6BJv5GrHaL4pQa/Cki
        VrkJJP8NbTFMCheXPQSnR0C78vfxMaFvN+AWeGVOr9szaEPQTIMaFftCMiJpFXQx
        D9iUjEDiWsWks1Ssf5fA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uxkc8089j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 09:30:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BC9UESe009141
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 09:30:14 GMT
Received: from [10.216.15.26] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 12 Dec
 2023 01:30:10 -0800
Message-ID: <06354190-b572-46e4-8036-0fae7f15dd15@quicinc.com>
Date:   Tue, 12 Dec 2023 15:00:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] ARM/arm64: dts: qcom: fix USB wakeup interrupt
 types
To:     Johan Hovold <johan@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231120164331.8116-1-johan+linaro@kernel.org>
 <ZXc7KcjF82EgiXWd@hovoldconsulting.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZXc7KcjF82EgiXWd@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: f4nHxxn8XQaS_EOlrkWKkZkYZKC5X6aa
X-Proofpoint-ORIG-GUID: f4nHxxn8XQaS_EOlrkWKkZkYZKC5X6aa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=435 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312120074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/11/2023 10:09 PM, Johan Hovold wrote:
> On Mon, Nov 20, 2023 at 05:43:20PM +0100, Johan Hovold wrote:
> 
>> It turns out a number Qualcomm devicetrees have also gotten the trigger
>> types wrong, something which this series addresses.
>>
>> Specifically, the HS/SS PHY wakeup interrupts are level triggered while
>> the DP/DM HS PHY interrupts are edge triggered, and which edge to
>> trigger on depends both on the use-case and on whether a Low speed or
>> Full/High speed device is connected.
>>
>> Fortunately, there should be no dependency between this series and USB
>> one as all devicetree use the correct trigger type for the HS/SS PHY
>> interrupts and the HS one has never been armed by Linux anyway. The
>> DP/DM interrupt trigger types are also updated on suspend currently.
> 
> Konrad reported off-list that the sc8180x patch in this series breaks
> probe of the dwc3 driver.
> 
> Turns out a number of these SoCs were using GIC interrupts for the
> DP/DM_HS_PHY interrupts despite the fact that the driver tries to
> reconfigure these as IRQ_TYPE_EDGE_FALLING (which the GIC does not
> support) to detect disconnect events during suspend.
> 
> This is obviously broken and the proper fix is to replace the GIC
> interrupts with the corresponding PDC interrupts. I believe Konrad is
> digging out the magic numbers at this moment.
> 
> The following patches will need a follow-up fix:
> 
>>    ARM: dts: qcom: sdx55: fix USB wakeup interrupt types
> 
>>    arm64: dts: qcom: sc8180x: fix USB wakeup interrupt types
>>    arm64: dts: qcom: sdm670: fix USB wakeup interrupt types
>>    arm64: dts: qcom: sdm845: fix USB wakeup interrupt types
>>    arm64: dts: qcom: sm6375: fix USB wakeup interrupt types
>>    arm64: dts: qcom: sm8150: fix USB wakeup interrupt types
> 
Hi Johan,

  If it helps, I tried to dig up the PDC numbers for corresponding 
GIC_SPI vectors:


SM8150:

eud_p0_dpse_int_mx	apps_pdc_irq_out[9]	SYS_apcsQgicSPI[489]
eud_p0_dmse_int_mx    apps_pdc_irq_out[8]	SYS_apcsQgicSPI[488]
qmp_usb3_lfps_rxterm_irq apps_pdc_irq_out[6]	SYS_apcsQgicSPI[486]
usb31_power_event_irq	SYS_apcsQgicSPI[130]
usb31_hs_phy_irq	SYS_apcsQgicSPI[131]

interrupts-extended = <&pdc 9 IRQ_TYPE_EDGE_RISING>,
			<&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
			<&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
			<&pdc 8 IRQ_TYPE_EDGE_RISING>;

interrupt-names = "dp_hs_phy_irq", "pwr_event_irq",
		"ss_phy_irq", "dm_hs_phy_irq";

--

sdm845-670-usb-common.dtsi

interrupts = <0 489 0>, <0 130 0>, <0 486 0>, <0 488 0>;
interrupt-names = "dp_hs_phy_irq", "pwr_event_irq",
		"ss_phy_irq", "dm_hs_phy_irq";

interrupts = <0 491 0>, <0 135 0>, <0 487 0>, <0 490 0>;
interrupt-names = "dp_hs_phy_irq", "pwr_event_irq",
		"ss_phy_irq", "dm_hs_phy_irq";

eud_p0_dpse_int_mx	apps_pdc_irq_out[9]	SYS_apssQgicSPI[489]
eud_p0_dmse_int_mx	apps_pdc_irq_out[8]	SYS_apssQgicSPI[488]
eud_p1_dmse_int_mx	apps_pdc_irq_out[10]	SYS_apssQgicSPI[490]
eud_p1_dpse_int_mx	apps_pdc_irq_out[11]	SYS_apssQgicSPI[491]
qmp_usb3_lfps_rxterm_irq	apps_pdc_irq_out[7]	SYS_apssQgicSPI[487]
qmp_usb3_lfps_rxterm_irq	apps_pdc_irq_out[6]	SYS_apssQgicSPI[486]

--

SDX55:

interrupts = <0 157 0>, <0 130 0>, <0 158 0>, <0 198 0>;
interrupt-names = "dp_hs_phy_irq", "pwr_event_irq",
		"dm_hs_phy_irq", "ss_phy_irq";

eud_p1_dpse_int_mx	apps_pdc_irq_out[10]	SYS_apcsQgicSPI[157]
eud_p1_dmse_int_mx	apps_pdc_irq_out[11]	SYS_apcsQgicSPI[158]
apps_pdc.gp_irq_mux[31]	apps_pdc_irq_out[51]	SYS_apcsQgicSPI[198]

--

SM6375, I think GIC_SPI is fine but I will try to get back on this.

Sorry for bad formatting.

Regards,
Krishna,

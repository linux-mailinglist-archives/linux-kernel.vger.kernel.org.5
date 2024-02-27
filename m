Return-Path: <linux-kernel+bounces-82969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F05D868C62
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0608828CE0E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105F0136999;
	Tue, 27 Feb 2024 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XLalJAtM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8814E135A75;
	Tue, 27 Feb 2024 09:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709026644; cv=none; b=II8p8lsT0uHBfk+Tom2UCK+MvnPXKX/lLAp9LTr75wqRRLKUJ9jmgfl3pOBIHG5KZ1vtO9YXdTrl43FScOnI8+Hb1yB2Tg8tjSzsOt3YbbNKG1fBaJqEyHjsLgNXWvk4UOgXSk9LP/HArLt6WWu7TdASgYzaqxeFF2kdB7QhMps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709026644; c=relaxed/simple;
	bh=KWWRW3EhxeTGgJPUwozk2/bEvmRjwj3S46pzNTZtE/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r2EXUC2mkoocIYAxwTqm9xN75SH1p+LX1L7xqo0hN4nN/UJWg2RYLZocw0XBbTyc/o41Q1Qr8DX4+n5xSQ0ocASFIxLJ2Wwvxv8A7VpfXcR7ED6+IF4cwf2mYkXWw2XJnfP11zbScuKtlNdEuRhy/UMEMlgKRlFzRl+Ebh2GZ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XLalJAtM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R9XxAv031474;
	Tue, 27 Feb 2024 09:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ZSPXY1KQK9kLzjHc2C6RIo1LKNvV7yesMu6Mxo6z4+E=; b=XL
	alJAtMcR/8ckZKpyqjmOI+mLCPeGsXMvk1fJX9NcK2qTgU6YYEGNNMDit07BuGGf
	OzYhRcu3Pp5sws9gd+u02tq7whpbBw1uCNMbcZfDWRGW7/Xvrg2OR4sB3SFx5vcw
	rWp7V5Dov6tUWlIiGvNOH/89Vvq5kuf1UwBsp0FbIHku+fWNZMHsXDs+/fz0j5Fp
	sAcBylOVdDpmEVwUPXqZ2cVdyawl1UMV8sVEdiIfJTZeDyrXgEpbNzVf2g2x8as1
	BYU5t4TtuK8U+g6eGxrLjCRxFBxqqnvKEHrPfhzRJxnM2GWWVdsyngQtZ66A4tcY
	PEbFqeV/zYqiUjl5vq1A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whccw83u5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 09:37:18 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41R9bHXB021436
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 09:37:17 GMT
Received: from [10.214.66.209] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 27 Feb
 2024 01:37:11 -0800
Message-ID: <15d09da8-7bb9-4e64-9808-af72c5a110ec@quicinc.com>
Date: Tue, 27 Feb 2024 15:07:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: Add initial support for rb5gen2 HDK
 board
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
References: <20240202133638.4720-1-quic_wasimn@quicinc.com>
 <20240202133638.4720-4-quic_wasimn@quicinc.com>
 <CAA8EJppnNZOWN5F0fOKhUGN-pk3T9L+kOd-AiNO0tcDNm8Bbxw@mail.gmail.com>
From: Wasim Nazir <quic_wasimn@quicinc.com>
In-Reply-To: <CAA8EJppnNZOWN5F0fOKhUGN-pk3T9L+kOd-AiNO0tcDNm8Bbxw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: g2Pv9FCXyzfRntvby0GgNxiVZshXdUVZ
X-Proofpoint-ORIG-GUID: g2Pv9FCXyzfRntvby0GgNxiVZshXdUVZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270075



On 2/2/2024 8:23 PM, Dmitry Baryshkov wrote:
> On Fri, 2 Feb 2024 at 15:37, Wasim Nazir <quic_wasimn@quicinc.com> wrote:
>>
>> RB5gen2 hardware development kit is based on QCS8550-Rb5gen2 SOM
>> for IOT solutions.
>> This initial version describes VPH_PWR, UART & USB3.1.
>>
>> On-board PMICs:
>> - PMR735D
>> - PM8010
>>
>> Signed-off-by: Wasim Nazir <quic_wasimn@quicinc.com>
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index 6fdde64d7540..8840b219d6d5 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -93,6 +93,7 @@ dtb-$(CONFIG_ARCH_QCOM)       += qcs404-evb-1000.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)        += qcs404-evb-4000.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)        += qcs6490-rb3gen2.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)        += qcs8550-aim300-aiot.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)        += qcs8550-rb5gen2-hdk.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)        += qdu1000-idp.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)        += qrb2210-rb1.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)        += qrb4210-rb2.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/qcs8550-rb5gen2-hdk.dts b/arch/arm64/boot/dts/qcom/qcs8550-rb5gen2-hdk.dts
>> new file mode 100644
>> index 000000000000..6f4c68402823
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/qcs8550-rb5gen2-hdk.dts
>> @@ -0,0 +1,136 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "qcs8550-rb5gen2.dtsi"
>> +#include "pm8010.dtsi"
>> +#include "pmr735d_a.dtsi"
>> +#include "pmr735d_b.dtsi"
>> +
>> +/ {
>> +       model = "Qualcomm Technologies, Inc. QCS8550 RB5Gen2 HDK";
>> +       compatible = "qcom,qcs8550-rb5gen2-hdk", "qcom,qcs8550-rb5gen2",
>> +                       "qcom,qcs8550", "qcom,qcm8550", "qcom,sm8550";
>> +
>> +       aliases {
>> +               serial0 = &uart7;
>> +       };
>> +
>> +       chosen {
>> +               stdout-path = "serial0:115200n8";
>> +       };
>> +
>> +       pmic-glink {
>> +               compatible = "qcom,sm8550-pmic-glink", "qcom,pmic-glink";
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +
>> +               connector@0 {
>> +                       compatible = "usb-c-connector";
>> +                       reg = <0>;
>> +                       power-role = "dual";
>> +                       data-role = "dual";
>> +
>> +                       ports {
>> +                               #address-cells = <1>;
>> +                               #size-cells = <0>;
>> +
>> +                               port@0 {
>> +                                       reg = <0>;
>> +
>> +                                       pmic_glink_hs_in: endpoint {
>> +                                               remote-endpoint = <&usb_1_dwc3_hs>;
>> +                                       };
> 
> SS lines unconnected?
> SBU is unconnected?
> 
This is the initial patch with basic support and that's why only HS is 
added. Other features are planned in incremental patch by respective 
team. I will update the commit message in next patch version.
>> +                               };
>> +                       };
>> +               };
>> +       };
>> +
>> +       vph_pwr: vph-pwr-regulator {
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "vph_pwr";
>> +               regulator-min-microvolt = <3700000>;
>> +               regulator-max-microvolt = <3700000>;
>> +
>> +               regulator-always-on;
>> +               regulator-boot-on;
>> +       };
>> +};
>> +
>> +&apps_rsc {
>> +       regulators-0 {
>> +               vdd-bob1-supply = <&vph_pwr>;
>> +               vdd-bob2-supply = <&vph_pwr>;
>> +       };
>> +
>> +       regulators-2 {
>> +               vdd-s4-supply = <&vph_pwr>;
>> +               vdd-s5-supply = <&vph_pwr>;
>> +       };
>> +
>> +       regulators-3 {
>> +               vdd-s1-supply = <&vph_pwr>;
>> +               vdd-s3-supply = <&vph_pwr>;
>> +               vdd-s4-supply = <&vph_pwr>;
>> +               vdd-s5-supply = <&vph_pwr>;
>> +               vdd-s6-supply = <&vph_pwr>;
>> +       };
>> +
>> +       regulators-4 {
>> +               vdd-s1-supply = <&vph_pwr>;
>> +               vdd-s3-supply = <&vph_pwr>;
>> +               vdd-s4-supply = <&vph_pwr>;
>> +               vdd-s5-supply = <&vph_pwr>;
>> +               vdd-s7-supply = <&vph_pwr>;
>> +       };
>> +
>> +       regulators-5 {
>> +               vdd-s1-supply = <&vph_pwr>;
>> +               vdd-s2-supply = <&vph_pwr>;
>> +               vdd-s3-supply = <&vph_pwr>;
>> +               vdd-s4-supply = <&vph_pwr>;
>> +               vdd-s5-supply = <&vph_pwr>;
>> +               vdd-s6-supply = <&vph_pwr>;
>> +       };
>> +};
>> +
>> +&pm8550b_eusb2_repeater {
>> +       vdd18-supply = <&vreg_l15b_1p8>;
>> +       vdd3-supply = <&vreg_l5b_3p1>;
>> +};
>> +
>> +&uart7 {
>> +       status = "okay";
>> +};
>> +
>> +&usb_1 {
>> +       status = "okay";
>> +};
>> +
>> +&usb_1_dwc3 {
>> +       dr_mode = "otg";
>> +       usb-role-switch;
>> +};
>> +
>> +&usb_1_dwc3_hs {
>> +       remote-endpoint = <&pmic_glink_hs_in>;
>> +};
>> +
>> +&usb_1_hsphy {
>> +       vdd-supply = <&vreg_l1e_0p88>;
>> +       vdda12-supply = <&vreg_l3e_1p2>;
>> +
>> +       phys = <&pm8550b_eusb2_repeater>;
>> +
>> +       status = "okay";
>> +};
>> +
>> +&usb_dp_qmpphy {
>> +       vdda-phy-supply = <&vreg_l3e_1p2>;
>> +       vdda-pll-supply = <&vreg_l3f_0p88>;
>> +
>> +       status = "okay";
>> +};
>> --
>> 2.43.0
>>
>>
> 
> 

Thanks & Regards,
Wasim


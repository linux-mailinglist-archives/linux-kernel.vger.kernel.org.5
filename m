Return-Path: <linux-kernel+bounces-87985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBE586DBD0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6ED1F26357
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29CE6931A;
	Fri,  1 Mar 2024 07:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kn4dWbHn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242308464;
	Fri,  1 Mar 2024 07:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709276597; cv=none; b=e6d9a97NzZ97mIMdGdG3B+1HnBIUaqiScMmQCgk36e2HI1LfCloXQxCoLzBS+QULcGFjNOElmyxt8vIEhS8HCMHvnx9ajY6jpHYp48o+SPofOymRaxLsIZXAEP2I/ocsx/ykE7l6l51PIkT1ksV++MwJrqKMk5NYFKMA5JFC3dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709276597; c=relaxed/simple;
	bh=Jp2tHeRRc8dd+EZCimAuq4LfWDzTcaPj7pzUv5vapT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JPE+Tdd4yHt34fkT/ndk++8z9BBGmUUaWYujQezJqf4B09qfJ4a4FR2A0AKfhTiR+bJOIKl9YKlYPMvYhSq6sceiGQtftxiVp4r+Fp+IJGCx/sQuIH428ww6mh90gzCeqmKrXaA/p54SoPF+slQ5+0+mPSmVZmCmpBVS3WX/GSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kn4dWbHn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4216fPLJ030785;
	Fri, 1 Mar 2024 07:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=rkrf3Upi92FvYnyDJyL1qbj5k8+wIYXJBUtWQwQAwCA=; b=kn
	4dWbHnt4P7BmuFLrMl8fCTMt/Ndvsu7DkgN65MEOndHyZCQkXnf6ST7ruW/Dg+94
	5G3cpb03kJGSSSyUy+0rGO7hfR9sRtqOiSFj+3v/VfLuP9SZDHtd551RSGCtrEEf
	topUbTQYmc8xibF5HPl6/h3k8l/MnXawYwitKGksr7U/0P6qpsuJPhWihGCZce17
	NFHNpZXoLkbf5KJgbGgTyfX3he0HOtV6XcY9nI+L9ehxpg9wRHERe0tnMUT271Bk
	M+hGQ0ZQOdzjz8g2NDZHa4NFrpZixn5sKXnLQhHrGMyX1kftXKEU879qWwA63uR2
	x+olMUpd11TgLZt4aAgQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wjx9y1tj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 07:03:05 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 421734uR003269
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Mar 2024 07:03:04 GMT
Received: from [10.238.139.231] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 29 Feb
 2024 23:03:01 -0800
Message-ID: <482ac768-ab2d-4f19-9245-df6b5ae5164a@quicinc.com>
Date: Fri, 1 Mar 2024 15:02:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2] arm64: dts: qcom: qcm6490-idp: enable pwrkey
 and volume-up/down function
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240228-gpio-keys-v2-1-3beb60225abe@quicinc.com>
 <CAA8EJppHUYZ46Bz48HzY-D9brBRj+TEw_-6j_VUDyMZPxwf8tQ@mail.gmail.com>
From: hui liu <quic_huliu@quicinc.com>
In-Reply-To: <CAA8EJppHUYZ46Bz48HzY-D9brBRj+TEw_-6j_VUDyMZPxwf8tQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: csChZRxnKCfmSdZIbljLMKym2Ap6SAzT
X-Proofpoint-ORIG-GUID: csChZRxnKCfmSdZIbljLMKym2Ap6SAzT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_04,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 clxscore=1011 impostorscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403010057



On 2/29/2024 9:21 AM, Dmitry Baryshkov wrote:
> On Wed, 28 Feb 2024 at 11:57, Hui Liu via B4 Relay
> <devnull+quic_huliu.quicinc.com@kernel.org> wrote:
>>
>> From: Hui Liu <quic_huliu@quicinc.com>
>>
>> Add configurations to enable pwrkey, volume-up and volume-down function.
> 
> Please take a look at how similar patches describe the changes. E.g.
> commit bb47bfbd5aa8 ("arm64: dts: qcom: sm8550-qrd: enable PMIC Volume
> and Power buttons")
Sure, I will refer to this description to update it.
> 
> 
> 
>>
>> Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
>> ---
>> Changes in v2:
>> - Update the commit description.
>> - Link to v1: https://lore.kernel.org/r/20240206-gpio-keys-v1-1-7683799daf8d@quicinc.com
>> ---
>>   arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 43 ++++++++++++++++++++++++++++++++
>>   1 file changed, 43 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>> index acf145d1d97c..4199ebf667af 100644
>> --- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>> @@ -9,6 +9,7 @@
>>   #define PM7250B_SID 8
>>   #define PM7250B_SID1 9
>>
>> +#include <dt-bindings/input/linux-event-codes.h>
>>   #include <dt-bindings/leds/common.h>
>>   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>   #include "sc7280.dtsi"
>> @@ -39,6 +40,24 @@ chosen {
>>                  stdout-path = "serial0:115200n8";
>>          };
>>
>> +       gpio-keys {
>> +               compatible = "gpio-keys";
>> +               label = "gpio-keys";
>> +
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&key_vol_up_default>;
>> +
>> +               key-volume-up {
>> +                       label = "volume_up";
>> +                       gpios = <&pm7325_gpios 6 GPIO_ACTIVE_LOW>;
>> +                       linux,input-type = <1>;
>> +                       linux,code = <KEY_VOLUMEUP>;
>> +                       wakeup-source;
>> +                       debounce-interval = <15>;
>> +                       linux,can-disable;
>> +               };
>> +       };
>> +
>>          reserved-memory {
>>                  xbl_mem: xbl@80700000 {
>>                          reg = <0x0 0x80700000 0x0 0x100000>;
>> @@ -421,6 +440,17 @@ vreg_bob_3p296: bob {
>>          };
>>   };
>>
>> +&pm7325_gpios {
>> +       key_vol_up_default: key-vol-up-state {
>> +               pins = "gpio6";
>> +               function = "normal";
>> +               input-enable;
>> +               bias-pull-up;
>> +               power-source = <0>;
>> +               qcom,drive-strength = <3>;
> 
> Why is this property required? Anyway, it should use the defined name
> rather than just numeric value.
I will remove power-source defination, because the default value is 0.
And "qcom, driver-strength" will update to "PMIC_GPIO_STRENGTH_LOW", 
it's a special value for pm7325.
> 
>> +       };
>> +};
>> +
>>   &pm8350c_pwm {
>>          status = "okay";
>>
>> @@ -448,6 +478,19 @@ led@3 {
>>          };
>>   };
>>
>> +&pmk8350_pon {
>> +       status = "okay";
>> +};
>> +
>> +&pon_pwrkey {
>> +       status = "okay";
>> +};
>> +
>> +&pon_resin {
>> +       linux,code = <KEY_VOLUMEDOWN>;
>> +       status = "okay";
>> +};
>> +
>>   &qupv3_id_0 {
>>          status = "okay";
>>   };
>>
>> ---
>> base-commit: 23e11d0318521e8693459b0e4d23aec614b3b68b
>> change-id: 20240206-gpio-keys-138bbd850298
>>
>> Best regards,
>> --
>> Hui Liu <quic_huliu@quicinc.com>
>>
>>
> 
> 


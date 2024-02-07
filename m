Return-Path: <linux-kernel+bounces-55846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB3B84C272
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640C91C217E4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021BFEEAC;
	Wed,  7 Feb 2024 02:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="btjl8GTE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B621CD1E;
	Wed,  7 Feb 2024 02:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707272457; cv=none; b=mpCRGjmZYCHBicko86TJWaVXCIdkOxZLMdXoQ4aIEIangWboutTRMPjsw2WOZYJx16gyJQ3nXNdYY2b7nI+PDqX6e226urg7g8k4igWktdPp2jwB/lWrpYWcsM0E5qsrlEyRxQ/56Y5xggv4qJxuWc0CDCfMflEHCThp06xEYKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707272457; c=relaxed/simple;
	bh=pPmjLZQk/syRJBZPIvptZzEbOgte7u2NJek0+dwN9uI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aAVeMGgca/RrhqJo9JMpiUQbelkM8d5NafDXyGD531u1eN0T2JA4dIdiZBU1XVoblM6H+EhHr4zCkB3qUNcjXeKaVlOQOcGDxXxOHewdnJooD8E2ZjFR6klO+8wySP7/kq8diZkWh0gB4vxE51hL7GEnkJCVczLEXYQl2FT3olY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=btjl8GTE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4172GFsb021935;
	Wed, 7 Feb 2024 02:20:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=9QXtNKq4I3TBfat6HvMurueK9bBBSRepYLI4I1syHAU=; b=bt
	jl8GTEmvoepvnpfU3SEoguLqLnokI9p0408idwXGVO+tvgmC2fvpVupDLgPdT2mp
	jDxgGF6G4Avk7IXvVFJygFBTjSs626wsIaEpGHAR8BgMgYa1Z5kpLJbmOXtk3oHf
	lCR9i6Lgoxox98amX30L2nBmLnKISPn52PZGNDZK0zn2orztMC+WDM/T/tCRKOp9
	mxifYGLmKw0Q64SHHstOTQnb6vxwM8yrYrgEiBbk/oWN/EFFcWEOt+PXJivsAr/x
	WGTXWxigHNmoGfA9fNRn0ty7VQIkQQ2tzrsCRAJLeWvlC8kBWVlmJ2FjchAOxHW6
	moPnzTcRGFdVf9ur7PJg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3k6g9s8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 02:20:51 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4172KpIK023475
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 Feb 2024 02:20:51 GMT
Received: from [10.238.139.231] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 6 Feb
 2024 18:20:47 -0800
Message-ID: <feef8ddd-c816-4088-ae21-eb9afdbfc86e@quicinc.com>
Date: Wed, 7 Feb 2024 10:20:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: qcm6490-idp: Add configurations for
 gpio-keys
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
References: <20240206-gpio-keys-v1-1-7683799daf8d@quicinc.com>
 <CAA8EJpqo6p+S4JirhGybGsiG0X9Evdb3LEVgorsewEcRT8LMgg@mail.gmail.com>
From: hui liu <quic_huliu@quicinc.com>
In-Reply-To: <CAA8EJpqo6p+S4JirhGybGsiG0X9Evdb3LEVgorsewEcRT8LMgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9G6tJPLMzklHsEzX-k594KXxO8iN0zux
X-Proofpoint-GUID: 9G6tJPLMzklHsEzX-k594KXxO8iN0zux
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_16,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1011
 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402070016



On 2/6/2024 1:57 PM, Dmitry Baryshkov wrote:
> On Tue, 6 Feb 2024 at 04:21, Hui Liu via B4 Relay
> <devnull+quic_huliu.quicinc.com@kernel.org> wrote:
>>
>> From: Hui Liu <quic_huliu@quicinc.com>
>>
>> Add configurations for gpio-keys to enable pon_key and pon_resin
>> key.
> 
> Configuring gpio-keys is a requirement for enabling the pon_key and
> pon_resin, so the commit message is incorrect.
Hi Dmitry,
This change is used to enable pwrkey, volume-up and volume-down 
function, and the gpio-keys configuration is used to enable volume-up.

So can I update the commit message as below:

arm64: dts: qcom: qcm6490-idp: enable pwrkey and volume-up/down function

Add configurations to enable pwrkey, volume-up and volume-down function.

Thanks,
Hui

> 
> 
> 
> 
>>
>> Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
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
> 
> pinctrl-names should come after pinctrl-0
I will update it in next change
> 
> LGTM otherwise
> 
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
> --
> With best wishes
> 
> Dmitry


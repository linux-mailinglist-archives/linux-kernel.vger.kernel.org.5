Return-Path: <linux-kernel+bounces-35257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AF2838EAF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72F9DB24692
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E7F5EE7A;
	Tue, 23 Jan 2024 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FYfP5UPX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB1B5DF00;
	Tue, 23 Jan 2024 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706013833; cv=none; b=lSUjG8TurWyYQqtXFIT9Y504KTRLF4zOrVrFqVY2ipc4zx1DPReRLyqIqHZSMUqTDNJ15Yf/6k8/MOGRmpmlrxdJZta7v6F5oDRpPW1aB6VALLTOARGHOMWgFhWiD166X3RqN28xSA3VX7ecsDIIX1ntPTNTbhKLPMw7laEjz1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706013833; c=relaxed/simple;
	bh=UCvBeVxZH1I1W7aFnfZBfhYgFfhsl9L84uwbqQ3nMCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h8KGWNUjWAVlQVYll7C2+ChZoPAZ/ozJg1UaOaW8PTL98HJ833Mws8kjnvcqIIUs65b+Pr4Cb1pIMJpk6T53hCnjiXA35tmJOqVtcoNz4H1XmF7Bve2ctCPxiENj7h4xvuecgKIIx/cTpW0I+vg5eMOM+6t6DKbAIgW2gEGt+M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FYfP5UPX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40NC54D4030979;
	Tue, 23 Jan 2024 12:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=TooN9L+vXIdff2SYsZTJWgp3hQjbI0Ip9LJ8U0o9bcQ=; b=FY
	fP5UPXWheHCqFQhE5URa3APBOfqtn/JraDFCKNUvdPqFu/HHAZZCpBX37YXuKWcO
	aCbrGgV7E6HRNyauGHAl/L1WnmD5BwcrcN4zV20nw6A0pSqOMAM3EyfNEP3gm2sW
	zL5yTvTA8eTkp/95+pf0ATh+JsSYu9/Q9913EhuBng3fDQzcTXpHu6e7dR0kgo7c
	QBoZYhagYptRp83aJmwK/jhzlJUqHVTcBIsqYiuVoXKH541rgccFO3p9To6EE10P
	8zENnzII0mpi2UFE77Ix/mBpCbmcVZUqOqWFWXRbhkN69WwIbrWBm57ON8Ll2cr0
	J5ZW4j7UVfubbIsOB1yA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vspw8ubfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 12:43:33 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40NChWmh008205
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 12:43:32 GMT
Received: from [10.204.67.124] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 23 Jan
 2024 04:43:26 -0800
Message-ID: <b9012927-b357-4875-9e8e-90df5cc8d8bb@quicinc.com>
Date: Tue, 23 Jan 2024 18:13:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: qcm6490-idp: add display and panel
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <quic_bjorande@quicinc.com>, <geert+renesas@glider.be>,
        <arnd@arndb.de>, <neil.armstrong@linaro.org>,
        <nfraprado@collabora.com>, <m.szyprowski@samsung.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <quic_abhinavk@quicinc.com>, <quic_rajeevny@quicinc.com>,
        <quic_vproddut@quicinc.com>
References: <20240116094935.9988-1-quic_riteshk@quicinc.com>
 <20240116094935.9988-3-quic_riteshk@quicinc.com>
 <CAA8EJpp3WJ8132aB-tyzJPXsdczvQC+TvKemm9NvUNYNrEntow@mail.gmail.com>
From: Ritesh Kumar <quic_riteshk@quicinc.com>
In-Reply-To: <CAA8EJpp3WJ8132aB-tyzJPXsdczvQC+TvKemm9NvUNYNrEntow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xDS6e3yalMauhsyKjjuTFgUI0ZJslTnJ
X-Proofpoint-ORIG-GUID: xDS6e3yalMauhsyKjjuTFgUI0ZJslTnJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_06,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401230094


On 1/16/2024 3:28 PM, Dmitry Baryshkov wrote:

> On Tue, 16 Jan 2024 at 11:49, Ritesh Kumar <quic_riteshk@quicinc.com> wrote:
>> Enable Display Subsystem with Novatek NT36672E Panel
>> on qcm6490 idp platform.
> Is this panel always present on the IDP board or is it an optional
> addon, like the panels for all the RBn boards?

This panel is always present on the IDP board.

>> Signed-off-by: Ritesh Kumar <quic_riteshk@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 100 +++++++++++++++++++++++
>>   1 file changed, 100 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>> index 2a6e4907c5ee..efa5252130a1 100644
>> --- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>> @@ -9,6 +9,7 @@
>>   #define PM7250B_SID 8
>>   #define PM7250B_SID1 9
>>
>> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>>   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>   #include "sc7280.dtsi"
>>   #include "pm7250b.dtsi"
>> @@ -38,6 +39,25 @@
>>                  stdout-path = "serial0:115200n8";
>>          };
>>
>> +       lcd_disp_bias: lcd-disp-bias-regulator {
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "lcd_disp_bias";
>> +               regulator-min-microvolt = <5500000>;
>> +               regulator-max-microvolt = <5500000>;
>> +               gpio = <&pm7250b_gpios 2 GPIO_ACTIVE_HIGH>;
>> +               enable-active-high;
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&lcd_disp_bias_en>;
>> +       };
>> +
>> +       pm8350c_pwm_backlight: backlight {
>> +               compatible = "pwm-backlight";
>> +               pwms = <&pm8350c_pwm 3 65535>;
>> +               enable-gpios = <&pm8350c_gpios 7 GPIO_ACTIVE_HIGH>;
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&pmic_lcd_bl_en>;
>> +       };
>> +
>>          reserved-memory {
>>                  xbl_mem: xbl@80700000 {
>>                          reg = <0x0 0x80700000 0x0 0x100000>;
>> @@ -420,6 +440,86 @@
>>          };
>>   };
>>
>> +&gpu {
>> +       status = "disabled";
>> +};
>> +
>> +&mdss {
>> +       status = "okay";
>> +};
>> +
>> +&mdss_dsi {
>> +       vdda-supply = <&vreg_l6b_1p2>;
>> +       status = "okay";
>> +
>> +       panel@0 {
>> +               compatible = "novatek,nt36672e";
>> +               reg = <0>;
>> +
>> +               reset-gpios = <&tlmm 44 GPIO_ACTIVE_HIGH>;
>> +
>> +               vddi-supply = <&vreg_l8c_1p62>;
>> +               avdd-supply = <&lcd_disp_bias>;
>> +               avee-supply = <&lcd_disp_bias>;
>> +
>> +               backlight = <&pm8350c_pwm_backlight>;
>> +
>> +               port {
>> +                       panel0_in: endpoint {
>> +                               remote-endpoint = <&mdss_dsi0_out>;
>> +                       };
>> +               };
>> +       };
>> +};
>> +
>> +&mdss_dsi0_out {
>> +       remote-endpoint = <&panel0_in>;
>> +       data-lanes = <0 1 2 3>;
>> +};
>> +
>> +&mdss_dsi_phy {
>> +       vdds-supply = <&vreg_l10c_0p88>;
>> +       status = "okay";
>> +};
>> +
>> +&pm7250b_gpios {
>> +       lcd_disp_bias_en: lcd-disp-bias-en-state {
>> +               pins = "gpio2";
>> +               function = "func1";
>> +               bias-disable;
>> +               qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
>> +               input-disable;
>> +               output-enable;
>> +               power-source = <0>;
>> +       };
>> +};
>> +
>> +&pm8350c_gpios {
>> +       pmic_lcd_bl_en: pmic-lcd-bl-en-state {
>> +               pins = "gpio7";
>> +               function = "normal";
>> +               bias-disable;
>> +               qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
>> +               output-low;
>> +               power-source = <0>;
>> +       };
>> +
>> +       pmic_lcd_bl_pwm: pmic-lcd-bl-pwm-state {
>> +               pins = "gpio8";
>> +               function = "func1";
>> +               bias-disable;
>> +               qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
>> +               output-low;
>> +               power-source = <0>;
>> +       };
>> +};
>> +
>> +&pm8350c_pwm {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pmic_lcd_bl_pwm>;
>> +       status = "okay";
>> +};
>> +
>>   &qupv3_id_0 {
>>          status = "okay";
>>   };
>> --
>> 2.17.1
>>

Thanks,
Ritesh


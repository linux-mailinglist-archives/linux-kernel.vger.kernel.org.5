Return-Path: <linux-kernel+bounces-7966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B7A81AFD9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79FBEB22BFB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295D116438;
	Thu, 21 Dec 2023 07:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jLHpEzas"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D559A16413;
	Thu, 21 Dec 2023 07:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BL6bL46002733;
	Thu, 21 Dec 2023 07:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=us2HKFxHPs+gXJBcMDDOYaOVnAgTak/lOue7n+uyzbQ=; b=jL
	HpEzasz2o5jPl7Yo/8J7XEw6eyZx6fAFjWQt58h1hVCLHIY7mwIr6cEOxKprP+iK
	O4ozDCry73B1+PGcUrx2MHOgcZR6gl1d6L9D7FKdqMxxfDgzj71mAbj56WlWrBr9
	VcW3XG2+cuV0G0cA3proPSTIHwN9HejwA7fi0o4iBWAr8OWsQBkY4FFm/utipegs
	hPqIU18LPvcPT3H7ppOTM9mx1bBGMRq6wG7nbxpzb8HsTia6Nu7yVJLxJefexHXq
	AObAHyI+AOnZmjATKeHZyC5LbfWJ4Ekluyl+/s6wAjF5628ehVloHYEXFPCqF3xg
	Onsj2haUaoRrAkAgP5nw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4g8egbjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 07:54:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BL7sqLI008302
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 07:54:53 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 23:54:47 -0800
Message-ID: <d1fe3178-ac31-4db5-ac58-89866f308f46@quicinc.com>
Date: Thu, 21 Dec 2023 15:54:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] arm64: dts: qcom: add base AIM300 dtsi
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Fenglin Wu <quic_fenglinw@quicinc.com>,
        <kernel@quicinc.com>
References: <20231219005007.11644-1-quic_tengfan@quicinc.com>
 <20231219005007.11644-6-quic_tengfan@quicinc.com>
 <CAA8EJpoBuUVu00-s6uVJpYWB2Bvn2VnJqV8b9CicMfgvfokxdg@mail.gmail.com>
 <b46398da-ef01-432a-896d-f4ce2436ec52@quicinc.com>
 <CAA8EJpoMovSoe1_GBQ-pB=xaEUoo+32Wmo3afE_WAeBZh66g7g@mail.gmail.com>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <CAA8EJpoMovSoe1_GBQ-pB=xaEUoo+32Wmo3afE_WAeBZh66g7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EHKahoTMmxwbtBVA920HmIuyaWeG5-7j
X-Proofpoint-ORIG-GUID: EHKahoTMmxwbtBVA920HmIuyaWeG5-7j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312210057



On 12/20/2023 3:00 PM, Dmitry Baryshkov wrote:
> On Wed, 20 Dec 2023 at 03:23, Tengfei Fan <quic_tengfan@quicinc.com> wrote:
>>
>>
>>
>> On 12/19/2023 6:25 PM, Dmitry Baryshkov wrote:
>>> On Tue, 19 Dec 2023 at 02:52, Tengfei Fan <quic_tengfan@quicinc.com> wrote:
>>>>
>>>> AIM300 is a module with QCS8550 SoC, UFS and PMIC chip.
>>>> AIM300 Series is a highly optimized family of modules designed to support
>>>> AIoT applications. The Module is mounted onto Qualcomm AIoT carrier board
>>>> to support verification, evaluation and development.
>>>>
>>>> Co-developed-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>>>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi | 371 +++++++++++++++++++
>>>>    1 file changed, 371 insertions(+)
>>>>    create mode 100644 arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi b/arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi
>>>> new file mode 100644
>>>> index 000000000000..04ca4597f952
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi
>>>> @@ -0,0 +1,371 @@
>>>> +// SPDX-License-Identifier: BSD-3-Clause
>>>> +/*
>>>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>>>> + */
>>>> +
>>>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>>> +#include "qcs8550.dtsi"
>>>> +#include "pm8010.dtsi"
>>>> +#include "pm8550.dtsi"
>>>> +#include "pm8550b.dtsi"
>>>> +#define PMK8550VE_SID 5
>>>> +#include "pm8550ve.dtsi"
>>>> +#include "pm8550vs.dtsi"
>>>> +#include "pmk8550.dtsi"
>>>> +#include "pmr735d_a.dtsi"
>>>> +#include "pmr735d_b.dtsi"
>>>> +
>>>> +/ {
>>>> +       vph_pwr: vph-pwr-regulator {
>>>> +               compatible = "regulator-fixed";
>>>> +               regulator-name = "vph_pwr";
>>>> +               regulator-min-microvolt = <3700000>;
>>>> +               regulator-max-microvolt = <3700000>;
>>>> +
>>>> +               regulator-always-on;
>>>> +               regulator-boot-on;
>>>> +       };
>>>> +};
>>>
>>> Is VPH_PWR regulator present on the SoM or on the carrier board?VPH_PWR regulator present on the SoM.
> 
> If not for gmail, I could have missed your reply.
> 
> Maybe it is a good idea to add an explicit comment here.


        ________________________________________
       |AIM300 SoM                              |
       |                            _____       |
       |                           |     |      |
       |                      |--->| UFS |      |
       |                      |    |_____|      |
       |                      |                 |
       |   _________________  |     _________   |
  3.8v |  |                 | |    |         |  |
-------->|   Regulatorss   |----->| QCS8550 |  |
       |  |_________________| |    |_________|  |
       |                      |                 |
       |                      |     _____       |
       |                      |    |     |      |
       |                      |--->| ... |      |
       |                           |_____|      |
       |                                        |
       |________________________________________|


VPH_PWR is obtained by vonverting 12v voltage into 3.8 voltage with a 
3.8v buck. VPH_PWR is power supply for regulators in AIM300 SOM. 
VPH_PWR regulator is defined in AIM300 SOM dtsi file.

> 
> BTW: what regulators are present on the carrier board rather than on the SoM?

The regulators in pm8550, pm8550ve and pm8550vs are present on the SoM. 
The regulators in pm8010 and pmr73d are present on the carrier board.

In the next version patch series, pm8010 and pmr73d will be moved from 
SOM dtsi to carrier board dts file.

> 
>>>
>>>> +
>>>> +&apps_rsc {
>>>> +       regulators-0 {
>>>> +               compatible = "qcom,pm8550-rpmh-regulators";
>>>> +               qcom,pmic-id = "b";
>>>> +
>>>> +               vdd-bob1-supply = <&vph_pwr>;
>>>> +               vdd-bob2-supply = <&vph_pwr>;
>>>> +               vdd-l1-l4-l10-supply = <&vreg_s6g_1p86>;
>>>> +               vdd-l2-l13-l14-supply = <&vreg_bob1>;
>>>> +               vdd-l3-supply = <&vreg_s4g_1p25>;
>>>> +               vdd-l5-l16-supply = <&vreg_bob1>;
>>>> +               vdd-l6-l7-supply = <&vreg_bob1>;
>>>> +               vdd-l8-l9-supply = <&vreg_bob1>;
>>>> +               vdd-l11-supply = <&vreg_s4g_1p25>;
>>>> +               vdd-l12-supply = <&vreg_s6g_1p86>;
>>>> +               vdd-l15-supply = <&vreg_s6g_1p86>;
>>>> +               vdd-l17-supply = <&vreg_bob2>;
>>>> +
>>>> +               vreg_bob1: bob1 {
>>>> +                       regulator-name = "vreg_bob1";
>>>> +                       regulator-min-microvolt = <3296000>;
>>>> +                       regulator-max-microvolt = <3960000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +
>>>> +               vreg_bob2: bob2 {
>>>> +                       regulator-name = "vreg_bob2";
>>>> +                       regulator-min-microvolt = <2720000>;
>>>> +                       regulator-max-microvolt = <3960000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +
>>>> +               vreg_l1b_1p8: ldo1 {
>>>> +                       regulator-name = "vreg_l1b_1p8";
>>>> +                       regulator-min-microvolt = <1800000>;
>>>> +                       regulator-max-microvolt = <1800000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +
>>>> +               vreg_l2b_3p0: ldo2 {
>>>> +                       regulator-name = "vreg_l2b_3p0";
>>>> +                       regulator-min-microvolt = <3008000>;
>>>> +                       regulator-max-microvolt = <3008000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +
>>>> +               vreg_l5b_3p1: ldo5 {
>>>> +                       regulator-name = "vreg_l5b_3p1";
>>>> +                       regulator-min-microvolt = <3104000>;
>>>> +                       regulator-max-microvolt = <3104000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +
>>>> +               vreg_l6b_1p8: ldo6 {
>>>> +                       regulator-name = "vreg_l6b_1p8";
>>>> +                       regulator-min-microvolt = <1800000>;
>>>> +                       regulator-max-microvolt = <3008000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +
>>>> +               vreg_l7b_1p8: ldo7 {
>>>> +                       regulator-name = "vreg_l7b_1p8";
>>>> +                       regulator-min-microvolt = <1800000>;
>>>> +                       regulator-max-microvolt = <3008000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +
>>>> +               vreg_l8b_1p8: ldo8 {
>>>> +                       regulator-name = "vreg_l8b_1p8";
>>>> +                       regulator-min-microvolt = <1800000>;
>>>> +                       regulator-max-microvolt = <3008000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +
>>>> +               vreg_l9b_2p9: ldo9 {
>>>> +                       regulator-name = "vreg_l9b_2p9";
>>>> +                       regulator-min-microvolt = <2960000>;
>>>> +                       regulator-max-microvolt = <3008000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +
>>>> +               vreg_l11b_1p2: ldo11 {
>>>> +                       regulator-name = "vreg_l11b_1p2";
>>>> +                       regulator-min-microvolt = <1200000>;
>>>> +                       regulator-max-microvolt = <1504000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +
>>>> +               vreg_l12b_1p8: ldo12 {
>>>> +                       regulator-name = "vreg_l12b_1p8";
>>>> +                       regulator-min-microvolt = <1800000>;
>>>> +                       regulator-max-microvolt = <1800000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +
>>>> +               vreg_l13b_3p0: ldo13 {
>>>> +                       regulator-name = "vreg_l13b_3p0";
>>>> +                       regulator-min-microvolt = <3000000>;
>>>> +                       regulator-max-microvolt = <3000000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +
>>>> +               vreg_l14b_3p2: ldo14 {
>>>> +                       regulator-name = "vreg_l14b_3p2";
>>>> +                       regulator-min-microvolt = <3200000>;
>>>> +                       regulator-max-microvolt = <3200000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +
>>>> +               vreg_l15b_1p8: ldo15 {
>>>> +                       regulator-name = "vreg_l15b_1p8";
>>>> +                       regulator-min-microvolt = <1800000>;
>>>> +                       regulator-max-microvolt = <1800000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +
>>>> +               vreg_l16b_2p8: ldo16 {
>>>> +                       regulator-name = "vreg_l16b_2p8";
>>>> +                       regulator-min-microvolt = <1800000>;
>>>> +                       regulator-max-microvolt = <3300000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +
>>>> +               vreg_l17b_2p5: ldo17 {
>>>> +                       regulator-name = "vreg_l17b_2p5";
>>>> +                       regulator-min-microvolt = <2504000>;
>>>> +                       regulator-max-microvolt = <2504000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +       };
>>>> +
>>>> +       regulators-1 {
>>>> +               compatible = "qcom,pm8550vs-rpmh-regulators";
>>>> +               qcom,pmic-id = "c";
>>>> +
>>>> +               vdd-l1-supply = <&vreg_s4g_1p25>;
>>>> +               vdd-l2-supply = <&vreg_s4e_0p95>;
>>>> +               vdd-l3-supply = <&vreg_s4e_0p95>;
>>>> +
>>>> +               vreg_l3c_0p9: ldo3 {
>>>> +                       regulator-name = "vreg_l3c_0p9";
>>>> +                       regulator-min-microvolt = <880000>;
>>>> +                       regulator-max-microvolt = <912000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +       };
>>>> +
>>>> +       regulators-2 {
>>>> +               compatible = "qcom,pm8550vs-rpmh-regulators";
>>>> +               qcom,pmic-id = "d";
>>>> +
>>>> +               vdd-l1-supply = <&vreg_s4e_0p95>;
>>>> +               vdd-l2-supply = <&vreg_s4e_0p95>;
>>>> +               vdd-l3-supply = <&vreg_s4e_0p95>;
>>>> +
>>>> +               vreg_l1d_0p88: ldo1 {
>>>> +                       regulator-name = "vreg_l1d_0p88";
>>>> +                       regulator-min-microvolt = <880000>;
>>>> +                       regulator-max-microvolt = <920000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +       };
>>>> +
>>>> +       regulators-3 {
>>>> +               compatible = "qcom,pm8550vs-rpmh-regulators";
>>>> +               qcom,pmic-id = "e";
>>>> +
>>>> +               vdd-l1-supply = <&vreg_s4e_0p95>;
>>>> +               vdd-l2-supply = <&vreg_s4e_0p95>;
>>>> +               vdd-l3-supply = <&vreg_s4g_1p25>;
>>>> +               vdd-s4-supply = <&vph_pwr>;
>>>> +               vdd-s5-supply = <&vph_pwr>;
>>>> +
>>>> +               vreg_s4e_0p95: smps4 {
>>>> +                       regulator-name = "vreg_s4e_0p95";
>>>> +                       regulator-min-microvolt = <904000>;
>>>> +                       regulator-max-microvolt = <984000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +
>>>> +               vreg_s5e_1p08: smps5 {
>>>> +                       regulator-name = "vreg_s5e_1p08";
>>>> +                       regulator-min-microvolt = <1010000>;
>>>> +                       regulator-max-microvolt = <1120000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +
>>>> +               vreg_l1e_0p88: ldo1 {
>>>> +                       regulator-name = "vreg_l1e_0p88";
>>>> +                       regulator-min-microvolt = <880000>;
>>>> +                       regulator-max-microvolt = <912000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +
>>>> +               vreg_l2e_0p9: ldo2 {
>>>> +                       regulator-name = "vreg_l2e_0p9";
>>>> +                       regulator-min-microvolt = <870000>;
>>>> +                       regulator-max-microvolt = <970000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +
>>>> +               vreg_l3e_1p2: ldo3 {
>>>> +                       regulator-name = "vreg_l3e_1p2";
>>>> +                       regulator-min-microvolt = <1200000>;
>>>> +                       regulator-max-microvolt = <1200000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +       };
>>>> +
>>>> +       regulators-4 {
>>>> +               compatible = "qcom,pm8550ve-rpmh-regulators";
>>>> +               qcom,pmic-id = "f";
>>>> +
>>>> +               vdd-l1-supply = <&vreg_s4e_0p95>;
>>>> +               vdd-l2-supply = <&vreg_s4e_0p95>;
>>>> +               vdd-l3-supply = <&vreg_s4e_0p95>;
>>>> +               vdd-s4-supply = <&vph_pwr>;
>>>> +
>>>> +               vreg_s4f_0p5: smps4 {
>>>> +                       regulator-name = "vreg_s4f_0p5";
>>>> +                       regulator-min-microvolt = <500000>;
>>>> +                       regulator-max-microvolt = <600000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +
>>>> +               vreg_l1f_0p9: ldo1 {
>>>> +                       regulator-name = "vreg_l1f_0p9";
>>>> +                       regulator-min-microvolt = <880000>;
>>>> +                       regulator-max-microvolt = <912000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +
>>>> +               vreg_l2f_0p88: ldo2 {
>>>> +                       regulator-name = "vreg_l2f_0p88";
>>>> +                       regulator-min-microvolt = <880000>;
>>>> +                       regulator-max-microvolt = <912000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +
>>>> +               vreg_l3f_0p88: ldo3 {
>>>> +                       regulator-name = "vreg_l3f_0p88";
>>>> +                       regulator-min-microvolt = <880000>;
>>>> +                       regulator-max-microvolt = <912000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +       };
>>>> +
>>>> +       regulators-5 {
>>>> +               compatible = "qcom,pm8550vs-rpmh-regulators";
>>>> +               qcom,pmic-id = "g";
>>>> +               vdd-l1-supply = <&vreg_s4g_1p25>;
>>>> +               vdd-l2-supply = <&vreg_s4g_1p25>;
>>>> +               vdd-l3-supply = <&vreg_s4g_1p25>;
>>>> +               vdd-s1-supply = <&vph_pwr>;
>>>> +               vdd-s2-supply = <&vph_pwr>;
>>>> +               vdd-s3-supply = <&vph_pwr>;
>>>> +               vdd-s4-supply = <&vph_pwr>;
>>>> +               vdd-s5-supply = <&vph_pwr>;
>>>> +               vdd-s6-supply = <&vph_pwr>;
>>>> +
>>>> +               vreg_s1g_1p25: smps1 {
>>>> +                       regulator-name = "vreg_s1g_1p25";
>>>> +                       regulator-min-microvolt = <1200000>;
>>>> +                       regulator-max-microvolt = <1300000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +
>>>> +               vreg_s2g_0p85: smps2 {
>>>> +                       regulator-name = "vreg_s2g_0p85";
>>>> +                       regulator-min-microvolt = <800000>;
>>>> +                       regulator-max-microvolt = <1000000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +
>>>> +               vreg_s3g_0p8: smps3 {
>>>> +                       regulator-name = "vreg_s3g_0p8";
>>>> +                       regulator-min-microvolt = <300000>;
>>>> +                       regulator-max-microvolt = <1004000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +
>>>> +               vreg_s4g_1p25: smps4 {
>>>> +                       regulator-name = "vreg_s4g_1p25";
>>>> +                       regulator-min-microvolt = <1200000>;
>>>> +                       regulator-max-microvolt = <1300000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +
>>>> +               vreg_s5g_0p85: smps5 {
>>>> +                       regulator-name = "vreg_s5g_0p85";
>>>> +                       regulator-min-microvolt = <500000>;
>>>> +                       regulator-max-microvolt = <1004000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +
>>>> +               vreg_s6g_1p86: smps6 {
>>>> +                       regulator-name = "vreg_s6g_1p86";
>>>> +                       regulator-min-microvolt = <1800000>;
>>>> +                       regulator-max-microvolt = <2000000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +
>>>> +               vreg_l1g_1p2: ldo1 {
>>>> +                       regulator-name = "vreg_l1g_1p2";
>>>> +                       regulator-min-microvolt = <1200000>;
>>>> +                       regulator-max-microvolt = <1200000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +
>>>> +               vreg_l2g_1p2: ldo2 {
>>>> +                       regulator-name = "vreg_l2g_1p2";
>>>> +                       regulator-min-microvolt = <1100000>;
>>>> +                       regulator-max-microvolt = <1200000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +
>>>> +               vreg_l3g_1p2: ldo3 {
>>>> +                       regulator-name = "vreg_l3g_1p2";
>>>> +                       regulator-min-microvolt = <1200000>;
>>>> +                       regulator-max-microvolt = <1200000>;
>>>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>> +               };
>>>> +       };
>>>> +};
>>>> +
>>>> +&ufs_mem_hc {
>>>> +       reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
>>>> +       vcc-supply = <&vreg_l17b_2p5>;
>>>> +       vcc-max-microamp = <1300000>;
>>>> +       vccq-supply = <&vreg_l1g_1p2>;
>>>> +       vccq-max-microamp = <1200000>;
>>>> +       vdd-hba-supply = <&vreg_l3g_1p2>;
>>>> +
>>>> +       status = "okay";
>>>> +};
>>>> +
>>>> +&ufs_mem_phy {
>>>> +       vdda-phy-supply = <&vreg_l1d_0p88>;
>>>> +       vdda-pll-supply = <&vreg_l3e_1p2>;
>>>> +
>>>> +       status = "okay";
>>>> +};
>>>> --
>>>> 2.17.1
>>>>
>>>>
>>>
>>>
>>
>> --
>> Thx and BRs,
>> Tengfei Fan
> 
> 
> 

-- 
Thx and BRs,
Tengfei Fan


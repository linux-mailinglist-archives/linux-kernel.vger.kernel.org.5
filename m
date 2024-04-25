Return-Path: <linux-kernel+bounces-157963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5575A8B1961
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D305F1F22F5D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0D0200DB;
	Thu, 25 Apr 2024 03:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jVYrdRJn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D56B17984;
	Thu, 25 Apr 2024 03:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714015353; cv=none; b=k9pv1uoqlk2CVh+z4fM5jRk2yL2dXQIEsAvviJ9Qi85MEiLKZRdRe0Y1C8aLb1cky6pY7bFMIGvtU+VINkisFXEFf3NszPOCIZCY9YTF/NfL+05JyP6lAyaadPDqKI+thnM3ACVBSQrvwkrXU7SL85Ema7iIx27S3nO9f0ENMlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714015353; c=relaxed/simple;
	bh=393WtAksLvqPcqLg6+lmRUeMymf0L5IRVsfw0NPtUEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TSjWXRa97P1XYF8Wqic9oooQlYDVrGmI+ZS0csvoIGavsdRICTy6WJlWEmIPAzgAjNn/O6yUgJx7KEnyiW3xHZQMQkB/G/JMnF9RLITixsVFdLaNwkbkPbj3o+4YDc7v1ZDp4qXJtXu1bPsvSJkguY5lyaLAPqe090RBxp7wP54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jVYrdRJn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P3Hdrn008598;
	Thu, 25 Apr 2024 03:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=4cxntKwVraGLCBnbR7ZtUwYwtWlxpd+0jLDS/RxVY+Y=; b=jV
	YrdRJnvZkT+FmJOQNXDcLJZoRVgSp4ypDXgT60uofUm6octy11BhGLx+j9Un6aJL
	FnP6VavTBppl2+qPnmmfd7hq5Ia6d5ITgeNKqc2T3VWqt7AXsFprbNQCZZY1nZXv
	RioLWNaHwCCkfUrnFxt8aU6GhABOdU2XiGHmlXBgCmnVThbcHhQct+xdu5vP0P1+
	zyXgUzkSKGo/hDvyfF4aQP5S/NJ6M+iKOSgjFDI4VGmx9qDC3Zi1iMoODrGMQNHb
	pvmqy79LtmQsrjCp9hx7+iTSMnS5XOEm6M2IRjqfgLW7n7+9tyUXW+QAlyMB3IR6
	tQbeYNkPZ4uV7wLM9Ehg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenhg254-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 03:22:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43P3M17X006254
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 03:22:01 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 20:21:55 -0700
Message-ID: <7e2e252d-41ba-490c-aa7e-578b12c69049@quicinc.com>
Date: Thu, 25 Apr 2024 11:21:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] arm64: dts: qcom: add base AIM300 dtsi
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <keescook@chromium.org>,
        <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <kernel@quicinc.com>, Fenglin Wu <quic_fenglinw@quicinc.com>
References: <20240424024508.3857602-1-quic_tengfan@quicinc.com>
 <20240424024508.3857602-4-quic_tengfan@quicinc.com>
 <CAA8EJprceDUBtcrT0XLc7V9e0Joyw21YZD9=DONjTTfNM9chBw@mail.gmail.com>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <CAA8EJprceDUBtcrT0XLc7V9e0Joyw21YZD9=DONjTTfNM9chBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FpSyccOP7AdvwSpkfqMve9Qx0NpNdoBi
X-Proofpoint-ORIG-GUID: FpSyccOP7AdvwSpkfqMve9Qx0NpNdoBi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_02,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250023



On 4/25/2024 7:47 AM, Dmitry Baryshkov wrote:
> On Wed, 24 Apr 2024 at 05:46, Tengfei Fan <quic_tengfan@quicinc.com> wrote:
>>
>> AIM300 Series is a highly optimized family of modules designed to
>> support AIoT applications. It integrates QCS8550 SoC, UFS and PMIC
>> chip etc.
>> Here is a diagram of AIM300 SoM:
>>            +----------------------------------------+
>>            |AIM300 SoM                              |
>>            |                                        |
>>            |                           +-----+      |
>>            |                      |--->| UFS |      |
>>            |                      |    +-----+      |
>>            |                      |                 |
>>            |                      |                 |
>>       3.7v |  +-----------------+ |    +---------+  |
>>    ---------->|       PMIC      |----->| QCS8550 |  |
>>            |  +-----------------+      +---------+  |
>>            |                      |                 |
>>            |                      |                 |
>>            |                      |    +-----+      |
>>            |                      |--->| ... |      |
>>            |                           +-----+      |
>>            |                                        |
>>            +----------------------------------------+
>>
>> Co-developed-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi | 403 +++++++++++++++++++
>>   1 file changed, 403 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi
> 
> 
>> +
>> +&pcie_1_phy_aux_clk {
>> +       clock-frequency = <1000>;
>> +};
> 
> Please rebase on top of
> https://lore.kernel.org/linux-arm-msm/20240422-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v4-0-868b15a17a45@linaro.org/

Sure, I will reabse on the top of this patch series in the new version 
patch series

> 
>> +
>> +&pcie1 {
>> +       perst-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
>> +       wake-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
> 
> Please add pinctrl configurations for pcie0 and pcie1
> 
> With that fixed:
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

The pinctrl configurations of pcie0 and pcie1 will be moved to this dtsi 
file from Carrier Board dts file.

> 
>> +};
>> +
>>
> 
> --
> With best wishes
> Dmitry

-- 
Thx and BRs,
Tengfei Fan


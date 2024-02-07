Return-Path: <linux-kernel+bounces-56053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6809084C561
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990B11C2490B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4A61D55C;
	Wed,  7 Feb 2024 07:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LjPNDWLo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF821CF8D;
	Wed,  7 Feb 2024 07:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707289244; cv=none; b=f/F51RutRqK00D4xjPQ880sCIQSEWaWBo7TMtVr1GLpCwWB99oVhQ87+fAx1vDqIH8ZbUTm0POiw22S+0ueMfzPbcmYh4Dm4FzwjXBbRD25Zx8XswDxfxgXDvS6/pTBB73a/X8MS2Fyoe/F+sFiU9+gZQy0QL+orVAxkLaVDaLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707289244; c=relaxed/simple;
	bh=r+aNoSIU2aZ/OQtJAe4EnJxub9OQH6AmLMGoH19p5Wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uPZYSbdKqtaMUxE3THzIoE1OOyEukwVgOtZ5yoErGsIhWixxQOVegbKMubrbv0tGhPqG0dmmxNjEXMgEH8WsmH/0WjTGcTNXLqn0Ze4w1e1+oDXZ6Tm2Kk3MWU3P59KBw4H9zV+gXMEVlC7MAwbHv3uW+n+EuTY2xFG+CeKJo7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LjPNDWLo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4176RtGK005703;
	Wed, 7 Feb 2024 07:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=whcdathZMpoTTAAcZqnpx+wQAvypPjgRBCzDoMwmXa8=; b=Lj
	PNDWLoHRBHmVWnCFXJMMC5tqBxTry6LoL7eX8u7Sh5Aa3GPHalxAhGYgwFGcHnR1
	gqBBrJt6rWNbC0rS8PHIIlMpoEU8vL1LCjWKsu9slKIwjWPyWBhmEsYvjcONBP8h
	Ss0iETW1+7fCW7D6va9lxidQsSKsMg8Kkg5o5tA9m32bTf+GWbsdm1dpQrjdAuoI
	/Hwqw9fGFVLEsptyq8s9bxjL+lQ+S9Bh4hs/rYonKi2KhC03t7CFF2YNRfh2getQ
	Q3uxW5HvEu5Lp/a7Djqn4O9LtjC8eAZc8Z/KMY0Tv6uvWAUe7hB12fiawQTlYlPy
	GKxB4bfPUPxfKM9LxToA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w42qxg917-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 07:00:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41770b7e030853
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 Feb 2024 07:00:37 GMT
Received: from [10.217.216.47] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 6 Feb
 2024 23:00:32 -0800
Message-ID: <3675d5ba-2fd8-4513-b48d-ea9a0ac955b9@quicinc.com>
Date: Wed, 7 Feb 2024 12:30:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] clk: qcom: camcc-sm8650: Add camera clock controller
 driver for SM8650
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Ajit Pandey" <quic_ajipan@quicinc.com>
References: <20240206113145.31096-1-quic_jkona@quicinc.com>
 <20240206113145.31096-5-quic_jkona@quicinc.com>
 <CAA8EJpp7p35UECE7QfE-At+=xpa253=De+ZZNnaPSO9GqXCnrg@mail.gmail.com>
Content-Language: en-US
From: Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <CAA8EJpp7p35UECE7QfE-At+=xpa253=De+ZZNnaPSO9GqXCnrg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2k32E1r82OI5myhOqI96yruD5laIbfeH
X-Proofpoint-ORIG-GUID: 2k32E1r82OI5myhOqI96yruD5laIbfeH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_16,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 bulkscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402070049



On 2/6/2024 5:38 PM, Dmitry Baryshkov wrote:
> On Tue, 6 Feb 2024 at 13:41, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>>
>> Add support for the camera clock controller for camera clients to be
>> able to request for camcc clocks on SM8650 platform.
>>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> ---
>>   drivers/clk/qcom/Kconfig        |    8 +
>>   drivers/clk/qcom/Makefile       |    1 +
>>   drivers/clk/qcom/camcc-sm8650.c | 3601 +++++++++++++++++++++++++++++++
>>   3 files changed, 3610 insertions(+)
>>   create mode 100644 drivers/clk/qcom/camcc-sm8650.c
> [
> [skipped]
> 
>> +static int __init cam_cc_sm8650_init(void)
>> +{
>> +       return platform_driver_register(&cam_cc_sm8650_driver);
>> +}
>> +subsys_initcall(cam_cc_sm8650_init);
> 
> We have been here for the patch series for camcc-sm8550. Upstream
> reviewers expect that you don't repeat the same mistakes over and over
> again.
> 
> Please use module_platform_driver().
> 

Sorry I missed this change, will update this in next series.

Thanks,
Jagadeesh

>> +
>> +static void __exit cam_cc_sm8650_exit(void)
>> +{
>> +       platform_driver_unregister(&cam_cc_sm8650_driver);
>> +}
>> +module_exit(cam_cc_sm8650_exit);
>> +
>> +MODULE_DESCRIPTION("QTI CAMCC SM8650 Driver");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.43.0
>>
>>
> 
> 


Return-Path: <linux-kernel+bounces-21683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D7C8292C0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 04:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D89EB24CD4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347244C6B;
	Wed, 10 Jan 2024 03:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gewyc9vY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCB723B1;
	Wed, 10 Jan 2024 03:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A1hmDC028430;
	Wed, 10 Jan 2024 03:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=eT2RFPcUzBjCFcgmYWvFX29+fptit5SqWct6bYbB0rY=; b=ge
	wyc9vYJ7JP7/kYqmB2apNJZVwkC2sUOu7LIFCWZlTgKnwzqgSy917cWJBs12+niL
	ctJ9AvMCEpWiHL+RFbuNmYaTahO21uOe8taj1BgVC75+gY7J2xexl8vpQn61iCjk
	4n+T115+I+U56PMTT0rFpiOROpBiYmVdcbyV+AzrBaSaI4qERr5px2kxJ2y3epeQ
	advp2/vM2xPT51JLrLxf2cT9IcKlW6GsBuTHFz62nUqk0QppcoNZyo02VMSQewI7
	MfHNFG/P95e8yoWEfe/ypmT68wdcFXM9AId6cAWGYAWwexAxw1edhs4o4xsLefRx
	ppD1wHV16ocCIKbHBfPw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh3g6a22r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 03:16:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40A3GvUb013535
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 03:16:57 GMT
Received: from [10.216.11.180] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 9 Jan
 2024 19:16:48 -0800
Message-ID: <16efa89e-6a9d-4e9a-9020-239b9750119d@quicinc.com>
Date: Wed, 10 Jan 2024 08:46:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] usb: dwc3: qcom: Instantiate dwc3 core directly
Content-Language: en-US
To: Bjorn Andersson <quic_bjorande@quicinc.com>,
        Wesley Cheng
	<quic_wcheng@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "Johan
 Hovold" <johan@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>
References: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
 <20231016-dwc3-refactor-v1-7-ab4a84165470@quicinc.com>
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20231016-dwc3-refactor-v1-7-ab4a84165470@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mTqddsODM1Z5spr7u8a0eebT_TPOR2qa
X-Proofpoint-ORIG-GUID: mTqddsODM1Z5spr7u8a0eebT_TPOR2qa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=794
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100025



On 10/17/2023 8:41 AM, Bjorn Andersson wrote:
> The Qualcomm DWC3 glue builds up a platform_device programmatically in
> order to probe the DWC3 core when running off ACPI data. But with the
> newly introduced support for instantiating the core directly from the
> glue, this code can be replaced with a single function call.
> 



> @@ -942,7 +889,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>   	if (np)
>   		ret = dwc3_qcom_of_register_core(pdev);
>   	else
> -		ret = dwc3_qcom_acpi_register_core(pdev);
> +		ret = dwc3_qcom_probe_core(pdev, qcom);
>   
>   	if (ret) {
>   		dev_err(dev, "failed to register DWC3 Core, err=%d\n", ret);
> @@ -986,10 +933,10 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>   interconnect_exit:
>   	dwc3_qcom_interconnect_exit(qcom);
>   depopulate:
> -	if (np)
> +	if (qcom->dwc_dev)
>   		of_platform_depopulate(&pdev->dev);
>   	else
> -		platform_device_put(pdev);
> +		dwc3_remove(qcom->dwc);

Hi Bjorn

  I was testing this patch and I suspect there is one issue.

  In the event dwc3_qcom_probe_core fails because dwc3_probe failed, 
then the variable (qcom->dwc) is NULL. We then exercise the depopulate 
path and we call dwc_remove(NULL) causing a crash.

Regards,
Krishna,


Return-Path: <linux-kernel+bounces-21912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA88829681
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0CC288DC7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA11F3FB25;
	Wed, 10 Jan 2024 09:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UPEoGCz1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901333F8F4;
	Wed, 10 Jan 2024 09:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A8dZTp021783;
	Wed, 10 Jan 2024 09:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=TJWOUqqOWfLSHwbrjDN1CSgQZxgpmxtxhOl651aGMzQ=; b=UP
	EoGCz1JIcJI7najrHCxJQwR8o/m+doI/I+1jBZUEDUeH0wV/JgukuXcC+HK8hZ7P
	9yVMeGxAl+T2YfE6Qgdc+5kkfqI5jNvJfgF+NO2w08BlghoHSfq3mxh+ct36ZW8p
	TCbEWCPmVIfUR/xduUOG8UVT9eTIx3Cxvdst/IyApQ+0sSjk6nS9afaN31NNFeKH
	b4UC93/oxzVG7hbrTJ1YMnBrDeI/A2QMzmYr2kFNZtPm4Sr3Cryg1UJL8Z8tDnkY
	KSmQ24xE0lndkMFrtWw42dW+pdEzjbOrCsEIxy63wCwmVzpDDyGRSJQjzgdH/mC/
	kRj53YjMop1hscVvf8jQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh9vfhw4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 09:45:18 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40A9jISZ023539
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 09:45:18 GMT
Received: from [10.217.217.69] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 10 Jan
 2024 01:45:12 -0800
Message-ID: <c839d2b9-1b4b-f2a0-ff5d-9e841daec9f2@quicinc.com>
Date: Wed, 10 Jan 2024 15:15:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/3] dt-bindings: clock: Update the gcc resets for sm8150
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Michael
 Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Deepak Katragadda" <dkatraga@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, "Taniya Das" <quic_tdas@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>
References: <20240104-sm8150-dfs-support-v1-0-a5eebfdc1b12@quicinc.com>
 <20240104-sm8150-dfs-support-v1-2-a5eebfdc1b12@quicinc.com>
 <218f9822-0bbf-489e-b3ac-bb5ec6cee8d4@linaro.org>
From: "Satya Priya Kakitapalli (Temp)" <quic_skakitap@quicinc.com>
In-Reply-To: <218f9822-0bbf-489e-b3ac-bb5ec6cee8d4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bKXOcpCmGzCMjtTd2VmxKzNWt2EPMUPl
X-Proofpoint-ORIG-GUID: bKXOcpCmGzCMjtTd2VmxKzNWt2EPMUPl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=774 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100079


On 1/4/2024 9:13 PM, Krzysztof Kozlowski wrote:
> On 04/01/2024 15:23, Satya Priya Kakitapalli wrote:
>> Add all the available resets for the global clock controller
>> on sm8150.
>>
>> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>> ---
> Subject:
> Everything can be an update. You also miss prefix. Instead:
> dt-bindings: clock: qcom,gcc-sm8150: Add Video camcc whatever foobar
> reset IDs


Okay, will update the subject.


> Best regards,
> Krzysztof
>


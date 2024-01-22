Return-Path: <linux-kernel+bounces-33057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F27A8363D2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27213285B19
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FB63C6AB;
	Mon, 22 Jan 2024 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AI3+L+0c"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0583A1C6;
	Mon, 22 Jan 2024 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705928326; cv=none; b=SISWKg5KvMY3yONVuApzeWCCRxau9mfjoKXV1wqi7p8nN+mg0ZDahxjynnOx577elyyCB0uYX/fwxZFTTQM9HpSESYWnEyLsXcA4H9Kt9uenRg0zw9RHFsI9nJAqHYBL+lhE4xw/jav5IeJkzAk7Q7S0ptXJhT2a9VQNJ8CXIPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705928326; c=relaxed/simple;
	bh=HFZqcUV95VG1QYVSxv5cz6r1X1VcMnGpM8zbzpiW+y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=brhFnWGqLa6jJZRCmNkoFQFLlsCnvgghrktglgXa2atRA97wzpqE/rhCNLFofjNlZvbeXjMaxRwEaJ155LH3DxE4yCdj5UH775HL+naqlpe98krff6OtZw9IXPHGp5wDYhGqzjCh7XycbQ+qJMjKkorHcb66RduzREGWaCqq2M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AI3+L+0c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40M42PxT013123;
	Mon, 22 Jan 2024 12:58:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=uhFlIPVA8pV+lRHjhhGe3aypD6SMO/ddDP706VtvdYg=; b=AI
	3+L+0cttCB9J6c8qasc3uH9QOpEQY3odQmc8HsWovMy9khvOeb3wJWoSujcXRxAx
	0xAxGfr+RxvVGbp88WLP/EIsYA27yWhNi8gGQwc1gB43sqZqe+Ty7xcnfcJohasV
	gxUt01DJ7wsCRAY2AxZ0jgEcDyywiSzGxFwO7mkOr7vRBaaPTSYO5mUKpITtoVDV
	8moZdHAFnzJBJZoPV+hKo5ltfbFipDy6GDDlF2e4lDXVcu9RARwIKB+c0x1HAOn1
	DXa00ECgBZmJ0ngYXMRLzJDohxepoPVpM2tfYkNRM3TbKYL+Ga4EpFAuzp0jA5rY
	kkZfOcjSmwBTOLdl60WQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr6xn4044-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 12:58:41 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MCweqG020607
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 12:58:40 GMT
Received: from [10.253.14.163] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 22 Jan
 2024 04:58:36 -0800
Message-ID: <17117e8a-e808-4908-985f-932232b1e6ea@quicinc.com>
Date: Mon, 22 Jan 2024 20:58:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] arm64: dts: qcom: ipq9574: Add PPE device tree node
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <quic_kkumarcs@quicinc.com>, <quic_suruchia@quicinc.com>,
        <quic_soni@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_souravp@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>
References: <20240110112059.2498-1-quic_luoj@quicinc.com>
 <20240110112059.2498-2-quic_luoj@quicinc.com>
 <a42718a9-d0f9-47d9-9ee8-fb520ed2a7a8@linaro.org>
 <de0ad768-05fa-4bb1-bcbc-0adb28cb2257@quicinc.com>
 <CAA8EJppeQdB4W8u0ux16pxBBwF_fpt1j-5aC0f849n9_iaaYtQ@mail.gmail.com>
 <6fc9e65a-709a-4923-b0b3-7c460199417a@quicinc.com>
 <84366aa2-e51e-4bce-a9d5-2420f1d9db0c@linaro.org>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <84366aa2-e51e-4bce-a9d5-2420f1d9db0c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Y5YKXXsMobSKxNPKclEV3TvBAd4GDU69
X-Proofpoint-ORIG-GUID: Y5YKXXsMobSKxNPKclEV3TvBAd4GDU69
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_02,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=914
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220091



On 1/12/2024 10:51 PM, Krzysztof Kozlowski wrote:
> On 12/01/2024 15:40, Jie Luo wrote:
>>>
>>>   From the first glance, the bindings do not follow upstream principles.
>>> You have all the settings (tdm, port config, etc) in the DT, while
>>> they should instead go to the driver. Well, unless you expect that the
>>> board might need to override them.
>>>
>> Hi Dmitry,
>> The TDM configuration varies per SoC type, since the ethernet port
>> capabilities of the SoCs vary. So we will have two different TDM
>> configurations for IPQ5332 and IPQ9574 SoC. The driver also will
>> need to support future SoC, so we choose to configure this from the
>> DTSI. The same reason applies to the port scheduler config as well.
> 
> Your statements here confirm Dmitry suggestion, so these are not board
> specific and should go to the driver. Please read again Dmitry's sentences.
> 
> Best regards,
> Krzysztof
> 

Sure, we will update the driver to configure the TDM depending on the 
SoC need.


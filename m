Return-Path: <linux-kernel+bounces-71059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 022CF85A025
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BA2DB209A9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DB725108;
	Mon, 19 Feb 2024 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A+CKEvVI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF95E24B2C;
	Mon, 19 Feb 2024 09:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336138; cv=none; b=EJ9YYb/vQJFCBPre3Yt+Jwu21nXbG8dHNMY+kZxC60IT8icldP3I5pCZn/mwKMIopK3S2bUQq8LRgmEB6MI7KZDo+B3LW7tGzd+f0mIESzGI7t6m9Wce9YfE08ccsgZ14fnWQ/g8FyxAy8oveClgssAnyilOIKwz00FTMwHJyf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336138; c=relaxed/simple;
	bh=evgpaaD5YWF/NgxUotDyDIZio7JSN3VGvWsj49vaKqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TQtMQiuoya6P3awbWbpyXeC4i0RfMxh+r2Odt3lbOna5V8FNy5oM/L4a8tgw+JWnUrfNvlIKJWZNZ9VNXHCQdTPZelNMAtoS3uAlcFp5Q6/HjwO9DZd+FdANrEkLlhznJ7cR36jsBHijvwVEBwvtw5LrE/yzjL86TEgXnl7ZRcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A+CKEvVI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41J4exqM030321;
	Mon, 19 Feb 2024 09:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=SVEu8MZ3e8dW0QHAXGwR0a6sVaNeklP/z/RmXLz5IUs=; b=A+
	CKEvVIaa8ho3rxF1rvOPVSOyvm+vyBAxUJ+eAo2/DEXrucnypl3KD6+IAsOh5M0C
	UFozvQedhgwXadehkIHmKsaro0ny3kqAdN9imHt94DTWtZPphgb4gOo9MmOWmX64
	spIv+BmTh33eRU/VNd/Jl6pnW7zRLyH4f1vu82t3HkzE0ehKuCxh93Sb2+8a650q
	AnzyCnD6wBAgc6cyQr71NzBHRDdrf1lRpockXtU8nRudmLtUVBo+ZMNep6T4xQ+u
	ZRThmilgPqZ9ORzhNyuVtpAHBIeI8J7Mif4QBoeKg3nYOC4JpsNvhSJl2X793WP1
	Zpeh3+X/3ypwSdJV9fWQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wan17kd4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 09:48:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41J9mgxh025919
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 09:48:42 GMT
Received: from [10.214.82.119] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 19 Feb
 2024 01:48:39 -0800
Message-ID: <7acbf41b-1618-4746-aa1d-e6b700994a03@quicinc.com>
Date: Mon, 19 Feb 2024 15:18:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add interconnect support for SM7150 SoC
To: Danila Tikhonov <danila@jiaxyga.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240218183239.85319-1-danila@jiaxyga.com>
Content-Language: en-US
From: Naman Jain <quic_namajain@quicinc.com>
In-Reply-To: <20240218183239.85319-1-danila@jiaxyga.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: loa4WZeOn44LUvK-4Bqq6_kSfedh7lrW
X-Proofpoint-GUID: loa4WZeOn44LUvK-4Bqq6_kSfedh7lrW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_06,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402190073

On 2/19/2024 12:02 AM, Danila Tikhonov wrote:
> Add dtbindings and driver support for the Qualcomm SM7150 SoC.

Nitpick.
s/dtbindings/dt-bindings

Please add that you are adding this support for Interconnect driver. Its
there in Subject of this patch, but reading above line gives wrong
impression.

Regards,
Naman Jain

> 
> To: Bjorn Andersson <andersson@kernel.org>
> To: Konrad Dybcio <konrad.dybcio@linaro.org>
> To: Georgi Djakov <djakov@kernel.org>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: Conor Dooley <conor+dt@kernel.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> 
> Danila Tikhonov (2):
>    dt-bindings: interconnect: Add Qualcomm SM7150 DT bindings
>    interconnect: qcom: Add SM7150 driver support
> 
>   .../interconnect/qcom,sm7150-rpmh.yaml        |   88 +
>   drivers/interconnect/qcom/Kconfig             |    9 +
>   drivers/interconnect/qcom/Makefile            |    2 +
>   drivers/interconnect/qcom/sm7150.c            | 1753 +++++++++++++++++
>   drivers/interconnect/qcom/sm7150.h            |  140 ++
>   .../interconnect/qcom,sm7150-rpmh.h           |  150 ++
>   6 files changed, 2142 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml
>   create mode 100644 drivers/interconnect/qcom/sm7150.c
>   create mode 100644 drivers/interconnect/qcom/sm7150.h
>   create mode 100644 include/dt-bindings/interconnect/qcom,sm7150-rpmh.h
> 



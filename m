Return-Path: <linux-kernel+bounces-68948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B0385824A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3777284AEC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C7112FB39;
	Fri, 16 Feb 2024 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="papBJ7wZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12BA12F588;
	Fri, 16 Feb 2024 16:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708100356; cv=none; b=CjQV3R+8R8cMGWuqyYpCYPQTmeLDzzh2E1Hg8ZizIh3kOTZ5+SNXZDe+WCSCT5be1NQtZeOmiX4li3n0qRgNjiMqjYt/vk1v8+fL3J4dlpIilQLF0hurP3XUItZvh9fMU9clp+R4WkqK3deI5xP2mX0KDoz0+RJxE+LTYy3Mjx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708100356; c=relaxed/simple;
	bh=3Th8DZt0OQ3ziiLVB/ua3HHK/SX15c+4q6Tfe2FBgm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bf6OKWMpQHTSjeLgFgdYbbIZ9j1vAJHiRguKTD+38VQlUXcczIA0Ya+ZUcgBc4B26Kbp4qAMm5+v1BMTAD0QwBdeSIGvN0fG2exzePyXC1bFCr3OneQkk5/wCC2lu2furUeHNoi0iQeJxP6UMACmC0UGs6dnY4eVitpO9FCmcQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=papBJ7wZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41GEMBMd000606;
	Fri, 16 Feb 2024 16:19:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=XM4jIqqu9Gn6mO9uXU+p5TfjjI0Se+EJZtDvA97ham4=; b=pa
	pBJ7wZQzlBq/qDmHSKSD1cfOgWdtLhOrzdAYa5nLen3VU7DdNP7muOH4zPtauxbR
	M61LU3basY3DXZPOBv15Bk1iSghjPGotWB6Vvu87XiqbcQYUG/OyBEkV6qwEHpSc
	m+0W52RMi7i3OtLrk/T/+qIfvnP9xC/VNyhIJGNWfn6e+EYADhezGKIBxvpeW9x7
	H62OsEvjdh3jtVXQAt3LVHaExWFYrVz62lrsnPzvm5xGMoIpp/GzvvqbOTQIw3Cs
	Gq5y6ysTdX8IGFti5YZbc3SclQPC/2Ftf86KwzYF2TaoYtfN4ylntKu4KoichPeJ
	RgMi11PXvCqKucqZAf8A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9fkfc19w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 16:19:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41GGJ99Y012483
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 16:19:09 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 16 Feb
 2024 08:19:08 -0800
Message-ID: <aca58fb4-b9c8-1730-cff4-56a2d73bd235@quicinc.com>
Date: Fri, 16 Feb 2024 09:19:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] dt-bindings: interconnect: qcom,rpmh: Fix bouncing
 @codeaurora address
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <konrad.dybcio@linaro.org>,
        <djakov@kernel.org>, <linux-pm@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <andersson@kernel.org>,
        <quic_okukatla@quicinc.com>, <devicetree@vger.kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20240202181748.4124411-1-quic_jhugo@quicinc.com>
 <170715826040.3958103.13885911803274019580.robh@kernel.org>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <170715826040.3958103.13885911803274019580.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qUqTURpdM8XLTJWgQCjljcplB4CRVbHZ
X-Proofpoint-GUID: qUqTURpdM8XLTJWgQCjljcplB4CRVbHZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_15,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=714
 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160130

On 2/5/2024 11:37 AM, Rob Herring wrote:
> 
> On Fri, 02 Feb 2024 11:17:48 -0700, Jeffrey Hugo wrote:
>> The servers for the @codeaurora domain have long been retired and any
>> messages sent there will bounce.  Fix Odelu's address in the binding to
>> match the .mailmap entry so that folks see the correct address when
>> looking at the documentation.
>>
>> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 

Will you take this into your tree?

-Jeff


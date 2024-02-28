Return-Path: <linux-kernel+bounces-84313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B49B486A4DC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F28B28AD7F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9657B1C10;
	Wed, 28 Feb 2024 01:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A5vA1XWe"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6330E3C36;
	Wed, 28 Feb 2024 01:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709083045; cv=none; b=uB46Erw9VV9kdiGdDeRP67dgNjISmNoLpKVsYxfHxvuiD43tB+YW/fxZsL5jrKYQkoOJ4Wl3VjBzOgNMno3sdNCP2BgrEWi+WRodSayDFGMQ2rOI13SUgGhrpOTb+g9K+WDLER5GMAOVIHp3e5HCIG/VnpJ/DT9UtK+GL+W+qRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709083045; c=relaxed/simple;
	bh=dusoIb75rz/NqNk4BgrneScAAhHN0mCIzRVK3c5hNik=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tHRWkF0pWsgbVVJ6C4eCEXurN3Y7phgXFNZE5dUxHjf9edXSdPsc/AB8vpjHhmQisS7hCClUg/z5Q/1gId9yGqqXvJOH/7CSQJri+l0ZQnOXXhK6qq+1/AvS2fioUCZyjcs1MKHGW/iFuJuQ+2m0AQjbgFpqiboJb+UQV5+QGYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A5vA1XWe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S186Q5021154;
	Wed, 28 Feb 2024 01:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=jWv665qtMWBRFX/3GN0jR+x+rYp8qbXSQMmXDqU8nsM=; b=A5
	vA1XWeU3h9DLJy3ZlBDe0EkXX1fo3+p4+7TFne2JxVoP9kB/6LY4WRhhLbjE4/Aa
	z3rwIInjYtXeeyTwTTvYPDKwBvS2EHy1xGEQ4eQvGgzKDkdOsVSQB6mlnjp+Q0QX
	M6ytwPUZoxRzSiAINN/oNSu09yy6FCUtTO3Xeaq/ka8gDRs0YOvFzoMUvXrEcKu+
	dPSByR9P6y+LZRQW9Le2f7KDVMGBOeyyyPJ5EwkMgrovyx9TOLP1nwjtwtZhQXpi
	yhPOtqmXppEqzocs/XmvrQ27RgKUd+N8jabEXPAvF+eiIHhR2xJ/Hd5s9wYxFrRX
	gwPsS1Uc9v8Ha2LHXxAA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wha07ahbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 01:17:20 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41S1HJla026884
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 01:17:19 GMT
Received: from [10.71.111.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 27 Feb
 2024 17:17:16 -0800
Message-ID: <65e9ef21-3406-4632-a607-2c4e9d587131@quicinc.com>
Date: Tue, 27 Feb 2024 17:17:16 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] arm64: dts: qcom: sm8550: Add mapping to llcc
 Broadcast_AND region
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
References: <cover.1708551850.git.quic_uchalich@quicinc.com>
 <d36f8c70e103bd6f740ebfaa512d246188aadf10.1708551850.git.quic_uchalich@quicinc.com>
 <4e5129de-ce1d-448c-9264-b7470c3feb49@linaro.org>
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
In-Reply-To: <4e5129de-ce1d-448c-9264-b7470c3feb49@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: M6c5ZJaqYN770YvSyJn-XDe31zd8gq9u
X-Proofpoint-GUID: M6c5ZJaqYN770YvSyJn-XDe31zd8gq9u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_11,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=834 clxscore=1015 suspectscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402280008

On 2/27/2024 7:49 AM, Krzysztof Kozlowski wrote:
> On 23/02/2024 00:07, Unnathi Chalicheemala wrote:
>> Mapping Broadcast_AND region for LLCC in SM8550.
> 
> I don't understand this sentence and I still do not know why.
> 

The check of whether status bit is 1 in the driver is being done
with the wrong register all along (sm8450 onwards). So I am adding
the base address of the right register region in the DeviceTree files.

I can add this explanation to the commit message of these
patches if you think that would help.

> Best regards,
> Krzysztof
> 


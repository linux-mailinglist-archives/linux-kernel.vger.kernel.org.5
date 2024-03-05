Return-Path: <linux-kernel+bounces-91749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B64787160A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCFBB285F58
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AEA7D3EE;
	Tue,  5 Mar 2024 06:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ckI5QqIv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6FD7B3CA;
	Tue,  5 Mar 2024 06:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709621423; cv=none; b=T+WlPuN1nC8Qmm4BCKj/ptrRNc8sFwia7fUsGRVMWweJ5gP6GAMnyj1IAe0ZM1Ta6CPo0KdK3RhKSWuqm7VnZxokJnA4E1hNJ+C0GSm9SHkGm93Fwt7vF82jpAjEHHG3EBrW+pd7TZZjW0J58972z1D7pyy28l7L3Clfem1PRPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709621423; c=relaxed/simple;
	bh=4Et3jw0oTd56Sgpp+eX2bggojW8hvfyFS1RQGZTk8J4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jSMw6GMMjJMsHvcSEWuXyIs2pgpUAMo/idaz18v+hnj0rhWYv108ApnX1UKVS4fFnOp7ENxHLi7uZ5gdig1HkNk+89Ms6sFlkDIaPH5/hPOMvlFdSN5cyMdnZ6sHUqXvQd8de/xZaSBStRtkvebfZStVz2NX0HLmEPiFhG/e5WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ckI5QqIv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4255wbIp006372;
	Tue, 5 Mar 2024 06:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=gG6HebXMsKr1hFQ6fnFclyFA+xdY7SFdds2cyRf2W7s=; b=ck
	I5QqIvoMbCGYHCnUXfb17+/VoV3FRgRwwU8oWc76QzpqA8QZHaWfGwCunMgze76m
	Nm1knrvL7iqq54yp4Q1SJSRrzLWvq1WhF8aThGx+VbUdmcwU2D4RoYdMbRCEhYr+
	MbkRXNKXAYK+4zYWICHD8rVvOsb7Ga+vJdt8+HtM2g3E8HPCOnTBP9BtIEzbmiRA
	2RjJ95k0dnBymc5+LbQaK6mIaDKpyQ8eSuQeRHNq3ElCz7qAXE9Lr0wVvc37I3+Z
	hyij0jSZdosmdvjhNyCm60xv4uIcH8wIcv/haTXGxQzpEqVARxxjncN9Vm1kGPvR
	qtdFFXfnYdKsfo9sgyjw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wndaj267p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 06:50:18 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4256oICO031158
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 06:50:18 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 4 Mar
 2024 22:50:14 -0800
Message-ID: <96634f3f-a334-d9de-d172-8edaf36a362d@quicinc.com>
Date: Tue, 5 Mar 2024 12:20:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] arm64: dts: qcom: sm8650: Add missing reserved memory for
 chipinfo
Content-Language: en-US
To: Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Neil Armstrong" <neil.armstrong@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Patrick Daly <quic_pdaly@quicinc.com>
References: <20240304-sm8650-missing-chipinfo-region-v1-1-8a0b41dd8308@quicinc.com>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20240304-sm8650-missing-chipinfo-region-v1-1-8a0b41dd8308@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UBJfj-3eG26DKTJJrgcD2Ptx4BgiemIH
X-Proofpoint-GUID: UBJfj-3eG26DKTJJrgcD2Ptx4BgiemIH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_04,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 mlxlogscore=904 mlxscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403050052



On 3/5/2024 4:11 AM, Elliot Berman wrote:
> Add missing reserved memory for chipinfo region.
> 
> Cc: Patrick Daly <quic_pdaly@quicinc.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Fixes: d2350377997f ("arm64: dts: qcom: add initial SM8650 dtsi")
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

Checked the memory map and the downstream code and saw it
looks to be missed.

Thanks for the change.

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh


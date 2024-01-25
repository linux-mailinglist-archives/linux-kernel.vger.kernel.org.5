Return-Path: <linux-kernel+bounces-37900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB26683B765
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE52D1C22722
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEAE63B1;
	Thu, 25 Jan 2024 02:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dTsGyQut"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CA46FA7;
	Thu, 25 Jan 2024 02:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706151191; cv=none; b=iwglHs5FDK6y6AUjcfhSJW2szwoE0pg+hHOXksYA8miQuRw2OXzwkmexRH+ca8PJfZs9ZwI0dg7IaB8zb5Zt0QeI3Db+b6Nq1QJ2cenJhpQ0tf2hOCn7Ar0w6hBRmAXSQVq7RRl2Ji/Z474cqR2523C1EB/TEHvLNMb8dPRfCJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706151191; c=relaxed/simple;
	bh=uTX/qig8Hkpz+E0xMYR8cHxn2puVgN4eRO1WczJwm0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HLsbnfRM3yQ8IUR6xpwbtLVTi0B575rWoQc57TgSnsEYr4WsKg61p/1Qw8XzPK7ow5nhhT8yt5hLUV04UbTsWKKm4gnzvhqJJAUlUcug9y5n3bl0kqG15iqrJ0urFhe85Q9ytA2BB9NEPgVBHQKQ5VPoYAQNlZDBcJfaVKUgU04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dTsGyQut; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P27MZr008423;
	Thu, 25 Jan 2024 02:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Cjy8M1nkvn+JsV84NtC71oQhXyA2OVGEdBFE3hQCB9Q=; b=dT
	sGyQutWn95K0U2naFup7BnzPvXCZ/GqkU6VrnhLIKl3Wrb6pTNlwxBEDXaHsWtxs
	aFciAAzZ5ik5231qc29zTYjg6MjYvK8VCWmJkDDwuUWdNmn+AwEvBPNlRRnFUkqa
	Hk1J109QN1+TOmFOREOVRmvhLwvmCSveKaIeOjSfpuMfK8rnT4rlJEw2+wRnUOAJ
	2yICjT5OQeeQoUiM8jsls543ADhkQdHR/3auceldiwMfYsqO9DsCcekWkEfKqKV7
	yXznx5lMZqmCzV6hP/bUFQTpDJ8SfvC1t/nb3YTL9Jk6TSVde8AojxbZutuL0Gbb
	Me5JqhFZ1pLLFZyW7gvA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vu99b0pey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 02:53:04 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40P2r3xF011841
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 02:53:03 GMT
Received: from [10.47.206.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 18:52:59 -0800
Message-ID: <884eb509-a997-869a-762b-b4c24ff89c27@quicinc.com>
Date: Wed, 24 Jan 2024 18:52:59 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: sm8650-mtp: add PM8010
 regulators
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <quic_fenglinw@quicinc.com>,
        <kernel@quicinc.com>, Bjorn Andersson <andersson@kernel.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20240123-sm8650_pm8010_support-v2-0-52f517b20a1d@quicinc.com>
 <20240123-sm8650_pm8010_support-v2-1-52f517b20a1d@quicinc.com>
 <892058db-8013-879d-6c6f-3fbbf4ed3c57@quicinc.com>
 <30e890e8-42dd-4b36-a133-95bb34c109d8@linaro.org>
From: David Collins <quic_collinsd@quicinc.com>
In-Reply-To: <30e890e8-42dd-4b36-a133-95bb34c109d8@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2U_3kZ-Q77Lu815Atf3fjW7MOX0zq7yA
X-Proofpoint-ORIG-GUID: 2U_3kZ-Q77Lu815Atf3fjW7MOX0zq7yA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_12,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=584 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401250020

On 1/24/24 15:36, Konrad Dybcio wrote:
> On 1/24/24 20:15, David Collins wrote:
>> On 1/23/24 00:49, Fenglin Wu via B4 Relay wrote:
>>> From: Fenglin Wu <quic_fenglinw@quicinc.com>
>>>
>>> Add PM8010 regulator device nodes for sm8650-mtp board.
>>>
>>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
..
>>> +
>>> +        vreg_l1m_1p1: ldo1 {
>>> +            regulator-name = "vreg_l1m_1p1";
>>> +            regulator-min-microvolt = <1104000>;
>>> +            regulator-max-microvolt = <1104000>;
>>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>
>> Optional:
>> PM8010 L1 and L2 physically support LPM vs HPM configuration.
>> Therefore, these lines could be added here to allow such configuration
>> by software at runtime:
>>
>> regulator-allow-set-load;
>> regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
>>                RPMH_REGULATOR_MODE_HPM>;
> 
> David,
> 
> I was under the impression that *all* RPMh regulators support
> modesetting. Would that be an incorrect assumption to make?
> 
> Konrad

Hello Konrad,

That is generally true.  However, PM8010 LDOs 3-7 are a special case.
These do not support LPM configuration.  The limitation is enforced in
the driver by this change:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2544631faa7f3244c9bcb9b511ca4f1a4f5a3ba0
.

Take care,
David



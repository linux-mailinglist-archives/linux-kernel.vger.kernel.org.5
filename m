Return-Path: <linux-kernel+bounces-37012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FFB83AA2E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4C21F227C2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5A27A702;
	Wed, 24 Jan 2024 12:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cgf8QpQv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2167A703;
	Wed, 24 Jan 2024 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706100262; cv=none; b=SJKYen8t7HkBhtJaMbPcJggD1NvpBokOebVa5qSRDE3DQUeCshRCLQrmbLaS3I00RyH8f5veBveXXs/jrEtWJQErmYFfP6zxBspUNN+ttb7v9mqOewBWp08sojLulpmusVYHNIZI74L5tbJf4PZEdTmS9QvvqRMNO2f3Bwcj5mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706100262; c=relaxed/simple;
	bh=tnRe5Ei/YJTczxwZvDToOZWUhjsn9sVDHvqVg2zKHrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C3vOWKmeewoOkbSqw8B5B/fzKCZXgEfdGTowFD6yp0CR8nHF4RxPnhX1QZjy/VOP0NlBgyTkdiYRJnwqXYPG4ykD2adxKg6oqXli/ugbM8TiE4zEtEWc+GabtmSSgocO4N/JIEypvC5HQ+HKafd6jRrngcNjBcN9UsgPcQ8r2dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cgf8QpQv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40OCYqcZ012776;
	Wed, 24 Jan 2024 12:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=maWhpjGGQMcpu7vtMvFkjeOy5RBxMSnQ1uDy31yUj6Y=; b=cg
	f8QpQvV8gnpxy7VshpA26KTuELDphwZmmr6oiZr+FS6+jksdvPIbmH43laC4mCZx
	oo2ivb8cX/jZwzH7ED6wuuY51+tEXiWhXW2JT0JVuCms0c/SfwiJWLlQZjMPwR4u
	Mwsv428nwMgBDKgQDz0Q6azY+qnwwLL++F5Acz85uHgyqqnSEVgMjZ1wWmMnwBmW
	gv7nxIJROSoL7iZLPzG4kPYuWzO7a/KSLHIxzNPb3vD9TgQ7nwykTaMJJpXK0UT6
	798wNRpLEcyMc/VlL+UQIHs4tsrGOJUCdEVXlZj15lawNkZKvQGeEN7qKz4NhsZg
	qk+hjp/kq0++ksfDxo/g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtmgxhrbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 12:44:17 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40OCiGPx011456
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 12:44:16 GMT
Received: from [10.216.58.233] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 04:44:09 -0800
Message-ID: <2f369f2e-1bad-caf8-a4f6-0e7de588de81@quicinc.com>
Date: Wed, 24 Jan 2024 18:14:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: hwinfo: Introduce board-id
Content-Language: en-US
To: Trilok Soni <quic_tsoni@quicinc.com>,
        Elliot Berman
	<quic_eberman@quicinc.com>
CC: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <konrad.dybcio@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        Conor Dooley
	<conor@kernel.org>, <andersson@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
References: <1705749649-4708-1-git-send-email-quic_amrianan@quicinc.com>
 <1705749649-4708-2-git-send-email-quic_amrianan@quicinc.com>
 <6e40dd60-884f-be23-0052-d14f7194f844@quicinc.com>
 <f21bc259-45fa-d14b-a556-625b813287f4@quicinc.com>
 <499320f4-f6b1-4582-9512-89ab505305b6@linaro.org>
 <20240123-sterilize-flap-8971aa3bad4b@spud>
 <1941558d-d1e0-43b7-9208-65b9ba191bc2@quicinc.com>
 <fd2c8c1b-02f3-2750-3449-f93fc119fda2@quicinc.com>
From: Amrit Anand <quic_amrianan@quicinc.com>
In-Reply-To: <fd2c8c1b-02f3-2750-3449-f93fc119fda2@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HsnQFIIeRa7qEX2ChADq64gB-W4kP5Dt
X-Proofpoint-GUID: HsnQFIIeRa7qEX2ChADq64gB-W4kP5Dt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401240092


On 1/24/2024 1:35 AM, Trilok Soni wrote:
> On 1/23/2024 10:51 AM, Elliot Berman wrote:
>>
>> On 1/23/2024 9:18 AM, Conor Dooley wrote:
>>> On Tue, Jan 23, 2024 at 12:50:07PM +0100, Krzysztof Kozlowski wrote:
>>>> On 22/01/2024 11:10, Amrit Anand wrote:
>>>>> On 1/21/2024 12:40 AM, Trilok Soni wrote:
>>>>>> On 1/20/2024 3:20 AM, Amrit Anand wrote:
>>>>>>> From: Elliot Berman <quic_eberman@quicinc.com>
>>>>>>>
>>>>>>> Device manufacturers frequently ship multiple boards or SKUs under a
>>>>>>> single software package. These software packages will ship multiple
>>>>>>> devicetree blobs and require some mechanism to pick the correct DTB for
>>>>>>> the board the software package was deployed. Introduce a common
>>>>>>> definition for adding board identifiers to device trees. board-id
>>>>>>> provides a mechanism for bootloaders to select the appropriate DTB which
>>>>>>> is vendor/OEM-agnostic.
>>>>>> Please extend CC list to more architectures? linux-arm-kernel, risc-v etc; since
>>>>>> the proposal below is not specific to ARM but any architecture is using the
>>>>>> devicetree.
>>>>> Wouldn't devicetree@vger.kernel.org will have concern folks from all the
>>>>> architectures?
>>>>> Please correct me.
>>>> No.
>>> The chromium guys should get a CC on future versions of this stuff,
>>> since they like doing wacky things with compatible strings in their
>>> bootloader and this problem is one they also face. Doug Anderson and the
>>> mediatek chromebook folks would be a good start.
>>>
>> Please CC Peter Griffin from Linaro as he helped restart this
>> discussion at Plumbers.
>>
>> Peter Griffin <peter.griffin@linaro.org>
>>
>> Also, for the oneplus boards:
>> Caleb Connolly <caleb.connolly@linaro.org>
> Thank you everyone. Amrit - please take care of above comments
> when you post next revision and as suggested please add other
> architecture mailing lists using the devicetree. Thank you.
Sure, will keep this in mind when sending next version. Thanks for 
pointing out.

Thanks,
Amrit.


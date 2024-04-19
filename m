Return-Path: <linux-kernel+bounces-151311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4A68AACB1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638AB1F21C73
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A36A7E11E;
	Fri, 19 Apr 2024 10:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mOzfZS+6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C7A7C0A6;
	Fri, 19 Apr 2024 10:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713522045; cv=none; b=Ps1A30joYfpYBqpv3yppNuAb0zFFCuXWMDWfRW2dwGI5c0O0tAV0z0i/fvXyKhzQQxAJO0jdajwqM3qCbwtkUHiFqSAdyu8mJGJnRXkttTY6qf1kvxPuzWc8dxInTXVyiMuGHSWcfOgeVMV1VxUS6nVX7D5dCH1ya0xAkjLa+yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713522045; c=relaxed/simple;
	bh=ARPr0uPN58IxzEf1SX/9k+ar4CkwGdC5TCXqcWGMsQw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=IE0D3ll9biLGENQeUIrQMqsAvJMnfSaM7Yxv4znG/vm/bkkwVUXJ/5+iuh4NXRel5DU0Oz6OvRNQ19KaZLF/OswKtf9G6SBhz4W2qEY8umX0Y+HqHSNBaD0K7Dghyp8YbgBVgtcOM+vgEB3sxCO7lD9/ko4yO18kBobxg+oEJ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mOzfZS+6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43J8nG62002928;
	Fri, 19 Apr 2024 10:20:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:from:subject:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=yaTjOd4Xo9AXRQiffLemhUtMHcm7hjBtYX1OiupahF8=; b=mO
	zfZS+6D8MNoYRf6lzQpoCspjqxjVdMaB2oc92ypW25zMfIyt6aSkr3aFomSQMHqb
	wt7Nz9SjCTU+lfwKss8Ptv1HLdmIjADfikjp1tIKPZKyC6aAF3Lf0b6h74QeDIqj
	XRg0S+QP/8rkqzNMHhM3sd3NUMvkA4QFCwQpVZzA6KDizM30kVFgbrzZWS7iJ3f7
	8j7JPmEuZmL7E1ZuJ1Z3b/dEa3FskbrWYRBnVi5+8xE0n9wuwE4CrAGclOYT7ACZ
	y9nQKg3UgEz/Hanu+vgEXcp9I1IWArq+Jb18tm6taF/2PMmKWH9kgZ3FbRpyrahd
	fpb7tC+JIbYGe502byLA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xkkgm8dqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 10:20:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43JAKcmv002687
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 10:20:38 GMT
Received: from [10.217.217.112] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 19 Apr
 2024 03:20:35 -0700
Message-ID: <229b9ae2-1705-493b-b0fc-9de6c32925a5@quicinc.com>
Date: Fri, 19 Apr 2024 15:50:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Umang Chheda <quic_uchheda@quicinc.com>
Subject: Re: [PATCH RESEND] arm64: dts: qcom: qcs6490-rb3gen2: enable PMIC
 Volume and Power buttons
To: Bjorn Andersson <andersson@kernel.org>
CC: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240403132839.2117675-1-quic_uchheda@quicinc.com>
 <6b3gqfrvljvlfaf365l55kjcbjd4rfmw223tro6rqy5crykxgb@l66dptcrujip>
 <3ca2f601-ce45-43cf-b0dd-e28865874455@quicinc.com>
 <jlwxlnllpt557eiktovujcrfm2qwd3ynlxpo2v2witkekvocey@indbptcgvitm>
Content-Language: en-US
In-Reply-To: <jlwxlnllpt557eiktovujcrfm2qwd3ynlxpo2v2witkekvocey@indbptcgvitm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Be1aZIVxTqcTFGf2uSNwnNRL9JrcxVof
X-Proofpoint-ORIG-GUID: Be1aZIVxTqcTFGf2uSNwnNRL9JrcxVof
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_07,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=545 impostorscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404190077



On 4/15/2024 7:30 AM, Bjorn Andersson wrote:
> On Fri, Apr 12, 2024 at 04:18:36PM +0530, Umang Chheda wrote:
>> Hi Bjorn,
>>
>> On 4/9/2024 8:47 PM, Bjorn Andersson wrote:
>>> On Wed, Apr 03, 2024 at 06:58:39PM +0530, Umang Chheda wrote:
>>>> The Volume Down & Power buttons are controlled by the PMIC via
>>>> the PON hardware, and the Volume Up is connected to a PMIC gpio.
>>>>
>>>> Enable the necessary hardware and setup the GPIO state for the
>>>> Volume Up gpio key.
>>>>
>>>> Signed-off-by: Umang Chheda <quic_uchheda@quicinc.com>
>>>> ---
>>>
>>> I suppose this isn't a "resend" either, so please send me a new version
>>> of this as well.
>>>
>>
>> I had earlier sent [1] for review, on which I hadn't received any review comments.
>>
> 
> I see.
> 
> If you want reviews on your patches, ask a colleague to invest a few
> minutes in the patch and send a Reviewed-by or Tested-by. That both 
> 
> Not only will this give you reviews, it will show the community and the
> maintainer that there's someone out there who's interested in seeing the
> patch merged.
>

Thanks for the suggestion! will ask colleagues to help with R-by/T-By tags on the patches
as suggested.

>> Hence, I resent this patch again after 2 weeks for review.
>>
> 
> Please only resend patches if you strongly believe that necessary
> recipients didn't receive the patch.
> 
Ack

Regards,
Umang

> Regards,
> Bjorn


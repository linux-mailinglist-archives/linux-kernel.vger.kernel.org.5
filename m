Return-Path: <linux-kernel+bounces-74652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF66C85D748
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DD531C20329
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB8E4D599;
	Wed, 21 Feb 2024 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E/eZZMw3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53B147A53;
	Wed, 21 Feb 2024 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515626; cv=none; b=Naok2mxPrb6X59ammwTHnQUWsdKbMpyrgnZknkhkOeCZWS7p47B2MSer3TDdv2VJdUDVGOllT3ro6M0K30YTz4W4SavTqsM8CX7fZ9+wUvA6XkaUawkrD0DsK2E5qoOgFqEVODPtwzC4bPRRHmtYTfhfms0KxnSoVUSdFYM52XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515626; c=relaxed/simple;
	bh=0ec34IK25nzurSkFJjXS/YQlGdjhk3snlkzJkHfASN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g9bFxQgt3An0AHirVHrSqum6kWO9iyGUoFtjH8CrW4PPhHXmaprb91dgtg/bcxPsFeyy3KgiviDZNdt6slxZ+SRacrDaLapwyKCy6hMCL8cCuYctz8HGc3DfPISAx0aCeY9PslJIKRwKdZqw5k8iAZ6l1K0/AOnbtZMCwDLOg58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E/eZZMw3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41L8AB6D010696;
	Wed, 21 Feb 2024 11:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=55EJpJjN/7VQPyDIfbMUTZRT/+5KZL9krJsL+5YEq/s=; b=E/
	eZZMw31yXmpyBtXkDf6YPpYZF9nFNwRWXViSFQYjyZBSgwg6Ni3GDyUchinVC5nc
	F/GPackZq2AqwlLtF7QDnnR+3ZbMtrgs04IAEbO/oNAZSEZnwiS3AEoMNmRS+ik/
	Der8LrqNK/SxU1xv3XgkXWDJSS2DiRGfOuBdn69lCXXFtEkyR7jNXwy088V3kpNo
	emS9lEvRpGH72oPaWnHe6WfpKeeg2CnLZUPCI8KJh+Fke+06D1tDynQ4F0ZTLZgy
	0AbdUSg91QyE2x9BiuAxDO5npwLOgPz9vPsgOg0jrRjgYmsaQfkx9M7BR9qaV4D3
	x3VTN1BmBr4aZCdw1LbQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdddg0ey0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 11:40:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41LBeG3T021375
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 11:40:16 GMT
Received: from [10.216.53.46] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 03:40:12 -0800
Message-ID: <00bd50ed-bc7c-482f-b126-321d1ac9228d@quicinc.com>
Date: Wed, 21 Feb 2024 17:10:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: qcom-snps: Fixed order of enabling regulators
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        "Kishon Vijay
 Abraham I" <kishon@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>
References: <20240221103202.3628142-1-quic_kriskura@quicinc.com>
 <CAA8EJprMd5tr91gm99GyP1oefO_=tNQzxKA6hmB-xtBNVTbeeQ@mail.gmail.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <CAA8EJprMd5tr91gm99GyP1oefO_=tNQzxKA6hmB-xtBNVTbeeQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: P90DIIVEW0y5-5QJQhHZwpZwmt94OTHk
X-Proofpoint-ORIG-GUID: P90DIIVEW0y5-5QJQhHZwpZwmt94OTHk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210090



On 2/21/2024 4:26 PM, Dmitry Baryshkov wrote:
> On Wed, 21 Feb 2024 at 12:32, Krishna Kurapati > <quic_kriskura@quicinc.com> wrote:
[...]
>> ---
>>
>> Downstream kernels on QC targets use this sequence to power up
>> the phy and this has been tested extensively on multiple targets.
>> This change has been tested with upstream kernel on QCM6490-IDP
>> without EUD to ensure there is no loss or breakage of functionality.
>>
>>   drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
>> index eb0b0f61d98e..e86d221b7397 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
>> @@ -79,7 +79,7 @@
>>   #define LS_FS_OUTPUT_IMPEDANCE_MASK            GENMASK(3, 0)
>>
>>   static const char * const qcom_snps_hsphy_vreg_names[] = {
>> -       "vdda-pll", "vdda33", "vdda18",
>> +       "vdda-pll", "vdda18", "vdda33",
> 
> NAK.
> The driver uses regulator_bulk_enable, which enables all three
> regulators simultaneously via async calls, thus your change doesn't
> have any effect.
> 
Hi Dmitry,

  Thanks for this information. I thought it was synchronous but you are 
right, I see in code they are async:

                 async_schedule_domain(regulator_bulk_enable_async,
                                       &consumers[i], &async_domain);

  I think separating them out and calling regulator_enable on each one 
might work out.

> Also note, that these regulators are frequently shared between
> different consumers. As such, even if you have tight control of
> regulator ordering in the driver, other drivers might enable
> corresponding regulators on their own, breaking the ordering.
> 

You are right. Let me check how the phy regulators are allocated in 
different femto phy targets.

Thanks for the review.

Regards,
Krishna,


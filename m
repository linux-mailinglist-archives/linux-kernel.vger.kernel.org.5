Return-Path: <linux-kernel+bounces-103593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF9D87C18C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674AB28360C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D467442C;
	Thu, 14 Mar 2024 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fMeg+X4Z"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A516574297;
	Thu, 14 Mar 2024 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710434992; cv=none; b=nt2/MnnyUKPs3z8jRZ+hGxZmR2jnhRxw/Zk9wBzbY6k4MF6zDp/l9AI/EGHTf776MAC+VXX4oSgG+GyEnXPiQ/5sQ30aspiXqPL7YDdr3aPKE2wKGFIb4Zg2tsQUK3MObY2ZLzUNRnxbPI5yxH643+Rfc2dOtGkdC1A69N55qxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710434992; c=relaxed/simple;
	bh=77RGVau4t5+nCJcsSl+IWY9mY9TgXjNVDBPzWOsL7Oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Vn8kIQEMg2NFuuAPOcPfXbaj1sGyTEF5ZXrOS7Dzs77SzSHIsyCx29Q6WwFGBK2SA8Udsa1WDJo5vmyRyiqDyTgEx81xEFDANmT/oLTnerYyhG8TDuntioNLEFHcgSxf1DuRvLm9FDmklkkaio9DVOLu8yTu0C8T1LdbicSfgNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fMeg+X4Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42ECt8TR020772;
	Thu, 14 Mar 2024 16:49:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=L1eAnaiZBqkMn7bva+eCnIAzET7tl1WlG5vQ4gbJSPk=; b=fM
	eg+X4ZuP7VBPIbi+PTue/ReWNL6Gsl88ooXnBa7JVZf9PE9ghFUb544baDCkrzfi
	4A36waAHOkAP+veaoTf6kHD5QHTMQr7KKLVqAvMWRkcWZ4l+03QxXtnurrLtLl7D
	DO4Fl388xc2qehbfTtiTtGFpe7vR1UHdx+IclIP8L2gXI1DJQH9ORizwqHJr1cDz
	UKzCAnF++Coa7SKlKe11fTizyWVFgfA5B7uD+h2IGZ705sHaqq5eapWUisGnEdjX
	98FMcq94QMwAd/WVoNWM14YNZSaTLRtaFrABTrs2cjTNH2ABO+HfxoHW+kxZOAVR
	s/0QTsN9dAQpY5eON4wQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wv1njrjce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 16:49:47 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42EGnkSI028029
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 16:49:46 GMT
Received: from [10.216.10.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Mar
 2024 09:49:43 -0700
Message-ID: <3f80db1c-43ba-aafb-3f4d-f0e348808f52@quicinc.com>
Date: Thu, 14 Mar 2024 22:19:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/3] Add eFuse region for Qualcomm SoCs
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1709727995-19821-1-git-send-email-quic_mojha@quicinc.com>
 <40985e3c-9280-4035-9f01-4693cfd39235@linaro.org>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <40985e3c-9280-4035-9f01-4693cfd39235@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4iwqqpsrm7ZWbmAUqgcDbIprV8S3W76Z
X-Proofpoint-GUID: 4iwqqpsrm7ZWbmAUqgcDbIprV8S3W76Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 mlxlogscore=464 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403140126



On 3/6/2024 8:38 PM, Krzysztof Kozlowski wrote:
> On 06/03/2024 13:26, Mukesh Ojha wrote:
>> This series is dependent on [1] for binding.
>>
> 
> Thanks for linking, that's good and explains a lot, but to clarify: No,
> it does not depend. There is no dependency. This can be applied via
> Qualcomm SoC.

I see, thanks.

-Mukesh

> 
> Best regards,
> Krzysztof
> 


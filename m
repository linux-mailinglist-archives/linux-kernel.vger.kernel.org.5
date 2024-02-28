Return-Path: <linux-kernel+bounces-84526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FAB86A7D5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D6E2884CA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094E0210E6;
	Wed, 28 Feb 2024 05:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AJARjKd3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0851B20B29;
	Wed, 28 Feb 2024 05:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709097324; cv=none; b=L2NQzPLwqta4u5bTMjSCsim1TiphbfVsGRRgj6/2Rdfo5ke876nfn/jSPBiAfg9mQrh88StDiB5ztC3kN1b4isFFpdjgs87qpyPp07wocWzJRdUW8Gj+jP7lEdcjMjtGVs8coJ+t+ftIdubGIEqiX0WEj3LiKU6awkOY+4fedp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709097324; c=relaxed/simple;
	bh=YMpvLnQoz8AsPgpA2MFPC0lyHfFC83eji81qUPET9ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RC8copKiOP9yA9499Ti+pHgqBa3yZu2oBz976V4v88szI+YbZPrQMO7/UOXiX53VRCriBJYjSWLR8rNorXiyqK001YQl9SQEtYa/wGfxv/t/EFrnsWyccOqjCLjOBzB+eK+SJ33uJ+u3eGsEQjIRRFM5GE0hvL9Ftt+tH9GlqlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AJARjKd3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S4fET6023481;
	Wed, 28 Feb 2024 05:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ONy1WksZsqY9VpOjDPFbVNytmYt+T8OhzsGJsHIhY8M=; b=AJ
	ARjKd3w0Ueix8Mih27ko6Yvcne25xh1TBqz+vjOp+cWa54kr2YBc13klcH4avJZ9
	DuiGYrkkket3es83Nu3/btju4sLbj4KdKq6tDC5jNejrhDqSgdoCiA3ysahFWmGK
	YeRjmmGZ/ZlSsBpREneeJj858GiQ4SoNLlaxhGc1ZqUidGpdXXY4Cr4E3gV3UaJ9
	/yQjBwyZOUfS06eiPOcqmjKSA/Lh/zqpxqPF6nqv0o0rGzFFogqYEVXSy+RpEgbt
	B/c3MUlZnaAI5UGBy/CAtAuR0OArwSpQWX3HGXebYNUU/OZk82f/MPyIu7uyd9TY
	+sFqhgLBFXwMUQWLHXiQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whu8k0b2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 05:14:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41S5EsIb015828
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 05:14:54 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 27 Feb
 2024 21:14:49 -0800
Message-ID: <c165dd32-1e51-2fac-38ae-dd7300d36372@quicinc.com>
Date: Wed, 28 Feb 2024 10:44:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/2] Fix per-policy boost behavior
Content-Language: en-US
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: <dietmar.eggemann@arm.com>, <marcan@marcan.st>, <sven@svenpeter.dev>,
        <alyssa@rosenzweig.io>, <rafael@kernel.org>, <xuwei5@hisilicon.com>,
        <zhanjie9@hisilicon.com>, <sudeep.holla@arm.com>,
        <cristian.marussi@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <linux-arm-kernel@lists.infradead.org>, <asahi@lists.linux.dev>,
        <linux-pm@vger.kernel.org>
References: <20240227165309.620422-1-quic_sibis@quicinc.com>
 <20240228050703.lixqywrtxravegc6@vireshk-i7>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20240228050703.lixqywrtxravegc6@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3PLJLITKKh5u0xgINhxue5qfBRIknhNp
X-Proofpoint-GUID: 3PLJLITKKh5u0xgINhxue5qfBRIknhNp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_04,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280038



On 2/28/24 10:37, Viresh Kumar wrote:
> On 27-02-24, 22:23, Sibi Sankar wrote:
>> Fix per-policy boost behavior by incorporating per-policy boost flag
>> in the policy->max calculation and setting the correct per-policy
>> boost_enabled value on devices that use cpufreq_enable_boost_support().
> 
> I don't see the problem explained anywhere and the patches look
> incorrect too. The drivers aren't supposed to update the
> policy->boose_enabled value.

Hey Viresh,
Thanks for taking time to review the series.

In the existing code, per-policy flags doesn't have any impact i.e.
if cpufreq_driver boost is enabled and one or more of the per-policy
boost is disabled, the cpufreq driver will behave as if boost is
enabled. I had to update the policy->boost_enabled value because we seem
to allow enabling cpufreq_driver.boost_enabled from the driver, but I
can drop that because it was just for book keeping. I didn't want
to include redundant info from another mail thread that I referenced in
the cover letter, but will add more info in the re-spin.

-Sibi

> 


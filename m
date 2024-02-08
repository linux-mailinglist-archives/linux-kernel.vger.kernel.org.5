Return-Path: <linux-kernel+bounces-58275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8064A84E3DD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87718B254FB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1F07B3D3;
	Thu,  8 Feb 2024 15:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e8s3+zAE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73047C08A;
	Thu,  8 Feb 2024 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707405501; cv=none; b=pmgaj3/bUUfrD7PofyGifqk67dhF+h3f/JnWt3SAg0gDAvL32oTuv7PpbEUMBCDQmUOA78jXPItQ6GsSPaaUL2En3P6jb8gRNZOrJMY2TTJlzm8VhqfFGoHrsM5HCEG5reM4Y0g7ECyHzcNME49GsGEauKwOUjIiAcPVqUwedSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707405501; c=relaxed/simple;
	bh=7FHpLsml/xrkJsAoY6Cfp+BIiPZFRxSXlyhhfCApqt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lvLyGBtAzU2bYez+mLq19kqqec59yln3jg2ofF7By0p5topI5CxAg1c5AkCoF2bFvPCc+swTWfq5YnBcecheHGBmLBqDGBIgtnPqWsaw8lDYFii33TuqRutcjXvnmvJwbflftPArcQeGEaxrZrIneFxWOkNr/3M9GdVoS9pls4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e8s3+zAE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 418FG4uo008555;
	Thu, 8 Feb 2024 15:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=xJSY7K7wKqMS50bCqgU7kI6Mf7K1mbRsWl+vQYNi4Q4=; b=e8
	s3+zAEszMyNcJM0J8FuoEQxEraXVRkIq9qWkwo6rICcywwZwtdRAxD2mzJ5l76Lq
	A40uobPwuShNpl7zTJMN3+uThyO8jZ+LRQuWrljlt1FEOpt/fHTDPuk3aCqlpe5J
	hePkWhM0PbQBW3v62PuKzMGBbE5+OTtKPh23x2i4KMpIzC3tR7n5qH91AUmZHvsa
	pNVCToOk7X9qahlGNEXzdAAl4VCpMx/ZIgqBlIfxdE9Cy/VNyxbfZIQ15/XnlwKF
	YmNlO/dusj8HUxU2KYuwLLVjDnEkVC2067fwZybX80jmdvgOpfRnxBanWpEQrYir
	AvkfR36F/ilNALmvCfHQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4frwtg5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 15:18:10 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 418FIAcD019950
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 15:18:10 GMT
Received: from [10.216.3.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 8 Feb
 2024 07:18:07 -0800
Message-ID: <1cb6a33f-57e8-f3d0-9098-755af70cda41@quicinc.com>
Date: Thu, 8 Feb 2024 20:47:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH 1/1] iommu: Avoid races around default domain allocations
To: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "Charan
 Teja Kalla" <quic_charante@quicinc.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <e605b38a2d40b1e7589e10110c6d3ece35f6af4e.1705571894.git.quic_nprakash@quicinc.com>
 <139a9abe-75d8-3bda-3ec9-a14a493eb2a9@quicinc.com>
 <20240201162317.GI50608@ziepe.ca>
 <9ba9c4fa-3fa9-c6c4-ce77-0c6cd5e23680@quicinc.com>
 <20240207145656.GJ31743@ziepe.ca>
 <37ab8689-5e0d-4166-bad6-84d3c51446ca@arm.com>
 <20240208011305.GM31743@ziepe.ca>
 <a93e93dd-5cb8-48ee-bf8d-b3bbb19507d6@arm.com>
Content-Language: en-US
From: Nikhil V <quic_nprakash@quicinc.com>
In-Reply-To: <a93e93dd-5cb8-48ee-bf8d-b3bbb19507d6@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: V_wrRmnuYUYs1H_6fl4F0M1x38iqtUAN
X-Proofpoint-GUID: V_wrRmnuYUYs1H_6fl4F0M1x38iqtUAN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_05,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=868 adultscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402080081



On 2/8/2024 7:07 AM, Robin Murphy wrote:
> On 2024-02-08 1:13 am, Jason Gunthorpe wrote:
>> On Thu, Feb 08, 2024 at 12:04:44AM +0000, Robin Murphy wrote:
>>>> Frankly, I'd suggest just proposing the necessary (and tested)
>>>> upstream patches to 6.1, however large they are, and see what Greg and
>>>> Sasha say. This is the usual working model they have, as I understand
>>>> it.
>>>
>>> To be blunt, hell no. Stable is far enough from its namesake already; 
>>> the
>>> ongoing bordering-on-ridiculous brokenness of your mainline changes 
>>> where
>>
>> What on earth are you even talking about? POWER?
> 
> I mean you're literally getting bug reports for your fix for your fix 
> for your grand idea, so what should we figure, that reality not aligning 
> with your expectations is all reality's fault?
> 
>>> That said, I also don't think there would be any harm in applying 
>>> this to
>>> mainline as a belt-and-braces thing either,
>>
>> Really?
> 
> "at 12:04:44AM +0000, Robin Murphy wrote:"
> 
> It's late, I should have gone to bed hours ago, so I apologise for any 
> lack of clarity; that was very much meant to be an implication of 
> agreement with the overall approach, not the exact patch as is, which if 
> you read the rest of my response you will see I still had questions 
> about and did not formally ack or review.
> 
>> Now that you've made me look, this patch breaks the
>> iommu_group_store_type() flow both on latest and on v6.1 from what I
>> can see.
>>
>> On v6.1:
>>
>> iommu_change_dev_def_domain():
>>          prev_dom = group->default_domain;
>>          if (!prev_dom) {
>>                  ret = -EINVAL;
>>                  goto out;
>>          }
>> [..]
>>          /* Sets group->default_domain to the newly allocated domain */
>>          ret = iommu_group_alloc_default_domain(dev->bus, group, type);
>>          if (ret)
>>                  goto out;
>>
>> But this patch changes iommu_group_alloc_default_domain() to succeed
>> always without doing anythiing.
>>
>> So this patch needs some fixing.
> 
> Hurrah! Please apply that kind of rigour to your own patches also.
> 
> Thanks,
> Robin.
> 
> [ you get two responses this week since I admit I ran out of patience 
> and motivation to finish last week's on time ]


Hi Robin,

Bunch of issues were reported on 6.1 because that is where we do master 
testing. The change proposed was fixing the reported issues.

On your query regarding 5.15, from code perspective, looks like this fix 
is applicable on 5.15 as well. However, as mentioned, we have done 
master testings on 6.1 codebase and hence could see the issues there only.

Also, as Jason pointed out, this fix would not allow changing the 
default domain for an iommu group. We didn't have any usecase for 
changing default domain, hence couldn't see any issues with the fix 
proposed. So, we would have to rework the patch for it to be upstream 
ready. Any suggestions for this would be really helpful and
appreciated. Thanks!!!

Thanks
Nikhil V



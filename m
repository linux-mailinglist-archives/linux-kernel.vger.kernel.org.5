Return-Path: <linux-kernel+bounces-62950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0C385284A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4034B23BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560C812B7F;
	Tue, 13 Feb 2024 05:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l0GhWb+P"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C5511C88;
	Tue, 13 Feb 2024 05:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707802841; cv=none; b=OXRJCDQjy8xiBdRGQt3haBmQvAIgyJ04jniQdPzM4iFcuyVEWkOG9HdcAtuOKko7lP6OijaW/YEAQ7itq9E0eIKzhYMlKDrla7YnAfw5WhjuLXIiEBZC3SB0TChYGcbuw1Km0vfC23/dx48d9KN2wuJgNJdZ2/UnZkN98L+0N78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707802841; c=relaxed/simple;
	bh=/SBqz9kKLbxiDr3+vIU4yakZsEGow4mgvLGrY7vbSzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Oq7Sd+ioiWMJRGQMUfyUXFbSc77ASDbFJNTZJUneo9qe4QCwo3Bk/G+VU72vbwr+UJWScVnxIUnfMoi/BzQ2579oZZnrhE+w09RCLTz1wgYo6rCtkIcOyjBxc3E0Mq66at3o7uIDMI3yN7+lwhDFhehTDvfT/XEHNyondCTVYZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l0GhWb+P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D5CN4E032147;
	Tue, 13 Feb 2024 05:40:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=bcECAOxG27hb5viVJ2WKDRBPwzybpcZBZwp56T0Hm+M=; b=l0
	GhWb+Pa9VTZygEdbCVtchYTP+z9qL6PEWITmhktr4Gi1ufPfKxWCI+B2w8q899sb
	NhiaODC1n64ohyyCdcwgErzKxE2bLhXgEHsDPsGa/tckHxuEIcO0PQFjJv6lVJG7
	DXgajTCSfPRKu54iVqXfTkGBMC3TUU1u83joyflD7rIwlHmtf+kr5tGg95235nBK
	02cInMY9c7c8Ng5r7qzj4th3//HtnqaT91fNgz2GDX5g7fQXLvOruRAVckl2d+4a
	mN/kr0Q22DWXvy9VYMUhrvGRQmTAubTko4jVziZjNKWB/zYh/lJoqPaXGfh98Bms
	LjtIr52vF64MRuK7Hvuw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7hewa4p7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 05:40:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41D5eSCV028913
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 05:40:29 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 12 Feb
 2024 21:40:25 -0800
Message-ID: <d0b47ead-0e39-a303-66bf-43d7e3bd3fd6@quicinc.com>
Date: Tue, 13 Feb 2024 11:10:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 1/4] firmware: arm_scmi: Add perf_notify_support
 interface
Content-Language: en-US
To: Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla
	<sudeep.holla@arm.com>
CC: <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>, <rafael@kernel.org>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
References: <20240117104116.2055349-1-quic_sibis@quicinc.com>
 <20240117104116.2055349-2-quic_sibis@quicinc.com> <ZbfJN1c9viiLhO1L@pluto>
 <ZbfhdqBBpjyf3IRI@pluto> <20240131112854.24euh6c6xgljsj6c@bogus>
 <ZcoSuv7qwexbXy-9@pluto>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <ZcoSuv7qwexbXy-9@pluto>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ES6HdPApwObErYW01lLVkdC3oSyHTg7S
X-Proofpoint-ORIG-GUID: ES6HdPApwObErYW01lLVkdC3oSyHTg7S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1011 mlxlogscore=987 priorityscore=1501
 malwarescore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130039



On 2/12/24 18:14, Cristian Marussi wrote:
> On Wed, Jan 31, 2024 at 11:28:54AM +0000, Sudeep Holla wrote:
>> On Mon, Jan 29, 2024 at 05:33:42PM +0000, Cristian Marussi wrote:
> 
> Hi Sibi,
> 
>>> On Mon, Jan 29, 2024 at 03:50:20PM +0000, Cristian Marussi wrote:
>>>> On Wed, Jan 17, 2024 at 04:11:13PM +0530, Sibi Sankar wrote:
>>>>> Add a new perf_notify_support interface to the existing perf_ops to export
>>>>> info regarding limit/level change notification support.
>>>>>
>>>>
>>>> Hi Sibi,
>>>>
>>>> as I mentioned previously, in order not to add a needless stream of SCMI
>>>> Perf accessors I posted this:
>>>>
>>>> https://lore.kernel.org/linux-arm-kernel/20240129151002.1215333-1-cristian.marussi@arm.com/T/#u
>>>>
>>>> to expose all the Perf domains infos via the usual info_get(), similarly
>>>> to how other SCMI protocols do already.
>>>>
>>>> I think that reworking this series on that, you can certainly drop this patch and just
>>>> check the _notify booleans on the retrieved domain info.
>>>
>>> Sorry, but hold on with this change, I will probably post an updated version
>>> my patch above.
>>>
>>
>> As discussed in private, I would prefer to avoid exposing all the internals
>> to the users of SCMI perf. At the same time may we can do better if we can
>> check the availability of notification as part of notification enablement
>> from the SCMI driver, I need to think the details yet.
>>
> 
> as previously mentioned, after speaking with Sudeep, I posted a new
> series at [1], that aims to solve your problem with registering
> notifications and looking up reported Perf frequencies in a new way.
> 
> Using the changes at [1] you should be able to:
> 
> - register your notifier without caring to check if the notification
>    is supported, since the SCMI core will take care of checking that and
>    report an error if not supported, without sending any unneeded
>    attempted notification enable message  (so you can drop 1/4 in this
>    series)
> 
> - retrieve the pre-calculated OPPs frequencies from the new extended
>    Perf notifications reports no matter if the system if operating in
>    level_indexing_mode or not. (so you can drop 2/4 in this series)

Christian/Sudeep,

Thanks a lot for spending time on this and simplifying the series.

Will re-spin the series with your recommendations.

-Sibi

> 
> Thanks,
> Cristian
> 
> [1]: https://lore.kernel.org/linux-arm-kernel/20240212123233.1230090-1-cristian.marussi@arm.com/T/#ma68cefd753e34ba3e1f2d4392e978026a87e1bf8
> 


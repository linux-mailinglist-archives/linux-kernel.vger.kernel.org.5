Return-Path: <linux-kernel+bounces-81473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AA5867660
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79CDA1C28DC0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD81127B75;
	Mon, 26 Feb 2024 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="chVli2vv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47211CFA9
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708953788; cv=none; b=jgth79PbenokMmx3HCQ+YBU5H+gWSbHnY42lBWT5kKEUD9G+UHfOAF4UGkcRjrVICKMxXRKgac2HmjufEZN9/iEng37QaDIFpfFPGJI2zc9d5Ty3kqVPY+mZynBQnPcMjNaYqistpcwso3xrAiBv/Jg2AGHXse3ca2CuzUkkj20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708953788; c=relaxed/simple;
	bh=AcqwwO5JCL52zifJIf6vDuEWWqwcYnJg9aUjnBuMVuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U6XoRanSSHWknVv4QGsAEr9eXu1QexL0RsD2p2hfIOzahNq8C6+eEf8Yvr6Auph2D1JB2AUfDa9aWGVYDAEUHpGDev8uxwUBzEkUj7HYCbCe0A9w9knpibgwBi8kR6roxxbPfiGHgDKPiDqj0Nj3kx1cnAEGl4HrnBywy3HQmQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=chVli2vv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41QAETk2007630;
	Mon, 26 Feb 2024 13:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=i9iledkpmb8HlUosuW65FlpRby2/2OjrN74Mvdfba8c=; b=ch
	Vli2vv79PIP07OXvWzJXxf7UBkvUy/E7GL5otYC/1NHv08Kl8QqJyUWROJwuUv/3
	aFyhLH+dvpyAl4Ei7XhXq8QH8Abg4lo96zVYGGo5c4VKuuTC0g45Sj+K/MynTd0H
	1T7DSQofRyP2Lw1L+QvR8H7daIlqJjhBg3F2L7ph/VBlZ5oRwPitzqjMrv9NlT6/
	T31fS1/9QbgiesMV508DCMIfGfhxoI5dENu4Kn2ZvG3cusDKnuyLBv1E+LEg3LTm
	NwKv27VoQRLzEmZWc8wk42UcRW/h2r31r50QRb63+79FOrP4g5ped3XWVpKHIU3R
	uJsJ3s+tiAvC1hK8yahw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxpryyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 13:22:55 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QDMsmZ004336
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 13:22:54 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 26 Feb
 2024 05:22:52 -0800
Message-ID: <f142baba-619c-940c-9ceb-7c0d9c8ca7dc@quicinc.com>
Date: Mon, 26 Feb 2024 18:52:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH vRFC 3/8] treewide: rename firmware_request_platform()
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
CC: Luis Chamberlain <mcgrof@kernel.org>, <russ.weight@linux.dev>,
        <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
        <cocci@systeme.lip6.fr>
References: <20240222180033.23775-1-quic_mojha@quicinc.com>
 <20240222180033.23775-4-quic_mojha@quicinc.com>
 <2024022347-ribcage-clench-37c4@gregkh>
 <Zdi2odoYPBWywOXn@bombadil.infradead.org>
 <2024022323-accustom-eradicate-8af4@gregkh>
 <Zdj1K28NBfGfSJ-0@bombadil.infradead.org>
 <2024022452-unwilling-pancake-3b2a@gregkh>
 <ed9f2b75-38d3-8562-0476-2200e201d4c9@quicinc.com>
 <2024022644-trough-humility-12b8@gregkh>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <2024022644-trough-humility-12b8@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nYApUmDPmRq5u9Z2LBuuRhr0ectVatbN
X-Proofpoint-ORIG-GUID: nYApUmDPmRq5u9Z2LBuuRhr0ectVatbN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_09,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=971
 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402260101



On 2/26/2024 6:39 PM, Greg KH wrote:
> On Mon, Feb 26, 2024 at 04:22:09PM +0530, Mukesh Ojha wrote:
>>
>>
>> On 2/24/2024 11:06 AM, Greg KH wrote:
>>> On Fri, Feb 23, 2024 at 11:42:35AM -0800, Luis Chamberlain wrote:
>>>> On Fri, Feb 23, 2024 at 04:33:40PM +0100, Greg KH wrote:
>>>>> On Fri, Feb 23, 2024 at 07:15:45AM -0800, Luis Chamberlain wrote:
>>>>>> On Fri, Feb 23, 2024 at 07:21:31AM +0100, Greg KH wrote:
>>>>>>> On Thu, Feb 22, 2024 at 11:30:28PM +0530, Mukesh Ojha wrote:
>>>>>>>> Rename firmware_request_platform() to request_firmware_platform()
>>>>>>>> to be more concrete and align with the name of other request
>>>>>>>> firmware family functions.
>>>>>>>
>>>>>>> Sorry, but no, it should be "noun_verb" for public functions.
>>>>>>
>>>>>> News to me, do we have this documented somewhere?
>>>>>
>>>>> Not really, but searching makes it nicer.
>>>>>
>>>>> And yes, I violated this in the past in places, and have regretted it...
>>>>
>>>> Care to share a few examples of regret?
>>>
>>> 	get_device()
>>> 	put_device()
>>> 	kill_device()
>>>
>>> vs. a saner:
>>> 	kobject_get()
>>> 	kobject_put()
>>> 	kobject_del()
>>>
>>> Learn from the mistakes of my youth please :)
>>
>> Thanks for the history.,
>> In that case, should we fix this verb_noun cases ?
>>
>> request_firmware()
>> request_firmware_into_buf()
>> request_firmware_nowarn()
>> request_firmware_direct()
>> request_firmware_cache()
>> request_partial_firmware_into_buf()
>> release_firmware()
> 
> That would provide consistency, right?

Yes, Below names look better..

firmware_request()
firmware_request_into_buf()
firmware_request_nowarn()
firmware_request_direct()
firmware_request_cache()
firmware_request_partial_into_buf()
firmware_release()

@Luis/Others, Can we do this change ?

-Mukesh
> 
> thanks,
> 
> greg k-h


Return-Path: <linux-kernel+bounces-78514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE2386145B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 769E4B2200C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA969839E7;
	Fri, 23 Feb 2024 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dCvGqtVv"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CF84687;
	Fri, 23 Feb 2024 14:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699346; cv=none; b=F3JpqgeQ8nydkBe5Hr6o+GGBEx5Jv87DhnvS3YKOEh42cnDQACXonMcTNDCIeKBcTebBxNZQHSMBeLaoNy41ajPXvHWSGDRlf4mGz9lALnK8k0b7K69amgjkLxCJNt+726bEd2dKw6K+RJh5IMk/8J3QOYx5aZuhJ6BGcaPGNjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699346; c=relaxed/simple;
	bh=JG2wz/jwI/HJkXPNsVUM9vI9kFE7H3GmD3rx1EWtrvI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DsHzFb15FxXFyy7jZ1SamsEaOfhEXPikpLwUNMjv4AOAzHzA1ARV3J4dB0hHB5/UnvJ/PPf6verpK9IOPMOYeVFKHItsT15OpZxmtgjxb0LhK6ctQgU0XEXmJtKTeqvLkPfgCwNYsMGPPXxqzIZXKFkrcYxGsBhcSXMASvUSOck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dCvGqtVv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NEDZLL000853;
	Fri, 23 Feb 2024 14:42:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=WBmD23Rw85X27Usle1YuvJy0QIb1N98BwcB2TVrk6R4=;
 b=dCvGqtVv6UVIUdIXf293vM0n9qXb31CPgDB6Qyi5G/wn6byGhI1K6xCMAQAD7LJS1E71
 7kKRjnQyRI/m6tEGMJo8OoWgebarE9INli6GVbrHXQScpIBD915QYiyxhM7IKITnDw7e
 Wo1xvykGz8JUJMinwfPLE/le/JvpkRSojew8n4evwRqaZggbB65kRZ5Trz9VKlmSFksk
 CN6tK66E2IQX3HELRcLqRYiIjfzVsM6n0BFBTf2YOSy/VJob7rQPf2jJsv43yN7+NYtl
 3vVXq9dOo+pIgSYYn7buws3jrsgKAUiQVdcY94Nitf+bri52U8iTqeJ2q1BbZiu1KTEV 2A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wevxdrt9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 14:42:19 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41NEZqEX020060;
	Fri, 23 Feb 2024 14:42:19 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wevxdrt95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 14:42:19 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NEBnae017261;
	Fri, 23 Feb 2024 14:42:18 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb8mmwtd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 14:42:18 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NEgEau7275374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 14:42:17 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A608558059;
	Fri, 23 Feb 2024 14:42:14 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 537B558065;
	Fri, 23 Feb 2024 14:42:11 +0000 (GMT)
Received: from [9.171.73.236] (unknown [9.171.73.236])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 14:42:11 +0000 (GMT)
Message-ID: <b8ad3e35-7dba-41f2-a301-65f8162a2dbd@linux.ibm.com>
Date: Fri, 23 Feb 2024 15:42:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 14/15] net/smc: introduce loopback-ism DMB data
 copy control
Content-Language: en-GB
To: Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jaka@linux.ibm.com, Gerd Bayer <gbayer@linux.ibm.com>
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240111120036.109903-1-guwen@linux.alibaba.com>
 <20240111120036.109903-15-guwen@linux.alibaba.com>
 <b3b71f26-239f-49c9-98e8-7eba2c4ecf69@linux.ibm.com>
 <58f36cb7-7427-4ed7-9a8e-baaacdd774cb@linux.alibaba.com>
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <58f36cb7-7427-4ed7-9a8e-baaacdd774cb@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bjq3QYY01i7GuuboqWVYpK1sIYlEM-VP
X-Proofpoint-GUID: BW3P7N4XcR4tpqGaukdPMVauBSZE4a1z
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230107



On 20.02.24 04:36, Wen Gu wrote:
> 
> 
> On 2024/2/16 22:25, Wenjia Zhang wrote:
>>
>>
>> On 11.01.24 13:00, Wen Gu wrote:
>>> This provides a way to {get|set} whether loopback-ism device supports
>>> merging sndbuf with peer DMB to eliminate data copies between them.
>>>
>>> echo 0 > /sys/devices/virtual/smc/loopback-ism/dmb_copy # support
>>> echo 1 > /sys/devices/virtual/smc/loopback-ism/dmb_copy # not support
>>>
>> Besides the same confusing as Niklas already mentioned, the name of 
>> the option looks not clear enough to what it means. What about:
>> echo 1 > /sys/devices/virtual/smc/loopback-ism/nocopy_support # merge 
>> mode
>> echo 0 > /sys/devices/virtual/smc/loopback-ism/nocopy_support # copy mode
>>
> 
> OK, if we decide to keep the knobs, I will improve the name. Thanks!
> 
>>> The settings take effect after re-activating loopback-ism by:
>>>
>>> echo 0 > /sys/devices/virtual/smc/loopback-ism/active
>>> echo 1 > /sys/devices/virtual/smc/loopback-ism/active
>>>
>>> After this, the link group related to loopback-ism will be flushed and
>>> the sndbufs of subsequent connections will be merged or not merged with
>>> peer DMB.
>>>
>>> The motivation of this control is that the bandwidth will be highly
>>> improved when sndbuf and DMB are merged, but when virtually contiguous
>>> DMB is provided and merged with sndbuf, it will be concurrently accessed
>>> on Tx and Rx, then there will be a bottleneck caused by lock contention
>>> of find_vmap_area when there are many CPUs and CONFIG_HARDENED_USERCOPY
>>> is set (see link below). So an option is provided.
>>>
>>> Link: 
>>> https://lore.kernel.org/all/238e63cd-e0e8-4fbf-852f-bc4d5bc35d5a@linux.alibaba.com/
>>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>>> ---
>> We tried some simple workloads, and the performance of the no-copy 
>> case was remarkable. Thus, we're wondering if it is necessary to have 
>> the tunable setting in this loopback case? Or rather, why do we need 
>> the copy option? Is that because of the bottleneck caused by using the 
>> combination of the no-copy and virtually contiguours DMA? Or at least 
>> let no-copy as the default one.
> 
> Yes, it is because the bottleneck caused by using the combination of the 
> no-copy
> and virtual-DMB. If we have to use virtual-DMB and 
> CONFIG_HARDENED_USERCOPY is
> set, then we may be forced to use copy mode in many CPUs environment, to 
> get the
> good latency performance (the bandwidth performance still drop because 
> of copy mode).
> 
> But if we agree that physical-DMB is acceptable (it costs 1 physical 
> buffer per conn side
> in loopback-ism no-copy mode, same as what sndbuf costs when using s390 
> ISM), then
> there is no such performance issue and the two knobs can be removed. 
> (see also the reply
> for 13/15 patch [1]).
> 
> [1] 
> https://lore.kernel.org/netdev/442061eb-107a-421d-bc2e-13c8defb0f7b@linux.alibaba.com/
> 
> Thanks!
Thank you, Wen, for the elaboration! As I said, though we did see some 
better performance on using the virtually contiguous memory with a 
simple test, the improvement was not really significant. Additionally, 
our environment ist very different as your 48 CPUs qemu environment, and 
it also depends on the workload. I think I can understand why you see 
better performance by using physically contiguous memory. Anyway, I 
don't have any objection on using physical-DMB only. But I still want to 
see if there is any other opinion.


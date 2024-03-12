Return-Path: <linux-kernel+bounces-100701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09332879C20
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ADE71F23A68
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BFD142657;
	Tue, 12 Mar 2024 19:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rRUaChy0"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3611142634;
	Tue, 12 Mar 2024 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710270546; cv=none; b=ZfWKkCJkxDsMeYMm5EAOvHd0z0aCSsij6JLN/BuGkafnpKE4VN8F1Ze07Grs4O/bz5cGe58/Eokwg7uAHBAUagwmrvymZA8Z/oHn+mQNroi2+r7dvk9Gl3bH/po/E4TX2QhxEPCcbvpY8z5cBoHleMaRTytiVE7J0U9aZYA9jJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710270546; c=relaxed/simple;
	bh=JZX5DPUe2Tn3QeB1xQN2/1/4oqxHA8hTmLbS2TW1Gw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V8FBb7LwIhr1dngarmgSl61eYIJolMoXN7SXSgLWD6VugviSVSAIHSYGw/RlEuhJ8r3oMNvh353dggaFLTXH03TxYLJ7ZOIBwkByKwQSpn7pAW2uPRCiZYACJN+G0WOvoknz9MaO2xN2yos6rGW2GZkwnFxpujQkCtWrT8jHpdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rRUaChy0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42CIuxSN002406;
	Tue, 12 Mar 2024 19:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=SlihXnpmGmd9lmDDDePxLPY4NbCMyKzYmvjmqDLRl9U=;
 b=rRUaChy0KA5/hHLyo675GDpV0QrUkz62ncB+8fo4SO2nQyKV9JcnT7nZw5h5DbN4vXg4
 +bHMK31vBY45Bz57eQ5Ck6LwtEGoxeNwdDxh1H2by/TXTWvzHz75ZUjWFlwAd0zKl+EO
 psZGNZJ+du6FJSj00g+fKtcVZ0JxMTF7SccxZCFuWjyDzSYJDpBYVgFq3jR6RK7DTpqa
 W40To1xld54p4bsNJgzF28KUWxeP07EhJ6hQj9C8hIhjkI8IPUi+4ybMjHnA+MouASgO
 YqbjETNSB67DoPiyJfmFDrzHfne4b+FZp93Poriqya28Sbzcq1KUCsNbvsCEXm93oSL3 nQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtvsa87er-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 19:08:54 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42CIuwWp002332;
	Tue, 12 Mar 2024 19:08:53 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtvsa87e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 19:08:53 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42CIon3c020437;
	Tue, 12 Mar 2024 19:08:52 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws3km0x86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 19:08:52 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42CJ8nIG17498482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 19:08:51 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE7EE58059;
	Tue, 12 Mar 2024 19:08:48 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23A6558065;
	Tue, 12 Mar 2024 19:08:48 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Mar 2024 19:08:48 +0000 (GMT)
Message-ID: <e1b818ae-c932-4d25-98a5-26b258b63365@linux.ibm.com>
Date: Tue, 12 Mar 2024 15:08:47 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tpm: of: If available Use linux,sml-log to get the
 log and its size
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Michael Ellerman
 <mpe@ellerman.id.au>,
        linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, rnsastry@linux.ibm.com, peterhuewe@gmx.de,
        viparash@in.ibm.com
References: <20240306155511.974517-1-stefanb@linux.ibm.com>
 <20240306155511.974517-3-stefanb@linux.ibm.com>
 <CZNS7FO53BHK.6NO93P0C0VY5@kernel.org>
 <CZNS9K4BJPQ8.2MD4WZS8YMI3W@kernel.org>
 <663a3834-056e-4dda-99dd-16ee8734100e@linux.ibm.com>
 <877ci74u0w.fsf@mail.lhotse> <CZRW3GY5O5C0.R5HY5SOFCFJA@kernel.org>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CZRW3GY5O5C0.R5HY5SOFCFJA@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FmkvrwcYsISQ2f9e8fbNFAVaaIupA038
X-Proofpoint-GUID: KbovTr4OsFOA-wqfFNJciTwuXBLAzX0K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_12,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403120146



On 3/12/24 11:50, Jarkko Sakkinen wrote:
> On Tue Mar 12, 2024 at 12:35 PM EET, Michael Ellerman wrote:
>> Stefan Berger <stefanb@linux.ibm.com> writes:
>>> On 3/7/24 15:00, Jarkko Sakkinen wrote:
>>>> On Thu Mar 7, 2024 at 9:57 PM EET, Jarkko Sakkinen wrote:
>>>>> in short summary: s/Use/use/
>>>>>
>>>>> On Wed Mar 6, 2024 at 5:55 PM EET, Stefan Berger wrote:
>>>>>> If linux,sml-log is available use it to get the TPM log rather than the
>>>>>> pointer found in linux,sml-base. This resolves an issue on PowerVM and KVM
>>>>>> on Power where after a kexec the memory pointed to by linux,sml-base may
>>>>>> have been corrupted. Also, linux,sml-log has replaced linux,sml-base and
>>>>>> linux,sml-size on these two platforms.
>>>>>>
>>>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>>>>
>>>>> So shouldn't this have a fixed tag, or not?
>>>>
>>>> In English: do we want this to be backported to stable kernel releases or not?
>>>
>>> Ideally, yes. v3 will have 3 patches and all 3 of them will have to be
>>> backported *together* and not applied otherwise if any one of them
>>> fails. Can this be 'guaranteed'?
>>
>> You can use Depends-on: <previous commit SHA> to indicate the relationship.
>>
>> cheers
> 
> Thanks, I've missed depends-on tag.
> 
> Stefan, please add also "Cc: stable@vger.kernel.org" just to make sure
> that I don't forget to add it.

Yeah, once we know whether this is the way forward or not... I posted v2 
as RFC to figure this out.

v2's 2/3 patch will only apply to 6.8. To avoid any inconsistencies 
between code and bindings we cannot even go further back with this 
series (IFF it's the way forward at all). So I am inclined to remove the 
Fixes tags. I also find little under Documentation about the Depends-on 
tag and what it's supposed to be formatted like -- a commit hash of 1/3 
appearing in 2/3 for example? The commit hash is not stable at this 
point so I couldn't created it.

> Right, and since these are so small scoped commits, and bug fixes in
> particular, it is also possible to do PR during the release cycle.
> 
> BR, Jarkko


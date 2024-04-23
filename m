Return-Path: <linux-kernel+bounces-155401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7D08AE9E9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4521C22443
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1497A13B7AE;
	Tue, 23 Apr 2024 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X4y3uUdx"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9381719BBA;
	Tue, 23 Apr 2024 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713884181; cv=none; b=GkWGzQ4zcvT6WU/qb+yPTlrOKicZH4KyEr7dvhEUlp022JqYkK816qdKENK/9UUqLnEqWb91c5R/vNZcL42+8XraDZvAcuhDP+aHo8JLxRwqGm1qN06IrFvdq2l+eqCQ/ig2fMz20HUgeM4IQ8dFlb7fTaQZ8zO7EPvG993l+bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713884181; c=relaxed/simple;
	bh=JXp+cO2yj5IAd9bXLq9v30tCel6lzULFC1pdStj5dV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TqMOFbMEG6lPeUbeYPq61Hfqxc1bBxYBGjT5EFp7D7+CsUcTytJKc9sKKA+wfFk9VAXvYQG8vys7eBtzueTUJg7eGLAjCiD+1QYpWJar2IGm407OhOrWhO7ejI7GT8IlL2P85tNk6lc6ycCb+x+ltcgERftdQ0+0w+1/m3EKjRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X4y3uUdx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43NEns4S022107;
	Tue, 23 Apr 2024 14:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=n3FibSyhqeqNBMqlU4DUPCJOy+2RIesEFMLjIGdVnS0=;
 b=X4y3uUdxUeEeyGEPhrnrav7X3pS2ZUrBP+Gu6sIaZsRPTOUQILuk2Q0ku3drDHQ4iogT
 PHuE8UqWEUttKQrUUxGRCkzp5xZjQwLuJetJj5PLype0RPmms5Xtq7MWuPyBLtJZ/dTg
 Mwf2eHwinG5HADIdaZhoLUQGI18vn2dRKetO1Ywh+hf54sMeNeVXoqJHfwaMG02C/sGP
 VUEkbbPBC7+StFVp1O6qSYKglLtjqvEoniSSTnJSJIbFEyvm1Ch7b8VES35NwSsMriNr
 0n4bpZmyJmEN/5d1BdD93yuuRMppfEhMb6iBnP+8Xzg4J6QACy8ix78p8cMH6NXSU5dW lQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xpf3200eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 14:56:02 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43NEu1hO030103;
	Tue, 23 Apr 2024 14:56:01 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xpf3200en-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 14:56:01 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43NEr6Tr015277;
	Tue, 23 Apr 2024 14:56:00 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmshm61js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 14:56:00 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43NEtv9o17564218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 14:55:59 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 813985805E;
	Tue, 23 Apr 2024 14:55:57 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BD3458066;
	Tue, 23 Apr 2024 14:55:57 +0000 (GMT)
Received: from [9.24.5.26] (unknown [9.24.5.26])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Apr 2024 14:55:57 +0000 (GMT)
Message-ID: <7e3f43a3-98e0-40ed-8820-2f1eef8742ba@linux.ibm.com>
Date: Tue, 23 Apr 2024 09:55:57 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ibmvnic: Use -EBUSY in __ibmvnic_reset()
To: Dan Carpenter <dan.carpenter@linaro.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Haren Myneni <haren@linux.ibm.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Rick Lindsley <ricklind@linux.ibm.com>,
        Thomas Falcon <tlfalcon@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <4cff158d-b5ac-4dca-9fbb-626237c1eafe@web.de>
 <f493e39063ee52a3d263de27bfd240149d910a88.camel@redhat.com>
 <da19d324-3c66-4bb1-8fa2-dc26dbea622b@moroto.mountain>
Content-Language: en-US
From: Nick Child <nnac123@linux.ibm.com>
In-Reply-To: <da19d324-3c66-4bb1-8fa2-dc26dbea622b@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: W3whKt0gJALV53n61XLBMtyhTMQ4uEBE
X-Proofpoint-GUID: QfRQoGfEpIA_zIycNlg5y3GEeMz7Y15v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_12,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 clxscore=1011 adultscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2404230036



On 4/23/24 06:55, Dan Carpenter wrote:
> On Tue, Apr 23, 2024 at 12:54:55PM +0200, Paolo Abeni wrote:
>> On Fri, 2024-04-19 at 16:08 +0200, Markus Elfring wrote:
>>> From: Markus Elfring <elfring@users.sourceforge.net>
>>> Date: Fri, 19 Apr 2024 15:46:17 +0200
>>>
>>> Add a minus sign before the error code “EBUSY”
>>> so that a negative value will be used as in other cases.
>>>
>>> This issue was transformed by using the Coccinelle software.
>>>
>>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>>> ---
>>>   drivers/net/ethernet/ibm/ibmvnic.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
>>> index 5e9a93bdb518..737ae83a836a 100644
>>> --- a/drivers/net/ethernet/ibm/ibmvnic.c
>>> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
>>> @@ -3212,7 +3212,7 @@ static void __ibmvnic_reset(struct work_struct *work)
>>>   		    adapter->state == VNIC_REMOVED) {
>>>   			spin_unlock_irqrestore(&adapter->state_lock, flags);
>>>   			kfree(rwi);
>>> -			rc = EBUSY;
>>> +			rc = -EBUSY;
>>>   			break;
>>>
>>
>> AFAICS the error is always used as bool, so this will not change any
>> behavior in practice. I tend to think we should not merge this kind of
>> change outside some larger work in the same area, but I'd love a second
>> opinion from the driver owners.
> 
> I missed the original patch due to my procmail filters...
> 
> You're right that it doesn't affect the behavior of the driver except
> for the debug output when we do:
> 
> 	netdev_dbg(adapter->netdev, "Reset failed, rc=%d\n", rc);
> 
> But the - was left off uninitentionally so I think we should apply it.
> 
> I have been trying to look for similar bugs where the - is left off.
> It's a bit challenging because there places where we use positive
> error codes deliberately.  But in this case a static checker could
> easily detect the bug with a low false positive ratio by saying, "We're
> mixing normal negative error codes with positive EBUSY".
> 
> regards,
> dan carpenter

Hello, small clarification, this patch will not effect the debug print 
statement due to the break statement immediately following:
	while () {	
		if () {
			rc = -EBUSY;
			break;
		}
		netdev_dbg(adapter->netdev, "Reset failed, rc=%d\n", rc);
	}
Though this return code can be passed to adapter->reset_done_rc, which 
is only treated as a boolean.

So, the point of the patch not doing any behavioral differences is still 
true.
Personally, I don't have strong opinions on this.
Reviewed-by: Nick Child <nnac123@linux.ibm.com>


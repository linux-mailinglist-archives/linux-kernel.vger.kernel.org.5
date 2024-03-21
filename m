Return-Path: <linux-kernel+bounces-110353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F0F885D9D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66D07281E79
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C1B10782;
	Thu, 21 Mar 2024 16:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e7vK/CND"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9441FA2;
	Thu, 21 Mar 2024 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039031; cv=none; b=DdSLIkWqSQ/ii0Vydi+JX8gzW72i3I4u3H52ZN8InOyhZAb5RUWC+92AhjwOZFeQ+LilI4ljqkh2j3ZaLwFUCNbZ03FzuOfnzsa/0qdrKnjrY3AHYGvwxh/66bnemZFXhXO1tk0tGJ6rOuLKlzfyrMeRUOo1aFqZNj/D1BJgyG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039031; c=relaxed/simple;
	bh=H+X49mgBo/tGpAsbI1/ADCVDDPwFjXTM12dknG8EjJs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UQm9TE4g7wvqws9NqSm2FVsqc0H3tVU3dscu1WOZ45clbYsuVEcMci82QW9yoGHjtPwAJKrasp+38zh4AYPduX2t1FIJ4DKqDY56TCrlcc3ktFXIBmTj7EFykw0O7ASokA4noppJrYGxNDW0oF+nvOq7C+FcYS0zTgpkCiFKZYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e7vK/CND; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42LFppRn012292;
	Thu, 21 Mar 2024 16:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=noF5Z/4P3tWdvqLDRBEcGEenfy6p/hfhy5qZF5Nd16k=;
 b=e7vK/CNDFKaGaiNgv8RXALUNHOgz7zPj4bc4Vu85/R6Q0IojBgB2nIwFrr9Ala3eHdk6
 LKFxmw065WhaxZZHbwcJLBjAxDghc12U0kc/ojbqbnK4ElUQkL4cJCx1it0n5qieGYvM
 8N8WralOzs5x2guh0dGsSKXQ+sRvL30JxSpS73o8eoQp9g2/dmPfeLVeLcMTwWhyMifU
 EpctFjPfQ5sD09S9MIW15NNEgIV2ch7k9gpRKgKtWWzPwsPYlxpIZ7gTgyrRcnk83DQH
 4zxtJJVs+lHXSOLZciupH+DrbQkCGIY/JVnPg3XaY6xzVd2XGQIp0FW6bQHGqpfOdnjQ 2Q== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0nq48gvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 16:36:54 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42LGW8GN002773;
	Thu, 21 Mar 2024 16:36:40 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwrf2wy30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 16:36:40 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42LGab8k16646850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 16:36:39 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB0EF5804B;
	Thu, 21 Mar 2024 16:36:37 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 961A458055;
	Thu, 21 Mar 2024 16:36:36 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Mar 2024 16:36:36 +0000 (GMT)
Message-ID: <cce10484-99cb-4c2e-9768-862fc35a6725@linux.ibm.com>
Date: Thu, 21 Mar 2024 12:36:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/13] Add support for NIST P521 to ecdsa
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        saulo.alessandre@tse.jus.br, bbhushan2@marvell.com
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <ZfiMhi9D2Rhh89BI@wunner.de>
 <d02eda40-2d3a-43a2-a3a9-cb79055acda7@linux.ibm.com>
 <CZXXPKTAUUM9.35VZUFITJWF6A@kernel.org> <Zfp20bLB0onXo7FV@wunner.de>
 <20240320-quirky-truthful-manul-da6eb9@lemur>
 <CZZKAZB5K1PD.2UKMDD28AUCEC@kernel.org>
 <CZZKCJGKVP5N.3GUU48O4Y62KQ@kernel.org>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CZZKCJGKVP5N.3GUU48O4Y62KQ@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WA26ICbuccV_KwjfhoKogfMoU_q1NJEp
X-Proofpoint-GUID: WA26ICbuccV_KwjfhoKogfMoU_q1NJEp
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
 definitions=2024-03-21_10,2024-03-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=783 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403210121



On 3/21/24 12:19, Jarkko Sakkinen wrote:
> On Thu Mar 21, 2024 at 6:17 PM EET, Jarkko Sakkinen wrote:
>> On Wed Mar 20, 2024 at 4:41 PM EET, Konstantin Ryabitsev wrote:
>>> On Wed, Mar 20, 2024 at 06:40:33AM +0100, Lukas Wunner wrote:
>>>> If Herbert applies patches with "b4 am --apply-cover-trailers" or
>>>> "b4 shazam --apply-cover-trailers" (I don't know if he does),
>>>> it is completely irrelevant whether Stefan strips my Tested-by from
>>>> individual patches:  It will automatically be re-added when the
>>>> series gets applied.
>>>
>>> Applying trailers sent to the cover letter is now the default behaviour in
>>> 0.13, so this flag is no longer required (it does nothing).
>>>
>>> -K
>>
>> The whole policy of how to put tested-by in my experience is subsystem
>> dependent.
>>
>> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
>>
>> Official documentation only speaks about patches so perhaps it should
>> then be refined for the series.
>>
>> I'm hearing about this option in b4 for the first time in my life.
> 
> It is also pretty relevant to know when you read the commit log e.g.
> when bisecting what was *actually* tested.
> 
> If you put tested-by to whole series it probably means that you've
> tested the uapi and are getting the expected results. Thus in this
> case it would 13/13 that is *actually* tested.

Btw, we have 2 entry points into the code and those are uapi and testmgr.

So if I was to exercise the uapi with a NIST P521 key then are you 
saying that none of the other code was exercised and therefore wasn't 
tested? How would YOU suggest to test individual patches then?

What the docs at the link above say is this:

A Tested-by: tag indicates that the patch has been successfully tested 
(in some environment) by the person named. This tag informs maintainers 
that some testing has been performed, provides a means to locate testers 
for future patches, and ensures credit for the testers.

Note: 'some testing' 'in some environment'. We probably can reasonably 
assume that not only 13/13 is necessary but also several of the other 
patches are necessary to support this new curve and were exercised with 
either UAPI and probably also testmgr.

> 
> Putting tested-by to every possible patch only degrades the quality
> of the commit log.

I would still be interested how one would test individual patches in a 
series so they are worthy of a Tested-by tag.

> 
> I don't see how this is "irrelevant".
> 
> BR, Jarkko


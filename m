Return-Path: <linux-kernel+bounces-77659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5975886088F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50C91F243DB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AF4B67A;
	Fri, 23 Feb 2024 01:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="rpLhicv4"
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com [136.143.188.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7208F51;
	Fri, 23 Feb 2024 01:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708653378; cv=pass; b=kR4pphUMOTZJAVB30S25wWtTf6bI15ccwfWJv08IZKo+zoPa/kBAY5xgLYHsZsPI5sZox6b5PBLE4SyOnSgQ2NiBSX88pOJPQWKagZyEU9xByoBX3VyX0tXpt0/WI4qLtc6v6YH2IxbcO8mwv1NuAWWOsDVlmFVDG/Girn9tDe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708653378; c=relaxed/simple;
	bh=rOmpfgPczFyunpveKME9oK5dgtJTsHPgtW7n74b+vj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bKPsu/reu4oYiPMxkeEQgj+pufeG79drAhyw43Q2fC6S5XP2kzcRcL5dBorhNEY3K3M8Lf8DLvS2mONGomtEHQoSlz31/l5RRusPag2NVNYPOpba6aaEkYpJKtMmkyATiXmGmyUFQ+ji4RCpXU9Sz9VsFNWHpieO0K1YDW5Yj1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=rpLhicv4; arc=pass smtp.client-ip=136.143.188.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1708653364; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HtpmZZJkHrbE6UjAHVdU+Xz+pJnXomzJkvQw/7UgX9TZP5EsekRUHcVvcNp6P/0GKsoirAZXddM/5Z7TmduKeF9bQXHHusvxQl+W9sx7WPB+kR5L7HaaJYJhOjKuinGROKrkaBnbXVz2OLYJ51FWpvkwohpQA9PegPRvNSdLQSw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1708653364; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yE9cp451YiCyIoaTq1gZiaYvn09rvPorzjEsPmMH2DA=; 
	b=K1r3FC1S/iLotWiqcdAL3Zlk66Oo/xwjkAj4EyAir/i6FYdQmtbKSUZrWTrBE4pk5pogJZc0LHTzSBVdNWFxps5JupAOoD8aSVsNuCQcRt/IBiSQV5tBa8LkHP9lkrqVnVzdb4rvFgPXodtBnnRn01zaZjLS/DySWeChrut6xDw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1708653364;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=yE9cp451YiCyIoaTq1gZiaYvn09rvPorzjEsPmMH2DA=;
	b=rpLhicv47z7UmSYfLZ24zgUpj7b3fgNC/LCgcjMq0+JhPrnvBLkK/8yZ23oKyro7
	n9i3SEQOx1A2OwskLlhxkowxY7EI2aJ+naRGXk4zn7of3AX7kw/dToR8qPqBvK5omjq
	nV+6AKDMHfJX1Zt0CXb2YAdd5SYoXUeqMZEd5U3U=
Received: from [10.10.1.138] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
	with SMTPS id 1708653361636526.7329451671354; Thu, 22 Feb 2024 17:56:01 -0800 (PST)
Message-ID: <f52546f1-acca-4915-924c-cdd2018215d5@apertussolutions.com>
Date: Thu, 22 Feb 2024 20:55:56 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tpm: protect against locality counter underflow
Content-Language: en-US
To: Alexander Steffen <Alexander.Steffen@infineon.com>,
 Lino Sanfilippo <l.sanfilippo@kunbus.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Sasha Levin <sashal@kernel.org>, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Ross Philipson <ross.philipson@oracle.com>,
 Kanth Ghatraju <kanth.ghatraju@oracle.com>, Peter Huewe <peterhuewe@gmx.de>
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
 <20240131170824.6183-2-dpsmith@apertussolutions.com>
 <CYU3CFW08DAA.29DJY7SJYPJJZ@suppilovahvero>
 <2ba9a96e-f93b-48e2-9ca0-48318af7f9b1@kunbus.com>
 <ae3fecc4-7b76-4607-8749-045e17941923@infineon.com>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; keydata=
 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
In-Reply-To: <ae3fecc4-7b76-4607-8749-045e17941923@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 2/20/24 13:42, Alexander Steffen wrote:
> On 02.02.2024 04:08, Lino Sanfilippo wrote:
>> On 01.02.24 23:21, Jarkko Sakkinen wrote:
>>
>>>
>>> On Wed Jan 31, 2024 at 7:08 PM EET, Daniel P. Smith wrote:
>>>> Commit 933bfc5ad213 introduced the use of a locality counter to 
>>>> control when a
>>>> locality request is allowed to be sent to the TPM. In the commit, 
>>>> the counter
>>>> is indiscriminately decremented. Thus creating a situation for an 
>>>> integer
>>>> underflow of the counter.
>>>
>>> What is the sequence of events that leads to this triggering the
>>> underflow? This information should be represent in the commit message.
>>>
>>
>> AFAIU this is:
>>
>> 1. We start with a locality_counter of 0 and then we call 
>> tpm_tis_request_locality()
>> for the first time, but since a locality is (unexpectedly) already active
>> check_locality() and consequently __tpm_tis_request_locality() return 
>> "true".
> 
> check_locality() returns true, but __tpm_tis_request_locality() returns 
> the requested locality. Currently, this is always 0, so the check for 
> !ret will always correctly indicate success and increment the 
> locality_count.
> 
> But since theoretically a locality != 0 could be requested, the correct 
> fix would be to check for something like ret >= 0 or ret == l instead of 
> !ret. Then the counter will also be incremented correctly for localities 
> != 0, and no underflow will happen later on. Therefore, explicitly 
> checking for an underflow is unnecessary and hides the real problem.
> 

My apologies, but I will have to humbly disagree from a fundamental 
level here. If a state variable has bounds, then those bounds should be 
enforced when the variable is being manipulated. Assuming that every 
path leading to the variable manipulation code has ensured proper 
manipulation is just that, an assumption. When assumptions fail is how 
bugs and vulnerabilities occur.

To your point, does this full address the situation experienced, I would 
say it does not. IMHO, the situation is really a combination of both 
patch 1 and patch 2, but the request was to split the changes for 
individual discussion. We selected this one as being the fixes for two 
reasons. First, it blocks the underflow such that when the Secure Launch 
series opens Locality 2, it will get incremented at that time and the 
internal locality tracking state variables will end up with the correct 
values. Thus leading to the relinquish succeeding at kernel shutdown. 
Second, it provides a stronger defensive coding practice.

Another reason that this works as a fix is that the TPM specification 
requires the registers to be mirrored across all localities, regardless 
of the active locality. While all the request/relinquishes for Locality 
0 sent by the early code do not succeed, obtaining the values via the 
Locality 0 registers are still guaranteed to be correct.

v/r,
dps


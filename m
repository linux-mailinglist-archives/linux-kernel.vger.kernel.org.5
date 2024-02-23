Return-Path: <linux-kernel+bounces-77665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 935A286089F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0A02860AC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D88ABA46;
	Fri, 23 Feb 2024 01:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="ua7nBwCQ"
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com [136.143.188.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28355B67A;
	Fri, 23 Feb 2024 01:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708653474; cv=pass; b=cqKglhOwDT+U3tJbNne54IWEKczrowNr5qPYOiRXzEKfPYtMpd8woofOBol8vI5oLs6pzAMTYQul+UsgaR5Rmv9tzmTqAXYsLaDyovCY0Dyaqzf0ZCZ9IBzO32RyZsvdalZsboeNe+ebyhtiJPOSYPli67/VEHc1sb+BSSkPjzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708653474; c=relaxed/simple;
	bh=wKt9TWsjT+lr1kc6jT6JYidAyFIURT7TMzy+9BW6TME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qt7ehyWfjT9cNlwYmkS9MZaIx5vuyno7UZLIoUZdzZ6KNBYvOT4S2kZWxAPtu5fodM55sl5oheMW53B0YDkyGAEKd8Ut/zpbEU1jt1JNSytaRTyA6VVjF884S7uv34tKXpUjzIDcclFuIvTtckroNIpg2ffpAcx9QqwGwmwZfcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=ua7nBwCQ; arc=pass smtp.client-ip=136.143.188.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1708653454; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=P+Nd9UN4xMws5QaT1qfiryGD9f1L/7zCOQ8HrEIdN/RKJkBxk1ydm7GDIpJD9wm9Nj+dbel1pV3otEbFLjYeByOBDn80j4yFl2BxWODxn+4W3cBGGDEHPq8xJeg0yM6NA7uowXBDgoG+fZcD+5c4eMHJp1JZGhW6yMW7tpw06ig=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1708653454; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eXyfAKyX45gaKkLAQFL5J6gskv64r13L4cRcWKXfxT0=; 
	b=YC1WRQztb/hN235YpIombhXNqclIUKZv72XsuuajPCTeuFBEIbY8Rj7B7PijE51oDFkDqExhOFtUvNaavFb5OntwHaIu8ctLkRkf2P7duwOGF5+1J2IcrBdaZIU6c0UXj7ita92Az2D+Ya5C+S4KVLaqZbYB771ZuBu6kfqhWPY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1708653454;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=eXyfAKyX45gaKkLAQFL5J6gskv64r13L4cRcWKXfxT0=;
	b=ua7nBwCQ6I36uu2rS+W0ZRUjXobpi1th7ASp1AoIoFR4xBtoSAjG93A/SKcFDB5M
	0Yp4jvuyMg9Ncz/0taIgitlbDw9FjaVr1PYXTD4pof7xuFXvmnRSXW56g0yA2rafrbV
	OMRec7fzV1Z8ivnHjai3A+Q8qu9JmeX7oPpckfys=
Received: from [10.10.1.138] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
	with SMTPS id 1708653453544363.34283143327457; Thu, 22 Feb 2024 17:57:33 -0800 (PST)
Message-ID: <f1a54774-9a44-4400-91e2-358facc12191@apertussolutions.com>
Date: Thu, 22 Feb 2024 20:57:30 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tpm: protect against locality counter underflow
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Lino Sanfilippo <l.sanfilippo@kunbus.com>,
 Alexander Steffen <Alexander.Steffen@infineon.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Sasha Levin <sashal@kernel.org>,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ross Philipson <ross.philipson@oracle.com>,
 Kanth Ghatraju <kanth.ghatraju@oracle.com>, Peter Huewe <peterhuewe@gmx.de>
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
 <20240131170824.6183-2-dpsmith@apertussolutions.com>
 <CYU3CFW08DAA.29DJY7SJYPJJZ@suppilovahvero>
 <2ba9a96e-f93b-48e2-9ca0-48318af7f9b1@kunbus.com>
 <ae3fecc4-7b76-4607-8749-045e17941923@infineon.com>
 <91f600ef-867b-4523-89be-1c0ba34f8a4c@kunbus.com>
 <CZA9CM3PDILC.82JMLUWMB6B7@seitikki> <CZA9GMC718HA.1JFHTTWV563IE@seitikki>
 <7a7f8f0c1b9d124bfc01b66082abf2d8445564ce.camel@HansenPartnership.com>
 <CZB0I9OAGNHT.1HTSJU3925RBY@seitikki>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; keydata=
 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
In-Reply-To: <CZB0I9OAGNHT.1HTSJU3925RBY@seitikki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 2/21/24 14:43, Jarkko Sakkinen wrote:
> On Wed Feb 21, 2024 at 12:37 PM UTC, James Bottomley wrote:
>> On Tue, 2024-02-20 at 22:31 +0000, Jarkko Sakkinen wrote:
>>>
>>> 2. Because localities are not too useful these days given TPM2's
>>>     policy mechanism
>>
>> Localitites are useful to the TPM2 policy mechanism.  When we get key
>> policy in the kernel it will give us a way to create TPM wrapped keys
>> that can only be unwrapped in the kernel if we run the kernel in a
>> different locality from userspace (I already have demo patches doing
>> this).
> 
> Let's keep this discussion in scope, please.
> 
> Removing useless code using registers that you might have some actually
> useful use is not wrong thing to do. It is better to look at things from
> clean slate when the time comes.
> 
>>>   I cannot recall out of top of my head can
>>>     you have two localities open at same time.
>>
>> I think there's a misunderstanding about what localities are: they're
>> effectively an additional platform supplied tag to a command.  Each
>> command can therefore have one and only one locality.  The TPM doesn't
> 
> Actually this was not unclear at all. I even read the chapters from
> Ariel Segall's yesterday as a refresher.
> 
> I was merely asking that if TPM_ACCESS_X is not properly cleared and you
> se TPM_ACCESS_Y where Y < X how does the hardware react as the bug
> report is pretty open ended and not very clear of the steps leading to
> unwanted results.
> 
> With a quick check from [1] could not spot the conflict reaction but
> it is probably there.

The expected behavior is explained in the Informative Comment of section 
6.5.2.4 of the Client PTP spec[1]:

"The purpose of this register is to allow the processes operating at the 
various localities to share the TPM. The basic notion is that any 
locality can request access to the TPM by setting the 
TPM_ACCESS_x.requestUse field using its assigned TPM_ACCESS_x register 
address. If there is no currently set locality, the TPM sets current 
locality to the requesting one and allows operations only from that 
locality. If the TPM is currently at another locality, the TPM keeps the 
request pending until the currently executing locality frees the TPM. 
Software relinquishes the TPM’s locality by writing a 1 to the 
TPM_ACCESS_x.activeLocality field. Upon release, the TPM honors the 
highest locality request pending. If there is no pending request, the 
TPM enters the “free” state."

>> submission).   I think the locality request/relinquish was modelled
>> after some other HW, but I don't know what.
> 
> My wild guess: first implementation was made when TPM's became available
> and there was no analytical thinking other than getting something that
> runs :-)

Actually, no that is not how it was done. IIRC, localities were designed 
in conjunction with D-RTM when Intel and MS started the LeGrande effort 
back in 2000. It was then generalized for the TPM 1.1b specification. My 
first introduction to LeGrande/TXT wasn't until 2005 as part of an early 
access program. So most of my historical understanding is from 
discussions I luckily got to have with one of the architects and a few 
of the original TCG committee members.

[1] 
https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p05p_r14_pub.pdf

v/r,
dps


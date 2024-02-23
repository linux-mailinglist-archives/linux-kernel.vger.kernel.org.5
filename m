Return-Path: <linux-kernel+bounces-77666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A288608A1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9DC72860CD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234CEB673;
	Fri, 23 Feb 2024 01:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="E0kby1gR"
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com [136.143.188.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7663209;
	Fri, 23 Feb 2024 01:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708653536; cv=pass; b=R61wdvOrMDvliqjCL7xfVtRT6v5at+Nwk38jLRKSLp/7JlTQDC/k3Gl3WnxNmWPYoAqO31XUu3TggTRU13zMz30I4YhjbIsJFxoPFtf8NbMOsXWiHgWgdC9TF3N1cJtyRAN4SCVHR6oRU3SPWC+rVwN6Wp7Sf4l/5NVX6maM0FE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708653536; c=relaxed/simple;
	bh=5WSYiRG0da1c48/HAqdyQzrAWeMUGqbq0I7r1FGiB2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7rxkQorG4aUoejdfFwCgPcapive1diXxMWzXhG/KqbepwDm2dD1gWAVk4w+FNxcKATEI20iUdr2sMWSG3nXjB0StnOeckNW5yxbMU5d8Rn3Y3AzaaN83Bk982VsOLR6fhg7a3H5cYlzqXmAsafrzA09wBWUJpdLge/+R3iA5Uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=E0kby1gR; arc=pass smtp.client-ip=136.143.188.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1708653524; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cjiEo2im1vcFKw2Q1SOdLZUt4fE9dUoL84U3+dTryleoXrqMP/ddTUAavE4mBzY8QCP2F9XvFB3zDq0urQvxmp/1pDOhj8O/ngiw1YFq8vv6fsWgqmFQqtWlC3CFk/xwfFlsz/oZAnPK98Il3noFIe+YXM6fuzQWoI9lq6HOjBQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1708653524; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0c/9UXs3DUULMzn59Y2UYaZS5a9by2Pn5MZ9zDCNofc=; 
	b=TGvkGcZfXFDdEUU+5h/felsDdkuBNL9QRckJMK7ZDXP3YOaeG2N0Mrmfo3Q/y5xjVumMZzSKzDtLEbZwvjA3lMVQ4gxtg1SVwNKJIMN+YfYiMRZwS3qNTeDtALJXhBpevkizimQRl846PbtBv0f7UvV8l9N90JakFqF78vOSaq4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1708653524;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=0c/9UXs3DUULMzn59Y2UYaZS5a9by2Pn5MZ9zDCNofc=;
	b=E0kby1gRBtS+r+5qRZAKkD77mQH5+7O7TNPBYqtdZ2urCmuFvXtWv3icZhBjISm/
	IOYZuBTMfNy5OJ20r6q/FNetjloXoreSlppBP7V4O80lQMe3/caf0SIkt08bPWbTUvc
	2Is16gaXyiv/QP2528TJY9/8wEJppM2w7G4NA9rM=
Received: from [10.10.1.138] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
	with SMTPS id 1708653523228943.4732868395558; Thu, 22 Feb 2024 17:58:43 -0800 (PST)
Message-ID: <88b75c9c-98ab-4474-8112-6a27d11a2fdf@apertussolutions.com>
Date: Thu, 22 Feb 2024 20:58:40 -0500
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
 <CZA9ADCGOTQT.LB5XHZZVTWVH@seitikki>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; keydata=
 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
In-Reply-To: <CZA9ADCGOTQT.LB5XHZZVTWVH@seitikki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 2/20/24 17:23, Jarkko Sakkinen wrote:
> On Tue Feb 20, 2024 at 8:54 PM UTC, Lino Sanfilippo wrote:
>> Hi,
>>
>> On 20.02.24 19:42, Alexander Steffen wrote:
>>> ATTENTION: This e-mail is from an external sender. Please check attachments and links before opening e.g. with mouseover.
>>>
>>>
>>> On 02.02.2024 04:08, Lino Sanfilippo wrote:
>>>> On 01.02.24 23:21, Jarkko Sakkinen wrote:
>>>>
>>>>>
>>>>> On Wed Jan 31, 2024 at 7:08 PM EET, Daniel P. Smith wrote:
>>>>>> Commit 933bfc5ad213 introduced the use of a locality counter to control when a
>>>>>> locality request is allowed to be sent to the TPM. In the commit, the counter
>>>>>> is indiscriminately decremented. Thus creating a situation for an integer
>>>>>> underflow of the counter.
>>>>>
>>>>> What is the sequence of events that leads to this triggering the
>>>>> underflow? This information should be represent in the commit message.
>>>>>
>>>>
>>>> AFAIU this is:
>>>>
>>>> 1. We start with a locality_counter of 0 and then we call tpm_tis_request_locality()
>>>> for the first time, but since a locality is (unexpectedly) already active
>>>> check_locality() and consequently __tpm_tis_request_locality() return "true".
>>>
>>> check_locality() returns true, but __tpm_tis_request_locality() returns
>>> the requested locality. Currently, this is always 0, so the check for
>>> !ret will always correctly indicate success and increment the
>>> locality_count.
>>>
>>
>> Will the TPM TIS CORE ever (have to) request another locality than 0? Maybe the best would
>> be to hardcode TPM_ACCESS(0) and get rid of all the locality parameters that are
>> passed from one function to another.
> 
> Usually, or at least use cases I'm aware of, localities are per
> component. E.g. Intel TXT has one and Linux has another.
> 
> There's been some proposals in the past here for hypervisor specific
> locality here at LKML they didn't lead to anything.
> 
> If you are suggesting of removing "int l" parameter altogether, I
> do support that idea.
> 
>> But this is rather code optimization and not really required to fix
>> the reported bug.
> 
> Just adding here that I wish we also had a log transcript of bug, which
> is right now missing. The explanation believable enough to move forward
> but I still wish to see a log transcript.

That will be forth coming.

v/r,
dps


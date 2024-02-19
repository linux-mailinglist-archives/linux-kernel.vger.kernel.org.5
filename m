Return-Path: <linux-kernel+bounces-71969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B392685AD30
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BC47284A47
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F6B53E15;
	Mon, 19 Feb 2024 20:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="hzgKBnKb"
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com [136.143.188.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D06B53E1B;
	Mon, 19 Feb 2024 20:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708374582; cv=pass; b=J/bcvERMz/a4KRNi9G7OFqy5MFZ3Y+dQj/3tgn4DDohTzo1H+1fsCG3wRbUastCuU/enYPZRZ2vnpkE4NQ1P39HedeucJw0674V+fC4BmAB93I/NPXqGF22NnW5gy3TcoGs29CGUlc8v8OLFY0nLQLHhKTnh+15sz1t4RkzTZqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708374582; c=relaxed/simple;
	bh=5r+FH+xJcJw68YN287eDIkroaDkBbUxD+MyKyHsVW7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQ2QicbxUi9HctmkAdiRkf6IdKUS03wfSR23wzTY7yEy0X3CpnLfzalzt1XaVb8ZZueo2wakmh2Y6B/zn2GC5jYs/WjPJ1QKdSLtR/NwEZgH6jq4j7OtO7ZO015Cq5QEIisXoRkVS46/ntMzWulvBFAZGwldAu0xU3SoRl8emc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=hzgKBnKb; arc=pass smtp.client-ip=136.143.188.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1708374574; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=REBRurB8sTr1GvhQ1PGNUmKC+DnBGSfbVUm36ygOzwcvAqj7CIIFigr6P2rAiLPLbuPn9Vtz7QhqMex8Cji4h5IyJV/kYEb+/aYsbiF9xUB0jip5YIR2YV8HPJdcKV5X7Q6fC1ZDfWttugkQwOJ7+nLwxcnlYimtyLgOxPIvF+A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1708374574; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hp4HzNxrv26J8xt1Zh7DsPuR7l5zajFvgi/ANo/IF4Q=; 
	b=eGe84rfhNz9DEKAkvz5Nr7Bi4KkqqjbhKW/LtjVSAkRd8NzHJ/OzdbPzefzT9pyh5t4O8Vuy7u1KloGy/WF2Cq0qnnsK7RKCbGtddKi9ZrkBuWXiH6gzEvnXACDdB1Vjqm9zvz0lJ2eubepcn0A2s3Q/Dw4j1KQ5KodSGS+3E6w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1708374574;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=hp4HzNxrv26J8xt1Zh7DsPuR7l5zajFvgi/ANo/IF4Q=;
	b=hzgKBnKbYXKwAX8BxmUbG72PQugPVdPrAoRNOiJ44ciR+4hKogZ0rzd1+b5/3HD5
	EAWvY/9Lu4UPCHImQxMqbE+d1nJdfSwudAkg6ckJx6z0cPb4SePMjoKxGWrXKqodA/W
	p9COIay8Ub6P3VvUyO9PmMfyiCTzACSzd5E1SbYo=
Received: from [10.10.1.138] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
	with SMTPS id 1708374572031563.5917402792816; Mon, 19 Feb 2024 12:29:32 -0800 (PST)
Message-ID: <80d95a08-a1c1-44a7-959c-8bff14254608@apertussolutions.com>
Date: Mon, 19 Feb 2024 15:29:30 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tpm: make locality request return value consistent
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ross Philipson <ross.philipson@oracle.com>,
 Peter Huewe <peterhuewe@gmx.de>
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
 <20240131170824.6183-4-dpsmith@apertussolutions.com>
 <CYU3XUGOX6QT.1GL070ONNPBWQ@suppilovahvero>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; keydata=
 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
In-Reply-To: <CYU3XUGOX6QT.1GL070ONNPBWQ@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 2/1/24 17:49, Jarkko Sakkinen wrote:
> On Wed Jan 31, 2024 at 7:08 PM EET, Daniel P. Smith wrote:
>> The function tpm_tis_request_locality() is expected to return the locality
>> value that was requested, or a negative error code upon failure. If it is called
>> while locality_count of struct tis_data is non-zero, no actual locality request
>> will be sent. Because the ret variable is initially set to 0, the
>> locality_count will still get increased, and the function will return 0. For a
>> caller, this would indicate that locality 0 was successfully requested and not
>> the state changes just mentioned.
>>
>> Additionally, the function __tpm_tis_request_locality() provides inconsistent
>> error codes. It will provide either a failed IO write or a -1 should it have
>> timed out waiting for locality request to succeed.
>>
>> This commit changes __tpm_tis_request_locality() to return valid negative error
>> codes to reflect the reason it fails. It then adjusts the return value check in
>> tpm_tis_request_locality() to check for a non-negative return value before
>> incrementing locality_cout. In addition, the initial value of the ret value is
>> set to a negative error to ensure the check does not pass if
>> __tpm_tis_request_locality() is not called.
> 
> This is way way too abtract explanation and since I don't honestly
> understand what I'm reading, the code changes look bunch of arbitrary
> changes with no sound logic as a whole.

In more simpler terms, the interface is inconsistent with its return 
values. To be specific, here are the sources for the possible values 
tpm_tis_request_locality() will return:
1. 0 - 4: _tpm_tis_request_locality() was able to set the locality
2. 0: a locality already open, no locality request made
3. -1: if timeout happens in __tpm_tis_request_locality()
4. -EINVAL: unlikely, return by IO write for incorrect sized write

As can easily be seen, tpm_tis_request_locality() will return 0 for both 
a successful(1) and non-successful request(2). And to be explicit for 
(2), if tpm_tis_request_locality is called for a non-zero locality and 
the locality counter is not zero, it will return 0. Thus, making the 
value 0 reflect as success when locality 0 is successfully requested and 
as failure when a locality is requested with a locality already open.

As for failures, correct me if I am wrong, but if a function is 
returning negative error codes, it should not be using a hard coded -1 
as a generic error code. As I note, it is unlikely for the -EINVAL to be 
delivered, but the code path is still available should something in the 
future change the backing call logic.

After this change, the possible return values for 
tpm_tis_request_locality() become:
1. 0 - 4: the locality that was successfully requested
2. -EBUSY: tpm busy, unable to request locality
3. -EINVAL: invalid parameter

With this more consistent interface, I updated the return value checks 
at the call sites to check for negative error as the means to catch 
failures.

v/r,
dps


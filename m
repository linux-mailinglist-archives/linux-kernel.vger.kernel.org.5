Return-Path: <linux-kernel+bounces-71784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B9F85AA6A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B2BB2857E8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA2347F67;
	Mon, 19 Feb 2024 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="g0DvvJjY"
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com [136.143.188.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D0847F50;
	Mon, 19 Feb 2024 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708365271; cv=pass; b=Giftd2nbO/8zEk4wDXn6KuTj33uCe1JfbQzLS1j0xEmzcbuzEHaPj19IdKgoyILlg5X8/1GLkiuiya4qcsEgtGESLxkx5Q3I6/oXM+LO2r7lIMr+SYhtfHde+m01vHEue7Ziq+jhAZ7KDg3u1BTlEPTgAqk+zIBffgOZXMdasc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708365271; c=relaxed/simple;
	bh=+vBgROQpUxhsS+8mG0Uu59VmhE/8dycc2dSyGObDGfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qeRLc14X8YFn9Ab8oBavvknj7yL+RW8Bd+TrnyY1GjWw0RQnwSag+GzrDQxYo1yZCgJcecWm+omucIAMSsT/ASO1YGDU6GTvuYd7NN3kl8wufSHkFZT32tX2OEC6rOC1JcnNTZC3s4WwJW4QmGXR9jD6fS4JvH6oWl5iz+UqvcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=g0DvvJjY; arc=pass smtp.client-ip=136.143.188.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1708365259; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Gr732xqzNbkW1WygKqiHg6iJNcKcrTaYqEskI1ux2iTkM6sArjM0EHp+lR0HxIEf8kt7hExfxCGS1IuRdzHvTVy8waCX+Es2V1FLIyHo8/pqIZDADxnvg/v8ZwoO3uym/86PMwoQEkR3e/jA9qEv2lAh02xntqPBw7Hzj4TJqgs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1708365259; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/SKbO8D/5N0nuzzKcMzPKSUmoio8F0MoSuF1jGCxm4Q=; 
	b=XcmD3tE0V9D0MiGTq4n8Rw5QFnGVBkeT3TOn32hbC66FUQGyx5d6bVxUiJlanu2LqgI87fBMfPz8AzOoBAT/CZpoRXfFwRvH5PamhlXExJpOziucVdLIJ7h7FzbkYxLENVwJnl5rZ/eLrh4ZNBnsc527FcdAUhdPJFCdLIaUcoE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1708365259;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=/SKbO8D/5N0nuzzKcMzPKSUmoio8F0MoSuF1jGCxm4Q=;
	b=g0DvvJjYdLBH6JoN43Eojn1EvwXsg8n1LKtPp3mG3k+Ti5YDf69YP85isWYqtYCa
	4dsRHRSaGwSyASgRP9lNEihJ1ioTy4f4hahNtekwsvgrdtm9de3cTAW/hMFu9MVj9it
	0vFz+7Z7NsttupcXJx/683zIj0AfovmrSA7aOUqc=
Received: from [10.10.1.138] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
	with SMTPS id 1708365259034862.7927012571332; Mon, 19 Feb 2024 09:54:19 -0800 (PST)
Message-ID: <439b7663-233d-46c3-9925-9b830833aa4f@apertussolutions.com>
Date: Mon, 19 Feb 2024 12:54:16 -0500
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
 Lino Sanfilippo <l.sanfilippo@kunbus.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Sasha Levin <sashal@kernel.org>, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Ross Philipson <ross.philipson@oracle.com>,
 Kanth Ghatraju <kanth.ghatraju@oracle.com>, Peter Huewe <peterhuewe@gmx.de>
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
 <20240131170824.6183-2-dpsmith@apertussolutions.com>
 <CYU3CFW08DAA.29DJY7SJYPJJZ@suppilovahvero>
 <2ba9a96e-f93b-48e2-9ca0-48318af7f9b1@kunbus.com>
 <CZ3DCC8JHNLK.3MGE70MQJT5XM@kernel.org>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; keydata=
 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
In-Reply-To: <CZ3DCC8JHNLK.3MGE70MQJT5XM@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 2/12/24 15:05, Jarkko Sakkinen wrote:
> On Fri Feb 2, 2024 at 5:08 AM EET, Lino Sanfilippo wrote:
>>
>>
>> On 01.02.24 23:21, Jarkko Sakkinen wrote:
>>
>>>
>>> On Wed Jan 31, 2024 at 7:08 PM EET, Daniel P. Smith wrote:
>>>> Commit 933bfc5ad213 introduced the use of a locality counter to control when a
>>>> locality request is allowed to be sent to the TPM. In the commit, the counter
>>>> is indiscriminately decremented. Thus creating a situation for an integer
>>>> underflow of the counter.
>>>
>>> What is the sequence of events that leads to this triggering the
>>> underflow? This information should be represent in the commit message.
>>>
>>
>> AFAIU this is:
>>
>> 1. We start with a locality_counter of 0 and then we call tpm_tis_request_locality()
>> for the first time, but since a locality is (unexpectedly) already active check_locality() and consequently
>> __tpm_tis_request_locality() return "true". This prevents the locality_counter from being increased
>> to 1, see
>>
>> 	ret = __tpm_tis_request_locality(chip, l);
>> 	if (!ret) /* Counter not increased since ret == 1 */
>> 		priv->locality_count++;
>>
>> in tpm_tis_request_locality().
>>
>> If now the locality is released the counter is decreased to below zero (resulting
>> in an underflow since "locality_counter" is an unsigned int.
> 
> Thanks, Daniel, can you transcript this to the commit message?

ack

v/r,
dps


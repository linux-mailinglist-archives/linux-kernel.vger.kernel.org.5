Return-Path: <linux-kernel+bounces-80042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2154A862A11
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 12:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0BAB1F2155C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 11:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C661078B;
	Sun, 25 Feb 2024 11:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="bj/mDHYi"
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com [136.143.188.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDB1DDDF;
	Sun, 25 Feb 2024 11:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708860219; cv=pass; b=nxY9boCLzMIGMnYBOJdzYH06PKutrtmK7/krFtY5HZkbTFqP8jntnQ0zvvkR3Z5xzCJV9XZd1QmuS8S6k8LTMF34HnurBdMfXm0oylf3zJdnqeOX38AxjD25DoGEXfeNm7Focww7v16tzzACYPVII4d//Sm70bLgiGhTT1+kUUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708860219; c=relaxed/simple;
	bh=kzsJOSbdO9aCNroEz/CW0AsE5F4Ewh3SNdXG8BVHGJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ROVui6SttoCx7vqYGKK22QiOsxe1lpyAG8SdtG8QEuojucTG9oodFI8f0c1wuEh2AYbqakOKQE6IRheQ8IWB6gxVutpPtQzYeu87jguNA/cSe6H0yxZbK8bvDkNnE6HNWfktDkhgyh+N2+lN/A1EylJZywncSkWocJosYE8Mrw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=bj/mDHYi; arc=pass smtp.client-ip=136.143.188.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1708860204; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cKz2B5fRi/61Qzy519l5Xxy7AcPV/OPTWEiigBJPKAPyp1Ggs5fLKMcs/CLNbIODAW5r40zqF5XorVeaRKqfADp+UcM8SjFq0CIhbZCtTcm+zOLUuCff1x2TBjfSDc2GjutF7ptN41z0GtpodGx5hWyOqszszoWMYg0m1gE5VqE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1708860204; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wfGoqZDkKgvNv8khUbgxCQPjnWH1gdlTXy979s/5nUg=; 
	b=B/SrW+JNxEnkFylMLVss30/YsNShVCHXdUuukDG7xVYiLdCGt3y7Y0Xo/q7tUdYgM5JwW2cd3/ajodtMn2IqbAqMNXT8Tr3GaM2nVfrBGvU+UAiApIp4zrwFINQWBHlE9SYPtDm71VqiuFPvqj2/uJXLx0gkCac7GDOyM8lavfk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1708860204;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=wfGoqZDkKgvNv8khUbgxCQPjnWH1gdlTXy979s/5nUg=;
	b=bj/mDHYit8XjJY2O2rEePk9H/E6SR2P4LqdM+hvx3B44c+uWiqUvOK7YyJmFvVAl
	D9pwjuqxAEwHEJFzXmoJv5rNhCC5RVjoHJqB5L/poM4ci35G1OUfLt/aJVfsrcgE6jA
	xCVIP7e22AqA1ogTCkkSysXCwDNAwq+8LWZaYH14=
Received: from [10.10.1.126] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
	with SMTPS id 170886020157550.311343935882974; Sun, 25 Feb 2024 03:23:21 -0800 (PST)
Message-ID: <44267c53-496d-4e41-896a-623673d938cb@apertussolutions.com>
Date: Sun, 25 Feb 2024 06:23:13 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tpm: protect against locality counter underflow
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
 <88b75c9c-98ab-4474-8112-6a27d11a2fdf@apertussolutions.com>
 <CZCH5V83WBBV.20JR0RC1GJVJY@suppilovahvero>
Content-Language: en-US
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
In-Reply-To: <CZCH5V83WBBV.20JR0RC1GJVJY@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 2/23/24 07:58, Jarkko Sakkinen wrote:
> On Fri Feb 23, 2024 at 3:58 AM EET, Daniel P. Smith wrote:
>>> Just adding here that I wish we also had a log transcript of bug, which
>>> is right now missing. The explanation believable enough to move forward
>>> but I still wish to see a log transcript.
>>
>> That will be forth coming.
> 
> I did not respond yet to other responses that you've given in the past
> 12'ish hours or so (just woke up) but I started to think how all this
> great and useful information would be best kept in memory. Some of it
> has been discussed in the past but there is lot of small details that
> are too easily forgotten.
> 
> I'd think the best "documentation" approach here would be inject the
> spec references to the sites where locality behaviour is changed so
> that it is easy in future cross-reference them, and least of risk
> of having code changes that would break anything. I think this way
> all the information that you provided is best preserved for the
> future.
> 
> Thanks a lot for great and informative responses!

No problem at all.

Here is a serial output[1] from a dynamic launch using Linux Secure 
Launch v7[2] with one additional patch[3] to dump TPM driver state.

[1] https://paste.debian.net/1308538/
[2] 
https://lore.kernel.org/lkml/scpu273f2mprr2uvjlyk2xrjjtcduhse2eb45lmj7givn6jh4u@i2v4f2vbldu4/T/
[3] https://paste.debian.net/1308539/


Return-Path: <linux-kernel+bounces-77662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A239186089B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB694285FE8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17438B67A;
	Fri, 23 Feb 2024 01:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="ImOABhn/"
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com [136.143.188.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9312E8F47;
	Fri, 23 Feb 2024 01:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708653455; cv=pass; b=FE/std86L7LuVY2cvL2cOohkoZ6vGaFbq5BGPDkAR2cPInRxsQNEbHcEmMXc/X2rfov8zcSRDHtGjH57KFltwMJr3tPkUOL4PTppeWTSQxLFWy+k8XrYeFpCn+J9s02zxV+siik1OkMSQTqjVV0vnM5L7w6ivMib4i65oGXtXLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708653455; c=relaxed/simple;
	bh=RkUsM3fNOCtog7XcwMdV1gd96Z13HZ/Xrl643qL3DAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aeG0V/B870x90j7Qh6s7zMN1ePh6ucJkYiLC51vdbMDZGQM+4CCS+k3iBzefBQ0o2OeoPdlkmK6oBG9oX5uqYNRYpioz8JwzCDOjnGVCHxCbWt9QUaT8aOyEKpuo641cwvrqfbc8j08qHwU4TDc5hYz3oMgV6cM1dYOcgNwP85I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=ImOABhn/; arc=pass smtp.client-ip=136.143.188.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1708653442; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UKyCxC6Gse0jNLVyIMV1Qx9jl+ypgotuJKWRsmJCkUnYRK4DiqPeVvWulupVNUSiSrNb6oWHk7wkr2WBM1JbfsfW9+ueI5RlS9XA5m2CWCX47155CHouM1KLHLLHPXA5oY57tB+GRSM5wxNdvNXfE/wRIpm8CbrdFcdW6n5MGnI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1708653442; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Y7E+chi1nvWxrS7rFKuiU+WNN30bUQPf5eQwnF+3sPY=; 
	b=mi0bzc41/h7uMY23CvivjwqjSMtDBbx3Sgcb9plsTLEsojtlo6qHmZWPq4u9DTJ0CSmQ1qJn8YEBamL4AhNYgQnf9lxo29f/R9kUnFEwHQAUr7ME0Rc6kLfBQwbSoudMwdo+oLw2urmo+UnAF7s/C/ej6JtFs0ocyDmohdh5jCY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1708653442;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Y7E+chi1nvWxrS7rFKuiU+WNN30bUQPf5eQwnF+3sPY=;
	b=ImOABhn/GwEvtD74IR1YfvvtQmVLvBqQUgavhUkct+/F4DwldSms/D21P3qgIG4O
	a5CeWeooq4CLSAm2Lv/l/tWJeSE8asxkm3xs70qsjwgPtH+mWfiO6KM2SnalY0Ibr8W
	ZnVX+M/xN+EX8TR/vcKdW3oLMEcJnr6DDB2XoPy4=
Received: from [10.10.1.138] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
	with SMTPS id 1708653441133802.0510915008789; Thu, 22 Feb 2024 17:57:21 -0800 (PST)
Message-ID: <4bd31b91-1f6a-4081-9ad8-e5fae29d0dd7@apertussolutions.com>
Date: Thu, 22 Feb 2024 20:57:18 -0500
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
 <CZA9CM3PDILC.82JMLUWMB6B7@seitikki> <CZA9GMC718HA.1JFHTTWV563IE@seitikki>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; keydata=
 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
In-Reply-To: <CZA9GMC718HA.1JFHTTWV563IE@seitikki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 2/20/24 17:31, Jarkko Sakkinen wrote:
> On Tue Feb 20, 2024 at 10:26 PM UTC, Jarkko Sakkinen wrote:
>> On Tue Feb 20, 2024 at 8:54 PM UTC, Lino Sanfilippo wrote:
>>> for (i = 0; i <= MAX_LOCALITY; i++)
>>> 	__tpm_tis_relinquish_locality(priv, i);
>>
>> I'm pretty unfamiliar with Intel TXT so asking a dummy question:
>> if Intel TXT uses locality 2 I suppose we should not try to
>> relinquish it, or?
>>
>> AFAIK, we don't have a symbol called MAX_LOCALITY.
> 
> OK it was called TPM_MAX_LOCALITY :-) I had the patch set applied
> in one branch but looked up with wrong symbol name.
> 
> So I reformalize my question to two parts:
> 
> 1. Why does TXT leave locality 2 open in the first place? I did
>     not see explanation. Isn't this a bug in TXT?

It does so because that is what the TCG D-RTM specification requires. 
See Section 5.3.4.10 of the TCG D-RTM specification[1], the first 
requirement is, "The DLME SHALL receive control with access to Locality 2."

> 2. Because localities are not too useful these days given TPM2's
>     policy mechanism I cannot recall out of top of my head can
>     you have two localities open at same time. So what kind of
>     conflict happens when you try to open locality 0 and have
>     locality 2 open?

I would disagree and would call your attention to the TCG's 
definition/motivation for localities, Section 3.2 of Client PTP 
specification[2].

"“Locality” is an assertion to the TPM that a command’s source is 
associated with a particular component. Locality can be thought of as a 
hardware-based authorization. The TPM is not actually aware of the 
nature of the relationship between the locality and the component. The 
ability to reset and extend notwithstanding, it is important to note 
that, from a PCR “usage” perspective, there is no hierarchical 
relationship between different localities. The TPM simply enforces 
locality restrictions on TPM assets (such as PCR or SEALed blobs)."

As stated, from the TPM specification perspective, it is not aware of 
this mapping to components and leaves it to the platform to enforce.

"The protection and separation of the localities (and therefore the 
association with the associated components) is entirely the 
responsibility of the platform components. Platform components, 
including the OS, may provide the separation of localities using 
protection mechanisms such as virtual memory or paging."

The x86 manufactures opted to adopt the D-RTM specification which 
defines the components as follows:

Locality 4: Usually associated with the CPU executing microcode. This is 
used to establish the Dynamic RTM.
Locality 3: Auxiliary components. Use of this is optional and, if used, 
it is implementation dependent.
Locality 2: Dynamically Launched OS (Dynamic OS) “runtime” environment.
Locality 1: An environment for use by the Dynamic OS.
Locality 0: The Static RTM, its chain of trust and its environment.

And the means to protect and separate those localities are encoded in 
the x86 chipset, i.e A D-RTM Event must be used to access any of the 
D-RTM Localities (Locality1 - Locality4).

For Intel, Locality 4 can only be accessed when a dedicated signal 
between the CPU and the chipset is raised, thus only allowing the CPU to 
utilize Locality 4. The CPU will then close Locality 4, authenticate and 
give control to the ACM with access to Locality 3. When the ACM is 
complete, it will instruct the chipset to lock Locality 3 and give 
control to the DLME (MLE in Intel parlance) with Locality 2 open. It is 
up to the DLME, the Linux kernel in this case, to decide how to assign 
components to Locality 1 and 2.

As to proposals to utilize localities by the Linux kernel, the only one 
I was aware of was dropped because they couldn't open the higher localities.

I would also highlight that the D-RTM implementation guide for Arm 
allows for a hardware D-RTM event, which the vendor may choose to 
implement a hardware/CPU enforced access to TPM localities. Thus, the 
ability to support localities will also become a requirement for certain 
Arm CPUs.

[1] 
https://trustedcomputinggroup.org/wp-content/uploads/TCG_D-RTM_Architecture_v1-0_Published_06172013.pdf
[2] 
https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p05p_r14_pub.pdf


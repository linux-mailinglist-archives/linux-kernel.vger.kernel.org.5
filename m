Return-Path: <linux-kernel+bounces-73816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 494ED85CBF3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD583282EC2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF86154BED;
	Tue, 20 Feb 2024 23:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=linosanfilippo@gmx.de header.b="aVRck/LA"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C5676C99;
	Tue, 20 Feb 2024 23:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708471206; cv=none; b=jJxXcasSuM1QD/oY/hA445/BeTf8MznG6bwVQtajjV5Jp1cZULe1P9wYBl7nzm0GeS7tbXcCRMo3dvWUkMKKEdgvXFbXC9Do48N68SjQUfWclZ1/trM4BuYUx5vWl7KoN0Qeby9RGd4tPszvsI8kfAt02QlJEElIPyEa/GsoAto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708471206; c=relaxed/simple;
	bh=xH8ZSLRht7pctArDuAylfQ17kd63clt15AKuCFAH6y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TlBkLxQ2FiahvQ98Bn6fuLmAmfVFnLSx61iRGTGkmbyaZSOGf5m2QncR1UsYxDPKZJIjp0sNeUbEK4x56z7zGxIGj1Wqt8Xz1GRQAOcjqoe8VszT05RXFYl6SHdBVDCKpQFMT+klforzTXCXPFeWAtMsR2Fao4i2rAQoJsfdD7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=linosanfilippo@gmx.de header.b=aVRck/LA; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708471186; x=1709075986; i=linosanfilippo@gmx.de;
	bh=xH8ZSLRht7pctArDuAylfQ17kd63clt15AKuCFAH6y4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=aVRck/LAQO/iDkfUrHSlqOSLSlstcBGTiufCCpIOgmDx9BeESoONq+gmaJBsZC/9
	 sv9l2H9EKrK0Wrsc9w9PreY9PYFpJNceuqRCP1dlyB318F05VXRGPFxqu/AoDrtVo
	 pG4bmnoJUJJiVPNwQwnQPwVTYd4wlbFPvqgsq9ZoQ35dfUf2oX8mV/Vje2f9hnk+z
	 zAhsA+8R+FMUPhV/DzR++8Mbue14E/lQuBCeoQile3VwpDFrXo03wvO7/0zWuSK6u
	 UChIu2/S5/+emCdF5n2FwLCiudo61zylBUyF8KgM84MuZ8idOyQxKBbu5n+Kw9gsX
	 01lPym2qz8yrdMkH3Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.180.21.119]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfHAB-1r1ZYP206t-00gt3r; Wed, 21
 Feb 2024 00:19:46 +0100
Message-ID: <0d482ce6-4318-4e42-ac12-be2a26ef3548@gmx.de>
Date: Wed, 21 Feb 2024 00:19:45 +0100
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
 "Daniel P. Smith" <dpsmith@apertussolutions.com>,
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
From: Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <CZA9ADCGOTQT.LB5XHZZVTWVH@seitikki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O3vOrXxrzF86Algu8uHxZH9Gl3MkV08j8IfEPs9dYKVlr0NdxhG
 zMTnzQda0oYxq0STtcTq1+U4uBvM4EDmEgaw95qaDxp/luDS3xx9fSLwqdfRzfI4YIK1Ujk
 brAjhHC2A7P9KEe/v57kkhPc4mVzjLlzOwIGbuZDEbXbs7VaML3bSaYxdmL2qR0bqT3Fniq
 G53nZvYokpf6Ino1Mdt0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:B0BuG/S2rcg=;0dYNanw631SEzNj19ADh239I+zt
 F3zSTiBBXlXlpDGxy93ZX1se/gP/qkxBUahggzu4LxTP4rSe9uLG8r+R4YlsVaLrwqDc8Q/I2
 JkxC+mm97m0vBGXuhoPdAVRCNI7HJwtVrCsimlq5S2JQsHJF8b7+yOCzauRt3JQ4k71fwoyuh
 yCgHSKXeYDu0XExQ9nnvXoOjtx8mEHWnR5ZwBHiiJXwAVDpwQNXaY5Y2G8yLWhVAY5vFrm86X
 qezHXjptI5bjL1ANYcu1MQYUcfK4JWHCcxUy7P8JtJIIpCPlxDD21ZMcSozzcce8A2EeSkCed
 w4Wcuuh6/EGXzl3zttP1ixDtmxJCLlyIR+dnN7RH/cskK3OMka1kbJvOTbp2KDDOUH1dC+rRl
 Ayhhe0v6dzsExfcLTHEBxUz1Z6zNMKM16O/pv7/n10kQuy9/qRPWM6b/EXm5L5/4BFgnuNFEh
 KUh206KMBJCKz3kuOwCvLsSoBdVPuCpWw+oDjwCi61ygc8A0b54jb6b/RfSacTlSqn+Cicmz3
 pH9C6/LhXcvNEvHgGNfbXIiduhyJr/p1fUl3J6DdPhuca0LUZ3d65oGWar6mHZTJVRNTsHKok
 VIhmMU3Cb3nVdx9/4sjQHSBtPoedzbxJ+xfN3MKIY1jk9px/6/dChzrJSulreuwMy6VOQoIaZ
 1K1DQRsS5X1OimLg0EFq7VHC/7GsG9go7IznkIYEsGIC+TBJnYGgy3BZczFJvPnsPQCktMbQ7
 lOb34Xe9mw5ooiy+qsKfg8A+9u3zgEvuwIP6UaXcW1bf1eZOXJKZEjoxiiFsr4TBwvy1qkkfC
 NRl0qRPbCy4qC+Zbb7m+a8+wT0x1n6MXxH5SYjr/PD8LM=



On 20.02.24 23:23, Jarkko Sakkinen wrote:
> On Tue Feb 20, 2024 at 8:54 PM UTC, Lino Sanfilippo wrote:
>> Hi,
>>
>> On 20.02.24 19:42, Alexander Steffen wrote:
>>> ATTENTION: This e-mail is from an external sender. Please check attach=
ments and links before opening e.g. with mouseover.
>>>
>>>
>>> On 02.02.2024 04:08, Lino Sanfilippo wrote:
>>>> On 01.02.24 23:21, Jarkko Sakkinen wrote:
>>>>
>>>>>
>>>>> On Wed Jan 31, 2024 at 7:08 PM EET, Daniel P. Smith wrote:
>>>>>> Commit 933bfc5ad213 introduced the use of a locality counter to con=
trol when a
>>>>>> locality request is allowed to be sent to the TPM. In the commit, t=
he counter
>>>>>> is indiscriminately decremented. Thus creating a situation for an i=
nteger
>>>>>> underflow of the counter.
>>>>>
>>>>> What is the sequence of events that leads to this triggering the
>>>>> underflow? This information should be represent in the commit messag=
e.
>>>>>
>>>>
>>>> AFAIU this is:
>>>>
>>>> 1. We start with a locality_counter of 0 and then we call tpm_tis_req=
uest_locality()
>>>> for the first time, but since a locality is (unexpectedly) already ac=
tive
>>>> check_locality() and consequently __tpm_tis_request_locality() return=
 "true".
>>>
>>> check_locality() returns true, but __tpm_tis_request_locality() return=
s
>>> the requested locality. Currently, this is always 0, so the check for
>>> !ret will always correctly indicate success and increment the
>>> locality_count.
>>>
>>
>> Will the TPM TIS CORE ever (have to) request another locality than 0? M=
aybe the best would
>> be to hardcode TPM_ACCESS(0) and get rid of all the locality parameters=
 that are
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

Yes, removing the "l" parameter is what I meant. I can prepare a patch for
the removal.

Regards,
Lino

>> But this is rather code optimization and not really required to fix
>> the reported bug.
>
> Just adding here that I wish we also had a log transcript of bug, which
> is right now missing. The explanation believable enough to move forward
> but I still wish to see a log transcript.
>
> A/B testing of the bug and fix is something I'm lacking here. If anyone
> has ideas how to use QEMU to simulate what Intel TXT does with
> localities that would help.
>
> Most of us do not carry Intel TXT setup anywhere (home or office).
>
> Also even tho 0/3 has an explanation bug 1/3 does not have anything at
> all to make it to be counted as a bug fix. Pretty difficult to compare
> any possible proposals for a fix on this playground tbh.
>
> BR, Jarkko
>


Return-Path: <linux-kernel+bounces-79434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210A8862234
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 03:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0DC72873B6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7199DF60;
	Sat, 24 Feb 2024 02:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=linosanfilippo@gmx.de header.b="GltXbv6c"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D00DDF59;
	Sat, 24 Feb 2024 02:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708740425; cv=none; b=pci7y35dY1qfrniwr2n2JKfqLVlJyZZah6HY/qW4+1F216guSAy2Yp+/BEcPUOGkYVPHPk6QtCMgISknCAZQDICU/lg+4kXz/r5M6iUBJGw2/IpA6WBQm6p1YPIxuInjcRMAxNSkmOzGYUqGR/Lyh3pZqLwkXP8pJRLtDfpICAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708740425; c=relaxed/simple;
	bh=6ByNVZjqOhC42lFK4uSCtMzO/SxCNqwZ6gFSR7hUZO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8/hcSZUYX9tmOidG655rE3MEyUmQLqnlwSOmndkhH7LSoZupy+kxSY/fpGv/330qEY+Q1jxqY62WkVV/Y7vfuQnlm+RhfIasyOZujoO8t17T7V+dsuk0Bba7q+MNttDRA9UEYjj+KjTlx57k+LTTvBnwtFH2UvBdGkJdYFDlO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=linosanfilippo@gmx.de header.b=GltXbv6c; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708740407; x=1709345207; i=linosanfilippo@gmx.de;
	bh=6ByNVZjqOhC42lFK4uSCtMzO/SxCNqwZ6gFSR7hUZO0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=GltXbv6c+NkjaH//0BGxYbrCZfx+W3lk+W89ch1IzlYIwg1yQi6prv+E5OdaiXRT
	 O6yuPbGcWG6lIKAs1o2zc3XvlxXqWyMN4uUUpLcbvr1ori6OQcdYaonQl67ELWk4W
	 bvAfVyMGcOC68o67izH6d7gvtViPR9sWYmbla5b4blRJffw35SGzvGVayKxU/d6ic
	 ft23KuFHGur4Bfu77H/NDdBLZlwMIbu9IfUHSrR0wuFNQRcrYQX3eb64fdFDYN0zb
	 bqx+MqYJFckk6RR+NyXqYAz4FO9URQVX5mMxxlT2Vv8Z+msZB8eOpAz96yy+j9CoN
	 rrJTJ0CqajpcEwVC8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.180.21.119]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0XD2-1qjgZ82Sxg-00wYOI; Sat, 24
 Feb 2024 03:06:46 +0100
Message-ID: <f1257a02-e383-484f-a0c4-90ac5b870dc1@gmx.de>
Date: Sat, 24 Feb 2024 03:06:44 +0100
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
 Jarkko Sakkinen <jarkko@kernel.org>,
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
From: Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <ae3fecc4-7b76-4607-8749-045e17941923@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/c3sJpAyD9Ca0CE3RjW+lMKdXpt0gj6lXrBGAkuCbXmoygslSsd
 jSZ213fmJcSYWG4SNySwcNQ1GhNifNAMGbZSLfeMi/vrzy35G9oCGcVuOmg973SSHkag44p
 BbJ4ujhkbPlrVAlZia8scc0T0KdWa7diHmZ5WS+o7e1MTzRvRMXUHPFkqcUE+jYEHsS27oz
 LSr+xQFnwU9eeB1v39FeA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nCj0f9L+1XM=;ux8VvHNJspF81voaqysoH4iLjZM
 lCmbCZu7U1aTJrzeBM0/XWD5i8qlnzBBiSYiuUKqPab0Y3OL4GcGCLDQPkT7eqr8HZ6r/8LW5
 gNA44Rj3QUR4WsY4UBZLgZVZ1FIjdaZwGCSVC9K9B382FYraz6KwzbbQSNjj0KkOB3FJjFp9Z
 zEXRl2NVrzxpnKm5tiOiBk3do09jLmUcVMzHcigqliL0T4rq5tacX5UcaiKTD4uERITN1deDJ
 cjk+5uT+HCSAZ6am916dmLwGVdRF/MxcyRr/d5z9rZ9AwLkigkWsKFzgJCRzFeZI4bpVlQLUw
 nhSc25cZTLU2mM/etGpWlOD1r/EkWCsd/HfMcLCu+grKCXmUf4DEsSw+xH2SCB77AImg6wUTi
 jaP0CI7WF81D8oRn5bk2jR0D7mnJK3akSe02CuvBYv26ubzvz5TYHIr/Z2Khq61ZKlGI1MLrQ
 R+K+5tiOh2gLEmtVbvPbsry0tF7BBolaUmZOAUuWnJiphZQmtBgmGSCQh9ARyacmGgWhoYjbZ
 ZgLrvpgfmSWkH1Wee5ZavdqynAcqJNs3Slln5aobsHVSZnXCawZWAXQZEoR/gU7ItYECi8lgb
 1m3wBX8pXQ6Jdo8BiSRUItMSaABnmcryDRnn1OdlAI0TmbvLH++F+dGrPVFrhmDaWPWYR6JtT
 dEzdjhXpV15hkhdftaZhjuGMP4ujbJvwutR1mUeybLF+cz8nUuOwS5awve0sKcLdcMIMuYLHp
 QHuknEXYE/zX7HIVs5RBGBPXUJLrGu2dYR8b4ag9Qo2t+iR9Y1ZUirj8p/lw7pYa+RaqyyuhM
 WvwqxlnDanIetDTDDvkrbJUW6r4QPDIlGaO6G0pxEXt+8=


Hi,

On 20.02.24 19:42, Alexander Steffen wrote:
> On 02.02.2024 04:08, Lino Sanfilippo wrote:
>> On 01.02.24 23:21, Jarkko Sakkinen wrote:
>>
>>>
>>> On Wed Jan 31, 2024 at 7:08 PM EET, Daniel P. Smith wrote:
>>>> Commit 933bfc5ad213 introduced the use of a locality counter to contr=
ol when a
>>>> locality request is allowed to be sent to the TPM. In the commit, the=
 counter
>>>> is indiscriminately decremented. Thus creating a situation for an int=
eger
>>>> underflow of the counter.
>>>
>>> What is the sequence of events that leads to this triggering the
>>> underflow? This information should be represent in the commit message.
>>>
>>
>> AFAIU this is:
>>
>> 1. We start with a locality_counter of 0 and then we call tpm_tis_reque=
st_locality()
>> for the first time, but since a locality is (unexpectedly) already acti=
ve
>> check_locality() and consequently __tpm_tis_request_locality() return "=
true".
>
> check_locality() returns true, but __tpm_tis_request_locality() returns =
the requested locality. Currently, this is always 0, so the check for !ret=
 will always correctly indicate success and increment the locality_count.

So how was the reported underflow triggered then? We only request locality=
 0 in TPM TIS core, no other locality.

>
> But since theoretically a locality !=3D 0 could be requested, the correc=
t fix would be to check for something like ret >=3D 0 or ret =3D=3D l inst=
ead of !ret.

I thought that the underflow issue has actually been triggered and is not =
only a theoretical problem.
But now I wonder how this could ever happen.

BR,
Lino


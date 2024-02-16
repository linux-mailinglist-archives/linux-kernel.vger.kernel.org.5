Return-Path: <linux-kernel+bounces-68537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 670CF857BE8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1281F27335
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4FA77F39;
	Fri, 16 Feb 2024 11:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="kvIS8qtb"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1B459B5F;
	Fri, 16 Feb 2024 11:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708083709; cv=none; b=O+sPjowcUQEOT42PED3OfOjdLkML9LVPnSFhBlmUEmGtgF92KskDsFfKGNvFJJc3zJo79hgOsrkItKSdtVexMpD00GvQmIO04tSPOQPtVb0xRy/o9lLKGkza8AKOP0QqTR883A3auDRP5LbnThEADlZYkgwUVU8BgzNAomjHcxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708083709; c=relaxed/simple;
	bh=ENkj9c3IlxXNoqACou83okSe3zXu5WBJkYNjVu8EpqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gNFMdDsTcRb4PDO8iVyIWRDdG2YHJoIWvIN4mtjelwZCzDsOfyAz40CqrEkGngNiUBDJb5k95qKotBGXwiu1vW1G2zhSYIcFyiajAuoRAm0YsvMV5tK9zb5t9Edj7YeAIcOGI98tNWtASuEgGOmedcSZAWfIfv11RzgYlQPRJ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=kvIS8qtb; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708083686; x=1708688486; i=deller@gmx.de;
	bh=ENkj9c3IlxXNoqACou83okSe3zXu5WBJkYNjVu8EpqM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=kvIS8qtbuadHs+uT7skkBZZK818kmErwrw6HwDJFsVcHlcBAOVUZTte9VNyrKsoK
	 QWg8lTomgHOBthOqvumrvEU3JQXceBFOHwPDxOM4SEiEwVvwARQ+dO9ADGGbi0R1J
	 EXqeykYxDj+LTKD3tEsifyKuDAKMq4Klb4qGbE9E+Y1Ezt5yhXYWJTdiEpIYj39OG
	 hiQ2/MRwNuQtRTHp/z0gBVc5quMmpbNi/XSmpCZJSCTh2Xsd6moH+pZxGxOrnaoov
	 /l7yqg9S2qvF/pKTeE3+Iq8EPsDZKFMLNO3tNd3M0kJucLM2MJDhvZSfBObafXDY5
	 O5wVrMTTkxfraU4LbA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.148.214]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXp5Q-1rTDsA1RXQ-00Y8u8; Fri, 16
 Feb 2024 12:41:26 +0100
Message-ID: <61cfc73e-e406-4e98-9057-d7843e7694e7@gmx.de>
Date: Fri, 16 Feb 2024 13:05:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>, Guenter Roeck <linux@roeck-us.net>
Cc: David Laight <David.Laight@aculab.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Parisc List <linux-parisc@vger.kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20240214-fix_sparse_errors_checksum_tests-v8-0-36b60e673593@rivosinc.com>
 <20240214-fix_sparse_errors_checksum_tests-v8-2-36b60e673593@rivosinc.com>
 <2ec91b11-23c7-4beb-8cef-c68367c8f029@roeck-us.net> <Zc1pSi59aDOnqz++@ghost>
 <cb4e358b-3fd0-4ca4-bf53-9cc379087304@roeck-us.net>
 <25f108d1-827f-4a18-bee4-4105fbd45974@gmx.de>
 <6aaa4b89-a967-4b19-b4bf-a1ad5c8e9faa@roeck-us.net> <Zc79I5VDSaFnb4xj@ghost>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 xsFNBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABzRxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+wsGRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2jvOwU0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAHCwXYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLg==
In-Reply-To: <Zc79I5VDSaFnb4xj@ghost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YuF9PVuGcuEpBNoBnA5hjOnuz5Bspi64Grxz2iK2S3IkdxDOLtv
 GCIoagFe46RGCoS+efUsxNyzUihQQFvedTJW87N4RIkC12WFAxCF5Lir2xaisO1CZgCQm0G
 EoeXSRdQGBscBtRjN86vJD8iSIy+My5vVZ7bFM8y4+xlQG43uQLc2qLpjuzNkr1/lMHZAa6
 PnwB1PeWf/kcK+PGdDkWQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RTB83uO8wns=;hiZTewUlieqkNBMyVa449AXBYM6
 HdzkyUSoDb/eBmsqzN7SLxRPM72sm3iZzyQbz6IxN0vaqImha6nuQnbR+S7V0++cPK9N/L/4K
 jtlkTPedTLsFBUD5ax/Wla9tKK343Ir8ApowLkMwdeGrzQXHG4AWAeKrkqngVU7fAfXVbTHI5
 RABMhUxvWV6GLqeGNWak6iIGMOjseFrR0fCxAEywtRA02GC/Cs8nQ5YRkpE0xl1iz+iUA/aX8
 oFnFcPRodeEWeT5ojaCMJRr0cweZoRrpZMVmznSDke6BUaD9kK4c9nHq/pwzsIPbZiyaw45BK
 EXXzjptR5csN4fNBjs+Bfcu/91t6MUQUO5jZ8SPkq8PRBozGEj92HNrtw6pNkJ6iIg8Kc6LL2
 wPVwHEp7JN0D8J1JmhQpNl1eOZVAhr1JE75o8k1vLZt23QEQzBunKSCkPzuV6pEhGgR3vIDCT
 59YCBjLvSISgG5qmBqHY/9lAbjrynkGozWPGqaYgGKIqrkG1RhXvwCVdTARyLU1Xv/gKpNVbE
 +Nagp2Y/Faurda1lhbkMzTQtUbXi51YLmuF0546r35sqXjkIOlcYuTX3vienWHsvssPG2ozO2
 iNb/GK+0hF2eci49SHMtwYKVqjId6USEb1r4Vt1BBw4ur1VVwXagVzSyoq+P0FqSx6covzOO1
 fpBL91YgifSzYQgf6yPqWIVRjB4C4iqvWANTkGrDpw3b9v9LeVAVszmpoHf5vlk2wIFYtmJel
 TjY3I86C7rjAEnvVrM8BxvUBtuC1v4UDV7CTsGW8L+ZG0/R+q8UexA/9WvH+wi3Gm411i+rAb
 rQBmcHCIVs5qAs9WnRhDCbwFfCUbJs9Q85udohi4ZUrPc=

On 2/16/24 07:13, Charlie Jenkins wrote:
> On Thu, Feb 15, 2024 at 10:09:42PM -0800, Guenter Roeck wrote:
>> On 2/15/24 21:54, Helge Deller wrote:
>> [ ... ]
>>>
>>> Can you please give a pointer to this test code?
>>> I'm happy to try it on real hardware.
>>>
>> You should also see the problem if you use v7 of Charlie's checksum
>> unit test fixes.
>>
>> I submitted the qemu fix (or at least what I think the fix should be)
>> a couple of minutes ago.
>>
>> https://patchwork.kernel.org/project/qemu-devel/patch/20240216053415.21=
63286-1-linux@roeck-us.net/
>>
>>>> It is quite easy to show that carry is always set after executing ldd
>>>> on an unaligned address. That is also why I know for sure that the
>>>> problem is not seen with ldw on unaligned addresses.
>>> Interesting.
>>
>> Ultimately it wasn't surprising, with the unusual carry bit
>> implementation on hppa. The upper 8 carry bits were not masked
>> correctly when returning from a trap or interrupt.
>
> Tangential question, but why does Linux need to save and restore the PSW
> if that is already handled by the hardware? I am missing something.

e.g. for task switching.

Helge


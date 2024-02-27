Return-Path: <linux-kernel+bounces-83969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E1B86A0B2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14454B21E27
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B8714A4DD;
	Tue, 27 Feb 2024 20:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="QO7oHusU"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3154D5A2;
	Tue, 27 Feb 2024 20:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709064888; cv=none; b=cuwBc+pfBNuycUn/dTs0MXmr0OGLL6KmyOouaXkddHbRb2NnlousR7NRrcpXc29Zrn8uAzK0/+GF7gNe+wmLOCbg5OEWJMaP1YZvTkcR+HJDDnGy6ov1f929pD0fHQho1rAnFtoDoW01wDP9BK9N//7So/aU7jtfw0VP0MLlXdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709064888; c=relaxed/simple;
	bh=kd4bIU/R8XOUWa99vIQj43v6ovZyK9dK3DLfkhNXoJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zituv6EQXkeXCDvXr3XYdJ3oj/PBreNHfgXGRe39Izndo/WaHJqovw5GbDUlZY5Rj0djtcxAU776EtSpZWK9iReAm96I7/DCQ+zFqSyMt5INAHyuI7SpR6TgM4ye+awEbrpU1UhntEhFJEkoBxXtZsV96u4kGjLauoT9TakkfGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=QO7oHusU; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709064867; x=1709669667; i=deller@gmx.de;
	bh=kd4bIU/R8XOUWa99vIQj43v6ovZyK9dK3DLfkhNXoJw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=QO7oHusUB70g1ugb29LZMtBP6Jae+PNM2TrL/rSQ+ai3N3t4FIBSlvOiLE1u+EWt
	 Jp9qF+lnkDN0mOpo24uKictPEQ0Yp0t3UqJqTw9/w1K2BqsHIs53gljZqI4iFwJzv
	 nYGtvgbws9tARyM1BFiMdHGERfM/39rbB+9o12iD80c3sqp0H/Wvy9ZH/pJq4PH3A
	 6PBXFJrZeFcFpPOFSs6CJePu0owFu1t2UntlhiUmXWroVsr7C8pYEXTnIYfjJ/yok
	 cHa6moYzdTj1E3dja4AZ7RGYcFCuzQ9AY5IdxKf66b/R3I+mlpM0W+vKvxavhspND
	 6yodhB7i6w180ru6Zg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.157.76]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Msq6M-1qm8qJ0OtM-00tD4l; Tue, 27
 Feb 2024 21:14:27 +0100
Message-ID: <d1a6fe49-19f9-433e-b275-209b59155193@gmx.de>
Date: Tue, 27 Feb 2024 21:14:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] parisc: More csum_ipv6_magic fixes
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 Charlie Jenkins <charlie@rivosinc.com>, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240227185334.2697324-1-linux@roeck-us.net>
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
In-Reply-To: <20240227185334.2697324-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PSbiFV3/SYww6osXvB3DYUhh8Gu3seUiRSHekdz2E3m7h46kfEU
 I3Pet6xRIRdQFQH5O2Du7W5goBrP3tCr8A4gwliBeUpcUS5rUdHSDqkyWIGgiqpEHCdbY/k
 Pwd6ThjMaem75VKXXjz/qG60+11EzG1bM2y/DrQJJO0Jxx1FwZH3wVJe0hxXQ6oTZB9Wi75
 adZemBnMc4WnKlbor4Bgw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HsFkZDSaxUA=;xlgBdRntWGQI0DDwdECWGLzE3Zk
 akuxByW5CNyD8LmSRXSaCuz0NXAwK5ubKfITznC4mDKM6AAAkwbEtZ5d4FBSyNXy8bGVWu+EI
 tjg8cncpRO21u6JlOYx+GiKNcjeoR93yyVdmmgM70cB8LmzxEDMuwvOaW2XtbAA4KatJaH9fP
 uIxSlRB3KuyXS5dSSN6/6fcsBYgEHRlorl/F3+jkiH8GgM2CEdi33pat6W+C4VhBDscDuZp/s
 ayj+Mc6M1ve/KnwWCi2KEXcDgG7OMVmHK9dxRe+h6YhV6/RFOR4YW2+1kH2aC1B9noKK/ZgRg
 lJfdRU7IwhVTNlMWXbiQYUNv1khCRCSKq1LfTMRvaIJTEi1Af9x5be1mnd6MRewoeptO4KUTI
 hlf50DGcxyrjfJ7E6jSzTshFvCK3uz56dKrnCf2IE8V+S9G8FpmUYsKj5O4ByahLyqY7mq+gW
 J1Vg6K52RmF+HJllmjw6/UdPPhD3ZEbJI+QgemKnx9dWKAv8IpGOhTaroIdBIGHa7mUJWhfzz
 EXHL1HiDvUqXBGkGE2v4UzVC3JK5zlYXR3l6TB6dl4iVKZIWb9rpQEFItyCXj6l8GWeJ0IB4V
 wQcNkZg9dc+OiC2V4cvoQLPf2/Trhp6lMK56raXDNqDBmigmoM/EOVmIbM1mjl6uU6iAtCmlo
 6FSD3Sv0se8UdDouL8l0/Ai7r7GZGLHb++qbkZ3pe2uPgiTbZ3FATkd1M1An52azPdp512vsw
 BWIpYahaduURua7fJzGmujXJwsPnNLykWHatsKBK3pFdUvqXxfriC69m95mn3kbhIdv2L+0LW
 xrt85yd/ytzMsnPtc0mNU4w7MbHYjAw+GX96/1bPg1HXw=

On 2/27/24 19:53, Guenter Roeck wrote:
> IPv6 checksum tests with unaligned addresses resulted in unexpected
> failures.
>
> Expected expected =3D=3D csum_result, but
>      expected =3D=3D 46591 (0xb5ff)
>      csum_result =3D=3D 46381 (0xb52d)
> with alignment offset 1
>
> Oddly enough, the problem disappeared after adding test code into
> the beginning of csum_ipv6_magic().
>
> As it turns out, the 'sum' parameter of csum_ipv6_magic() is declared as
> __wsum, which is a 32-bit variable type. However, it is treated as 64-bi=
t
> variable in the assembler code.

Nice catch!
That kind of bugs is actually the reason why I start to prefer
C-code over inline assembly, even if C might perform slower.

I've applied that patch to the parisc git tree, but do you think
you can come up with a better patch title, e.g.
"strip upper 32bits of sum in csum_ipv6_magic()" ?

Other than that you may add
Acked-by: Helge Deller <deller@gmx.de>

Helge

> Tests showed that the upper 32 bit of
> the register used to pass the variable are _not_ cleared when entering
> the function. This can result in checksum calculation errors.
>
> Clearing the upper 32 bit of 'sum' as first operation in the assembler
> code fixes the problem.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Maybe there is a way to do this without additional instruction, but if s=
o
> I have not been able to find it.
>
>   arch/parisc/include/asm/checksum.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/parisc/include/asm/checksum.h b/arch/parisc/include/as=
m/checksum.h
> index c949aa20fa16..2aceebcd695c 100644
> --- a/arch/parisc/include/asm/checksum.h
> +++ b/arch/parisc/include/asm/checksum.h
> @@ -126,6 +126,7 @@ static __inline__ __sum16 csum_ipv6_magic(const stru=
ct in6_addr *saddr,
>   	** Try to keep 4 registers with "live" values ahead of the ALU.
>   	*/
>
> +"	depdi		0, 31, 32, %0\n"/* clear upper half of incoming checksum */
>   "	ldd,ma		8(%1), %4\n"	/* get 1st saddr word */
>   "	ldd,ma		8(%2), %5\n"	/* get 1st daddr word */
>   "	add		%4, %0, %0\n"



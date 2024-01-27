Return-Path: <linux-kernel+bounces-41182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5929883ED00
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 12:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCD751F225C1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 11:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E375E2033E;
	Sat, 27 Jan 2024 11:52:35 +0000 (UTC)
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81690200BF;
	Sat, 27 Jan 2024 11:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.239.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706356355; cv=none; b=hzU7c4PW3FRYqkj7UpZKFQf9Pju+hJ5tY5BkCUVBvRw+q5Vj1WhMKKoK63jBYe7BPPwhI31RNaJ7Yd2v94fFLVZ513k2BP2N510qeanJRODlnSZwLLLiZhb1QLLJ7cZlBJksF7VGjaS0VCS+QXlZv0cXme6RUi3+90mIzLtTdww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706356355; c=relaxed/simple;
	bh=smEVPDJ1TMvwMUm2x05BLrsaQnBayyX2ir3dtq9gJF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NXQKRu9nXnHjnIzxDVbBMH10t0ATFhRb7se/M0R8JNqVlBB5cUSsaKWTpIA9Hb9odsXjCwg+vKTZQsIESVfcEWxDMO3ffDrALgruHT9TFr06lRfbl1ldTTrNbnyYYMNlJJ0ExulCMJRBFGnRJaiI/n4CE+H9f8YXBYMRRggRKIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.239.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 2EE881015FD;
	Sat, 27 Jan 2024 11:52:27 +0000 (UTC)
Message-ID: <88df213a-5a12-4571-9f29-6311b82a8f25@enpas.org>
Date: Sat, 27 Jan 2024 20:52:25 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/7] HID: playstation: DS4: LED bugfix, third-party
 gamepad support
Content-Language: en-US
To: Roderick Colenbrander <thunderbird2k@gmail.com>,
 Jiri Kosina <jikos@kernel.org>
Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240115144538.12018-1-max@enpas.org>
 <nycvar.YFH.7.76.2401231047140.29548@cbobk.fhfr.pm>
 <CAEc3jaATA-Z86jh=njR6yctguQBRp1BQEFcBQhYT0rYKcA4f2w@mail.gmail.com>
From: Max Staudt <max@enpas.org>
Autocrypt: addr=max@enpas.org; keydata=
 xsNNBFWfXgEBIADcbJMG2xuJBIVNlhj5AFBwKLZ6GPo3tGxHye+Bk3R3W5uIws3Sxbuj++7R
 PoWqUkvrdsxJAmnkFgMKx4euW/MCzXXgEQOM2nE0CWR7xmutpoXYc9BLZ2HHE2mSkpXVa1Ea
 UTm00jR+BUXgG/ZzCRkkLvN1W9Hkdb75qE/HIpkkVyDiSteJTIjGnpTnJrwiHbZVvXoR/Bx3
 IWFNpuG80xnsGv3X9ierbalXaI3ZrmFiezbPuGzG1kqV1q0gdV4DNuFVi1NjpQU1aTmBV8bv
 gDi2Wygs1pOSj+dlLPwUJ+9jGVzFXiM3xUkNaJc4UPRKxAGskh1nWDdg0odbs0OarQ0o+E+v
 d7WbKK7TR1jfYNcQ+Trr0ca0m72XNFk0hUxNyaEv3kkZEpAv0IDKqXFQD700kr3ftZ8ZKOxd
 CP4UqVYI+1d0nR9LnJYVjRpKI9QqIx492As6Vl1YPjUbmuKi4OT2JdvaT4czGq9EJkbhjC8E
 KQqc2mWeLnnwiMJwp8fMGTq+1TuBgNIbVSdTeyMnNr5w0UmJ4Y/TNFnTsOR0yytpJlHU4YiW
 HDQKaw6wzvdxql2DCjRvn+Hgm9ifMmtPn5RO3PGvq7XQJ0bNzJ/lXl9ts9QbeR62vQUuv63S
 P6WIU+uEUZVtaNJIjmsoEkziMX01Agi+5gCgKkY8mLakdXOAGX9CaUrVAH/ssM0SIwgxbmeH
 F0mwfbd7OuPYCKpmIiX1wqNfiLhcTgV3lJ12Gz7XeeIH3JW5gw6tFGN3pQQNsy6SqtThyFQN
 RlLNZWEHBh2RdE1Bh3HFFCgdbQ2CISV+nEGdTpP+wjlP17FaBUEREM/j4FT5Dn1y/XICJog/
 dymN4Srn8BZ0q1HQBVIJszdfpBa37Fj3gHQbUPinoDsNCCjNibOD06Xk4hvex307pcsXe/Gi
 qON0vCtTfbF9jUmao84LpOMjfnqMXQDl3bIi0GwvdXWTvTNM3gCllj1sygWYvPn405BHysbk
 xbuGCP1qwRRYxrkBpCOUxBz48fT+90CewfwvhuYjBc1dPu0x2io+TRex2rfpMLbjUhYWYeun
 Oo/w+7Ea8UoxqLkvQjNY7IDBtvtPQdW5NxPh1kYOOMCMTGPR7wKMo7O0clMQ3Gviu12nvt2X
 2rKtI56oU9pEFpIY/moDM+nDNR3fIi1BjdBfhGhSi6uRWy1vgBHYdW0rItPqYtQ9R/AxMbFN
 Kv4axzus1+yAfqSAWyp1DCC8+PX+x4gYEh0rbh2Ii91jdhzONzoEjMy8VCfu9hgeE4XazsFD
 234zaonkEh8Mpo/SyYH4x0iMO0UyKn1RbyC9zTmAtlIvYUsQdF8exWwF07vvqbzKWkHv8a+y
 RFT9nuZZtVN3ABEBAAHNGk1heCBTdGF1ZHQgPG1heEBlbnBhcy5vcmc+wsN9BBMBCgAnAhsD
 CAsJCAcNDAsKBRUKCQgLAh4BAheAAhkBBQJj8hAUBQkSFRkTAAoJEGVYAQQ5PhMunA8f/0ju
 wYM509cxVrFNKmoyMx2Jhja1JkfUgI5y7BT7vemL8Q2prmdXPVT4CPuJQ3mNnb/R/bZ9noDc
 WntrunxGWAHQl5ng4GfY8SIWPCqbXs/nBfqpCdoOyJrRKx3/vdYgCOnwpRPU0sbZ2MuMPaVP
 TK5eVp5eTqhQkN4wHPoceO2iEk6+R9CoT9SFIS50fIo96WAj8SrGBVmypQxdRLCemWYDOy3l
 kzB3bxG2cDhc228r4iFMoYh5+UdbbtNOuDlPab1l4BwXfX0NfUwuXXxqmiJlk/rZnlw5QIzl
 l3UcOvwJ344kRjsY2Hadx2Uz1EvqGDqLodfxsNp3Vf5QrPxH5T3/j//OOdSuvcetWaeNeiC1
 Tcx7wiCL1iQjaFgPKaWF5Qca5jJUidUyS2JaCgNmQ9dBJ61zAB+ZqbAcS7aQMJN05HWfPUZq
 y7lVcDKYrdq2tIhDk0OUQnZ7RSZShrCCMz2dsjFqcWv33SkKHFKB6o7BGU/2S9Iv0QssR5Xv
 F+6orxW9PDYMzT+4c3BvPBXFUo+LxExFHutPeaDaMAhszoJJ87e42Cgr/5aZvHaG5GqMcsBq
 l9nffEfy6veJIevvA8B8XfR9QrfiNWWm/xsDrbjCznRzAI2GnFphJwjdppOOQWURHvxsJVG0
 aalqMjhwoI/6obscyjqLiwFkr3eMFv0guQ6UR/V80i9XUiHMR+6UH6vC/LMsTurdHGohoEvf
 bAudo2YHaZoiFyvR2I7oPI4PavHQBFUtL0i8r213M+LRb5tfoXAVy8OYIaSe/c6wrA6IDaAQ
 7eF9jDh3Be66JihmS3W0ifhMjqwRfeJXAYr4EtRVo6kTy3+xpeb/ThVwb8tP47gu/IZnMSZ9
 q2VFenTWyR68G1KAaxcEo5bftohs9vcxZHaZN0ubzLeuUkzdhP70ikt60T5/foW7N7fDFUGj
 /2nSjajmeAV/3L97LjjF+5D+czubhE51epNAOlNLBgRMDyE2Hgo8l2A1uiuqIwIvGSk10BKC
 TImOhCsL+IoXFJhDMU3JunL8/H2HAN3l+TNceAMzD275klQHQUvSU6DKc1UY2iYgjyEERMys
 r/HpU3b+HZW2bcGaudL57bvwGclke9Lg7jKVD3HSkiDy0UPh/8d82qo3hXa5opBonw7QhiQ+
 X4t2AlLtGWEg6QB67MxT23nlVx/P1eSzck6JwQQ6W2W8+pNseKOOaASZjSKMntHiuEjaEfCj
 zune+n9NVB5jOh3mCDo5BIjSn9eTK/i9Zc+qIKllr4qyLwrUx+4X/kYpU8Or+8F/TSjXDk1r
 DDUP6KRl7RRYHuuhgWmx9zOdlzasrpxDcZ36c33wczp0PWUkNPOeAKHupOejeUb1Gd/OwU0E
 VZ96mAEQAMPq/us9ZHl8E8+V6PdoOGvwNh0DwxjVF7kT/LEIwLu94jofUSwz8sgiQqz/AEJg
 HFysMbTxpUnq9sqVMr46kOMVavkRhwZWtjLGhr9iiIRJDnCSkjYuzEmLOfAgkKo+moxz4PZk
 DL0sluOCJeWWm3fFMs4y3YcMXC0DMNGOtK+l1Xno4ZZ2euAy2+XlOgBQQH3cOyPdMeJvpu7m
 nY8CXejH/aS40H4b/yaDu1RUa1+NajnmX+EwRoHsnJcXm62Qu8zjyhYdQjV8B2raMk5HcIzl
 jeVRpEQDlQMUGXESGF4CjYlMGlTidRy6d5GydhRLZXHOLdqG2HZKz1/cot7x5Qle2+P50I32
 iB0u4aPCyeKYJV6m/evBGWwYWYvCUJWnghbP5F2ouC/ytfyzXVNAJKJDkz//wqU27K26vWjy
 Bh0Jdg+G8HivgZLmyZP229sYH0ohrJBoc68ndh9ukw53jASNGkzQ6pONue8+NKF9NUNONkw4
 jjm7lqD/VWFe5duMgSoizu/DkoN+QJwOu/z10y3oN9X7EMImppCdEVS01hdJSyEcyUq90v/O
 kt8tWo906trE65NkIj+ZSaONYAhTK+Yp/jrG88W2WAZU54CwHtoMxhbMH9xRM0hB97rBvaLO
 JwGBAU0+HrxOp1Sqy2M1v91XBt4HeW8YxzNEexq1ZtNnABEBAAHCw2UEGAEKAA8CGwwFAmPy
 EEQFCRIU/KwACgkQZVgBBDk+Ey5eHB/9Fv7hi2E/w82AQD8bOujnKcpShl7rd7hldO4CWOzz
 dLwBP6F0UXMv4yZ9Kc2PZhsg1y9ytO3/BaCYGOE+NONgmKy+yQxPnLQCxNTw57hMjDeCuu/R
 CgcxNDmaocsHrP9SCOBHcvfODj80+VhU+R2gQowmhfkzSSwCn1QCUOkt/OZpX8Bx6OoT97cU
 hN38d+NXTMj+sbYqqFtDoEK5vf/3Q/oSwVPDRF8rmAESW/lKhKpzbV713V6rYeCujt5yC8Yt
 PrfLsuWZ9s2U4OzpL18MR+tAKf7tYuq4a9/pK/r9h0+SzxB9yHQn+u9D/+vqVRXXSjTOzHL3
 BGgV5tNsolNsiEZA1bcw/TvvZMshCQN21CoqjHjCENoK6z6l+/BlNozwXG+ZQVaWOjvqKpNz
 LmXsA2I7ZtaW/dyCblYsd2wzN6iQQjkypGOwG4M3JFzdmY29H/0ygTi+c/wyHHXmjKZ84pgM
 sIzLJdgoIGjL+UP3+Pt+zwP6yNAdXnvuI4ibLH/8v/Ie0gWxhx+gL3qRMtydHGC8jHQCW6Yq
 Mz+WgqnVgSNFEScf7cPlyzAfW8Y7keWqmn1m6rCQUS3uVzqY9C0k7Oim9JVfTvijwb8rf/p9
 SYxi7IjTOFAJ3uml351POpWH0RWf4SS+NkWZpD+xq6m1y50FhJkJoFzpQ3r/ZRzs9WN0xoGu
 vJIE0R1c2STuc0oiLEP7vz2+nLQGCTSh7cG+Zy5v5+dUiq94rl/dLgdbX0XKF++dYMDrsaV3
 ZJ3aWq56FqXmtbwN7XhZv2/ZRuHGqjNLbDfVLKqcAT8kDQgdkaTIxJ2xXCtTYRqPqe9foPx4
 LkRfcO41oL7FBAZiKtdZYXMjnweafuwMA4eYiLB6Ozn7nobZP7Wg4mWAMIR7Fju9QtuvacB7
 nMwXFn+P+aVY9rzSxyKhm6eoOGR95/Fho6/+pDA+5FRGoN6Fg3kBOJ9zzHx9uA57wBt30//S
 ECSxv2vMWo4b5XYsSeMVupOjJJmQtyAD8pB7JfFCnwJUmU6egnFkJoFQYjAxUwk4RHMKAd6M
 34bbhs5XaM/4yN2wCqQlFwp8NF4T/YFAtUdV7pyTMEohvRdk49u+Ko8NvkaR0pfHZukxyLcE
 ZWUFb6BdMl8xPI2vWxLrzXdpHg2hS55+fqbTrtZHAazA/2vNtXTLg1rGDD344359iVo8i7Pw
 d3HIwZEKLNW9hUEqwXueZqQSNQ0Lvjx/oWYlrQQpz4kFJJb9LYpKpY5k3nBf9AGtJP+c1+PN
 eOjt3GvAJlnOzLtT36UIgcXSQuQFgLpY6FKT0verMP35mV2JXfm/qHIC+mnHAe4HRiZ54aML
 PsRBqTJGs7jw5gOWMMchFaemEnEJtg==
In-Reply-To: <CAEc3jaATA-Z86jh=njR6yctguQBRp1BQEFcBQhYT0rYKcA4f2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/25/24 07:24, Roderick Colenbrander wrote:
> Sorry for the late reply. I had glanced over them, but didn't have an
> opportunity for a detailed review yet.

No worries, thank you for giving the patches a chance.


> My general fear is a balance between supporting clone devices vs
> reliability. This driver is heavily used in devices (phones, tablets,
> TVs, cars). There have been bug reports in the past and just getting
> the fixes downstream takes a lot of time (e.g. Android devices).

I understand this very well, which is why I hope I've kept the patches small enough to be alright to follow. If you have a bad feeling about something in particular, please let me know, and maybe we can find a better solution or alleviate concerns.

On my end, I am working (currently as a hobby) on an appliance that aims to support as many controllers as possible, hence I know the choices you face in order to keep user expectations in check, and user experience consistent. See my comment on patch 7/7 - what if someone uses a third-party controller that happens to work by chance, and a kernel update breaks stuff?

So I am with you on focusing on the original devices, which have predictable behaviour and quality. That said, hopefully some or all of these patches are trivial enough to be included upstream. I feel that it's beautiful to plug random stuff into a Linux box and to find that it just works :)


> One of the key things I really would like to see enhanced are the unit
> tests (hid-tools / kernel side now). To really make sure we emulate
> behavior of these other devices well. The tricky part is that they
> don't always support all the HID requests of the real device (which is
> weird as the game console does use those HID reports and others and I
> don't know how it would have worked there).

I've been wondering the same, but without a PS4 of my own, I didn't try such controllers on a real console. That would be interesting indeed!


> That's in general the key feedback about the tests. A question for
> Max: do you have access to all the devices being added?

I don't have all devices I've ever tested, but I do have at least one reproducer for each patch in this series.



Thanks,

Max



Return-Path: <linux-kernel+bounces-52297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5FA849677
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24404282993
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A3212B8C;
	Mon,  5 Feb 2024 09:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="L/NzhZ1y"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9BD12B71;
	Mon,  5 Feb 2024 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707125336; cv=none; b=X/xTfD57Mxy3Ov04ttxE53/s4b8rjoFAJNfRh2rkJjQK1z197m2LLnXwzvrrcvJ08KOGyVid+gUXWthq1VBNAvWrXhRk73WwHMvFqvBGolSivkq2yJxau83+NbcbbkiqokhUrAVx/5+fTFHvR8ADrQQTcf8t0AxOSKeD/Nl7l1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707125336; c=relaxed/simple;
	bh=g9H0mf+7TI03/TpL+Efn6cRRTCfqLHMm2aPY9t9yYj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uf2GbgbNQn7FV06m7YcVkHFzxCXpOmGj6whxpquBhcAkRY42WTPk24y70OWbyWiOx4Y7aplZxPUNRDkMDLe0PWC1Wm+ndmHpdKCW63OkYNzab/Z/Fjix7hJ8T10Z5gj4C4bD1p87OvpCtRGsZzCY68kM0QAGOWc4rihgUS5LfyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=L/NzhZ1y; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707125309; x=1707730109; i=deller@gmx.de;
	bh=g9H0mf+7TI03/TpL+Efn6cRRTCfqLHMm2aPY9t9yYj0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=L/NzhZ1yJY2gCugREzTjdYqWW2YHSKra6gwIj/qEfmkx9KnGG42L6SMBinBH5y4y
	 2glUiMwJgTuzS8tAeyvWrDXuET3CT/Rb5Tiokm+uoR4f7UbYxe7fQJLdb16PqMLnX
	 bv71YZ+sL1MgYKAWutWXMXAUNGIxIEkpA0/ZRR9Wa7e8IWr4FPnkJGdNs1F9Z51Kk
	 Uil0w9BTKF3HyEQHb3LJoHK9n23r6qluduOItDkil3w+SYUIaWTCzAsHGta8GR4zD
	 cJwny177Qtg/Q4z+m8LpbE0diz1sMzH/hbMvqyadNRBJoQvyYwnVvO3BIhij2lcFH
	 J4z9g7JCwaczPzCEjw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.145.139]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MN5if-1rGm081kN3-00J0kv; Mon, 05
 Feb 2024 10:28:29 +0100
Message-ID: <929506cf-a1a7-436e-938d-4e5eff0181e4@gmx.de>
Date: Mon, 5 Feb 2024 10:28:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kunit test failures with cpumask tests on parisc
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>, Yury Norov <yury.norov@gmail.com>
Cc: James.Bottomley@hansenpartnership.com, linux-parisc@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org
References: <e6f0ab85-5bbe-41c1-8976-5ba00044998c@roeck-us.net>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <e6f0ab85-5bbe-41c1-8976-5ba00044998c@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JymWDCErreo80xVCyd8jlE2xAcHkgqBcL5N5nOlm5og7wHnxL7i
 4hcGdOB3iYQdSh4NF3Aa1OiMb6paswhX7vxPswVABh6ynP9LrqGiq4rNgJHGGa5I+Wac4hm
 QWInyf+RCKiIbrrn4rZEdq8sROeXLxS7PKz5BSn1X1svL2xVDoL/wpZlS4wFgA+7TltytSW
 fayf+Y8QlC7dINRfbVSYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jSmwCNqrguw=;n4OxuDS09MLbyxqOiWCyy+nDdGK
 aPUU43ZXyjOgLHJUIzfAPgpOZusXNYEcos836sd/UNOwFrfFnvdjiNsiRULxXfKE0CsOxio+s
 EHzgZ0mN2dLYdZ9uJXY2pxgaXUypG3WqlGT7Umuu3ioe1iEbPInABUjiEq4lBB9Rj3Ro8kWlB
 8tavS7RhMulOQoHOBJiFlM8X4+Vyw4lJUjSpgK2fRTdp9UeaxcPymfUxwfDfZjeXaTDYQKT/M
 axAi0gI66v9hT5j2v9lfrR8OWU+Pxy6XaRG1H0gLDDF9YFOtHFk+h1pgnUogsymhPAwoiBPkl
 deRrogeQziDarIdO++LNAw2feWx6hE8AnGeEhV7ryV2Ut/v+tiSI4355NjViLBwoiUVW8XDkt
 tPkqdFMHyrZ0MmjO3DVUiWfjm/bF/onhhb8lypLcFsDkZpAQQCUk91DNE+g7m7KfIZ8IqWMeq
 ULNMIg0gJJVAE8UqEMZUk/ck3U07SKehiyFMYgI05mjINLjqOyUUwgRdthJ5kxZJL8EHTowBS
 6IOl9bQww4QULUoskvbngtFQNfbwRU3GBmbwOEBKNoSqnqkvtR+fACUneMG9D5ug05CtYUh8T
 ggUIIm+eMc65ybYkP4OXc/yshO5Wx+ovu2oMO5NzG4lXE4TxuQ2o6U1wnWrd2JGQUSTtOwDtV
 aarsbhPyA9UPYgxeSCSznkRyztOipak8FTxZGb7ZzXegbsLIy7e4JeGJQC80Gn+CUkH+5L1Wq
 krpK3YVa2jkc6nbJbdZV5TPfn0GC7hbWchKE1IUTvmpVr2Dr67MZoIEEWz5oNfWV3SXcjLzsM
 GtGZAO3CACowN1uwQyVmHxiugdko9Cp8dGRwBohCWXumbP2/++O5cfF1TKRALkDAcI/XsYbL4
 CCZfvSR8ltSuFbg==

On 2/5/24 07:53, Guenter Roeck wrote:
> when running cpumask Kunit tests on parisc/parisc64 in qemu,
> I get the following errors.
>
>        KTAP version 1
>        # Subtest: cpumask
>        # module: cpumask_kunit
>        1..6
>        # test_cpumask_weight: EXPECTATION FAILED at lib/cpumask_kunit.c:=
68
>        Expected nr_cpu_ids =3D=3D cpumask_weight(((const struct cpumask =
*)&__cpu_possible_mask)), but
>            nr_cpu_ids =3D=3D 16 (0x10)
>            cpumask_weight(((const struct cpumask *)&__cpu_possible_mask)=
) =3D=3D 1 (0x1)
>    cpu_possible_mask contains CPUs 0
>        not ok 1 test_cpumask_weight
>        # test_cpumask_first: EXPECTATION FAILED at lib/cpumask_kunit.c:7=
9
>        Expected nr_cpu_ids <=3D cpumask_first_zero(((const struct cpumas=
k *)&__cpu_possible_mask)), but
>            nr_cpu_ids =3D=3D 16 (0x10)
>            cpumask_first_zero(((const struct cpumask *)&__cpu_possible_m=
ask)) =3D=3D 1 (0x1)
>    cpu_possible_mask contains CPUs 0
>        not ok 2 test_cpumask_first
>        # test_cpumask_last: EXPECTATION FAILED at lib/cpumask_kunit.c:87
>        Expected nr_cpu_ids - 1 =3D=3D cpumask_last(((const struct cpumas=
k *)&__cpu_possible_mask)), but
>            nr_cpu_ids - 1 =3D=3D 15 (0xf)
>            cpumask_last(((const struct cpumask *)&__cpu_possible_mask)) =
=3D=3D 0 (0x0)
>    cpu_possible_mask contains CPUs 0
>        not ok 3 test_cpumask_last
>        # test_cpumask_next: EXPECTATION FAILED at lib/cpumask_kunit.c:94
>        Expected nr_cpu_ids <=3D cpumask_next_zero(-1, ((const struct cpu=
mask *)&__cpu_possible_mask)), but
>            nr_cpu_ids =3D=3D 16 (0x10)
>            cpumask_next_zero(-1, ((const struct cpumask *)&__cpu_possibl=
e_mask)) =3D=3D 1 (0x1)
>    cpu_possible_mask contains CPUs 0
>        not ok 4 test_cpumask_next
>        ok 5 test_cpumask_iterators
>        ok 6 test_cpumask_iterators_builtin
>    # cpumask: pass:2 fail:4 skip:0 total:6
>    # Totals: pass:2 fail:4 skip:0 total:6
>    not ok 5 cpumask
>
> It appears that parisc sets __cpu_possible_mask to the number of online =
CPUs,
> which is limited in qemu and doesn't match CONFIG_NR_CPUS. Is this a pro=
blem
> with the unit test or with the parisc architecture, or does the unit tes=
t
> simply not apply for parisc ?

Thank you for finding and reporting this!
It's a bug (or a misunderstanding) in the parisc kernel.
Reverting commit 0921244f6f4f ("parisc: Only list existing CPUs in cpu_pos=
sible_mask")
fixes the KUnit test.

Furthermore the revert fixes the issue that CPU hot-unplugging doesn't
work and which I just was starting to debug:
https://lore.kernel.org/lkml/Zb0mbHlIud_bqftx@slm.duckdns.org/t/

Helge


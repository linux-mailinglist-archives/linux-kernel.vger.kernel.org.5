Return-Path: <linux-kernel+bounces-31029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FF28327C5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0A51F23B1F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADEE4C3D2;
	Fri, 19 Jan 2024 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="aUMfllpX"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0673C06A;
	Fri, 19 Jan 2024 10:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705660949; cv=none; b=sbzWM0ANsjY41IRGWw+Yh6LvQ7fN0iger1/AQOQ4m0sovijh16oSWtvi5efetMyoOCFxKtKL03/4SmuRtJpcJvbTXoTBjCj56udRnkoeYNFWub1E7S8YDyE4SUtYKaG5yuRPRHFqzksYRD9p0evwnvYZM80/0680XSM1AY6Z6pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705660949; c=relaxed/simple;
	bh=cO3V1vzVt/XdQPd4h52EbfomnaIJyRP7lYScOtdsYfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uRvMyepLazMTC95RyOREfe1HucQzNnaf+fyE9y9BexWRRcggeHggE+iMxLv5MeyDwLBl075/loGRMzWXs0MNQuQQxVvKd4Ov77gnUZEL3P2kzwRn3oxuhZXTUCK73OCvetKLblRUXs5agqkWnL3c42KpF56aeChGxqXRBYLhob8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=aUMfllpX; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705660854; x=1706265654; i=markus.elfring@web.de;
	bh=cO3V1vzVt/XdQPd4h52EbfomnaIJyRP7lYScOtdsYfA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=aUMfllpXhQp96ch+72qMDLSmcLyDdYTI95M+i9y/KrwZRGGMot0eTY+0rwXCxNP1
	 sdtxYWf+w/xQEMObBPPZEGZ2Bxs0PACvQhN9EjN2YBb5Znd733txOgj7sZL/YpnkD
	 vaIebkxOArHMSUG70Yz4IYTZWfVvSgEX6deyqWAcJ2IrarpPQyGXepDZvUbwXrvzn
	 ZI15Q2evZc1Cc25/KsDRbED7Fjw6NMuzXi8CTg8S0ep7lLH+DgSK9a4Z3nmBLRa6W
	 7eMHYqrbVE4wFqXuEypmjD7JKIxRDBwgD2pOOO4vqL9AR5brc2F6nnyPPNDz6NMhV
	 LpQ1qPF6+/MEXWj4pg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXGK4-1rcI6C0CUA-00Z3qK; Fri, 19
 Jan 2024 11:40:54 +0100
Message-ID: <91af4a8c-d2e2-416f-b02e-5d69553c5998@web.de>
Date: Fri, 19 Jan 2024 11:40:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/xen: Add some null pointer checking to smp.c
Content-Language: en-GB
To: Kunwu Chan <chentao@kylinos.cn>, xen-devel@lists.xenproject.org,
 kernel-janitors@vger.kernel.org, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?=
 <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc: kernel test robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>
References: <20240119094948.275390-1-chentao@kylinos.cn>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240119094948.275390-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ghWwRZ/xa5RiEzFG9SbB0YwItzwhscPRgB036myKdl26mgHPgKw
 VQbfwMEIvEYjgoBwMzGbrC86u73mQWUAltu6JjfaeKhE0StOY0nu7+cgBg/EHNLAO0/X+BM
 EBxxa3DUjgyyfYOV5m3vCuXn9YLNj9tZuWEYayV5ptyDsZtJkANo7xydQln4MmP7NONjqa4
 EUy/959xDksIDzQKmvvUA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Jdxt2uu7/7Y=;HuDpAVrdHwPdL9vQoUbqKiGrS40
 jrr9+Shr1pVnJD5Of/QXY9RNn0QLS8cUxdkrkEY3hPpLtU4ONu5yTqk4gf0qoqVTuGJnOD1Sn
 4UrF12BONo5rcPNaYyf5k0IW3lMsXl5nF472p1Jtx1Go5zQ8wxkQHDivMIkKwGG2AWoMX61ZU
 Hi4/FpxLFYz/LiUddzOcuuxVbJiBPGiaonoQF43MXTxrNGoKyQZ7xsGD3X4KTDkUorVbhbSwZ
 sXHkWnKRV+yASAqYr2MNrkdkuIrgCUTG8vs0YqBg1T+nivDDbNM7kt67VU8jgqMmGR3S+oITw
 q3J23UQ7mfv84Xmg0Q2kWQfRbTDcl7VIbhnpBCsug4ijQ6BcJcxT6r77xDu/Gp19LaRutvHWq
 ikMASjzuT7OfjYcHxu0yiz3NQK20GUuaE4ehx8Ka/Pk0uihwglrabOKlYTwTeEqP9tn+SGyY6
 Iu/nz7+UgqBi2yurZd2IxhwOZ+BezJKN25qru5qAzKFwxuhOdUyCunv7h3r8teyCJ+t2WLjc6
 GAbxLzJ97GbfWnuP423Zs8y/UjUP75u+nPGqSNd5Gpf3fV3/ezW04pzkB3Q7PZYMZtWHB85C2
 HIlKfL63hLkXUDWriYv4ejxh2C4YQPKfxsEXRZDF0wFEsC98DVews10fJgSqVfyOIcyLTApZj
 3I8uM37B4H+d5Gerjo+2NgOB0h5sSMUhhs5syKmsoEgYRKZsVa0/Aj69GIawSRHt9uxDtDWlR
 R2okc37C8jVAGB6hu0wheHhb/K1G8n7ct3UDPNeBm1F/Yua2vuhBObIWg9vSt6OXXWf5nBNaG
 dpEBLuKRz4narT4kDT5Bwag9mpo6h9E2tybPq5PIodGIqJYy5QV7t297S77lifFtdLwEYnr5U
 Ww7jgUT4o5p/aTeMKxVvbdVh+CL/k3q5PrpQ0Bpd58eTxWYJUwx3KS3VhhpciBGDK15c6dp1V
 HIfFig==

> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure. Ensure the allocation was successful
> by checking the pointer validity.
=E2=80=A6
> ---
> Changes in v3:
>     - Remove rc initialization
>     - Simply error paths by adding a new label 'fail_mem'
=E2=80=A6

I became curious if you would like to simplify further source code places.


> +++ b/arch/x86/xen/smp.c
> @@ -65,6 +65,8 @@ int xen_smp_intr_init(unsigned int cpu)
>  	char *resched_name, *callfunc_name, *debug_name;
>
>  	resched_name =3D kasprintf(GFP_KERNEL, "resched%d", cpu);
> +	if (!resched_name)
> +		goto fail_mem;

Would you like to add a blank line after such a statement?


>  	per_cpu(xen_resched_irq, cpu).name =3D resched_name;
=E2=80=A6

Please compare with your subsequent suggestion.

=E2=80=A6
> @@ -101,6 +108,9 @@ int xen_smp_intr_init(unsigned int cpu)
>  	}
>
>  	callfunc_name =3D kasprintf(GFP_KERNEL, "callfuncsingle%d", cpu);
> +	if (!callfunc_name)
> +		goto fail_mem;
> +
>  	per_cpu(xen_callfuncsingle_irq, cpu).name =3D callfunc_name;
=E2=80=A6

Regards,
Markus


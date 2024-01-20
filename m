Return-Path: <linux-kernel+bounces-31819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF2D83351C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 15:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094BC2836DE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 14:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2923FC1E;
	Sat, 20 Jan 2024 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="km7MGfgy"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7069BFC01;
	Sat, 20 Jan 2024 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705762359; cv=none; b=n/vQEn7XWgVKhWbu/mgZtnuaFKbGiGUz3uZx6JI7uEwqo13/qtESagdmVnvMp5PwQDOhAHpCQhTvhW2WC3nm2hnkiFrVKb9DIam2JhoqCR+8g1rR8jBbr7fX5m/BT4oYtTqwq5cbc2xd1M4bAiPFL8FihOBBJBmw8QHr84vUpBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705762359; c=relaxed/simple;
	bh=7y4p5pvIngJ3aP5NdJ2PdSmbuGEVhNmS9q08S5a8BFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQV0QrOwGyF1IvLR/EwVdqRP7lCG4xwUHOC9QNUAVwseILufqpUxLIR0g+KZukIjHs914NSJAUHIWdf7C40clrieuPhVJqPXcE4xUY5HM0bS+j46kH3Ic4ZbKtE3GqCRA400ohhjIpku/Bhyky+G66onaCJ0lV8nGa9eRWii/h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=km7MGfgy; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705762336; x=1706367136; i=markus.elfring@web.de;
	bh=7y4p5pvIngJ3aP5NdJ2PdSmbuGEVhNmS9q08S5a8BFM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=km7MGfgyLOfuo8lXhgVhudRr5SaQ3CDAQ8y1EpIpCIVP8w6/30UXRbXNKur8dSwT
	 xcdzEa3RQl1nJEVOwukFygMFVrbGWJ3//tkQcSHaedc0gS14xNkbEsu4m7FL94wNT
	 S/QlyPhKQ+76lq7g4aq/dh6uR09ZUmraTXYDMgTRBDOErLhbAASsKxXhIZBQvJwVu
	 p61hbswhcFamQniIzCUcE2cfBRaU6kQOZ4Q7CdqOjvfs5tnuwqTbh3bvZP1L7jBBW
	 kxNPvv5zl7CG94I/XlcYKf5Dvq8UZX7Z3Hxou3EAqPjtzKyC6Y0MdZjC/fwvlwaVr
	 NRnFuaJvR6NJazoKUg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MxYbN-1rBITt3fsv-00xdP1; Sat, 20
 Jan 2024 15:45:24 +0100
Message-ID: <26ef811d-214c-4ce4-a9f8-4fa4cfdefe29@web.de>
Date: Sat, 20 Jan 2024 15:45:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/xen: Add some null pointer checking to smp.c
To: Kunwu Chan <chentao@kylinos.cn>, xen-devel@lists.xenproject.org,
 kernel-janitors@vger.kernel.org, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?=
 <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc: kernel test robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Ilya Dryomov <idryomov@gmail.com>, Jean Delvare <jdelvare@suse.de>,
 Jonathan Corbet <corbet@lwn.net>
References: <20240119094948.275390-1-chentao@kylinos.cn>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240119094948.275390-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f7xX5lxSHQgJlr4n1BCo7mY8k5CxgyoVCcwDx8vDb81qa7iinjp
 ygTbFkH+h1w/S5ZoMSnj08gwbxWJGFxt9wXsJdUQHSaxAWNG5h3hUKEK/epM8rFwt3ZMsAe
 GGoA1wFozLQEI4nm9mmzNp+YSVHpveqj6S7m9BzPY8ezDb0rPR16s07u5MxZ71jjWEdHQKJ
 EXpaFRb580g4W1z9GL0AA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kvTIFKx34dg=;JrM0jCAeZHWaii5y7r7dOydzsH/
 uXaPcxEWXRFr2x7CuC9tO4Fowq8H82DgAA9WsJE7G3dF/pGzBlBdX7yg/h3FW1dvxZ7L9Bwq9
 YZqtkhcz7oiOllmFXulWXXT8TUiwbuWCOGHS9iggwoMw/g+2VnSJGIUJmgTWjS4UzANjh/x8r
 eV+3HlqoINvOWjVtUuOHipjU4GMkO2781Z9VPLzD7KVuAjRjG1GbHXRkM/V6T+ySE6IBfW4z9
 yJBjfaG/o+nVaI4+cXQp4LaSAmTJL/mcxR8a1oLSaX/20AYUZtOAFtdXkrbH/zozqQPMVgBO0
 338sa0VkYV/U5B7/pshxyVNRbkPcVp1uLHN5CpFbRuo1VPKellG0ELlimWWqkEKK+raOwkm77
 65R5IG0fcJI7961Jef2v0osiTeQRTAr1bjx4sOTPNRKUzpn0NC1DNTjT9kgMtaIFA5l/AwkoV
 29NZ6m17PJdstEsfstnlaLUFQ+fWKSfE0e6No3OmLgbKXK0LKAauriHYkvhk3ewJ203myG2IU
 YJwi0gk9FezgwmACzyQT4pSCrgHf4impbKFaitG16dTeUqtdaTI8h6hEg9OkwoMivrwg+8bem
 6+xvc0SZnrruIWxGGmMczQKyCn5YwG432j8o8B6bIlMujwOgJJIb7JpRmCDwmhIRWF0qkEgU1
 JJ17vy64v+HUOs8t7BQFXbIGnlVXzzpLzhhUptkCMiM0HxkAFCTUf2nXlxRhGnOM91PfKNaQ+
 usRxHngFEVveI06mhCDkJaYP81rbsGAuYhsNKTGOYB2nRbgfO84AC+0J3ghEHIAY+qF8iYBF8
 nX4ixznIdAaK46dT0S7yj+0kPZyD0h4nXAp+qIF7aTGuuIH7FtFCxT8mO7hK6Qbs6uBydatL8
 H6fRRzibSyunhrkNZztI73denc0+gR0SCUWmQrnIQtgMFAqoZj5rayKloIyeG+f5/XW9QgxOf
 ra398Q==

> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure. Ensure the allocation was successful
> by checking the pointer validity.

How do you think about to refer to the function name
instead of the file name in the patch subject?


=E2=80=A6
> +++ b/arch/x86/xen/smp.c
=E2=80=A6
> @@ -114,6 +124,8 @@ int xen_smp_intr_init(unsigned int cpu)
>
>  	return 0;
>
> + fail_mem:
> +	rc =3D -ENOMEM;
>   fail:
>  	xen_smp_intr_free(cpu);
>  	return rc;

Is it currently preferred to start labels in the first text column?

Regards,
Markus


Return-Path: <linux-kernel+bounces-83359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77848694B2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D98286B08
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181AE145324;
	Tue, 27 Feb 2024 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="Uo1YuRNK"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC69013B29B;
	Tue, 27 Feb 2024 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042117; cv=none; b=CLVBHrwxyyjg1Opjmy53Dq9jsOmb+TZHsVo9NjvqwO44aP0bYIjp19JsI/OuklJfh3yruMZtdw0MBltzkjay9YAPVkN8yFca1bhce+6hDS72k7k4pJ4Z4ZGNXyQXdKzrvoCSSARigZDkfDoVw+7GwcYkPF/gWrGGA6iJuZ+Jgiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042117; c=relaxed/simple;
	bh=HGGO3MU/eeqHbARDqKo9ThxHWt83jFsN9Hq6Lxh3rOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cG9plAVv3ahrS2tSTH8FbSFH9TlDj3d12lsPfmMMNPN8wsSIBMlp2IWSVv/kqlSjZMBNQPxZreVzALZhohsUfEz4s4db+DXCdOKuv1x6cRGBXU5WYHAPaSeXv7T1oKFfl73ijt0Jg4CiHCOaE2OB1eVN8wxYW2OtkoEINLcikiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=Uo1YuRNK; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709042040; x=1709646840; i=deller@gmx.de;
	bh=HGGO3MU/eeqHbARDqKo9ThxHWt83jFsN9Hq6Lxh3rOs=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Uo1YuRNKdRFudCtP9NBwGZ/BIMlYJ8uouEe0MIzezHHQsbOczbOK5c6g3wDOBpgp
	 8aNYr5k5QtLpOU5DhVK97DEBS6VKK01fGKBut0z1ivkd/JLzdi4XcDH2xK+YqzOny
	 3SYxQf15vg1l6qqpm8kJ3pJh6XeVgfdRdq9Cx9H2fwTO2iPbLgwGPMexB+dh9XaCz
	 QVdlLqhsWpev4WQqb5Gp3ZaZZWa3iiK9LOP1h2jdhcu3A/q4o8XJaUEluf3ELxTpF
	 rxceN+zy0mN2DmM7qd2ZzWy8AGSSZB5I4mNcLbYQLUBLpsgsXrcCW3vd6JyVTQ3GI
	 qU1P9CAIKsKILiVGPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.6] ([78.94.87.245]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQvD5-1rI5xY47kt-00NvTX; Tue, 27
 Feb 2024 14:54:00 +0100
Message-ID: <951c6d29-ef8c-43ce-b91b-fcb905198f80@gmx.de>
Date: Tue, 27 Feb 2024 14:53:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arch: simplify architecture specific page size
 configuration
To: Arnd Bergmann <arnd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Kees Cook <keescook@chromium.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>,
 Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
 Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Andreas Larsson <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>,
 x86@kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
 Andy Lutomirski <luto@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Kieran Bingham <kbingham@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org
References: <20240226161414.2316610-1-arnd@kernel.org>
 <20240226161414.2316610-3-arnd@kernel.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240226161414.2316610-3-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hQzjzd7p5TM5Kw1mzvAh+YheK9ajjziFjVP/rq6z93mOcW5SPOs
 e6zmoNjX63XqeTgBwmmYXz0rXFuKFvd8XC66SD7FfY+WnPNGx2dtMFhb8xJts0RVw6olrzE
 lpJ4rkVeLTnLvlzJf86dorWqoPaHA4gaQfDDMpVHU60xM+wJfVgHYdRp1Vf0oMb26RgCcoV
 x700IvlTmiQiOzHig96HA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JL9i5HKn/14=;K6/YQ9sF4WAtWoetrz9CHb8JPjw
 eHbMooc38h0sAzTqwt6CWi9CY9pNLE5PZHFmRClaQ7ahEw4VwiySJGmkYbImpC3iQu7y7/muL
 iD5vZ42b3nhcfkWSs2vmsG023U3cqDhmf6PssAJkPd7wSKleQWPnF148IFwAFzZwaKKj5UyAm
 lnsfKi7NkNUboWKdcd3W/N4NiFVuyMb2faYznKzvLDjGmBv/HXwuwMOXk00b/jzVM8E1inRza
 Hd/r1UOPnRhbh0ONIjuwGG1/R180mk4fwSD6B4uFYatFatTSEMqlWWp48lPQd6Zg+a0FkwzuK
 LBH91jUQfP+VZiPXH91lMpmn9+AeTD2BD74SfaJFSpnMzTa3/FIgLuzbONAEkr0CHZaJw/0Gs
 UAkusnK5RLsA7jRYcsewFqPl8tN48HW0M/hTiYJzkrgKC6GLEZNod4eidd7aJzXJyo4GkLsqt
 Bz7kopSndiJQbjykNCEdinVZb5FNzMpl2H2WiH1QjysQuzHKkHBlMY4ZYg+8XKT0st0gNQcUv
 dy39a5hGCVENqqLUMv8DICeuMNSTPSsPaAlfrGgWrQ7kMVYoATx1CAdd1WFUDLlMdWHn7SWNz
 /NnPmpgO/X2L2LLcr1wGcF0bCAekeo2XJtJnuAyZa6yoiFQdSKAnCXN3NWY2sjODF9heXndiR
 nVTI5o3bjKgD8r7+07ugQhP3Sq477uKRmL139SAtRRfWUv3fM2ArEnlKyp2Y6obX7qxBdJKVr
 FcjlGLpAT0mIcokEJvu5q0m05Tw7YZZB/W0o6l9hk4OUwgx5Zx9NLXPfV97cq/G2OcI8NkOgl
 dJriZcRah6Tep44PJPV878JpPqr6hHqfVWEAd8VmB/6Ko=

On 2/26/24 17:14, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> arc, arm64, parisc and powerpc all have their own Kconfig symbols
> in place of the common CONFIG_PAGE_SIZE_4KB symbols. Change these
> so the common symbols are the ones that are actually used, while
> leaving the arhcitecture specific ones as the user visible
> place for configuring it, to avoid breaking user configs.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/arc/Kconfig                  |  3 +++
>   arch/arc/include/uapi/asm/page.h  |  6 ++----
>   arch/arm64/Kconfig                | 29 +++++++++++++----------------
>   arch/arm64/include/asm/page-def.h |  2 +-
>   arch/parisc/Kconfig               |  3 +++
>   arch/parisc/include/asm/page.h    | 10 +---------

Acked-by: Helge Deller <deller@gmx.de> # parisc

Thanks for the cleanups!

Helge



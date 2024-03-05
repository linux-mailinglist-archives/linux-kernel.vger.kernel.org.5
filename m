Return-Path: <linux-kernel+bounces-92787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4888D8725FC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3960B26FC0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7871517BBF;
	Tue,  5 Mar 2024 17:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="svBNJ8o3"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0117175A1
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709661046; cv=none; b=FXa3EBRV5ixCq5mnKmL5+4fi9eMQvjZz4VwrNr0JOz4FKLTfQ9GqwK82wNCgxrRFsM4jJoJTiW9vCO01AAskOpACXM0NFpaIHAdVWC4qXhr9yxPEXMQo0Cez6RkF+EOCy9zv8eq/Jfdvf7Q1RNljb3l0uPWYHZEKPGOPxdJPRAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709661046; c=relaxed/simple;
	bh=gaD5NGVa0EnCxj9c3TXhPd/2JfBhznddbAsKW3/SWM0=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=lsrNqUrZ8xPTPuB8h133jd5ksTTDJNAOn6M92eEjs+tnGg2J6QLaD4VUxplH//lcASfFDUBZCuHv4sHafqV4a6LuJJi+ioUI6y01QHexgMfGOtfGE0xOKh51kNx/qUQptQ0y19FvjGaFJozqWeL7TdIlIEf6D1eT9EdytB4r9Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=svBNJ8o3; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709661039; bh=g0VikDDZHRPX1F+raT86tLLC0uFSiNwgf0RrjwgjTDQ=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=svBNJ8o3d+bbf8B6s3jzYt92tvyGNr3k04oMMXGszHCWhcV+grLEu4nIgLYysgT1m
	 4bT04oOtinym5ew8wMgfe+kkOWpwX0Qx+qEqvIauzoEQqrPO1iYGcdmVt1d5QmVY/G
	 lE8j9LfoPP1EIEYBVhWFPKVh57ccO55VQ+TfLeRo=
Received: from smtpclient.apple ([2001:da8:c800:d084:84f7:c158:bab8:8899])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id CA3A6E33; Wed, 06 Mar 2024 01:50:35 +0800
X-QQ-mid: xmsmtpt1709661035tuur2m1ml
Message-ID: <tencent_AA20462764AFF185EF405043DBC99119F705@qq.com>
X-QQ-XMAILINFO: MqG4KXyEKpQye6Sjmokj1B8vEqsYsqQnANZBIE4uyKBM4b5RwTTrbxPOnZHCQE
	 KRRrkBsbf1ueRLgIJ7T5wutix5QYmVTMCSqaXaljN8cql0RcxLes6XLihiYdbzps4oDNvTZOA9Fu
	 CBVavCNUSqx4vcYwRBtCCOt8vAEyJVyMJqQRhzR7R4gNR8oe3og50qFzGCntxAVPNiLcFXoT2cXA
	 Vn5HAln+26uVyyXY4hX0dRRtat24JWwKnOiNsZehzXslBakYPNM/Mp5D38c1ip/6wEaHzai5L3Sj
	 04VHEi6a/wWDyyt+Fes1wM1KauEkaAQMB/BwRNb2b5P9gR5lkSpVUSJbnGM28EyaQl5X9IcmquE9
	 8rRifQolFDLvNi3aVyVvZ9I5j5ggoSS9yvRORyBtCQddSVeCK52fHn0Af9XO0JLWs5D8YOcD6kzI
	 ppY2rTiLFnrn9Ylq4pAo0m0PaOckv1FzTlfRBguih3tze5JTyOAme/kfXFbymLmiWp07GCSxi6bs
	 8ZmIQy4mlbUJphJW8vpuCW8xnLeKPAnJLRAaNBn/1vXYvsy+pNZopKsMeb0/HoIYHhKmsCHbnbBX
	 u31zi24Hj3Pz4pp9D+eVPixgXHDowZRB/NtpXp0qykbDFZ/l5A/EzK9dUezWAxr3hMZFCWbUMEeu
	 LQp7e4K2R9/lYf1Ue49cAD2ICig/OIS26EFTFo9wHdpvQZwCz/rOuJXh9CfV9FIaQtkN8K80nPKK
	 /45G5FmwHjkGMGXXHDs2b2HnqfSNFT4YTDcNoNT0IJ10Q4bbFvCYUwWQ+/muBk9TBhQbhs6NSaWD
	 QyfqrAloAxFlSwQuLKZMHkdr2Zd6ulYYW+yLgsH9gDDsdgPtu2kYw+MLKMgnT4UsDpUtUHubxrhs
	 WBvPuW16BnOPtUWzPiUy45TLXrxu6clqdu1x/sBdZDqGdvYIXboSCuzgh3zTd6k3u2gf7qEKJA/b
	 p1JkaQyAAMprbAZFxFm17RoryXI97zMfGZYu59RkCeLC6Hre2FlUaCpWZA0MzE71teFaVsELU=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Resend: Re: [PATCH v3 5/7] riscv: Kconfig.socs: Allow SOC_CANAAN with
 MMU for K230
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <20240305-fascism-enrich-06483ddeb149@spud>
Date: Wed, 6 Mar 2024 01:50:25 +0800
Cc: Damien Le Moal <dlemoal@kernel.org>,
 linux-riscv@lists.infradead.org,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <066CA89A-31BD-47DF-B540-D1D5844B8597@cyyself.name>
References: <tencent_BB2364BBF1812F4E304F7BDDD11E57356605@qq.com>
 <tencent_0432DA968E39B81431F921F38D747C008208@qq.com>
 <ef8df22f-dac8-4652-bf17-d10254e6abfb@kernel.org>
 <tencent_E56A833916E00EC7B4840C34FAF1250ADE0A@qq.com>
 <20240305-fascism-enrich-06483ddeb149@spud>
To: Conor Dooley <conor@kernel.org>
X-Mailer: Apple Mail (2.3774.400.31)

The last email was not received in the list due to I didn=E2=80=99t =
change the mode
to plaintext. Sorry for that. This is a resend email.

> On Mar 6, 2024, at 01:20, Conor Dooley <conor@kernel.org> wrote:
>=20
> On Tue, Mar 05, 2024 at 03:47:15PM +0800, Yangyu Chen wrote:
>> On 2024/3/5 07:46, Damien Le Moal wrote:
>>> On 3/5/24 06:05, Yangyu Chen wrote:
>>>> Since K230 was released, SOC_CANAAN is no longer only referred to =
the K210.
>>>> Remove it depends on !MMU will allow building dts for K230 and =
remove the
>>>> K210 string from the help message.
>>>>=20
>>>> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
>>>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>>> ---
>>>>  arch/riscv/Kconfig.socs | 5 ++---
>>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>>=20
>>>> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
>>>> index 623de5f8a208..b4e9b7f75510 100644
>>>> --- a/arch/riscv/Kconfig.socs
>>>> +++ b/arch/riscv/Kconfig.socs
>>>> @@ -75,13 +75,12 @@ config ARCH_CANAAN
>>>>   def_bool SOC_CANAAN
>>>>  config SOC_CANAAN
>>>> - bool "Canaan Kendryte K210 SoC"
>>>> - depends on !MMU
>>>=20
>>> This seems wrong to me. The k210 support does require no-mmu. So why =
remove
>>> this ?
>>=20
>> It just allows SOC_CANAAN to be selected when MMU=3Dy. With this =
patch,
>> nommu_k210_defconfig still works.
>=20
> I think the concern here is that this would allow people to build a
> kernel for the k120 with the MMU enabled, not that the existing nommu
> build will be affected.
>=20

Aha. I don't think is there anyone will try a build with MMU on
K210. It only has 6MB of memory available to the CPU. For rv64 if
the S-Mode software starts at 2MB, it will only have 4MB for S-Mode
Linux. It's hard to trim the kernel and fit in 4MB and even preserve
some memory for userspace.

I also tried to make nommu_k210_defconfig on gcc 13.2.0, it produced a
1.6M kernel in arch/riscv/boot/Image. But if I use nconfig to set
CONFIG_MMU=3Dy and rebuild, the kernel file will increase to 11M.

> Maybe you could squash in something like the following?
>=20
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index b4e9b7f75510..75d55059163f 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -72,15 +72,19 @@ config SOC_VIRT
>   This enables support for QEMU Virt Machine.
>=20
> config ARCH_CANAAN
> - def_bool SOC_CANAAN
> + bool "Canaan Kendryte SoCs"
> + help
> +   This enables support for Canaan Kendryte SoC platform hardware.
>=20
> config SOC_CANAAN
> - bool "Canaan Kendryte SoC"
> + bool "Canaan Kendryte K210 SoC"
> + depends on !MMU
> + depends on ARCH_CANAAN
> select CLINT_TIMER if RISCV_M_MODE
> select ARCH_HAS_RESET_CONTROLLER
> select PINCTRL
> select COMMON_CLK
> help
> -   This enables support for Canaan Kendryte SoC platform hardware.
> +   This enables support for Canaan Kendryte K210 SoC platform =
hardware.
>=20
> endmenu # "SoC selection"
>=20
> (Which reminds me, I really need to go and finish sorting out the =
ARCH_
> stuff)

Seems like an idea if we want this consideration. But I don't think we =
need
this as the opinions shown above.

If it should be, I think SOC_CANAAN should be renamed to SOC_K210 or
SOC_CANAAN_K210.



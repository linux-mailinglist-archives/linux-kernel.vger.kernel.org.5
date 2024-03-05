Return-Path: <linux-kernel+bounces-92840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F228726B3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4D81C2328D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4215A1B26E;
	Tue,  5 Mar 2024 18:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="veynD+Aw"
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA4B18E06
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 18:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709663917; cv=none; b=ryU/gNIJtmQFLAos5Yj2ospHuxoHkYkYxaO4PudMK8d7TdEJ0ywSgmWyiHSQTnM1GZeSX2Nx5hO/RfkJ2u0+P6+ZhrLl/2II0FoN9Wd2WcIFDPXWwLwre6dRYXZ09dGBV00x94Y9XQ+j+q7uLvRYle0ZYUIO4qaPoUwuVZwSHCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709663917; c=relaxed/simple;
	bh=ccsmIrPdFMrT28j3xA5dnBLiiglBPka10Yd9UzuHo4w=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=kf73kosUQeQ+vzBHFXJIwXwLBZXscIzqUZTxNV8cnyj7yAhjOwW8i6pxTXcpnHShRBQu3SrpsSVDBic2ulAA18YCK+ldhqMrc+1NowndpgRZThuqkp5ZrMcjw5mh+5gcj3ON258xZJcHKwmkKd+/GSVkdEVoSd6QNt3yuY3Olug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=veynD+Aw; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709663907; bh=d+kTQqs56hEdA/J+nt265wjTS9zlpPPPEe2AQ1DBrK8=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=veynD+Aw2I3sKUgZ/UqsUoCQPs7xDBHtxQK/axq/rj4oN8US50+n+zHevnb5+f81w
	 brxWZd6wkCPYKs0BrktcXHCV7T/+Dx5zV5VBWGejURRl+nVS4X9AVT3BHvssm2h3/Z
	 Cuk9Pv6O2fQCdwHa1vdqsLWorIfUtp/GCUJ2XPCc=
Received: from smtpclient.apple ([2001:da8:c800:d084:84f7:c158:bab8:8899])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 81283222; Wed, 06 Mar 2024 02:32:18 +0800
X-QQ-mid: xmsmtpt1709663538tl2ajfv2w
Message-ID: <tencent_4B189E90E5C66BBE3EC1386D32C715DCF407@qq.com>
X-QQ-XMAILINFO: NJ/+omVLhVgagmpidtm5HSHBgBqIXOrSOPIHRoXnn6toxcP2mSDvTvhAT4+3eJ
	 Sa0aDbfx+/GgyXyxqSa/eaVsT/ozJp30wkBBZHgmP6RHaE5PRqQnwLRJEpDCcFkE4FdoHidjzEte
	 XvEyL5qAeaeZyGTsjtar6rYrLT85pxfca6/Qtnz6dpea+lmdufCPCcvDGqaFPrdwXJiieH9Lg080
	 6sf9X4nD0a2rXUuCERx+Eptb1pAmDhBjvYZT87nCoAapCau0r7wlKBWr/pEUaeTK06qxLRhGdqWh
	 +pP/Itxm7tMYSjE/jft0vUSs4/cUve+FHOXjtgFhZdCz8450Tf50tVjcS8GhT85dzU4x7QXdICuo
	 yIYhtdgFYu7hrpiBUhD8bV+mUvj/kgSfrpp1rYkjYFn6bO54KeohAHD+fO1c+r3kYLL7nhbE41Vp
	 I6k7HAmovJOZPBt/nEXqHKfdMNXqSEOzLQV60J+saHB9WFnribuH8HtqXdKfKD9hf/eAXA8FSvGc
	 aJHIlWTKeF0M7v8fAPkPpaB6ePdpU+/p2CbCwmlqA2XFlWutSZr/xl9uyE4otZrPp4u7BtzI4ibv
	 4wlS93tVGpmgZhI4FtCyLV7QuP42vzIkzCvX9U2Y34UCDoYfJu9NHLMBJrw7t3LIm+bkTCPE56w6
	 L63LpPBKQIi1NA7HK/PbjU0Z0anfDnWxto9s+GoPDz40v/lOE6nafb1QoUrUfqQssYboo83uufI2
	 O07JXdwpA0VegJnJS25eISXxPNuosMiqbrJaaZRAHmgVkHhWQRxWwiB5wn/Q/Zb7bwlvh7Lvdgkt
	 VvWiIVcEHm8xk10ytYjV+BpkCA856C1JVbPkSlPY5d9yHu4/i9//M7oMTpHofRpP/zVlihEKRSBb
	 lfvs0OUqc/kpb6N8HDTjt7OIfCUHxdpxaMkehK3n0eccsivWS6X56W5ebDVR21Jju0TZK2Rzcfu0
	 kCexfBUfhoBUJuAw7qOQ9QYEpI3DHM4SlTf4DpktPInYZ0QGOzcmomoAFxHqOXi4/JnEm2FI+fvj
	 LPcndT/O1/UtG/gBsvF7fWyf9nCNhYgO8Rt7B0hVn8bFJeJ46p
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: Resend: Re: [PATCH v3 5/7] riscv: Kconfig.socs: Allow SOC_CANAAN
 with MMU for K230
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <tencent_AA20462764AFF185EF405043DBC99119F705@qq.com>
Date: Wed, 6 Mar 2024 02:32:08 +0800
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
X-OQ-MSGID: <444AB6B6-283A-49ED-8CEF-0FE76A4B5DB5@cyyself.name>
References: <tencent_BB2364BBF1812F4E304F7BDDD11E57356605@qq.com>
 <tencent_0432DA968E39B81431F921F38D747C008208@qq.com>
 <ef8df22f-dac8-4652-bf17-d10254e6abfb@kernel.org>
 <tencent_E56A833916E00EC7B4840C34FAF1250ADE0A@qq.com>
 <20240305-fascism-enrich-06483ddeb149@spud>
 <tencent_AA20462764AFF185EF405043DBC99119F705@qq.com>
To: Conor Dooley <conor@kernel.org>
X-Mailer: Apple Mail (2.3774.400.31)


> On Mar 6, 2024, at 01:50, Yangyu Chen <cyy@cyyself.name> wrote:
>=20
> The last email was not received in the list due to I didn=E2=80=99t =
change the mode
> to plaintext. Sorry for that. This is a resend email.
>=20
>> On Mar 6, 2024, at 01:20, Conor Dooley <conor@kernel.org> wrote:
>>=20
>> On Tue, Mar 05, 2024 at 03:47:15PM +0800, Yangyu Chen wrote:
>>> On 2024/3/5 07:46, Damien Le Moal wrote:
>>>> On 3/5/24 06:05, Yangyu Chen wrote:
>>>>> Since K230 was released, SOC_CANAAN is no longer only referred to =
the K210.
>>>>> Remove it depends on !MMU will allow building dts for K230 and =
remove the
>>>>> K210 string from the help message.
>>>>>=20
>>>>> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
>>>>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>>>> ---
>>>>> arch/riscv/Kconfig.socs | 5 ++---
>>>>> 1 file changed, 2 insertions(+), 3 deletions(-)
>>>>>=20
>>>>> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
>>>>> index 623de5f8a208..b4e9b7f75510 100644
>>>>> --- a/arch/riscv/Kconfig.socs
>>>>> +++ b/arch/riscv/Kconfig.socs
>>>>> @@ -75,13 +75,12 @@ config ARCH_CANAAN
>>>>>  def_bool SOC_CANAAN
>>>>> config SOC_CANAAN
>>>>> - bool "Canaan Kendryte K210 SoC"
>>>>> - depends on !MMU
>>>>=20
>>>> This seems wrong to me. The k210 support does require no-mmu. So =
why remove
>>>> this ?
>>>=20
>>> It just allows SOC_CANAAN to be selected when MMU=3Dy. With this =
patch,
>>> nommu_k210_defconfig still works.
>>=20
>> I think the concern here is that this would allow people to build a
>> kernel for the k120 with the MMU enabled, not that the existing nommu
>> build will be affected.
>>=20
>=20
> Aha. I don't think is there anyone will try a build with MMU on
> K210. It only has 6MB of memory available to the CPU. For rv64 if
> the S-Mode software starts at 2MB, it will only have 4MB for S-Mode
> Linux. It's hard to trim the kernel and fit in 4MB and even preserve
> some memory for userspace.
>=20
> I also tried to make nommu_k210_defconfig on gcc 13.2.0, it produced a
> 1.6M kernel in arch/riscv/boot/Image. But if I use nconfig to set
> CONFIG_MMU=3Dy and rebuild, the kernel file will increase to 11M.
>=20

Another interesting finding is that the root cause of the huge kernel is
because CONFIG_STRICT_KERNEL_RWX. If we turn it off, the size will
reduced to 1.9M. Not so much for userspace but seems ok to boot.

That is because we defined SECTION_ALIGN to 2MB to fit with one PMD on
rv64 to reduce the miss of TLB. However, it increased the kernel size.

Link: =
https://lore.kernel.org/linux-riscv/d78c601d553dde791057b54252064221f96054=
6e.1586332296.git.zong.li@sifive.com/

I know MMU on K210 is not standard as now.=20

Maybe I should care about that. I will fix this for patch v4.

>> Maybe you could squash in something like the following?
>>=20
>> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
>> index b4e9b7f75510..75d55059163f 100644
>> --- a/arch/riscv/Kconfig.socs
>> +++ b/arch/riscv/Kconfig.socs
>> @@ -72,15 +72,19 @@ config SOC_VIRT
>>  This enables support for QEMU Virt Machine.
>>=20
>> config ARCH_CANAAN
>> - def_bool SOC_CANAAN
>> + bool "Canaan Kendryte SoCs"
>> + help
>> +   This enables support for Canaan Kendryte SoC platform hardware.
>>=20
>> config SOC_CANAAN
>> - bool "Canaan Kendryte SoC"
>> + bool "Canaan Kendryte K210 SoC"
>> + depends on !MMU
>> + depends on ARCH_CANAAN
>> select CLINT_TIMER if RISCV_M_MODE
>> select ARCH_HAS_RESET_CONTROLLER
>> select PINCTRL
>> select COMMON_CLK
>> help
>> -   This enables support for Canaan Kendryte SoC platform hardware.
>> +   This enables support for Canaan Kendryte K210 SoC platform =
hardware.
>>=20
>> endmenu # "SoC selection"
>>=20
>> (Which reminds me, I really need to go and finish sorting out the =
ARCH_
>> stuff)
>=20
> Seems like an idea if we want this consideration. But I don't think we =
need
> this as the opinions shown above.
>=20
> If it should be, I think SOC_CANAAN should be renamed to SOC_K210 or
> SOC_CANAAN_K210.
>=20



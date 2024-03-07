Return-Path: <linux-kernel+bounces-96230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F20C8758FB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9916B2105B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A88E13A268;
	Thu,  7 Mar 2024 21:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="SGBc9NeA"
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D400C2376A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709845440; cv=none; b=A/ZL98tWVbmwlQ1wJjh/z+Iey9awQJUL/PzBuJLq3Qw+w3rr4MBfrm9EyJINs8DWMi9cL8Hg0PE5kDCItsummrIEstnnBqiYQ5rWlydyQv0AKFDr3A7xJ80tZ/f7gLnuRa8xaSBTsKOlGHh165x6S2sdFQ/EQSZ9vDPsthJhbGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709845440; c=relaxed/simple;
	bh=9wdOL1kQY/+guFW4QFw3BDBx6hrBI+VcB9saEGfsngc=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=kCqKckLQAs1HvU+gBuU1ReIuO1O/ztKuKtvtL+iB8L25194FfrB5PNk5fffL1MKic4c+3ZZBOps5r2x+wFQQiOObEdcJIa/7Ef54LEaeNDrLIvmXRuaFouclftF1GXm5hCUsNEra4V21cZi2IU/swkFwgYZOM8rpwJHacQNLuKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=SGBc9NeA; arc=none smtp.client-ip=203.205.221.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709845428; bh=ILcslGL5KiBT0UroAuLyiR9xQW1TYfMJ9QBrV7cZqgY=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=SGBc9NeA2HPEZcVO0j6yRn09+ELJdZSkRXfhUOW6mbf0yFXTGNzPkYbe0kJ1DAQel
	 o+dRipR8P78DUhEmoZiyYL9/xa0KO6RojiaSTC6023WvWfHBUqEXB+rRE/nUV2YaFO
	 Iw3T7ireHyYbRJGU2ngu6G/aEf+3vP+JkeL8FJa8=
Received: from smtpclient.apple ([2001:da8:c800:d084:3ceb:d122:f739:7103])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id ED036EB; Fri, 08 Mar 2024 05:03:45 +0800
X-QQ-mid: xmsmtpt1709845425tg7r8viig
Message-ID: <tencent_FF86EF51905CFBDF1102F721663984B2F105@qq.com>
X-QQ-XMAILINFO: MjZkc9TfnG+XBf4pOjkLwGkiLxvORHG6HQ2COPhjIIZmP046+YvS1B43jWTfLp
	 MTDp3htXS21B+IxChL+E0RMIj82edeY+voSpKQoIy/x/XmsyY4IXd5/J+kVemx34tVIBLU5qSHjb
	 dWuNzw/btFbtk2+O7setlKTz1rDUy0et6AQFPsTu874uzNBva0ZJWXGAMvRy7YoQ4Ewi1ElVDACt
	 AXCU66LW2qxtFHTKWDKsHQbAdAUY/pka7OShqNTyJSNsel6h2kXEwvC+oKyzSlvYJ0g3IqBFPWFv
	 KNwTn4mU2e24HWUoO0gMdFmOeVcB6c8UF+Ta8xt9HFOVh+X6xBFPks7e4gfXBWpqcavtOg6IAJAz
	 Csgz80iqZsLiEoSxmJs9+7o9bmp3NlLYpR8Qinackqol9SiF8S1qsjeiaOjhTzyTwcYZWYwFRh7O
	 2SQyEYu5Y/HkUlu2Z4HNItZbkM14mcaplqD6Vu1MW7b62w93Hm+sIRV8Yizj95dtu7Rp5zMRC75C
	 JdzA3BYmnb/EzhCM4WhLz2b/liLEHSTtBXNPc6bklshuzWAH9CHSJd1S75O0XIA1TsNOQK++XOKu
	 CgtHdWHG1uidX5rtmahJuBGrdMO64v/ektei9BVwT5ZQnnG4cUYrUAiCbLielrqxSanXZphQHg6A
	 71Ff9Wss8MZmawPR1o0di/pKHecYSpfFpjhp21ezNOp6U3pjDd273L63WDyEabIqu4xOXYyEcYGH
	 m2sV8brOiF7YBK64vE0zbwOhi0DMwpclB1tSDxHXEo8lwbwyaKalBNKHdRa/dCcSiwmtDdyewj0F
	 lrwcoM7kd6MzyxziwVfPShNhs0N+FdbC274QIdolGZruhzBsKDuOwZiw0bHfza4qSb9gykUCMoiy
	 TkT9MYx+a6HcOdG/6eFgh8kg7wSkl4WVF3UNPFpOfcVa9Kc9I3PjppyS9iDNB3x7jAMu6ZiKaRQt
	 CqHup8WKZvrHvdxLvGT4BXK6z9tVRMlbE7ElCs25XAVzLn2RexDTRVGfpgukr9
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH v3 5/7] riscv: Kconfig.socs: Allow SOC_CANAAN with MMU for
 K230
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <311bdf17-c16f-41d8-8366-10f9b00adf27@kernel.org>
Date: Fri, 8 Mar 2024 05:03:34 +0800
Cc: Conor Dooley <conor@kernel.org>,
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
X-OQ-MSGID: <AF27E48D-1DD4-48B6-BD68-7188FFFD87D2@cyyself.name>
References: <tencent_BB2364BBF1812F4E304F7BDDD11E57356605@qq.com>
 <tencent_0432DA968E39B81431F921F38D747C008208@qq.com>
 <ef8df22f-dac8-4652-bf17-d10254e6abfb@kernel.org>
 <tencent_E56A833916E00EC7B4840C34FAF1250ADE0A@qq.com>
 <20240305-fascism-enrich-06483ddeb149@spud>
 <311bdf17-c16f-41d8-8366-10f9b00adf27@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
X-Mailer: Apple Mail (2.3774.400.31)



> On Mar 6, 2024, at 07:58, Damien Le Moal <dlemoal@kernel.org> wrote:
>=20
> On 3/6/24 02:20, Conor Dooley wrote:
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
>>>>>  arch/riscv/Kconfig.socs | 5 ++---
>>>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>>>=20
>>>>> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
>>>>> index 623de5f8a208..b4e9b7f75510 100644
>>>>> --- a/arch/riscv/Kconfig.socs
>>>>> +++ b/arch/riscv/Kconfig.socs
>>>>> @@ -75,13 +75,12 @@ config ARCH_CANAAN
>>>>>   def_bool SOC_CANAAN
>>>>>  config SOC_CANAAN
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
>=20
> Yes, this is my concern. Apologies for the lack of clarity.
>=20

Hi,

Thanks for the review comments. After thinking about it for a while,
I think we don't need to change it as we have changed the help
message which deleted the "K210". And the dts on k210.dtsi shows
mmu-type is riscv.none, I think if someone noticed this would know
why it fails to boot on the S-Mode MMU Kernel on K210. The only
special thing for ARCH_CANAAN is that a loader.bin will be built
when M-Mode is on arch/riscv/Makefile. However, Canaan has no other
M-Mode chips except for K210. So I think we don't need to change
it.

Another reason is that SOC_CANAAN for K210 is somehow hard to change.
If we continue using SOC_CANAAN for K210 but not for other Canaan
SoCs such as K230, it will cause some confusion to users. If we
rename SOC_CANAAN to SOC_CANAAN_K210, it will change many drivers
in many subsystems like my patch v5 [1]. So I don't think we need
to fix it.


If we don't change it, A concern for this is that some drivers for
K210 will be built when SOC_CANAAN=3Dy and if we add this to defconfig,
all riscv builds will also build some K210 drivers even on MMU. But
I think this will not be a problem just need some memory/storage
for a slightly bigger kernel. Also, we will enable some new configs
in defconfig when a new soc gets supported, it's normal for K210
SoC drivers.

Thus, I think we don't need to change it. If you have some other
opinions, please let me know.

[1] =
https://lore.kernel.org/linux-riscv/tencent_6F35FEF31908DE6AEB385AE30AC658=
863C0A@qq.com/

Thanks,
Yangyu Chen

>>=20
>> Maybe you could squash in something like the following?
>>=20
>> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
>> index b4e9b7f75510..75d55059163f 100644
>> --- a/arch/riscv/Kconfig.socs
>> +++ b/arch/riscv/Kconfig.socs
>> @@ -72,15 +72,19 @@ config SOC_VIRT
>>   This enables support for QEMU Virt Machine.
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
> --=20
> Damien Le Moal
> Western Digital Research




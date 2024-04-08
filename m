Return-Path: <linux-kernel+bounces-134910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 753E989B890
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98F931C22148
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CDB25778;
	Mon,  8 Apr 2024 07:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="eb86c3M7"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D4836AFB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712561835; cv=none; b=JBYnEkOO6t8Jx+lSEdelatSxlwJxuLtZlj6C9JRkoJ1xT5U+mAYlA3lkt85NV4zHt/EsVUDlv/6GrlNTeMfjj06YzsZQYpq4tlRn8UQItQWU7uTpt36RJl4OMEGuVIs5A5iDvBFxLpofBlsW6TGWbwUUEkNu7DgvE3qHzNawg14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712561835; c=relaxed/simple;
	bh=tqjwV+JDRwoTV4kKpmTw+sycK/8TTzP8wfXnwKx+/Rk=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=A0lOGzrOAxY34vZNEoRYoQaV1Fpsz+7HUJWTdCFdDcUmRe4duvd6c6Op2BYtaRGPcy+08Wqq1ltspkXgX+A33x0akL4NN98Pfh4WjwL7bkm77M0bCyTxTSVXvlITJie8+CZHS6vIIHmF9bt4rh7MaVor50o87t/tAk6Zwhe7sVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=eb86c3M7; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712561821; bh=XCQn5D2df8HC5dzPf32j41h6MB+QW4OTGuJoooVhLpc=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=eb86c3M7iCDh1rTwMPu+O53C9cC8gjRnFytPCz5+y6+pTCSxVmSsVYE1mnHPJx9It
	 mrTYHGWbPKPPrTSnorzwgCtgoyG5o3pevIOV+Enfo/zda7f1FAuq7h2mhOySrsJ5VO
	 oCNYgVlepb1ND/3E1ev+gp37M7S657DTqlM+Xd7U=
Received: from smtpclient.apple ([219.141.235.82])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 9370704C; Mon, 08 Apr 2024 15:36:55 +0800
X-QQ-mid: xmsmtpt1712561815tr819vea5
Message-ID: <tencent_459BC09115173E0624A4A0F19D2F43704F05@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCtlgG7Ygfvzh+AL8VVzyWhZSnZowU8V3XrXi3UlrROSxg5qNDyxE
	 06nDHjonLffCrAFF/78r/HochHUntjXhwB7lMZd5Jex438cQUCHQY08ksjZBtMUeFasQVgY25DaA
	 GHgz9fF4U0xBh7BDnSlBntV0sngMzHS7sErh9hhG4Q5LnrXAWEcxWeFR9YjVkTc/mwWhZDUMJU6n
	 uLkOa8iP+UVi17NgEF+PBxVCuDYk/fdUs0mQQNUdsqhD/dZ4tl9ga0Qg3P+a/0zM4IEm/zTBVf/U
	 H1x+lmQmwao5hFYm0j0CMYoI3od2NEEb1lJTksSvCC1365LBwNtF6uSgdlSm9E6V3n1LfZEW2Gi0
	 C6GjPn8y3TdWcnU/1dcjIWA38beQCwf2Ul/u9EovD5O12nFjHoW0fPXauIz9VfJT5GDC0FrXQ7AF
	 U8xScZuNotRjCH0qTemceOBbny482dEmoKy5I5NoQRxIQmyqxJGW0cXDUJtnqr6YZCWFkAZfUR4U
	 xePLy0s0/Jq9ppMGvOG3dtXKg2x+Td41ZxYXRmPqYN20kpx2phWRJKYAoKngxlU76SLIFelSTgWV
	 frgJ0iJgWuehP0sePnrz1dFn/pIUiYNylxQr4aQJoO+gOmjeoRv2av2tYzjJTtHyCw7QhhwCDP60
	 T69gL7oKslpzTtnc793p2Esd83KZQ0PgpoulbT5AIlLdt7gw5je3RnfeeeqrM5HUvB6mDlnP0fpM
	 wIz8HrL34jtvv5NTIdmlhTG7LJd2gSABY6eZ2adPvSCVQ2d210dfb4noJFo9g8fAX2ckzjm0UzDf
	 OE8wErXN2fiTonzEtLoncH4yc7nN1vvBYUqkCiuUJw2Owc4TDfUC8/RfMZL6DVDkbJm00UU2bWr0
	 9pI85KOLzico8ppL1nfp4CIquo2oxnGFHN1dtwCM1JSSbjQU4HXTUoTMzNzycvI8mocRQAh8eTDL
	 RJNMoXXd8vTvUMp98M/5iJw+Lkx3F6yQvyrgjy/rXKT3YQecndkJQCNKYxP+6S
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH v3 2/2] riscv: T-Head: Test availability bit before
 enabling MAE errata
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <CAEg0e7h0F_LaeMoS6Co1UjgLM6ML8SXtTfHW5+OQS6yedjdZPQ@mail.gmail.com>
Date: Mon, 8 Apr 2024 15:36:44 +0800
Cc: ajones@ventanamicro.com,
 alex@ghiti.fr,
 alistair.francis@wdc.com,
 Albert Ou <aou@eecs.berkeley.edu>,
 bjorn@kernel.org,
 Conor Dooley <conor.dooley@microchip.com>,
 Conor Dooley <conor@kernel.org>,
 cooper.qu@linux.alibaba.com,
 dbarboza@ventanamicro.com,
 Qingfang Deng <dqfext@gmail.com>,
 eric.huang@linux.alibaba.com,
 heiko@sntech.de,
 linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 philipp.tomsich@vrull.eu,
 samuel.holland@sifive.com,
 zhiwei_liu@linux.alibaba.com,
 Guo Ren <guoren@kernel.org>
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <347E5675-332A-4AF4-8A16-64FBB65445E1@cyyself.name>
References: <20240407213236.2121592-3-christoph.muellner@vrull.eu>
 <tencent_CF232CDF85208DF6BFA3076E73CC4E087306@qq.com>
 <CAEg0e7h0F_LaeMoS6Co1UjgLM6ML8SXtTfHW5+OQS6yedjdZPQ@mail.gmail.com>
To: =?utf-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On Apr 8, 2024, at 14:00, Christoph M=C3=BCllner =
<christoph.muellner@vrull.eu> wrote:
>=20
> On Mon, Apr 8, 2024 at 3:58=E2=80=AFAM Yangyu Chen <cyy@cyyself.name> =
wrote:
>>=20
>> On 2024/4/8 05:32, Christoph M=C3=BCllner wrote:
>>> T-Head's memory attribute extension (XTheadMae) (non-compatible
>>> equivalent of RVI's Svpbmt) is currently assumed for all T-Head =
harts.
>>> However, QEMU recently decided to drop acceptance of guests that =
write
>>> reserved bits in PTEs.
>>> As XTheadMae uses reserved bits in PTEs and Linux applies the MAE =
errata
>>> for all T-Head harts, this broke the Linux startup on QEMU =
emulations
>>> of the C906 emulation.
>>>=20
>>> This patch attempts to address this issue by testing the MAE-enable =
bit
>>> in the th.sxstatus CSR. This CSR is available in HW and can be
>>> emulated in QEMU.
>>>=20
>>> This patch also makes the XTheadMae probing mechanism reliable, =
because
>>> a test for the right combination of mvendorid, marchid, and mimpid
>>> is not sufficient to enable MAE.
>>>=20
>>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>> Signed-off-by: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>
>>> ---
>>>  arch/riscv/errata/thead/errata.c | 14 ++++++++++----
>>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>>=20
>>> diff --git a/arch/riscv/errata/thead/errata.c =
b/arch/riscv/errata/thead/errata.c
>>> index 6e7ee1f16bee..bf6a0a6318ee 100644
>>> --- a/arch/riscv/errata/thead/errata.c
>>> +++ b/arch/riscv/errata/thead/errata.c
>>> @@ -19,6 +19,9 @@
>>>  #include <asm/patch.h>f
>>>  #include <asm/vendorid_list.h>
>>>=20
>>> +#define CSR_TH_SXSTATUS              0x5c0
>>> +#define SXSTATUS_MAEE                _AC(0x200000, UL)
>>> +
>>>  static bool errata_probe_mae(unsigned int stage,
>>>                           unsigned long arch_id, unsigned long =
impid)
>>>  {
>>> @@ -28,11 +31,14 @@ static bool errata_probe_mae(unsigned int stage,
>>>      if (arch_id !=3D 0 || impid !=3D 0)
>>>              return false;
>>>=20
>>=20
>> I would raise a little concern about keeping this "if" statement for
>> arch_id and imp_id after we have probed it in this CSR way. I would =
like to
>> remove it and move the CSR probe earlier than RISCV_ALTERNATIVES.
>>=20
>> I added CC to guoren for more opinions.
>>=20
>> Even T-Head C908 comes in 2023, which supports RVV 1.0 and also keeps =
MAEE.
>> But it also supports Svpbmt, and we can perform the switch by =
clearing the
>> MAEE bit in CSR_TH_MXSTATUS in M-Mode Software.
>>=20
>> Moreover, T-Head MAEE may not be removed in the future of T-Head =
CPUs. We
>> can see something from the T-Head C908 User Manual that adds a =
Security bit
>> to MAEE. So, it might used in their own TEE implementation and will =
not be
>> removed.
>>=20
>> However, C908 has arch_id and impid, which are not equal to zero. You =
can
>> see it from the C908 boot log [2] from my patch to support K230 [3]. =
So, if
>> we have probed MAEE using CSR, you confirmed that this bit will also =
be set
>> in the C906 core. We can only probe it this way and no longer use =
arch_id
>> and imp_id. And if the arch_id and imp_id probes get removed, we =
should
>> also move the csr probe earlier than riscv alternatives.
>=20
> We keep the probing via arch_id=3D=3D0&&impid=3D=3D0 because we had =
that
> already in the kernel and don't want to break existing functionality.
>=20
> =46rom the discussions that we had about the v1 and v2 of this series,
> my impression is that we should use DT properties instead of probing
> arch_id and impid. So, if C908 support is needed, this should probably
> be introduced using DT properties. The logic would then be:
> * if arch_id =3D=3D 0 and impid =3D=3D 0 then decide based on =
th.sxstatus.MAEE
> * else test if "xtheadmae" is in the DT
>=20
>=20

I know about it, and Conor also mentioned adding this property to DT a =
few
months ago. I agree with this at that time. But for now, you have found =
the
T-Head document description about this, and we can probe MAE using CSR =
even
on C906. I think only probing in CSR will be a better way to do that. It
can maintain compatibility with some early cores, such as C906. And will
also support some new cores with non-zero arch_id and impl_id but may =
have
MAE enabled, such as C908.

For future concerns, T-Head said from their documentation that
"Availability: The th.sxstatus CSR is available on all systems whose
mvendorid CSR holds a value of 0x5B7." [1] and this extension is frozen =
and
stable. I think it's okay to have MAE errara for some cpus whose impl_id
and arch_id are non-zero. And T-Head may have used this for their TEE, =
so
it might never be removed.

Since it might never be removed, if some vendor uses it and makes it =
hard
to run the mainline kernel since it requires setting CSR in M-Mode =
software
or changing the DT, they may be hard to change for some security reasons
for TEE, I think it's not right.

I'm also waiting for Conor's opinion about this.

[1] =
https://github.com/T-head-Semi/thead-extension-spec/blob/master/xtheadsxst=
atus.adoc

Thanks,
Yangyu Chen

>=20
>=20
>>=20
>> [1] =
https://occ-intl-prod.oss-ap-southeast-1.aliyuncs.com/resource//1699268369=
347/XuanTie-C908-UserManual.pdf
>> [2] https://gist.github.com/cyyself/b9445f38cc3ba1094924bd41c9086176
>> [3] =
https://lore.kernel.org/linux-riscv/tencent_D1180541B4B31C0371DB634A42681A=
5BF809@qq.com/
>>=20
>> Thanks,
>> Yangyu Chen
>>=20
>>> -     if (stage =3D=3D RISCV_ALTERNATIVES_EARLY_BOOT ||
>>> -         stage =3D=3D RISCV_ALTERNATIVES_MODULE)
>>> -             return true;
>>> +     if (stage !=3D RISCV_ALTERNATIVES_EARLY_BOOT &&
>>> +         stage !=3D RISCV_ALTERNATIVES_MODULE)
>>> +             return false;
>>>=20
>>> -     return false;
>>> +     if (!(csr_read(CSR_TH_SXSTATUS) & SXSTATUS_MAEE))
>>> +             return false;
>>> +
>>> +     return true;
>>>  }
>>>=20
>>>  /*
>>=20



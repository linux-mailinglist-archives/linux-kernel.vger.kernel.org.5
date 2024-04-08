Return-Path: <linux-kernel+bounces-135023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F6B89BA0D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B0E11F21E84
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF7C2D796;
	Mon,  8 Apr 2024 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="CWrlCsj3"
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974222C197
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712564511; cv=none; b=Wr5wglOwO1j6ZlZNRSo2VcizWf6desWGMYzZ2WhNzL6eYHz4wbCdcNdf+GqScz2IqJRDkSqRS6iyKW3++tZ2//6xpIRIiw33OLtTYkvC0T0UUZsZZAWc9X4LnXPB+pOhzYMCDAuvK3ZtWbqPGa7q+WpW6RYKeINccUvVeodEVb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712564511; c=relaxed/simple;
	bh=GrcGGCODtXTsJx6LAbSWtBlNJU+Y0EOoyOBHLEdhbwQ=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=IhlmJicRN1lmVF3rsx+T8CNnrUi4Sr7o/fdZnaAyccCZ5HgtknwHe47TBW7TnS0YhvO+qTlCvKHcjzzZtxRqvAPbUhjp4ij6YwlGOYZdHhAZVgQAiHuk7xY3M/710ydY5wJ1jEkFh6+NFVVu92R8mc2OKYzZPiZzEKkjc7DkKV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=CWrlCsj3; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712564501; bh=SrU4cZaQ+zjdmulKEchHapOU6RlTnfsrpOFcfswV0H0=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=CWrlCsj3Fwdae/fhtJlV9MzvZ9GqehWw1aNsYjRwPigj4vDuamy+JvU3VIxZ4ZOjf
	 +bmFKNhARP0UEnp9hsXwcWv0Eq6P/DlM7nF03wdpWMBS9s74185F7TEJyCmbsqnsnG
	 PNE2nGmHOvcvM1pdHgQw0MuHbRuR23QCHhcJKlYY=
Received: from smtpclient.apple ([219.141.235.82])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 562B603A; Mon, 08 Apr 2024 16:21:34 +0800
X-QQ-mid: xmsmtpt1712564494thxyundlv
Message-ID: <tencent_D6D1043732E63644A4B1838F4210499BCF05@qq.com>
X-QQ-XMAILINFO: MmpliBmRb3iCbvkqWZDjism5ElW3n7jWTwlhNh/hVriu+LtKiW1fbfZ+qyJJHW
	 P3nOqL7l5D8JaWhUKMIAL+mAaCzLzen8PIxC5FeJ4+DQOjsyYtsDcuzSfMlCdOBn1UWWVKy5eEBp
	 UMijejIRrKoKqL9COMx7lvYoquB9UsU9JrdlrjeWUQ8bEDSDezqAIFtU06VVqJm0cHZK0DpXjSaa
	 1EmbN5KRfzfgKL2KG2MkrJsFpMT91sjKGVFuaGReaVSRB4j3YI0YIlgsy+mN7ZqngxpgktP3hnry
	 TJuOdDVKlSMp8wybe0SG+064PP72OCEJlDiGiwmjzUdjQTZXwbQtucDgPsDR5voIPnz7cCDzsOW9
	 3e4m2h1bgsmJlnDHvHtXUaBpjAJnSDRyxyBEWfXkMHlGhx9GUy2rfrNK2mqfh7EwqQ0T8txn6voK
	 /1xzbwoGIJVqZ9P0qOOC1AoKDfhZ7qfRMCdxWIfgPw2NgcHnA7J02kRzduRYlLzWFOAGob1FWXQq
	 Kg71wrpCCNo5JxsjhiZv6IaI48H5U1pnU1BSAXuQoKIA1ia8eKjjGUk902B73/yZ+qsSxYcfgdVD
	 YZ69a2jmh1I6tS+P/Iwi8xLKFGOtCxwHBypfd32U13+rQFIcF2OT5jH95+cFirX8YfwyMO28Ksq+
	 1j0hM7fi428DerMUFcfKYwGn2U3ggonFiezi/eMgsOtpN6H0Pss929A0BCJ+a2gp0dYVaKQuGfXi
	 iDA44cXjrrOHvHWRS8LYoFHjuJKbUxFhG1TbXLiAkGI6L6bh6pj25rfx02mjcVAsZOwQ4mNM7br2
	 QMa4fV/DPulokR082JJ0PNNx2w8G3LbAQW0mhhukqJNif/g0QitXlv7ZFbN6zpOdB42dbv0boBz0
	 cojsmhnjqMnp/TDM0S83m/jmJ7HNev45oPVfI/Ge87+oCdwQZQV+xpbWnAt+9F+iMBQMsoJpTTfF
	 9z9jxHPQdBDrD/EeTKk6BeUQLNmqHlY8qoAp8oQoUYwqS66Ti8Cypc+GNJP+LhKDjqROMzLYJAjE
	 fx5zIOsg==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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
In-Reply-To: <20240408-dispersal-foster-49c4e269216e@spud>
Date: Mon, 8 Apr 2024 16:21:24 +0800
Cc: =?utf-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 ajones@ventanamicro.com,
 alex@ghiti.fr,
 alistair.francis@wdc.com,
 Albert Ou <aou@eecs.berkeley.edu>,
 bjorn@kernel.org,
 Conor Dooley <conor.dooley@microchip.com>,
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
X-OQ-MSGID: <BAA88F86-1701-47A0-9A3C-132D908E96A9@cyyself.name>
References: <20240407213236.2121592-3-christoph.muellner@vrull.eu>
 <tencent_CF232CDF85208DF6BFA3076E73CC4E087306@qq.com>
 <CAEg0e7h0F_LaeMoS6Co1UjgLM6ML8SXtTfHW5+OQS6yedjdZPQ@mail.gmail.com>
 <tencent_459BC09115173E0624A4A0F19D2F43704F05@qq.com>
 <CAEg0e7jW=Sfc3tcc0eJwbTx=vb0HM49ZWpda972E-t=Fj1PG+g@mail.gmail.com>
 <20240408-dispersal-foster-49c4e269216e@spud>
To: Conor Dooley <conor@kernel.org>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On Apr 8, 2024, at 16:10, Conor Dooley <conor@kernel.org> wrote:
>=20
> On Mon, Apr 08, 2024 at 09:55:48AM +0200, Christoph M=C3=BCllner =
wrote:
>> On Mon, Apr 8, 2024 at 9:37=E2=80=AFAM Yangyu Chen <cyy@cyyself.name> =
wrote:
>>>> On Apr 8, 2024, at 14:00, Christoph M=C3=BCllner =
<christoph.muellner@vrull.eu> wrote:
>>>> On Mon, Apr 8, 2024 at 3:58=E2=80=AFAM Yangyu Chen =
<cyy@cyyself.name> wrote:
>>>>> On 2024/4/8 05:32, Christoph M=C3=BCllner wrote:
>>>>>> T-Head's memory attribute extension (XTheadMae) (non-compatible
>>>>>> equivalent of RVI's Svpbmt) is currently assumed for all T-Head =
harts.
>>>>>> However, QEMU recently decided to drop acceptance of guests that =
write
>>>>>> reserved bits in PTEs.
>>>>>> As XTheadMae uses reserved bits in PTEs and Linux applies the MAE =
errata
>>>>>> for all T-Head harts, this broke the Linux startup on QEMU =
emulations
>>>>>> of the C906 emulation.
>>>>>>=20
>>>>>> This patch attempts to address this issue by testing the =
MAE-enable bit
>>>>>> in the th.sxstatus CSR. This CSR is available in HW and can be
>>>>>> emulated in QEMU.
>>>>>>=20
>>>>>> This patch also makes the XTheadMae probing mechanism reliable, =
because
>>>>>> a test for the right combination of mvendorid, marchid, and =
mimpid
>>>>>> is not sufficient to enable MAE.
>>>>>>=20
>>>>>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>>>>> Signed-off-by: Christoph M=C3=BCllner =
<christoph.muellner@vrull.eu>
>=20
>>>>>> @@ -28,11 +31,14 @@ static bool errata_probe_mae(unsigned int =
stage,
>>>>>>     if (arch_id !=3D 0 || impid !=3D 0)
>>>>>>             return false;
>>>>>>=20
>>>>>=20
>>>>> I would raise a little concern about keeping this "if" statement =
for
>>>>> arch_id and imp_id after we have probed it in this CSR way. I =
would like to
>>>>> remove it and move the CSR probe earlier than RISCV_ALTERNATIVES.
>>>>>=20
>>>>> I added CC to guoren for more opinions.
>>>>>=20
>>>>> Even T-Head C908 comes in 2023, which supports RVV 1.0 and also =
keeps MAEE.
>>>>> But it also supports Svpbmt, and we can perform the switch by =
clearing the
>>>>> MAEE bit in CSR_TH_MXSTATUS in M-Mode Software.
>>>>>=20
>>>>> Moreover, T-Head MAEE may not be removed in the future of T-Head =
CPUs. We
>>>>> can see something from the T-Head C908 User Manual that adds a =
Security bit
>>>>> to MAEE. So, it might used in their own TEE implementation and =
will not be
>>>>> removed.
>>>>>=20
>>>>> However, C908 has arch_id and impid, which are not equal to zero. =
You can
>>>>> see it from the C908 boot log [2] from my patch to support K230 =
[3]. So, if
>>>>> we have probed MAEE using CSR, you confirmed that this bit will =
also be set
>>>>> in the C906 core. We can only probe it this way and no longer use =
arch_id
>>>>> and imp_id. And if the arch_id and imp_id probes get removed, we =
should
>>>>> also move the csr probe earlier than riscv alternatives.
>>>>=20
>>>> We keep the probing via arch_id=3D=3D0&&impid=3D=3D0 because we had =
that
>>>> already in the kernel and don't want to break existing =
functionality.
>>>>=20
>>>> =46rom the discussions that we had about the v1 and v2 of this =
series,
>>>> my impression is that we should use DT properties instead of =
probing
>>>> arch_id and impid. So, if C908 support is needed, this should =
probably
>>>> be introduced using DT properties. The logic would then be:
>>>> * if arch_id =3D=3D 0 and impid =3D=3D 0 then decide based on =
th.sxstatus.MAEE
>>>> * else test if "xtheadmae" is in the DT
>>>>=20
>>>>=20
>>>=20
>>> I know about it, and Conor also mentioned adding this property to DT =
a few
>>> months ago. I agree with this at that time. But for now, you have =
found the
>>> T-Head document description about this, and we can probe MAE using =
CSR even
>>> on C906. I think only probing in CSR will be a better way to do =
that. It
>>> can maintain compatibility with some early cores, such as C906. And =
will
>>> also support some new cores with non-zero arch_id and impl_id but =
may have
>>> MAE enabled, such as C908.
>>>=20
>>> For future concerns, T-Head said from their documentation that
>>> "Availability: The th.sxstatus CSR is available on all systems whose
>>> mvendorid CSR holds a value of 0x5B7." [1] and this extension is =
frozen and
>>> stable. I think it's okay to have MAE errara for some cpus whose =
impl_id
>>> and arch_id are non-zero. And T-Head may have used this for their =
TEE, so
>>> it might never be removed.
>>=20
>> I wrote that specification. And yes, T-Head reviewed that part.
>> But there is no guarantee for future cores.
>=20
> Yeah, that is what I assumed. Unless its a 100% certainty that this =
bit
> will always have this meaning, we can't unconditionally assume that it
> does.
>=20
>>> Since it might never be removed, if some vendor uses it and makes it =
hard
>>> to run the mainline kernel since it requires setting CSR in M-Mode =
software
>>> or changing the DT, they may be hard to change for some security =
reasons
>>> for TEE, I think it's not right
>=20
>> The question is: why should the kernel have to care about that?
>> This can all be addressed (hidden) in FW, where core-specific
>> routines can test the required bits in vendor CSRs and set DT =
properties
>> that match the core's configuration.
>=20
> I'm also not super inclined to care about it requiring changes in
> firmware, because the last time I checked T-Head's SDK (and therefore
> the vendors') use a version of OpenSBI that cannot even run mainline =
and
> needs to be updated to begin with.

So the solution might be to have some property like `xtheadmae` and test
th.sxstatus whether it has MAEE bit set when we have this in ISA string =
in
the DT rather than have MAE enabled for sure if `xtheadmae` exists as
discussed before. This will require changing the DT. However, since the
C908, the first core released by T-Head that supports MAE with non-zero
arch_id and imp_id hasn't merged to mainline yet. It's time to add this
dt-binding and some code to probe it. I can have it tested on K230
recently. Whatever, this patch can go first.

Thanks,
Yangyu Chen=



Return-Path: <linux-kernel+bounces-129353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 132018968F7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D1C1C23EB5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0C86EB4B;
	Wed,  3 Apr 2024 08:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="lwRDd6nv"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CA56EB44;
	Wed,  3 Apr 2024 08:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133601; cv=none; b=lzNTKvEY4ybAJKpgkXkxxhZuD6E16UWob1ctj/OKdAcXpP3hi+jq8BiL2qVWycw2/CquBUvgbUm4EOzfQJE3kNd3hAmrhXDsOa4QySGWDhP/8pjNBc0Uh6cmWrevyXludtfEqRJYNexCKz9vAhDMuO6lQpdUp1o5npkt4HYTagI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133601; c=relaxed/simple;
	bh=h38IpzYE40rRL6YUDxEuxo1A9c6P3+Tqcuhs5gHFXsQ=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=rEkqq6wa5hPJXjTBtNNl9e9xgyvi0qJru3Lpo1b66Q5vEaVVf2htrximA2Ffq1ffuKN2HtRHEgzaMNgeGrRIT6kyOtPBtk77q6ObhijVGgjam4gJtt2jRrbLMITZF8+ngwzyHCsGlPacpjtuJPvpBrJjx+Za6byfnkxSnK9CUxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=lwRDd6nv; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712133587; bh=h38IpzYE40rRL6YUDxEuxo1A9c6P3+Tqcuhs5gHFXsQ=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=lwRDd6nv3nWd7/b76WzvLV+U28YiU+3jUNFbuBQSTXrqW36mM8AgDQTmlc9Aumcai
	 +8ZZqlzY5dzbDznEjQlnkZK1O/4mU5hy/aAcc07Q4C/W+U82BGOoh+x4wuCOEDPHQP
	 PI7lcC8UkhTb7f23/lw/EA+SPTH8xMAlaBs6Ol3o=
Received: from smtpclient.apple ([219.141.235.82])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 99DAF6F4; Wed, 03 Apr 2024 16:38:29 +0800
X-QQ-mid: xmsmtpt1712133509t4g857ofk
Message-ID: <tencent_191962F243021BFBF9A40403B4451C757009@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8PluXiaw8tD0iRMGI5K2+7PtPdjlOWGX/KbqOaAMV25IrC6sOlm
	 SV9Un7yK/HDB8D/RzxR0RosEH4/kkIxOAEiP7tDuHcbztzshwgUhzFqF0WBPDN7c0oFHKGmXI+J+
	 h4IaLvmROghSyfOxwznQgkukISQq3Kb3gzmwa5dV1abClg0jhFLzwTsjv55pHt76D75Tsng3VYZ9
	 ur6OLYcC5wSQaciZa8iUbFadAp226G4wxTLcbKplG77h/oTZ386j5YtBtxrS83rcqSIJPj1Tfal9
	 wNB0BR2/BTEGjv6+2IXIzzvydyR6O486AwhCUhm0qJQ+1myPtvGUU6dYug/n5HYM2S6I2zDpMQVl
	 Z75NGq4WybdhcLwWZEpb35U5fZnFxmT8VKq803tDWQVyi2y0nbeREixT4d1X80KmUCCb3a+J1AJC
	 xbg0dxsivz6fiuayYEMXZ2D5r0LfMmjnJzEUfMj2XJGOYRwfv+NhECK7BZmIGTpuXCaxu8so1I3g
	 JwS/lGIilCSPOY3RfKVl5AsXvxQOy6YIGqMelt+mvlDv6gNvx5QG42nueQP+yJp8Cok+PQkUFFXW
	 1XHiZpIjXMEkcCgXZ2/FbGFcDyL2k4MZ1rzoQIPXfSjHMS/gZ1U4lvnhuTJIOXlFo5lznVgiS6DE
	 R/Jbn2VVSjsvvz6IIMzV2n5TDT2f5tiqfFlg27sCjFT5/VFCTI9noZKsjngzYJ18dCnfgj28Xhhm
	 yB0LPTO4YiNOg39vsmtRxA9cFOuh/5jB1y9nwezuX+ZXpnsEeKyAKATlL/ZCPkF7NshbFVi6FwwI
	 c9w3rQbzAXsUtDbxXo5idSHc1i0h+2d+frHV1pbj4azceJgL+WFNlu+gsIMECu85gGm0rILKadzT
	 XCQlzYIpp4wexHkZQq4DuqBAvI4Ul3HPcdRdR/Lsk7K9nN4RZ4d9M7zaiPSjafd8mXHQqHSjApEW
	 tiU43TGpDIuOcCqJvn4FF4gQrWLeLQomUM/XJiaSJPS+EfgQ4nyA==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH v6 08/11] pinctrl: k210: Deprecate SOC_CANAAN and use
 SOC_CANAAN_K210
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <CACRpkdY1wpGM7M5QV5rN0M6JMN_yugQJ7CEtnQjzsheD5AT23A@mail.gmail.com>
Date: Wed, 3 Apr 2024 16:38:19 +0800
Cc: linux-riscv@lists.infradead.org,
 Conor Dooley <conor@kernel.org>,
 Damien Le Moal <dlemoal@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 linux-gpio@vger.kernel.org,
 linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <1807DEE3-E572-44E3-997D-C7D2EADF4BB1@cyyself.name>
References: <tencent_F76EB8D731C521C18D5D7C4F8229DAA58E08@qq.com>
 <tencent_6D10A9C63E3E0F412EED33477B5CDB98C207@qq.com>
 <CACRpkdY1wpGM7M5QV5rN0M6JMN_yugQJ7CEtnQjzsheD5AT23A@mail.gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On Apr 2, 2024, at 20:31, Linus Walleij <linus.walleij@linaro.org> =
wrote:
>=20
> On Sat, Mar 23, 2024 at 1:13=E2=80=AFPM Yangyu Chen <cyy@cyyself.name> =
wrote:
>=20
>> Since SOC_FOO should be deprecated from patch [1], and cleanup for =
other
>> SoCs is already on the mailing list [2,3,4], we remove the use of
>> SOC_CANAAN and introduced SOC_CANAAN_K210 for K210-specific drivers,
>>=20
>> Thus, we replace its drivers depends on SOC_CANAAN_K210 and default =
select
>> when it has the symbol SOC_CANAAN_K210.
>>=20
>> [1] =
https://lore.kernel.org/linux-riscv/20221121221414.109965-1-conor@kernel.o=
rg/
>> [2] =
https://lore.kernel.org/linux-riscv/20240305-praying-clad-c4fbcaa7ed0a@spu=
d/
>> [3] =
https://lore.kernel.org/linux-riscv/20240305-fled-undrilled-41dc0c46bb29@s=
pud/
>> [4] =
https://lore.kernel.org/linux-riscv/20240305-stress-earflap-d7ddb8655a4d@s=
pud/
>>=20
>> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
>=20
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>=20

Please add Acked-by to this email [1]. I will separate them in the next
revision.

[1]
=
https://lore.kernel.org/linux-riscv/tencent_DB11214C8D0D7C48829ADA128E7BB8=
F13108@qq.com/

Thanks.

> Is this patch something I can just apply to the pinctrl tree?
>=20

I think not. As Conor said.

> Yours,
> Linus Walleij



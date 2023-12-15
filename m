Return-Path: <linux-kernel+bounces-1333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 040AF814D90
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF451F2517B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D253EA6B;
	Fri, 15 Dec 2023 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f1wzshh3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF0A3EA69;
	Fri, 15 Dec 2023 16:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D76ABC0004;
	Fri, 15 Dec 2023 16:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702659140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sfWZH/svifhxC7W4M7gZ14WX8XvsD6qw/uDPo8WcvAQ=;
	b=f1wzshh3cKH6bWa+OECXGVN61sYa1O4bSH5bKlfhN2DLchVmrRyZ9TCV2Ge7cXO2YcVn4s
	zi9u3uP5Lr58adQe7Ay09wXGgTv3n6X1NFdjE5esgUIEpQJ3d5suPvZ3WyERoX+23s7WCv
	GWVYN0zkuVcJEjlybJMiu62WrktEjrMy8VR9ehQTivFZ7M3Hn8Wfeaor9Qyf1D81kVx2LY
	einWNqxjEAsTso6z8YVnIpQYFzNJ5sUQh1GPYEdKVgzz9c7KU1jxfO4yiGHDjuo52jZ83I
	tNoBH9IRoHiK/gct1bYClQ5xeRVAQSiMK2bFKa17VCSNoziUU0CBvSSyIXjYbQ==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, "paulburton@kernel.org"
 <paulburton@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, Tawfik Bayouk
 <tawfik.bayouk@mobileye.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, =?utf-8?Q?Th=C3=A9o?= Lebrun
 <theo.lebrun@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 21/22] MIPS: generic: Add support for Mobileye EyeQ5
In-Reply-To: <6b747f3b-f0d7-4e40-a331-8d2323e4874c@app.fastmail.com>
References: <20231212163459.1923041-1-gregory.clement@bootlin.com>
 <20231212163459.1923041-22-gregory.clement@bootlin.com>
 <6b747f3b-f0d7-4e40-a331-8d2323e4874c@app.fastmail.com>
Date: Fri, 15 Dec 2023 17:52:19 +0100
Message-ID: <875y0zcssc.fsf@BL-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gregory.clement@bootlin.com

"Jiaxun Yang" <jiaxun.yang@flygoat.com> writes:

> =E5=9C=A82023=E5=B9=B412=E6=9C=8812=E6=97=A5=E5=8D=81=E4=BA=8C=E6=9C=88 =
=E4=B8=8B=E5=8D=884:34=EF=BC=8CGregory CLEMENT=E5=86=99=E9=81=93=EF=BC=9A
>> Introduce support for the MIPS based Mobileye EyeQ5 SoCs.
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> ---
>>  arch/mips/configs/generic/board-eyeq5.config | 42 ++++++++++++++++++++
>>  arch/mips/generic/Kconfig                    | 15 +++++++
>>  arch/mips/generic/Platform                   |  2 +
>>  arch/mips/generic/board-epm5.its.S           | 24 +++++++++++
>>  4 files changed, 83 insertions(+)
>>  create mode 100644 arch/mips/configs/generic/board-eyeq5.config
>>  create mode 100644 arch/mips/generic/board-epm5.its.S
>>
>> diff --git a/arch/mips/configs/generic/board-eyeq5.config=20
>> b/arch/mips/configs/generic/board-eyeq5.config
>> new file mode 100644
>> index 0000000000000..d94e408145389
>> --- /dev/null
>> +++ b/arch/mips/configs/generic/board-eyeq5.config
>> @@ -0,0 +1,42 @@
>> +CONFIG_HIGH_RES_TIMERS=3Dy
>> +CONFIG_TASKSTATS=3Dy
>> +CONFIG_FIT_IMAGE_FDT_EPM5=3Dy
>> +CONFIG_BOARD_EYEQ5=3Dy
>> +CONFIG_PHYSICAL_START=3D0xa800000808000000
>
> ^ I still think by doing this you are risking overriding starting address
> for all other generic systems. make 32r6_defconfig will load config files
> of all boards.

I think at a point you mentioned a way to remove the eyeq5 config board
from the 32r6_defconfig. It would be indeed a good solution.

>
> Perhaps just provide an eqm5_defconfig will work better?

So you mean a defconfig in direclty in arch/mips/configs/ and not
anymore in arch/mips/configs/generic ?

Gregory

>
> Thanks.
> --=20
> - Jiaxun

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com


Return-Path: <linux-kernel+bounces-55461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A353E84BCFE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E07BB22292
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F594134BA;
	Tue,  6 Feb 2024 18:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="fVkMdGUL"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B240613AC7;
	Tue,  6 Feb 2024 18:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707244620; cv=none; b=ndjcfDzGloTC11g6ft3ZdB7y/vbLLCOKaioXofHGxlQI2Q7wH/vLfSACvT4/8Zbu+1KtcDcX8n7BGgZQ3SWf1BhL/x3+mFoLnMBe2I2X8npW3w5L8TiWCWRsrblFwYSY/Y8LqT4y2N+FLasaNutL3W2eBF7C1CP2U3ewQcW7C24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707244620; c=relaxed/simple;
	bh=P+vXSlwDpmhtaUOyJDpWrnf7rOSka48e/3C8lNI4rdo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=lwIXzPD/64wTWSEs7B53QrFDDgBM1ZHwf/Lfu+LR6YXVFaWUe7GpH3Faz4ZE2hrgRdEbZiSbwUy3Mm1yhMoSnHIJiiz+PBzuFcXdaJ5PcHhJsjGEbrAIfqcJjQGqkapuYa/VRbsAzhejVW6HQTBDie6BPEVzOY+P9YQ6tJpQgvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=fVkMdGUL; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from [127.0.0.1] (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 0A0CF22A99;
	Tue,  6 Feb 2024 19:36:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1707244614;
	bh=am4Gfl/dMYoJTXjOuFfFs7MGZX49MaaHbJnO0r0rWZU=; h=From:To:Subject;
	b=fVkMdGULQ25Km7zP8Z5L5Jhajz5vUQhbmduI4vjmk+/K+aZg7oSIqWlY5FB3w14eu
	 ENZfqvlWmW8fhapWcnyKb1dSNvAEb+TzleFf+/hqpy6zoKZc6vfhEZ24q6rKy5PoF8
	 yKRd/nLi1DubCupbPOocksup04kPFd6vQdGFd552f8EnIKmWXvjvoPjyAWLVv2jhiz
	 jdDSQgpff71RyKH84qXpYzASDvkVMp33uTbaBVX0ZSrWzor0jiQKOPixnOSFji7SPU
	 3oFHgjb00bonM068A3pIw8HvqPWu2YAUwENxmdMXlBaKQ4B+XCxNAIhZKWt1Goe2Ur
	 1xRiDNt1trWjQ==
Date: Tue, 06 Feb 2024 19:36:53 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: ti: verdin-am62: mallow: add TPM device
User-Agent: K-9 Mail for Android
In-Reply-To: <65a24f21-4cc6-4843-b838-b1c7020ca45d@ti.com>
References: <20240126165136.28543-1-francesco@dolcini.it> <65a24f21-4cc6-4843-b838-b1c7020ca45d@ti.com>
Message-ID: <26F9C286-606C-40C6-994E-EABDFFCDFDC4@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



Il 6 febbraio 2024 19:29:13 CET, Andrew Davis <afd@ti=2Ecom> ha scritto:
>On 1/26/24 10:51 AM, Francesco Dolcini wrote:
>> From: Francesco Dolcini <francesco=2Edolcini@toradex=2Ecom>
>>=20
>> Add TPM device to Mallow device tree file, the device is connected to
>> the SoC with SPI1/CS1, the same SPI interface is also available on an
>> extension header together with an additional CS0 signal=2E
>>=20
>> Signed-off-by: Francesco Dolcini <francesco=2Edolcini@toradex=2Ecom>
>> ---
>>   arch/arm64/boot/dts/ti/k3-am62-verdin-mallow=2Edtsi | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>=20
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-mallow=2Edtsi b/arch=
/arm64/boot/dts/ti/k3-am62-verdin-mallow=2Edtsi
>> index 17b93534f658=2E=2E77b1beb638ad 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62-verdin-mallow=2Edtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-mallow=2Edtsi
>> @@ -127,6 +127,16 @@ &main_spi1 {
>>   		    <&pinctrl_qspi1_cs2_gpio>;
>>   	cs-gpios =3D <0>, <&main_gpio0 12 GPIO_ACTIVE_LOW>;
>>   	status =3D "okay";
>> +
>> +	tpm@1 {
>> +		compatible =3D "infineon,slb9670", "tcg,tpm_tis-spi";
>> +		reg =3D <1>;
>> +		pinctrl-names =3D "default";
>> +		pinctrl-0 =3D <&pinctrl_qspi1_dqs_gpio>;
>> +		interrupt-parent =3D <&main_gpio1>;
>> +		interrupts =3D <18 IRQ_TYPE_EDGE_FALLING>;
>
>Just a heads-up, the SLB9670 datasheet says this device uses
>an active low interrupt (IRQ_TYPE_LEVEL_LOW)=2E Using TYPE_EDGE
>here can cause missed interrupts if the line stays low for
>multiple interrupts=2E


The driver interrupt handler would need to take care of it, if needed=2E

The SOC does not support level interrupt, so there is no other solution, a=
m I wrong?
=20
Francesco



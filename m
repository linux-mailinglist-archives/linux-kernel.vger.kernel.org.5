Return-Path: <linux-kernel+bounces-99028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E103D878294
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96EFE1F22308
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8030344369;
	Mon, 11 Mar 2024 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/FdvGT1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFB747F48;
	Mon, 11 Mar 2024 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710168927; cv=none; b=kpOb0pcL/gMkRIEXM3vCFsb9DjEW4nBUKp6Y6R1JJjkBjaAGf9X2BfRfZUwj4heL2o3DU2MmWXkjCxxj7pwFAze5rVQB9e5EgQizJrCxpSwDNcqudwEo9jPYTfI+vNbhZx439CawwQ3GZG6nwMNqjmC9NpJzm4+lAY99LRYZ1+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710168927; c=relaxed/simple;
	bh=LvW9nTAyldiPop/Tibv4R+2RE6G1PnecV6XkNaBzfHU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HzdOpRnm4x/g4vbcN6dp4o3WisNMW/xLpZ5w+4AE7/r1aiWUnUNf4fd8MLNlGALANgtbX4SuR6v94XKjBwM5TCDckJC0XkywbZAwH1y9NjvwA+ZICYmF9PxoiSrDW9kZm9N1DfnZU1/Z46Lf0Yru3cvK3g731njFG3cCUYmLO2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/FdvGT1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3417C433B2;
	Mon, 11 Mar 2024 14:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710168927;
	bh=LvW9nTAyldiPop/Tibv4R+2RE6G1PnecV6XkNaBzfHU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=C/FdvGT1IhklU0hQgvncDarCtzuZJg/X9/A/KRM2Ok9EyBGOGD9918a269te/L6dJ
	 PjHJA3rntAnFWHn9/3NsK2F6kTxh6I9FK/1akxCWbSzW8IPdxcUTHkjDgM8AWd6Nxm
	 ycdRRfkkBdbmksRI6cJwQvY75MnN6I9QzrNBJ8FYOqVkidwteJJSEz50MUJ9wPEObw
	 Vf8wnp2LhIoaQoHY4lLmhaRItN2s/p4UvKtHxpjiuot0vL/M7Edl/KrzGCT8a1hWDe
	 Hvj3IicHJ2d1PXu8/XS+UvMgpBtvHjikO4FJizE2CvIDA9LKq9Xb0ea7RjPfbY84un
	 i0aj9TzbTD7mg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>,  Mark Brown
 <broonie@kernel.org>,
  Rob Herring <robh+dt@kernel.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
  Vaishnav Achath <vaishnav.a@ti.com>,  Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>,  "linux-mtd@lists.infradead.org"
 <linux-mtd@lists.infradead.org>,  Pratyush Yadav <pratyush@kernel.org>,
  Michael Walle <mwalle@kernel.org>,  linux-spi@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mips@vger.kernel.org,  Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>,  Gregory CLEMENT
 <gregory.clement@bootlin.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Tawfik Bayouk
 <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH 11/11] MIPS: mobileye: eyeq5: add octal flash node to
 eval board DTS
In-Reply-To: <f6b8d9bc-d95a-4d85-a2bc-820b1206fcaf@linaro.org> (Tudor
	Ambarus's message of "Mon, 11 Mar 2024 14:06:10 +0000")
References: <20240308-cdns-qspi-mbly-v1-0-a503856dd205@bootlin.com>
	<20240308-cdns-qspi-mbly-v1-11-a503856dd205@bootlin.com>
	<f6b8d9bc-d95a-4d85-a2bc-820b1206fcaf@linaro.org>
Date: Mon, 11 Mar 2024 15:55:23 +0100
Message-ID: <mafs0v85s95t0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11 2024, Tudor Ambarus wrote:

> On 3/8/24 17:18, Th=C3=A9o Lebrun wrote:
>> Add SPI-NOR octal flash node to evaluation board devicetree.
>>=20
>> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>> ---
>>  arch/mips/boot/dts/mobileye/eyeq5-epm5.dts | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>=20
>> diff --git a/arch/mips/boot/dts/mobileye/eyeq5-epm5.dts b/arch/mips/boot=
/dts/mobileye/eyeq5-epm5.dts
>> index 6898b2d8267d..0e5fee7b680c 100644
>> --- a/arch/mips/boot/dts/mobileye/eyeq5-epm5.dts
>> +++ b/arch/mips/boot/dts/mobileye/eyeq5-epm5.dts
>> @@ -21,3 +21,18 @@ memory@0 {
>>  		      <0x8 0x02000000 0x0 0x7E000000>;
>>  	};
>>  };
>> +
>> +&ospi {
>> +	flash0: flash@0 {
>> +		compatible =3D "jedec,spi-nor";
>> +		reg =3D <0>; /* chip select */
>> +
>> +		spi-max-frequency =3D <40000000>;
>> +		spi-rx-bus-width =3D <8>;
>> +		cdns,read-delay =3D <1>;
>> +		cdns,tshsl-ns =3D <400>;
>> +		cdns,tsd2d-ns =3D <400>;
>> +		cdns,tchsh-ns =3D <125>;
>> +		cdns,tslch-ns =3D <50>;
>
> These cdns properties look bad, they bypass SPI NOR entirely. I'd check
> if these timings can be determined at SFDP parsing time, then I'd pass
> them to the SPI controller.

I agree, but I don't see any table in SFDP that describes these timings.
So I don't think there is a way to discover them.

>
> I see these properties are already accepted in the bindings file for few
> years now. Something to improve later on.

--=20
Regards,
Pratyush Yadav


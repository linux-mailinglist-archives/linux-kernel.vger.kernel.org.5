Return-Path: <linux-kernel+bounces-54449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6BC84AF69
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA3A5B245E1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5A412B153;
	Tue,  6 Feb 2024 07:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bf6WmOk8"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC7E39AD5;
	Tue,  6 Feb 2024 07:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707206020; cv=none; b=aa2ZUj2AqdSF5JaljPqlQLpEDm1FTczLmMvzo0ZuXi5RsmBlShm+xBO/SWLw5ZeoM4M1ej79+mltJGcOd3pw97c1oNKr8TsYsO3CamqznkgB7clhWVQKX1lI3vOdhX+VB6PRDSImtNP9+8SSVvQbZ/jVJaQTUPkjHCnrZ8t1xm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707206020; c=relaxed/simple;
	bh=jz2+5YFHxsUaP9YhKbytE2vv1d82tUYGMWDtEarsyBg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=OzyPssqPo/w54214R4YDfnirzYpc7hKF0j46WMbXzGRLR1llLCMadf/YFeroE4+HU9aupk+3pjNsrIhJpZF9xeELzwrB91r8/wLE/F0a8s/oedF/lHNMkGhXuHcnvuE+DorvW2Hp9+uxvQBf8dGNo2qWw5eLYOYibPTiyuEacQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bf6WmOk8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40fe59b22dbso1243555e9.3;
        Mon, 05 Feb 2024 23:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707206017; x=1707810817; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfkBm1RhD0fBqif8h7QjuzJWyO2tJjvDMiDZcwNsAPg=;
        b=Bf6WmOk8nKvmg/lh/mdSCfazUqcsLx85LCEmJOJZAS1veBDJrkbd68DhmsHEiRwwCG
         9sXcjGcFrdVvmcQWzLq+vXi46UHncQ3+beBENCmeW2H/4nFJ+EV5YgwyOJB4OnQbIdDq
         7CKVH2HjvQyaFwHk7C1sy9q0rexcx0wfD+Qnzp6yOY8vLmfGd6bS8Y74LAJc8btuz6+N
         PYkE65+6PBCsCB6yoDwizmPVPlenF6R/hgeG1P6tUUUGuGedgD4bv7nrt+QSLOpmC4kD
         qyb7OPLUKxcifyb1U8pJ14m/YLH6sG97p5Y9c8qxav88OyfVH1lSfkwNyUDF0lmiJwFI
         vISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707206017; x=1707810817;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zfkBm1RhD0fBqif8h7QjuzJWyO2tJjvDMiDZcwNsAPg=;
        b=ig00w6NefTSAD8bKtGlVYRa5LpHMR+i1f21uwNDGYpZeqjZumxaiCHCp6ani17pG9r
         N1QIPwNlaWUk/hnP3tCdtifrsr6V6AfoC8JM9YpCppLPd+v8WzmA7zHovuy6nh7vrcXI
         qjDHZf9KPRjjTs+Igkk6o6gnH5uZOMj1t1qIVB1JgZscYEYKxdSa5twpa4QDRuL+su1o
         uX2qYM8qievOeBoaToLqahetIrDXGNFrtwDLGC85hbYk4pKzmFdpSTQrY2C0WKwCkSAT
         HFfq4QFw0BsNwY8FkYOF8dzY2OJMzC3toB9FvU2lV5AnPZGsvpt6VZn98hIxshQ8LhEF
         ojZw==
X-Gm-Message-State: AOJu0YzCutsayyfoPVgDSSGDxhbA3rcNveC2XQcEAV+qvj4sTDpfklLl
	NojMu3C3y56YJMTVPPrCZqu5PiDflnti6F6tqh8pKiIjSiQFm2dN
X-Google-Smtp-Source: AGHT+IEkxytFY/M7v//MYcmidm4cgYusdjWKs3q86A1TUXUqt3jP1s6OjJY1u1rglqfVV597ka2Dzg==
X-Received: by 2002:a05:600c:511a:b0:40f:dd91:2d06 with SMTP id o26-20020a05600c511a00b0040fdd912d06mr1483545wms.32.1707206016988;
        Mon, 05 Feb 2024 23:53:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUCzbly27GvMKMmnHbmpUcxQJNeYbM47wEtSHLWabBiurZKyKWh49Lz4iBP4jbXue+rmAlQwV/GUKAZVhSZYzoNp/PSnkviJ5DZIhCznLX+ZqBW5kL3E58zGL4IhmL2cjYNXFOEbOnvVpAuTfWZhZ8vcYtsQLeO1eDr3zWM66TVUdfc5P7MS1R+MpUnxjlIxGLzU7uy289P73Xeo/WSW2L38L/r+cJ92XOfzD2cWga6qtZFC4JTyCgEn0+5cIMy+P9SWvxzYE/GYA95GjjXrrRG8Tp08gxzZg3dtLiJzGQa+6GJKpXPcs+hcMMXQzm4xEyAfUsJiMF3Q7uTIT8OdpVVNlawYaJImFVJ66cb4E2hypzDnq5yZ0NePmDdlkNmtKfB5mWagTYqwV0eYePM2EnBh8Rk0j6CX8W360MJ5ic7spXAFvsjGh4XVbCAYkKph5VoFAf+bf14DtFpXAGGb0qrMN4FSKw=
Received: from smtpclient.apple ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id n29-20020a05600c3b9d00b0040ef2e7041esm1093717wms.6.2024.02.05.23.53.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2024 23:53:36 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCHv1 3/5] arm64: dts: amlogic: Add cache information to the
 Amlogic G12A SoCS
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <4248e19e-5f2f-4e4f-a869-a0fec81b16bd@lexina.in>
Date: Tue, 6 Feb 2024 11:53:22 +0400
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 devicetree <devicetree@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 AML <linux-amlogic@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Viacheslav <adeep@lexina.in>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E850AF1E-BF7E-45F7-8AF0-68B548166094@gmail.com>
References: <20240205171930.968-1-linux.amoon@gmail.com>
 <20240205171930.968-4-linux.amoon@gmail.com>
 <4248e19e-5f2f-4e4f-a869-a0fec81b16bd@lexina.in>
To: Anand Moon <linux.amoon@gmail.com>
X-Mailer: Apple Mail (2.3774.400.31)

> On 6 Feb 2024, at 11:48=E2=80=AFam, Viacheslav <adeep@lexina.in> =
wrote:
>=20
> You missed the AXG family with the Cortex-A53 CPU. The datasheet does =
not provide information on cache sizes. Given that the A113X/A113D are =
equipped with the Arm Cortex-A53 processor, it is assumed they use the =
same cache size as the S905/S905X/S905X2 models.

GXM is also missing, and also using A53 cores.

Christian

> 05/02/2024 20.19, Anand Moon wrote:
>> As per the S905X2 datasheet add missing cache information to the =
Amlogic
>> G12A SoC.
>> - Each Cortex-A53 core has 32KB of L1 instruction cache available and
>> 32KB of L1 data cache available.
>> - Along with 512KB Unified L2 cache.
>> To improve system performance.
>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>> ---
>> No public dataheet available, since S905X2 support Arm Cortex-A53 cpu
>> nence used the same cache size as S905 and S905X.
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 27 =
+++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi =
b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>> index 543e70669df5..6e1e3a3f5f18 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>> @@ -17,6 +17,12 @@ cpu0: cpu@0 {
>>   compatible =3D "arm,cortex-a53";
>>   reg =3D <0x0 0x0>;
>>   enable-method =3D "psci";
>> + d-cache-line-size =3D <32>;
>> + d-cache-size =3D <0x8000>;
>> + d-cache-sets =3D <32>;
>> + i-cache-line-size =3D <32>;
>> + i-cache-size =3D <0x8000>;
>> + i-cache-sets =3D <32>;
>>   next-level-cache =3D <&l2>;
>>   #cooling-cells =3D <2>;
>>   };
>> @@ -26,6 +32,12 @@ cpu1: cpu@1 {
>>   compatible =3D "arm,cortex-a53";
>>   reg =3D <0x0 0x1>;
>>   enable-method =3D "psci";
>> + d-cache-line-size =3D <32>;
>> + d-cache-size =3D <0x8000>;
>> + d-cache-sets =3D <32>;
>> + i-cache-line-size =3D <32>;
>> + i-cache-size =3D <0x8000>;
>> + i-cache-sets =3D <32>;
>>   next-level-cache =3D <&l2>;
>>   #cooling-cells =3D <2>;
>>   };
>> @@ -35,6 +47,12 @@ cpu2: cpu@2 {
>>   compatible =3D "arm,cortex-a53";
>>   reg =3D <0x0 0x2>;
>>   enable-method =3D "psci";
>> + d-cache-line-size =3D <32>;
>> + d-cache-size =3D <0x8000>;
>> + d-cache-sets =3D <32>;
>> + i-cache-line-size =3D <32>;
>> + i-cache-size =3D <0x8000>;
>> + i-cache-sets =3D <32>;
>>   next-level-cache =3D <&l2>;
>>   #cooling-cells =3D <2>;
>>   };
>> @@ -44,6 +62,12 @@ cpu3: cpu@3 {
>>   compatible =3D "arm,cortex-a53";
>>   reg =3D <0x0 0x3>;
>>   enable-method =3D "psci";
>> + d-cache-line-size =3D <32>;
>> + d-cache-size =3D <0x8000>;
>> + d-cache-sets =3D <32>;
>> + i-cache-line-size =3D <32>;
>> + i-cache-size =3D <0x8000>;
>> + i-cache-sets =3D <32>;
>>   next-level-cache =3D <&l2>;
>>   #cooling-cells =3D <2>;
>>   };
>> @@ -52,6 +76,9 @@ l2: l2-cache0 {
>>   compatible =3D "cache";
>>   cache-level =3D <2>;
>>   cache-unified;
>> + cache-size =3D <0x7d000>; /* L2. 512 KB */
>> + cache-line-size =3D <64>;
>> + cache-sets =3D <512>;
>>   };
>>   };
>> =20
>=20
>=20
> Best regards,
> --
> Viacheslav Bocharov <adeep@lexina.in>
>=20
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic




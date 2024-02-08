Return-Path: <linux-kernel+bounces-58034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9005884E07B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B0D1C23BF6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CA671B4F;
	Thu,  8 Feb 2024 12:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rjcuxx9N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2599E71B37;
	Thu,  8 Feb 2024 12:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707394543; cv=none; b=Dj6BWdPlcE2EyToqPnABDGDBKq2DW2ARxku3sgpjYCtSI5vNpdZHHDqHwYzmFrWLfsNxyvNPVfblnfIq/f73ZQMWYjBLMdh/ArJ3Y10rkm8VaVlnW/ISPnn9tIfB/ZybSmkKuhTjq08GL64tUSXqhOhkXUU0ARlGxilMmmg0NC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707394543; c=relaxed/simple;
	bh=HD8ssfrPCs3mudGxWOlRjwSvpuYcFmOaUuOszBVHbt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AcL9FIsybD800cBjJpEM8wBQ8B90ZHNrRJVcV2ElTxiYddehA3lBg9MBOf/ADGces6GqJxdSq9SZI/ywn0YAn50KIESq0msD+suisKYhyxYVPhX/ILaM9lzr88vS1Z2/Mt10HwGtX0eOBeMQoRE7ozLt+1FekuySdUcGw709UVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rjcuxx9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F951C433F1;
	Thu,  8 Feb 2024 12:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707394542;
	bh=HD8ssfrPCs3mudGxWOlRjwSvpuYcFmOaUuOszBVHbt0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Rjcuxx9NhI8Phc0mWKFspNrSWPb9iHeL61bjn7QHLZjqOWaEy+Yk05x8NRx6ZdSNp
	 OVD8Iq52NkQJoJNI9pCsXKt5opTW/phV6j9OxMu+hAAoRYQNKtQpEsPArqNad7PpRo
	 QThHXWL6/P14tAIlL5HTluNiS+z23N+7zSTHmqszXL7VuHtwLwi0iBOWDmXw2b20wl
	 ABO5ft1zfzrXcec8Zmlaz49E278kDEF2Mq/aJGXSFQ3B0E8WE1VRhJzBssbKj78sx5
	 BGMe6YV2tYwVZLCTNwcMsGP3ScNz6vWFUZAbZZOpSywzou2bkoVwMeuDtinxXddbSS
	 4DBYbAEUePDrg==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so2036083a12.2;
        Thu, 08 Feb 2024 04:15:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVOm3vve3BbghzxuNUc6i1sjLJoW0nYttvDNVPwpI2fRQCuqNmgH4vFkX/Ei41S/1MT/KjqXh5mi9M+fjO5E02AkemI3GJgz19kVEgyrU5f0hbUPmZgpA/KV8+bZ+L7FvLAdiuU2MMsSA==
X-Gm-Message-State: AOJu0YzXtlG4aa96vrGNdPqU35uj+BGxXD0AoXKxQmBD9O4i1CHy0oAz
	S14ciC6C9eMcSEm4WoitY6Y+wDnR2qPRO1sN2gW49PpbhsoOejDGrPNZv+CJuN06D7m5IChtvfA
	VWheRzsChHg0Z3YRDZa1qwzsboSw=
X-Google-Smtp-Source: AGHT+IGc7wCpaZmzRLXw08H64IoAWQ6ApuS0ma8yFyLra7q7ckw32L6kWfj4rBPrKsub3Qtomy21hQ049VJ+4oa9wTM=
X-Received: by 2002:a05:6402:2032:b0:55f:8d03:411c with SMTP id
 ay18-20020a056402203200b0055f8d03411cmr5833914edb.24.1707394541130; Thu, 08
 Feb 2024 04:15:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208105121.128521-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240208105121.128521-1-krzysztof.kozlowski@linaro.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 8 Feb 2024 20:15:34 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7-+tKazjqgbqNckord+cpMDA2g8x77x8wKiQfKyhyf3w@mail.gmail.com>
Message-ID: <CAAhV-H7-+tKazjqgbqNckord+cpMDA2g8x77x8wKiQfKyhyf3w@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: dts: minor whitespace cleanup
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, devicetree@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Queued, thanks.

Huacai

On Thu, Feb 8, 2024 at 6:51=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The DTS code coding style expects exactly one space before '{'
> character.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/loongarch/boot/dts/loongson-2k0500-ref.dts | 2 +-
>  arch/loongarch/boot/dts/loongson-2k1000-ref.dts | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/boot/dts/loongson-2k0500-ref.dts b/arch/loong=
arch/boot/dts/loongson-2k0500-ref.dts
> index b38071a4d0b0..8aefb0c12672 100644
> --- a/arch/loongarch/boot/dts/loongson-2k0500-ref.dts
> +++ b/arch/loongarch/boot/dts/loongson-2k0500-ref.dts
> @@ -60,7 +60,7 @@ &i2c0 {
>
>         #address-cells =3D <1>;
>         #size-cells =3D <0>;
> -       eeprom@57{
> +       eeprom@57 {
>                 compatible =3D "atmel,24c16";
>                 reg =3D <0x57>;
>                 pagesize =3D <16>;
> diff --git a/arch/loongarch/boot/dts/loongson-2k1000-ref.dts b/arch/loong=
arch/boot/dts/loongson-2k1000-ref.dts
> index 132a2d1ea8bc..ed4d32434041 100644
> --- a/arch/loongarch/boot/dts/loongson-2k1000-ref.dts
> +++ b/arch/loongarch/boot/dts/loongson-2k1000-ref.dts
> @@ -78,7 +78,7 @@ &i2c2 {
>
>         #address-cells =3D <1>;
>         #size-cells =3D <0>;
> -       eeprom@57{
> +       eeprom@57 {
>                 compatible =3D "atmel,24c16";
>                 reg =3D <0x57>;
>                 pagesize =3D <16>;
> --
> 2.34.1
>
>


Return-Path: <linux-kernel+bounces-93102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E20D4872B12
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98E771F25460
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BE212D748;
	Tue,  5 Mar 2024 23:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgYxooau"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A50B129A9A;
	Tue,  5 Mar 2024 23:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709681588; cv=none; b=r3UzzKGbB6nHY9m+5dXdLbYWZftlWhj48VdIOp0spj8w6b+8sbML0Lp4iIxwASyi+uLdgD5j3ZDXgE/hyBM6MR/DIVRdX/cHT0CNi0qtEYcCiYiM0yY060G8TR07VakXMGZX1GQsW9ruoYqcIZExvbJxtfIOTiCig261ZcCo/Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709681588; c=relaxed/simple;
	bh=GV6QSpr73nKx1N3kC+/YquZZJlDLkT+Jyggf5X8nB3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kK12adwCAxDO8GupNVC2CAa3uZG2V5f2it6pXzFqH0UHaFWwZCTBPiWPXAmlySxo5wwmQHifAXah3i24h6MAOSa53VD1GSOHPrTAanxvvIHHKVZc8kZswT9iEBKTK71d+HN1jh2UdCcMyeC+YFivNSTo4a1ACGUZ7y/RP/vd6gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgYxooau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483F7C43390;
	Tue,  5 Mar 2024 23:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709681588;
	bh=GV6QSpr73nKx1N3kC+/YquZZJlDLkT+Jyggf5X8nB3Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JgYxooaukiQEv8kYAhZ+k9R8UPYFemzDg9fAoHRgAWYGUcpXyU1+0KI/RpXc+Wt18
	 3F4Awz3IHeC0YUcWMUaH5tOb10oE6Iqfx414SIizqoMIlTZshp8ToueLWjwXSUsY1e
	 3JNaLJK04BnTkufqmL0zpKBD67RXsmrMV7w4gWfS8X1sB3aGQI4S6V9r1nbNRHDeED
	 o+PQI5uL7uQcXY+DXbgtue9YJkDss6K8jh2J+BDDwCGlIRzo6hIEEZ52Xyg1n0GhVv
	 ynS003qguSKk1STR18zuBq5E0+apqIGy4k9IrdanUhAaCZgJTw1Qr8lIH+1Mch9tUX
	 L+z+NQ8hP43/g==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56647babfe6so9099735a12.3;
        Tue, 05 Mar 2024 15:33:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUI1HAl9Y+xruxuUtJQQvaZO+HFfxeD2ZDh0+ddbvJv8fpFpPuYLRsAxnifadAc5HHHNAJL8aayliQMPUE7NAl+i1fsBWjRC/hnm9lvSvyUNu8sdK/rQq4SQRo0m71BZVKUskFX35FNAw==
X-Gm-Message-State: AOJu0YxX+fJ+hlLls1pWnQCfnN0XC0R78HZC4WA4V3ubG1JIv2WZXhg9
	PL1Z2kJT10tzpKBw4xriS5KS2I42ienQZXbdAqvhJ5qKqHdFS1L0QZ00WcGWeiorhdsn7JOkz8i
	ZZEtoIb3zcPatyfTBST9HQlSv6/s=
X-Google-Smtp-Source: AGHT+IE4oE/82RTc1ckiCxung2i51spLqqwA1a4EnF/Ui8gBzt85uDUwF69igN7hEQLgRa4LJ4A4X/hQUKRWKBRJujQ=
X-Received: by 2002:a50:d585:0:b0:566:5dcc:1c27 with SMTP id
 v5-20020a50d585000000b005665dcc1c27mr8605222edi.41.1709681586660; Tue, 05 Mar
 2024 15:33:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_FC10B3C630BE27412FED2547245CBE18D807@qq.com> <tencent_8E66E30C9FBB60BB36B9230E2E56CC770806@qq.com>
In-Reply-To: <tencent_8E66E30C9FBB60BB36B9230E2E56CC770806@qq.com>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 6 Mar 2024 07:32:55 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS2cif-6+oym48yCM3zqifpdsnXavtuo81T6rFYkMi4ZA@mail.gmail.com>
Message-ID: <CAJF2gTS2cif-6+oym48yCM3zqifpdsnXavtuo81T6rFYkMi4ZA@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] riscv: config: enable ARCH_CANAAN in defconfig
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 4:03=E2=80=AFAM Yangyu Chen <cyy@cyyself.name> wrote=
:
>
> Since K230 has been supported, allow ARCH_CANAAN to be selected to build =
dt
> and drivers for it in defconfig.
>
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> ---
>  arch/riscv/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 89a009a580fe..f89df7ddb543 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -33,6 +33,7 @@ CONFIG_SOC_STARFIVE=3Dy
>  CONFIG_ARCH_SUNXI=3Dy
>  CONFIG_ARCH_THEAD=3Dy
>  CONFIG_SOC_VIRT=3Dy
> +CONFIG_ARCH_CANAAN=3Dy
>  CONFIG_SMP=3Dy
>  CONFIG_HOTPLUG_CPU=3Dy
>  CONFIG_PM=3Dy
> --
> 2.43.0
>
Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren


Return-Path: <linux-kernel+bounces-74830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 241A785DC85
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9E9FB26C89
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C687BB0F;
	Wed, 21 Feb 2024 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffBNQ0aY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF1D69D29;
	Wed, 21 Feb 2024 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523647; cv=none; b=NgRlp27KjO8XL3pSTa0xYe87wUKaLtQQKHa63x8Awf7/Uw7Z4Oj8A+1sciedvg8EL0kMYh2R/c8Oho58olYN3VpJM154sZ/fZWvyTsM9AueIDCFygZ2LyknrpDxZ8y2YW18beLJWBZB7xupaAwcW+jr+jMlAgo4JmsQlnHnUO6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523647; c=relaxed/simple;
	bh=LRGJNciaAUYgyD6k2NIgJqhdms8o6KcCLycAC049Z54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c6D1eNcdLijzj1Ty4qmAg8QNMaAwt7tFQH/wCcotNrfqoMOzsYoBba08T/d01vrMBi/p4yr9uXBgtnUhWUYdVhk0RBLK1j4LEmf4hmJzkVNjOm1jykSMwHYnRhdUVgVV+OkVxkNE97rNKzGBMMwrGWInwqSxJG2D8VOAULczSaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffBNQ0aY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56D4C433A6;
	Wed, 21 Feb 2024 13:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708523646;
	bh=LRGJNciaAUYgyD6k2NIgJqhdms8o6KcCLycAC049Z54=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ffBNQ0aY+AHLFsN8q3Zj6sifXWCH20xH8hq1POffsGgyqd1i+DWyRHzF7/KyO6+zi
	 1LvY+PYAdo6RH9BOIvYtAtZMgyhV8W8G8xHIhE/h9sNVbA0Z1QhN364pGAL1QSKQgI
	 amxIuOUzd+26jUQQ+mTqPyuQCIxUItFLzQT4xFTb58ECpjgvdJh9I0Rz8gLHE3QL+J
	 6QJBxxRYoVqlmAZDQVVWW1UwWFmE3zwzxPKDJ9//FvWrMKvdMDMmLSerCeU+zHWaQK
	 fBzRhhzSGOvSjDrr19MOF6zMkLneGb7bBLwZIM1UH+akcktmshJU8SuLWpQlA2gLut
	 IjWI2xVHB8dgQ==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d240d8baf6so7805741fa.3;
        Wed, 21 Feb 2024 05:54:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVDghDmj4LMOUTmfUjdBWJASRplK0uaF1Q4PCDPQYuupupWT30Mm+279FV16gL4jfYddMr9PqTIjnT/KSqcvjP0Yp6AgT6cBrvTUosGvODacNpH4WV53HLekCBy07wHFVBoIg4SokyuKw==
X-Gm-Message-State: AOJu0YwjBLZTZHCM2Ra1Bz7H5yzjqkhwqiR3uweIVdcYip3rYa4d2NtJ
	3Uhalm/YhEkzpt3OkRspNGLTc7oiRXegfsQtaqamraRDI8znRrKEpvg2UCTe8ouswLP902mJ18v
	FT2gmwyajYv77eOOSJZNiNQ7uXg==
X-Google-Smtp-Source: AGHT+IFallM18pmYp5SHxgVTMRrxZpYTzzOu2FTAE3dLdE8RPOEN74k5no2UpZSfyBOs0DoP85LVmn+jR1+jGOb2jrs=
X-Received: by 2002:a05:651c:14c:b0:2d2:3018:4cdf with SMTP id
 c12-20020a05651c014c00b002d230184cdfmr6701736ljd.23.1708523644649; Wed, 21
 Feb 2024 05:54:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221092826.748e70c4@canb.auug.org.au>
In-Reply-To: <20240221092826.748e70c4@canb.auug.org.au>
From: Rob Herring <robh@kernel.org>
Date: Wed, 21 Feb 2024 06:53:51 -0700
X-Gmail-Original-Message-ID: <CAL_JsqKw9OXb=aOMni1qprzeWDBgmjdJef-6VAjwx0R--D+URw@mail.gmail.com>
Message-ID: <CAL_JsqKw9OXb=aOMni1qprzeWDBgmjdJef-6VAjwx0R--D+URw@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the arm-soc-fixes tree
To: Stephen Rothwell <sfr@canb.auug.org.au>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, 
	ARM <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 3:28=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
au> wrote:
>
> Hi all,
>
> After merging the arm-soc-fixes tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
>
> arch/arm/boot/dts/renesas/r8a7790-lager.dts:444.11-458.5: Warning (interr=
upt_provider): /i2c-mux4/pmic@58: Missing '#interrupt-cells' in interrupt p=
rovider
> arch/arm/boot/dts/renesas/r8a7790-lager.dtb: Warning (interrupt_map): Fai=
led prerequisite 'interrupt_provider'
> arch/arm/boot/dts/renesas/r8a7792-blanche.dts:376.10-392.4: Warning (inte=
rrupt_provider): /soc/i2c@e60b0000/pmic@58: Missing '#interrupt-cells' in i=
nterrupt provider
> arch/arm/boot/dts/renesas/r8a7792-blanche.dtb: Warning (interrupt_map): F=
ailed prerequisite 'interrupt_provider'
> arch/arm/boot/dts/renesas/r8a7790-stout.dts:344.10-362.4: Warning (interr=
upt_provider): /soc/i2c@e60b0000/pmic@58: Missing '#interrupt-cells' in int=
errupt provider
> arch/arm/boot/dts/renesas/r8a7790-stout.dtb: Warning (interrupt_map): Fai=
led prerequisite 'interrupt_provider'
> arch/arm/boot/dts/renesas/r8a7791-koelsch.dts:816.10-830.4: Warning (inte=
rrupt_provider): /soc/i2c@e60b0000/pmic@58: Missing '#interrupt-cells' in i=
nterrupt provider
> arch/arm/boot/dts/renesas/r8a7791-koelsch.dtb: Warning (interrupt_map): F=
ailed prerequisite 'interrupt_provider'
> arch/arm/boot/dts/renesas/r8a7791-porter.dts:410.10-420.4: Warning (inter=
rupt_provider): /soc/i2c@e60b0000/pmic@5a: Missing '#interrupt-cells' in in=
terrupt provider
> arch/arm/boot/dts/renesas/r8a7791-porter.dtb: Warning (interrupt_map): Fa=
iled prerequisite 'interrupt_provider'
> arch/arm/boot/dts/renesas/r8a7794-alt.dts:450.10-464.4: Warning (interrup=
t_provider): /soc/i2c@e6510000/pmic@58: Missing '#interrupt-cells' in inter=
rupt provider
> arch/arm/boot/dts/renesas/r8a7794-alt.dtb: Warning (interrupt_map): Faile=
d prerequisite 'interrupt_provider'
> arch/arm/boot/dts/renesas/r8a7794-silk.dts:436.10-454.4: Warning (interru=
pt_provider): /soc/i2c@e6510000/pmic@58: Missing '#interrupt-cells' in inte=
rrupt provider
> arch/arm/boot/dts/renesas/r8a7794-silk.dtb: Warning (interrupt_map): Fail=
ed prerequisite 'interrupt_provider'
> arch/arm/boot/dts/renesas/r8a7793-gose.dts:756.10-770.4: Warning (interru=
pt_provider): /soc/i2c@e60b0000/pmic@58: Missing '#interrupt-cells' in inte=
rrupt provider
> arch/arm/boot/dts/renesas/r8a7793-gose.dtb: Warning (interrupt_map): Fail=
ed prerequisite 'interrupt_provider'
>
> Introduced/exposed by commit
>
>   78b6f8e7379b ("dtc: Enable dtc interrupt_provider check")
>
> I guess you missed some :-(

No, Geert separately posted fixes for already.

Rob


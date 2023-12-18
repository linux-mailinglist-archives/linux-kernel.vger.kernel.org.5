Return-Path: <linux-kernel+bounces-3809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5D4817286
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608411F24D7A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C531D148;
	Mon, 18 Dec 2023 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzC1NSts"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0CF3788B;
	Mon, 18 Dec 2023 14:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6FEC433CD;
	Mon, 18 Dec 2023 14:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702908448;
	bh=ylwDB8EaiT63RbKsIo8qmDnkgJNsnzzWUofGhTQT/vs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HzC1NSts+MmJjzo3EomeX8gDR0AnhqmH/okCKAsD8/tLXzzCuw01ZIB4Nxv9D/dMY
	 2a92RPoGr71Ovqd4kuV6zMT1d/hZlstRmCYkF9yrf0FMei3iCm0KDiHeXQyf8CICTx
	 zjKqD8nUsCt1jp24enQT5/jprEg4SODhrHWANZGKPCPufaC89/uvnlqeKeLo0BA/wk
	 OJ9y9oRMpApKY7dXr+FTj5oMecGkc5leJblhXBpRblIDYYQ9GyoGfdZdwVnyQT88O3
	 kioFABef8iNvJnZkZTt1I8tvJlLEZG8Mpyvznd03/DsHcsMdEqsyWzMMbR3BR8POZ+
	 pu0fUB7aFzN1g==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cc6121c113so18638421fa.0;
        Mon, 18 Dec 2023 06:07:28 -0800 (PST)
X-Gm-Message-State: AOJu0YzFckKr8va8OpPoRmpRo796sOTdDez2075oiH4dHCXz/+s4A8LC
	trpfCqmI2KgWWgrnKdJEQh0qWhXOJOJnncyP1A==
X-Google-Smtp-Source: AGHT+IGGmE7yX5GXoA6PiC+8TE5JiB8PD9CYSkmjUJCS1/0lm9lmnWQvmBEyLX4HpQeDPl4CSfVmmcguFpKFx+EqrOU=
X-Received: by 2002:a05:651c:620:b0:2cc:6ab1:e6a4 with SMTP id
 k32-20020a05651c062000b002cc6ab1e6a4mr465013lje.71.1702908447045; Mon, 18 Dec
 2023 06:07:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218164203.530ad4f7@canb.auug.org.au>
In-Reply-To: <20231218164203.530ad4f7@canb.auug.org.au>
From: Rob Herring <robh@kernel.org>
Date: Mon, 18 Dec 2023 08:07:14 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+9TTE01MO5HtcB34gX=d9XR7dGFRgqYg0nUY4_NzhOqA@mail.gmail.com>
Message-ID: <CAL_Jsq+9TTE01MO5HtcB34gX=d9XR7dGFRgqYg0nUY4_NzhOqA@mail.gmail.com>
Subject: Re: linux-next: duplicate patches in the devicetree tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 11:42=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote:
>
> Hi all,
>
> The following commits are also in various other trees as different
> commits (but the same patches):
>
>   11844f340318 ("cdx: Explicitly include correct DT includes, again")
>   319e31686b9f ("tpm: nuvoton: Use i2c_get_match_data()")
>   5adf0863e467 ("serial: esp32_acm: Add explicit platform_device.h includ=
e")
>   68398c844813 ("serial: esp32_uart: Use device_get_match_data()")
>   72cc46a84b80 ("pci: rcar-gen4: Replace of_device.h with explicit of.h i=
nclude")
>
> These are commits
>
>   aaee477e3e2c ("cdx: Explicitly include correct DT includes, again")
>
> from the char-misc tree
>
>   ebf2d4e8e582 ("tpm: nuvoton: Use i2c_get_match_data()")
>
> from the tpmdd tree
>
>   2600d9939440 ("serial: esp32_acm: Add explicit platform_device.h includ=
e")
>   3d19ff562d06 ("serial: esp32_uart: Use device_get_match_data()")
>
> from the tty tree
>
>   ec2152374804 ("PCI: rcar-gen4: Replace of_device.h with explicit of.h i=
nclude")
>
> from the pci tree.

Yes, expected as I was carrying them until applied. Now dropped.

Rob


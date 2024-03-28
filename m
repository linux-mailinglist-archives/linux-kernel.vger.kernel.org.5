Return-Path: <linux-kernel+bounces-123045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DA789016B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8B3FB2422F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54434823CB;
	Thu, 28 Mar 2024 14:14:14 +0000 (UTC)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44C814294;
	Thu, 28 Mar 2024 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635253; cv=none; b=gbCbA+fOBmw0aApEBzHRANuLeVHe745R16Qvw4gFLKmY0Jhw0JeWIrHwxskDdC1sK9q42ZwMHXtP44Q8v42dsZK7pytvfstOpYc8vaqjG51dhSaMJmRps+6+6vf42rljiwx+4gEt5ZIcX0tgpasfipyabuXTIz6MNKjGqnnunso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635253; c=relaxed/simple;
	bh=aHiAHQZ4NABASJrYqh8ebkIampi71CgvClYUPY03YUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AiCh8qTyKvN7YHUztruo22jr3og+g1TCaVTVrguhSCv4Q2Oam7EljPmLcAfJbgzoNOM4KC8VSUCvpKySTi/951ycThhVufvskAf1yt3PfGhN9YQ+bIfMV6PgSnENTEvhncor/qEQ7NQtnadNy4blyr1Q3koniX1wsxw8Ir6ivaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so969315276.1;
        Thu, 28 Mar 2024 07:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711635250; x=1712240050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NefUZqr+Yfj8Qez7QQphPqdSKucudQKpoHbpjj/G5I=;
        b=pQ91T2CR07oeEsCc9BdxYATtIcoUrUsbgH2N9S+cRpHoymRXhIuzcgXgHOpiIvUuXR
         5I0crJGQNYv9FIuPB34FfiCd2cqOqsjEXLP0O4hu1IOyOzaNf8IRS2bVBDrqVymvD5cj
         eaScmUPIXm4Zx+I1nctvVNqNR9e0Ep/Kr1onvtAosWUXg5T0Y72M1f+NWtxI5cBx4Gav
         bKK4DFeS1PZ0DHatrJLRquBmETct2f84NpDgmtM9q+Xh35eRTMa8/sxVxxCPvCMVj9ZX
         DFW22oRtCSOi8D3KaVL8ixes9bhO0f7GuPQ07bCXh9H7Bos18xTmyD8Y7FFistNrbOq5
         h0jg==
X-Forwarded-Encrypted: i=1; AJvYcCU/THNq4a9naDxLR0OxrKjeQc6VV/iN+uddXlT5t14ZMhg2ZxHcb7+bxKFcBF1vwoZv5N0fvncNIoLnS3K584VQWfJ6T9UnkBplmz8rZrnlK/PqOYGwI+9Pjm+bWGbkihEA7Qjbayd18qQBxkR7UpgDO4r7evYWqQObCtJauqmMGuf87BLZMJSLj24jEBvyqiisQJM7jo3mI559K7S3ClcKgi7VTOirXA==
X-Gm-Message-State: AOJu0YwF1vhlBbFUdRrJzEejMEqosNtBRuHEeLjxb2VqdMzQwonE57rm
	pg8DNP/n9SnRjKILVgQCyiJwxc/jUdln+agL64G5kl3b7fukspVBhKlS4zw6tNw=
X-Google-Smtp-Source: AGHT+IEM3zssbWOSnDMrjyNKrON0pNmD2juCMJCOs6F4V4C3Sl2CLvlLZkgK76K0PWAovpQeiWOy8Q==
X-Received: by 2002:a25:a290:0:b0:dcc:a446:553 with SMTP id c16-20020a25a290000000b00dcca4460553mr2759135ybi.57.1711635249889;
        Thu, 28 Mar 2024 07:14:09 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id p15-20020a25818f000000b00dce0a67ac8bsm304046ybk.23.2024.03.28.07.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 07:14:09 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dcc4de7d901so915906276.0;
        Thu, 28 Mar 2024 07:14:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW7xbfqe46XVmSa/BltuNY40XqQVNM5lrIWhcQ8iJWq5jkPxsZx8Om/aL0O2Ojqnoq3zUQsJw8o+6IJQ8ZY5ee0xazn+yrZ8wKLna8WtXF4Y14GngOHeAi2VK7RekV7xuuJNPd0+Why/kVu/4jjmAjctS/fL9L4Mhxj4pX8d4plOS78SEvYBg+eORehxnJsPfxUn22kMadu+zShP8Pi1DrXHn4FgWJ5qw==
X-Received: by 2002:a25:bc49:0:b0:dcd:5e5d:4584 with SMTP id
 d9-20020a25bc49000000b00dcd5e5d4584mr3267859ybk.34.1711635249059; Thu, 28 Mar
 2024 07:14:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326222844.1422948-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240326222844.1422948-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240326222844.1422948-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 28 Mar 2024 15:13:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWdaiSer10agMytpv9h_gb4bEpEHjThDwRkMShXkKMxzA@mail.gmail.com>
Message-ID: <CAMuHMdWdaiSer10agMytpv9h_gb4bEpEHjThDwRkMShXkKMxzA@mail.gmail.com>
Subject: Re: [RFC PATCH 06/13] pinctrl: renesas: pinctrl-rzg2l: Make cfg to
 u64 in struct rzg2l_variable_pin_cfg
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Tue, Mar 26, 2024 at 11:30=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.=
com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Now that we have updated the macro PIN_CFG_MASK to allow for the maximum
> configuration bits, update the size of 'cfg' to 'u64' in the
> 'struct rzg2l_variable_pin_cfg'.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -241,7 +241,7 @@ struct rzg2l_dedicated_configs {
>   * @pin: port pin
>   */
>  struct rzg2l_variable_pin_cfg {
> -       u32 cfg:20;
> +       u64 cfg:46;
>         u32 port:5;
>         u32 pin:3;

Doesn't this store the 46 cfg bits in a 64-bit word, and the 8 port
and pin bits in a different 32-bit word?  Worse, you'll get 4 bytes
of padding at the end of the structure.
Changing the port and pin to u64 should make sure everything is
stored together in a single 64-bit word.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


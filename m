Return-Path: <linux-kernel+bounces-81818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAC4867A66
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762971F25314
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4073612BE87;
	Mon, 26 Feb 2024 15:36:55 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C5F12B159;
	Mon, 26 Feb 2024 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961814; cv=none; b=OyLHp7L/8ZDyKhBnkRgsAKeZJk9Y6xSW9AoRx+HExISbEnLhPT3FA3CQFMYHTuWnDKcHN4AnMUKkeAXZOCaOt8GbgKThAEqRi0rsIYAwnJ5aFtXGGpBkjr0yGEWJDZPK2szFTWsFkAL2ssMk0AmjfI8UE7Mw2H8uLou/isRJ4sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961814; c=relaxed/simple;
	bh=BjNxNSutKJiNR5zXcgPNhRhILN601sd61EC4YV5AKX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tom+X2Bmo/q3kfQcEBkTpEzkTwmEJpGj7CLtAJ5NQ+9xdnUYIf0p1Z9OBRsQTeizTmIjmJd60CasTHaZljvV2IezPmSIxkwQ1aPppVAV/+Jfa0Y/SS7q0sp9E029P+gS2ESj49Gv9I5mD5rbM2nVFKjxg7V3KICmaiRJdh7E8bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-608342633b8so28058337b3.1;
        Mon, 26 Feb 2024 07:36:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708961811; x=1709566611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6sTzvocRErrvVxGZHtwvRZxdbc4PLEFDUqv58JeN2Rk=;
        b=oVu86ljrU5JbLkxU0BQ9Vp/OqFMHWHQ9XpO8OD86pA0/GUrtKEPV46866KKa4Jvx0x
         To7ByAOLBp3/GzCP7Ok/uhGAi/Jm2RCng3g+083lf/Or1/0D2UednzARdqdDCYCcIX0O
         vjKJA90Oat+tATTAo646Px2HbuAbPTEgxdWnQODS+7I5xJk62Ewfw7Pnx4z2S/k/Azx3
         E6pCDsYY65bxLq30bmyEgaulDBz9GwEeKVsqEBumWu7NSwbc/cGVrwGNn5JJ9yIyiksU
         bLD3IZlxM9XVmBa9sjpC1wjpU9ZszwLGLRJQsC8BhSt2IDwljMC5J0T/Jw8g9C9CvEKu
         eXPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaIowlxjuNIWIDQ3v/hSU9IyoAL+iUKQtSe6orOrRHZebgtwYe5c0JbjCzZ5duLWIqmY7XYSRqi0vkazBazDdkazV2ykVBMOmUag+p/yP9unPNsY7KRSU6fvNE6k5ZcL/t8ZMoiL+w2A==
X-Gm-Message-State: AOJu0Yyjpe4MH2Q6X0Xi+4a3hWteMLkqg99wuRWqvg4BFdktSt+tOoYr
	8AuKvGcgSJAZDNUajjvB0h+j0HccQrrDrHz5fSrB5nczMYd621sBJTeMaGQPUJo=
X-Google-Smtp-Source: AGHT+IErRkgW4BaT5Z+TBbzM2IZ5mgxoI04IY2LWrdSTfjDiQXuA4FF3aV+SK6ux0G4uDnsu9JF/ew==
X-Received: by 2002:a81:d208:0:b0:607:8afd:fa32 with SMTP id x8-20020a81d208000000b006078afdfa32mr6808614ywi.28.1708961811681;
        Mon, 26 Feb 2024 07:36:51 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id s6-20020a815e06000000b006079e8f3572sm1235572ywb.85.2024.02.26.07.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 07:36:51 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc6e080c1f0so2594908276.2;
        Mon, 26 Feb 2024 07:36:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXRTlzjHd0y9wTdnpMKk9BGTAO+IiVIX+axmnBVLb0pXV0Hylicks4hf6LmRRrGq2GiJh1LtKajEQpgwZzGgfjqFsVFSfn/ybi6Pu9P+DxpvdXkk+tGibcFYuRuPGO9uyJ1i7WrqHSmnw==
X-Received: by 2002:a25:dbd1:0:b0:dcc:9e88:b15 with SMTP id
 g200-20020a25dbd1000000b00dcc9e880b15mr5134183ybf.41.1708961811025; Mon, 26
 Feb 2024 07:36:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com> <20240219170337.2161754-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240219170337.2161754-3-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Feb 2024 16:36:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVSZZdRwxUOgz9-SkPwoC4FMYtfwhncC19kNHPmy_Bp2A@mail.gmail.com>
Message-ID: <CAMuHMdVSZZdRwxUOgz9-SkPwoC4FMYtfwhncC19kNHPmy_Bp2A@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] auxdisplay: linedisp: Allocate buffer for the string
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 6:03=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Always allocate a buffer for the currently displayed characters.
> It makes the line display API simpler.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

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


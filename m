Return-Path: <linux-kernel+bounces-120703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D47C388DBB0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EB352939EF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578414AEF7;
	Wed, 27 Mar 2024 10:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDOjXZSJ"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046941E88D;
	Wed, 27 Mar 2024 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711537132; cv=none; b=YNcnIZE8q0cDaP5DJm5nyQm36CedK0moMsGCDh4Mar21QU3JvrKNXPsUc0uhs6g7QtgHP6fXEeTfD2Fm0lf6fDE/b0UNvrRL+McbTFFg4BuIyIAPRTCJTkjIFbxxUgOUC7IbzWVBqkJbOmlqBkLq59jIiTbz6VQb4nWi53ZHkNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711537132; c=relaxed/simple;
	bh=FPOIGS3XU/PJpUjx1JSgCVFLz7sjFzTxaraDc1Cj4iA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t64uLlr6bZzyFQSD8oHuCpe5bxwUrU7w7U+Zvs75QDA1wlt5MU/VoSaLB8PT4Nwt4yK549eKa3j5pkDap/jUWd62KLHivseZ84fpYZOhKo7JxomDb/7JJ8wfefjTBTwoS5IKhxOuiADL0iazaEppimjB6Oia3JAWHz7F4geuQek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDOjXZSJ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56bb22ff7baso7764019a12.3;
        Wed, 27 Mar 2024 03:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711537129; x=1712141929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdBJoZMB+M+m7as7ulZ/MHo9uJhY03Nr+jTBbOpnN74=;
        b=JDOjXZSJ6ipTc+oszly/nqhiauUcyyEHiXfbOJgzP9F4O1ufqG5IXz7pmmidLIIFSE
         U36O/G8lXfLoD+EqUVCC0mnR95IRvyS1lIVXcFbx3MNt0OVV1TcwNNoY5X9f6Rfbdjxi
         xcK2HplxTqO9NnygWMN61IccVe6iKXb/lxgFqiFpO8wL8Jeokpg5mWsFcVZo3rqy7NyP
         7wJ8SkIF4zv9ESGl+24JKqnAUJ9konTmaGeDv9nqDEUnCbCacVy1DJvs4roBq+tmmq6r
         vMYq9BlK6XEUoZIhU0B/81sFzZ+b+F585rJCgjDRcasdiX89WGFO1+D73ys8TIpwwx4O
         9Ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711537129; x=1712141929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdBJoZMB+M+m7as7ulZ/MHo9uJhY03Nr+jTBbOpnN74=;
        b=vGWKzsaKAp7AL26b4MrwKaNi8uOFdmeV+r8M+BuCr9JuyuqKjqIjWBQR29el8cWAe9
         wThjrzqEeCzXe3uh9UO9dCQZ+M2KmZ4g5bkH1+bOOZtsUrFOPPQ8QuGymZQo3nwEGG6U
         NVOqoJw8o2Z/PBLUZvDvDGepR5zgdE+4rxBXW51W1DkIuq9U3DhIv8S2KdFDnoptx8T0
         yA39onSmkuL+iucHH+rvs1/S/g9fHcdLhDZFvRd1stAghZ0TIDKqrZGpv3R4cmoSnRNN
         cw908CJLMHSo0uq1S1g7CWU9/zNpFyKwvNncpPUD1e9GOs2dLgFFh4XO7wCNQZWXi98Y
         Ljnw==
X-Forwarded-Encrypted: i=1; AJvYcCXy7BZQjdZuJuvoV2h7O4ZhYLTOwqI83DrBKG7NmSX2iAz3BrSD1J8h9noZ0Bn8P9fsTOAgsSrB8UX3u53hqOclLfLdAhVKneU8XEVw9G/eLSVEIQxGc2tk/n2Nz5BNhcE5Hx63OOCTbTotrLs/O51MAw==
X-Gm-Message-State: AOJu0YzcHC364rJQ0Gk4Cbh553RXdFN2yWt5UIS8+25zSi+SYLneqYBD
	VXBGyzM4KgszHLXsogvci4vyL6B8SgJib3eWp/v1n/tdqDb+aaJ0qHwiKgiUUX8sXE1z17Ih1Nr
	OiWp4lbEXwZfKCh0YBh5Ej6L94wA=
X-Google-Smtp-Source: AGHT+IE4QWniaYBGdlfiIo/PIZxypR+YNDlj/T7yCI0n5qUoLGvcU9GGoY+74iIG6sH3olcGanSfCKapfSKQJzLoh9I=
X-Received: by 2002:a17:907:9689:b0:a4e:dd7:4e24 with SMTP id
 hd9-20020a170907968900b00a4e0dd74e24mr35601ejc.23.1711537129044; Wed, 27 Mar
 2024 03:58:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326223825.4084412-1-arnd@kernel.org> <20240326223825.4084412-6-arnd@kernel.org>
 <20240326230511.GA2796782@dev-arch.thelio-3990X>
In-Reply-To: <20240326230511.GA2796782@dev-arch.thelio-3990X>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 27 Mar 2024 12:58:12 +0200
Message-ID: <CAHp75VeTq=eyumbRWiQeLnpbTOZJR=R_7=+RkKtY2YcL-z3isQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] surface3_power: avoid format string truncation warning
To: Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, llvm@lists.linux.dev, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 1:05=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
> On Tue, Mar 26, 2024 at 11:38:04PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > clang warns about printing a pair of escaped strings into a buffer that=
 is
> > too short:
> >
> > drivers/platform/surface/surface3_power.c:248:3: error: 'snprintf' will=
 always be truncated; specified size is 10, but format string expands to at=
 least 12 [-Werror,-Wformat-truncation-non-kprintf]
> >   248 |                 snprintf(bix->serial, ARRAY_SIZE(bix->serial), =
"%3pE%6pE", buf + 7, buf);
> >       |                 ^
> >
> > Change the format string two print two less bytes so it always fits. Th=
e string
> > is still truncated, so there is no change in behavior, but the compiler=
 no
> > longer warns about it.

> > Fixes: 85f7582cd484 ("platform/surface: Move Surface 3 Power OpRegion d=
river to platform/surface")

Hmm... Is it really a move patch (which by title should not have
changed the contents)?
(I haven't looked into it, though.)

> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > Not entirely sure about this one, as I've never used escaped strings, a=
nd
> > don't know if gcc is correct to warn here, or if the kernel defines it
> > differently from the standard.
>
> As far as I understand it, this is a false positive because clang does
> not understand the kernel's %p extensions.

Yes, %pE here is special. Btw, what has already been discussed a long
time is to have a validation plugin in the kernel to check those %p
extensions, but IIUC nobody committed to it.

That said, the patch is most likely incorrect.

> GCC does not warn for
> overflow or truncation when %p is involved but the clang developers
> chose to intentionally deviate from GCC in that aspect while sticking it
> under a separate diagnostic that we could disable. I sent a patch that
> did so some time ago but I guess Masahiro never applied it...
>
> https://lore.kernel.org/20231002-disable-wformat-truncation-overflow-non-=
kprintf-v1-1-35179205c8d9@kernel.org/
>
> Consider dropping the changes that fix non-kprintf warnings and
> including that patch as part of this series.

--=20
With Best Regards,
Andy Shevchenko


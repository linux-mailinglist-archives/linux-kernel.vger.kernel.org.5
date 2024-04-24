Return-Path: <linux-kernel+bounces-156909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DEA8B0A32
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433031C246C2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F8515ADBC;
	Wed, 24 Apr 2024 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YxPBbcXl"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD03142E70
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963490; cv=none; b=hZVl/ZaCY4YUTZCkRG474+JAd2snc50HsL0Q97y+C5gpSWnEWymoU7VHzOufJwd3HphtMPkFEJPDizIdGYmel04vPA3kebhfvJNznXb4QvxWWjmdj+CPZBul5OEKb1zstkT9uhCIuww65fKr49v/TEsAHRWluAO9BnZJnSeoPXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963490; c=relaxed/simple;
	bh=bSmiXrrngk3nVYD1ESlkMmhOh9YwC4mUMCtZmjMqvBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fuB/QTgQUuhY/GdYz+LHUz6Xd53sWmpweT6fZ6OG2FqxfB0J5L9MPKtzQp/3troo9aFbrt2TAha26+CIPI9VlNok+XQoyRkT7n/U3bGaQAE2HXwDTQ4dKhnmyaPHSc8cYo0XhU49KUmOFoiy8i2kaRMSe+FhyARq3Vm516xd3XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YxPBbcXl; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-de54b28c41eso2251659276.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 05:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713963488; x=1714568288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSmiXrrngk3nVYD1ESlkMmhOh9YwC4mUMCtZmjMqvBo=;
        b=YxPBbcXldo3fu8hqM3OeHg8qilyCfpJMiOD9uryKPr4ZYYKROFAylAk06DrCprKTXx
         +I7sLdpOHvsbFzqDCcuiCIOGKVwXTv/MHhpdqKSKCoXmSn3KOtYHAY/s5WvyE6HURcHE
         slrrY2Row9m/CK9ehy6gvvKCu0Lyf9tTlLcXejAKlx+bBG7ihLUn8M4sbiuiJ46R2FlQ
         VbQONwSUS06W7KLaebLE1357UmlVAM0gWOY3UmcaZO0BBhq+HifFpTygTtOF/P6djuFx
         19biVC6XCXKWn85YEm8ah9Ly4DhC4Q/ai10HuVwQJk9/LK8xB+ICoyIF6aswrmVV+1w8
         +C6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713963488; x=1714568288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSmiXrrngk3nVYD1ESlkMmhOh9YwC4mUMCtZmjMqvBo=;
        b=W5cMy5+2RBhx3bAyAcucTkuCwrTDj44fnBg868/NPsGZjMhiaKM0IRs7kAWQ8P9q1B
         fhdONo49/cIgoKufsam5MTHyJ99n3Wf4+yHhO5w0MGpOVxIdFUm7aiuhE+WOj2j1UXw1
         TCLYMpnfCiYL20cWrZwxMbyC/0aqHn8zkNl+QaV67iJeaFhKLeyig9/dOaMN9BWyIjDS
         p3tuJdkR6r+PCDCwgn/fB1jqjOjtAUsosBSUb56L6Bry889hL8fdV90dN4yaEE94ChTv
         urvDpZHHw3vsCkKciGgmhbtpuKGNJfPlARvOVpPNdst5sifSJ5dX2N1m6ZZbAAnTrGhg
         8NJA==
X-Forwarded-Encrypted: i=1; AJvYcCUr5zYJYwBUTFyc4EMzp1C8hdN8ZX6HMPiKaCWSkYI7cJMERI7bsvLZEUVpQy58zHIPEAnHegWLoVFpTWN+0PXBBSzmq43Jnazal2UJ
X-Gm-Message-State: AOJu0YyzTDbA44u+144rMUo5OSX0ERBG17qLAm0kE1rfL/S71KN+1diK
	9GHGA5ev+E+vUF1uGX5V63kXBeJpwspTb/jbT2wu+cy7lNLrARS2ghUmjEkGsaSM0Zg6fvcjc6q
	eaXTbsSCFzW9aQv7R4Oy1YLJ5RmjBwwB3mkaY+w==
X-Google-Smtp-Source: AGHT+IF0SeaFBpzWYEpTIWay1McelyuIqowaka9D5+ZW53B6hEDrr8A5zyXzstUikgoJK/sUowrhBgt1SUT5qI0VrBc=
X-Received: by 2002:a25:c187:0:b0:dcd:b76f:36de with SMTP id
 r129-20020a25c187000000b00dcdb76f36demr2615198ybf.1.1713963487846; Wed, 24
 Apr 2024 05:58:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422130036.31856-1-brgl@bgdev.pl> <99242a7c-53bf-4227-9623-7bc092f564b3@penguintechs.org>
 <CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com>
 <b982b73d-0540-409c-a6e2-0e03ecb11715@penguintechs.org> <0381f39c-38ba-4a2b-915c-f14c5f911eb9@penguintechs.org>
 <CAMRc=MfnEct7ThQhCA3AoY7hxq8j1mmFLNNkK17+RSvJxs67XQ@mail.gmail.com>
 <2371f538-ec53-4037-b171-c62bf4e06eb1@penguintechs.org> <CACMJSeunUaj0cxLaN4MpFmX5vTOx_vnWjBN4Y2FavdQoQxFRkg@mail.gmail.com>
 <4c33304a-5dbc-450a-b874-e04ba9e93150@penguintechs.org> <CAMRc=MeDQFHX9r-sHNxqkfpi=LkHoRSL7i6dWokB-J+J03rBEg@mail.gmail.com>
 <835f54a6-bdf7-447b-b76b-185cdde99450@penguintechs.org>
In-Reply-To: <835f54a6-bdf7-447b-b76b-185cdde99450@penguintechs.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 24 Apr 2024 14:57:56 +0200
Message-ID: <CACMJSetN0XVW0y5Sse5oeBWn6O73MtcrXApUFAjjBvkRHJxFiw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: set power_ctrl_enabled on NULL returned
 by gpiod_get_optional()
To: Wren Turkal <wt@penguintechs.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Apr 2024 at 14:30, Wren Turkal <wt@penguintechs.org> wrote:
>
> On 4/24/24 5:27 AM, Bartosz Golaszewski wrote:
> > On Wed, Apr 24, 2024 at 2:24=E2=80=AFPM Wren Turkal <wt@penguintechs.or=
g> wrote:
> >>>>>
> >>>>> That's OK, we have the first part right. Let's now see if we can re=
use
> >>>>> patch 2/2 from Zijun.
> >>>>
> >>>> I'm compiling it right now. Be back soon.
> >>>>
> >>>
> >>> Well I doubt it's correct as it removed Krzysztof's fix which looks
> >>> right. If I were to guess I'd say we need some mix of both.
> >>
> >> Patch 2/2 remove K's fix? I thought only 1/2 did that.
> >>
> >> To be specific, I have applied your patch and Zijun's 2/2 only.
> >>
> >
> > No, patch 1/2 from Zijun reverted my changes. Patch 2/2 removes
> > Krzysztof's changes and replaces them with a different if else. This
> > patch is a better alternative to Zijun's patch 1/2. For 2/2, I'll let
> > Krzysztof handle it.
>
> Got it. Thx.
>
> BTW, should this patch's commit message include the following?
>
> Tested-by: "Wren Turkal" <wt@penguintechs.org>
>

Please respond with this tag under the v2 patch and b4, patchwork or
whatever other tools the maintainer will use will pick it up.

Thanks,
Bartosz

> If so, please feel free to add it.
>
> wt
> --
> You're more amazing than you think!


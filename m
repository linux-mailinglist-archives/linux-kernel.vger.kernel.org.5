Return-Path: <linux-kernel+bounces-26515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D4282E27F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F59BB220F1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 22:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA27E1B5AC;
	Mon, 15 Jan 2024 22:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="agIlr8ZH"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEB11B5A0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 22:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ddeb015ec6so4973258a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 14:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705356987; x=1705961787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smGP4/vbSoxRhEbuPgjZxI7Ma1afrNafYH29Jzd8O0o=;
        b=agIlr8ZHflklNZACeEnBn8e6/LERkCh9hIeQYqXu8trgPdA7O4aiRbwuThvhyqJhXc
         G7D3EOGHU1rCrFH6wWU0njkVH9z3cZ+YM+BD/Hp6jhqDDrqJHZLCDgpJorBvU/2lU3vD
         AlA4tqUfLQKGxzI4ncVrk/AfcmnDHrbNFYK8ciBwxTVSH4Viqtfhz6qpeVll069L5N6l
         fEpb6xLRpWL98aHtI5JJc1g1APZqEdMBNuWyASG8BXutZ+vYHp12M9t7Og9xQb8aq+MO
         ieTBL2JPa7/vnCuZDZpM2tFgJ+LmvZs7sEnGoqokUDuYWQpjdz5V5hrlkfluLdgpjvAl
         Cr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705356987; x=1705961787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smGP4/vbSoxRhEbuPgjZxI7Ma1afrNafYH29Jzd8O0o=;
        b=WqEJwMwfb+bSbUkONCMvXFGjBQy4xDlSFjCFNyQSNnvd91+KG6LjhKZO0gMN5k9Hau
         o/H/REl34fn9M9hkwomRIKlipmCbFxZsk2hZ19Q6aB2XJSC7/g1rtCwG74iwi67Me2g1
         GBCWFeE6n8hyc/FY3VGgE+K87bEclNdVkoTx7kj64upWVDUiBjy791xdDexHbOO39KQk
         fO8x4nnpO3eCalYv5e5DLe1zlRk4gVKBd+8Y2EXbnJyac/o0u9Zz90IKiXcuRu0Yl0Pn
         Hae6KaGn9Rlv1HUjxrk3aLc6dn3G5bgxylUn4mS+jOZVIMFmA2a0uVDSTYsH3lk0gf5+
         PJlg==
X-Gm-Message-State: AOJu0Yzw9A6ZgmKu4scGSbkjaszmnRrm3cTWft3Yfw5N1pkpZn6DkVwc
	VSUEmGxFzqP/X4DaQbdBZAlWrO2GPy+stLgHcFFfKDkAy++KNw==
X-Google-Smtp-Source: AGHT+IHAqvqD/AqQ9BF4p3rb5LnH+dMJ5jj/tciKrJ/owq0ig0xatSfXjyhc3O3BL6RTg3NHee9ntgaxDjc9po+ctlQ=
X-Received: by 2002:a05:6808:2088:b0:3bd:8a84:3393 with SMTP id
 s8-20020a056808208800b003bd8a843393mr10225oiw.93.1705356987545; Mon, 15 Jan
 2024 14:16:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115185647.30663-1-rdunlap@infradead.org>
In-Reply-To: <20240115185647.30663-1-rdunlap@infradead.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 15 Jan 2024 23:16:16 +0100
Message-ID: <CAMRc=MfrfUJAHA+LdfU1590MHizn+2MkiSyjt4X_GXMtD+VXLg@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: EN7523: fix kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, John Crispin <john@phrozen.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Felix Fietkau <nbd@nbd.name>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 7:56=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Add "struct" keyword and explain the @dir array differently to
> prevent kernel-doc warnings:
>
> gpio-en7523.c:22: warning: cannot understand function prototype: 'struct =
airoha_gpio_ctrl '
> gpio-en7523.c:27: warning: Function parameter or struct member 'dir' not =
described in 'airoha_gpio_ctrl'
> gpio-en7523.c:27: warning: Excess struct member 'dir0' description in 'ai=
roha_gpio_ctrl'
> gpio-en7523.c:27: warning: Excess struct member 'dir1' description in 'ai=
roha_gpio_ctrl'
>
> Fixes: 0868ad385aff ("gpio: Add support for Airoha EN7523 GPIO controller=
")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: John Crispin <john@phrozen.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Felix Fietkau <nbd@nbd.name>
> Cc: linux-gpio@vger.kernel.org
> ---

Applied, thanks!

Bart


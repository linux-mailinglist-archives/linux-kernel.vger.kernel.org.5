Return-Path: <linux-kernel+bounces-15290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3FE8229C5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9ADE2851A9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1F6182A9;
	Wed,  3 Jan 2024 08:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="RmOlLDEO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427F718623
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7cd42bc0f1dso972606241.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 00:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1704271888; x=1704876688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vgekKZ/OlG7JICiZDEFn9JZQAvlVZRayuPQgdK4A3Y=;
        b=RmOlLDEOGcUN6ItkidKPz5rcHWhOwPSxPO6J2UcmKGHkGY9eVksKFn4NldD8O4opW7
         OTDNm8A56G43f3E3RDa1H+CEuXOFgqE+RGQbyBezBnxAXO1NuvlbxmiOcwp8JWgs1aOc
         LEqjlQvz+Uqwg9dDbHsa8OTRYI7GAr7f1kVEmKi+cApYX6Mf72qtVtGa2bCzLwpAowBs
         QqU8b9rIQlnZyzw5AY+VowElwQUGPVTxyCurCoLXN5PMpFCTZhlqkMlnMkHAOPbSvQFr
         WihHlP5js52lGyd69ky07xo9DqnmSH7ALAaQ9YhBA57U0v2UUCKFzhSQVF6l4Gk7Yacx
         mp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704271888; x=1704876688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vgekKZ/OlG7JICiZDEFn9JZQAvlVZRayuPQgdK4A3Y=;
        b=hMmtSQNpywruB2B0khYpCuTxnDXsMfDe4vpOBy0P+klk9724hTyzbB2USKhVilLifY
         nsvOeM//xStvLV6xWxQcBrfcGznXj8eQQDyOgbhDGjZXgl+7uMx/n+qZiGlLfy8WcfZa
         umhNzioDYRkPaVUUDuKfDNbtNrWd++p11ylyVHIwfKMCxjVhXeLyQ5Yy8Hgse1ACfEiO
         d84Wx5qpAAtT3r9oohjGQWXHd2f8KbwZqQpm7BXSGw6ehwMWE/VBWpq2ZDVegZeZSb9T
         4qgbFULZqLZtaHqbQBZX6ItCv6yUItjEyPct1MmE7KPbA4yheNpEG+K+/QEqwfnFWyvV
         BfcA==
X-Gm-Message-State: AOJu0Yw93LfN9GkDtPLKvpB8s6RFko+SQBIccBsNUs7LrK2mM9LEVO0D
	oqPTmjnPzI3FIocQ7VvgbdV2fHCDrEpEhwy0bcvqfTz43pSHtg==
X-Google-Smtp-Source: AGHT+IGlCDun+5AZYjonVjIbZIWyoWJfpOTl00hEI6erZzD7dQFVLcGlY2MgsTLACmwfHfuGizoarZKojMhAgXVHtjI=
X-Received: by 2002:a05:6102:4b15:b0:466:ecfa:88de with SMTP id
 ia21-20020a0561024b1500b00466ecfa88demr9565508vsb.14.1704271888154; Wed, 03
 Jan 2024 00:51:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102082829.30874-1-Wenhua.Lin@unisoc.com>
In-Reply-To: <20240102082829.30874-1-Wenhua.Lin@unisoc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 3 Jan 2024 09:51:17 +0100
Message-ID: <CAMRc=Md-9vh7-r+SWm-TFPhonntindgj4cjeATUr2uZxEUxLxw@mail.gmail.com>
Subject: Re: [PATCH V3] gpio: pmic-eic-sprd: Configure the bit corresponding
 to the EIC through offset
To: Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andy@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, wenhua lin <wenhua.lin1994@gmail.com>, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 9:28=E2=80=AFAM Wenhua Lin <Wenhua.Lin@unisoc.com> w=
rote:
>
> A bank PMIC EIC contains 16 EICs, and the operating registers
> are BIT0-BIT15, such as BIT0 of the register operated by EIC0.
> Using the one-dimensional array reg[CACHE_NR_REGS] for maintenance
> will cause the configuration of other EICs to be affected when
> operating a certain EIC. In order to solve this problem, configure
> the bit corresponding to the EIC through offset.
>
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> ---
> Change in V3:
> -Change title.
> -Change commit message.
> -Delete the modification of the two-dimensional array maintenance pmic ei=
c,
>  and add the corresponding bits to configure the eic according to the off=
set.
> ---

Applied, thanks!

Bart


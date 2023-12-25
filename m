Return-Path: <linux-kernel+bounces-11153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6252481E228
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 20:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168A01F21D4F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 19:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C5F53801;
	Mon, 25 Dec 2023 19:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0Kkn1LH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DC0537F8;
	Mon, 25 Dec 2023 19:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-67f9f24e7b1so24790746d6.0;
        Mon, 25 Dec 2023 11:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703533983; x=1704138783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zo5pv5tv9aZL0UVfqEU5d7Hi5VVdArR6BFQqDa0XDPw=;
        b=R0Kkn1LHpEyW+8pgJFpfbORew0R6iFEA2/l8qWfPRsQueS52AOX4oAgNju7vKoYm5C
         mpHnr0hM3bLGigg5bgwQZLprHcWqjuBj6wGCUiVVejU+QfgUros50QUDQHHan5CMxo53
         MafVWy5krysEkv448+vnEORqYcKOY4O+thRrAEeb6orAC+KvLFmOT6fD63CkwsQWSpTw
         pIFAKgsHuU2PIhsyhTH3sIAM1uPAlUsynz5g4t3YMXr/xhZqgqEGi9TkEQYnbShF5k3X
         2b1qWEYjVQa+NpLU8auQg/f9dJ5q8sZvzfqDAFY/neuMGgK8GWaPsUPD27LCZk51a4wE
         5n6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703533983; x=1704138783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zo5pv5tv9aZL0UVfqEU5d7Hi5VVdArR6BFQqDa0XDPw=;
        b=hLDj7wSP+2c+jP6aLngvRUYZXygutM9NkvV0GqDZ3ovKrsWKXLYHqrtZVMOFq3LB8v
         hReOKeWefTXTdvgN22OoD8uRkJybWVgi6U6d9I9FoZ5XL5cCXuqjHAfog3JS2kslPOEU
         oygKDaqA0OhcjV3ZDRV/o4gEsEfQhTLDCltFsZmft2HWxpRRx0TPMhK0zdUz1HyodlsE
         +lpMo2jRBeEj5VjAWBOLgnB12yA4VEsv6E+vBtjIwvmavrD35vI85Ulx252+v/8HpxAq
         7LdHhmNqICt9Uzyotd9oi1CmCSpJLIGSr9nfVprvw9rEie1ShsErYcL2S8pkRwx12elU
         X35Q==
X-Gm-Message-State: AOJu0YwrfTpHHYIEa/AfMB0ScvDWvkTEuInufdcRQaHOfQe779hTAh76
	+X+Kip2d9XJrEPdg/hUfemCnfe8EDuKMzIf/Og0=
X-Google-Smtp-Source: AGHT+IGEg7lbigXCkW2p3/PPQeO356jCdB+c0EfL6mZZQpUEIAn5DMmuwDVeIk0EczQgFSuGyoiKXJhOZpxVuLNTxIs=
X-Received: by 2002:a05:6214:2b05:b0:67f:3d0e:7844 with SMTP id
 jx5-20020a0562142b0500b0067f3d0e7844mr10371952qvb.5.1703533983145; Mon, 25
 Dec 2023 11:53:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222075812.6540-1-tychang@realtek.com> <20231222075812.6540-3-tychang@realtek.com>
 <2a44fe91-b4a5-4842-8abc-f30c532f14e0@linaro.org>
In-Reply-To: <2a44fe91-b4a5-4842-8abc-f30c532f14e0@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 25 Dec 2023 21:52:26 +0200
Message-ID: <CAHp75VehqcXLhSc64msaq1Z5JYTWNtGFEqjO6rRTam4ypgZLCw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] Add GPIO support for Realtek DHC(Digital Home
 Center) RTD SoCs.
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Tzuyi Chang <tychang@realtek.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 4:19=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 22/12/2023 08:58, Tzuyi Chang wrote:

...

> > +     raw_spin_lock_irqsave(&data->lock, flags);
>
> Why are you using raw spinlock? This question applies to entire driver.

If you want to have your IRQ chip to work in the RT kernel, you need a
real spinlock.

> > +     raw_spin_unlock_irqrestore(&data->lock, flags);


--=20
With Best Regards,
Andy Shevchenko


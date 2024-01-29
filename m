Return-Path: <linux-kernel+bounces-43063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CFC840B09
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70A5028D7D2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4CC155A5C;
	Mon, 29 Jan 2024 16:13:25 +0000 (UTC)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B50155A44;
	Mon, 29 Jan 2024 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706544805; cv=none; b=ZZtjXtRZL+u3eEfnOYpNxPs2M03CdocG6yuwNwl3h8qGfzXVMSTP8KJ3EMWA7ozD12ldvj3PkKw2B/1LDx/f/g9seeL4SXnpBExZFcYyIeZoy4kY3Janh6EUXo6O1DDXDlnpL78EH1QynQe5/0YvuuSSUXhRt+LKrxL6ZiKWivU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706544805; c=relaxed/simple;
	bh=iBuWSo0zZ0zhs3nszLVS5iO2TT7tnyzjI6i6+b4CDGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qbgl5BxzuCAfmoMUVCmmQsecE3akCw0CXF6sC2xWltj2WQJPwHjH5DFZ2MKHxJ7nOAY7iJkpTLGzVTR7dON0QYf/doXsWzN3VzFNOpD+XtFGJN6ldUBCi4kEIKMAbuUyclNx1w24yI2Pk1qkZ+KVBzsWVbg6nkezS2nrSNLZf5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc6933a46efso506968276.0;
        Mon, 29 Jan 2024 08:13:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706544801; x=1707149601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M34SovAVKIxJ85Xs2siD2UjRmVaUICuFPeB7G+JCjO0=;
        b=U5FlurnfJr/7jEx+GmeSxjMpOuAGJpCMxBYvD+9KQDoKYVrXYQ5gHiaHpq32hOAr5O
         RCAv9fdiiMuiPB6GU/mICSNkzKYT8Nl9orNs4z+7guao8s613r76LYYyt9ieEETBnFYf
         5tAV9qfKDPrs18zORD2HjBaJyViBwhDXI47bWz/jnchxMmPz7ua3N9ploWKUhLTVW/4w
         89VG6HH/Sc3qduN4qBvdCxQF4ZtmTmcnZv3GGlwi7TFy9juJuHn3WUFh0g860HwEicNR
         DCps1WS3gvNnvTzrpOsV+ckOJ3WJqbWiFolq6ZxplZ5+iGMKFxjqIqU11q9GxLYpgGEl
         AlSw==
X-Gm-Message-State: AOJu0YzgPQRnyCxoiLKfFZEqkTPG12yVyGznBcdwQAMgfiaJw4eEZta+
	5xUYhWlfvsR8d2Z8SmYpaXYLVuZwQO81+vgdA1bbGxNkDYdzPrnS8z7huXj1hO0=
X-Google-Smtp-Source: AGHT+IHqA6CC3cQ+KmLzxCROgIdBf2cOfh+NJFawnRG0HhfD8zqHmnkna+802LAlVf+2t12PiG97GA==
X-Received: by 2002:a25:8c8c:0:b0:dc2:1743:be55 with SMTP id m12-20020a258c8c000000b00dc21743be55mr2587882ybl.112.1706544801520;
        Mon, 29 Jan 2024 08:13:21 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id p65-20020a252944000000b00dbed7110107sm2341708ybp.12.2024.01.29.08.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 08:13:21 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6001449a2beso19300957b3.3;
        Mon, 29 Jan 2024 08:13:21 -0800 (PST)
X-Received: by 2002:a05:690c:3603:b0:5ff:83f7:57e7 with SMTP id
 ft3-20020a05690c360300b005ff83f757e7mr4614143ywb.31.1706544801029; Mon, 29
 Jan 2024 08:13:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115153453.99226-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240115153453.99226-1-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Jan 2024 17:13:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXrLmBOFg-9soCYD+hAcW9hXCbtM5NkLb1Pa2SJ6bxSyg@mail.gmail.com>
Message-ID: <CAMuHMdXrLmBOFg-9soCYD+hAcW9hXCbtM5NkLb1Pa2SJ6bxSyg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: renesas: rzg2l: Fix locking in rzg2l_dt_subnode_to_map()
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: linus.walleij@linaro.org, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dan.carpenter@linaro.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 4:35=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Commit d3aaa7203a17 ("pinctrl: renesas: rzg2l: Add pin configuration
> support for pinmux groups") introduced the possibility to parse pin
> configuration for pinmux groups. It did that by calling
> rzg2l_map_add_config() at the end of rzg2l_dt_subnode_to_map() and
> jumping to the remove_group label in case rzg2l_map_add_config() failed.
> But if that happens, the mutex will already be unlocked, thus this it wil=
l
> lead to double mutex unlock operation. To fix this move the
> rzg2l_map_add_config() call just after all the name argument is ready and
> before the mutex is locked. There is no harm in doing this, as this only
> parses the data from device tree that will be further processed by
> pinctrl core code.
>
> Fixes: d3aaa7203a17 ("pinctrl: renesas: rzg2l: Add pin configuration supp=
ort for pinmux groups")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>

Closes: https://lore.kernel.org/all/f8c3a3a0-7c48-4e40-8af0-ed4e9d9b049f@mo=
roto.mountain

> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl for v6.9.

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


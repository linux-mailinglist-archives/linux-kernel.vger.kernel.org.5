Return-Path: <linux-kernel+bounces-22894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B98C82A50F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 00:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06FAF28717B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B3A4F8AA;
	Wed, 10 Jan 2024 23:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B0AtZgAQ"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AFC4F89F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 23:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5e734251f48so37500277b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 15:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704930390; x=1705535190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmFQQJ+8nG8wUPicnQ4h9Swe0ak+9PDkXgvvWyQBNFE=;
        b=B0AtZgAQNZKVEijcVK72/619gA4iwtHBLY7v+tc9glWzHxGn1RlH9tzotMs9MxKuUV
         vTULUDsty4NXEGRRRGed1ARXLpNpkWvuWlafeO35jNXIa9rcj08LfNbgCJ77M1y6LzAC
         EHMaWNtQO/s710tZpNwOpJ80P8c6LD2OGy7mhQFrV+sqkmvck+LnuA0sl291x83awxu/
         hxLzJVsN/2rtUFzfttwg7IEoUDt8/tdiU7KlOP+45WUhuGbj5URIDRLnS5G33cp6f1kN
         ciC1obTjfoUUIy+6EDLhlTySOpuNpl63OxAhyiMB42jRX40Du4BxO7G1mqCKILnzwpTT
         ZMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704930390; x=1705535190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmFQQJ+8nG8wUPicnQ4h9Swe0ak+9PDkXgvvWyQBNFE=;
        b=YIdBXoAkarSgTLKabjpvjlcwJHd5f2ANxUkqCwZJYXw1ahTKQXlQv23a340NMH58/P
         cbNScyajJpmOPVyWtXF2jY/LF/Su1gIR5x3b7J0st8dBvSOaNzTYVO9AcyL+IdnIMTen
         Ezr9298Utpf7f6mVYlHyMO83IOeRtpEtd4I1L03TNo8VsvGFWvVk3sSLfSspI4qgzrne
         B/OHlOzxtq+byJlTFWK4yM2jKSG0LVM6+zMmtjcBJ6VP3NrtB8y5hB70OXO1OF9ERuCR
         72TrxB7EAWA0SXtx4sVchPG8xdaXAC1S85wRK4eLVOSR/IaP+8V52E4qG1hPw0Yha/IZ
         jORw==
X-Gm-Message-State: AOJu0YyBsT5HEW51u2YNxd2HkXXpiZp3o7Tt9CNfh1/jkCHcWDr4DiMB
	It0bCyRTWtCBrtNYQRKHX+c4ObVjo9sGdyUlasFrdcaZMND9EA==
X-Google-Smtp-Source: AGHT+IGuQg0IwSl+XFTQhWt7adXMLbJQdEzuvpam0kpoBkXiCz2Ra8XvGX0poJ1j/FHmkzNMnVnXABz6nLNFKAH0CN0=
X-Received: by 2002:a81:b613:0:b0:5fa:ae33:463d with SMTP id
 u19-20020a81b613000000b005faae33463dmr190769ywh.41.1704930390607; Wed, 10 Jan
 2024 15:46:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110215554.work.460-kees@kernel.org>
In-Reply-To: <20240110215554.work.460-kees@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 11 Jan 2024 00:46:19 +0100
Message-ID: <CACRpkdZCtDvrWW6AL-sX71fY1_qa858+tCR9ke6pT5HPnA7mKg@mail.gmail.com>
Subject: Re: [PATCH] ARM: unwind: Add missing "Call trace:" line
To: Kees Cook <keescook@chromium.org>
Cc: Russell King <linux@armlinux.org.uk>, Mark Brown <broonie@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Vladimir Murzin <vladimir.murzin@arm.com>, Zhen Lei <thunder.leizhen@huawei.com>, 
	Keith Packard <keithpac@amazon.com>, Haibo Li <haibo.li@mediatek.com>, 
	linux-arm-kernel@lists.infradead.org, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alexandre Mergnat <amergnat@baylibre.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 10:56=E2=80=AFPM Kees Cook <keescook@chromium.org> =
wrote:

> Every other architecture in Linux includes the line "Call trace:" before
> backtraces. In some cases ARM would print "Backtrace:", but this was
> only via 1 specific call path, and wasn't included in CPU Oops nor things
> like KASAN, UBSAN, etc that called dump_stack(). Regularize this line
> so CI systems and other things (like LKDTM) that depend on parsing
> "Call trace:" out of dmesg will see it for ARM.
>
> Before this patch:
>
>         UBSAN: array-index-out-of-bounds in ../drivers/misc/lkdtm/bugs.c:=
376:16
>         index 8 is out of range for type 'char [8]'
>         CPU: 0 PID: 1402 Comm: cat Not tainted 6.7.0-rc2 #1
>         Hardware name: Generic DT based system
>          dump_backtrace from show_stack+0x20/0x24
>          r7:00000042 r6:00000000 r5:60070013 r4:80cf5d7c
>          show_stack from dump_stack_lvl+0x88/0x98
>          dump_stack_lvl from dump_stack+0x18/0x1c
>          r7:00000042 r6:00000008 r5:00000008 r4:80fab118
>          dump_stack from ubsan_epilogue+0x10/0x3c
>          ubsan_epilogue from __ubsan_handle_out_of_bounds+0x80/0x84
>         ...
>
> After this patch:
>
>         UBSAN: array-index-out-of-bounds in ../drivers/misc/lkdtm/bugs.c:=
376:16
>         index 8 is out of range for type 'char [8]'
>         CPU: 0 PID: 1402 Comm: cat Not tainted 6.7.0-rc2 #1
>         Hardware name: Generic DT based system
>         Call trace:
>          dump_backtrace from show_stack+0x20/0x24
>          r7:00000042 r6:00000000 r5:60070013 r4:80cf5d7c
>          show_stack from dump_stack_lvl+0x88/0x98
>          dump_stack_lvl from dump_stack+0x18/0x1c
>          r7:00000042 r6:00000008 r5:00000008 r4:80fab118
>          dump_stack from ubsan_epilogue+0x10/0x3c
>          ubsan_epilogue from __ubsan_handle_out_of_bounds+0x80/0x84
>         ...
>
> Reported-by: Mark Brown <broonie@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Vladimir Murzin <vladimir.murzin@arm.com>
> Cc: Zhen Lei <thunder.leizhen@huawei.com>
> Cc: Keith Packard <keithpac@amazon.com>
> Cc: Haibo Li <haibo.li@mediatek.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Makes sense.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


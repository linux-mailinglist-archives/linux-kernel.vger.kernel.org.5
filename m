Return-Path: <linux-kernel+bounces-73597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DF385C4DB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 246C4B22ECB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1386314A0A6;
	Tue, 20 Feb 2024 19:32:21 +0000 (UTC)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3970076C89;
	Tue, 20 Feb 2024 19:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708457540; cv=none; b=kj48IhTlWYgSa7Npbf8P0O0E/SW/UqEUa4pHEOwv0Swf0kI9i4EMVdxIgrR2yOqGUVti9hLCjm3RtSeg18xz4F1pllP8yLp4N07Z4csULToNGMIzEfvPLzxhJnQiUY965WhfFfqckpG+VyIM86qBiNu+irrUkPTyLkWoKR0hs74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708457540; c=relaxed/simple;
	bh=SszpkFbrTiSepHEcHv73HAL06XFg+t2SIWPqKACl370=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUnBD9mHIqEebK09DL7igig7i/8DcI4vS8VHIvUTCfgz69QhP0yUSbtLD/HFdUXhFGlSJpb5+CJceZyM+RWd5/E5R7ySxQpuYLEebEQfdjfS4mq7ies9Jci9n6Y2gZK/vhT2qLAm9o4UqX/dzYIBamx6G+PVABCttLRLipLGN2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so5163126276.3;
        Tue, 20 Feb 2024 11:32:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708457536; x=1709062336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8GTO+lAF2fk+HfBG0cHdMNOcQxsEjyIPCBMHPyZPUI=;
        b=NGRAX49KSziWe7IwSTyfSzSriq+I9fgFwCTTx7iTsNEYMwXnNjE688X/j4sFNFX9NU
         Y4pgLVFjuUF4AvZM2fBbduFvccMlqYDbUl8jPkSTJMT9gGMj8MdClKB7hq7xXkzCopyt
         sCJoSGSr2vZ5UvVd+3gTJEOO1WoZ9y3T7r82imAsCMwC95717guwRXVkapEbCIhBnlUD
         so8KfQRDPuumN+oJTXPyPgC2CVWHB+umuCuuwlvhcQDG20kc0kFaqB2i0Ny3dFCe24DJ
         9S7QdlA1AcJf0V3kmbK+oavIwPeCCEKfm/Vg1rZOAsotRBepyTt67IZJqw2ZSEZ1wBbg
         QAYA==
X-Forwarded-Encrypted: i=1; AJvYcCXckgdN7x8onE6LXo372cwzG9Cz6HSFEZBr4aDnv78WhUe8oN39T/MeJkvzRS9hvJDXZQFqe1R33lRRfBGwMQGpGR2TU9hYBj0i+92XNKehn38AUA7a4K4PG2Uvczz1uaoPrE6N6rNTpHHadlyuqr+31QNacYorT9zI7fcZyQ6fHz0GDn48/YVnxcr7lT3Une4bCTDOekmYSrJRE0UliRgElp+Uq/zo
X-Gm-Message-State: AOJu0Ywh4Ab5jlf4LLfy/KM5S72gCvq/ISrXqWPWNBSsh4uKWB4dylzD
	CakQ+1y5SzDMEv4CwejD0Exv4F4WzyD/bKfllUXoo4VOYYgIYD4HiYCiv44rUz8=
X-Google-Smtp-Source: AGHT+IH35SgJjhhvE6ygmBqJXW9fKhgfVPETCcK8MhgFj+AM2c/QiztJnHB22XJUV+dlK/YdSoqodA==
X-Received: by 2002:a05:6902:118c:b0:dc6:ff12:13d7 with SMTP id m12-20020a056902118c00b00dc6ff1213d7mr12988060ybu.60.1708457535550;
        Tue, 20 Feb 2024 11:32:15 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id p9-20020a257409000000b00dcdb990f93bsm2026571ybc.64.2024.02.20.11.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 11:32:14 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6079d44b02bso36943237b3.3;
        Tue, 20 Feb 2024 11:32:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX3DAu4yMSYYqJ0SLTJPVKCBMuasBY1H8KxvqMnUJDBLTAdHAC7ikiusU+6p2WOfjHqKOj4HHwyyEIe8N5qECWQm/fjKFg42kcpLwed0AWViw3SDifqI0kcFTPz6i939EUGeiujVEsiaw4WN6MFDa4kTxCgqziLuQwrdw7BWaGGOyfx7GkG4pjhpiFnzCcHuJW8ZdcnZeTGuCp8Q63LNFdutVmiaeTt
X-Received: by 2002:a81:9817:0:b0:607:87cd:9394 with SMTP id
 p23-20020a819817000000b0060787cd9394mr12513129ywg.11.1708457534400; Tue, 20
 Feb 2024 11:32:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com> <20240208124300.2740313-8-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240208124300.2740313-8-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Feb 2024 20:32:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU+WRJLLH4zUvAnsfNtgUxsNGe1bCKLu+98BC6K0d6Rgg@mail.gmail.com>
Message-ID: <CAMuHMdU+WRJLLH4zUvAnsfNtgUxsNGe1bCKLu+98BC6K0d6Rgg@mail.gmail.com>
Subject: Re: [PATCH 07/17] clk: renesas: rzg2l: Extend power domain support
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Thu, Feb 8, 2024 at 1:44=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> --- a/drivers/clk/renesas/rzg2l-cpg.c
> +++ b/drivers/clk/renesas/rzg2l-cpg.c

> +static struct generic_pm_domain *
> +rzg2l_cpg_pm_domain_xlate(struct of_phandle_args *spec, void *data)

As of commit 4d0824608a636b64 ("pmdomain: core: constify of_phandle_args
in xlate") in next-20240215 and later the first parameter needs to
be const.

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


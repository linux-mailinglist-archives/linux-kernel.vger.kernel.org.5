Return-Path: <linux-kernel+bounces-140698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 135A48A17DA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 447D41C21D60
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C05DF5C;
	Thu, 11 Apr 2024 14:53:05 +0000 (UTC)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676B7DDCB;
	Thu, 11 Apr 2024 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712847184; cv=none; b=ceJHmDLzfQzvW0T7izkXf2knoGmQX/OccG7pSvZGwgU49lYww1ZuR/BIVMtpXZKSD2UBmBv/t+Wqet4zAt2BcHLfTvzc+Ia6BBktM1AR06H/a0Jbevrx+yAf++ATisxPqESG0ejsJdOexxIkZaG/vp53b6Wy3vAeQUJfKMTs3oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712847184; c=relaxed/simple;
	bh=EyhnWJiAS0nR8fJyhRZTkbp1BLMobMq6UhnnwGa9dmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rvBneR4zl7ICKTbOrSRI7AH142uYNlBx6Dr/RkY6gK7wY42ouC00jwPvMhMvMrMkBeABbe6WJmzrO6u697sYva5CWn8pAwTIR9zbA/lvD7nuzfFNTfm+lFQR5ivJtsHjUc0OKQaraBktEywfaHSBLwp1M157lxuRNpNeeDefbUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d886f17740so10359581fa.1;
        Thu, 11 Apr 2024 07:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712847180; x=1713451980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVjsRotGn7u6Rn7aIZqkg7iAwWDdxhRzncPX3YRKcQk=;
        b=OCmYHKHaFAhcNayLW8UM7bjr3GNq4pqLtgwMC0OMuLQB3sHvZDLwXNGNKhcyLO1JvC
         EOv7sbkJf3eT9sSDuRmpc7d0UoQpoLkbw6Yl11+9aeLxvMEVxYo0ofr33aCT7DlbnrjA
         vOzm8L9ssBi6SEqZFpIA43KjwTdC2L/zll5kImoXjQmReDxrW15uKvKgLAzOWLWgyKRH
         s228Y7HrIyew3CqtGwViHgrTSIq9Q19zQq5ZXWXALH11IP0d9f2zG/nel8PNvLRVJI8f
         IO2816L984qSbzvfRokRN4fOa33ZgqPTEYp9NsQVu40LOi0DfcGUXBZeTU/PcCvmKurB
         1Ouw==
X-Forwarded-Encrypted: i=1; AJvYcCWBJhIZvsEAGMcxzUtDDyGv70orFvfIApxuDNpXdPcDABJ0dqdb4ewPHLf2RniFlMek7WKG9ugZawb5Lu6C/Un/K6hOxYMZ6wajEUXMCXeGngH/t6a2F+0IoMYhoau+skXxvYAXF8pHKAXChYoQkAAD8hd/91E5YYncX7SVQfZFkaCQWKORjnG820k0
X-Gm-Message-State: AOJu0YzfG+YbP9ms85tvacLHFq5QGEfR4glnsJ/w5gsozdZI3RKMHtRc
	hrh4i4t8yzYp9U7QDGBbpEHYDpkKxC2b0r6d+cedphC19dfX87z8/ez9jaVD1ck=
X-Google-Smtp-Source: AGHT+IHtmYPwBRwzhlRVjfyHCc9sHZCUVQpmG1us9sILUW81OOhjlK0NGYvuhXXXnTKxFPVadxX9Hg==
X-Received: by 2002:a05:651c:1416:b0:2d8:cea3:85e7 with SMTP id u22-20020a05651c141600b002d8cea385e7mr826281lje.12.1712847179572;
        Thu, 11 Apr 2024 07:52:59 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id t5-20020a2e9545000000b002d865254e49sm233406ljh.16.2024.04.11.07.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 07:52:59 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-516d264d0e4so997522e87.0;
        Thu, 11 Apr 2024 07:52:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVmJDqE8L/XUA8FP6Ny0/bic1vVecCTT8ffmr3LDR4EeeIAUfe+zFp7FoiACSXF63aZDDh95DiKb7FyvI2QwZTQ2jYeoorJ/SxtWSsWiFMhEKloglGTFaTfQBVYx5k5Cpdw43eIcIcQXlkV6zoFyS1RakSmw/OuclwLQdSKiEg98WPQ4K7Yc6rTAvFa
X-Received: by 2002:a05:6512:33d2:b0:516:ac69:3bf5 with SMTP id
 d18-20020a05651233d200b00516ac693bf5mr1161921lfg.0.1712847179026; Thu, 11 Apr
 2024 07:52:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226192530.141945-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240226192530.141945-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Apr 2024 16:52:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUwwV85e02q+WqMSQ28zeVjLAjqNOHqjiDpX1swTg2c9Q@mail.gmail.com>
Message-ID: <CAMuHMdUwwV85e02q+WqMSQ28zeVjLAjqNOHqjiDpX1swTg2c9Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: renesas: pinctrl-rzg2l: Remove extra space in
 function parameter
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 8:25=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Remove unnecessary space in rzg2l_pinctrl_pm_setup_pfc() function
> parameter.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl for v6.10.

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


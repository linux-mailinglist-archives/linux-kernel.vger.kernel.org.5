Return-Path: <linux-kernel+bounces-19675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEC48270B9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90ED31F2241D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA624655B;
	Mon,  8 Jan 2024 14:08:36 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9C146B88;
	Mon,  8 Jan 2024 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dbdd61d80a3so1332672276.0;
        Mon, 08 Jan 2024 06:08:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704722912; x=1705327712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdHl7md1Zkmv60g30fUAOV7PYkRMYcjuuSdDFpSytAY=;
        b=OGUKsnvckriOw3+AXBaO9KzCSJ0M5Zdpb6wBPtCZ0ESGzFGCwdAqeYnoU9+23ZbLOc
         GTMQBAzAkzdI6DyHPU1SYFyPc4hXBcmdx7PCtgPSIfGl3e5YfMAtLZXKkthEwR3wrYcp
         5mSmr9mEfrV+Ztgi/BeudQsWnNutKwkQH5cj6hUuAPGeHudZJFCKvDeXQpInEfF9BY1b
         47kQiqMhHXU/SyGYdVNXmzakgwo7NClugkWrJ2DRfmY1oRQnOCpRWoQZAaYBYieB3lQq
         EODigL+FTM69raGdrz6QJ+y9MDg7M8HjOVUVoqjYlnoTQwjmcHDgTdyTezXlmqMHMWzn
         AmZg==
X-Gm-Message-State: AOJu0YwYYNSIKIBzDmdtvOFd4IftAftC7BYblE0jsYABjVC71kf6xjkk
	m22rYG0AKG3MEpi5VYykvx0EbAVS9DnOOg==
X-Google-Smtp-Source: AGHT+IFaj1QXA6VxzzfaNdDvMYIOmWFtc5jFxlsdeCbGpNuOYIh1XDr7y3IsYUu0Ky1GCJ1GgVOR5A==
X-Received: by 2002:a5b:11:0:b0:dbe:341b:d38 with SMTP id a17-20020a5b0011000000b00dbe341b0d38mr2309447ybp.49.1704722912648;
        Mon, 08 Jan 2024 06:08:32 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id n185-20020a25d6c2000000b00db54cf1383esm2211679ybg.10.2024.01.08.06.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 06:08:32 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5e784ce9bb8so13430497b3.0;
        Mon, 08 Jan 2024 06:08:32 -0800 (PST)
X-Received: by 2002:a81:570b:0:b0:5f8:fc22:93f5 with SMTP id
 l11-20020a81570b000000b005f8fc2293f5mr128986ywb.26.1704722911972; Mon, 08 Jan
 2024 06:08:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108134102.601-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20240108134102.601-1-lukas.bulwahn@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 8 Jan 2024 15:08:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXW0bU3KO+-S+jZDGUDkb0Nxg6EQUdc_uKTCs8jj6VOLg@mail.gmail.com>
Message-ID: <CAMuHMdXW0bU3KO+-S+jZDGUDkb0Nxg6EQUdc_uKTCs8jj6VOLg@mail.gmail.com>
Subject: Re: [PATCH] vt: remove superfluous CONFIG_HW_CONSOLE
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-serial@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Helge Deller <deller@gmx.de>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 2:41=E2=80=AFPM Lukas Bulwahn <lukas.bulwahn@gmail.c=
om> wrote:
> The config HW_CONSOLE is always identical to the config VT and is not
> visible in the kernel's build menuconfig. So, CONFIG_HW_CONSOLE is
> redundant.
>
> Replace all references to CONFIG_HW_CONSOLE with CONFIG_VT and remove
> CONFIG_HW_CONSOLE.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

>  arch/m68k/amiga/config.c        | 2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


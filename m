Return-Path: <linux-kernel+bounces-20771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FCC8284FF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18FF283467
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA21381CF;
	Tue,  9 Jan 2024 11:25:30 +0000 (UTC)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0451729CE3;
	Tue,  9 Jan 2024 11:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dbdc7ff087fso2017295276.2;
        Tue, 09 Jan 2024 03:25:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704799527; x=1705404327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9M4e0KgRG4duwu/WfThya1uTfD/WswypLpOJmDTcgE=;
        b=BzQmbCP6CGZJ+h0o69z/P+mkozJU1jBrDdoFyX2Rbx0TGpn7hCe84E7LAUSQWXF6Nu
         uwOdUKuyEv3CYE0Cl9OR8T82tnHx6/5OYROxoXqAn9pK6mGtD5eyxMxU2r1UDymNTP9r
         db7hhpHhMXgM1y/7KKKa9oOXwR/48FhTQZMTFQFVsBgsazF8CekV5EoyNbxOsz3hi7Rv
         hJWMsdbminejfpOO6kA6/dlsw05kc4bfyJKAoFqfRB4mV5XPFSazrVXbXufbFFsVtu27
         tkgFGTwWJlinzF16nn4A//ZabomPV3F2vrbT4zv+fGun8pAVNiLw9nVNT6oEryMIa7pZ
         Ktog==
X-Gm-Message-State: AOJu0Ywf9YcUF6XEgwvPxZdXfX2HBnvJPhKq98sFjifSEJS0ZHb50fh2
	rRwmH9DRBWh/BpeR082m9LfkaWkQfAcxabSP
X-Google-Smtp-Source: AGHT+IEbvbI7fi9u8m3yA72JueQB1w5sZR0Cs+kHQqdZnSmM7Zm9rC8C3Qi5Bt6KOjQwzF9LLl/I1g==
X-Received: by 2002:a25:fc1e:0:b0:dbe:aa9f:795b with SMTP id v30-20020a25fc1e000000b00dbeaa9f795bmr2820420ybd.16.1704799526755;
        Tue, 09 Jan 2024 03:25:26 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id a17-20020a25ae11000000b00d9c7bf8f32fsm613719ybj.42.2024.01.09.03.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 03:25:26 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5edfcba97e3so28882277b3.2;
        Tue, 09 Jan 2024 03:25:26 -0800 (PST)
X-Received: by 2002:a81:690a:0:b0:5ef:a183:a8a4 with SMTP id
 e10-20020a81690a000000b005efa183a8a4mr4155660ywc.90.1704799526385; Tue, 09
 Jan 2024 03:25:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108181610.2697017-1-leitao@debian.org> <20240108181610.2697017-2-leitao@debian.org>
In-Reply-To: <20240108181610.2697017-2-leitao@debian.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Jan 2024 12:25:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWqnTjHa6KW5g0F8xH50As4Ce+O3a2HaifJtnY1cGrFcQ@mail.gmail.com>
Message-ID: <CAMuHMdWqnTjHa6KW5g0F8xH50As4Ce+O3a2HaifJtnY1cGrFcQ@mail.gmail.com>
Subject: Re: [PATCH net-next 01/10] net: fill in MODULE_DESCRIPTION()s for 8390
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, Greg Ungerer <gerg@linux-m68k.org>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Breno,

On Mon, Jan 8, 2024 at 7:17=E2=80=AFPM Breno Leitao <leitao@debian.org> wro=
te:
> W=3D1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to all the good old 8390 modules and drivers.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Thanks for your patch!

> --- a/drivers/net/ethernet/8390/apne.c
> +++ b/drivers/net/ethernet/8390/apne.c
> @@ -610,4 +610,5 @@ static int init_pcmcia(void)
>         return 1;
>  }
>
> +MODULE_DESCRIPTION("National Semiconductor 8390 PCMCIA ethernet driver")=
;

I would write:

    National Semiconductor 8390 Amiga PCMCIA ethernet driver

as this driver does not work on generic platforms with a PCMCIA slot.

>  MODULE_LICENSE("GPL");

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


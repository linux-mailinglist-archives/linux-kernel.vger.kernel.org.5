Return-Path: <linux-kernel+bounces-156650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 882F38B0642
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B2A285B95
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304E2158DC9;
	Wed, 24 Apr 2024 09:41:19 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E94E158A29;
	Wed, 24 Apr 2024 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713951678; cv=none; b=TxvCKSTPG3qgeY2MsJc/SZ9YOTq5a3+ukoyR27CC5TQYNAQrHriBfcw/2Jwdcmo0fldaJouQWmtJkFQftZEz4EFHyxRfSYCgSyKEL3pK1oQitTVWe13/gIN1Ahdsg9VLo2DRHoKkWTUjxl2XSLrtxBIDtQhMH0hEnTHFNTkaIyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713951678; c=relaxed/simple;
	bh=d/jVMhV9WCi1ko1s1PDn/7LBlBHAFTr0EBZsAFsgIS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/ZJBRDdbLd/WQGWr+edBDtorVROcuxlV8ap+1qKMMFPvMpY4H/mbtxl8SSpaiIEWpWiWXjgCGbr28XV9V1pJXgNr4Q20sZJbCl+FpjzpDKlAFZvxZ1rosB1jeIulAb7KqHjGqmXAwgDTnr973m5U/zIh2dAMaVppDjykdRTDPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-61ab6faf179so68462137b3.1;
        Wed, 24 Apr 2024 02:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713951675; x=1714556475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6FxB/M70b/YNi3oH/B6VnLi+ZainAgAZAXesfKRQoI=;
        b=gdy7iz5MOkekK2OTYYyG4IQSan8dFA+5+umcEeyuZP1KVfN7mpuXAuNDfE8eYtz9Lw
         yGdoj7Ab/lZbwff68hjmwyYrph+AvjRcXHf506JPjy0qvEqrXHIYkz/Acqw4g5kMABIq
         l0tUekRub8M8WqXOJKZqj4mNfpj9pBCTt9PuJj5ugcwleSm2eLR+AwAzkMW8Xe6bp/BH
         6GfNjspqxe49ee2aXvjXx4jJoqJx/C+EAPOu496Hgm7cHT3gtOkR01Bd/ucSXKvc74ay
         SM/ksXOz+BHZElNyGjdZLnYsYVlMgnq6nG4ZMfrNb0GWnwzuvirn5c8p0Du0bPxKeVAa
         QzTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxqyC5UZoJJ1rvqLlCKVHRLurWktQbjfppsgB9cIXXYaH5cu0d6dkm++CbdkDagM0o5l++JZ+iE10/fP/siDIY5WH6Armkqf9hkuymnHaMFD+VwvSBA541yZq2Uxhho1pgehEdCssDBINa
X-Gm-Message-State: AOJu0Yx07HPtUZbg64yGstPKlQldeGEy9ZWmN7DvL6OPfTbNYusfYIMX
	VKAapEsLArHdp2xAx3sDSPBBwur+18uhfxvMi4//Oe1kcFb+ANrPtv+dXtZn
X-Google-Smtp-Source: AGHT+IFKzP2vwLoil6vSHWzEBCUE96cyP1eJj3Mbv/jYMoAwkdJ82ZoC9nl36o38LsHORjPzdDc31w==
X-Received: by 2002:a05:690c:6d02:b0:619:c995:143a with SMTP id iv2-20020a05690c6d0200b00619c995143amr2718002ywb.12.1713951675472;
        Wed, 24 Apr 2024 02:41:15 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id y67-20020a81a146000000b00615556f99dfsm2471739ywg.36.2024.04.24.02.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 02:41:15 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-de467733156so6561006276.0;
        Wed, 24 Apr 2024 02:41:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsW7GkaUCpzJXIkk6kRzhXaxdeEdhUm4FMzfxacc5bAmbid0lV/kCAKC0FNZCLHyOu0H8BN6G+Lk585LyWKd0SZIkPGQIvwa24UupWwM3zj9A9v0sniRTuUhW1+DQ45bKYtsBHR2Xw4IoU
X-Received: by 2002:a25:7406:0:b0:de5:705d:9387 with SMTP id
 p6-20020a257406000000b00de5705d9387mr1257061ybc.44.1713951674619; Wed, 24 Apr
 2024 02:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416123545.7098-4-wsa+renesas@sang-engineering.com> <20240416123545.7098-5-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240416123545.7098-5-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Apr 2024 11:41:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUiS57QZSEaFZjqFm1EV6Lhfq5XbOiuxxGwbi_VNupjQw@mail.gmail.com>
Message-ID: <CAMuHMdUiS57QZSEaFZjqFm1EV6Lhfq5XbOiuxxGwbi_VNupjQw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] serial: sh-sci: start hrtimer after setting up DMA
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Dirk Behme <dirk.behme@de.bosch.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

Thanks for your patch!

On Tue, Apr 16, 2024 at 2:35=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> In the RX DMA completion handler, the hrtimer was restarted before DMA
> was set up. If DMA failed, for some reason, it would clean up and the
> hrtimer would run into a NULL-pointer. Restart the timer after DMA was

.. into a NULL-pointer dereference of s->chan_rx.

> successfully set up.
>
> Reported-by: Dirk Behme <dirk.behme@de.bosch.com>
> Closes: https://lore.kernel.org/r/ee6c9e16-9f29-450e-81da-4a8dceaa8fc7@de=
bosch.com
> Fixes: 67f462b069e9 ("serial: sh-sci: Get rid of the workqueue to handle =
receive DMA requests")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

This is definitely a step in the right direction, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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


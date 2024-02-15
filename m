Return-Path: <linux-kernel+bounces-66712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 950958560D4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DDE4B2A77D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EC4133432;
	Thu, 15 Feb 2024 10:47:32 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C19C12EBD4;
	Thu, 15 Feb 2024 10:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994051; cv=none; b=GyJMNwWNeQMAylGjc7QF00DQo6QmtUAxH+nld9kBiMoMq+jvjZO28iqHv/2/lXvNplKf5l5HoKIzwWxUK91PPQsjx23oKrW0Q0q8iwN7qHeLLtXI0LHe2nLVztYhRBTnr40eed/KLnjhDkc936KjuWBRj/Bl3eXPCS5sYqrf3O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994051; c=relaxed/simple;
	bh=J1lf+RbzBwTUdgwEgk5Mt6fRHJgMnJQ02SQ/jvvXxO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGN90EDz2TE88x8BPIgrI8H8YMHyqPGcx/oX40K2/21C9bY7Shx3K7V+AE1cNVySVF/L3YhV24IaVzgwqtQoVYNHS54kpb2nqXOZE3I2bTzLn25U5ceoRo3MgFxk1EvVfsWnMvlkXfw7cZgWc4DFzAdeudnusdM8atTQwwkvULE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-604a1581cffso7017697b3.3;
        Thu, 15 Feb 2024 02:47:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707994048; x=1708598848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cngMjuMI3kUloDphCEqdAv46UiS6t4QhdjtrFhn8Hf4=;
        b=rjuNsd1M9XcEWl3TVu2Oa6CjvhhLyj+qdPbzSf3aJLF9vwsulnQ0Dui4LqShQL5GgU
         Ltd5eScCq+kKNfBP5Lzvz8fS0JDgmGlazzVU3OYd54kutf66n2PCIq2RagrvEJAMvzG2
         HsAZSPH+fQzI9MPs4H4zfKBE7pDtb3i/fXr1m0n9KmdiLrWeHV9bWxhIzfFe5nOzZrjh
         e9NtgX0AoUASaF7+Q6ELA2YofiHp5AL89j0usdUXjEl4JasG5XitKjmUb/m6+4KOPpqY
         uHw4KY0fI8vsDIggGi5ZyeudSguEmqmc05UqzAYQ0Qz1jEA5GFtOKvFl5hyD1UgsfuEP
         AHng==
X-Forwarded-Encrypted: i=1; AJvYcCUdOfmYhVnI6jEYf4/dNxhjn7Rhbofhik8hYCLch0yoV4x8fUt1aryl8PT0py1ENzsB30nKZhSUvCp/0O1t0/4Lhgw1NFC5GHs0tB/i
X-Gm-Message-State: AOJu0Yx2sfF6I5liDaIFlVPET4OCWJoWa1M9VMrScJx1/LjmToyzm2Am
	vrfsR1NmJrpiUb2tRQDGXLtgWO+ln2ALNVDyOrLDCV+mTYp/jptko2JeKfrYjqEUvQ==
X-Google-Smtp-Source: AGHT+IHOqRgKg85V89qJIZJsNTKTfY3fp02aVzakTIfez8ZotOJ/GbvMTlHdhfa3kUO3SVxKdajh1A==
X-Received: by 2002:a0d:e284:0:b0:607:8c4a:b4e5 with SMTP id l126-20020a0de284000000b006078c4ab4e5mr1389652ywe.22.1707994048284;
        Thu, 15 Feb 2024 02:47:28 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id i204-20020a816dd5000000b005ff9bb7fa40sm196400ywc.34.2024.02.15.02.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 02:47:27 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so641204276.0;
        Thu, 15 Feb 2024 02:47:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWlM9bMfsj/sIlh1TLirASmeyI3HKwHAZP7PoTkKJzrJHnkWD4KOEz0zEAJI5J+xO2mDorv/HVPen7ZofUr5mrmOXKxCDSRnwMQ+3MQ
X-Received: by 2002:a25:2bca:0:b0:dc2:6f92:2ec0 with SMTP id
 r193-20020a252bca000000b00dc26f922ec0mr1301977ybr.51.1707994047597; Thu, 15
 Feb 2024 02:47:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
 <20240212170423.2860895-13-andriy.shevchenko@linux.intel.com> <CAMuHMdUqvotuuj6p7SNVo3X+BRvc0MAeQ9krLnJVQywr6rzOKg@mail.gmail.com>
In-Reply-To: <CAMuHMdUqvotuuj6p7SNVo3X+BRvc0MAeQ9krLnJVQywr6rzOKg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Feb 2024 11:47:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWQ5D-H22+is4PO5MS7CHnb8xDwO-1FXDQtkZmyJ8Z4pw@mail.gmail.com>
Message-ID: <CAMuHMdWQ5D-H22+is4PO5MS7CHnb8xDwO-1FXDQtkZmyJ8Z4pw@mail.gmail.com>
Subject: Re: [PATCH v2 12/15] auxdisplay: ht16k33: Switch to use line display
 character mapping
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 11:44=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, Feb 12, 2024 at 6:04=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > Since line display library supports necessary bits to map the character=
s
> > (if required), switch this driver to use that.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Thanks for your patch!
>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

With the missing return-statement reported before added, of course ;-)

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


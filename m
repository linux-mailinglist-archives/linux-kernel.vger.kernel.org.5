Return-Path: <linux-kernel+bounces-123526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C17A890A5A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDA3DB212B0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998B613A3E8;
	Thu, 28 Mar 2024 19:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlE0bFjJ"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588F61327FC;
	Thu, 28 Mar 2024 19:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655698; cv=none; b=ThnLk807HwgS4aWDinULZ3PIEUGG8s1/M/S99bY0pHoGj7W5Mpa0S+haDTM3WJIWH2h5RwudmRAw8ZCooJX5QAwcuQS6IKYE7UNhQj7I6wLjA1e3VSJLONzmQFKA/IaCcbgb4FbLrgIufCXsdqKCxgyOIVY+L7J+c0q+UVZebA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655698; c=relaxed/simple;
	bh=PSDZovwfsjNCrw5eVrkA8X9sJK4u7vGS2YhntmA5pe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JsHYB1fqhtD3xB7hxfArbKCvucbjJxyniuSIlYidtkK82AK43nLL1H0gMk40xAeUHwqeTzqW+oxLbPtM9RTFbrZ5S9TLA/pttMwZC1tIbGsau8mmHN7UjCJlBHwj+uWk5LpwVScTv7hdtF30C6tvvwGJ7o6nJHJ3IYKrDpvBlZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlE0bFjJ; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4d43a1f0188so545736e0c.2;
        Thu, 28 Mar 2024 12:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711655696; x=1712260496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edpM49hY5bgsJjXAVnncLdk5Mo7gmai926Onh5HepfM=;
        b=LlE0bFjJthml5zi58FdrRLqLg19JV+WY9BJ9nSk5Fg1Uad0mc/hh6xZpWfVNPsDVoU
         Gd7MSH8KWAJpVV1x94Qtj7N+cr4XZ+khvtXhq5XMWw1tI3DBL+DjRxBPMSfoCZMxkFOu
         K3tQGvsbaQ332/YsUdMdfcZ3ZNitDkg8q54QoCpsQsmFcP+NGpRd7apNrWWiVsRdzPBG
         clpksKCOHmsG8+7rBGOH53TC0tWRWF++JTs3+tMSYlt87Mc86pyUS8k9KhbmElORDqI+
         v5Y1BFNij1GQ7LB2FTspKh2gdReUYvwRRAU4unESDHCnmoNZwxncBQGSiQaOWkU6xaNG
         HLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711655696; x=1712260496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edpM49hY5bgsJjXAVnncLdk5Mo7gmai926Onh5HepfM=;
        b=LiVEaX7Y0iYI6hsepfgSivA2h88uyE/ZLE4fx1Yfc+3KrcBugjY/D1V1CWaAu5u9fO
         TNNTiwmLGpelkrbUnMnIDDG3GKeJbAuXaJV1DNrbUTsUYmEJfYVMHwNjoP17cEOSMnQf
         bdGiyy+xCfq1MxtdVsvdMhljBHfvZTcImV1IjpExKt8fGb38zZiqUrh+wBBvfHY7TGDT
         etoK18GPJ3aQJcJziaeIW+8e4gcRf8AiWeAXp3bxiJJARTu91UMRulaVnp14MDSyUWg9
         7TrYmZga6FLdcj4tpAoAzAj0EiEuhrbCry124FO7RqZAOAKGlRqwZFxWqPve+jfIx+09
         vy2g==
X-Forwarded-Encrypted: i=1; AJvYcCWLTCMo1gcRdBK+ZujZ1iB5WvpPXU5MxhnPIIDzw9NNG4TvU0HkrzXjczHfpsJGq4J3xteR4OPMqXJcFOLVrw8b18FN85Tp01NjYADVT6h8Hsj9RM98jTi+HZ+1Tj1CZ+tU5POi82/N79YDL3LLQPIC3icg8qvmbW3N+r0OA4uoKj/vlvcasmjXMzK4tBKltBx8SX28Q1M655h7stAH4yXuLwPOc+ozEw==
X-Gm-Message-State: AOJu0YyrkA7NyRao6MzMj1ip2nC1yvy+6Nf1VSkmSo8PQMDZDXd/AUR3
	JxCKcnfsDl+YB+CnDOn/i8anVJ7i7O3sQXCO0OnlkBIGeumqafjl0Bf9LxySMQ26gc5NyXoxe58
	uI3DyFHagnAS8xp8jn8QbgVfxGGVK0XLcuac=
X-Google-Smtp-Source: AGHT+IHa9XAosSfz4PvD/IcWP/NhKOLb0BvmrqJ2Lo2NpQG6t74W5U8h2BiSeNMsW8VD/17fq5eWBQ4y1Ml9pRBhVtY=
X-Received: by 2002:a05:6122:3982:b0:4d3:398f:8633 with SMTP id
 eq2-20020a056122398200b004d3398f8633mr422285vkb.10.1711655696167; Thu, 28 Mar
 2024 12:54:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326222844.1422948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240326222844.1422948-7-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdWdaiSer10agMytpv9h_gb4bEpEHjThDwRkMShXkKMxzA@mail.gmail.com>
In-Reply-To: <CAMuHMdWdaiSer10agMytpv9h_gb4bEpEHjThDwRkMShXkKMxzA@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 28 Mar 2024 19:53:12 +0000
Message-ID: <CA+V-a8udXMwzZvJhDH5kK9J4ihLU00TbpKNb5-YoxOGFtdgpPg@mail.gmail.com>
Subject: Re: [RFC PATCH 06/13] pinctrl: renesas: pinctrl-rzg2l: Make cfg to
 u64 in struct rzg2l_variable_pin_cfg
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Thank you for the review.

On Thu, Mar 28, 2024 at 2:14=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Tue, Mar 26, 2024 at 11:30=E2=80=AFPM Prabhakar <prabhakar.csengg@gmai=
l.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Now that we have updated the macro PIN_CFG_MASK to allow for the maximu=
m
> > configuration bits, update the size of 'cfg' to 'u64' in the
> > 'struct rzg2l_variable_pin_cfg'.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > @@ -241,7 +241,7 @@ struct rzg2l_dedicated_configs {
> >   * @pin: port pin
> >   */
> >  struct rzg2l_variable_pin_cfg {
> > -       u32 cfg:20;
> > +       u64 cfg:46;
> >         u32 port:5;
> >         u32 pin:3;
>
> Doesn't this store the 46 cfg bits in a 64-bit word, and the 8 port
> and pin bits in a different 32-bit word?  Worse, you'll get 4 bytes
> of padding at the end of the structure.
Agreed.

> Changing the port and pin to u64 should make sure everything is
> stored together in a single 64-bit word.
>
I'll change the port and pin to u64 .

Cheers,
Prabhakar


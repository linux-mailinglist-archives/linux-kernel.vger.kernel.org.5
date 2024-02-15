Return-Path: <linux-kernel+bounces-66893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8BA856338
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C70284951
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC38512CD98;
	Thu, 15 Feb 2024 12:31:26 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDCD26AC1;
	Thu, 15 Feb 2024 12:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000286; cv=none; b=bznU53Y3pzU9k0y/7utAkXSKLA1wMk2rZOkvmhY9hhFTs9kFXTuCtE0Wng4enXexjglkNgB0cse7UQcDyajAsR+49pS95h/nuGD0Uaq9N+41UbkPdotnFGpew8JBVlT7IzdWunDu3vDKuYBNrnFoKERZO1NY3Dy/cKrACv1h8rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000286; c=relaxed/simple;
	bh=CWPtIlpV9nzAVGHY/drNqYAWNEuBNyDgfM9CnQYQdGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eFOZptJ5vaUhm7UjHMB3T/0uHS9waSwNrx6LD8LQiFhFafStZUWpcO/toF40+OE0f620iKPSak5KMjYPOUG0xFKEwMN9ejfMNf4xzSqakpWhuWtMFAUXQlzjwUPKxAkF3X0uI6ji0FVwNZ6NMT7zTO+9USxIrLiKl+59tY0eOPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-604a1581cffso7778917b3.3;
        Thu, 15 Feb 2024 04:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708000283; x=1708605083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8u20eYn2u5qLfNUZkHz2pWCJyf9yZJC9qcaLndHqMc=;
        b=tbhzd6UfYWcfI8oJLto8Ed3n1CGlVKRTk33Qy8Plh46HM3+CR/um6yEuZCwa9rvOII
         nUv3uGZwe3Yy31D/HuB5CH6dSiB/t67+LSecMZtJVWuAtC4SlWDDKzsPX5mx8XkVA+Q1
         fC45wVFI5YAlFFkHuT4mb/lUW45NKCixF0/vBug8lCwjSDSlvg5YfG/9YNtuvNKBPBjg
         xp89ClK6sP+26bfXkfSxQIv+gQgavuh+IFZVrxGZH5bDb++vE9j1aOh3eqfH7IF9ABLu
         47wv0GNgb2jbJcQffkjsOmUHkHfNv4oF6IbZQVoee3Psyq8OLMc/kH01mp+aejR+NIWx
         VRww==
X-Forwarded-Encrypted: i=1; AJvYcCXUPuzqXFEfY+Lz9X0m5JMBhxdysHDtybs5tH9YK/5NqKcnBaGVODRYItsAZXV7+cGtBs1G3yIEaMrzjxUUAiGZj/VzEo1Yh4kvZ44J
X-Gm-Message-State: AOJu0Ywqj13dJaGr6XI3py0cRXPneZ1IseruMGnKyh4a7WuiJADZQISJ
	POzXihQWPTXSwirI5Z0KZszinWdxP/TcfFHIw5VDAT56be/KbNy+WERH1osXEndi/Q==
X-Google-Smtp-Source: AGHT+IHiO3GU+UlckdVQl9jgUaQEofS57K7EXCJqhxn/d+EgkzbmFxOL3sDvhzYxmMgnTlBFpXhwzg==
X-Received: by 2002:a81:ac15:0:b0:607:ecad:90f6 with SMTP id k21-20020a81ac15000000b00607ecad90f6mr15535ywh.38.1708000283439;
        Thu, 15 Feb 2024 04:31:23 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id d195-20020a814fcc000000b006077c16f7c4sm223869ywb.33.2024.02.15.04.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 04:31:23 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcc86086c9fso713895276.3;
        Thu, 15 Feb 2024 04:31:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV3tI/7HxCUIuUEH307b8hIo2mcDXzoXNUQyYbcsZ0nBr6z1RngtwE8aadc/gMw2XxDJ0hPqP0vo03eY3/8YBD3KAeL+XHbxJJx0zKy
X-Received: by 2002:a25:2bca:0:b0:dc2:6f92:2ec0 with SMTP id
 r193-20020a252bca000000b00dc26f922ec0mr1507971ybr.51.1708000283050; Thu, 15
 Feb 2024 04:31:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
 <20240212170423.2860895-13-andriy.shevchenko@linux.intel.com>
 <CAMuHMdUBMieOt8V03OzRXO84w6RTjnMDHwBr3RtAWc+v-cRUsA@mail.gmail.com> <Zc4BmcVF-dEX4Mvo@smile.fi.intel.com>
In-Reply-To: <Zc4BmcVF-dEX4Mvo@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Feb 2024 13:31:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXfYq0LZjxJWg9yj0DBnbYBTv2oeJRB+LBQt613qUWULA@mail.gmail.com>
Message-ID: <CAMuHMdXfYq0LZjxJWg9yj0DBnbYBTv2oeJRB+LBQt613qUWULA@mail.gmail.com>
Subject: Re: [PATCH v2 12/15] auxdisplay: ht16k33: Switch to use line display
 character mapping
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 1:20=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Feb 15, 2024 at 09:16:05AM +0100, Geert Uytterhoeven wrote:
> > On Mon, Feb 12, 2024 at 6:04=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
>
> ...
>
> > > +static int ht16k33_linedisp_get_map_type(struct linedisp *linedisp)
> > > +{
> > > +       struct ht16k33_priv *priv =3D container_of(linedisp, struct h=
t16k33_priv,
> > > +                                                seg.linedisp);
> > > +
> > > +       switch (priv->type) {
> > > +       case DISP_MATRIX:
> > > +               /* not handled here */
> > > +               return -EINVAL;
> > > +
> > > +       case DISP_QUAD_7SEG:
> > > +               INIT_DELAYED_WORK(&priv->work, ht16k33_seg7_update);
> > > +               return LINEDISP_MAP_SEG7;
> > > +
> > > +       case DISP_QUAD_14SEG:
> > > +               INIT_DELAYED_WORK(&priv->work, ht16k33_seg14_update);
> > > +               return LINEDISP_MAP_SEG14;
> > > +       }
> >
> > error: control reaches end of non-void function [-Werror=3Dreturn-type]
> >
> > Missing "return -EINVAL";
> >
> > This case cannot happen, so it wasn't handled in the old code.
> > But with the new code, it fails at compile-time.
>
> What is the command line and compiler you are using?
> I have compiled this code without issues.

riscv64-linux-gnu-gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04)
aarch64-linux-gnu-gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04)

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


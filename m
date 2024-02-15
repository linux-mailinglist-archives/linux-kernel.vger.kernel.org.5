Return-Path: <linux-kernel+bounces-66710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7175A85610B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E91D7B244EE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603911332BC;
	Thu, 15 Feb 2024 10:46:48 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E56133412;
	Thu, 15 Feb 2024 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994007; cv=none; b=vBPIg/x2IbtaZnxgcrzt7DUvu9DBId0UGbpmrrri3MqsRzNdFHQLqcgUwtKkU7kIJhBhpon6LTpXeoTfzt21TNxv7scAJSjuwDmvFjQm32iOaiNlnm0B4sb9ZCbzWkIybNlD5GYb//4iaEe8CeQcPZYNaaPMpiRtgLrPKW8+ano=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994007; c=relaxed/simple;
	bh=2g1UCNPioXAN/NTdQsZtoVsmkeQZGEUJ1Z4j/bMyhTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGgqrVbVSFbULcxZVgdt7aCMdWt8eAUFN87OqnoG4Eqz+y1sXi3jt8JEYBSClZ210rhGK8h1prSThjxNJztBpJLNeOAYmvXgGX44p94dp8iUd+IZ8qHIqt2yxP1xw1vqB2TDXFxnODvV8egWfvLymWJEoF0A9wTlO257xlQBR6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-604a1581cffso7011917b3.3;
        Thu, 15 Feb 2024 02:46:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707994004; x=1708598804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1lAFMaqNvrj4VTIdRbaFJPSTWNCjgzdwW6T4WWjzLw=;
        b=Cq6v1D9BLWOn9lNzBr955DlR5NMKKzXRcNeoilXgtscZvTuWcoG8Yb77pdIQXT4sc/
         gln0uNZhZMCgauPlvdOjvR8s/S8ebc/fyD9fbB0lbGN4tdHYtXuRpWtaWdoWvezWhhHX
         SCTzXV1IzDuh4wG3ziy8h9G//L0OfQxmlsCVXEi2nTdMli3q0wsFoDSBW4JhJdkEtxHW
         OrZ3Td5mZ1l106KxD8eazUT8jFM6KZFfJ/fTNzhLJvzgtP644pmSPE5gD644XRN0LNGz
         WJexq+AcYNRLF4CNz3DXVIhmOBF9aXAUPgI/XlXiCWoyz+V2sej2X1/L2O1gKAh06lK7
         OCqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC8+p3j8i4Hst+GI6kTAjTs6bev4UWsd+TF5pP3d/ibIc68Auv0gcQwskwftVAgYmfSF0GR888zgDIcNolR3Z9c3QYelkJMUZuq/og
X-Gm-Message-State: AOJu0Yw5oEIutZaFZXsj7D25MYvGQ8QxhiKlT2KIFGjUz+IqyPE8E+B4
	jdeV9odTBTADXQfYcCugZpFhJjbtlNyQg4heCfb5Hk5iwGbL9ctPo2kShkW9H27NAQ==
X-Google-Smtp-Source: AGHT+IEAMlNuzUm4x9ocnPd/5LkUN4u0ASIukzxeWojbjm37d9otLvtmnc69XPSSRz/FYuxLNcNGjg==
X-Received: by 2002:a0d:ca0c:0:b0:604:93a9:386a with SMTP id m12-20020a0dca0c000000b0060493a9386amr1559700ywd.39.1707994004304;
        Thu, 15 Feb 2024 02:46:44 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id b188-20020a0dc0c5000000b00607c2ab443dsm189942ywd.130.2024.02.15.02.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 02:46:44 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so640483276.0;
        Thu, 15 Feb 2024 02:46:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUgjAPnek/Orp6jTomrskDZpjzDtNIPVZk2s96++Xw3pW5YRGkI4/GOvySAxVV7OWIYVqUXQstYnEzRulqs3GtidAcTviPElkaBpJCV
X-Received: by 2002:a81:8492:0:b0:607:90a5:dc15 with SMTP id
 u140-20020a818492000000b0060790a5dc15mr1629169ywf.7.1707994003820; Thu, 15
 Feb 2024 02:46:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com> <20240212170423.2860895-14-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240212170423.2860895-14-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Feb 2024 11:46:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUMgGsuxo+hB9EDeq+ZU3awUMYok1NWKTaR4Yu61W7kEQ@mail.gmail.com>
Message-ID: <CAMuHMdUMgGsuxo+hB9EDeq+ZU3awUMYok1NWKTaR4Yu61W7kEQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/15] auxdisplay: ht16k33: Use buffer from struct linedisp
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 6:04=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> struct linedips embedds a small buffer for the string that we may reuse.
> Update the driver accordingly.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Two nits below.

> --- a/drivers/auxdisplay/ht16k33.c
> +++ b/drivers/auxdisplay/ht16k33.c
> @@ -451,8 +444,7 @@ static void ht16k33_seg14_update(struct work_struct *=
work)
>
>  static int ht16k33_linedisp_get_map_type(struct linedisp *linedisp)
>  {
> -       struct ht16k33_priv *priv =3D container_of(linedisp, struct ht16k=
33_priv,
> -                                                seg.linedisp);
> +       struct ht16k33_priv *priv =3D container_of(linedisp, struct ht16k=
33_priv, linedisp);

Please wrap long lines.

>
>         switch (priv->type) {
>         case DISP_MATRIX:
> @@ -471,8 +463,7 @@ static int ht16k33_linedisp_get_map_type(struct lined=
isp *linedisp)
>
>  static void ht16k33_linedisp_update(struct linedisp *linedisp)
>  {
> -       struct ht16k33_priv *priv =3D container_of(linedisp, struct ht16k=
33_priv,
> -                                                seg.linedisp);
> +       struct ht16k33_priv *priv =3D container_of(linedisp, struct ht16k=
33_priv, linedisp);

Likewise.

>
>         schedule_delayed_work(&priv->work, 0);
>  }

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


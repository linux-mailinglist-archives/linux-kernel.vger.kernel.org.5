Return-Path: <linux-kernel+bounces-66396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0B8855C1A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D7BF28FE42
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A25E12B87;
	Thu, 15 Feb 2024 08:16:24 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287CB9475;
	Thu, 15 Feb 2024 08:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707984983; cv=none; b=oFdfo3cCu5BYiMMuG2ytprEckC3tnMjmX1DO5j0zBbjsPAOBwwtymFvwAao7Jfpriqrm45qPnLGimb2kJMJmMYwWgj2P0MFsYQVJrhc55FQ+0hHAut/JWC+0vj4wtt/XU+npLuNmcvPynAJjQrG63Jn+XlpT0Yh4ijRdz9I85u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707984983; c=relaxed/simple;
	bh=JjGi5ZDYvrRIDl/1EOJ5b0pBB3A9qnfjnY9iKfbunL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j12l91NYWtjskd7oxQ0G2KxXxyBOLjst0zErZiKMttUbduWuJ8F5UlfUpUuCnHWn2kwuK65v5N7gTe/zRghJeHQ5oBYFpnHBbj/RXPZu7foXLucMZP/9cP5MpLVAdx1nJ6qynwWSCwO+a2pJzQqWOi0XZJnDFXfPL7GGfj3P40o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-607e364c985so89167b3.1;
        Thu, 15 Feb 2024 00:16:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707984979; x=1708589779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPcCwO5p3sWFBxGdMeqPKr7uj3BE3coRyKUOujECZjw=;
        b=VNArU4g+ZE1SU7wOgRGL5IxrJxOrvMMEKPS4HiiCnirr8m/ApZeoyg84r8dpT+oSFW
         30X31i4lVHurarFcfy1rV2CUvyawHiAJnTHs9DOmeKYd9OrrmYsl1Y29AIT6xJQ3FBqs
         GPcn+/D3j/EFOzRoQ4hA/jowFVhGg2Slv6QFnW2aF1MN1uX6dwx5UZ/yCeT9S1P0vwE9
         78yLIfCawwqscIcfCdwyeGlFpjvDprfENUygcqZJKYrOOnTEGHQhwbfZBu52ilLVQRLU
         N+CxSKJEU+leYMOEeq9ZdUpXawep8uj5Db0g8joxdbBRbbbzk99ZHEDbZ/d018lfHvWK
         3MMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZTYxZPgFlu3uWVFoO+IGDIS08IM7QLk6flK+1seBrRZVuaruc5xtf0Ti/jST6dh3HGEHrg72wEiz9iIlHWwHMR2JnKnLysujK1AHc
X-Gm-Message-State: AOJu0Yyz8J2SakZ/QFAEpDkob1PMsOtW/54nMi4HePlnyJXrq7JuKtFX
	DqJtkIofdHqHSm4LXNJ4V/eZlxUi97kV2XrAaPx3xd/ep361ZHBAxfz7DHeeZGM=
X-Google-Smtp-Source: AGHT+IGTU51hzIcmvWTsH6waHMr9BHRdirebk0iWMhCja7IYV2GF1mFR4zw4Br9NhavrtW/vLttdVw==
X-Received: by 2002:a81:4417:0:b0:607:82e6:aa40 with SMTP id r23-20020a814417000000b0060782e6aa40mr1080551ywa.27.1707984979136;
        Thu, 15 Feb 2024 00:16:19 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id c9-20020a814e09000000b005ff9c1373ddsm154545ywb.88.2024.02.15.00.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 00:16:18 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcbc6a6808fso554703276.2;
        Thu, 15 Feb 2024 00:16:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWTkEVsS+CFiYr5O+lX0ArkAAKdzB3wYJwm2hMP6uAA6SFdNf4oyviZkDdfR0HrAy0RLnrucIpH+v6RX3OklIKHqviZ3nke+j6AgHXW
X-Received: by 2002:a05:6902:2501:b0:dcc:97e4:bc61 with SMTP id
 dt1-20020a056902250100b00dcc97e4bc61mr1069341ybb.57.1707984978176; Thu, 15
 Feb 2024 00:16:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com> <20240212170423.2860895-13-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240212170423.2860895-13-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Feb 2024 09:16:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUBMieOt8V03OzRXO84w6RTjnMDHwBr3RtAWc+v-cRUsA@mail.gmail.com>
Message-ID: <CAMuHMdUBMieOt8V03OzRXO84w6RTjnMDHwBr3RtAWc+v-cRUsA@mail.gmail.com>
Subject: Re: [PATCH v2 12/15] auxdisplay: ht16k33: Switch to use line display
 character mapping
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Mon, Feb 12, 2024 at 6:04=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Since line display library supports necessary bits to map the characters
> (if required), switch this driver to use that.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for your patch!

> --- a/drivers/auxdisplay/ht16k33.c
> +++ b/drivers/auxdisplay/ht16k33.c

> +static int ht16k33_linedisp_get_map_type(struct linedisp *linedisp)
> +{
> +       struct ht16k33_priv *priv =3D container_of(linedisp, struct ht16k=
33_priv,
> +                                                seg.linedisp);
> +
> +       switch (priv->type) {
> +       case DISP_MATRIX:
> +               /* not handled here */
> +               return -EINVAL;
> +
> +       case DISP_QUAD_7SEG:
> +               INIT_DELAYED_WORK(&priv->work, ht16k33_seg7_update);
> +               return LINEDISP_MAP_SEG7;
> +
> +       case DISP_QUAD_14SEG:
> +               INIT_DELAYED_WORK(&priv->work, ht16k33_seg14_update);
> +               return LINEDISP_MAP_SEG14;
> +       }

error: control reaches end of non-void function [-Werror=3Dreturn-type]

Missing "return -EINVAL";

This case cannot happen, so it wasn't handled in the old code.
But with the new code, it fails at compile-time.

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


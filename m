Return-Path: <linux-kernel+bounces-66612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C212855EFA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0011F25D82
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3556E69D36;
	Thu, 15 Feb 2024 10:13:51 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E324679FE;
	Thu, 15 Feb 2024 10:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707992030; cv=none; b=BIy8yaeWYF10O+FVsqkHj9uSUQjtgycDcseMgsL0+bxcuexP4repyyLtIQChXD5yZDQ8x1UOb+AgeIP5Kr7TcD+Krkkc8O0BmadF27hHuZykaH3hi0ZkaG/C1HhHFi6ZAWVkpODpgH/cX0Ec9stfvyeoqX3ZCeQUATkrcYHPMEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707992030; c=relaxed/simple;
	bh=zQK9YWdnA2MLFWkG0KYucAtSWqDsyb5toZ7+7+Lze/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmgqufxdNwoFOXIhVtwDumZY4gtyt2BdKD64gbLNjt0P8VIskruREPY3T2CArq91eyueyFy3rj97jA8ASnAteZNXxHCuKNCNl3xFFaSJXaD/8sCjQofoSSCLd9yat5YCWXVTPhyIwy8HrqnePOXPJX40EmDh3mEiEd1wQL8bhNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d10ad265d5so8814151fa.0;
        Thu, 15 Feb 2024 02:13:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707992026; x=1708596826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNaDKxTWYbBEr/pCLpL+n0Yx2MpOWuz0pvKe7ocVQwQ=;
        b=EXaElozzM7IYTeEUeuLAlMFBM1n4aikJ/sza54ziNGGcVPgJnKl8scOAzH+dxE+/pK
         QU0I42aLG3Lyw3/llxzqjgbyRC2gECweADd01wq/4H3Cjyq/6ZyoFGdsdNzIQ+yO6ZGQ
         aI4vdOm8ppxlZM/6zqQhMNGFpDUu9dZTysU+KF3z5maSwwavn6tehMiL4GgADvnLtwzu
         xbZL6eIRalUM7/yU0nR7/iZuHK9jUntQ34wKfjt/js1bXzfcs6EQNBeycLxiTitX7tIq
         8TAXBKBjKo4FXz4b8te+UwAI8W/DldS2V7qLSeRBcY60ELO9saRt0al0q+mkKd0yVVvA
         YpTg==
X-Forwarded-Encrypted: i=1; AJvYcCVlhoBwWZXwy2t9/M+tG6YXr8L8Wi54N6mg419n3tNHWhtpkjRL5yC937NiZw3XdUFpv/WYTMhQSg4up9jGbtTuNiRhvK6We+mcLR6G
X-Gm-Message-State: AOJu0Yz4zgDbE+sh4ZMV6OB7yAf6knBkuY6vUKovM8/XIJ2DG66+ahaq
	lWBQUNpmM/tz3it7Q5jlWA8CVixye2bIpEZyervPpR3RNq4j/hYIVYn+xJ6usyNv9Q==
X-Google-Smtp-Source: AGHT+IFrxfdkttYFuNy6II5xa4smJepNzsJk8CRsvZGZjwLVwwsWfBFtm5hbprjBOMNmkLh0mZktWg==
X-Received: by 2002:a2e:9793:0:b0:2d0:ce22:516d with SMTP id y19-20020a2e9793000000b002d0ce22516dmr1087986lji.3.1707992026019;
        Thu, 15 Feb 2024 02:13:46 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id w12-20020a2e9bcc000000b002cf1cf44a00sm213259ljj.52.2024.02.15.02.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 02:13:45 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5128812662eso506854e87.0;
        Thu, 15 Feb 2024 02:13:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJUq9XOyf+GVgx4V7x0bM/P358v4Ldow+vaGD6bOfcBZL5LrcCQ3v0MfgGH5fcgXk9sDCS1mzYUbkiWu0uBDjikMeWFJT+95iUrJt2
X-Received: by 2002:a05:6512:4884:b0:511:61bd:d748 with SMTP id
 eq4-20020a056512488400b0051161bdd748mr1062136lfb.36.1707992025566; Thu, 15
 Feb 2024 02:13:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com> <20240212170423.2860895-9-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240212170423.2860895-9-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Feb 2024 11:13:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXWu4JYT5wCX8sbwdM8gt571JakL1UHi2SGd5wKB41pxQ@mail.gmail.com>
Message-ID: <CAMuHMdXWu4JYT5wCX8sbwdM8gt571JakL1UHi2SGd5wKB41pxQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/15] auxdisplay: linedisp: Provide struct
 linedisp_ops for future extension
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
> Currently the line display library doesn't scale in case we want to
> provide more operations. Prepare the library to take a newly created
> struct linedisp_ops that scales.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

For the code changes:
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/drivers/auxdisplay/ht16k33.c
> +++ b/drivers/auxdisplay/ht16k33.c
> @@ -696,8 +700,7 @@ static int ht16k33_seg_probe(struct device *dev, stru=
ct ht16k33_priv *priv,
>         if (err)
>                 return err;
>
> -       err =3D linedisp_register(&seg->linedisp, dev, 4, seg->curr,
> -                               ht16k33_linedisp_update);
> +       err =3D linedisp_register(&seg->linedisp, dev, 4, seg->curr, &ht1=
6k33_linedisp_ops);

Please wrap this long line (everywhere).
All lines in these drivers fit in 80-columns before.

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


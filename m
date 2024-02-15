Return-Path: <linux-kernel+bounces-66672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F28F0855FEA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313981C21623
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC6112EBC1;
	Thu, 15 Feb 2024 10:37:04 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDE512836D;
	Thu, 15 Feb 2024 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993424; cv=none; b=QDDAQfDsvGm6eUvAPadCXKlpjTz216k8TmYusvtOgEtYLaDxFJrk+TZNwX0RC0v2AdBO/ID8GrbF7l5iZJ8yZCpBoVaVd9f15UevHcY1U4hVIHMXUJhg1g2eLycgY/Od2IrcBDHEBYIPuKK6GE4G5bwbkfCBqyiDrk1JbyD0Uew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993424; c=relaxed/simple;
	bh=5yP/oK/QX6GLqNHGcZE42Y0It6X9OWSybO44CFOdKoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ItrhDa+mBCEzcqZBsOQzvdGt+8oZXJ81h6fpTsbA6phOJJ3ng7wpNtM2oZJL7S7llMzUfYWGsaku3C3OZmoPMocIW0sRLyNEVZNR8UtFeZILZPLnOxeXaWUkLlpXYfPq/U3lmrZLUr/oUMx8f7v73EDjFUklfC2mftJ9pW9yAdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-607e41efcf1so893377b3.1;
        Thu, 15 Feb 2024 02:37:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707993420; x=1708598220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/AKQkhEkHphdPg3PZ7b6i/z7hewaCRwLC+2BBvfgFzo=;
        b=V72PQlyvu5yEwjTwm+tbZESWivWulpyHdtGUa0EPdd1lV938SAF910qMXgmMviPENz
         PK36x1C1uuyr4OBGD7sC98ly0RPAspK4RVX/DNg8dL4F1qGYEEWtvZZUKzm4nFy80ier
         lh77FVsXytMdZeA4bhSXlyMKmyknOqpHqCyWjlFDiioSWh5/DHDlANpP7DevV4arXZth
         Bvv0ZX1q4uhkCJuYn+tBJJeMs2WAcA73f3AWotOcg2Q22Ds7Cq+jQa7gJhZvferwCSAU
         4lg8HJhpX5iBX8fIIsEc57DavSUwylSSYhROe63f5IeBaFXKs0kQ3D9CyAw64PkCuuAx
         EFyA==
X-Forwarded-Encrypted: i=1; AJvYcCVZouuIgCzSk8wdRDnlITj1rysv79Cv3ZU+CsYRdEJby6R8iCwJPDfVevDZLx9nuWbBppSFOcI0s20U4/9rYtdDO9lCjbovcEfvyoiq
X-Gm-Message-State: AOJu0YzrrrLNCbfQnsR5IH74HXzNSjvNl/+A/PZxjg3HrfAIMsEGF3kU
	QYq2HaE3orJy3VPQxT/9tHJzrhoVX/ku+8fKC6DkL3ybfSujTKvY/V2pZ//E12m83Q==
X-Google-Smtp-Source: AGHT+IEnldONfvWvwnxD+CiJW6hdEhh93Br0SjyfdCfnUvotGGDS5gZILUAAy3+2feq9cZxQMn8UIA==
X-Received: by 2002:a81:4e06:0:b0:607:75e1:9da7 with SMTP id c6-20020a814e06000000b0060775e19da7mr1317286ywb.30.1707993420599;
        Thu, 15 Feb 2024 02:37:00 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id o205-20020a8173d6000000b006077f156d24sm189728ywc.75.2024.02.15.02.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 02:36:59 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so654171276.2;
        Thu, 15 Feb 2024 02:36:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXUcsIAnTgAyJkzz87skW+7Uj3Ce8aGszzUiH+IR8euNMGYc2lNyWa9Dz7vnms4eV4HZ9/oBmADo59ZrHyFodNnhlL0w9mgyeNuUT1Q
X-Received: by 2002:a25:3626:0:b0:dc6:ff32:aaea with SMTP id
 d38-20020a253626000000b00dc6ff32aaeamr1038810yba.24.1707993419510; Thu, 15
 Feb 2024 02:36:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com> <20240212170423.2860895-10-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240212170423.2860895-10-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Feb 2024 11:36:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV3TOXc-_L5qG7D_XyFUcgNOyCoOwBhFPqNFBfAVyVydA@mail.gmail.com>
Message-ID: <CAMuHMdV3TOXc-_L5qG7D_XyFUcgNOyCoOwBhFPqNFBfAVyVydA@mail.gmail.com>
Subject: Re: [PATCH v2 09/15] auxdisplay: linedisp: Add support for overriding
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
> There is already the driver using character mapping table for
> 7 or 14 segment display. It is possible to override it. Make
> the similar in the line display library to allow other drivers
> to utilise the same functionality.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

One question below.

> --- a/drivers/auxdisplay/line-display.c
> +++ b/drivers/auxdisplay/line-display.c

> +static const struct attribute_group linedisp_group =3D {
> +       .is_visible     =3D linedisp_attr_is_visible,

Shouldn't that be .is_bin_visible?

> +       .attrs          =3D linedisp_attrs,

Likewise, .bin_attrs?
But that is a pre-existing issue in the ht16k33 driver.

> +};
> +__ATTRIBUTE_GROUPS(linedisp);

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


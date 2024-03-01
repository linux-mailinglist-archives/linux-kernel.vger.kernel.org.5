Return-Path: <linux-kernel+bounces-88431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C693A86E186
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1F71F220C5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE3C6A8B9;
	Fri,  1 Mar 2024 13:05:28 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586C73C6BF;
	Fri,  1 Mar 2024 13:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298327; cv=none; b=MjuJjN+0xuWQtVlKajp4GAkFVP/UH9rqe0bM+pFC61OUi0eCwzu9kt/bufe3XT8ev+nVZshNjTU+VSRE3pvDdbMERjcaVq0UWfGmmtpR/+Pkqb8BoRfSYN8ldKGj8yk/EUhtV/PA6dIYW6HWucJby4S29RNM24+BPhkw0Y/3atY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298327; c=relaxed/simple;
	bh=0bVCzrJS9x+1yZMoEFxLm9bnbbJleSpuIb0C3VF53qQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S0knYbSeUwoDkR4v8AsBqnOmiZbWixycnemnunMexYd4dfo9WBmXR2DaNg3eCO6v/yHpUfGji0n9T5KBInV/Flqqf5e2HfL6E7ArMs0SZ14inSA6hYsoYNxVamDtndYeOiuUi9lKXn/Fdfv5bitk/jREYdJbCyGydJZhaxrPZyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6098bf69909so68857b3.1;
        Fri, 01 Mar 2024 05:05:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709298324; x=1709903124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQI2EbWiD61r+f+mvhd3WkVdayuolmx0uiT5UHC3aVk=;
        b=OW0LAvkK8gFJ6A3yRPRHxkaFFcAV22erxlSeyKVKtWtkv6wirTvPIOAtZQKzunfY1K
         flmTqR83JSz1b+yZULgYS4744fTs9kO+94fCsD1m5onn9Sj7snIP1x4PJjAsLjTDoFAp
         2FS2E5nWaVDbKD/0neZNn9l/sRpQGnorZzvxGT+s7acY4jkf+nskGxpUVXRTd/Y4F5X6
         xRIaUg9H2g0OW3aKwrhrmNdndwAh6+FE0nHlX3URHlBlIFckCy7qQzSdcR9kTOL4t3mW
         +3hbA5+Q0HghSIMC+iwPnTnsoqMJ/sD6IuCuLxtXW/4jEI7K+oMpeS6oqQq1AQ8x20JM
         DzfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZO1Q26ivPGgTGyQeYsVBAIr2/4OYUDlarXwUI4OuraRB47Plp7BSuSNranMx+vaT8wIRZswSneaW8yRcxqE+N8YjMPalfn0fOyw9YaRbCFFp9jSjyvLKwW4oN4j8Vl/f8zqVov24qzWRp5X4Zus/rbmEpvlJ+mtfdPfuNABWUCSaloJMl3v7AVjE=
X-Gm-Message-State: AOJu0Yw/hF1XcLjt/fJ3HAvUVQL65PhsMZe6zQENSJQoBHmkSq3NsBEt
	BDTst6n06dpecjar/D1NfB/7DUciPu+u8ZsK8Z4x4JU9bl4qZZBDhVMZxEkCrVQ=
X-Google-Smtp-Source: AGHT+IG+Lq9JYtWOeBMPrYoQz7PR0vpZ9fQTaDnPvsBie0GaRSqwNucZkabNJehPhiPyv923Zgaoug==
X-Received: by 2002:a81:8414:0:b0:609:892e:b944 with SMTP id u20-20020a818414000000b00609892eb944mr429804ywf.4.1709298323984;
        Fri, 01 Mar 2024 05:05:23 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id o1-20020a81ef01000000b00607ad76d855sm909733ywm.67.2024.03.01.05.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 05:05:23 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so1624817276.1;
        Fri, 01 Mar 2024 05:05:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWhOKClxVr6fkz1Y8KyAOaBWsSDPcPcZhqdLLAXj2qw2G5a7YcRAOfCcf2lk4ny/MMBeDMIHXgAx7ukbVGFNtdk4TBUV4Aa6WbXe1KGjdPOP+9tdcDoQptEv/h02QK2k4t675Pp+wvpsKO6K8ULuYJKC3mIuzVBrz1RfvhoXHy24P3tPtbHQKqveNQ=
X-Received: by 2002:a05:6902:2310:b0:dc6:daa4:e808 with SMTP id
 do16-20020a056902231000b00dc6daa4e808mr4576821ybb.12.1709298322979; Fri, 01
 Mar 2024 05:05:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8b4203dc-bc0a-4c00-8862-e2d0ed6e346b@web.de>
In-Reply-To: <8b4203dc-bc0a-4c00-8862-e2d0ed6e346b@web.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 1 Mar 2024 14:05:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWwegdks3eEviEsBJE3AvUVKbZqHduYdhuwz=8xTMDs5g@mail.gmail.com>
Message-ID: <CAMuHMdWwegdks3eEviEsBJE3AvUVKbZqHduYdhuwz=8xTMDs5g@mail.gmail.com>
Subject: Re: [PATCH] media: rcar-csi2: Use common error handling code in rcsi2_parse_dt()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus,

On Fri, Mar 1, 2024 at 1:10=E2=80=AFPM Markus Elfring <Markus.Elfring@web.d=
e> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 1 Mar 2024 13:02:18 +0100
>
> Add a label so that a bit of exception handling can be better reused
> in an if branch of this function implementation.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Thanks for your patch!

> --- a/drivers/media/platform/renesas/rcar-csi2.c
> +++ b/drivers/media/platform/renesas/rcar-csi2.c
> @@ -1388,12 +1388,13 @@ static int rcsi2_parse_dt(struct rcar_csi2 *priv)
>         ret =3D v4l2_fwnode_endpoint_parse(ep, &v4l2_ep);
>         if (ret) {
>                 dev_err(priv->dev, "Could not parse v4l2 endpoint\n");
> -               fwnode_handle_put(ep);
> -               return -EINVAL;
> +               ret =3D -EINVAL;
> +               goto put_fwnode_ep;
>         }
>
>         ret =3D rcsi2_parse_v4l2(priv, &v4l2_ep);
>         if (ret) {
> +put_fwnode_ep:
>                 fwnode_handle_put(ep);
>                 return ret;
>         }

Please do not use goto to jump to random positions buried deep inside
a function,as this makes the code harder to read.

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


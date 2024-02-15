Return-Path: <linux-kernel+bounces-66704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFA885606B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A60A9283240
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9666612CD8F;
	Thu, 15 Feb 2024 10:44:50 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805FC85297;
	Thu, 15 Feb 2024 10:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993890; cv=none; b=LoGPDLaGYebIdFOufjyELh6tCFVT7qqBIONG7B6T5bI+Q+YqH9lsyRyLD/n5343hRt5MvCWoORhlJfsIMF019pQaPTa4qakkOhjjAG/mY84FMAUGNV2eVNDczgDmIzeMwqsykqHmBj5Bkp7SPc1YR0foPecFAalnCBj8OhCuvPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993890; c=relaxed/simple;
	bh=rEfHphf8TVKM2mNrRqxuojkJo7yWHdXJjr38782xKJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZECMjLzopbcPRkXwkVQ49KVP/eER8lDxBKP5eTFoi9kVYsX90XksB2g0w4D6FFwzGgFDUu8jxCMd7rByLVkw++yT4pcCO6eGcPArC/2FZB1P1oQ+929RT1cQEdwRzZkLAVCn/tU05gtg8jHMQa8BVv8lsQbAn97lIgCSHkL8PHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-607e705f745so314717b3.2;
        Thu, 15 Feb 2024 02:44:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707993887; x=1708598687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENTHKve8MexsMKpgWm23bV9atjw5KN2SAIf+2QKC+IU=;
        b=xAY8pb77lDDJAH1NubepKkmhwMoNtVOO7tJbqRqvtOhSezT8OUyIfhjKNklF2ZyOXe
         FqnKhy8n+aegW5d5uC6fcKMD+AHHMBLhoS8G95wqY1bSZMfiqpXb1AfBZd761gXhT0V1
         pXn9dqjq46/0r34RFPJUGPs5VIx74oiDxCYcthB9es2jUQE+2lHBLIo3Haj3yN0AlUK1
         kOzhBZwGvj2hup4zyiNSf2TkXwzIqXz3rkZVuILcH8mSUNaV4bQ7Tzgr3WVBl12hQoTU
         SHKeMB2bo+98viorWEqRGHXEVjDbpdh7SSp6DL1EAE9mF9aE5pumj26ATgIlNcP791/d
         j7uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlJlDvGAP5hX4zKXviyVPEzbBA4w/GqCv9cvQ6ydtF8EL3Lo1/JrK+VoLX3SiBp9siwzkuZvTQbvfaQCXjf97XI+OCh4aVl9tE01f1
X-Gm-Message-State: AOJu0Yxv3rwgkjLh2lMcenPSLlyHY+XarAoJisNcqWK7ljmHH3igrQyE
	nKM9ffhmnFO6pdG2b20nPB8V8EDW0xFiSNqDHofz4YulDHy+7+i3n5aZQjWWtwxiiw==
X-Google-Smtp-Source: AGHT+IEYzmuGSNm1DtjmG4YoN9SNQa1SVy9TPcjDmzOvtlDd898mC5OCEAwRsVCByUc/cpgWt4KkmA==
X-Received: by 2002:a05:690c:d1a:b0:607:9918:8c7b with SMTP id cn26-20020a05690c0d1a00b0060799188c7bmr1434441ywb.22.1707993886987;
        Thu, 15 Feb 2024 02:44:46 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id h189-20020a0dc5c6000000b006040f198d3esm188263ywd.142.2024.02.15.02.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 02:44:46 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-607e705f745so314507b3.2;
        Thu, 15 Feb 2024 02:44:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8UUiOX/uAEZB1Cj3GiQtvuhi32KA/mxsZvhnQ41uSJ12aOyiFZShum2ZaYvRjJTcLH2Vo6OHfneHlPA+cJKRok01wOLZkBs4P78t7
X-Received: by 2002:a81:f00b:0:b0:607:9202:3fd9 with SMTP id
 p11-20020a81f00b000000b0060792023fd9mr1257053ywm.41.1707993886590; Thu, 15
 Feb 2024 02:44:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com> <20240212170423.2860895-13-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240212170423.2860895-13-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Feb 2024 11:44:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUqvotuuj6p7SNVo3X+BRvc0MAeQ9krLnJVQywr6rzOKg@mail.gmail.com>
Message-ID: <CAMuHMdUqvotuuj6p7SNVo3X+BRvc0MAeQ9krLnJVQywr6rzOKg@mail.gmail.com>
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

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Minor nits below.

> --- a/drivers/auxdisplay/ht16k33.c
> +++ b/drivers/auxdisplay/ht16k33.c
> @@ -445,18 +413,20 @@ static void ht16k33_seg7_update(struct work_struct =
*work)
>         struct ht16k33_priv *priv =3D container_of(work, struct ht16k33_p=
riv,
>                                                  work.work);
>         struct ht16k33_seg *seg =3D &priv->seg;
> +       struct linedisp *linedisp =3D &seg->linedisp;
> +       struct linedisp_map *map =3D linedisp->map;

struct linedisp_map *map =3D seg.linedisp->map;

as linedisp is not used below.

>         char *s =3D seg->curr;
>         uint8_t buf[9];
>
> -       buf[0] =3D map_to_seg7(&seg->map.seg7, *s++);
> +       buf[0] =3D map_to_seg7(&map->map.seg7, *s++);
>         buf[1] =3D 0;
> -       buf[2] =3D map_to_seg7(&seg->map.seg7, *s++);
> +       buf[2] =3D map_to_seg7(&map->map.seg7, *s++);
>         buf[3] =3D 0;
>         buf[4] =3D 0;
>         buf[5] =3D 0;
> -       buf[6] =3D map_to_seg7(&seg->map.seg7, *s++);
> +       buf[6] =3D map_to_seg7(&map->map.seg7, *s++);
>         buf[7] =3D 0;
> -       buf[8] =3D map_to_seg7(&seg->map.seg7, *s++);
> +       buf[8] =3D map_to_seg7(&map->map.seg7, *s++);
>
>         i2c_smbus_write_i2c_block_data(priv->client, 0, ARRAY_SIZE(buf), =
buf);
>  }
> @@ -466,17 +436,39 @@ static void ht16k33_seg14_update(struct work_struct=
 *work)
>         struct ht16k33_priv *priv =3D container_of(work, struct ht16k33_p=
riv,
>                                                  work.work);
>         struct ht16k33_seg *seg =3D &priv->seg;
> +       struct linedisp *linedisp =3D &seg->linedisp;
> +       struct linedisp_map *map =3D linedisp->map;

Likewise.

>         char *s =3D seg->curr;
>         uint8_t buf[8];
>
> -       put_unaligned_le16(map_to_seg14(&seg->map.seg14, *s++), buf);
> -       put_unaligned_le16(map_to_seg14(&seg->map.seg14, *s++), buf + 2);
> -       put_unaligned_le16(map_to_seg14(&seg->map.seg14, *s++), buf + 4);
> -       put_unaligned_le16(map_to_seg14(&seg->map.seg14, *s++), buf + 6);
> +       put_unaligned_le16(map_to_seg14(&map->map.seg14, *s++), buf + 0);
> +       put_unaligned_le16(map_to_seg14(&map->map.seg14, *s++), buf + 2);
> +       put_unaligned_le16(map_to_seg14(&map->map.seg14, *s++), buf + 4);
> +       put_unaligned_le16(map_to_seg14(&map->map.seg14, *s++), buf + 6);
>
>         i2c_smbus_write_i2c_block_data(priv->client, 0, ARRAY_SIZE(buf), =
buf);
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


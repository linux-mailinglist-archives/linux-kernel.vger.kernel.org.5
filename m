Return-Path: <linux-kernel+bounces-161432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D50548B4BE9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 15:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16415281CE1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 13:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34E56CDB4;
	Sun, 28 Apr 2024 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="md3BQSOT"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8519222064;
	Sun, 28 Apr 2024 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714309832; cv=none; b=nFK8kWHh6QbKGNkA8TGeSayZo9EXCDnsc6DpNyKV9b2HnG9PNwseFmH3DvsWeXL1Nm+io7dI0rDJzEXtT3kOMxv9WpiJ+mMteN68iV710A5zSis9vo9XyZPbq5WZapdvaHDVMMKeAE2pq0pIbMj9tXz8kwUHCLhIiWDaDZ5O9RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714309832; c=relaxed/simple;
	bh=lpiHaZYM8+2Y3uyoOmqD9y7aDSEx9LkyS3ICJpEoe0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aaiDtaOMAoinVS9fe/KRCi/OILnKtHHLPyI2nie8lSbyR00PeVSXbW0AsM+qat3G6cerIfK7kZyP2lt4VxYLid1MWOsSyLCxB6h6GvrZqwaa6CQezEJpk24Suotpx/mEeDSlOF2t1Lr/XGkTZNdhF0Acp0SUZpjvVxZrLrQUO70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=md3BQSOT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41adf155cffso26701745e9.2;
        Sun, 28 Apr 2024 06:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714309829; x=1714914629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhgCnJKPmb4AsGDiMaLDS91P6nngDSMLvYORDn1dWMg=;
        b=md3BQSOT/BuhGAqsgYYNRT5/NUfQH+SRm8msLIx0eKf3Yicg9jnJzaAhGu2WeLzx3J
         rwItg2ee2ZTiFTDNqZlLi9+f3CgRr5S00WZb4FJWp+K14Sd6kT+R5VajGLYlfmHHyYxb
         SBvPaZ2N3VY6mw++dhl8TGTGSz0OV2AD2mpJGpmtR/mjw+m2r6zRBvRYt1RikE0/Fjtp
         6eS3r8Ik1e8bVw6q09jKE9uf+XqtqIArEaoG0XfnjbvaMG9iMcI2uP5L9kIk4ejoyT3h
         sv74Wl5FR0+L0kqvfayxRiQkB0yzDrNq3Pu/AxzbA2ur3WnevrharB68oUwjrPn+saaH
         OFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714309829; x=1714914629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhgCnJKPmb4AsGDiMaLDS91P6nngDSMLvYORDn1dWMg=;
        b=h3Wnzl68GZxTGPhnFV53ZpJNOts4TQISFZyemRQWAk/6i3nb3EmYn30ktJwXFV029U
         ZaedUfn5IkONhEdZ/M7Uqy/F50sNTFk6nyv6RAn0IPTYScg5KEe3cjgUWLwHcez5xbN+
         pRzIsm31iXbIZk5RsqiwuHKwj2+AGHT6wvDO6VynDOTPLysQsH5vmQPiX10ET8XTpJpD
         2rnAa5Kcemdk+jCgvS6xUvsCsW4jW7xeM+NRpd7P69V5w9TVxjPWzUx+zlvZl4pziaLF
         6i0FDkgBs+4yZU6M3IZLBkOG/dzSgsG+apVEB68KURbF4xWfNBxSrGwI5ql0Z6afBxf5
         558g==
X-Forwarded-Encrypted: i=1; AJvYcCVD7Qeq1aBQGjfeH0F4bi0ldTU/RLakzZ2kaS9RRGwSFQWTPJe+Hb0C87Gk8SVbR1eIIpOMxNejA6YGOK6ADrVyI5RrlNB63GmBKVlN
X-Gm-Message-State: AOJu0YzKtlkyhlKBKlXwOQIUyBYC3AD65HUXeiaKsdBZeqKpD0zHfluR
	a3DD5gP1bU+cw1ZLEIBhuWp2gkyuxemBgh8Rbgi4keMaMat5DlX9RgdBWdCxo9LW/VqVj4OmLws
	AgHzB1iDjp7RGC+x4C3g5VTzjYGcZA0FVLfI=
X-Google-Smtp-Source: AGHT+IGEr1rIQGPa8PZm/eTLozJ+byjMjb58FS8WqwrAqnBspFu22WHkm6gbo6Q6KFIu3tcLzDtyiYk7OLnU3UHsU0U=
X-Received: by 2002:a05:600c:1988:b0:418:f826:58c3 with SMTP id
 t8-20020a05600c198800b00418f82658c3mr6752323wmq.15.1714309828506; Sun, 28 Apr
 2024 06:10:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240428125505.434962-1-skseofh@gmail.com>
In-Reply-To: <20240428125505.434962-1-skseofh@gmail.com>
From: DaeRo Lee <skseofh@gmail.com>
Date: Sun, 28 Apr 2024 22:10:17 +0900
Message-ID: <CAATEi5kd-XeZ359De36oLJeVvALsEM7oJ9zez_M=zivwrQw5yA@mail.gmail.com>
Subject: Re: [PATCH] of: of_reserved_mem: clean-up reserved memory with no-map
To: robh@kernel.org, saravanak@google.com, rppt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daero Lee <daero_le.lee@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 4=EC=9B=94 28=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 9:55, <=
skseofh@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> From: Daero Lee <daero_le.lee@samsung.com>
>
> In early_init_dt_reserve_memory we only add memory w/o no-map flag to
> memblock.reserved. But we need to add memory w/ no-map flag to
> memblock.reserved, because NOMAP and memblock.reserved are semantically
> different.
>
> Signed-off-by: Daero Lee <daero_le.lee@samsung.com>
> ---
>  drivers/of/of_reserved_mem.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 8236ecae2953..1c916da8adaf 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -91,7 +91,8 @@ static int __init early_init_dt_reserve_memory(phys_add=
r_t base,
>                     memblock_is_region_reserved(base, size))
>                         return -EBUSY;
>
> -               return memblock_mark_nomap(base, size);
> +               if (memblock_mark_nomap(base, size))
> +                       return;
Sorry. The return value is wrong.

Here is what I want to do:

--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -81,6 +81,7 @@ static void __init
fdt_reserved_mem_save_node(unsigned long node, const char *un
 static int __init early_init_dt_reserve_memory(phys_addr_t base,
                                               phys_addr_t size, bool nomap=
)
 {
+       int err =3D 0;
        if (nomap) {
                /*
                 * If the memory is already reserved (by another region), w=
e
@@ -91,7 +92,10 @@ static int __init
early_init_dt_reserve_memory(phys_addr_t base,
                    memblock_is_region_reserved(base, size))
                        return -EBUSY;

-               return memblock_mark_nomap(base, size);
+
+               err =3D memblock_mark_nomap(base, size);
+               if (err)
+                       return err;
        }
        return memblock_reserve(base, size);
 }


Regards,
DaeRo Lee


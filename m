Return-Path: <linux-kernel+bounces-18019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82522825742
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A4D1F225FE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA842E822;
	Fri,  5 Jan 2024 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtO2Ko+s"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782222E657
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50eaa8b447bso1901144e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 07:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704470124; x=1705074924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkvU2jP6F+TYCmXLML4f8jNr6z6Unk5LytAZK/GmgzY=;
        b=VtO2Ko+sxo1uY7QtLY6g0oykTZApEJL9H91cDqMP9Hk7vta/Q3JSJBdxRfp8lLNGlQ
         XHwKxgK3CJsoKzE6jbaJFB6Nl6vwELmpU6ii7CNCjK3bkkHVexj25oLPNxoJJ4Ylb/03
         xYS6kAjZNH/sOaODaDJvEt46nIEnemiCoAzX7sftbhcVaSnPJHQrDDuvDz0jhYTdg1k9
         Dzd4IBH/YdagnNzvXmHYbeBr/Ez9dduMQILymAz4SfvFOdr3/siERPOmTaa4GpwN5T2f
         G/0iMDZ4DZXLTQ1hWQAtmXH8zYjllL5y5JSXNOnjdOxHh/BTlD/YiwBQfqNm8no2+OMc
         dyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704470124; x=1705074924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkvU2jP6F+TYCmXLML4f8jNr6z6Unk5LytAZK/GmgzY=;
        b=sFbcee7CFL0Bmeq9DL15x3IVurJ2GyI/o4eharB8U7fDx4yJNd1oX1ZQA3vBF1MOpE
         Y0D8+QkgcOjSLX52Z4Lz6nLo+5dCpGp20Q2cNxnSO/eR6aYXovVvmGFirG233JJEPjto
         +8xNHJsa1EjrjMLW+UDqJ9UPDxRODjWeoIroWLpT2K7AQCr60Sy9a7BKbMh38vRcv5nQ
         8gxYBU3seincYi2GAP8fzs+imkzfAEqUBzD/dhghIOuxTmJvwVSzZUNrXotkfXPffElT
         H15vCnZvFX9vtiBJqwuLGrgyn7Bl9CTPtMBOz7EAe0ANYDik4mqNwlT/pX//t9Dpo6Q+
         ijTg==
X-Gm-Message-State: AOJu0YxRcGfWVp/qwDDVm67skmqkGXXr0xtHbnYt6ydicmxykymkjce7
	D4phAlMAvqb/UHN9Hk0SfxRF/TmdzvGGltMMy9A=
X-Google-Smtp-Source: AGHT+IHv+5fUTRxy54sAoptj93r7Tc0Y0iLJVqnR2jPYsRdXJi5cQajCPj0Gh3weNYeWfJ6GQ1ec7EXv1kaxFExX7Hc=
X-Received: by 2002:ac2:4254:0:b0:50e:cf8:b168 with SMTP id
 m20-20020ac24254000000b0050e0cf8b168mr513895lfl.208.1704470124225; Fri, 05
 Jan 2024 07:55:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231111143314.1518314-1-chentao@kylinos.cn>
In-Reply-To: <20231111143314.1518314-1-chentao@kylinos.cn>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 5 Jan 2024 16:55:11 +0100
Message-ID: <CAFLxGvzAncnBTEbHZ0pA-oF6n9P+wKFMugz8c+8UQKoPeBiYig@mail.gmail.com>
Subject: Re: [PATCH] ubifs: Remove unreachable code
To: Kunwu Chan <chentao@kylinos.cn>
Cc: richard@nod.at, Artem.Bityutskiy@nokia.com, kunwu.chan@hotmail.com, 
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 3:33=E2=80=AFPM Kunwu Chan <chentao@kylinos.cn> wro=
te:
>
> Because there is no break statement in the dead loop above,it is
> impossible to execute the 'err=3D0' statement.Delete the code that
> will never execute and initialize 'err' at the start of the function.
>
> Fixes: 6fb324a4b0c3 ("UBIFS: allocate ltab checking buffer on demand")
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  fs/ubifs/lpt_commit.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ubifs/lpt_commit.c b/fs/ubifs/lpt_commit.c
> index c4d079328b92..d4751628fe70 100644
> --- a/fs/ubifs/lpt_commit.c
> +++ b/fs/ubifs/lpt_commit.c
> @@ -1589,8 +1589,8 @@ static int dbg_is_node_dirty(struct ubifs_info *c, =
int node_type, int lnum,
>   */
>  static int dbg_check_ltab_lnum(struct ubifs_info *c, int lnum)
>  {
> -       int err, len =3D c->leb_size, dirty =3D 0, node_type, node_num, n=
ode_len;
> -       int ret;
> +       int len =3D c->leb_size, dirty =3D 0, node_type, node_num, node_l=
en;
> +       int ret, err =3D 0;
>         void *buf, *p;

Now it is still dead code.
A few lines later err will be used for the result of ubifs_leb_read().
So you can remove the initialization of err completely.

>         if (!dbg_is_chk_lprops(c))
> @@ -1646,7 +1646,6 @@ static int dbg_check_ltab_lnum(struct ubifs_info *c=
, int lnum)
>                 len -=3D node_len;
>         }
>
> -       err =3D 0;
>  out:
>         vfree(buf);
>         return err;
> --
> 2.34.1
>


--=20
Thanks,
//richard


Return-Path: <linux-kernel+bounces-9135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C75B81C120
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE0A1C24AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6333768F7;
	Thu, 21 Dec 2023 22:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BY86XJdc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677AA78E8D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 22:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-db99bad7745so1311236276.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 14:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703198072; x=1703802872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fW9u13R2m/seX4C40s0cSa+YFoN5vjey1nP3znUtySI=;
        b=BY86XJdcs2ufSEr0XnK/ainTdjVE0DWqkNbXiaIf3s0ph6mIl+EF/BXDhgqyP1quyJ
         50X9EnA7SW0o75uVllFv/4g7zMQme+O55dx9iuwo+1uF6moymbOSj0X2iN4G/kNrEZjY
         wUsmQ7mFHUeV/5e+NmyK62I2tXwpESXzdGtIGoVm7J0DVNgViWxtdu/LJm/eGi8SQDhU
         1fgCwoPpeC8sVRQV+ZCm9JQzCgEVA3FjrVSDU5oQ0cjOE3K/WZNUn1l2IPEVGIkCLeGj
         /0fO08nVuA6y7r3VnC3DeH7tkduaNG+xd6pMuUMv0aBpylheEdvs/SSQy3qiynEMEVNZ
         uIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703198072; x=1703802872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fW9u13R2m/seX4C40s0cSa+YFoN5vjey1nP3znUtySI=;
        b=mjyJbNhQBKqGnP5T0rDbHMWVkDKKq4u8F20gv5i4RAgBKlp7R60HTe1e9MzJP+oiYJ
         mJMJ6D/sbWHXH/XI2KzjGaA9Q4qG9/z6/+GBln0IozprMFMdWZI6aaMBwLGR/SAbWXlf
         lH0EGE4SYLoHxo1BisSOthHVjSWbb+M8DG/5rskHD3ff3SBNB8BG3xqaPnYpausHXt4Y
         xMmr+W048SNLu6ozfKvjeRzkKGLDOvIol3k48HSOWTkGS4hF/Elp4gf4CPLoUe3nW/B8
         IuZcXVOqBqQzXfGO9BPzi6+BR/lzm5MThGLOgPqTPcm7zzPNhCLwyUZRpzxqkdUWdOOE
         dn/w==
X-Gm-Message-State: AOJu0Yy1XuC5J++LOQn7wwSyQ/7/4jr5amJWlAR07lE4StppdZT1TN8t
	yoALKJU3w6ibETATZo1/XleMuynrYca+MoLibu3S65fmKXNi
X-Google-Smtp-Source: AGHT+IG1hO7YJPbuAC/zsS203ayV7bqgFA92mRNrD+2UvRMtUEj3RH3+v5y706hPcUE91g3GRexn4caKf9f5yey0beA=
X-Received: by 2002:a25:6602:0:b0:db7:dacf:2f21 with SMTP id
 a2-20020a256602000000b00db7dacf2f21mr413450ybc.104.1703198072420; Thu, 21 Dec
 2023 14:34:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221-lsm-fix-counted-by-v1-1-12cc27597cdf@kernel.org>
In-Reply-To: <20231221-lsm-fix-counted-by-v1-1-12cc27597cdf@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 21 Dec 2023 17:34:21 -0500
Message-ID: <CAHC9VhRwUJkJJVnytxbME4ycmd3BuoLhr-V6xjFWau7eQxeGiw@mail.gmail.com>
Subject: Re: [PATCH] lsm: Add a __counted_by() annotation to lsm_ctx.ctx
To: Mark Brown <broonie@kernel.org>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Aishwarya TCV <aishwarya.tcv@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 3:39=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> The ctx in struct lsm_ctx is an array of size ctx_len, tell the compiler
> about this using __counted_by() where supported to improve the ability to
> detect overflow issues.
>
> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  include/uapi/linux/lsm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> index f0386880a78e..4150333d224f 100644
> --- a/include/uapi/linux/lsm.h
> +++ b/include/uapi/linux/lsm.h
> @@ -36,7 +36,7 @@ struct lsm_ctx {
>         __u64 flags;
>         __u64 len;
>         __u64 ctx_len;
> -       __u8 ctx[];
> +       __u8 ctx[] __counted_by(ctx_len);
>  };

We also now need to include stddef.h in lsm.h for the __counted_by() macro,=
 yes?

--=20
paul-moore.com


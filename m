Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9616676015C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjGXVlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjGXVla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:41:30 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BEB126
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:41:29 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a426e70575so2582280b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690234888; x=1690839688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sV2E65JaJ+s2Te44qQqNGa/qcFLI/Mc9cc9UlCLk1yo=;
        b=GPueKY01EuAz5CMCO8DVmG7WZNEehAvdLh3dPoiaOC/5mxUocQPPqsLbjmnwj51vZM
         XTL5/+qsDQ6iIX2BfIbktDLUjYGzMIIm3YXDIssjjMi57RiPbyQhbECcSJf/Ly5fXRoj
         TcduYsi+raYIO5ML3EHpw18e2XErIPQdsq6usxjQcO3qfGCYXlF5+fvERuB7LyWzUPN/
         HaL5rIb0HMpqVtUOn5R7WeU4y3z+TabHogMfV7tFbiZLxtLtRDzbWzsJAjvhSwtR3HW3
         /EyICUStP8/7c3+iZUN4dyZMHDgDJxNV+VzJKYsGfbzCDndI0RwXtFeyBMD5GdNGbXNF
         eAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690234888; x=1690839688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sV2E65JaJ+s2Te44qQqNGa/qcFLI/Mc9cc9UlCLk1yo=;
        b=EzWc5b4qVPZtdWj6bZLkdLYFOil6hjYpuP9oFgtAdiceCQeClxxv9RqG2tY2XYmI/L
         85fE7/QeQNewcvW2fsoQwDXLDbXGXb/k2qaz2DxBT4zV7HV6rMxzeSmqNQdPB9EceEfK
         I/dLVOszQlNdx0gZkk8y2tRv7hXwRYYbI2zcxh3FKjmfA3QclZ4ovjGikAN6vNUKOYyj
         3UD4M5rJm8pn9xSjXUL5Dy/RlNM71y+s1nwl9TmSSo+0U+TH3hAhFdsmB40q5Rqy0A/g
         K533uyFue6sHtHmG96lj4Yr0qGmrAUUkfxF8MWIgKoizN0a5fxbTj4VxdGK9QOusv5FK
         dD+g==
X-Gm-Message-State: ABy/qLbiPT7ogNvzMfaD6H2N7puZr/gpZB7Atc1ZxlQeMOQBDB6n811J
        SVrIaz/a2qz/PphUt0um+nvw/SgPEt3A8PLy6xKAPb6P
X-Google-Smtp-Source: APBJJlGRK3JQkS6TAmrMGjYqZYkyOwEqDWLq903A43VQpZ6r+BMC+w/yDYw1dk8djnSIsynnaK1MgbuLQTKxNiQ3j4o=
X-Received: by 2002:aca:1e0d:0:b0:3a3:fa64:bb8d with SMTP id
 m13-20020aca1e0d000000b003a3fa64bb8dmr7967436oic.10.1690234888364; Mon, 24
 Jul 2023 14:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230724033939.8147-1-xujianghui@cdjrlc.com> <f558b5bf6037d0e0eadcaee9448ad4c6@208suo.com>
In-Reply-To: <f558b5bf6037d0e0eadcaee9448ad4c6@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 24 Jul 2023 17:41:17 -0400
Message-ID: <CADnq5_ONmrbaSwjzcoQ17qW8F8ShH3xgz58vv=uciVu8aePZ7g@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: that open brace { should be on the previous line
To:     sunran001@208suo.com
Cc:     alexander.deucher@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  thanks!

Alex

On Sun, Jul 23, 2023 at 11:40=E2=80=AFPM <sunran001@208suo.com> wrote:
>
> ERROR: that open brace { should be on the previous line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   drivers/gpu/drm/radeon/rv770_smc.c | 36 ++++++++++--------------------
>   1 file changed, 12 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/rv770_smc.c
> b/drivers/gpu/drm/radeon/rv770_smc.c
> index 45575c0d0a1d..09fa7f5e7c41 100644
> --- a/drivers/gpu/drm/radeon/rv770_smc.c
> +++ b/drivers/gpu/drm/radeon/rv770_smc.c
> @@ -34,8 +34,7 @@
>   #define FIRST_SMC_INT_VECT_REG 0xFFD8
>   #define FIRST_INT_VECT_S19     0xFFC0
>
> -static const u8 rv770_smc_int_vectors[] =3D
> -{
> +static const u8 rv770_smc_int_vectors[] =3D {
>         0x08, 0x10, 0x08, 0x10,
>         0x08, 0x10, 0x08, 0x10,
>         0x08, 0x10, 0x08, 0x10,
> @@ -54,8 +53,7 @@ static const u8 rv770_smc_int_vectors[] =3D
>         0x03, 0x51, 0x03, 0x51
>   };
>
> -static const u8 rv730_smc_int_vectors[] =3D
> -{
> +static const u8 rv730_smc_int_vectors[] =3D {
>         0x08, 0x15, 0x08, 0x15,
>         0x08, 0x15, 0x08, 0x15,
>         0x08, 0x15, 0x08, 0x15,
> @@ -74,8 +72,7 @@ static const u8 rv730_smc_int_vectors[] =3D
>         0x03, 0x56, 0x03, 0x56
>   };
>
> -static const u8 rv710_smc_int_vectors[] =3D
> -{
> +static const u8 rv710_smc_int_vectors[] =3D {
>         0x08, 0x04, 0x08, 0x04,
>         0x08, 0x04, 0x08, 0x04,
>         0x08, 0x04, 0x08, 0x04,
> @@ -94,8 +91,7 @@ static const u8 rv710_smc_int_vectors[] =3D
>         0x03, 0x51, 0x03, 0x51
>   };
>
> -static const u8 rv740_smc_int_vectors[] =3D
> -{
> +static const u8 rv740_smc_int_vectors[] =3D {
>         0x08, 0x10, 0x08, 0x10,
>         0x08, 0x10, 0x08, 0x10,
>         0x08, 0x10, 0x08, 0x10,
> @@ -114,8 +110,7 @@ static const u8 rv740_smc_int_vectors[] =3D
>         0x03, 0x51, 0x03, 0x51
>   };
>
> -static const u8 cedar_smc_int_vectors[] =3D
> -{
> +static const u8 cedar_smc_int_vectors[] =3D {
>         0x0B, 0x05, 0x0B, 0x05,
>         0x0B, 0x05, 0x0B, 0x05,
>         0x0B, 0x05, 0x0B, 0x05,
> @@ -134,8 +129,7 @@ static const u8 cedar_smc_int_vectors[] =3D
>         0x04, 0xF6, 0x04, 0xF6
>   };
>
> -static const u8 redwood_smc_int_vectors[] =3D
> -{
> +static const u8 redwood_smc_int_vectors[] =3D {
>         0x0B, 0x05, 0x0B, 0x05,
>         0x0B, 0x05, 0x0B, 0x05,
>         0x0B, 0x05, 0x0B, 0x05,
> @@ -154,8 +148,7 @@ static const u8 redwood_smc_int_vectors[] =3D
>         0x04, 0xF6, 0x04, 0xF6
>   };
>
> -static const u8 juniper_smc_int_vectors[] =3D
> -{
> +static const u8 juniper_smc_int_vectors[] =3D {
>         0x0B, 0x05, 0x0B, 0x05,
>         0x0B, 0x05, 0x0B, 0x05,
>         0x0B, 0x05, 0x0B, 0x05,
> @@ -174,8 +167,7 @@ static const u8 juniper_smc_int_vectors[] =3D
>         0x04, 0xF6, 0x04, 0xF6
>   };
>
> -static const u8 cypress_smc_int_vectors[] =3D
> -{
> +static const u8 cypress_smc_int_vectors[] =3D {
>         0x0B, 0x05, 0x0B, 0x05,
>         0x0B, 0x05, 0x0B, 0x05,
>         0x0B, 0x05, 0x0B, 0x05,
> @@ -194,8 +186,7 @@ static const u8 cypress_smc_int_vectors[] =3D
>         0x04, 0xF6, 0x04, 0xF6
>   };
>
> -static const u8 barts_smc_int_vectors[] =3D
> -{
> +static const u8 barts_smc_int_vectors[] =3D {
>         0x0C, 0x14, 0x0C, 0x14,
>         0x0C, 0x14, 0x0C, 0x14,
>         0x0C, 0x14, 0x0C, 0x14,
> @@ -214,8 +205,7 @@ static const u8 barts_smc_int_vectors[] =3D
>         0x05, 0x0A, 0x05, 0x0A
>   };
>
> -static const u8 turks_smc_int_vectors[] =3D
> -{
> +static const u8 turks_smc_int_vectors[] =3D {
>         0x0C, 0x14, 0x0C, 0x14,
>         0x0C, 0x14, 0x0C, 0x14,
>         0x0C, 0x14, 0x0C, 0x14,
> @@ -234,8 +224,7 @@ static const u8 turks_smc_int_vectors[] =3D
>         0x05, 0x0A, 0x05, 0x0A
>   };
>
> -static const u8 caicos_smc_int_vectors[] =3D
> -{
> +static const u8 caicos_smc_int_vectors[] =3D {
>         0x0C, 0x14, 0x0C, 0x14,
>         0x0C, 0x14, 0x0C, 0x14,
>         0x0C, 0x14, 0x0C, 0x14,
> @@ -254,8 +243,7 @@ static const u8 caicos_smc_int_vectors[] =3D
>         0x05, 0x0A, 0x05, 0x0A
>   };
>
> -static const u8 cayman_smc_int_vectors[] =3D
> -{
> +static const u8 cayman_smc_int_vectors[] =3D {
>         0x12, 0x05, 0x12, 0x05,
>         0x12, 0x05, 0x12, 0x05,
>         0x12, 0x05, 0x12, 0x05,

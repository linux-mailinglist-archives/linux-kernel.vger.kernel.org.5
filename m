Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1047CFCC6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346197AbjJSOcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbjJSOcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:32:42 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FDF19BA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:31:47 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c9b70b9656so53601755ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697725907; x=1698330707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIi5sl7kotf6K4zebahXrePOnqvZwmDyPuUbQKhEpnY=;
        b=DmWQkwvPkYojGMkbaeaACKz0u0I7ynfk+ssHQuK4vCwDDHODXHDkY9APjTyMKAaSd5
         ZlKwyztpwjFX5tIUG3Csdwof8ZiMWzvqeZSCrRZtdNy/JNrXWy47by5UVoqU94uEfNsl
         84k/jiDdQl9CSPLdYo/tm+uHzV8+aJ8KOkoxA1mhTfJLIp+FFK015Qu92nqoqwPQrunB
         hjsOCeS5VLDi2AFd6PE7wS/Q8MiZMwIGxX0oYPq9zBqQgS8QErOd4Y3zatBgIHIxbVHj
         ZpzFqr/lXXthwbOW7ytoNDhK3EYf77QYKmEN5F/y9ju/B0xSUyIBBL88ShgQ3rHP/BGT
         WwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697725907; x=1698330707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIi5sl7kotf6K4zebahXrePOnqvZwmDyPuUbQKhEpnY=;
        b=ZRuZX6fiSr11eK/Z7+Qv4++TNZzumorbS5ud/zOraHmaxAPRms/jCfuPjqHbpR/8tj
         MuwdFCv7hejZ2Ob1R7hN+E2e/RNNTd08/msFaRqjKPrIJyIOEIHe8IfUn2CExiXoAN3p
         DJVE9YDJm2Pa+c78hEWQtkcB9ZrprpmAMjZfp7sM4UeTCpEU6d0DI4a/qETKgnUYishN
         q3r5F+StpqVKtB2o1e9HqE0HT59MFsycFaATIpM+NlNh6d89XlK5fcnqyykGJGiDlPTF
         cf2Y039uNQGlvFWowYbZAiwmRYpK20QnO/JLV24t79qs6/9aWqwKAc3n3lzYygFWOAV7
         3gnQ==
X-Gm-Message-State: AOJu0YzKaJDGfkf1r1WR//notqvSlxn26d4E0YLN/lVS+lMmAYyR7H6N
        A1YIc5rcd+3eSDO3IYgq3uZ0I/uMrO4p3g8rqTxRgA==
X-Google-Smtp-Source: AGHT+IG/GJqdnqvx4V9L4BUA/fWFsRzxuErdFglDBcvKmdt4ZRtxaP1ns06xq1OdK3DtBHOoyVfRHYqF5bvkZSe5uxs=
X-Received: by 2002:a17:902:db0b:b0:1c8:a06e:fce9 with SMTP id
 m11-20020a170902db0b00b001c8a06efce9mr2922496plx.52.1697725907291; Thu, 19
 Oct 2023 07:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231019100639.4026283-1-andre.draszik@linaro.org>
In-Reply-To: <20231019100639.4026283-1-andre.draszik@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 19 Oct 2023 09:31:36 -0500
Message-ID: <CAPLW+4=oY1PjTTbsLq6QL5k37CZnqY1NprC1AxyAMkO4zBBDsQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] tty: serial: samsung: drop earlycon support for
 unsupported platforms
To:     =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        alim.akhtar@samsung.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 5:06=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik@l=
inaro.org> wrote:
>
> Commit 1ea35b355722 ("ARM: s3c: remove s3c24xx specific hacks") removed
> support here for several old platforms, but kept support for earlycon
> for those same platforms.
>
> As earlycon support for otherwise unsupported platforms doesn't seem to
> be useful, just drop it as well.
>
> Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/tty/serial/samsung_tty.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index 6b8d4b4402e9..a74ecc78f4e0 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -2735,17 +2735,7 @@ static struct samsung_early_console_data s3c2410_e=
arly_console_data =3D {
>         .rxfifo_mask =3D S3C2410_UFSTAT_RXFULL | S3C2410_UFSTAT_RXMASK,
>  };
>
> -static int __init s3c2410_early_console_setup(struct earlycon_device *de=
vice,
> -                                             const char *opt)
> -{
> -       device->port.private_data =3D &s3c2410_early_console_data;
> -       return samsung_early_console_setup(device, opt);
> -}
> -
> -OF_EARLYCON_DECLARE(s3c2410, "samsung,s3c2410-uart",
> -                       s3c2410_early_console_setup);
> -
> -/* S3C2412, S3C2440, S3C64xx */
> +/* S3C64xx */
>  static struct samsung_early_console_data s3c2440_early_console_data =3D =
{
>         .txfull_mask =3D S3C2440_UFSTAT_TXFULL,
>         .rxfifo_mask =3D S3C2440_UFSTAT_RXFULL | S3C2440_UFSTAT_RXMASK,
> @@ -2758,10 +2748,6 @@ static int __init s3c2440_early_console_setup(stru=
ct earlycon_device *device,
>         return samsung_early_console_setup(device, opt);
>  }
>
> -OF_EARLYCON_DECLARE(s3c2412, "samsung,s3c2412-uart",
> -                       s3c2440_early_console_setup);
> -OF_EARLYCON_DECLARE(s3c2440, "samsung,s3c2440-uart",
> -                       s3c2440_early_console_setup);
>  OF_EARLYCON_DECLARE(s3c6400, "samsung,s3c6400-uart",
>                         s3c2440_early_console_setup);
>
> --
> 2.40.1
>
>

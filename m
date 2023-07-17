Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895FF755CE7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjGQHai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjGQHag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:30:36 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22883F7;
        Mon, 17 Jul 2023 00:30:35 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so5984525a12.1;
        Mon, 17 Jul 2023 00:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689579033; x=1692171033;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4GVZUqLECesnO++vcJqOUpxug7iu+l6bIIX+pZ/7ds=;
        b=pa3cxSO43O5rhLwbjslcgkooBp6j/b2jMD3FV3oA2MtfQ7B6sJaLtbIU/6Tu3bjR+U
         uA/7f9/iNcqN6eJNAUiqDoSifOCFixsWGJmj8tV8ysY8efeKAEZNzbbNEE8MXoHNPgYd
         awFph86iUycJHPh2gBjUmnHQcFbZVsx0almr3IlatF4Ovy2v3TuwIyEfpRCiJQBSgJUW
         NrCMnW7HUD8t22eZTy5eZlbp4KWZKvb+kp9bUbbY7iK/JxdTU188qhNecNivpkHSd3fF
         K0khN+EVLRQjjY4v0VPeRmGxQd9gnJ77kAk3sxfo6U4fiJmW32TWgxInx/k0H75/JH8U
         o/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689579033; x=1692171033;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4GVZUqLECesnO++vcJqOUpxug7iu+l6bIIX+pZ/7ds=;
        b=QSC3gueemqHE8+svPMJhxXL1nTOXzKCLkLdiAIkzSDA0em8w5RqeLc3Fpqmt5bRaBJ
         4YDmzONFo++64AIsSm67WlpY6WmGFI7dEU+VayeNRxVHWK0a21nSPwX6J21V7yssBp5v
         Jdkck88gkMzhItvbWbfsFzoW8+Qb2RDPj0+//csl7AhkEaWFCwwCrNuH4XfPRCTVZq6C
         uJleIcjRVQgO1asfROCHMoTFbjOgoRq5ZLpp0CKdBgM+IwEELJiB+9q20/2Wyhsmcsmq
         T9aNpsgl5J0QI9KfW3M1Pt/cOFk1gV7NDNCI+Fqkid82zFqa8JWcQiaOqv6zbZDb354C
         qSSg==
X-Gm-Message-State: ABy/qLZr3VfU/LMD2TmJyr1jpTdmwjKbdeZR85PYIYJpl6dY+TdX62Py
        lfkzRMcWeGgz/F6HiWP5Z/QcejgMjEo=
X-Google-Smtp-Source: APBJJlEKebMHwsWjis1A2PlL7OiBb4/ylj2V9P4gqCP/xh3JvCKXin32nhBCnErW9CQqrvtJKfUALQ==
X-Received: by 2002:a17:906:46c6:b0:982:89b3:8650 with SMTP id k6-20020a17090646c600b0098289b38650mr9909495ejs.64.1689579033385;
        Mon, 17 Jul 2023 00:30:33 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id b21-20020a1709065e5500b009934855d8f1sm8793395eju.34.2023.07.17.00.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 00:30:33 -0700 (PDT)
Date:   Mon, 17 Jul 2023 09:30:31 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     ldewangan@nvidia.com, broonie@kernel.org, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: tegra20-sflash: Fix signedness bug in
 tegra_sflash_probe
Message-ID: <ZLTuFyYewf8pUiRw@orome>
References: <tencent_4D4974DE0CD4266C25819179B42888A3E20A@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9cyN+Lexs+8sRPGX"
Content-Disposition: inline
In-Reply-To: <tencent_4D4974DE0CD4266C25819179B42888A3E20A@qq.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9cyN+Lexs+8sRPGX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 15, 2023 at 05:53:56PM +0800, Zhang Shurong wrote:
> The "tsd->irq" variable is unsigned so this error handling
> code will not work.
>=20
> Fix this by adding error handling statement

This doesn't really make sense. First you say that the error handling
will not work and then you say you fix that by adding error handling.

So the bug here is that there is no error checking in the first place,
so you should probably reword that commit message.

Thierry

>=20
> Fixes: 8528547bcc33 ("spi: tegra: add spi driver for sflash controller")
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> ---
>  drivers/spi/spi-tegra20-sflash.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-s=
flash.c
> index 4286310628a2..4c18337de813 100644
> --- a/drivers/spi/spi-tegra20-sflash.c
> +++ b/drivers/spi/spi-tegra20-sflash.c
> @@ -455,7 +455,11 @@ static int tegra_sflash_probe(struct platform_device=
 *pdev)
>  		goto exit_free_master;
>  	}
> =20
> -	tsd->irq =3D platform_get_irq(pdev, 0);
> +	ret =3D platform_get_irq(pdev, 0);
> +	if (ret < 0)
> +		goto exit_free_master;
> +
> +	tsd->irq =3D ret;
>  	ret =3D request_irq(tsd->irq, tegra_sflash_isr, 0,
>  			dev_name(&pdev->dev), tsd);
>  	if (ret < 0) {
> --=20
> 2.30.2
>=20

--9cyN+Lexs+8sRPGX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmS07hQACgkQ3SOs138+
s6FWsw//ejk+7MtZ9+XJ1pY/45JPEu2E9UgxMwjg2ZEIprSO5LM/gofh7Y0MrKTU
2yv0deTR+tTqN7Ks8gMLjyt+FkA2wu5KjiMZpuI9YNGZwvbugKL/m4KWsTosXpso
s5puXPqLAdschSFrIG3L7K+N/G5yziMT6MgZuLhF0KT9HYJE057ABc9ZjjYm+3pq
6yFubaU7Q5xNB0C3+91Fs71ZB6hoxCYg/3Yw5/WP4byzFXwalM/RftBAHyQlZ6fE
I+uKpvsuDpnSsCi3iwHPCXMmXmjaiH8Td1lgusGeQUG7taIp7a4stZ09M8vj+doK
QZAQljCVKX4lA4CB6WjGUXUEUq5GNsdsDbdhD80RJuh82hZ/ekkG9hGoAL+WV1wm
Hs1AsJr8QyfeQVLL01h0wU5sqDIAIZXjEXEC99HP/GV5H70qu1R1DSXZMOHjPQrP
BAzlKxrHB1OI6V8EXyq17jkNxrr9J/tk8G3CtQQMt6TEXhq6750MxLeqVUYhaemY
mynHAXwj5rElzdyQqWQdbg+QJQjDkQJTr56LF6bS8BYYabQAQkgK4uDbGEnPVHpi
Lj4vJBnGzmOx3MhsSWbg3cK6YWIfza0Nd6pPUv9tQiRZwtkFujHtNXa9VIfFXSCl
IwekZaVsY3aC/3FHylXy5KLTRDQFZg9D1iEGWPezgXuTbj7s8K0=
=tho+
-----END PGP SIGNATURE-----

--9cyN+Lexs+8sRPGX--

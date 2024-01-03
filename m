Return-Path: <linux-kernel+bounces-15844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2CE823435
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA890286D3F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797631C696;
	Wed,  3 Jan 2024 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e7llcwng"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1591C691
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2041ed74956so286240fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 10:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704305877; x=1704910677; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qxpZGm1LUW9qcqNNqbb0vBtBxdxzxJTmCdbStl0FKDI=;
        b=e7llcwngt36r3BS/gdyAmoxfYNJj3xKmkM6n0WiG4d8daTWubS8MZaiCKvY6u4aSm6
         eYw85/iVELFbIyhJTXdq4EEJxutwtbnyyj1qGomvS+tiAct7hm9Sl3wEe9CqBomhYaRD
         fRlim3KBXLI6REB5NQPxZEKPf1N9MQfK+jrm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704305877; x=1704910677;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qxpZGm1LUW9qcqNNqbb0vBtBxdxzxJTmCdbStl0FKDI=;
        b=SiUtRCPtey06njQ9w//zashs63JhB8osjmnyBIAoDUMHSL13ncadWnE4dzsON8P8lY
         KtW9895DNAmM1u8pO0qVk6p7oikKG2k5x+DLDFc/gJC37nnEwL+PT/NInVIjjBELV7WW
         yPT1zDJy1bdC07eBDw2/b1Vf/jS3s/HQC/SnGgRKYiDwELL9NLDFNeMzdkYfXfo2dIj5
         E/7vG9C8xNa4Wa8cJHAGIyNo3FINUQz2HVHPKWbJYwoub47qAsc+X6gbzGj9ULc7asLm
         +rpuxWYFxgb47EYOrl4NAzZEnsER1CdtBkmsuSbbOf6hOAVbLb6oiE80WA45QtogHDeO
         +sQQ==
X-Gm-Message-State: AOJu0YxB+m27IIyVjGybN0AIdPnyx6KPEk5DsNOJ5oYeDXfgukLTYEPy
	6+6sZPZOglFrmDWvk68F+Bz9z4M724QbnOZ1cHZCYGhtBK1d
X-Google-Smtp-Source: AGHT+IFOe9hxXvX0ghoyBjoTJNLQIqDMaI9Xs1rmLcqDIXd8o72p/PKtSB9ivgl0jGDuy4Zxh+buv5SJJrWtn1PxGUk=
X-Received: by 2002:a05:6870:7b52:b0:204:347a:8175 with SMTP id
 ji18-20020a0568707b5200b00204347a8175mr581796oab.46.1704305877112; Wed, 03
 Jan 2024 10:17:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231229145232.6163-1-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20231229145232.6163-1-ilpo.jarvinen@linux.intel.com>
From: Ray Jui <ray.jui@broadcom.com>
Date: Wed, 3 Jan 2024 10:17:45 -0800
Message-ID: <CAJ8Y1dRSOdYesQ5cG1JTDc2W-mdz-OvcJBBTYz3X-EiUQPS8=g@mail.gmail.com>
Subject: Re: [PATCH 1/1] net: mdio: mux-bcm-iproc: Use alignment helpers and SZ_4K
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000069a3b1060e0ea2aa"

--00000000000069a3b1060e0ea2aa
Content-Type: multipart/alternative; boundary="00000000000064fb11060e0ea270"

--00000000000064fb11060e0ea270
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 6:53=E2=80=AFAM Ilpo J=C3=A4rvinen <ilpo.jarvinen@l=
inux.intel.com>
wrote:

> Instead of open coding, use IS_ALIGNED() and ALIGN_DOWN() when dealing
> with alignment. Replace also literals with SZ_4K.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/net/mdio/mdio-mux-bcm-iproc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/mdio/mdio-mux-bcm-iproc.c
> b/drivers/net/mdio/mdio-mux-bcm-iproc.c
> index a750bd4c77a0..1ce7d67ba72e 100644
> --- a/drivers/net/mdio/mdio-mux-bcm-iproc.c
> +++ b/drivers/net/mdio/mdio-mux-bcm-iproc.c
> @@ -2,6 +2,7 @@
>  /*
>   * Copyright 2016 Broadcom
>   */
> +#include <linux/align.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> @@ -11,6 +12,7 @@
>  #include <linux/of_mdio.h>
>  #include <linux/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/sizes.h>
>
>  #define MDIO_RATE_ADJ_EXT_OFFSET       0x000
>  #define MDIO_RATE_ADJ_INT_OFFSET       0x004
> @@ -220,12 +222,12 @@ static int mdio_mux_iproc_probe(struct
> platform_device *pdev)
>         md->base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res=
);
>         if (IS_ERR(md->base))
>                 return PTR_ERR(md->base);
> -       if (res->start & 0xfff) {
> +       if (!IS_ALIGNED(res->start, SZ_4K)) {
>                 /* For backward compatibility in case the
>                  * base address is specified with an offset.
>                  */
>                 dev_info(&pdev->dev, "fix base address in dt-blob\n");
> -               res->start &=3D ~0xfff;
> +               res->start =3D ALIGN_DOWN(res->start, SZ_4K);
>                 res->end =3D res->start + MDIO_REG_ADDR_SPACE_SIZE - 1;
>         }
>
> --
> 2.39.2
>

Acked-by: Ray Jui <ray.jui@broadcom.com>

Thanks.

--00000000000064fb11060e0ea270
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Dec 29, 2023 at 6:53=E2=80=AF=
AM Ilpo J=C3=A4rvinen &lt;<a href=3D"mailto:ilpo.jarvinen@linux.intel.com">=
ilpo.jarvinen@linux.intel.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">Instead of open coding, use IS_ALIGNED() and A=
LIGN_DOWN() when dealing<br>
with alignment. Replace also literals with SZ_4K.<br>
<br>
Signed-off-by: Ilpo J=C3=A4rvinen &lt;<a href=3D"mailto:ilpo.jarvinen@linux=
.intel.com" target=3D"_blank">ilpo.jarvinen@linux.intel.com</a>&gt;<br>
---<br>
=C2=A0drivers/net/mdio/mdio-mux-bcm-iproc.c | 6 ++++--<br>
=C2=A01 file changed, 4 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/net/mdio/mdio-mux-bcm-iproc.c b/drivers/net/mdio/mdio-=
mux-bcm-iproc.c<br>
index a750bd4c77a0..1ce7d67ba72e 100644<br>
--- a/drivers/net/mdio/mdio-mux-bcm-iproc.c<br>
+++ b/drivers/net/mdio/mdio-mux-bcm-iproc.c<br>
@@ -2,6 +2,7 @@<br>
=C2=A0/*<br>
=C2=A0 * Copyright 2016 Broadcom<br>
=C2=A0 */<br>
+#include &lt;linux/align.h&gt;<br>
=C2=A0#include &lt;linux/clk.h&gt;<br>
=C2=A0#include &lt;linux/delay.h&gt;<br>
=C2=A0#include &lt;linux/device.h&gt;<br>
@@ -11,6 +12,7 @@<br>
=C2=A0#include &lt;linux/of_mdio.h&gt;<br>
=C2=A0#include &lt;linux/phy.h&gt;<br>
=C2=A0#include &lt;linux/platform_device.h&gt;<br>
+#include &lt;linux/sizes.h&gt;<br>
<br>
=C2=A0#define MDIO_RATE_ADJ_EXT_OFFSET=C2=A0 =C2=A0 =C2=A0 =C2=A00x000<br>
=C2=A0#define MDIO_RATE_ADJ_INT_OFFSET=C2=A0 =C2=A0 =C2=A0 =C2=A00x004<br>
@@ -220,12 +222,12 @@ static int mdio_mux_iproc_probe(struct platform_devic=
e *pdev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 md-&gt;base =3D devm_platform_get_and_ioremap_r=
esource(pdev, 0, &amp;res);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(md-&gt;base))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return PTR_ERR(md-&=
gt;base);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (res-&gt;start &amp; 0xfff) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!IS_ALIGNED(res-&gt;start, SZ_4K)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* For backward com=
patibility in case the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* base addres=
s is specified with an offset.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info(&amp;pdev-=
&gt;dev, &quot;fix base address in dt-blob\n&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res-&gt;start &amp;=
=3D ~0xfff;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res-&gt;start =3D A=
LIGN_DOWN(res-&gt;start, SZ_4K);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res-&gt;end =3D res=
-&gt;start + MDIO_REG_ADDR_SPACE_SIZE - 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-- <br>
2.39.2<br></blockquote><div><br></div><div>Acked-by: Ray Jui &lt;<a href=3D=
"mailto:ray.jui@broadcom.com">ray.jui@broadcom.com</a>&gt;</div><div><br></=
div><div>Thanks.=C2=A0</div></div></div>

--00000000000064fb11060e0ea270--

--00000000000069a3b1060e0ea2aa
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
YVhHgdTTB3aAzFyz4UFRLwxCzIG7d7GIiB9MoLImssS08R5WQ5EJCd1fAF6iefLupAn/plPmn2w0
GF8bLF/FhwOn8jObLW5pQiKhjQSv3QIDAQABo4IB1TCCAdEwDgYDVR0PAQH/BAQDAgWgMIGjBggr
BgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9j
YWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8v
b2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBE
MEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20v
cmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2Jh
bHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAfBgNVHREEGDAWgRRyYXku
anVpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdb
NHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUIScG7uNJuCYBQieQC+eonQS9tdkwDQYJKoZIhvcNAQEL
BQADggEBAGLwq/sDtwLmkAa5/UpIG4o5HA9EH7SaYi05EUlzrDdIeZsJnXDkxmG9144wNZBbndHx
nKXRnpJjCX4jhZeNQFyY4m5c9c8bMytO4zb8XUJIxCjqkhtukJtqHieEogwGsmZlpOxt6Ucc2JXg
6oTTbyITD4Bvn7cFb7EI2FBcT7K8bf8AvwtNLl/dKYtUA/nEvVhjqp0wsDL3t//Q3GTwGWZB41gf
LC04V6gD9TVFl7i/N48Gu8PzTt4Kt0SZvBr7kQ9PKi7DVyXe23Ou89QVflaja3bPjt2UZCyq0JxJ
Nu5SjFDWjKlBCzbLDGkCBlM4DpjAb0y4MyKOsiVv7vIxNlYxggJtMIICaQIBATBrMFsxCzAJBgNV
BAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdD
QyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwcAgHcg4j27cIp1UUwDQYJYIZIAWUDBAIBBQCg
gdQwLwYJKoZIhvcNAQkEMSIEIDVWaf0hk8S52ocVcem9wkzBWnSalpzWOQS3/iNK52QRMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDEwMzE4MTc1N1owaQYJKoZI
hvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQAWkmSSDeKk3nJIyXhm+qyfdnRAv3UZD69R2idzY3AR10gdvww42LixK2y6iqFn5z2XPqOc
tyLwXTLaJcD6bB0DwE/A/ZGo0wgIKUCFBB2yFEVMXmMRHqZaNj/aKPztqCa0i5zK0aBI46qdyZL+
gkQ5jaD7GTL+1LqAaCsJ3NZE2/3/yd2M86GaENNP5O7fMMGrMWKug0sxEe3of++vwfzFbioRrmum
KMSEL1yNoTFi2K8zRko0bLV9wGB9w1PSIdDIG0PDKmoEcejOj0nqn0Nk5NHG8c8IFtYyQ0FPvIeF
Id4QVIhzGX//uOXR1fn1l3YZv0LGU01GbwTmMg1tsHol
--00000000000069a3b1060e0ea2aa--


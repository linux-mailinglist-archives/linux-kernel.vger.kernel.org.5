Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1012D8074B1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378417AbjLFQQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjLFQQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:16:24 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92ECED42;
        Wed,  6 Dec 2023 08:16:30 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a1e116f2072so86140566b.0;
        Wed, 06 Dec 2023 08:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701879389; x=1702484189; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANhsNm1z1q5r0k4ig7l9fgQ6wnefNabJyB6yrVtO5Dw=;
        b=DGR64mNn1Gfftkep0d5kBQGP4oXlH/YI5ONU+WqsKuferqdbJz992wS9YeUrDp+gou
         aOz5wHFvztvfWjXcZnvMY6p502hOpdIwQLNjsdUwCjMCcMOVL4q4jEPDVRTqPUUXdZT2
         sCjTIg2RcmmYhbquZ2i/eug1wePlvBJP/A6at4aa115m0gYnqlvyYyKozRzof/hlXBZm
         d4opkEOq4DNmVMjVnAY9F2qdZ43yhO0XQZt8OCjaJQN/p5OV6BV89Bz/Z75rsVIfSJKS
         8ihodEnvWzSKPkUcfpXkjMHCv/KkA7SMv0L7HsD28yJBtzD+5clEyzLeGW0HLzdZ8M0j
         9VXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701879389; x=1702484189;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANhsNm1z1q5r0k4ig7l9fgQ6wnefNabJyB6yrVtO5Dw=;
        b=YK0jXVM5bcrw4pOGoyCbkzSdvXYMrIaQWENrfGgpKrfr3Aqk7m27vOegISrbfIV1u/
         Nu9vFjJE6eZotmz7BCjbBz8dIyQHYk6plJGXfNrYmdcbYonCDrkYDAjebV4DLOTPu6Oh
         dVSvML3B4m/f8PiqalSFb9UbFRQ1z/n6tfDauv90s2LhZcMDNM2Q6viuOl4Y/Ln4q4vN
         FDVxEX8AZLeEl7fxuM3KDQ1gE4wQvrr+C7wuljYCuRM3s3N8E2SlfL1eFTXjpnM92Gre
         KpkQrshM2e061egEs1G2a6N9BV52+//yGeGrKHYoID6ddludpOmMJzbCsTv0qlimpe9v
         Tr6A==
X-Gm-Message-State: AOJu0YwTECWtZAKEcD5B0D26mMxk8YNdw+sdAKopzc2wjKuFIGFPwDRt
        MSJ/9AyK0HNmWDemOpU6aqw=
X-Google-Smtp-Source: AGHT+IFy8x5NdSw4gMUVcSn6gTYvfx+5ZcFZaDpA+FIzL/xuDBuyQYdp284Mn4A9tfEwJ5Vrnr8htQ==
X-Received: by 2002:a17:906:185:b0:a1d:d900:271b with SMTP id 5-20020a170906018500b00a1dd900271bmr958745ejb.2.1701879388726;
        Wed, 06 Dec 2023 08:16:28 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id s14-20020a170906454e00b00a1ce98016besm108989ejq.224.2023.12.06.08.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 08:16:28 -0800 (PST)
Date:   Wed, 6 Dec 2023 17:16:26 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-fsd@tesla.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: pwm: samsung: add specific compatible
 for Tesla FSD
Message-ID: <ZXCeWmEO3PJiK0m5@orome.fritz.box>
References: <20231205092229.19135-1-krzysztof.kozlowski@linaro.org>
 <20231205092229.19135-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CFJ6EccMqQxL/2Mm"
Content-Disposition: inline
In-Reply-To: <20231205092229.19135-3-krzysztof.kozlowski@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CFJ6EccMqQxL/2Mm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 10:22:25AM +0100, Krzysztof Kozlowski wrote:
> Tesla FSD is a derivative of Samsung Exynos SoC, thus just like the
> others it reuses several devices from older designs.  Historically we
> kept the old (block's) compatible only.  This works fine and there is no
> bug here, however guidelines expressed in
> Documentation/devicetree/bindings/writing-bindings.rst state that:
> 1. Compatibles should be specific.
> 2. We should add new compatibles in case of bugs or features.
>=20
> Add Tesla FSD compatible specific to be used with an existing fallback.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> ---
>=20
> I propose to take the patch through Samsung SoC (me). See cover letter
> for explanation.
> ---
>  Documentation/devicetree/bindings/pwm/pwm-samsung.yaml | 1 +
>  1 file changed, 1 insertion(+)

You point to the guidelines that say we should have specific compatible
strings, but then the string that you add seems very generic. Now, I'm
obviously not an expert on Tesla hardware, but just FSD seems to be
quite generic according to the internet. It seems like the chip derived
=66rom Samsung used to be known as AP3/HW3, but there's now also AP4/HW4,
so I wonder if those differ in some way and if these shouldn't include
some sort of version/generation number.

Thierry

--CFJ6EccMqQxL/2Mm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmVwnlkACgkQ3SOs138+
s6HNNxAAr18wT2Xx7P6HZfEgxKUQPSCBFlyEXUDvbkHuvzp6EQKPzf/qxwtlsnFk
nrFGQTrZn7i6PREWY3t2J9yOd4OjSUvwbkuSJnivXzZla7r0+H1u4iFD8cOWT1JH
RdzvcGTRIO6NVCyYH1uq8zszeWkMftGYP65u15WlMFoNhbvDshpTRHpTtBH+GKzw
uOvHeU+XGckCiuWLTlw5G3X1B/ApmiGb7faNwlIEOWcHtDSfq+z0ypjAA509NKkJ
UqcrFJbn28pcuPPzudHQBDhw8h6azTRS7cYdaAI9XrU5+kg0dSthoWXWUHnxCluq
888aZXm1xsCwMAy09y1GLOraEBTuy+qtDKr4hqydKJ5fs2jJEVseX9X2vQpL4Tvm
4rS68YgmsbAtt9rvGeKgh9qoP+uk9jlzv5TqF4/p8ou4WPjLCm/tY8tnGYDhU23p
4kSXpyHYJ2FJQjaCpHMVpRJhQ86lO0HuBecJU5l+/meu/iWk6wRvJMOQ00/+5PpR
tjRwy3Wey7HTT7o9FUwrP7zvWbyIzyhANX6tKCEBHfTQvH0o3Iawa959Ip9lzkrV
sB3j6nS8OiPWn4TjogGQHIjvm86H1r8hMPNQQGV26iLXxmbarWylBsJviqkGHPyP
UpsvXImtnoR0/WG2qYO/VbbzK1k3PU6PWhJ0CJuPhrYnaISX5Uc=
=yEhC
-----END PGP SIGNATURE-----

--CFJ6EccMqQxL/2Mm--

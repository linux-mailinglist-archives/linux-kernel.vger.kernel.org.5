Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96C47575A3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjGRHqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjGRHqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:46:18 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD15610DF;
        Tue, 18 Jul 2023 00:46:15 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-992ca792065so742908966b.2;
        Tue, 18 Jul 2023 00:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689666374; x=1692258374;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXaT6APHJQXhpbwZ9c1qIYiSYwOvNOpb+GN5TESf5y0=;
        b=kuUL6qubC4aVn22O15bxQLyYanj97a2vktrajCEMYVHyKka+ggyEPUfBwU6TJ1etlo
         /le1HoC3ySgmofs9wboZlrd3lr6CNNlhWLqpzpU+b8hRrbVPfNiz2jF1BQ+XUVofm43n
         rik5HU+yZMK2RPDKqQS9Pk8qhmThEAoDee1tesR1TMtLiQT6WT4bFijDhxFmv3WGXdU0
         4FUT6ghKiWCkdUKVS1nMFcLsT39Cj31+5rgAmjZ6UrHGEHtGWcqyGRWnosMwRupt8M7z
         cJD+JB0PT2uI1ncMuS9jHL619hKLBVvo8nx2MAFv3zCnbXpuSVABGv0x/hE6r04doVUB
         E3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689666374; x=1692258374;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXaT6APHJQXhpbwZ9c1qIYiSYwOvNOpb+GN5TESf5y0=;
        b=YMmkoDfKvHzEHtk7tFGCVyX7QHNfdfhcKRcaLl2UMlDtMKvTybzpiWyh1uDRTBJE4M
         D1Xd2z07RJ3F+VRuklcv0E5N7DrqtLvLzwxN0GIrDkS3gwbpLaCU1NK9dwn7OI5KHPb6
         678BNhC5N4a1gn347r/vtOWojU62SxeuNV6FUdKYURdh6pU0drV8EpaxNTonxKVLlGbR
         SXc3zpnqrATUnkGXi6hJ87pm/M6x7qYkLhZqqpCpNLKeJygkdTzOHLPh0k/0wfzZzdA6
         pVWlV2z/5ZfZsu3RrI+42WVCqvEob5nsDp5qZArINKvU2WNdzAZ947oWi/PmELSBr+E9
         jMnA==
X-Gm-Message-State: ABy/qLaQbmlj3HjKqLGzdT4HCAom3tmfx+G4WFKHq8K0GwVEQAiRMUpa
        KP0vlE/4tEUu1hXi+WIQU5Ng2r4pyB8=
X-Google-Smtp-Source: APBJJlGEfvRTZ1qi772HzYEzzIQoZO2W4jSwQ00uCNhfTuToM8Pe+1d/DyRPiG4wclpp5+j+MPeKhQ==
X-Received: by 2002:a17:907:7704:b0:992:c8d7:b66f with SMTP id kw4-20020a170907770400b00992c8d7b66fmr11300335ejc.75.1689666374008;
        Tue, 18 Jul 2023 00:46:14 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id o3-20020a170906860300b0099290e2c163sm638762ejx.204.2023.07.18.00.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 00:46:13 -0700 (PDT)
Date:   Tue, 18 Jul 2023 09:46:11 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 10/10] pinctrl: tegra: Switch to use
 DEFINE_NOIRQ_DEV_PM_OPS() helper
Message-ID: <ZLZDQ64QHsNi7kra@orome>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
 <20230717172821.62827-11-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xXrLK6/iTZZPHAap"
Content-Disposition: inline
In-Reply-To: <20230717172821.62827-11-andriy.shevchenko@linux.intel.com>
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


--xXrLK6/iTZZPHAap
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2023 at 08:28:21PM +0300, Andy Shevchenko wrote:
> Since pm.h provides a helper for system no-IRQ PM callbacks,
> switch the driver to use it instead of open coded variant.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pinctrl/tegra/pinctrl-tegra.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--xXrLK6/iTZZPHAap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmS2Q0MACgkQ3SOs138+
s6F/xA/+I0bEAIZvtYSJbWGW3odYR79tYmCu4u3Def9PnhZ4sLDjCh4N3pUGz/hc
cmQzv/IXBSl8Z2xpnAmBCZHdz6EzsdEpaGxaykNyskzO1ABDIMw8YkkvN4vA3f+2
g7NOaof0vdyf0n+Q6AtdJW/2KHVgwJSGqkfRVHHajwLJOZtCm1naB5wThiSCKz1a
ytHyYiYwD4Os1zh2dD2EXJ0Ezz/+XkjwdTNoTaZZvaxvIyo3IgX9K0cXX2wzpMr+
asMkplyryGX8LfjKcExpiPotUPGFUFwN93gA6Glg8PDdqRU9I1ARbTmlqlSld+eT
V4xy5I4DNKeU8Zi1kN+umHEkhaZg2bC5ZFG8GHgmcTbHogmc5s3AB4nHmIr6geS4
/zYsU7W/0wdR5fUF7Umnbe/DX0Tss27ntqbz1aEj/p+W7E0QDXvT4LtUKz5SiJjs
8gcdP8h5ZM4Eji0+UlWlZX0JVtg3d+48FefiuaEf43gBJXrvKCZTlLNif4JEUzAZ
cflDyd3QSeKNEXTVPKAju5++znR69t+PhlyrGqNkeEUhQ5RgM3O3CCbJuhuaycn7
hZaNEynqbxNwQoeIXxfQ5a/i38iRosZyLhdVQt52YE8ON5Y3sl18Q4nXjvCTTQd8
uPduIo56wHEd2064KmnQP6oWDa+ceh8kJI2/qmNH0xk15QYSVF4=
=NQCN
-----END PGP SIGNATURE-----

--xXrLK6/iTZZPHAap--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3962757CD3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjGRNI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbjGRNIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:08:01 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742211731;
        Tue, 18 Jul 2023 06:07:08 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e5e4c6026so8139369a12.0;
        Tue, 18 Jul 2023 06:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689685627; x=1692277627;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeNzcLZcbKq2pijVIKB1EKgYyt490I0ItiXqddVq1sY=;
        b=rP3r+2F3AtU9GAGdeWWs0YgHxvEURd130cvktz54GM4lnMwxB516TsdaJesy7qaCjI
         4+/0VA7N1E+xSOrMg/fBoenZaTAxuz/SGcNLFSOIDOm5QPNQEkDUDYxubU1L4nKVeJCT
         9SlVxT1pcW1UiuADjAqmAQzHTEPvaOG65NnextEZL4bbMPRbdNKjl7BdP5lZxvNAZbKp
         aKLkq+HHEcl4JTCu5ZsDHiBmEGrGh+BqvSViUWI5WXQ5x6ucFXmHJ2Ro7TNgZawah+n4
         OcU6DeeXdZaGKG71n+iyijDAz2E7cP/gSjoGVApK3JrKMl+N5whq11HOy6RuYyp/jUys
         8m0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689685627; x=1692277627;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeNzcLZcbKq2pijVIKB1EKgYyt490I0ItiXqddVq1sY=;
        b=TJKtX6vBv/DzMM1YAl0l6qKcu7pwQKQSDZwCrVrBxMVuHFloNYSRAqwPrLbbAbhFm6
         mmFPSISIAV65X9vmvcQ28AZc+T8LjjPUoDFHYHaSgfHv/VI29vj+cSWEUEzFdHwQQXmF
         Wp5iOCiLxVKweO1sPJF91Be1HukdwMxUV/y8wHX09HOIuYWErC1YKUJXyLZ876jSdBK9
         PuqlXU/CRr1msRuiyh5uPac1j3ssoMP4S7TawMPURwLd/It9s+81+930VfKvuhRHL++D
         DDEUe3JRF/5ZuPVkk/EzTNpo2hkZ6eQNdcpaAnd1Y8p+M57tMfAEmIDk6DripDN+2sma
         BShw==
X-Gm-Message-State: ABy/qLbBqXW2xMNZp4iK3QBtKcYP2/1jB/ou7vK6nyfOsjFpeo4HpuDj
        Ab//ClsuSEWX61egyGoXDWI=
X-Google-Smtp-Source: APBJJlEiPfshVtSNYkP8OH436Zpce1Qp7nrenoouEBdZbfLSznRPVQG3AGuGgTjKso3ViGypwJ6d7g==
X-Received: by 2002:aa7:d38e:0:b0:51d:9dd1:29d0 with SMTP id x14-20020aa7d38e000000b0051d9dd129d0mr14765841edq.23.1689685626590;
        Tue, 18 Jul 2023 06:07:06 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id v18-20020aa7dbd2000000b0051e0c0d0a8bsm1218465edt.7.2023.07.18.06.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 06:07:06 -0700 (PDT)
Date:   Tue, 18 Jul 2023 15:07:04 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sean Wang <sean.wang@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Pavel Machek <pavel@ucw.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 10/10] pinctrl: tegra: Switch to use
 DEFINE_NOIRQ_DEV_PM_OPS() helper
Message-ID: <ZLaOeCI4cp79wfiH@orome>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
 <20230717172821.62827-11-andriy.shevchenko@linux.intel.com>
 <20230718111143.000067dc@Huawei.com>
 <ZLZ5obLK89E1S_2R@orome>
 <f002fe945307d0904bcee8bd1f21d9e589d32ffb.camel@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cxQ8UzeWhjJFmiXC"
Content-Disposition: inline
In-Reply-To: <f002fe945307d0904bcee8bd1f21d9e589d32ffb.camel@crapouillou.net>
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


--cxQ8UzeWhjJFmiXC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2023 at 02:01:27PM +0200, Paul Cercueil wrote:
> Hi Thierry,
>=20
> Le mardi 18 juillet 2023 =C3=A0 13:38 +0200, Thierry Reding a =C3=A9crit=
=C2=A0:
> > On Tue, Jul 18, 2023 at 11:11:43AM +0100, Jonathan Cameron wrote:
> > > On Mon, 17 Jul 2023 20:28:21 +0300
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > >=20
> > > > Since pm.h provides a helper for system no-IRQ PM callbacks,
> > > > switch the driver to use it instead of open coded variant.
> > > >=20
> > > > Signed-off-by: Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com>
> > >=20
> > > No pm_sleep_ptr()?
> >=20
> > pm_sleep_ptr() is pointless on this driver. This driver is selected
> > by
> > ARCH_TEGRA and ARCH_TEGRA also always selects PM.
>=20
> If I'm not mistaken, ARCH_TEGRA selects CONFIG_PM, not CONFIG_PM_SLEEP.

Indeed. I suppose pm_sleep_ptr() would make sense, then.

Thierry

--cxQ8UzeWhjJFmiXC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmS2jncACgkQ3SOs138+
s6Ew4hAAl5R17Bggr3INa4txNS6fRJHBAZkJ+mWhS+i2rp5oJ52oHctOukPe3n3x
pLZ+YCbflBOYqF9kNA5d6t9ij7t6oc5OXj8gfSxn9EB9I8dGfYHA67fX2ul7YyWG
cWN8YivHIXUJrSl36ZyUbzLx5PIUwQzMPiKnlMs91l3CyiLDDUC57vhhlAkxBjsa
pS7jTqHWQgv3wvDXq9hPKm5vHioJsaMninnzlicJyPPKEklTJuPt8ztxEuOoKrXJ
R92uAqURS/sp65HGBajYC/zytjduCjCLCaEphlRRvUpgDzI20LYJ0ozzPCkxMoee
2J51MbQlOAOur28EjjISkUtU6lPvved5XzWPEvNcya8uwxgfpCOFbXMycYawqkSf
8+pWkZJAAF9uDchinQwEl82g19NndHZ049YWwlqiluDURZqVAGDitkRBlYRiIhpe
bApEYaQed5NIDRZ45MohoZR1bcCUcN8SCTYeiM7buOH+JV7fvWIZJHWhcATTCvUj
kKWgl5fnMPq2a5F5346roojgESbtWuauYKzvGqIMlqr2wTe29hrTY+pzSsqaceSN
TEwu80frLmy+a/1OzgrQtAhZ14RmpP1XlFDHkipJHNFIRSF6pc2SsRMrRggcKJVA
LgXuPi7IxBkI763YIoGS8f1k0AkVOduCSe3hTKXM17tRGoKMzY0=
=JFZa
-----END PGP SIGNATURE-----

--cxQ8UzeWhjJFmiXC--

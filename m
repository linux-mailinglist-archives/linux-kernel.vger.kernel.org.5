Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D342757A92
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjGRLiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjGRLiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:38:15 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8AD1705;
        Tue, 18 Jul 2023 04:38:13 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9923833737eso676157866b.3;
        Tue, 18 Jul 2023 04:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689680292; x=1692272292;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytViiwfcWe6lsyfyDSaN9OoXNWJryJiZznNT0Efms7I=;
        b=UH6/jNT6G/IyXGm0cDcz8bMGqhWZEcRoDl7YEmT4RLClO5FMO7umKh3Ngtz3zFW8gN
         I0WNIoLjxncgOP5/cofemL/NG1RKHN4lCDDGPCL6kM3Rj14wSajZzVTnSLX9sE9VO4Y9
         UQGo5AQBJoFaLQAK8kdRMoVQ+MNoeucfKLjjAXzovOPSdeF8l4P7RtYgS83aaXGJ5suT
         kLR8SPe9ZSXCoNebACKkqT5ewGJYPxlRQpigC+nB//bkpsVFtd/ULixpqjsXjv6gKog0
         xaQUKxLw2ODCfSaJnO6d1l4/zCYOMYUXkCl4+UDgjBxPH1DowrrJ0y81D6jo3dMoXRc6
         fPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689680292; x=1692272292;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytViiwfcWe6lsyfyDSaN9OoXNWJryJiZznNT0Efms7I=;
        b=Te1isbu0ZxEnKtoNbAuFL2E4nHAwjsxoYoL/YCu+Bu3PLumf7Ln+ubhNbWpcCNqp9b
         k7Z5DdjL9bx2Vwme8kj2AgiYPt+nyIv8UqdWJxncOco0nIJ+mSYA3X+43BwYypHKXbH+
         LqVz86Z4Ukrpk/GLIScnWq5TZvr88tDEx1fmhMkLfA8nLzFWDTAEulCZNQGUqNgnxXho
         1B5l1uQoIs+Uln+YLegAmKfptZWNfsNvbjpEv4mXLtBZpVILIlyvew+zR1tEYeSxeAvt
         OdYYmftl1TVPBElv9w0HKOnUxchnhNOxm3MLN1ip+7QhPlf5f2Pzi6WWkVsmKEjB4nA/
         L8aQ==
X-Gm-Message-State: ABy/qLb6tCMqa2T1i0KXdd1VjPh0rpP8yaLBqvErplb9qZekViIX91au
        44ZGvXRFHOT3EbxMxCQjaVQ=
X-Google-Smtp-Source: APBJJlHJRSPDt4M6wS2e1KWsyePiNebOZ7j3ub/iC5nCKSHaAmmccwdmBc9nzeQ3r0OPWw7mcHpIAw==
X-Received: by 2002:a17:907:7413:b0:96a:2acf:61e1 with SMTP id gj19-20020a170907741300b0096a2acf61e1mr13582422ejc.64.1689680291722;
        Tue, 18 Jul 2023 04:38:11 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709063a8e00b00988b86d6c7csm903639ejd.132.2023.07.18.04.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 04:38:11 -0700 (PDT)
Date:   Tue, 18 Jul 2023 13:38:09 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
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
Message-ID: <ZLZ5obLK89E1S_2R@orome>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
 <20230717172821.62827-11-andriy.shevchenko@linux.intel.com>
 <20230718111143.000067dc@Huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="P74v0JVNv+vvpyMH"
Content-Disposition: inline
In-Reply-To: <20230718111143.000067dc@Huawei.com>
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


--P74v0JVNv+vvpyMH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2023 at 11:11:43AM +0100, Jonathan Cameron wrote:
> On Mon, 17 Jul 2023 20:28:21 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>=20
> > Since pm.h provides a helper for system no-IRQ PM callbacks,
> > switch the driver to use it instead of open coded variant.
> >=20
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> No pm_sleep_ptr()?

pm_sleep_ptr() is pointless on this driver. This driver is selected by
ARCH_TEGRA and ARCH_TEGRA also always selects PM.

Thierry

--P74v0JVNv+vvpyMH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmS2eaEACgkQ3SOs138+
s6HN5g//Ywj/wrs+BJr6VMHiLwbiRkA7v79ehOPzJ4OJUIYi3+1MAwmiWoFhEAcl
/T/eouCmHEic/yTcPLdI+J281dGNEtUfBocjS2bjIDVmEJLxdEQaj9etacJ45Mcb
IQYvnbmISFU6pJmF1TGioxkM6hSkHYpp1UNTAj4zZQZHqTGnk/NqOuEDIbht89x0
wQB0lbP9v0MshiQFj8QQKzDL/Q1nfrMzjAuvi9esT8DDqxNXWObkxqhNsJWxvbzV
a170XTFD7jE1+aTHyWt6KL2OtbLl4hKm4oyuyJsgGuW/NJRCIdFLyOfjPZ5bDWSS
tpTQcbvkjeGNSLjbZHB7cq8b8pgfuC+3f1fRL9V+3WLiHv34tTi+KBE1mdtk7oMz
jtWordkVw1MKp4coQrejaKK3kk24m4Xafa5ESYOJsL8F0CemS0Xqk8lQ+QrSEXGC
DvUbBTLWCZYopNX1TTD0IN3zy7MAopgsvIoEXjVfUPupR6onNJ5MyriXzDOJEqAq
P1WgES+vP23KX8uf/SCLCTBXSXMhfjwv1bDV+R2V5dIvVvYAW+SXbWncKxufAk24
myEePxe0D6lfE3I0pXSJwFOy/1GBu2eMojpkHPAOXS6xalB1tfNA0i5ql0qXwIci
yxdnnk39QqWv2w7pVnlUC43liVyc8pITB0bYSPspMhPsPFug1ug=
=Df4E
-----END PGP SIGNATURE-----

--P74v0JVNv+vvpyMH--

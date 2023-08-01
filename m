Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D623A76BD7C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjHATOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 15:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjHATOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:14:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9191F1BF0;
        Tue,  1 Aug 2023 12:14:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F965616A7;
        Tue,  1 Aug 2023 19:14:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824A8C433C7;
        Tue,  1 Aug 2023 19:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690917290;
        bh=RricL0NBD2SlXPu5D6K3MkV2NfI2Fl9g7qhLIB9lKzs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ZmhBbI6q1rH8SwBWw7Bxp58j12JA0u4tagm4I1spQ4hymiK8n+VSfZn4bnDxGQ5eZ
         zRTn75Ez47dqoWaZAC/USrqMPfbutYJpA39CcU3FzTLBDCEPbHVCDfqNZ5fHPNyVxi
         F8p1YiI9Q3oxsyXvYMH07aFZjDm0ZBXeOqRDiHtNkE4yBNMT12zQQypoQw/I2MS8CT
         9iVPIC5awUS2tzXak5s1SBNF9fSL0887T4zOFPmsLfd7I13Vvi5Ya20JsFXa6JB2fj
         XC6b1TtXp+N/aGb6yueKNPuXaAKetcrrl1D/WntkFG00YSO5xydBVrzQ6jyiDJaa1k
         EpxBXA8mJ1DRg==
Message-ID: <54b4d761e5b16ffb798a89c1cea99714.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZLvyn0xq3Msk+lxF@probook>
References: <20230428190226.1304326-1-j.neuschaefer@gmx.net> <20230428190226.1304326-3-j.neuschaefer@gmx.net> <4e0a5db18ed7d37038e67be0f1ddcb08.sboyd@kernel.org> <ZLvyn0xq3Msk+lxF@probook>
Subject: Re: [PATCH v8 2/2] clk: wpcm450: Add Nuvoton WPCM450 clock/reset controller driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Joel Stanley <joel@jms.id.au>
To:     Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Date:   Tue, 01 Aug 2023 12:14:48 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Neusch=C3=A4fer (2023-07-22 08:15:43)
> On Thu, Jul 20, 2023 at 05:02:15PM -0700, Stephen Boyd wrote:
> > Quoting Jonathan Neusch=C3=A4fer (2023-04-28 12:02:26)
> > > diff --git a/drivers/clk/clk-wpcm450.c b/drivers/clk/clk-wpcm450.c
> [...]
> > > +static unsigned long wpcm450_clk_pll_recalc_rate(struct clk_hw *hw,
> > > +                                                unsigned long parent=
_rate)
> > > +{
> > > +       struct wpcm450_clk_pll *pll =3D to_wpcm450_clk_pll(hw);
[...]
>=20
> > > +static const struct wpcm450_pll_data pll_data[] =3D {
> > > +       { "pll0", { .name =3D "ref" }, REG_PLLCON0, 0 },
> >=20
> > This is new code, please don't use .name. Instead use .fw_name or .inde=
x with preference to
> > .index first and .hw if the pointer is available in this driver.
>=20
> As far as I can see, .fw_name and .index depend on a struct device*
> being passed to clk_hw_register, which won't be available unless I
> actually convert the driver to a platform driver.

You can call of_clk_hw_register(), but a conversion to a platform driver
is preferred.

>=20
> Not relying on .name would indeed be nice.

Cool.

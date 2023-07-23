Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD57175E2D9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 17:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjGWPUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 11:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGWPUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 11:20:44 -0400
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [178.154.239.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303C4183;
        Sun, 23 Jul 2023 08:20:39 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:2481:0:640:e0:0])
        by forward103c.mail.yandex.net (Yandex) with ESMTP id CEA4F60049;
        Sun, 23 Jul 2023 18:20:35 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id XKKVCAKWwGk0-ryRAJRRp;
        Sun, 23 Jul 2023 18:20:35 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1690125635;
        bh=QHMivvH+ml3LY6p99d8Wkoqg/EJjRAjBCx6TowpssQA=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=bpWTSuwOh3Pq1nNVTeYjZ0rxthaWyc737Iz04dhOC5EO8W6O+NK2iBitqy1D1UrZt
         OigfEUbOrr/uaP9SpRo8/sazcILmkQQINJQahvE2B7Pqd08P4quXijIhzyQTblFFM0
         wPwkU11B16Hhil9uKPQt6maplK4D9B+xDKsx+Vxo=
Authentication-Results: mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <7d304d3a14ad44f1dcb301961c0b7d777b243156.camel@maquefel.me>
Subject: Re: [PATCH v3 02/42] dt-bindings: clock: Add Cirrus EP93xx
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 23 Jul 2023 21:20:33 +0300
In-Reply-To: <11dbf88d12051497ba1e3b16c0d39066.sboyd@kernel.org>
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
         <20230605-ep93xx-v3-2-3d63a5f1103e@maquefel.me>
         <11dbf88d12051497ba1e3b16c0d39066.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen.

On Thu, 2023-07-20 at 16:20 -0700, Stephen Boyd wrote:
> Quoting Nikita Shubin via B4 Relay (2023-07-20 04:29:02)
> > diff --git a/Documentation/devicetree/bindings/clock/cirrus,ep9301-
> > clk.yaml b/Documentation/devicetree/bindings/clock/cirrus,ep9301-
> > clk.yaml
> > new file mode 100644
> > index 000000000000..111e016601fb
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/cirrus,ep9301-
> > clk.yaml
> > @@ -0,0 +1,46 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/cirrus,ep9301-clk.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Cirrus Logic ep93xx SoC's clock controller
> > +
> > +maintainers:
> > +=C2=A0 - Nikita Shubin <nikita.shubin@maquefel.me>
> > +=C2=A0 - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> > +
> > +properties:
> > +=C2=A0 compatible:
> > +=C2=A0=C2=A0=C2=A0 oneOf:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: cirrus,ep9301-clk
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enum:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 - cirrus,ep9302-clk
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 - cirrus,ep9307-clk
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 - cirrus,ep9312-clk
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 - cirrus,ep9315-clk
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: cirrus=
,ep9301-clk
> > +
> > +=C2=A0 "#clock-cells":
> > +=C2=A0=C2=A0=C2=A0 const: 1
> > +
> > +=C2=A0 clocks:
> > +=C2=A0=C2=A0=C2=A0 items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: reference clock
> > +
> > +required:
> > +=C2=A0 - compatible
> > +=C2=A0 - "#clock-cells"
> > +=C2=A0 - clocks
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +=C2=A0 - |
> > +=C2=A0=C2=A0=C2=A0 clock-controller {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "cirrus,ep9301-clk";
>=20
> Is there a reg property? The driver grabs some syscon and then iomaps
> it, so presumably there is a register range. Is it part of some other
> hardware block? If so, can you make that device register sub-devices
> with the auxiliary bus instead of using a syscon?

Is reg property missing the only thing that doesn't fit ?=20

`devm_of_iomap` was done only for reusing `devm_clk_hw_register_gate`
for DMA's and USB clock gates, i can give clk node it's own registers,
like:

reg =3D <0x80930004 0x04>;

Or drop devm_clk_hw_register_gate reusage entirely and just implement
non swlocked version of clk enable/disable that will go through syscon
regmap.

The ep93xx really looks like an syscon device in docs it refers itself
as a "Syscon block", also converting into "Auxiliary Bus" won't help
with `ep93xx_syscon_swlocked_write` either.

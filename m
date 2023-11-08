Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F077E5ABB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjKHP7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjKHP7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:59:11 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28D31BC3;
        Wed,  8 Nov 2023 07:59:08 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 705276000A;
        Wed,  8 Nov 2023 15:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699459147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+kB2MAhqd2CZLOXA9zNCWTpxhkyv6CSvJsAidaTRfM8=;
        b=KKWV5oa4oO9WQ67xnEEwSXBsBlzSskaYTpOkboLkWa5FAVNWFeSdcUgK/5QaocyH62Qu1k
        TcmmbOUN8DpF27Jw8fuIno/znuahXsLUsmLAFLlMLYEzn9foFKHbiC3yZ7snvoHnzjDnsQ
        3Wop1gCuH2cYUViRgtcxTAO/dWjCdALBNakXOjYcWAzxyAKpwj/irGRtn5HO3UO69a0epX
        a6jfLehliImS1qxCAWFp8gvFanv7Admk4FH+Vqly/M5x7Y2hv5gHnV+aDv9A/7cPsqkS0r
        pk29HXu8SZexmLp88HPpYegT1eFpPPdJWNMTVNFNfDXl5AnYSdZZkEWkUoN4HA==
Date:   Wed, 8 Nov 2023 16:59:05 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH 6/6] mtd: rawnand: gpio: Rename file
Message-ID: <20231108165905.4675430e@xps-13>
In-Reply-To: <20231108-fix-mips-nand-v1-6-5fc5586d04de@linaro.org>
References: <20231108-fix-mips-nand-v1-0-5fc5586d04de@linaro.org>
        <20231108-fix-mips-nand-v1-6-5fc5586d04de@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

linus.walleij@linaro.org wrote on Wed, 08 Nov 2023 15:33:54 +0100:

> The implementation of the GPIO NAND controller is just "gpio"
> with the usecase for NAND implied from the folder nand/raw.
>=20
> This is not so great when the module gets the name "gpio.ko".
> Rename the implementation to nand-gpio.c so the module is
> named nand-gpio.ko which is more reasonable.
>=20
> We put "nand" first instead of "gpio" because the order is
> usually <subsystem>-<driver>.c, cf ls drivers/gpio/

Do you mind if we take the "english" version which would rather be
"gpio-nand-controller.c/o"? I _really_ want people to understand we
don't emulate the storage but the host part here.

Thanks,
Miqu=C3=A8l

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805E5750E99
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjGLQbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjGLQbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:31:13 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87662EA;
        Wed, 12 Jul 2023 09:31:05 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E5336FF802;
        Wed, 12 Jul 2023 16:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689179464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4I7KqMlGQ1jWsPHpCvnpP3x5qLJt8ehVJksZQDgy4Q4=;
        b=kbOWBmv3V/Hpg9K2nq6/gdiXQqeTc6XG6mhSwoSP4xxQMpzzIeFH0eaAR3TkYmbxkpAi23
        C8YQfn60PsEWz1mnXbdTPTY+ZF+bZzIkODW5adoUYUgf/AjGPD0RdB5ZA9Uw25fMGSzT8Z
        jlgQ/eTVvxU3AsradvGIBgTrLc994AzFahLqeHEoRfWVZFtStnGsxtPC4gVdC/tcHp10cM
        8Z1IXWSjSBmauEAwlocXfZVP77emoHD748l2IsDWZ60bdyDW2EbunyRi8fwHuIYXPAEWGS
        MJzFG7E8SH0BHEIZV0auqfcfNmJ03jCDlAj94KtpQ6DjE5S5mBZOmgAnwUfOFw==
Date:   Wed, 12 Jul 2023 18:31:00 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 00/13] Add Inanbo T28CP45TN89 panel support
Message-ID: <20230712183100.690b33c5@xps-13>
In-Reply-To: <20230422205012.2464933-1-sre@kernel.org>
References: <20230422205012.2464933-1-sre@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

+ Thomas

sre@kernel.org wrote on Sat, 22 Apr 2023 22:49:59 +0200:

> Hi,
>=20
> This adds panel support for Inanbo T28CP45TN89, which I found inside of a
> handheld thermal camera. The panel is based on the st7789v controller. All
> information is based on reverse engineering.

I haven't seen another version for this series so I assume it is still
the one to look at. As you already know, I also want to add support for
a panel based on the st7789 display controller. As discussed, I rebased
my changes on top of yours as you actually sent them upstream
much earlier than I did.

As a single minor comment was made to this version of the series, I
would like to know if you wanted to send a new version soon? Or if it
would make sense to send a bigger series with all our common patches in
one single shot (mine should apply cleanly without further work on
yours). Let me know how we can move forward.

For the record, here are my patches.

Link: https://lore.kernel.org/all/20230619155958.3119181-1-miquel.raynal@bo=
otlin.com/

Thanks a lot,
Miqu=C3=A8l

>=20
> Changes since PATCHv1:
>  * https://lore.kernel.org/all/20230317232355.1554980-1-sre@kernel.org/
>  * Apply DT binding changes requested by Krzysztof Kozlowski and his Ack
>  * I changed the driver patches to avoid code duplication and splitted
>    the code a bit more
>=20
> -- Sebastian
>=20
> Sebastian Reichel (13):
>   dt-bindings: vendor-prefixes: add Inanbo
>   dt-bindings: display: st7789v: add Inanbo T28CP45TN89
>   drm/panel: sitronix-st7789v: add SPI ID table
>   drm/panel: sitronix-st7789v: remove unused constants
>   drm/panel: sitronix-st7789v: make reset GPIO optional
>   drm/panel: sitronix-st7789v: simplify st7789v_spi_write
>   drm/panel: sitronix-st7789v: improve error handling
>   drm/panel: sitronix-st7789v: avoid hardcoding mode info
>   drm/panel: sitronix-st7789v: avoid hardcoding panel size
>   drm/panel: sitronix-st7789v: add media bus format
>   drm/panel: sitronix-st7789v: avoid hardcoding invert mode
>   drm/panel: sitronix-st7789v: avoid hardcoding polarity info
>   drm/panel: sitronix-st7789v: add Inanbo T28CP45TN89 support
>=20
>  .../display/panel/sitronix,st7789v.yaml       |   5 +-
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  .../gpu/drm/panel/panel-sitronix-st7789v.c    | 148 ++++++++++++++----
>  3 files changed, 120 insertions(+), 35 deletions(-)
>=20


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCE37534DD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbjGNIQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbjGNIP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:15:56 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7736330EB;
        Fri, 14 Jul 2023 01:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1689322538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KsipixUfNNIYvS1Su+tDY3+aBff0I+kz0FoxPFL3Kjg=;
        b=DvKxmR5Fy7ezNzUpnj1l39UcuzzkVbmYKyCrMEepMqVGs7BxXYQQLYrWJZ65cfixlmevr3
        +XePbNWCXiXH8F6/h+9FW63k+wzimZhm6eXvU+7vV69EEQSiNKX23/gDXckRMyJZ3scqOv
        syDR4X2x+CgMA2SC26tAQuGciv2D70k=
Message-ID: <5ae98ac651d6cc69d6bfd3c25b4879307f3c2c76.camel@crapouillou.net>
Subject: Re: [PATCH v2 0/3] Galaxy S2 (i9100) panel updates v2
From:   Paul Cercueil <paul@crapouillou.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Date:   Fri, 14 Jul 2023 10:15:36 +0200
In-Reply-To: <20230708084027.18352-1-paul@crapouillou.net>
References: <20230708084027.18352-1-paul@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patches 1/3 and 2/3 applied to drm-misc-next.

I'll resend patch 3/3 as standalone.

Cheers,
-Paul

Le samedi 08 juillet 2023 =C3=A0 10:40 +0200, Paul Cercueil a =C3=A9crit=C2=
=A0:
> Hi,
>=20
> Follow-up on my patchset that fixes the display of the Samsung Galaxy
> S2
> when running PostmarketOS.
>=20
> The first two patches update the LD9040 panel driver so that it looks
> much better, and supports setting the backlight.
>=20
> The third patch fixes the size of the panel in the Device Tree. The
> previous values were completely bogus and caused Phosh (PmOS' UI) to
> display tiny icons and text as it thought the DPI was much lower.
>=20
> Changes since V1:
> [1/3]: Remove spurious new line
> [2/3]: Remove .get_brightness() callback, use bl_get_data() and
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 backlight_get_brightness()
>=20
> Cheers,
> -Paul
>=20
> Paul Cercueil (3):
> =C2=A0 drm/panel: ld9040: Use better magic values
> =C2=A0 drm/panel: ld9040: Register a backlight device
> =C2=A0 ARM: dts: exynos/i9100: Fix LCD screen's physical size
>=20
> =C2=A0arch/arm/boot/dts/exynos4210-i9100.dts=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 4 +-
> =C2=A0drivers/gpu/drm/panel/panel-samsung-ld9040.c | 42 +++++++++++++++++=
-
> --
> =C2=A02 files changed, 38 insertions(+), 8 deletions(-)
>=20


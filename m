Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF63760296
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 00:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjGXWp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 18:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGXWpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 18:45:54 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F5010E3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 15:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1690238747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1BlHsP2EMV7nqNFEHat6zF0tfhx8Pg3UKKa/ZaxyN9c=;
        b=B8mX7t2uf+7J+slFG+j6tg4nqx639gasGBP4QnRFwGxkCyfl5/56sdhHg0r6cAeU8cWhxs
        GhKx9YnkcYxag4lBsME9eS+pPfO9N06IQJMuPBrL4x6k7lufYAUCIvPX5oLzAtYxWFzXbF
        DBg5FL2oBdTDjsgR9ESvcE8XFlHVqS4=
Message-ID: <b2dd8cbcaff623eef6d1abe6cd709f3fdbd9adc0.camel@crapouillou.net>
Subject: Re: [PATCH] drm/panel: ld9040: add backlight Kconfig dependency
From:   Paul Cercueil <paul@crapouillou.net>
To:     Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@kernel.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Tue, 25 Jul 2023 00:45:45 +0200
In-Reply-To: <20230724171108.GA692753@ravnborg.org>
References: <20230724121736.1293270-1-arnd@kernel.org>
         <20230724171108.GA692753@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le lundi 24 juillet 2023 =C3=A0 19:11 +0200, Sam Ravnborg a =C3=A9crit=C2=
=A0:
> On Mon, Jul 24, 2023 at 02:17:05PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >=20
> > The driver now uses the backlight interface, which breaks when that
> > is disabled:
> >=20
> > ld.lld: error: undefined symbol: devm_backlight_device_register
> >=20
> > Enforce the necessary Kconfig dependency to avoid this.
> >=20
> > Fixes: c2268daa65fb4 ("drm/panel: ld9040: Register a backlight
> > device")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
>=20
> I expect that someone else with drm-misc rights apply the patch.

Pushed to drm-misc-next.

Thanks,
-Paul

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D68E7AD4BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjIYJni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjIYJng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:43:36 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72729C;
        Mon, 25 Sep 2023 02:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1695635008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0rJDXgONrHX3aR1z2MM/iasrNXbrM9SUVbUdm4JtGGg=;
        b=HyuaFSYBVqDrcWKB++UJXMUa/cwScDM0/7cah93B75QHwXOdXbalzy973JOawgDGSaGwKJ
        9xmVPUaz9Ad3Y4Zti+EK8GXq8YqXSwEJ6cBdz+wCo5gKa1PFTvsX3QDauJRcH5iglv53/7
        FfZRhgY5D7EjJKI6rNZ1IB2KwyLi1Eo=
Message-ID: <d63b2a7bf2bbabe41b8e45a6c0a4dc0b1e117bdd.camel@crapouillou.net>
Subject: Re: [RFC PATCH v3 4/7] drm/panel: nv3052c: Add Fascontek FS035VG158
 LCD display
From:   Paul Cercueil <paul@crapouillou.net>
To:     John Watts <contact@jookia.org>
Cc:     dri-devel@lists.freedesktop.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 25 Sep 2023 11:43:26 +0200
In-Reply-To: <ZRFRFXCKTIb9x7GW@titan>
References: <20230925021059.451019-1-contact@jookia.org>
         <20230925021059.451019-5-contact@jookia.org>
         <ebd5808fe3029e46376aea3c25d3770a6b406fdc.camel@crapouillou.net>
         <ZRFRFXCKTIb9x7GW@titan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 25 septembre 2023 =C3=A0 19:21 +1000, John Watts a =C3=A9crit=C2=
=A0:
> On Mon, Sep 25, 2023 at 11:12:29AM +0200, Paul Cercueil wrote:
> > Hi John,
> >=20
> > Just to be sure, your fascontek panel won't work with the
> > initialization sequence of the leadtek panel?
>=20
> Yes, it does work.

OK, why not use the leadtek's initialization sequence then?

From what I can see, you have a panel with a NV3052C chip, so the
existing initialization sequence should already work.

>=20
> > Did you try with the existing display modes? If you can afford the
> > 24
> > MHz clock (and if it works with your panel) it will give you a
> > perfect
> > 60.0 Hz refresh rate, while this mode above will give you above
> > 59.93
> > Hz (which is not that bad though).
>=20
> No I didn't test with this.
>=20
> In general I don't feel comfortable submitting code that strays from
> what is
> recommended by the manufacturer.

The NV3052C datasheet does not give any settings for a 640x480 panel, I
only see suggested settings for a 720x1280 vertical panel.

Unless you have a min/max range specified, the values you see in there
are only suggestions for a working setup, that doesn't mean they are
the only recommended ones.

Cheers,
-Paul

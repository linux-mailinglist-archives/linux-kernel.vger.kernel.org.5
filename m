Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA25575B077
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjGTNxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjGTNxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:53:17 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F61358C;
        Thu, 20 Jul 2023 06:52:50 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 76E7CC0002;
        Thu, 20 Jul 2023 13:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689861156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RuvPFmG9ZFC9+7jm4gOrOBVSo5fimZfSmfuIWCXVc4M=;
        b=NuAnMN5XhRNe4iSNbCsbYt3hLB86U7IAdDLR5+sN2pLJfm5zbPooAJjyM21kk1I8uWBl6N
        CVqu6vs+gBdjwlIlVNUyUFIvJInVpbLXGzLykm5UAD/ONGPOB793kBlx1V1fTiCoi01XWI
        U229AiYkvY53eMQEmv4h6XoR183btcUiAkrpDQw1vQX/1Dpzv688BnyUQpg3TjBhEn1PgL
        V/9vKN7Pv3HJK6XjZ9oOmJz/UzALITbXFCn8Kpkdib8tgxCsys/3qmG34sQgDPiQq72OXu
        v/AflvuUodgUZ78BJkaNrk1zyFw6RCVSRt61RpAqd5dYUkL0iUHqD8zkfrVMfw==
Date:   Thu, 20 Jul 2023 15:52:33 +0200
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH 2/3] dt-bindings: display: panel: Add panels based on
 ILITEK ILI9806E
Message-ID: <20230720155233.604cc5cc@booty>
In-Reply-To: <a4ad14db-f3e6-a9a9-c7a9-b64bf2b3d33d@linaro.org>
References: <20230719152147.355486-1-luca.ceresoli@bootlin.com>
        <20230719152147.355486-2-luca.ceresoli@bootlin.com>
        <a4ad14db-f3e6-a9a9-c7a9-b64bf2b3d33d@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

thanks for reviewing.

On Wed, 19 Jul 2023 21:12:14 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 19/07/2023 17:21, Luca Ceresoli wrote:
> > Add bindings for LCD panels based on the ILITEK ILI9806E RGB controller
> > connected over SPI and the "ShenZhen New Display Co NDS040480800-V3"
> > 480x800 panel based on it.  
> 
> 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index aee340630eca..3c38699ee821 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6515,6 +6515,12 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
> >  F:	Documentation/devicetree/bindings/display/ilitek,ili9486.yaml
> >  F:	drivers/gpu/drm/tiny/ili9486.c
> >  
> > +DRM DRIVER FOR ILITEK ILI9806E PANELS
> > +M:	Luca Ceresoli <luca.ceresoli@bootlin.com>
> > +S:	Maintained
> > +T:	git git://anongit.freedesktop.org/drm/drm-misc  
> 
> Nope, same for recent one-driver-subsystem. It's like a second try...
> You do not have git tree for one driver. The git tree is for subsystem,
> not driver.

I see, no problem, I'm removing the T: line in v2.

As this came from copy-pasting another panel driver, should the T: line
be removed from every "DRM DRIVER FOR * PANELS" entry? I could send a
patch to do that, if that makes sense.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

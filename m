Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4FC7AD46B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbjIYJWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbjIYJV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:21:58 -0400
Received: from out-207.mta0.migadu.com (out-207.mta0.migadu.com [IPv6:2001:41d0:1004:224b::cf])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1CFAB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:21:52 -0700 (PDT)
Date:   Mon, 25 Sep 2023 19:21:25 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1695633709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n9O5UKN7tbRZK1Q9LpJlaNZaOpS94daiRwiLSPX4z0c=;
        b=vWTlglalviIbwVryZ8nWg7ttWfbbiBMo5J1cE+AyRX3ulLrW7ftoDRBRETqaWXeHC4LuRH
        CBb/QK5vRkpGVoWFw0efM3uGJQ/AAsh+4L2vSvg6DVo5IegdGfoVHTgEY4JdCcD/8SUNj0
        tyf9W1I9/B1yqEo+AAESJalMbKPNOje0PTB7EGuSzFCsSyfWwc5fcmLnv/ceJbDHYZRVYU
        O5FY0+v277dWCbGJC/juvl0WytI5AtWfvDcaXTf5WhsGN5ahPT8LCIoj1xsd4o1KUCKEl8
        Wpcso/SAMK3/TCL4x54a1oDLU3fTo2UurQ70JkIFClg5j1jvHkttwpH1RY7r2g==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   John Watts <contact@jookia.org>
To:     Paul Cercueil <paul@crapouillou.net>
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
Subject: Re: [RFC PATCH v3 4/7] drm/panel: nv3052c: Add Fascontek FS035VG158
 LCD display
Message-ID: <ZRFRFXCKTIb9x7GW@titan>
References: <20230925021059.451019-1-contact@jookia.org>
 <20230925021059.451019-5-contact@jookia.org>
 <ebd5808fe3029e46376aea3c25d3770a6b406fdc.camel@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebd5808fe3029e46376aea3c25d3770a6b406fdc.camel@crapouillou.net>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 11:12:29AM +0200, Paul Cercueil wrote:
> Hi John,
> 
> Just to be sure, your fascontek panel won't work with the
> initialization sequence of the leadtek panel?

Yes, it does work.

> Did you try with the existing display modes? If you can afford the 24
> MHz clock (and if it works with your panel) it will give you a perfect
> 60.0 Hz refresh rate, while this mode above will give you above 59.93
> Hz (which is not that bad though).

No I didn't test with this.

In general I don't feel comfortable submitting code that strays from what is
recommended by the manufacturer.

> Otherwise LGTM.
> 
> Cheers,
> -Paul

John.

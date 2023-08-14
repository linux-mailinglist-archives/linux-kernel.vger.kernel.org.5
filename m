Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947A677BA4C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjHNNkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjHNNjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:39:42 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E18E54
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:39:40 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C128DC0006;
        Mon, 14 Aug 2023 13:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692020379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gnac+iz/OeJ3aAVoaRx/bpiiylMQmySRZ97jfu/PZXA=;
        b=SRd1DsNsIpnUs14s8YfCNN2ZWqpSue3ckx23zDZo+R4VpvYvwPFqrupPXpyhtkD8K1FWaj
        gtovepaI1arcD5H9f+2y0zkcTn+CatsJ1OU3SdIjFfpn4PgnA/iI5dwVDDO3dcqrc2woy6
        PFDf0bquvC75vLHoldsHdEOxNGfs1UFC1o1CxMCMUB2aK3b+sMBynUdjDwdx0PjbKLLLQ1
        Shbof78uTFco9DlodSy3JEQgZz7xeAK9yKF+fimbz7iY/iyVwLFrMFhg9emJWW6iAfr3zK
        Gxbi+bq0eg4HEMojLgFQYoTSmaVIaJdo4mZwNnTs+iXVCxRF7Kz0JYhL0zaAcw==
Date:   Mon, 14 Aug 2023 15:39:09 +0200
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Marek Vasut <marex@denx.de>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH] drm/panel: simple: Fix Innolux G156HCE-L01 LVDS clock
Message-ID: <20230814153909.2b00b4c3@booty>
In-Reply-To: <0df7954c-6520-43bb-9246-c4a5a40b202b@linaro.org>
References: <20230804151010.834990-1-luca.ceresoli@bootlin.com>
        <0df7954c-6520-43bb-9246-c4a5a40b202b@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Neil,

On Mon, 14 Aug 2023 14:38:51 +0200
Neil Armstrong <neil.armstrong@linaro.org> wrote:

> On 04/08/2023 17:10, Luca Ceresoli wrote:
> > This panel has been implemented in commit 225213f24c79 ("drm/panel-simple:
> > Add Innolux G156HCE-L01 panel entry") with a higher clock than the typical
> > one mentioned on the documentation to avoid flickering on the unit
> > tested. Testing on a different unit shows that the panel actually works
> > with the intended 70.93 MHz clock and even lower frequencies so the
> > flickering is likely caused either by a defective unit or by other
> > different components such as the bridge.
> > 
> > Fixes: 225213f24c79 ("drm/panel-simple: Add Innolux G156HCE-L01 panel entry")  
> 
> This is the wrong sha, it should be eae7488814b5

Ah, good catch, Thank you!

v2 on its way.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

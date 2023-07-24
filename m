Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AD275FCF0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjGXRLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjGXRLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:11:14 -0400
Received: from mailrelay1-1.pub.mailoutpod2-cph3.one.com (mailrelay1-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:400::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F917A9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=k09OkZkHz1U1VJpY6ueOtE8II+8Lsf71u3vpE5oB4HY=;
        b=mbLhdXcpe+m4cljXsBMSeHpGFR5L46rZd8hu3zDt6nAoWl7hRAToRw1lszE1SV5swECwnAFZ4U3i4
         0sphoUIXicxPD6QjvOE4xYiXgymFm/bBXDJ+wmRPY/G5LK45gxZ2WHqZiEI4CwgOH82x3Pvnnb5zbG
         bwjWKc9oohdXH1sugZLU/LcsA+dIicWKwhTHHil0UJwfZZqFA2w5vL/fY8xtvxJuagdvIXLMoOuErh
         rCVNrS+AEbwA2ADBDsGLEyyzKrXkjPwZbAHV0+0MZFuNrBAbYXcDTyruu2MIzPTarcZwFIGLrapkM6
         UbsYRE2Wa24kbomENMQAID5gv97XXJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=k09OkZkHz1U1VJpY6ueOtE8II+8Lsf71u3vpE5oB4HY=;
        b=vJtbr9px1cBBxtrVUa5zxWMb4KYiUR048317wgr+Hr1oN3ehJ5elJQdNyPbN1N08tb8oSrhGfggzH
         cXrVKSkAg==
X-HalOne-ID: 148c1359-2a45-11ee-8d86-99461c6a3fe8
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay1 (Halon) with ESMTPSA
        id 148c1359-2a45-11ee-8d86-99461c6a3fe8;
        Mon, 24 Jul 2023 17:11:10 +0000 (UTC)
Date:   Mon, 24 Jul 2023 19:11:08 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: ld9040: add backlight Kconfig dependency
Message-ID: <20230724171108.GA692753@ravnborg.org>
References: <20230724121736.1293270-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724121736.1293270-1-arnd@kernel.org>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 02:17:05PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The driver now uses the backlight interface, which breaks when that
> is disabled:
> 
> ld.lld: error: undefined symbol: devm_backlight_device_register
> 
> Enforce the necessary Kconfig dependency to avoid this.
> 
> Fixes: c2268daa65fb4 ("drm/panel: ld9040: Register a backlight device")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

I expect that someone else with drm-misc rights apply the patch.

	Sam

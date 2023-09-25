Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D1B7AD4CC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjIYJtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIYJtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:49:08 -0400
Received: from out-201.mta0.migadu.com (out-201.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD39C0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:49:01 -0700 (PDT)
Date:   Mon, 25 Sep 2023 19:48:39 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1695635339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4dRdGkWCi+7rtuoY3VfupvdbW14yuz7oH4cStDJMMaw=;
        b=q529K7DaZTmoYJ4kW1UJ7DKPrrYj/pzpJQycIPKy9rQR72b+inomsCrccRrt1nwAj63o9W
        McJDn3CuN723tMvH3iwG/bU1QgJ4jm2VQJLj6AHxpuUcpBUH8395T+oKnFgCMKjx30Dv3H
        JBoxQ1mwnAkZktaYaGfyLvLqTjz6DTxJpUwYCo2AT7f1UsYMSlmlbpKlSeBistP1vdzfS/
        88KjTSZsKK+zlJjxmQvMmDMiVRvTaEf3v2OdoODU6ieCvclUqsJYF3XRO87U1FnoVcqkeN
        zdqtB6iLBCkgqYtIR/+q2N/c5uN4FxxECJVY+33XGm9y7h8Ypc0Jt4UZn0uPmA==
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
Message-ID: <ZRFXd3F7eit7x4aJ@titan>
References: <20230925021059.451019-1-contact@jookia.org>
 <20230925021059.451019-5-contact@jookia.org>
 <ebd5808fe3029e46376aea3c25d3770a6b406fdc.camel@crapouillou.net>
 <ZRFRFXCKTIb9x7GW@titan>
 <d63b2a7bf2bbabe41b8e45a6c0a4dc0b1e117bdd.camel@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d63b2a7bf2bbabe41b8e45a6c0a4dc0b1e117bdd.camel@crapouillou.net>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 11:43:26AM +0200, Paul Cercueil wrote:
> From what I can see, you have a panel with a NV3052C chip, so the
> existing initialization sequence should already work.

It has some differences that I don't know if are important.

> The NV3052C datasheet does not give any settings for a 640x480 panel, I
> only see suggested settings for a 720x1280 vertical panel.
> 
> Unless you have a min/max range specified, the values you see in there
> are only suggestions for a working setup, that doesn't mean they are
> the only recommended ones.

The panel datasheet has these values.

> 
> Cheers,
> -Paul

John.

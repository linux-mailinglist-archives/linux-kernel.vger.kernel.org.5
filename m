Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465177A54D7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 23:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjIRVJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 17:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIRVJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 17:09:23 -0400
Received: from out-229.mta1.migadu.com (out-229.mta1.migadu.com [95.215.58.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E32910F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 14:09:17 -0700 (PDT)
Date:   Tue, 19 Sep 2023 07:08:55 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1695071355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZZomkiVeqQePLkvnRcH7LRW8XoaXDjBYaYpZxuuvnrE=;
        b=TM+L0mLmXFJbKLdV3EPOLnnZrMC3GK1swbB1Ci+li00xC67T8F/qnPQsiuTZXStwpNNF2p
        cAGmR05E8PA73llDJajAoXAAjbiHM2xM89Xt6zL0ZxM3gc2yypDt0CN9YH5sGScdc1DQ+6
        VccUkI44OSvCFzn2yneTLKC2mbzTtvempUcD9nbIzqR+A7iGXeTQM8OglEynhZtYqEZXWQ
        qFZTBp9/a9jOGYmMGaNk0qCQnAk/A2BP5RR9tFAGfiAt1hISDdWgZ01H47eD4gqV7rpgBD
        vLgJ1OYNj/SETgEB7CmuwPwG+TmPHCwMBuaMxHNUnBsSJc5QUy8sOQ/+PiUEig==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   John Watts <contact@jookia.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        dri-devel@lists.freedesktop.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
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
Subject: Re: [RFC PATCH v2 3/9] drm/panel: nv3052c: Sleep for 150ms after
 reset
Message-ID: <ZQi8Z45VCqr-GqN6@titan>
References: <20230918125853.2249187-1-contact@jookia.org>
 <20230918125853.2249187-4-contact@jookia.org>
 <7fc1ca68-ca7c-59b2-0b70-27bc34d83cee@quicinc.com>
 <ZQi4fFZ0VnsUIiXO@titan>
 <4d2079d66249a7052acded0abf30169a4e95d151.camel@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d2079d66249a7052acded0abf30169a4e95d151.camel@crapouillou.net>
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

On Mon, Sep 18, 2023 at 11:01:15PM +0200, Paul Cercueil wrote:
> The datasheet does say a 5ms sleep time is necesary after a reset. I
> assume the 120ms delay you quote is when a *software* reset is
> performed in Sleep-out mode. The code here does a hard-reset.
> 
> Cheers,
> -Paul

Hello Paul,

Section 7.3 of the data sheet (AC characteristic) says that the reset can take
up to 120ms to complete if the reset is applied during sleep out mode.

John.

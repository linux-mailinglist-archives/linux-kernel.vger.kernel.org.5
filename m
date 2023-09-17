Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6737A3C1A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 22:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240908AbjIQU0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 16:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240953AbjIQU01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 16:26:27 -0400
Received: from out-215.mta0.migadu.com (out-215.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F3310B
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 13:26:21 -0700 (PDT)
Date:   Mon, 18 Sep 2023 06:24:24 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1694982379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qEy663wbTYgFkY8BNJi+ahfknVm89R9oplFVkVuCOzo=;
        b=v/DLL3KPs678sxsCZzCuk+NPwsJvuXXiy9+Dr36jVLgYb4b9d4OY35vNgwMK2ypjpq9xRb
        d9tuGdAEFz46FUzkxuZqbVkgP0Y/kseaN/ko/r7jjpJDiBkgnq5x3BL5SmljKQ4946CjEU
        AJKRHQRI5z4BuXZUQPF7nd/5Q/uMPUIs4Yso5FFP4dsZ+YyihpTZlgXNRGcNfrrDyu1+dX
        1HKWUn+R/Qt3miliSQkGsXXbL6+GBk3nk6pkZlQE+7xTr8L2T+XZzbi35WtgjjZPWazjDP
        zg/gOQPovAt+0exu6eStLjEvx67ew+yToElQE+vbmKmwUiSEGe3qiDzBfLE7hQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   John Watts <contact@jookia.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     dri-devel@lists.freedesktop.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 8/8] dt-bindings: display: panel: add Fascontek
 FS035VG158 panel
Message-ID: <ZQdgeA5tQA4xK5qL@titan>
References: <20230911090206.3121440-1-contact@jookia.org>
 <20230911090206.3121440-9-contact@jookia.org>
 <e22e61e7-02b1-8127-888d-e470838f4a18@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e22e61e7-02b1-8127-888d-e470838f4a18@linaro.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 11:41:12AM +0200, Krzysztof Kozlowski wrote:
> Missing reg. Probably also port.

Hello again,

I've been working on v2 of this series and done some initial cleanup.

Right now it looks a bit like this:

> allOf:
>   - $ref: panel-common.yaml#
>   - $ref: /schemas/spi/spi-peripheral-props.yaml#
> 
> properties:
>   compatible:
>     const: fascontek,fs035vg158
> 
>   spi-3wire: true
> 
> required:
>   - compatible
>   - reg
>   - port
>   - power-supply
>   - reset-gpios

Does this seem correct?
- reg is required by spi-controller
- port is listed in panel-common
- power-supply is listed in panel-common

I'm guessing that the required section just lists the minimal
properties needed for this specific device tree yaml?
There's nothing implied by allOf?

> Best regards,
> Krzysztof
> 

John Watts.

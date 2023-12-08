Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6660280A6F5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574121AbjLHPLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574326AbjLHPL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:11:27 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048B635BE;
        Fri,  8 Dec 2023 07:10:22 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 321F924000B;
        Fri,  8 Dec 2023 15:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702048221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gbiC1E0U5GD7F8IjRcMUn71q+WA4RzbXCwAcwZqG6vU=;
        b=RzqVjNmTcFRXyw7h+GFOQ8BUppnGpDBZcdOYi/MemctnQHj0PGqNLwxGLkc4QZxBrBrh2y
        G5J5YYM7qId+Dg39hWYUmIp+tW9UR/x6Ts9NpqYO1o/IEfcvWrKFYuxElovqtvJKqYAH+2
        1HlVmoZvKl7TUydMGR20/hDzvP50iVb04PguOGq11Hqar6PRo7hsKl0Ic5lGL0vCo6V7pe
        ZOWnX3LK931DbDb+GfEU9NdxyalrUDPXevlzPr2hR4loSAubgBxhJj6bLe/V41lav0wnws
        BD//3J9M+miY9IyZtgtCBslVRHLSp4abW7wof41Arrb60YUxQXNsuQ7WnPE6rQ==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH v9 1/3] ARM: dts: marvell: Fix some common switch mistakes
In-Reply-To: <20231127-mv88e6xxx-mvebu-fixes-v9-1-d19b963e81fb@linaro.org>
References: <20231127-mv88e6xxx-mvebu-fixes-v9-0-d19b963e81fb@linaro.org>
 <20231127-mv88e6xxx-mvebu-fixes-v9-1-d19b963e81fb@linaro.org>
Date:   Fri, 08 Dec 2023 16:10:20 +0100
Message-ID: <87a5qkenmr.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Walleij <linus.walleij@linaro.org> writes:

> Fix some errors in the Marvell MV88E6xxx switch descriptions:
> - The top node had no address size or cells.
> - switch0@0 is not OK, should be ethernet-switch@0.
> - The ports node should be named ethernet-ports
> - The ethernet-ports node should have port@0 etc children, no
>   plural "ports" in the children.
> - Ports should be named ethernet-port@0 etc
> - PHYs should be named ethernet-phy@0 etc
>
> This serves as an example of fixes needed for introducing a
> schema for the bindings, but the patch can simply be applied.
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied on mvebu/dt

Thanks,

Gregory

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

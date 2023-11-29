Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADDD7FD42D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjK2KcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjK2KcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:32:09 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74304E1;
        Wed, 29 Nov 2023 02:32:14 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A184FE0003;
        Wed, 29 Nov 2023 10:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701253932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6AQWLTAi/kFH63piYrCOLoe9cLcpZEYdoGnno5qNn/0=;
        b=iqK5PCgQPERsEeGyBLIVzQiwbgw6FnuNHNsyXxtLmbxTb+m18bbsx5EPx2JIb51kbmlPGZ
        v0zSdbGydbfI6lHbknqW2yg1VOyPO4kK5vhu2fCTqXzTyvFriB62AHm2aeoycahLn73XWM
        eDJFWUZ5QObQqmapvsRK155GziR5a5MHbG+jBadIg8f2rDIkWYoR4Qa8TVVf+T/Mya5+FZ
        r2oHQrJ6ageQ+/iQfuSp1ZlKTfeIwXXJPwwkqnE33yPpJXfvztrGIhzsg0j2fL99rnkNuZ
        lmgFW6jUxsdZ1G2FH1hotwp6wAKwfUyDuzAvdylrNFH4qvVBWov49awq/8OOiw==
Message-ID: <9806d838-3eb8-406c-8ef9-f75ebe664078@bootlin.com>
Date:   Wed, 29 Nov 2023 11:32:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-j7200: use ti,j7200-padconf
 compatible
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        theo.lebrun@bootlin.com, u-kumar1@ti.com
References: <20231128-j7200-pinctrl-s2r-v1-0-704e7dc24460@bootlin.com>
 <20231128-j7200-pinctrl-s2r-v1-3-704e7dc24460@bootlin.com>
 <20231129101905.GY5169@atomide.com>
From:   Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20231129101905.GY5169@atomide.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.richard@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/23 11:19, Tony Lindgren wrote:
> * Thomas Richard <thomas.richard@bootlin.com> [231128 15:35]:
>> For suspend to ram on j7200, use ti,j7200-padconf compatible to save and
>> restore pinctrl contexts.
> 
> Hmm are the mcu registers lost too? Anyways presumably you looked at it:

Hi Tony,

Thanks for the review.
Yes the mcu registers are lost too, as the SoC is fully powered-off.
And I did the test to confirm.

Regards,

> 
> Reviewed-by: Tony Lindgren <tony@atomide.com>
-- 
Thomas Richard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


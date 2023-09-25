Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C780F7ACD5C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 03:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjIYBA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 21:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjIYBA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 21:00:28 -0400
Received: from out-210.mta1.migadu.com (out-210.mta1.migadu.com [IPv6:2001:41d0:203:375::d2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D765DD3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 18:00:20 -0700 (PDT)
Date:   Mon, 25 Sep 2023 10:59:30 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1695603618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WNjNopcEjQfN12kbCSrhwvqbW3WLiiX1nbplJr5QSuY=;
        b=Uy2NbfVfgMCJhxEwf5RUAEi72sP541r0gEtly66WLMFGw+E+GK13+B4eOJO9WBf1kr97pf
        fA8b4PrtfrpEoBBWAM5N4ieLMHYDZgv8sZqx1lJUxBdgEd+puHEvNUOciFuDObBKqqhmHE
        rJwW8j7SfLM+ge56WO2ivx1UcJvlTtf5pE4O0b8mDQiRsGJ/RoPqr5sS8Oui3OZ8YIk7Tt
        +mss1ofxS1mCjnXK7WASDHFdA9bOWMzQB7XCRKqFi6zfjV+o97cFHmrbTqP+yR+zOOXINR
        BLFWywt2VK9Vzz22A3JW5wwVdSL2dmNukowvgN6vflBw2DBKC5f99fVVRMO8Lg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   John Watts <contact@jookia.org>
To:     Aleksandr Shubin <privatesub2@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 0/3] Add support for Allwinner PWM on D1/T113s/R329
 SoCs
Message-ID: <ZRDbcvhO3Z2G4Elf@titan>
References: <20230824114038.891493-1-privatesub2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824114038.891493-1-privatesub2@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 02:40:24PM +0300, Aleksandr Shubin wrote:
> Hi,
> 
> This series adds support for PWM controller on new
> Allwinner's SoCs, such as D1, T113s and R329. The implemented driver
> provides basic functionality for control PWM channels.

I did some more testing of this and it seems to work on my T113, outputting
correct periods and duty cycles.

Tested-by: John Watts <contact@jookia.org>

John.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08D1800968
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378479AbjLALJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378464AbjLALJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:09:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B7E1A4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 03:09:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB25C433C8;
        Fri,  1 Dec 2023 11:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701428988;
        bh=o05AhYqQMl6gqIIPfGCy+BD9YDKBTaLzd34nySfyWC8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ObgOAzlGppLIARiW9BNQhCs7HUjaLBSKRMhtQ7DM97/eILMUSwzVUGLDlQLiNYPoG
         2kxr3XplZIBqxW1ofmIxBV6dQLD7kn8LTQ5Bi0D8PeQXOgJNfrtwVfs3hL2uWue4dK
         OxUsZwJzBVbfiOb5PXFNB+pTQtn3rIDcH5WnRwJ+AAxX4pXCZ67DjvAvayC71LWUE3
         SjHNf5Wr0ORlU4GAanKnhn+yHYxFhioAAmbfMORbjtY5iB6+FHHoB4BpXBJ6q6FGxg
         9M64qnfg1QKRRayQLXIRT2MzornCrSNSFf+jSNsaoeV05TP6Dx0qtsUU6a8WoOqgKE
         z5yGuxuI8zuTA==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andy.shevchenko@gmail.com,
        Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     kernel@sberdevices.ru, rockosov@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
In-Reply-To: <20231125200519.1750-1-ddrokosov@salutedevices.com>
References: <20231125200519.1750-1-ddrokosov@salutedevices.com>
Subject: Re: [PATCH v5 00/11] leds: aw200xx: several driver updates
Message-Id: <170142898612.3365188.2222761548333694548.b4-ty@kernel.org>
Date:   Fri, 01 Dec 2023 11:09:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2023 23:05:08 +0300, Dmitry Rokosov wrote:
> The following patch series includes several updates for the AW200XX LED
> driver:
>     - some small fixes and optimizations to the driver implementation:
>       delays, autodimming calculation, disable_locking regmap flag,
>       display_rows calculation in runtime;
>     - fix LED device tree node pattern to accept LED names counting not
>       only from 0 to f;
>     - add missing reg constraints;
>     - support HWEN hardware control, which allows enabling or disabling
>       AW200XX RTL logic from the main SoC using a GPIO pin;
>     - introduce the new AW20108 LED controller, the datasheet for this
>       controller can be found at [1].
> 
> [...]

Applied, thanks!

[01/11] leds: aw200xx: fix write to DIM parameter
        commit: 785fec3a8daff2957fd55e49cbdfe0a50866fdb7
[02/11] leds: aw200xx: support HWEN hardware control
        commit: eabe8239022cf3c75b90d9ee07dcfbbe4e50bcac
[03/11] dt-bindings: leds: aw200xx: introduce optional enable-gpios property
        commit: e91899ea3759d04e185721153a036e1a25e315b7
[04/11] leds: aw200xx: calculate dts property display_rows in the driver
        commit: 4ccd392c3ea7ceefbee58622e634d4997ef46acc
[05/11] dt-bindings: leds: aw200xx: remove property "awinic,display-rows"
        commit: 66d078f105837670c52bb31da29e26ad13bc2923
[06/11] leds: aw200xx: add delay after software reset
        commit: aac13e5630d6e081a9f6c5a57e5e6fc1152acca8
[07/11] leds: aw200xx: enable disable_locking flag in regmap config
        commit: 851fa70b9b162bbf5b5f5f92fc450633e6b21a3a
[08/11] leds: aw200xx: improve autodim calculation method
        commit: 5fcc24b92b43f012cbf430244f0698ff588ec9fc
[09/11] leds: aw200xx: add support for aw20108 device
        commit: abc74724d5e714bb3359124f3576d5318828a83e
[10/11] dt-bindings: leds: awinic,aw200xx: add AW20108 device
        commit: d6bbe677add2c560ae4aa2f9dab7a19c287e2193
[11/11] dt-bindings: leds: aw200xx: fix led pattern and add reg constraints
        commit: 5707a06e5391a4eeaf0c2705f973336537a41c79

--
Lee Jones [李琼斯]


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D02D77F232
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348963AbjHQI3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348953AbjHQI3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:29:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62292723;
        Thu, 17 Aug 2023 01:29:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DBD46562E;
        Thu, 17 Aug 2023 08:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1E6C433C9;
        Thu, 17 Aug 2023 08:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692260941;
        bh=BbGi2kVrkXBHhaot+Rw7YbWMiGVGl0ctmnn+aGT0E4o=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CynTVj+yi93r/Igaep0/WKTWTBkNtE7nW4KF/yyRu+To3Cn7uW5U48dL/7WowW9zo
         pKFlW1MSSWfHeDeUHTW5u+FHLeDZXjgK0oUGAKawfMHShM2lzG0y986EECC4dYfu8l
         7l+4uw+meDMz7scVoZtLtktRn2LAP7+uhCBK0SW5L3a3wz6QF1tXwvglPM0wstkybW
         WWqraoAkR/S9bART/hkWUAWri5F8ltsefOq7Ai01YyHKcGcin4AyRfTVs8Jw0quCHU
         ZJLK0Ne8YbfgbpLtCnR/m8iw+xEKQbJErxiRoE6CrSWext2x8ZcwwLxJOe7CyBkvC7
         zs4d+ob3+DafA==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230718092527.37516-1-jjhiblot@traphandler.com>
References: <20230718092527.37516-1-jjhiblot@traphandler.com>
Subject: Re: [PATCH v11 0/5] Add a multicolor LED driver for groups of
 monochromatic LEDs
Message-Id: <169226093956.909741.13461014038581088073.b4-ty@kernel.org>
Date:   Thu, 17 Aug 2023 09:28:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 11:25:22 +0200, Jean-Jacques Hiblot wrote:
> Some HW design implement multicolor LEDs with several monochromatic LEDs.
> Grouping the monochromatic LEDs allows to configure them in sync and use
> the triggers.
> The PWM multicolor LED driver implements such grouping but only for
> PWM-based LEDs. As this feature is also desirable for the other types of
> LEDs, this series implements it for any kind of LED device.
> 
> [...]

Applied, thanks!

[1/5] devres: provide devm_krealloc_array()
      (no commit info)
[2/5] leds: provide devm_of_led_get_optional()
      (no commit info)
[3/5] leds: class: store the color index in struct led_classdev
      (no commit info)
[4/5] dt-bindings: leds: Add binding for a multicolor group of LEDs
      commit: 099c52d9448c1ca832b4695e982221a521282b94
[5/5] leds: Add a multicolor LED driver to group monochromatic LEDs
      (no commit info)

--
Lee Jones [李琼斯]


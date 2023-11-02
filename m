Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3A47DF514
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjKBOc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjKBOcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:32:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E7A195
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:32:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A3CC433C8;
        Thu,  2 Nov 2023 14:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698935553;
        bh=SyvUHYItchroCv0RsklVyvuIq8aoVyhg1ZCj3SrD0YE=;
        h=Date:From:To:Cc:Subject:From;
        b=DSPj9eTDZdi0lXXAI22cdzhAq/a9jlP1T1B4wON1u9QrogvLZvXP2KqGJkyfSMMAi
         J5O+ZxXiSYOQQ+hCvTqYY1Y2TOu62QdpwQzW+2vFYP8rrt5WSKs/HMqQ4r6G2xrmeS
         +0JmwS6kMFSZid9caGWTn866zJgYS+ahHIWhV+qpe1/GEhxjmgTUOsDynRQPA063xJ
         oPKYtYFoj654FLfYaM7Q9FIXZ82BSgNCCS0dJSdLfMHn2DzJ77FSBCRBPJCIiJdP9G
         965ONwmWnPetu4tGmrx/3ohmzfG/4WmDuHjk5EIQax4VYh0sYUsfpycg5cAmU6N/+y
         ujdxFjIhU/tVg==
Date:   Thu, 2 Nov 2023 14:32:29 +0000
From:   Lee Jones <lee@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: [GIT PULL] LEDs for v6.7
Message-ID: <20231102143229.GZ8909@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon Linus,

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git tags/leds-next-6.7

for you to fetch changes up to b9604be241587fb29c0f40450e53d0a37dc611b5:

  leds: lp5521: Add an error check in lp5521_post_init_device (2023-11-01 11:29:26 +0000)

----------------------------------------------------------------
 - Core Frameworks
   - Add support for a bunch more colours

 - New Drivers
   - Add support for Kinetic KTD2026/7 RGB/White LEDs

 - New Functionality
   - Add support for device to enter HW Controlled Mode to Turris Omnia LEDs
   - Add support for HW Gamma Correction to Turris Omnia LEDs

 - Fix-ups
   - Apply new __counted_by() annotation to several data structures containing flexible arrays
   - Rid the return value from Platform's .remove() operation
   - Use *_cansleep() variants for instances were threads can sleep
   - Improve the semantics when setting the brightness
   - Generic clean-ups; code reduction, coding style, standard patterns
   - Replace strncpy() with strscpy()
   - Fix-up / add various documentation
   - Re-author the GPIO associated Trigger to use trigger-sources
   - Move to using standard APIs and helpers
   - Improve error checking
   - Stop using static GPIO bases

 - Bug Fixes
   - Fix Pointer to Enum casing warnings
   - Do not pretend that I2C backed device supports SMBUS
   - Ensure PWM LEDs are extinguished when disabled, rather than held in a state
   - Fix 'output may be truncated' warnings

----------------------------------------------------------------
André Apitzsch (2):
      dt-bindings: leds: Add Kinetic KTD2026/2027 LED
      leds: Add ktd202x driver

Andy Shevchenko (8):
      leds: tca6507: Don't use fixed GPIO base
      leds: core: Refactor led_update_brightness() to use standard pattern
      leds: gpio: Keep driver firmware interface agnostic
      leds: gpio: Utilise PTR_ERR_OR_ZERO()
      leds: gpio: Refactor code to use devm_gpiod_get_index_optional()
      leds: gpio: Move temporary variable for struct device to gpio_led_probe()
      leds: gpio: Remove unneeded assignment
      leds: gpio: Update headers

Biju Das (2):
      leds: pca955x: Convert enum->pointer for data in the match tables
      leds: pca955x: Cleanup OF/ID table terminators

Christian Marangi (1):
      leds: trigger: netdev: Move size check in set_device_name

Christophe JAILLET (1):
      leds: trigger: ledtrig-cpu:: Fix 'output may be truncated' issue for 'cpu'

Chunyan Zhang (1):
      leds: sc27xx: Move mutex_init() down

Justin Stitt (2):
      leds: pca955x: Fix -Wvoid-pointer-to-enum-cast warning
      leds: lp3952: Replace deprecated strncpy with strscpy

Kees Cook (8):
      leds: aw200xx: Annotate struct aw200xx with __counted_by
      leds: cr0014114: Annotate struct cr0014114 with __counted_by
      leds: el15203000: Annotate struct el15203000 with __counted_by
      leds: gpio: Annotate struct gpio_leds_priv with __counted_by
      leds: lm3697: Annotate struct lm3697 with __counted_by
      leds: qcom-lpg: Annotate struct lpg_led with __counted_by
      leds: mt6360: Annotate struct mt6360_priv with __counted_by
      leds: mt6370: Annotate struct mt6370_priv with __counted_by

Linus Walleij (2):
      dt-bindings: leds: Mention GPIO triggers
      leds: triggers: gpio: Rewrite to use trigger-sources

Marek Behún (5):
      leds: turris-omnia: Do not use SMBUS calls
      leds: turris-omnia: Make set_brightness() more efficient
      leds: turris-omnia: Support HW controlled mode via private trigger
      leds: turris-omnia: Add support for enabling/disabling HW gamma correction
      leds: turris-omnia: Fix brightness setting and trigger activating

Mark Brown (4):
      leds: lm3601x: Convert to use maple tree register cache
      leds: aw200xx: Convert to use maple tree register cache
      leds: lm392x: Convert to use maple tree register cache
      leds: lp3952: Convert to use maple tree register cache

Ondrej Jirman (2):
      dt-bindings: leds: Last color ID is now 14 (LED_COLOR_ID_LIME)
      leds: core: Add more colors from DT bindings to led_colors

Stefan Eichenberger (1):
      leds: lp55xx: Use gpiod_set_value_cansleep()

Su Hui (1):
      leds: lp5521: Add an error check in lp5521_post_init_device

Uwe Kleine-König (3):
      leds: simatic-ipc-leds-gpio: Convert to platform remove callback returning void
      leds: Convert all platform drivers to return void
      leds: pwm: Don't disable the PWM when the LED should be off

 .../testing/sysfs-class-led-driver-turris-omnia    |  14 +
 Documentation/devicetree/bindings/leds/common.yaml |   4 +-
 .../devicetree/bindings/leds/kinetic,ktd202x.yaml  | 171 ++++++
 drivers/leds/Kconfig                               |   1 +
 drivers/leds/blink/leds-lgm-sso.c                  |   6 +-
 drivers/leds/flash/leds-aat1290.c                  |   6 +-
 drivers/leds/flash/leds-ktd2692.c                  |   6 +-
 drivers/leds/flash/leds-lm3601x.c                  |   2 +-
 drivers/leds/flash/leds-max77693.c                 |   6 +-
 drivers/leds/flash/leds-mt6360.c                   |   7 +-
 drivers/leds/flash/leds-mt6370-flash.c             |   2 +-
 drivers/leds/flash/leds-qcom-flash.c               |   5 +-
 drivers/leds/flash/leds-rt8515.c                   |   6 +-
 drivers/leds/flash/leds-sgm3140.c                  |   6 +-
 drivers/leds/led-core.c                            |  17 +-
 drivers/leds/leds-88pm860x.c                       |   6 +-
 drivers/leds/leds-adp5520.c                        |   6 +-
 drivers/leds/leds-aw200xx.c                        |   4 +-
 drivers/leds/leds-clevo-mail.c                     |   5 +-
 drivers/leds/leds-cr0014114.c                      |   2 +-
 drivers/leds/leds-da903x.c                         |   6 +-
 drivers/leds/leds-da9052.c                         |   6 +-
 drivers/leds/leds-el15203000.c                     |   2 +-
 drivers/leds/leds-gpio.c                           |  56 +-
 drivers/leds/leds-lm3533.c                         |   6 +-
 drivers/leds/leds-lm3692x.c                        |   2 +-
 drivers/leds/leds-lm3697.c                         |   2 +-
 drivers/leds/leds-lp3952.c                         |   4 +-
 drivers/leds/leds-lp5521.c                         |   2 +
 drivers/leds/leds-lp55xx-common.c                  |   4 +-
 drivers/leds/leds-mc13783.c                        |   6 +-
 drivers/leds/leds-mlxreg.c                         |   6 +-
 drivers/leds/leds-mt6323.c                         |   6 +-
 drivers/leds/leds-nic78bx.c                        |   6 +-
 drivers/leds/leds-pca955x.c                        |  69 +--
 drivers/leds/leds-powernv.c                        |   5 +-
 drivers/leds/leds-pwm.c                            |   2 +-
 drivers/leds/leds-rb532.c                          |   5 +-
 drivers/leds/leds-regulator.c                      |   5 +-
 drivers/leds/leds-sc27xx-bltc.c                    |  10 +-
 drivers/leds/leds-sunfire.c                        |   8 +-
 drivers/leds/leds-tca6507.c                        |   8 +-
 drivers/leds/leds-turris-omnia.c                   | 362 ++++++++++--
 drivers/leds/leds-wm831x-status.c                  |   6 +-
 drivers/leds/leds-wm8350.c                         |   5 +-
 drivers/leds/rgb/Kconfig                           |  13 +
 drivers/leds/rgb/Makefile                          |   1 +
 drivers/leds/rgb/leds-ktd202x.c                    | 625 +++++++++++++++++++++
 drivers/leds/rgb/leds-mt6370-rgb.c                 |   2 +-
 drivers/leds/rgb/leds-qcom-lpg.c                   |   8 +-
 .../leds/simple/simatic-ipc-leds-gpio-apollolake.c |   8 +-
 drivers/leds/simple/simatic-ipc-leds-gpio-core.c   |   4 +-
 .../simple/simatic-ipc-leds-gpio-elkhartlake.c     |   7 +-
 drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c |   8 +-
 drivers/leds/simple/simatic-ipc-leds-gpio.h        |   6 +-
 drivers/leds/trigger/Kconfig                       |   5 +-
 drivers/leds/trigger/ledtrig-cpu.c                 |   4 +-
 drivers/leds/trigger/ledtrig-gpio.c                | 137 ++---
 drivers/leds/trigger/ledtrig-netdev.c              |   6 +-
 59 files changed, 1349 insertions(+), 366 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/kinetic,ktd202x.yaml
 create mode 100644 drivers/leds/rgb/leds-ktd202x.c

-- 
Lee Jones [李琼斯]

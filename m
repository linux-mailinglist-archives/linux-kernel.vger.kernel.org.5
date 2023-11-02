Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A9A7DF516
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjKBOdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjKBOdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:33:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52F41FC3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:30:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1EFC433C7;
        Thu,  2 Nov 2023 14:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698935446;
        bh=85p+CLu4W0AnfKF5ReDjg/r2RQF5LGFbBJEBrfcMLA4=;
        h=Date:From:To:Cc:Subject:From;
        b=W/bx7FCYor3dDpn7vQLXj0Bi6tykYM8NCF0GO0tK2+gQptOCI7CRb5IvkMAlOxk9N
         tWXAEhMUC7DDR+7uWmBjCm/Ks7L5EybPbKqObJIHv8wGF/vO1s9zYtZ5EMf1Gr8KS2
         CwCbjpOVCtycKZOLgFwa6h1OE/YVGqJT/xX7F3rLtV9DtCHLF6HIgR3f6SNTf/c3V5
         G6syJUBU4TGfq1woUdjKE/B+5pa4mqRY890TIRt1M43PBuAorrjXMFJa3w2cH3XDIx
         dfNejkGIKTaoonbKmLcdnW1utqOknYWkUOBfgUOyoNv1/Wo4WyIy1Ci8MAofgWgtqD
         fLdQx5OuxRyZg==
Date:   Thu, 2 Nov 2023 14:30:41 +0000
From:   Lee Jones <lee@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [GIT PULL] Backlight for v6.7
Message-ID: <20231102143041.GY8909@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon Linus,

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-6.7

for you to fetch changes up to d5272d39995f4150062a67e6f2cef556edece740:

  dt-bindings: backlight: Add brightness-levels related common properties (2023-10-19 13:27:36 +0100)

----------------------------------------------------------------
 - New Functionality
   - Add new Device Tree binding for Monolithic Power (MPS) MP3309C step-up converter
   - Document brightness-levels in bindings for; generic, LED and PWM

 - Bug Fixes
   - Ensure PWMs are disabled on; .shutdown(), .suspend() and .remove()

----------------------------------------------------------------
Flavio Suligoi (2):
      dt-bindings: backlight: Add MPS MP3309C
      dt-bindings: backlight: Add brightness-levels related common properties

Uwe Kleine-König (1):
      backlight: pwm_bl: Disable PWM on shutdown, suspend and remove

 .../devicetree/bindings/leds/backlight/common.yaml | 17 +++++
 .../bindings/leds/backlight/led-backlight.yaml     | 19 ++----
 .../bindings/leds/backlight/mps,mp3309c.yaml       | 73 ++++++++++++++++++++++
 .../bindings/leds/backlight/pwm-backlight.yaml     | 20 ++----
 drivers/video/backlight/pwm_bl.c                   | 22 +++++++
 5 files changed, 120 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml

-- 
Lee Jones [李琼斯]


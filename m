Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1D8791979
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243581AbjIDOLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240620AbjIDOLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:11:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D38BCDF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 07:11:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0B93B80E43
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 14:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FA0C433C9;
        Mon,  4 Sep 2023 14:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693836703;
        bh=wi4WfZYXRCj7Aue0BgzcwfADSeECX6e4g6fL9auiHNQ=;
        h=Date:From:To:Cc:Subject:From;
        b=swF2RZygra4TZyMaG1Vdl9J+e36Sw6gMLFdf7Kd+SpZh8t5dPGfGkkMov52i0t/M7
         rYapZGyjyzAq3O8g0pvlmnEhDs9IT2WzG4/Dv2YcD4I5Q53Za5buTsg3mtZh0Z4zJ6
         m4q3wyPY0fQf+9cXBJDXQWYh+xKI82IhdiTbqPH2wApcB5+jjvn1YnmqT/DjqpeE5A
         Exno04zeYge7HoFf//mEOB4gXkz7LawJ95WHJ9KnS1E7yIdJx3oCp0emGbab3m3r6r
         GXPkQA09vENjFeAJ67KHzvISzRQvQuByZBxl6KgPyC1LJklNUzKeSKbZgkzac8Jsea
         tSwyxaLOz8nYA==
Date:   Mon, 4 Sep 2023 15:11:39 +0100
From:   Lee Jones <lee@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [GIT PULL] Backlight for v6.6
Message-ID: <20230904141139.GC13143@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon Linus,

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-6.6

for you to fetch changes up to a4464092f2c514a7f0788906d340f0bab59fdd73:

  backlight: led_bl: Remove redundant of_match_ptr() (2023-08-21 12:16:56 +0100)

----------------------------------------------------------------
 - New Functionality
   - Ensure correct includes are present and remove some that are not required
   - Drop redundant of_match_ptr() call to cast pointer to NULL

 - Bug Fixes
   - Revert to old (expected) behaviour of initialising PWM state on first brightness change
   - Correctly handle / propagate errors
   - Fix 'sometimes-uninitialised' issues

----------------------------------------------------------------
Artur Weber (3):
      backlight: lp855x: Initialize PWM state on first brightness change
      backlight: lp855x: Catch errors when changing brightness
      backlight: lp855x: Drop ret variable in brightness change function

Rob Herring (1):
      backlight: qcom-wled: Explicitly include correct DT includes

Ruan Jinjie (1):
      backlight: led_bl: Remove redundant of_match_ptr()

Ying Liu (1):
      backlight: gpio_backlight: Drop output GPIO direction check for initial power state

 drivers/video/backlight/gpio_backlight.c |  3 +--
 drivers/video/backlight/led_bl.c         |  2 +-
 drivers/video/backlight/lp855x_bl.c      | 33 ++++++++++++++++++--------------
 drivers/video/backlight/qcom-wled.c      |  2 +-
 4 files changed, 22 insertions(+), 18 deletions(-)

-- 
Lee Jones [李琼斯]

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C637FF119
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345749AbjK3OCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345768AbjK3OCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:02:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C51A10E3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:02:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61191C433C9;
        Thu, 30 Nov 2023 14:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701352970;
        bh=0HfzENfinj2Ja46P/LCKGr17zbnVTr1k9b/TXJfjupU=;
        h=Date:From:To:Cc:Subject:From;
        b=XDilvnhgVzh8VzxVTvN6EQh1mm0c91Gi/vMaMi8yYMhcMFmPMEcjBK3fOyQLSZ6jg
         3igYPTMONabeTxlbnCZIuXNXqxSP5ika8ZN0sSiTZ/7HUUSczOcBKoBG8Mjd59tft8
         70qZ7R4kPA++ZioLOoolQDSHZgKc2dM096mMc6g3Qto2SgDnCcpGac0MD9p1GplYja
         DdQgVAJYAzaM90l2X3OwIq0JCLDeuBfHzj211jh9fxzeYGR6u0R8ezbsxV5R+D1YDQ
         RvsNt/2UUz39fBnaeiXOC3n23vSTaNgZfQZZbuNB4teu2I/tphycmVvcaiwWNctl+i
         tCtjZZBhb58jQ==
Date:   Thu, 30 Nov 2023 14:02:46 +0000
From:   Lee Jones <lee@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Takashi Iwai <tiwai@suse.de>
Subject: [GIT PULL] LEDs fixes for v6.7
Message-ID: <20231130140246.GK1470173@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon Linus,

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git tags/leds-fixes-6.7

for you to fetch changes up to 8f2244c9af245ff72185c0473827125ee6b2d1a5:

  leds: class: Don't expose color sysfs entry (2023-11-22 11:46:03 +0000)

----------------------------------------------------------------
 - Core Frameworks
   - Remove duplicate sysfs entry 'color' from LEDs class

----------------------------------------------------------------
Takashi Iwai (1):
      leds: class: Don't expose color sysfs entry

 Documentation/ABI/testing/sysfs-class-led |  9 ---------
 drivers/leds/led-class.c                  | 14 --------------
 2 files changed, 23 deletions(-)

-- 
Lee Jones [李琼斯]

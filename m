Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262A17C52D1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbjJKMBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234926AbjJKMBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:01:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8FDC9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:01:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D816C433C8;
        Wed, 11 Oct 2023 12:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697025663;
        bh=h6LidJ0i1sCBvJ8nX/Vk8Dh7A1FFZLBmHx/ZyXwM204=;
        h=Date:From:To:Cc:Subject:From;
        b=uNv/Prf/cv3h/vzWCXO0wAwwk4hk8WnZI95XhDhjLXjz875PAD878Zx/Z7HI612Sa
         SfaBsy6swHAY26fmC6+AfBw6FuVFHWAPMGVglH9qiTM145GivQLbHMAtBjQLvBD3Vq
         opZYrHUWMlemgXsaJooqrgGySfu0i3g0MkYy1E4C6vjgmJHpJIVGRFuNIypwJ+O/En
         EnWFPkR4/5aTI/wdIqmCoTBgSoFblWRJWaQvMwgi7uJ7f0W0wF9NaHMd55caLgi07q
         186d8XgvB5+zRQHbz6/hzNi4vvelnyM0IDihghx0sTR3Yp/n6Qhz1uydMLVFX+6X9Q
         7+P5NRGNjXeCw==
Date:   Wed, 11 Oct 2023 14:00:59 +0200
From:   Benjamin Tissoires <bentiss@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes
Message-ID: <4wjxfhlg6z5kjfmazfkjfgnsdwrsrzg4muxv7pzts4kojopsfu@wwfmx6547462>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023101101

to get HID subsystem fixes for 6.6.

=====
- regression fix for i2c-hid when used on DT platforms (Johan Hovold)
- kernel crash fix on removal of the Logitech USB receiver (Hans de Goede)

=====

Hopefully this time my English is better :/

Thanks.

----------------------------------------------------------------
Hans de Goede (1):
      HID: logitech-hidpp: Fix kernel crash on receiver USB disconnect

Johan Hovold (1):
      HID: i2c-hid: fix handling of unpopulated devices

 drivers/hid/hid-logitech-hidpp.c   |   3 ++-
 drivers/hid/i2c-hid/i2c-hid-core.c | 144 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------------------------
 2 files changed, 83 insertions(+), 64 deletions(-)

--
Cheers,
Benjamin

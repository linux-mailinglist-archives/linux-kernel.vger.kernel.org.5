Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3658F78973A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 16:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjHZOOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 10:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjHZOO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 10:14:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9778B173F
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 07:14:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BC1E616CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 14:14:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E7AC433C7;
        Sat, 26 Aug 2023 14:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693059265;
        bh=9R8YO3MXdr5KgQbfCte9z6M2Z+Y4ytGOjtrgTyNoZpU=;
        h=From:To:Cc:Subject:Date:From;
        b=lLfxsuzk0BwrNWznvTH0XAIm1Kq1zVea306iXZmftpU99r6IwznvvlLEJS7l4xCkt
         JlvBdCNHwiOkEF4mPKQCUhV+oJ8/iI9P3JT24TPkiGf01o2RgSE1b1bNek28SkFPb4
         hd3UsAjxjsuiyRkA5hZBjFCtvZjppHkh09IGhaN/nh/XmAx4KSpxzyPTuYiOvNkq9M
         tdu8yqt7sm5pwC3RFloX9GlHPd/2C7jDhtRZfvq6tHRW3uUfY53uvPWADvJl39yp3W
         wXt6M3swdlI5deMminPKdLzO4FRgXC84btBJHuNdkE1WIX32L6Xri4l/tn6S836uEk
         jjBugv54Fi2Qg==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] auxdisplay for 6.6
Date:   Sat, 26 Aug 2023 16:14:12 +0200
Message-ID: <20230826141412.41764-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A small update for auxdisplay. It has been in linux-next for a week.

Please pull for v6.6 -- thanks!

Cheers,
Miguel

The following changes since commit 2ccdd1b13c591d306f0401d98dedc4bdcd02b421:

  Linux 6.5-rc6 (2023-08-13 11:29:55 -0700)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/auxdisplay-6.6

for you to fetch changes up to 35b464e32c8bccef435e415db955787ead4ab44c:

  auxdisplay: hd44780: move cursor home after clear display command (2023-08-19 21:53:49 +0200)

----------------------------------------------------------------
auxdisplay update for v6.6

 - hd44780: move cursor home after clear display command

   The change allows to support displays like the NewHaven
   NHD-0220DZW-AG5 which has a non-standard controller.

----------------------------------------------------------------
Hugo Villeneuve (1):
      auxdisplay: hd44780: move cursor home after clear display command

 drivers/auxdisplay/hd44780_common.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

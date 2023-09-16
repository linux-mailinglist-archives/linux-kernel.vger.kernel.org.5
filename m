Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C71C7A2FCF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 14:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbjIPMAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 08:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjIPMAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 08:00:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3D3CCD
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 04:59:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8F6C433C7;
        Sat, 16 Sep 2023 11:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694865598;
        bh=gUYn1boYKCebIo7ZO9DJxSeqqd1YStvLwVMVr/TMHeA=;
        h=Date:From:To:Cc:Subject:From;
        b=bgBUix2sE7NXcY2NPi6hBA7El8hYhMqfoLmi5f//8y8RgLSczdrHXDvqgpcaC/DF9
         s/OEo9Vji3cDwlLMW2Tl+Gxj1uUSyuFKIhZms/Yxy/ZBPwBC6jNCfQKORySHjD7YLx
         sTdD0hERO/ATdwrN5G4FKD/UonkYxOUjQISkGOVQ=
Date:   Sat, 16 Sep 2023 13:59:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fix for 6.6-rc2
Message-ID: <ZQWYu7xf_8KTWXFu@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.6-rc2

for you to fetch changes up to f26a679ed799deef9e2934a6b60b8f38bdbf4921:

  usb: typec: ucsi: Fix NULL pointer dereference (2023-09-11 13:52:16 +0200)

----------------------------------------------------------------
USB fix for 6.6-rc2

Here is a single USB fix for a much-reported regression for 6.6-rc1.

It resolves a crash in the typec debugfs code for many systems.  It's
been in linux-next with no reported issues, and many people have
reported it resolving their problem with 6.6-rc1.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Heikki Krogerus (1):
      usb: typec: ucsi: Fix NULL pointer dereference

 drivers/usb/typec/ucsi/debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

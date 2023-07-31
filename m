Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F9E7690EC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjGaJAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGaJAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:00:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E824B7;
        Mon, 31 Jul 2023 02:00:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FF6160F94;
        Mon, 31 Jul 2023 09:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA16C433C8;
        Mon, 31 Jul 2023 09:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690794005;
        bh=BcdJOCOvfo8+7qQhbdTLh8aFMXzejg7630OC9etO7XQ=;
        h=From:To:Cc:Subject:Date:From;
        b=FcTkxNLikH8fSXz2XDSU3qfG0CqU2tXHPlvvSndo9GBqinO7CzJuapptWJR3hnCXE
         mjskJl4Y+8gYClk3de1OmVXU7mrDj8Z4cbeLpHPXl3RYDYCZBwGmDz/LfTAfLgmQWB
         D0CCQS70320V3IfGohaFsA+SYoZ3p5aEykgHGkPSUy1TjXdZE6EwJkVXwjG31Mc01E
         47Hgf5lYzK8dAmx2z7NbkLJ2uj7wfM56OMILHjeDhbyqOOaVbVEdE/HqwfIc6eveFs
         QLDxaY6pdgaWq12BTLiOPrS+CwVB1don7MwL6S/tfOFfPJ6KKkHp7kMG7BGdB0LH6R
         zpUkp9uREXnOQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 0/7] tty: synclink_gt: mark as BROKEN
Date:   Mon, 31 Jul 2023 10:59:55 +0200
Message-ID: <20230731090002.15680-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
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

I did some cleanups in the driver (in this series), but then decided not
to go on and mark the driver as BROKEN instead. See the last patch for
explanation.

Feel free to take only the last patch. I don't assume anyone appears to
take care of the driver, so we will drop it sooner or later anyway. The
changes only demonstrate how unmaintained the driver is...

Jiri Slaby (SUSE) (7):
  tty: synclink_gt: convert CALC_REGADDR() macro to an inline
  tty: synclink_gt: drop global slgt_driver_name array
  tty: synclink_gt: define global strings as const strings
  tty: synclink_gt: drop info messages from init/exit functions
  tty: synclink_gt: use PCI_VDEVICE
  tty: synclink_gt: make default_params const
  tty: synclink_gt: mark as BROKEN

 drivers/tty/Kconfig       |  1 +
 drivers/tty/synclink_gt.c | 65 ++++++++++++++++-----------------------
 2 files changed, 28 insertions(+), 38 deletions(-)

-- 
2.41.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A4B7A2FCE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 14:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbjIPL7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 07:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238123AbjIPL7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 07:59:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA962CCB
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 04:59:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21020C433C8;
        Sat, 16 Sep 2023 11:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694865571;
        bh=mzoVyVKRVpO07eBhxKowz5IZt6J187Oq2WelLQ0zG+Q=;
        h=Date:From:To:Cc:Subject:From;
        b=VugREvb2XGr2uZNilYdyd+zL6oi6XVyYToWc4hj4tMcg2wDdVjwlbFuKKeN7xtVK9
         M1fXaW5bVskayNgYsg8CTbNC0En9rmhyfZYi6eQ52OSD7wKeLwYuNEMk831iPiyNXO
         ZXu/qgSsd7OJrfyeeGa0HS1s5QxgzcIgZDTBJv18=
Date:   Sat, 16 Sep 2023 13:59:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core fix for 6.6-rc2
Message-ID: <ZQWYoJkwI85bJ5tz@kroah.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.6-rc2

for you to fetch changes up to 139e08188babf7a4c5f0df54b605105852fc347a:

  Documentation: embargoed-hardware-issues.rst: Add myself for RISC-V (2023-09-13 09:19:49 +0200)

----------------------------------------------------------------
Driver core fix for 6.6-rc2

Here is a single driver core fix for a much-reported-by-sysbot issue
that showed up in 6.6-rc1.  It's been submitted by many people, all in
the same way, so it obviously fixes things for them all.

Also in here is a single documentation update adding riscv to the
embargoed hardware document in case there are any future issues with
that processor family.

Both of these have been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (1):
      driver core: return an error when dev_set_name() hasn't happened

Palmer Dabbelt (1):
      Documentation: embargoed-hardware-issues.rst: Add myself for RISC-V

 Documentation/process/embargoed-hardware-issues.rst | 1 +
 drivers/base/core.c                                 | 2 ++
 2 files changed, 3 insertions(+)

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6177DA45B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 02:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346739AbjJ1A0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 20:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJ1A0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 20:26:18 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098D91B9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 17:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=55lOmAGAraDAOtxbJfYWaCAJ+P7+/WKsnEiG0JtycEU=; b=B72wZy3uaEFKXSjGvAnbcZoaQf
        uZPnOngke4dDMf3orBrOYo87hD6yEME2wH6TWRQ5wOwYeQthwOcY3qOncRcMDglgUTKhL3vX+UP4j
        4wfGoufQMk7aTsN9II40rtvhOuzj2ljUbzcysx3hMB4mupkybc6Bmd2ebABuiQ0XkWg9yjHKe7tmE
        h4A1eG1ImZbb3QVzVIeXaPBYRt7I9l9z+KfSpQUTfT1qHqwGI/9KdAC0jlAin3ePbmDQmJIJa5JGu
        GKFC5i/mHG2wygT23dl5TAcL0QTVnbykFhXijnQlyef1d3CVSNWc1tlrYFOHiAVLDzqPMJXAkUne5
        Rg+ONvKA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qwX9Z-006nzK-0X;
        Sat, 28 Oct 2023 00:26:13 +0000
Date:   Sat, 28 Oct 2023 01:26:13 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] misc fixes
Message-ID: <20231028002613.GN800259@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 94f6f0550c625fab1f373bb86a6669b45e9748b3:

  Linux 6.6-rc5 (2023-10-08 13:49:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

for you to fetch changes up to dc32464a5fe4946fe1a4d8f8e29961dc411933c5:

  ceph_wait_on_conflict_unlink(): grab reference before dropping ->d_lock (2023-10-27 20:14:38 -0400)

Literally nothing in common; could've been 3 separate pull requests.
All are simple regression fixes, but not for anything from this cycle.

----------------------------------------------------------------
assorted fixes all over the place

----------------------------------------------------------------
Al Viro (3):
      sparc32: fix a braino in fault handling in csum_and_copy_..._user()
      io_uring: kiocb_done() should *not* trust ->ki_pos if ->{read,write}_iter() failed
      ceph_wait_on_conflict_unlink(): grab reference before dropping ->d_lock

 arch/sparc/lib/checksum_32.S | 2 +-
 fs/ceph/mds_client.c         | 2 +-
 io_uring/rw.c                | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F197C9A18
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 18:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjJOQnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 12:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJOQnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 12:43:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F531AD;
        Sun, 15 Oct 2023 09:43:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8D5C433C8;
        Sun, 15 Oct 2023 16:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697388202;
        bh=mBV9ylSnWXa7wsz/5JIt85htDDq31tB9xRWxJWWoPQE=;
        h=From:To:Cc:Subject:Date:From;
        b=bgNnyWzF0vgrEDx7lBjPAG+f+dX8Z+7X1Jq2jsQKez94J3zLIJYB6FZkW/pHPzoJe
         2qShm2w6uEG9g9nU2dRSACMPg6BzWgH8k+fiDWyCb49LfdPSmfkiiNGAs0npA4fxYJ
         sn0czsZ8FyaqTkVQDgLzyvh3whbdeFcqdr3zSlXE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.58
Date:   Sun, 15 Oct 2023 18:43:18 +0200
Message-ID: <2023101518-subscript-entity-be71@gregkh>
X-Mailer: git-send-email 2.42.0
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

I'm announcing the release of the 6.1.58 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                 |    2 
 fs/nfs/direct.c          |  134 ++++++++++++++---------------------------------
 fs/nfs/write.c           |   23 +++-----
 include/linux/nfs_page.h |    4 -
 lib/test_meminit.c       |    2 
 5 files changed, 55 insertions(+), 110 deletions(-)

Greg Kroah-Hartman (7):
      Revert "NFS: More fixes for nfs_direct_write_reschedule_io()"
      Revert "NFS: Use the correct commit info in nfs_join_page_group()"
      Revert "NFS: More O_DIRECT accounting fixes for error paths"
      Revert "NFS: Fix O_DIRECT locking issues"
      Revert "NFS: Fix error handling for O_DIRECT write scheduling"
      lib/test_meminit: fix off-by-one error in test_pages()
      Linux 6.1.58


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D951811909
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377970AbjLMQTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbjLMQSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:18:55 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32ED51A6;
        Wed, 13 Dec 2023 08:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=7rWy5XWiTjoPkItro/VsBDG3wudUvVA8NmkBjomTzUo=; b=V19QhVTb4gkpH0c2lEIwOexRUj
        xhX+kvCWGy0PXcN4Dwth1YJLz7RI8Qi8p7/JI8TK86K4RI9Oh4eJOh9B6yCzGyjlWvTKOWoWROejm
        AxxnRSmxRYzczuK9w5lzQDvetEAou5Z8g9h98/S+9DiyPkdxITE4wmY5tvZ7uOtB/8Jx5v6NNXOBk
        hzgawRnGXb2yO78IMF7JLh+b4KJw2DSy4CtGpzzp7abt3E2UkpOHe9S5YSyaXgfEAcIaPDUPDYoN1
        FSEb020DrmfIO14SxJZosxzwmJY4shaWkNHSKSjXweRryxKJOHakOJ60vdvJ+zckZlBCU+z7Y224C
        NkIiXEeg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rDRwn-00Bpq0-0A;
        Wed, 13 Dec 2023 16:18:57 +0000
Date:   Wed, 13 Dec 2023 16:18:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] ufs fix
Message-ID: <20231213161857.GN1674809@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

for you to fetch changes up to 485053bb81c81a122edd982b263277e65d7485c5:

  fix ufs_get_locked_folio() breakage (2023-12-13 11:14:09 -0500)

----------------------------------------------------------------
ufs got broken this merge window on folio conversion - calling
conventions for filemap_lock_folio() are not the same as for
find_lock_page()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (1):
      fix ufs_get_locked_folio() breakage

 fs/ufs/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

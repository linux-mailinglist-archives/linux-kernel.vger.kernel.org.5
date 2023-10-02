Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE96F7B50A8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 12:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbjJBKym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 06:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbjJBKyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:54:40 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFD4B4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 03:54:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C25246340E0F;
        Mon,  2 Oct 2023 12:54:36 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id auzUsoEp9ASw; Mon,  2 Oct 2023 12:54:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 767576340E0E;
        Mon,  2 Oct 2023 12:54:36 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id K09owi8AKj8W; Mon,  2 Oct 2023 12:54:36 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 590156340DEB;
        Mon,  2 Oct 2023 12:54:36 +0200 (CEST)
Date:   Mon, 2 Oct 2023 12:54:36 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <764987343.25592.1696244076263.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UBI fixes for v6.6-rc5
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: 7nU+P4NwjJl3FRuYxfDJrq7PNmNoIw==
Thread-Topic: UBI fixes for v6.6-rc5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 4a0fc73da97efd23a383ca839e6fe86410268f6b:

  Merge tag 's390-6.6-2' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2023-09-07 10:52:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.6-rc5

for you to fetch changes up to 017c73a34a661a861712f7cc1393a123e5b2208c:

  ubi: Refuse attaching if mtd's erasesize is 0 (2023-09-07 21:59:04 +0200)

----------------------------------------------------------------
This pull request contains the following fix for UBI:

- Don't try to attach MTDs with erase block size 0

----------------------------------------------------------------
Zhihao Cheng (1):
      ubi: Refuse attaching if mtd's erasesize is 0

 drivers/mtd/ubi/build.c | 7 +++++++
 1 file changed, 7 insertions(+)

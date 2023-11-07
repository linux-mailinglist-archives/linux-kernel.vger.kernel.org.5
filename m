Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8149B7E38D2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbjKGKTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbjKGKTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:19:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BCE116
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:19:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A49C433C7;
        Tue,  7 Nov 2023 10:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699352382;
        bh=A4VPcvJ4dA+Yy8VOtHRw4WXDaIsSxBzIv4UlMHj8gJs=;
        h=From:To:Cc:Subject:Date:From;
        b=sLtJCONeJ6nLpIRdKU8X4Q3JZFoYcS4azYOe+wFgV/Mbij8DHlBf0R4M5sOpI8q6u
         whedvNbxP9ddmU3DyW/JTXmfw6G7ex1SSPB6oCMd0n24HBEvZS9pNFkCrlyke7GNT8
         87sOd7qw5dwZ8So6989NYKi6wqgMMqFqK2oggc+cPHJPZ3DPpj+K7AnGUrDyWGizBK
         Jb+caC0Xi1bTFTP+28Op6YGnSf2aT7iPItFHOQ+FQRqa4D5O6MjVcBta2o3r1DP5O/
         WVjrD8et+PmI4Z5bp/vyuldDurbdhVj671HmzgdzdStDJbxkSFLybRr6JgqMb8IwgA
         WKFBOmv9N2aTQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs iomap updates
Date:   Tue,  7 Nov 2023 11:18:34 +0100
Message-Id: <20231107-vfs-iomap-60b485c2b4fb@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1351; i=brauner@kernel.org; h=from:subject:message-id; bh=A4VPcvJ4dA+Yy8VOtHRw4WXDaIsSxBzIv4UlMHj8gJs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR68d2aajXBTNn/85MpagFbnbWUD++JfZ77aDuj84ZfnfWX pvsv7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIsikjw4aQny+tLgjP2sNg4VKw+I 9hh9X2HRseHziz9f/UIzwnYyQYGRY49UhOKUqbbm93fsb+nYJMtn3r1jdzzKp6aFQkv8dwHQsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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

Hey Linus,

/* Summary */
As discussed on list last week this makes fs/iomap part of vfs.git with
Darrick as main reviewer.

/* Testing */
clang: Debian clang version 16.0.6 (16)
gcc: gcc (Debian 13.2.0-5) 13.2.0

All patches are based on v6.6 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit ffc253263a1375a65fa6c9f62a893e9767fbebfa:

  Linux 6.6 (2023-10-29 16:31:08 -1000)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.iomap

for you to fetch changes up to 64bc7eee421fafc5d491d65bff74f46430fe61af:

  iomap: rename iomap entry (2023-11-07 10:52:08 +0100)

Please consider pulling these changes from the signed vfs-6.7.iomap tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.7.iomap

----------------------------------------------------------------
Christian Brauner (1):
      iomap: rename iomap entry

Darrick J. Wong (1):
      iomap: rotate maintainers

 MAINTAINERS | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

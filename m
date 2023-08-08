Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F487773F74
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbjHHQsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbjHHQrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:47:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE43170E4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691510161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dTX14N9/0e74HCqepsk/apUoVl7UMygGmrFkx9a+jkY=;
        b=bbw6aQvcJ1WGsFmBDJg7vT/z0ZO4QuOThL6SYL5tQcEWsXSscyIY7GW9TA6HsivCgI5E/p
        VwdFMcDWGTk3jrwymV9BajcARr441gFcxymswt6n1P1KWxnl2NfqfuvpA/sT25U7Duw5Yd
        pZGhmCeIGxVXZZS4Ty0mGN8HklMAmA4=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-179-Zm8CYJDlO7ixagSsCGnqDA-1; Tue, 08 Aug 2023 08:53:17 -0400
X-MC-Unique: Zm8CYJDlO7ixagSsCGnqDA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8305C3C11C68;
        Tue,  8 Aug 2023 12:53:17 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.225.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0DBE2026D4B;
        Tue,  8 Aug 2023 12:53:16 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 fixes
Date:   Tue,  8 Aug 2023 14:53:15 +0200
Message-Id: <20230808125315.1727575-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following two gfs2 fixes.

Thanks,
Andreas

The following changes since commit 94c76955e86a5a4f16a1d690b66dcc268c156e6a:

  Merge tag 'gfs2-v6.4-rc5-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2023-07-04 11:45:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.4-fixes

for you to fetch changes up to 0be8432166a61abc537e1247e530f4b85970b56b:

  gfs2: Don't use filemap_splice_read (2023-08-07 18:42:04 +0200)

----------------------------------------------------------------
gfs2 fixes

- Fix a freeze consistency check in gfs2_trans_add_meta().

- Don't use filemap_splice_read as it can cause deadlocks on gfs2.

----------------------------------------------------------------
Andreas Gruenbacher (1):
      gfs2: Fix freeze consistency check in gfs2_trans_add_meta

Bob Peterson (1):
      gfs2: Don't use filemap_splice_read

 fs/gfs2/file.c  |  4 ++--
 fs/gfs2/trans.c | 14 ++++++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)


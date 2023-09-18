Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D957A4CE7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjIRPnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjIRPnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:43:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168951726
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695051309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LEt+aOCH+NJxKysD6ybSjGWUVqM+LPVA1IYSdCJ4bi4=;
        b=KFDRn7rw2BVlQ7KYgL1GJWl1ZBkam7VNpGhu92SHvehwkq73vw/lAGi20Or5ef+oFXNa7H
        ZrppEMePAjpM9exCNdS885D6JdyqxIX/WRloekG6/FzNg+DmFUgozM28Qkt5cfTCUTp53w
        Kjzb6qkqxFFV6tZKMe4QQiHq23q0wFk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-auOuSAFcP3e2-wILCT6xgw-1; Mon, 18 Sep 2023 10:34:40 -0400
X-MC-Unique: auOuSAFcP3e2-wILCT6xgw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4295858296;
        Mon, 18 Sep 2023 14:34:39 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.226.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD88340C2064;
        Mon, 18 Sep 2023 14:34:38 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 fixes
Date:   Mon, 18 Sep 2023 16:34:38 +0200
Message-Id: <20230918143438.2739942-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

pleae consider pulling the following gfs2 fixes.

Thank you,
Andreas

The following changes since commit 65d6e954e37872fd9afb5ef3fc0481bb3c2f20f4:

  Merge tag 'gfs2-v6.5-rc5-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2023-09-05 13:00:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.6-rc1-fixes

for you to fetch changes up to fb95d536080e6c1db099f0023f59cd55adcc5d87:

  gfs2: Fix quota=quiet oversight (2023-09-18 16:26:24 +0200)

----------------------------------------------------------------
gfs2 fixes

- Fix another freeze/thaw hang

- Fix glock cache shrinking

- Fix the quota=quiet mount option.

----------------------------------------------------------------
Andreas Gruenbacher (1):
      gfs2: Fix another freeze/thaw hang

Bob Peterson (2):
      gfs2: fix glock shrinker ref issues
      gfs2: Fix quota=quiet oversight

 fs/gfs2/glock.c | 4 +++-
 fs/gfs2/glops.c | 9 +++++----
 fs/gfs2/quota.h | 3 ++-
 3 files changed, 10 insertions(+), 6 deletions(-)


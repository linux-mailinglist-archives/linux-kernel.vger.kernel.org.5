Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5638B7F635D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346205AbjKWPxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346192AbjKWPx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:53:28 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013AAD5A;
        Thu, 23 Nov 2023 07:53:34 -0800 (PST)
Received: from arisu.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ABA3E6607328;
        Thu, 23 Nov 2023 15:53:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700754813;
        bh=eQSQ9kZBc9hWlP0jIUGHqy0Ce7PCPO42UcQIm6uTYF4=;
        h=From:To:Cc:Subject:Date:From;
        b=lQzU/VpeLikRTi5CCQwZJ6Z7sGJrMWFJjkcpJOsCfPywHZFpLakXk3qW9ru4MZTBg
         1EzKLb967gl5naJyLCkhgLEr9d+KZO0ki/DWvdOBACyUI48SQ/G9o6Bpup3H2O/hOF
         KDi9Z5JSadGq6Rd+FVW1pk4thfLBba6/94gmt0V2ycdF/ahV1Qcz1MzeU2l04/Te2Z
         CVagHW541tHMwgR3syYq1GEfxikG9TUendGRlDOQ4CHYBwOj81A8y401m/8aA46xqu
         coo7S8fcevGEilI72r8d1KH8f+uK6eeSrwvkoC+aMqh1E1rbajW04pn6OU0RCOQMSa
         qu6q8GBMTkbgQ==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-media@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v3 0/2] visl: Add support for AV1
Date:   Thu, 23 Nov 2023 10:52:24 -0500
Message-ID: <20231123155342.56277-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AV1 support is missing in the visl test driver.
Add it and adapt documentation.

The traces are missing for some fields, basically:
- multi-dimensional arrays
- arrays of flags
- enums
which don't have a __print_* macro.

Changes since v2:
- Fix the ref_frame indexing
Changes since v1:
- Rebased on media_tree/master

Detlev Casanova (2):
  visl: Add AV1 support
  doc: visl: Add AV1 support

 Documentation/admin-guide/media/visl.rst      |   2 +
 drivers/media/test-drivers/visl/visl-core.c   |  21 ++
 drivers/media/test-drivers/visl/visl-dec.c    |  72 +++-
 drivers/media/test-drivers/visl/visl-dec.h    |   8 +
 .../media/test-drivers/visl/visl-trace-av1.h  | 314 ++++++++++++++++++
 .../test-drivers/visl/visl-trace-points.c     |   1 +
 drivers/media/test-drivers/visl/visl-video.c  |  18 +
 drivers/media/test-drivers/visl/visl-video.h  |   1 +
 drivers/media/test-drivers/visl/visl.h        |   1 +
 9 files changed, 437 insertions(+), 1 deletion(-)
 create mode 100644 drivers/media/test-drivers/visl/visl-trace-av1.h

-- 
2.41.0


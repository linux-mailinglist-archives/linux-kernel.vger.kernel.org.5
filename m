Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A6A7875A8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242632AbjHXQkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242673AbjHXQkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:40:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C2D198;
        Thu, 24 Aug 2023 09:40:06 -0700 (PDT)
Received: from ginger.. (unknown [189.115.8.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: koike)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3F9916607276;
        Thu, 24 Aug 2023 17:40:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692895205;
        bh=J8b2QT9rrJ018sKXflFL3FjdhNbqyS9w7fXnjXrLUcM=;
        h=From:To:Cc:Subject:Date:From;
        b=ROoNObRj3jfoWAYldXHpGfSLSdoQL0iecq4jjC3aAMkDzvlfJf2j0KKhKC8dTCUXx
         JVmPBX4RUoJxu7m9UWOJwaMH6iyvO1lvxAEjYRyTpodLJovyHP7L8UjICJFSQzn5OL
         ko1+HLg9AfvzY3TfqoSsPeu9Dsuezfo5I5J0VgIQMRqY7oLkslDARqwOft+KNdMwzI
         WD+93mbT9JraJwmKrtxoROYdj3bb7jb6QPvcvqplnYg4TVozPi9nr8zYyfo0H/4YqG
         VVWUqSkwCHJNJEXPjDaFCc2oIAaw9AmDFz4py4LTA8WJE9bs9zgBaxm0j0M3eTyRON
         U8mgzqBI6QLww==
From:   Helen Koike <helen.koike@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, airlied@gmail.com
Subject: [PATCH] drm: ci: docs: fix build warning - add missing scape
Date:   Thu, 24 Aug 2023 13:39:54 -0300
Message-Id: <20230824163954.47881-1-helen.koike@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warning:

Documentation/gpu/automated_testing.rst:55: WARNING: Inline emphasis start-string without end-string.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Helen Koike <helen.koike@collabora.com>

---

Patch for topic/drm-ci
---
 Documentation/gpu/automated_testing.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/automated_testing.rst b/Documentation/gpu/automated_testing.rst
index 1b87b802ac7f..469b6fb65c30 100644
--- a/Documentation/gpu/automated_testing.rst
+++ b/Documentation/gpu/automated_testing.rst
@@ -52,7 +52,7 @@ IGT_VERSION
 drivers/gpu/drm/ci/testlist.txt
 -------------------------------
 
-IGT tests to be run on all drivers (unless mentioned in a driver's *-skips.txt
+IGT tests to be run on all drivers (unless mentioned in a driver's \*-skips.txt
 file, see below).
 
 drivers/gpu/drm/ci/${DRIVER_NAME}-${HW_REVISION}-fails.txt
-- 
2.34.1


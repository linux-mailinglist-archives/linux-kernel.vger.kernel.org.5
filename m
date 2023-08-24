Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2662B7875BF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240354AbjHXQnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242743AbjHXQnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:43:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4F11FDE;
        Thu, 24 Aug 2023 09:42:47 -0700 (PDT)
Received: from ginger.. (unknown [189.115.8.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: koike)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 18F956607273;
        Thu, 24 Aug 2023 17:42:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692895360;
        bh=KEyNwtYYO4BSXGKpu8cyHNwnu4krA5gnS4naNjnuc2M=;
        h=From:To:Cc:Subject:Date:From;
        b=cR5YHUWiS5gT/bLp5SNr+AGlSISCof/y63WV89l2QZF0ajLiaHtxGbPWJgnv/xOQR
         v/8HkWQRqNbXnznf2uIwb2hEKhOFrrahAXlywrcVepldXtC6Xw0GAiOgP1irS8dtTu
         csO5B/Kx6wjFLtFeaJTs333QYI1TUjnEcJwP5BeDieddArrqsSdweSFxGVjDWe6ld1
         QahCCJSRTUDdInOBjm3iHyG/bu46fOwXBQGdkH4UCsPx+m2WNV+3M9TIAilTDdZJFj
         r8OfNFNYiPklZ+rQn6seWLA5TF0B5TCW5/K0naIlnG3vdP3ETT+PX3xBtnwq2qH/fK
         9G+Cc8gIs4DzQ==
From:   Helen Koike <helen.koike@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, airlied@gmail.com
Subject: [PATCH v2] drm: ci: docs: fix build warning - add missing escape
Date:   Thu, 24 Aug 2023 13:42:30 -0300
Message-Id: <20230824164230.48470-1-helen.koike@collabora.com>
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

V2:
- Fix typo s/scape/escape

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


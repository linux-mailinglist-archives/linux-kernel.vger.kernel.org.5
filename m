Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718907A5654
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 01:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjIRXvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 19:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjIRXvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 19:51:33 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855EC97
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 16:51:27 -0700 (PDT)
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx1.riseup.net (Postfix) with ESMTPS id 4RqM5B6dpgzDqPT;
        Mon, 18 Sep 2023 23:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1695081087; bh=a5qAWNm+UMJ0Oyu8eITh6RRhujsvqMrn9VkHcbL3nk4=;
        h=From:Subject:Date:To:Cc:From;
        b=Gi9naeRPYwfH4g16uMkNme4XZi6Ptq/dWqBKXpVegyvB/T1/wWwYU5mozgjXhYc33
         WiIXp7fGRw5X6OVwREgH6VBJEgO3uey3iPgwozKVuhxrkL+he/KONx43wIhImkImxm
         VPuqINPr/k5kyzNbZw978ooyFLpYlxQyVxt6YC6o=
X-Riseup-User-ID: E8D6C1456C108BD5DF881710FE9D7D15EC1552548AC2012A4B1F609724590B37
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4RqM4w6hB2zFpgC;
        Mon, 18 Sep 2023 23:51:12 +0000 (UTC)
From:   Arthur Grillo <arthurgrillo@riseup.net>
Subject: [PATCH RESEND v3 0/2] Add KUnit tests for drm_fb_blit()
Date:   Mon, 18 Sep 2023 20:51:03 -0300
Message-Id: <20230918-final-gsoc-v3-0-b999c042a4cc@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Arthur Grillo <arthurgrillo@riseup.net>, tales.aparecida@gmail.com,
        andrealmeid@riseup.net, mairacanal@riseup.net,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset tests the drm_fb_blit() function.

As this function can be used with already tested formats, the first
patch adds calls to drm_fb_blit() on the tests of supported formats.

Some supported formats were not yet covered by the existing tests
because they are only supported by drm_fb_blit(). The second patch
adds those format conversion tests.

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
---
Changes in v3:
- Fix memset sizes to avoid out-of-bound access
- Link to v2: https://lore.kernel.org/r/20230905-final-gsoc-v2-0-b52e8cb068ea@riseup.net

Changes in v2:
- Split the patch into two (Maíra Canal)
- Link to v1: https://lore.kernel.org/r/20230901-final-gsoc-v1-1-e310c7685982@riseup.net

---
Arthur Grillo (2):
      drm/tests: Add calls to drm_fb_blit() on supported format conversion tests
      drm/tests: Add new format conversion tests to better cover drm_fb_blit()

 drivers/gpu/drm/tests/drm_format_helper_test.c | 285 +++++++++++++++++++++++++
 1 file changed, 285 insertions(+)
---
base-commit: 37454bcbb68601c326b58ac45f508067047d791f
change-id: 20230901-final-gsoc-395a84443c8f

Best regards,
-- 
Arthur Grillo <arthurgrillo@riseup.net>


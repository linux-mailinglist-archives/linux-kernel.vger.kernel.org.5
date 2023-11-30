Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21A87FFBF8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376598AbjK3UIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376594AbjK3UH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:07:59 -0500
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D93910FC;
        Thu, 30 Nov 2023 12:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=pyLKFFJL0+QHAkvFUr9epX+zDms0kHGRY+0nNCweE+4=; b=VRCEDbxyM4FF5Dt9ADAKKchvzy
        K5FxoPzCUxIch4XBRnoCKBVF4kaTMkl00Pi7kuUWTciw8vZwbQr7NOF5IHA9qYSbrkCIANQ/OrjyK
        pfzIhvTkDb8r72PrdWrTG20n7y9aLnVpk+Zcjf9NT2joLBNPRsg6RrlDomc4WbtGy8Ou1nfIi3LB2
        h7rIziMyU2ojrcQ5SCnLKZx9dCLZZDTviZK0GIb9h66ltoLbuhBZdDGzsa6h9Qs4B0bf8PX2lFbRj
        wDoAQgQaBlB4SsYGXAb25JNXN1c8HjPRH6MKkx78LDf6qTbSvx725N6gmUGtzFUext3qMALJTcxsI
        LFt/SvWg==;
Received: from [191.193.131.178] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1r8nKC-008wQ8-W1; Thu, 30 Nov 2023 21:07:53 +0100
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>, daniel@ffwll.ch,
        Daniel Stone <daniel@fooishbar.org>,
        =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH] drm/doc: Define KMS atomic state set
Date:   Thu, 30 Nov 2023 17:07:40 -0300
Message-ID: <20231130200740.53454-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Paalanen <pekka.paalanen@collabora.com>

Specify how the atomic state is maintained between userspace and
kernel, plus the special case for async flips.

Signed-off-by: Pekka Paalanen <pekka.paalanen@collabora.com>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---

This is a standalone patch from the following serie, the other patches are
already merged:
https://lore.kernel.org/lkml/20231122161941.320564-1-andrealmeid@igalia.com/

 Documentation/gpu/drm-uapi.rst | 47 ++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
index 370d820be248..d0693f902a5c 100644
--- a/Documentation/gpu/drm-uapi.rst
+++ b/Documentation/gpu/drm-uapi.rst
@@ -570,3 +570,50 @@ dma-buf interoperability
 
 Please see Documentation/userspace-api/dma-buf-alloc-exchange.rst for
 information on how dma-buf is integrated and exposed within DRM.
+
+KMS atomic state
+================
+
+An atomic commit can change multiple KMS properties in an atomic fashion,
+without ever applying intermediate or partial state changes.  Either the whole
+commit succeeds or fails, and it will never be applied partially. This is the
+fundamental improvement of the atomic API over the older non-atomic API which is
+referred to as the "legacy API".  Applying intermediate state could unexpectedly
+fail, cause visible glitches, or delay reaching the final state.
+
+An atomic commit can be flagged with DRM_MODE_ATOMIC_TEST_ONLY, which means the
+complete state change is validated but not applied.  Userspace should use this
+flag to validate any state change before asking to apply it. If validation fails
+for any reason, userspace should attempt to fall back to another, perhaps
+simpler, final state.  This allows userspace to probe for various configurations
+without causing visible glitches on screen and without the need to undo a
+probing change.
+
+The changes recorded in an atomic commit apply on top the current KMS state in
+the kernel. Hence, the complete new KMS state is the complete old KMS state with
+the committed property settings done on top. The kernel will try to avoid
+no-operation changes, so it is safe for userspace to send redundant property
+settings.  However, not every situation allows for no-op changes, due to the
+need to acquire locks for some attributes. Userspace needs to be aware that some
+redundant information might result in oversynchronization issues.  No-operation
+changes do not count towards actually needed changes, e.g.  setting MODE_ID to a
+different blob with identical contents as the current KMS state shall not be a
+modeset on its own. As a special exception for VRR needs, explicitly setting
+FB_ID to its current value is not a no-op.
+
+A "modeset" is a change in KMS state that might enable, disable, or temporarily
+disrupt the emitted video signal, possibly causing visible glitches on screen. A
+modeset may also take considerably more time to complete than other kinds of
+changes, and the video sink might also need time to adapt to the new signal
+properties. Therefore a modeset must be explicitly allowed with the flag
+DRM_MODE_ATOMIC_ALLOW_MODESET.  This in combination with
+DRM_MODE_ATOMIC_TEST_ONLY allows userspace to determine if a state change is
+likely to cause visible disruption on screen and avoid such changes when end
+users do not expect them.
+
+An atomic commit with the flag DRM_MODE_PAGE_FLIP_ASYNC is allowed to
+effectively change only the FB_ID property on any planes. No-operation changes
+are ignored as always. Changing any other property will cause the commit to be
+rejected. Each driver may relax this restriction if they have guarantees that
+such property change doesn't cause modesets. Userspace can use TEST_ONLY commits
+to query the driver about this.
-- 
2.43.0


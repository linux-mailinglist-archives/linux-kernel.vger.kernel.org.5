Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8E97E508C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 07:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjKHGzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 01:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKHGzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 01:55:24 -0500
Received: from 8.mo561.mail-out.ovh.net (8.mo561.mail-out.ovh.net [87.98.172.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08F91A5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 22:55:21 -0800 (PST)
Received: from director6.ghost.mail-out.ovh.net (unknown [10.109.138.180])
        by mo561.mail-out.ovh.net (Postfix) with ESMTP id 0E2B6254BE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:55:20 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-lv8ff (unknown [10.110.208.62])
        by director6.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 15B4C1FE12;
        Wed,  8 Nov 2023 06:55:17 +0000 (UTC)
Received: from foxhound.fi ([37.59.142.109])
        by ghost-submission-6684bf9d7b-lv8ff with ESMTPSA
        id uGgwOtUwS2X3fAAAN287Lg
        (envelope-from <jose.pekkarinen@foxhound.fi>); Wed, 08 Nov 2023 06:55:17 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-109S003812ecbba-255d-4a16-800e-086f660595b3,
                    CA30051851D9204B2894E18F048F6C805596AA31) smtp.auth=jose.pekkarinen@foxhound.fi
X-OVh-ClientIp: 87.94.109.40
From:   =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, skhan@linuxfoundation.org
Cc:     =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>,
        airlied@gmail.com, daniel@ffwll.ch, felix.kuehling@amd.com,
        jonathan.kim@amd.com, Jack.Xiao@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] drm/amdgpu: remove unused MES_LOG_BUFFER struct
Date:   Wed,  8 Nov 2023 08:55:12 +0200
Message-Id: <20231108065512.14087-1-jose.pekkarinen@foxhound.fi>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3519281634429019841
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedruddukedgleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomheplfhoshorucfrvghkkhgrrhhinhgvnhcuoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqeenucggtffrrghtthgvrhhnpedtudethfeghfegfffhtdeuhedukeduudeuieeiteegkedtudegvdektefftedvffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupdekjedrleegrddutdelrdegtddpfeejrdehledrudegvddruddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeiuddpmhhouggvpehsmhhtphhouhht
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mention struct seems not to be used along the driver, and is also
triggering a warning to migrate to flexible array. This patch will
remove the full structure and get rid of the warning.

drivers/gpu/drm/amd/include/mes_v11_api_def.h:192:27-34: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
---
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index b1db2b190187..e032ee262fa9 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -187,11 +187,6 @@ struct MES_LOG_ENTRY_DATA {
 	};
 };
 
-struct MES_LOG_BUFFER {
-	struct MES_LOG_ENTRY_HEADER	header;
-	struct MES_LOG_ENTRY_DATA	entries[1];
-};
-
 enum MES_SWIP_TO_HWIP_DEF {
 	MES_MAX_HWIP_SEGMENT = 8,
 };
-- 
2.39.2


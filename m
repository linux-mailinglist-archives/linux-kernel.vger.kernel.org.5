Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE177E5088
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 07:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjKHGyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 01:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKHGyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 01:54:52 -0500
Received: from 1.mo560.mail-out.ovh.net (1.mo560.mail-out.ovh.net [46.105.63.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75ADA1A5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 22:54:50 -0800 (PST)
Received: from director11.ghost.mail-out.ovh.net (unknown [10.109.143.145])
        by mo560.mail-out.ovh.net (Postfix) with ESMTP id E89E128437
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:54:47 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-mcdch (unknown [10.110.208.112])
        by director11.ghost.mail-out.ovh.net (Postfix) with ESMTPS id DDD3C1FDFD;
        Wed,  8 Nov 2023 06:54:45 +0000 (UTC)
Received: from foxhound.fi ([37.59.142.105])
        by ghost-submission-6684bf9d7b-mcdch with ESMTPSA
        id 6yACMbUwS2WPBwsA+VWt7Q
        (envelope-from <jose.pekkarinen@foxhound.fi>); Wed, 08 Nov 2023 06:54:45 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-105G0062025b92b-b4e0-4a0d-8579-cd97c65636dc,
                    CA30051851D9204B2894E18F048F6C805596AA31) smtp.auth=jose.pekkarinen@foxhound.fi
X-OVh-ClientIp: 87.94.109.40
From:   =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To:     evan.quan@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        skhan@linuxfoundation.org
Cc:     =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>,
        airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] drm/amd/pm: replace 1-element arrays with flexible-array members
Date:   Wed,  8 Nov 2023 08:54:35 +0200
Message-Id: <20231108065436.13969-1-jose.pekkarinen@foxhound.fi>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3510274434799740609
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedruddukedgleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomheplfhoshorucfrvghkkhgrrhhinhgvnhcuoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqeenucggtffrrghtthgvrhhnpedtudethfeghfegfffhtdeuhedukeduudeuieeiteegkedtudegvdektefftedvffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupdekjedrleegrddutdelrdegtddpfeejrdehledrudegvddruddtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeitddpmhhouggvpehsmhhtphhouhht
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following case seems to be safe to be replaced with a flexible array
to clean up the added coccinelle warning. This patch will just do it.

drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h:76:38-63: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h
index c7b61222d258..1ce4087005f0 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h
@@ -73,7 +73,7 @@ struct smu8_register_index_data_pair {
 
 struct smu8_ih_meta_data {
 	uint32_t command;
-	struct smu8_register_index_data_pair register_index_value_pair[1];
+	struct smu8_register_index_data_pair register_index_value_pair[];
 };
 
 struct smu8_smumgr {
-- 
2.39.2


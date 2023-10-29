Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6017DABE9
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 10:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjJ2Jro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 05:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjJ2Jrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 05:47:42 -0400
Received: from 19.mo582.mail-out.ovh.net (19.mo582.mail-out.ovh.net [188.165.56.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D50CD3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 02:47:39 -0700 (PDT)
Received: from director6.ghost.mail-out.ovh.net (unknown [10.109.143.216])
        by mo582.mail-out.ovh.net (Postfix) with ESMTP id 9ED2F25613
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 09:38:31 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-x2g4z (unknown [10.111.208.154])
        by director6.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 9167A1FD2F;
        Sun, 29 Oct 2023 09:38:28 +0000 (UTC)
Received: from foxhound.fi ([37.59.142.107])
        by ghost-submission-6684bf9d7b-x2g4z with ESMTPSA
        id 9QKQHBQoPmXpkwQAjDjF9w
        (envelope-from <jose.pekkarinen@foxhound.fi>); Sun, 29 Oct 2023 09:38:28 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-107S001d53088e7-9f9b-4152-9236-a5a90e87501e,
                    2D5A9C8C3C9544CFCEEB4DEE313913C815DB1A20) smtp.auth=jose.pekkarinen@foxhound.fi
X-OVh-ClientIp: 87.94.110.144
From:   =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        skhan@linuxfoundation.org
Cc:     =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>,
        airlied@gmail.com, daniel@ffwll.ch, qingqing.zhuo@amd.com,
        Jun.Lei@amd.com, alex.hung@amd.com, Zhongwei.Zhang@amd.com,
        sunran001@208suo.com, Yao.Wang1@amd.com, aurabindo.pillai@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] drm/amd/display: remove duplicated argument
Date:   Sun, 29 Oct 2023 11:39:26 +0200
Message-Id: <20231029093926.137766-1-jose.pekkarinen@foxhound.fi>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 2888777688825374374
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrleekgddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeflohhsrocurfgvkhhkrghrihhnvghnuceojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqnecuggftrfgrthhtvghrnhepfedtleeuteeitedvtedtteeuieevudejfeffvdetfeekleehhfelleefteetjeejnecukfhppeduvdejrddtrddtrddupdekjedrleegrdduuddtrddugeegpdefjedrheelrddugedvrddutdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkedvpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spotted by coccicheck, there is a redundant check for
v->SourcePixelFormat[k] != dm_444_16. This patch will
remove it. The corresponding output follows.

drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c:5130:86-122: duplicated argument to && or ||

Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index ad741a723c0e..3686f1e7de3a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -5128,7 +5128,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			ViewportExceedsSurface = true;
 
 		if (v->SourcePixelFormat[k] != dm_444_64 && v->SourcePixelFormat[k] != dm_444_32 && v->SourcePixelFormat[k] != dm_444_16
-				&& v->SourcePixelFormat[k] != dm_444_16 && v->SourcePixelFormat[k] != dm_444_8 && v->SourcePixelFormat[k] != dm_rgbe) {
+				&& v->SourcePixelFormat[k] != dm_444_8 && v->SourcePixelFormat[k] != dm_rgbe) {
 			if (v->ViewportWidthChroma[k] > v->SurfaceWidthC[k] || v->ViewportHeightChroma[k] > v->SurfaceHeightC[k]) {
 				ViewportExceedsSurface = true;
 			}
-- 
2.39.2


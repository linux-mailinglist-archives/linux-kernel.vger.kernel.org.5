Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4256E76EC30
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbjHCOSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236384AbjHCOSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:18:03 -0400
X-Greylist: delayed 395 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Aug 2023 07:17:59 PDT
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12FFDA
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:17:59 -0700 (PDT)
From:   Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
        t=1691071876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Wwx6Ta6AHqq3TcGW8bDS4dyENTyGmjacKacctkGambU=;
        b=SVNHybaDXO7SxMWdFbZblKTdyyFkRoiYZQcaKlUxbxzbcVAdbKxYxPGC5CPwCH2clX7nhS
        picfAtFTw01T80c7e1s2RP/e1bbR16gQsGvSdfYdGy0sftTwtP4e8AsPCNdIbU0+FQsjGh
        ZnIjvQUSnrniQv3p+J8kgTlGv0ex0bs=
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Wenjing Liu <wenjing.liu@amd.com>, Jun Lei <Jun.Lei@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        trufanov@swemel.ru, vfh@swemel.ru
Subject: [PATCH] drm/amd/display: Return value of function
Date:   Thu,  3 Aug 2023 17:11:16 +0300
Message-Id: <20230803141116.58883-1-arefev@swemel.ru>
MIME-Version: 1.0
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

Added return value check hpd_enable

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index fa314493ffc5..bf2f620aeb66 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -1645,7 +1645,7 @@ void dce110_link_encoder_enable_hpd(struct link_encoder *enc)
 	uint32_t hpd_enable = 0;
 	uint32_t value = dm_read_reg(ctx, addr);
 
-	get_reg_field_value(hpd_enable, DC_HPD_CONTROL, DC_HPD_EN);
+	hpd_enable = get_reg_field_value(hpd_enable, DC_HPD_CONTROL, DC_HPD_EN);
 
 	if (hpd_enable == 0)
 		set_reg_field_value(value, 1, DC_HPD_CONTROL, DC_HPD_EN);
-- 
2.25.1


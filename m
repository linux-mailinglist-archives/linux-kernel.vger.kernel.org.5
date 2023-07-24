Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0831175EA13
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 05:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjGXDa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 23:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGXDaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 23:30:24 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAAC1AA
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 20:30:22 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R8Qf26v7dzBRx4N
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:30:18 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1690169418; x=1692761419; bh=Aih9b3mm0L/W57ewzfZK0Mk2HMM
        uvyf31AvjFkXi8+I=; b=l/VAKTIcjlyWOGKtifjZLmhWFCSY+xtgf4nSre0R708
        Kd/+LemFANnznhlFN8fdLbFXK5NQiSK4+8GTcwULPjHRW8Ew2tPLFZYxQeH1ykNU
        paqOravr1Sd+9X84AOm1BlwHEQ+jZP7Kh++gvbGmQegIgNNk/eZmczkmQDbAUNsd
        fgCx/ntDUu6XreMbX+YBrc2nbLMeWUMXd2ssbGuL8jxonzh+uNhb0umnU3ExdHrV
        JWGOkFehD0U4H604jww6wf8PWWbcUPdVm4AZXQWM//BkkBXQY6AYAM/vtrOGzgEY
        Y3Ue41AP8vFcm5aBkD3dmc3MuN1Ak96bHpgJi6LlCGw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6ZX9COF4HglX for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jul 2023 11:30:18 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R8Qf24pbszBRDrF;
        Mon, 24 Jul 2023 11:30:18 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 24 Jul 2023 11:30:18 +0800
From:   sunran001@208suo.com
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: add missing spaces after ',' and else should
 follow close brace '}'
In-Reply-To: <20230724032920.7892-1-xujianghui@cdjrlc.com>
References: <20230724032920.7892-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <d88773902f7a8536a8be83ead18981b3@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ERROR: else should follow close brace '}'

ERROR: space required after that ',' (ctx:VxV)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/radeon/radeon_connectors.c | 5 ++---
  1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c 
b/drivers/gpu/drm/radeon/radeon_connectors.c
index 07193cd0c417..4ceceb972e8d 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -198,8 +198,7 @@ int radeon_get_monitor_bpc(struct drm_connector 
*connector)
  				DRM_DEBUG("%s: HDMI deep color 10 bpc exceeds max tmds clock. Using 
%d bpc.\n",
  						  connector->name, bpc);
  			}
-		}
-		else if (bpc > 8) {
+		} else if (bpc > 8) {
  			/* max_tmds_clock missing, but hdmi spec mandates it for deep color. 
*/
  			DRM_DEBUG("%s: Required max tmds clock for HDMI deep color missing. 
Using 8 bpc.\n",
  					  connector->name);
@@ -1372,7 +1371,7 @@ radeon_dvi_detect(struct drm_connector *connector, 
bool force)
  					/* assume digital unless load detected otherwise */
  					radeon_connector->use_digital = true;
  					lret = encoder_funcs->detect(encoder, connector);
-					DRM_DEBUG_KMS("load_detect %x returned: 
%x\n",encoder->encoder_type,lret);
+					DRM_DEBUG_KMS("load_detect %x returned: %x\n", 
encoder->encoder_type, lret);
  					if (lret == connector_status_connected)
  						radeon_connector->use_digital = false;
  				}

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7A37A5E0A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjISJec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjISJe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:34:29 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F99E135
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:34:20 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c4194f7635so34481335ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695116059; x=1695720859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QVf5D/+j5N+ia+SFzQBn7+4Q88aksoEeF9OLLDBHLuM=;
        b=hI7doWYbrcLaqitrDz3Dpv945ukDeEo5/eFyfF8ck6mcSMG9IdaKqAnwreOiXEvXrm
         RzCMQFrFQ9BCI0PDeklFkbIhOFij6DzkNCGeyzqfWq0+Em2IL4iWHct8US6C/p6dXiER
         zcZt4gBLy86HdM17nBOfpRbR8saV8wCcnUZUU+i0YiWhBSk8Atj2kvB/eUvl5A5U2pMc
         wsW4Rlm3R+e4R+ZavWzWk409mN4Z0R+9MGWHbvR9wwnj7UbqD2noeU06gJKtAN4FiXaZ
         uSAvC5dKWjn/rXF2qPMdSVgYa1p9JuRZfKg4p5FBs2QarETrJitMHRkd/XOoyYS98BKK
         9vQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695116059; x=1695720859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVf5D/+j5N+ia+SFzQBn7+4Q88aksoEeF9OLLDBHLuM=;
        b=Sm3Vp4OEaxnnZLHfkSaaGL96DZVaU+FPWzrSWFJeAceJO2HJ+51cwVLqamf2Fzh4+C
         JiKdTE5GKMcCkt4VierkOgSXqRr0jc5QSSf2ln7iNRIoyRby8pklbwA9gr7PgcvUNDvU
         CkQd1HATCiAw75J7HyLjQkF9Se+GCcocKUbDdlHhbcEPyaf2RRAinTJan3I9L/EnB+vb
         TR9bsSa6O6n0e5lhGk2bM+UGuHmw+dcv2/LwmOzf9rlTve+vez3dlBpmLEcRXVbmFNTi
         AKWJpzYwCJNU3+H1wS5V2X5KD8opt/Lzq361c+2VgX7QDg7e6lRipWRHyUwW2Lr2+QRm
         mvXA==
X-Gm-Message-State: AOJu0YxHg5gRqNDLrNLlPPZlT9WJfVrgAffLoDM/GQFU1pnmSinv+xM3
        Q+PEBfCKB60n0jYAUGXW/bAIBhzdtSo2gO/N
X-Google-Smtp-Source: AGHT+IFEM34YO2uN1IhUDPCwqvzRc2cQqob4GZnt3NU716uhhFhKM1D0NXBeVCyJWYwKQ2stjepyvQ==
X-Received: by 2002:a17:902:d507:b0:1c1:d5d1:a364 with SMTP id b7-20020a170902d50700b001c1d5d1a364mr2849526plg.33.1695116059209;
        Tue, 19 Sep 2023 02:34:19 -0700 (PDT)
Received: from swarup-virtual-machine.localdomain ([171.76.87.78])
        by smtp.gmail.com with ESMTPSA id ji1-20020a170903324100b001c44489ee55sm6487608plb.273.2023.09.19.02.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 02:34:18 -0700 (PDT)
From:   Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        swarupkotikalapudi@gmail.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] gpu: drm: amd: display: fix kernel-doc warnings
Date:   Tue, 19 Sep 2023 15:03:11 +0530
Message-Id: <20230919093318.16407-1-swarupkotikalapudi@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel-doc warnings discovered in AMD gpu display driver.
Fixes these warnings:
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:110: warning:
Function parameter or member 'overlap_only'
not described in 'mpcc_blnd_cfg'.

./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:110: warning:
Function parameter or member 'bottom_gain_mode'
not described in 'mpcc_blnd_cfg'.

./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:110: warning:
Function parameter or member 'background_color_bpc'
not described in 'mpcc_blnd_cfg'.

./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:110:
warning: Function parameter or member 'top_gain'
not described in 'mpcc_blnd_cfg'.

./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:110:
warning: Function parameter or member 'bottom_inside_gain'
not described in 'mpcc_blnd_cfg'.

./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:110:
warning: Function parameter or member 'bottom_outside_gain'
not described in 'mpcc_blnd_cfg'.

Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
index 8d86159d9de0..61a2406dcc53 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
@@ -91,6 +91,12 @@ enum mpcc_alpha_blend_mode {
  * @global_gain: used when blend mode considers both pixel alpha and plane
  * alpha value and assumes the global alpha value.
  * @global_alpha: plane alpha value
+ * @overlap_only: whether overlapping of different planes is allowed
+ * @bottom_gain_mode: blend mode for bottom gain setting
+ * @background_color_bpc: background color for bpc
+ * @top_gain: top gain setting
+ * @bottom_inside_gain: blend mode for bottom inside
+ * @bottom_outside_gain:  blend mode for bottom outside
  */
 struct mpcc_blnd_cfg {
 	struct tg_color black_color;	/* background color */
-- 
2.34.1


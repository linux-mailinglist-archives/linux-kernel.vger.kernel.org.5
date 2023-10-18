Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2AC7CD5E1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbjJRIBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjJRIBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:01:35 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1E7BC;
        Wed, 18 Oct 2023 01:01:33 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53e751aeb3cso6743870a12.2;
        Wed, 18 Oct 2023 01:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697616092; x=1698220892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=30ULjp8VAyqZgr5itRchTkBiQGYWmRnWFZPnaPGlIfI=;
        b=IEkeJd3OaH7Ll7U7HiXDaBfg8JosMXxIBKJGsydVgdXnO+updefeaN+/N6GJKn5b57
         qkrWMJnC+gi9f0gtQREJntExL1HraviDEJfIHGhIXDpgVTO9mCTurx95fStosIvtQXPM
         JDA6ytEVn/GbbKCj7nVTxwsCERan5zeOgqdD7wfpgTIuNyTj7+/Hdc/LvJoAxF+HGdWB
         r276FPOQn237mHGmbBR1nwMW0hDZfShfM7Fqp9F4DDAMHCwRZfmVSyqAew+/qyIaV+vh
         3A3TOgSqN6NNMT0uhZeJJFFPeNb1xjuM0TKsIQPi3IQ4dwRpXPxFptgdPuVL1DYhnCXy
         JadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697616092; x=1698220892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=30ULjp8VAyqZgr5itRchTkBiQGYWmRnWFZPnaPGlIfI=;
        b=BvMm7PAn6a4y87RG2zOTCk1W6j8Emi6zng1YsUt1zDEeSKMKdEMMkEdk/nhMwHzlAK
         pbbOFZ4dHb/zNiDaicsySIEarmsl1tRg76q5BO7d/+vxeqDOgaSdmU6rdpGMzmVhfgid
         SWao/uHWVXayxUp9lTBMoq7vvz6GrYfodxaQx2Z1m/Bt0Yx40XRj32K6bMXCZIWkrxOX
         mIWeynpmnApkyuQNcJCwwkVMyJ10Ms5cRvtVbkFr7AIy9h24wMcRsY22LpXUzi42ri4U
         Z7VdihAgadoU9hMduqPdNMHb0uBX5ZdnObN/ncn6zSpOsFg3A5Pra5wl6+RcV6YRqpk/
         sH6w==
X-Gm-Message-State: AOJu0YwhixrFbg/E4sdwdzNoYu69rT/qxtQmejCdT4oPqjUCl/jn333N
        MkKf5Pn3cBvBMW4dwE0yrQ==
X-Google-Smtp-Source: AGHT+IFO5HbNWvKe8y47ftHvUNTxHsza97HzHWo6CRd4IG8Kf9Ur5Z8NsFE0wLzrGk2H35KGEIhKqw==
X-Received: by 2002:a05:6402:50d1:b0:525:6e47:10f6 with SMTP id h17-20020a05640250d100b005256e4710f6mr3714476edb.22.1697616091949;
        Wed, 18 Oct 2023 01:01:31 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine.localdomain ([105.163.0.227])
        by smtp.gmail.com with ESMTPSA id z96-20020a509e69000000b0053b67aba57bsm2428560ede.17.2023.10.18.01.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 01:01:31 -0700 (PDT)
From:   Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc:     anonolitunya@gmail.com, outreachy@lists.linux.dev,
        julia.lawall@inria.fr, dan.carpenter@linaro.org,
        andi.shyti@linux.intel.com,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: sm750fb: Rename display_control_adjust_sm750LE
Date:   Wed, 18 Oct 2023 11:00:50 +0300
Message-ID: <20231018080103.25555-1-anonolitunya@gmail.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function display_control_adjust_sm750LE to
display_control_adjust_sm750le. This further enforces snakecase naming
convention for consistent naming style throughout entire file.

This change was suggested by Andy <andi.shyti@linux.intel.com>

Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
---
 drivers/staging/sm750fb/ddk750_mode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index f3f354831617..bcdd291d25c9 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -14,7 +14,7 @@
  * in bit 29:27 of Display Control register.
  */
 static unsigned long
-display_control_adjust_SM750LE(struct mode_parameter *mode_param,
+display_control_adjust_sm750le(struct mode_parameter *mode_param,
 			       unsigned long disp_control)
 {
 	unsigned long x, y;
@@ -125,7 +125,7 @@ static int program_mode_registers(struct mode_parameter *mode_param,
 			tmp |= DISPLAY_CTRL_HSYNC_PHASE;
 
 		if (sm750_get_chip_type() == SM750LE) {
-			display_control_adjust_SM750LE(mode_param, tmp);
+			display_control_adjust_sm750le(mode_param, tmp);
 		} else {
 			reg = peek32(CRT_DISPLAY_CTRL) &
 				~(DISPLAY_CTRL_VSYNC_PHASE |
-- 
2.42.0.345.gaab89be2eb


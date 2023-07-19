Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C2275A212
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjGSWiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjGSWiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:38:54 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F891FE1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 15:38:53 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6682909acadso76288b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 15:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689806333; x=1692398333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hhDuaWIdtI3VxINGy4xngROSBmAaTvKi9fOK78JMCKc=;
        b=gHaeqrsBSvle8ussVsR2PnH5rF8XjBtz2YegJot+HtyutyM+p2jd7p5WTMwXfLbqHV
         +xL3Ot0KrrPCKPgYi2dMxFCxdkaD5j0a53+puK1gAaYfH/28SN4lwzGecKFqmv/PyZlg
         iQYcScmvWVW1A9oecLmiftqdQChuipQtTqKzmH5NAuuEPXFrZ8E5U11M62NfWD8F11iV
         KpTV8RKH0OLjRPJlpA+TCnFjPdJx23hWbWJBvyLkPune4CT8PwQx0lGJzOFgcJDclv7G
         VqFBRyIjF+LBaAsXISbpykHOoDUD3X1BR16FDxqPHUBUrv+9nvlp3A8rlhE7xQkfv9E6
         2yUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689806333; x=1692398333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hhDuaWIdtI3VxINGy4xngROSBmAaTvKi9fOK78JMCKc=;
        b=ODjfN5sBLYz+lKtEUVbg99rmfxIGY+XqzIkanw+rODs43BBhAbovOaYROXIyhUXV3M
         un2Q/+03gArAXsULS3SQ2semCMl9s2Kz55oiBy3+n7+LEDrOlYJp19ZeHjqYEzEbJuFl
         tlKW5NG/7hsRwAGFfoa0BFqbF7dA3agUaBvrWjvRUGy2A5ysiAR7OG8AVBXz8F1/XgKF
         DsadKs8dXS75cKwmkDScXvnJl283EalU0Ugo6zbcLPkPnmpJXjCspovGJgqc13Ax/wqY
         5pXCt6wjXw+JcxDk+LE4woQpg5EzACrZAMB1O1z9X4vZymEP4dVgawyzM7+QOotbo0qo
         +C+A==
X-Gm-Message-State: ABy/qLaqD5us2D6Od2Xs6oBrrgS8hCPVo3dGfmoF6p2lm8m1dit88uTK
        GL/sydE7VHRU30CCgjz+K62umMt4LOI=
X-Google-Smtp-Source: APBJJlFnSVZU+y2eVwJou+1lLI+OGWpLPNJffWtRe6QH8zxmp4w0rfb4mjaYTPjekBnsDdlrDuPmtQ==
X-Received: by 2002:a05:6a00:1a4c:b0:67a:f6f6:ccc6 with SMTP id h12-20020a056a001a4c00b0067af6f6ccc6mr4522386pfv.5.1689806332980;
        Wed, 19 Jul 2023 15:38:52 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-69-4.dynamic-ip.hinet.net. [36.228.69.4])
        by smtp.gmail.com with ESMTPSA id e8-20020a633708000000b0053051d50a48sm4028568pga.79.2023.07.19.15.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 15:38:52 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: apple: apple-pmgr-pwrstate: mark apple_pmgr_reset_ops static
Date:   Thu, 20 Jul 2023 06:38:47 +0800
Message-Id: <20230719223848.138363-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following sparse warnings:

drivers/soc/apple/apple-pmgr-pwrstate.c:180:32: sparse: warning: symbol 'apple_pmgr_reset_ops' was not declared. Should it be static?

No functional change intended.

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 drivers/soc/apple/apple-pmgr-pwrstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/apple/apple-pmgr-pwrstate.c b/drivers/soc/apple/apple-pmgr-pwrstate.c
index d62a776c89a1..9467235110f4 100644
--- a/drivers/soc/apple/apple-pmgr-pwrstate.c
+++ b/drivers/soc/apple/apple-pmgr-pwrstate.c
@@ -177,7 +177,7 @@ static int apple_pmgr_reset_status(struct reset_controller_dev *rcdev, unsigned
 	return !!(reg & APPLE_PMGR_RESET);
 }
 
-const struct reset_control_ops apple_pmgr_reset_ops = {
+static const struct reset_control_ops apple_pmgr_reset_ops = {
 	.assert		= apple_pmgr_reset_assert,
 	.deassert	= apple_pmgr_reset_deassert,
 	.reset		= apple_pmgr_reset_reset,
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322158066D0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 06:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376775AbjLFF4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 00:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376738AbjLFF4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 00:56:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1ED18F;
        Tue,  5 Dec 2023 21:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=hbjoSIyl9QoK27efhpqBsMqg26tMTotTFPXa+8t3xFE=; b=m5ZmOD9IV2/hkfAjw2X/04sqMa
        Ic4f7pymAirhazpqWEmoFJpKGVJDBfnrlsGofiBIJdynATFpizpRLnO5PJTrIyjdL5nSlwoKYNJ1Y
        yDOjuxl6tja8Sf87VD0NogKUJ8di2j43/SJX4daYrZ2kzU7Tbt5eEHw7UGXxBiI1H6utmfAZuVFtv
        x59GVDPeRi4693yd9+Zw0OKz7TxRhyztdD3oS8M0bjhXp+i8v4LwBFje2q88vw1cChLmXqC+V88Ow
        Kot3zUigItcxsDYVQoswAiC+7PL6EELpz+QIQ1Q+RmxNw5cUrwCX8w1X4m4Tw7uc8Ev3vK9FPeblw
        P4f3woeg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAktI-0098h0-2m;
        Wed, 06 Dec 2023 05:56:12 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH] Input: twl4030-pwrbutton: don't misuse kernel-doc marker
Date:   Tue,  5 Dec 2023 21:56:12 -0800
Message-ID: <20231206055612.17142-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a common C comment "/*" instead of "/**" to prevent a warning
from scripts/kernel-doc.

twl4030-pwrbutton.c:33: warning: expecting prototype for twl4030(). Prototype was for PWR_PWRON_IRQ() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
---
 drivers/input/misc/twl4030-pwrbutton.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
--- a/drivers/input/misc/twl4030-pwrbutton.c
+++ b/drivers/input/misc/twl4030-pwrbutton.c
@@ -1,4 +1,4 @@
-/**
+/*
  * twl4030-pwrbutton.c - TWL4030 Power Button Input Driver
  *
  * Copyright (C) 2008-2009 Nokia Corporation

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CAC79D98F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237645AbjILT2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237629AbjILT2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:28:45 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1079910D0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 12:28:41 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31c49de7a41so898155f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 12:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694546919; x=1695151719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nytdb2jTBTDlZWB9THAVoMMoHv0wERJG7iM7Ci7CqjE=;
        b=N4bg8Y+xIypOVFi+rShomsZwg3T/6pSob0jbqO5NpHdcAEOjOmOiC9Wiixt9x9LEsQ
         o95Uv+k6WEQroslOWCVUVEfRars+4RjSC/Vfi7DZqMfWdn11K9VzY++1GdMSr2UQdjGu
         QS5+FxVzVIwYhH2D/SRm/mrG6pANPH+O+phFl+SVap41vBz4pNngr+/w8sY05QLvmbk2
         doR5f7PicfWVR3584LxJEqq1tNpsKOkZRcXkGoGRzad8z5t5xaHktVp3oNC32f4RAYzx
         81Vozel84qCbziMMFfICp0Wx6pSS5f9VfEd+ZUuZ1sTM5C7Ls6kk//EpbXyza6PLFGJL
         cKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694546919; x=1695151719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nytdb2jTBTDlZWB9THAVoMMoHv0wERJG7iM7Ci7CqjE=;
        b=P20HsHnfdjRN2XSgUg3SlDtYS7tgouHfh/vKogDzcvK2UBmyR5Bf27PP9Z4zbDWY5h
         brB5cmfe5BObu0bVJCv32z1Hk8y5fAXUBxZ2fppnAl4A0FX3m6sHoXouTWs+8rolFT1+
         WHIyYqxG83oOfB8/YuR6uFbPjr7G/qgNWVBNniW0fsCNcsRK+ZE25gCj12wpCgDgjLMv
         vtSCDXPD2T4E7ctbiKRty53+Z0weA5JgcAYQRdXukpqbJTZMSfgBE6lCx45h2C4feLCp
         X3DIyq/+aHwQTf3PeViila7tNv4IBcwousCNKOrtbaD+3syVehW6rSRiXSOLTjEa3lug
         uBqA==
X-Gm-Message-State: AOJu0YwJtrsRM1jie+NJmuGelME2IS6T17xwDN+I2NUz6dgBDWCcZCTH
        D1eCasGkrmFAkvA8P8w34YQ=
X-Google-Smtp-Source: AGHT+IG/9MgxMeR+xBSEaeYilcAWAwpkZxKutcOmZRDSFl5HllvKV5D9rKmel+FD5ViAG9qaTeNCTg==
X-Received: by 2002:adf:f0c2:0:b0:31f:af30:1bd4 with SMTP id x2-20020adff0c2000000b0031faf301bd4mr339777wro.1.1694546919469;
        Tue, 12 Sep 2023 12:28:39 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id q17-20020adff511000000b00317f3fd21b7sm13642874wro.80.2023.09.12.12.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 12:28:39 -0700 (PDT)
Date:   Tue, 12 Sep 2023 21:28:37 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] staging: rtl8192e: Replace rtl92e_disable_irq with
 rtl92e_irq_disable
Message-ID: <07c7312d1571e23ee382d47095931d68ba194551.1694546300.git.philipp.g.hortmann@gmail.com>
References: <cover.1694546300.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694546300.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace rtl92e_disable_irq with rtl92e_irq_disable to increase
readability. priv->irq_enabled = 0 was set in both functions.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
v1->v2: Unchanged
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 9 ---------
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 8adf53174239..e0500946dea5 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1879,7 +1879,7 @@ void rtl92e_enable_irq(struct net_device *dev)
 	rtl92e_writel(dev, INTA_MASK, priv->irq_mask[0]);
 }
 
-void rtl92e_disable_irq(struct net_device *dev)
+void rtl92e_irq_disable(struct net_device *dev)
 {
 	struct r8192_priv *priv = (struct r8192_priv *)rtllib_priv(dev);
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h
index 11366fda4ec3..3c06e1da4408 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h
@@ -17,7 +17,6 @@ void rtl92e_ack_irq(struct net_device *dev, u32 *p_inta);
 void rtl92e_enable_rx(struct net_device *dev);
 void rtl92e_enable_tx(struct net_device *dev);
 void rtl92e_enable_irq(struct net_device *dev);
-void rtl92e_disable_irq(struct net_device *dev);
 void rtl92e_init_variables(struct net_device  *dev);
 void rtl92e_start_beacon(struct net_device *dev);
 void rtl92e_set_reg(struct net_device *dev, u8 variable, u8 *val);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 50eb8f3494ec..055cd513d76a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -236,15 +236,6 @@ void rtl92e_irq_enable(struct net_device *dev)
 	rtl92e_enable_irq(dev);
 }
 
-void rtl92e_irq_disable(struct net_device *dev)
-{
-	struct r8192_priv *priv = rtllib_priv(dev);
-
-	rtl92e_disable_irq(dev);
-
-	priv->irq_enabled = 0;
-}
-
 static void _rtl92e_set_chan(struct net_device *dev, short ch)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
-- 
2.42.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B9B7B227A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjI1QfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjI1QfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:35:22 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318401A4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:35:19 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c5ff5f858dso72982715ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695918918; x=1696523718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JMVm0roAoR3214GXE6h3jsc+ZnFkKHU1KaBPb1+s4xE=;
        b=cC0RHO9zMEeP6lPbx/TiEX9DNgrQpwQ9M2zRy6z7j9ovgJJogM6oYr9xEhRoNvtRI7
         eEUthxYpvi38vsBxpcytQV7yUNb9nxJ9EAcfveKB9t/Ibscex2kzdDP/aLfA6iP7xJNe
         yy+Pk2NY5LzvfHMobbkBVxDu8j7bWBqR+/IPPWltFBWSt+IywAv+Oiy22ZzTVznB3mHT
         O7P8Ym5QZRX6SVzim7ORVTsRyw5rBC/9M6Ir9boasIat9ie0bmUDw75NYP1UBX8VeaF6
         UiFZklEhyBdWyjzcf51aWznFoEh0deH1X6S2TGO1+ys1Mk0mR4ZPxOxj696VK4/4comp
         E29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695918918; x=1696523718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JMVm0roAoR3214GXE6h3jsc+ZnFkKHU1KaBPb1+s4xE=;
        b=VWi7+UO9zeYRpWy1H/uPv2LPbJDOvKLnkocMdXmI7RB39E/YHrnys649eO1r1xQi+o
         6F8GHEtAk+4TvYR2DApMN+fgzq90My+ENYUGlAyWtWXczdDjUXkiKDRh/ljNSXJ3KNBk
         s/pKd2hAiLi41lVoj4AHxBeMgNZRCjEXuuyYtBcN0okbh6e+sDfLDsmf7dx66S2F8178
         DEUwSqsLOZkopsP3rItsGp1pPapHlyHsmMmgqw+odl3xpgnlHweWuypMk0w4kjHQVKjT
         mp2SNhX7zTwjARMr5j3nLLcNfRNzHNQ2njEUwlh4b2QihrGw0VblrL1KaV1rD+INWxG/
         wa1g==
X-Gm-Message-State: AOJu0Yzyj2oYoM3MB8VvqiNhrSub6g2+AAv0JPr3hOb31TzDTrsdAOsK
        ZA0e00I/UqqZ2AYjyljIFy6x1owB3Gr+/Q==
X-Google-Smtp-Source: AGHT+IFHonybK5mLU6smXCP9fmJJ02ht1z2QPwZoxpSRJvHAGcsahrLSfYMIm23HDxC8n2N3tp7sbQ==
X-Received: by 2002:a17:903:230d:b0:1c0:98fe:3677 with SMTP id d13-20020a170903230d00b001c098fe3677mr1830934plh.56.1695918918136;
        Thu, 28 Sep 2023 09:35:18 -0700 (PDT)
Received: from sagar-virtual-machine.localdomain ([103.79.114.74])
        by smtp.gmail.com with ESMTPSA id s17-20020a170902ea1100b001c59f23a3fesm8406410plg.251.2023.09.28.09.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 09:35:17 -0700 (PDT)
From:   Sagar Vashnav <sagarvashnav72427@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     sagarvashnav72427@gmail.com
Subject: [PATCH] add kernel-doc for dc_dmub_caps
Date:   Thu, 28 Sep 2023 12:34:52 -0400
Message-Id: <20230928163452.15084-1-sagarvashnav72427@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: sagar-7227 <sagarvashnav72427@gmail.com>

Add kernel documentation for the dc_dmub_caps structure.

Signed-off-by: sagar-7227 <sagarvashnav72427@gmail.com>
---
 dc.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/dc.h b/dc.h
index 8125839..cd4dab3 100644
--- a/dc.h
+++ b/dc.h
@@ -208,6 +208,16 @@ struct dc_color_caps {
 	struct mpc_color_caps mpc;
 };
 
+/**
+ * struct dc_dmub_caps - DMUB (Display Microcontroller Unit) capabilities
+ * @psr: support for PSR (Power Saving State Residency)
+ * @mclk_sw: support for MCLK_SW (Memory Clock Switch)
+ * @subvp_psr: supprt for SUBVP PSR (Sub-Viewport Power Saving State Residency)
+ * @gecc_enable: GECC (Global Error Correcting Code) enablement.
+ *
+ * This structure describes the capabilities of the Display Microcontroller Unit (DMUB).
+ * It specifies whether certain features like PSR and MCLK_SW are supported.
+ */
 struct dc_dmub_caps {
 	bool psr;
 	bool mclk_sw;
-- 
2.34.1


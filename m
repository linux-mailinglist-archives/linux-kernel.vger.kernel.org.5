Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA82C7A023B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbjINLQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjINLQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:16:08 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FB31FD6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:16:03 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-500c37d479aso1370715e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694690161; x=1695294961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwwwwfCX71CGPY+4m/B/8JB1FGVXzFuLpjf50GP33WM=;
        b=mrUrG3F5waGhxnAVEni2chuXNhbBacCWpm1UWN9GnGnGIyjKEIl9AMhz3vaVIYfqAU
         52UAQCtuRDCrY27EghvtvGI7DKS72gloiMmBMm7hM9s+Jos4TLPaIWS58eFxEpcu6D3e
         NPN98y71v6LNGg7L2YVGtg6aQvFswLdsbsiJIyd+i/pHklzD+03pCjJ2bh4sXC8b/URT
         zL/v74Bi4RrsIqzhhJjn/asE9gPXKZlQzSH3DVoBrcObsPNsbL4VGHKhAoZalyyv/w70
         NcZZv/M90AXS7pxXdRSJ03YU0lpG0jmgxSh8oXAgMQd090wXs8YBf3WWkP6G1uabZJ3a
         m+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694690161; x=1695294961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwwwwfCX71CGPY+4m/B/8JB1FGVXzFuLpjf50GP33WM=;
        b=Ga/aC9Moe4AqpVedKWJRxaHM1VAp87zcetxNhxDD6uczyF/ahf4Av9JW534SQ8lFNq
         CvInrU/ZNBVXvwrL13CLyAfe+FxaxK0i++SS6eIrDHXAbU8RGF9mDURLVB10Y+wEw0Nz
         vNzRXDMOIFiDsGWHBhKI1aEHhUhN91/3XtcNpUddBV1ZbIfJAAafvRpP2Xw6cR0ScUMB
         KUtG+xmOH5kR20PJ55WOS0Un9VyBg9BMRZc2pZjGzfBMqpjYsS11nwpMsjI4UhDAIeui
         Oq37UfOpeq21iSqAkifuvWQeOblKoabG6C0a/AIAxhsTCu9Q2ipoPzTixRhjPpjZpz0p
         S6lA==
X-Gm-Message-State: AOJu0YxfeSDrFwAubGCa9wHyL263E//oP24mzPFGXNWP3dDFG3Y03nNN
        FBU1T9neY8fe8mUOTZJwqdtK3n2ZSIgnayRfRDhICw==
X-Google-Smtp-Source: AGHT+IGNDq1+kGv5ZTcP0wVAqFgUnsmaefZprk/wPO9nW3ABND+2s7KXW5rp8cCLBWwqxo4DDvNGnA==
X-Received: by 2002:a05:6512:20cc:b0:500:75e5:a2f0 with SMTP id u12-20020a05651220cc00b0050075e5a2f0mr3775138lfr.51.1694690160982;
        Thu, 14 Sep 2023 04:16:00 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id d25-20020ac244d9000000b00500ba43a43asm236197lfm.86.2023.09.14.04.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:16:00 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/17] pmdomain: Prepare to move Kconfig files into the pmdomain subsystem
Date:   Thu, 14 Sep 2023 13:15:54 +0200
Message-Id: <20230914111554.586438-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pmdomain_move_kconfig/0002-pmdomain-actions-Move-Kconfig-file-to-the-pmdomain-s.patch>
References: <pmdomain_move_kconfig/0002-pmdomain-actions-Move-Kconfig-file-to-the-pmdomain-s.patch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than having the various Kconfig files for the genpd providers
sprinkled across subsystems, let's prepare to move them into the pmdomain
subsystem along with the implementations.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/Kconfig          | 2 ++
 drivers/pmdomain/Kconfig | 4 ++++
 2 files changed, 6 insertions(+)
 create mode 100644 drivers/pmdomain/Kconfig

diff --git a/drivers/Kconfig b/drivers/Kconfig
index efb66e25fa2d..045c469cb438 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -175,6 +175,8 @@ source "drivers/soundwire/Kconfig"
 
 source "drivers/soc/Kconfig"
 
+source "drivers/genpd/Kconfig"
+
 source "drivers/devfreq/Kconfig"
 
 source "drivers/extcon/Kconfig"
diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
new file mode 100644
index 000000000000..c32a76b51840
--- /dev/null
+++ b/drivers/pmdomain/Kconfig
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "Power Domains Support"
+
+endmenu
-- 
2.34.1


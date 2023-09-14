Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A0F7A025E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbjINLTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236893AbjINLTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:19:13 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF181FC9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:19:09 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-500cfb168c6so1345142e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694690347; x=1695295147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=re3ccXgEY4PCpIWQZxRpCI/lf6THlIYVapQUmLrOGD0=;
        b=wqE0GRHlt8eWjBA5A4IbiXHm0duWqWvTSJYXXuA4U8GHec3+k+3HKM9SK65k2RuLGc
         36EYV9KaHiFoGV3YrH5SPDopWEmbs1wNVKBYUs47x3xK6S9cL4oOxm+Us0LrlEUZ3M3D
         XH9+fvBJYrokpqL+JWUFkRrQ3KjRi+60iImfGcGFft30yM8CXxUJQu/9OGc3PQke/Ivs
         YtEhTXQLu/cTfVxqwyOuHcdWcvDx6wrjmsPnpcsObeASpcpGp0fa4Q2kXyICuU2lXlLg
         683/09SwfbTW60K4uHMySTtODWWE40Z2cnQBXfoI90rzDw9bWaT8eJPpfwfDTPXDwxUi
         5W/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694690347; x=1695295147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=re3ccXgEY4PCpIWQZxRpCI/lf6THlIYVapQUmLrOGD0=;
        b=jlPHZJN9+xjxw633sEop/eC52FE1JQIJLUXwRw/VJQgeCip+u40m3s5WrJQkqbA8AV
         qAsvnWeZuBSmKZP4AVZCgXS43Pl5sge4/vtQ+aaAd06XsHlQ3n2EcDnPTqs7jxjUtp6B
         oxw/PVU0wYpQFJFjsdjs23uDmuoBMOdr9SOzNlEM4gyVqV3POxb+vDeVxwETSS0HGDFE
         aZ5YBCa6qOSEbfHEq54ld6xTtyY0UKCEsPrdtsdDqoqHOt6QEc8L5PwkRcOGRtJXUzUv
         BEUrVzszeswk2fAYNnV8dSsuaG07WS3B6WYisXhnHW8WMdRz3A/qF4Z3hF3oAQ33sn+O
         sBSA==
X-Gm-Message-State: AOJu0YyIziQsNlw6nIm1ZBxQkkLclsqvMPAC8pv6uiXYG9iUlN+wHnHW
        ny+DBm+54ZXYJ+j64imvBjW9d4graDOrB9mpyjzc1w==
X-Google-Smtp-Source: AGHT+IFMIk+ZnIOfvzIXcwK0L67jrQVRTEsaCfy623g2MVHPfq9rLx8+/oZMJ+vnLz8E9Es/1EIlYg==
X-Received: by 2002:a05:6512:12d4:b0:500:c5df:1872 with SMTP id p20-20020a05651212d400b00500c5df1872mr4961180lfg.44.1694690347245;
        Thu, 14 Sep 2023 04:19:07 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id x5-20020a19f605000000b0050089b26ea1sm230413lfe.276.2023.09.14.04.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:19:06 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Walker Chen <walker.chen@starfivetech.com>,
        Conor Dooley <conor@kernel.org>
Subject: [PATCH 13/17] pmdomain: starfive: Move Kconfig file to the pmdomain subsystem
Date:   Thu, 14 Sep 2023 13:19:04 +0200
Message-Id: <20230914111904.586744-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig belongs closer to the corresponding implementation, hence let's
move it from the soc subsystem to the pmdomain subsystem.

Cc: Walker Chen <walker.chen@starfivetech.com>
Cc: Conor Dooley <conor@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS                                | 2 +-
 drivers/pmdomain/Kconfig                   | 1 +
 drivers/{soc => pmdomain}/starfive/Kconfig | 0
 drivers/soc/Kconfig                        | 1 -
 4 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/{soc => pmdomain}/starfive/Kconfig (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6b491ebcf790..b8eae18f0fb1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20523,7 +20523,7 @@ M:	Conor Dooley <conor@kernel.org>
 S:	Maintained
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
 F:	Documentation/devicetree/bindings/soc/starfive/
-F:	drivers/soc/starfive/
+F:	drivers/pmdomain/starfive/
 
 STARFIVE TRNG DRIVER
 M:	Jia Jie Ho <jiajie.ho@starfivetech.com>
diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index cfe9ea754062..67049ebf7265 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -12,5 +12,6 @@ source "drivers/pmdomain/renesas/Kconfig"
 source "drivers/pmdomain/rockchip/Kconfig"
 source "drivers/pmdomain/samsung/Kconfig"
 source "drivers/pmdomain/st/Kconfig"
+source "drivers/pmdomain/starfive/Kconfig"
 
 endmenu
diff --git a/drivers/soc/starfive/Kconfig b/drivers/pmdomain/starfive/Kconfig
similarity index 100%
rename from drivers/soc/starfive/Kconfig
rename to drivers/pmdomain/starfive/Kconfig
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 8b46da40f107..10a9ff84ff41 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -23,7 +23,6 @@ source "drivers/soc/renesas/Kconfig"
 source "drivers/soc/rockchip/Kconfig"
 source "drivers/soc/samsung/Kconfig"
 source "drivers/soc/sifive/Kconfig"
-source "drivers/soc/starfive/Kconfig"
 source "drivers/soc/sunxi/Kconfig"
 source "drivers/soc/tegra/Kconfig"
 source "drivers/soc/ti/Kconfig"
-- 
2.34.1


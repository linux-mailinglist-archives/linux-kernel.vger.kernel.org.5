Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43933768F05
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjGaHhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjGaHgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:36:49 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A259EE;
        Mon, 31 Jul 2023 00:36:48 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe0e34f498so6319506e87.2;
        Mon, 31 Jul 2023 00:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690789006; x=1691393806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6j0RW75STEI+5ZneQ+EaoJsYheY8+d1jwea7sk4EPgA=;
        b=T/MFohopS/BeXcEOIKcI+cKbio9xHJw754uW1T4iafV4Cpc+VMjI32RZqanKyS0c3u
         ClVlopqABlN0fqoAfTJQ1PEq2enBvzqMS1t65L3ynFlWX6m7Sq2zHmP0XKqYL/rEtfw8
         DgZV22HlJaGMpLTaP9J+NixAUS71c+zIIQZ6o/8q/Cfdw1jPi1TAusj14G50cQHwGxcE
         C8NgkGO3B1UUKEMSgrPrL4wLGz43APbpoLnUIKnSbs4Uz0eVw5CU91pz7c5JnFMscf6B
         5ZUrxnGap4NaiA5LuXs+0koOCjymRdigu1CsB4Kg/AHFVaSpftWmMQ504YBe4WpnuuiU
         sHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690789006; x=1691393806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6j0RW75STEI+5ZneQ+EaoJsYheY8+d1jwea7sk4EPgA=;
        b=b5RX22qso+PF+kbtNK7KlW/f2wIj+2J978XV8Dx4+2rMgkNrl759oDU2PU8fi6LXWq
         0J3Qx/Rgjrxl58hFeMuh0/BcYhEHh7zSYtqE/Zn9V/RfNsxKRtdgeTAd+Ob9zpW8B14J
         KAG55c9uUuUjYXuTN2dYA4W7QlF/HbrcGuR+ROXpOoP2rtpgfmveBP3f3FxrwjTGP4mn
         M+H09ri9zywRLyonz6yE0ogLUpLflkjTbRV+qgdtTS51JytJUsy0sTxeoiIYFPkePZQc
         XmMGEfkahK1MURX5/Ur7gy+BQMGctJ/qCty3Xofze6C/dmM1la9yW6uUC+QcPl0MxHlx
         ztmA==
X-Gm-Message-State: ABy/qLYlF1wuJsX3yM6eXYJL+ADu6dL99Nr1sCpBVeiqIVA+y/ufK6Mn
        OAzMP0PIOlhsYe6rQXtHtW1Pfs6rdvmI8A==
X-Google-Smtp-Source: APBJJlEjVuG3rpNknzE+EPZVjnZ7ZAzAmvi4ufDOCu979EnSfo/KhZ/P7n7O1xJ0r5fu+kF5CV21Yw==
X-Received: by 2002:ac2:5df3:0:b0:4fb:89b3:3373 with SMTP id z19-20020ac25df3000000b004fb89b33373mr4822337lfq.43.1690789006542;
        Mon, 31 Jul 2023 00:36:46 -0700 (PDT)
Received: from xeon.. ([188.163.112.48])
        by smtp.gmail.com with ESMTPSA id m14-20020a056512014e00b004fe3229e584sm586898lfo.270.2023.07.31.00.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 00:36:46 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Iskren Chernev <me@iskren.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Stefan Hansson <newbie13xd@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 4/4] ARM: configs: s5pv210_defconfig: enable IIO required by MAX17040
Date:   Mon, 31 Jul 2023 10:36:13 +0300
Message-Id: <20230731073613.10394-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731073613.10394-1-clamor95@gmail.com>
References: <20230731073613.10394-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After adding support for passing temperature data from thermal sensor
to MAX17040 it got dependency on CONFIG_IIO. From all defconfigs
using MAX17040 only s5pv210_defconfig did not have IIO already enabled
so let's enable it to avoid regression.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/configs/s5pv210_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv210_defconfig
index 4c1e480b5bbd..24070ee3d43e 100644
--- a/arch/arm/configs/s5pv210_defconfig
+++ b/arch/arm/configs/s5pv210_defconfig
@@ -97,6 +97,7 @@ CONFIG_MMC_SDHCI_S3C_DMA=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_MAX8998=m
 CONFIG_DMADEVICES=y
+CONFIG_IIO=y
 CONFIG_PWM=y
 CONFIG_PWM_SAMSUNG=y
 CONFIG_PHY_SAMSUNG_USB2=m
-- 
2.39.2


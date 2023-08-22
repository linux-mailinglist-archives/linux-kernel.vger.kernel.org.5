Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FE9784C16
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjHVVdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjHVVdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:33:35 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D93CDF;
        Tue, 22 Aug 2023 14:33:32 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1cc69d1f9b1so389028fac.1;
        Tue, 22 Aug 2023 14:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692740012; x=1693344812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=INI5oiFH+66CehZMbF3pmu6G1MXsfiESDSRSKZHLaRY=;
        b=fgqVrynvkq6uP08BaXCnNWw/p06D/4o+QC336L0CUsEz6UD+oH/Vd4n0c1wMnzIUhF
         vUgxAe4dYrQz9skKsjzGsWzOCr31RfbD11PENfLsAgUCuUPlZmu3mRJ2xKBb9jkF1O8j
         sDzgCt4LBN11ek0r5qJNa1aXnACy7u45hPSIsubH2c86OBOsqxKpVxNFu1FyrNDrDtWO
         RjX/vugFLc52L+h0NDjP7saPh9TmmXhVVLLkScpi8WCx3zgJCk9vGhv+zWWfPo/UaAUd
         7LGrT6f7NVCH4g/1U4hQYDInBbYQ1AzaJSW114/jcURPz4LR7IWv4of2UuD0BtURJwyE
         Td8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692740012; x=1693344812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=INI5oiFH+66CehZMbF3pmu6G1MXsfiESDSRSKZHLaRY=;
        b=NuloRnzIiVY2yofWCvZGIGjVD+PCz1y6J8F2FCInyyGiVaHNz2kBomVJNZSKDPxrh8
         B/qqpfeDPPIoQqyFTUz/sm4b7nIfJJDBcbjS9rfRa/KluSdECQJoI0DmjZjtgI03zUii
         +FBBX6ccrKGLLm9Df6FTinErysG5UmS0fDPgf1HKON9QhDjeQB2zQDJ0o63zqmACu8F8
         k+gB0Nzdny4ResfppTOccpQRjRGZ0KDQOy7bqHAQ2rC3j3OSMX4aOoZOBzsSkhSKS8Ze
         uRHU2SqrR5a4qrWt83nafFhBhROPMaMS9eEcp5SQhr5i36+Z06zoGF7+D5zg5HFWDhkl
         jxqQ==
X-Gm-Message-State: AOJu0YwOJ4s6LYRU1I5/bV0ay1qx8UFexXYmITvdscgdZDkpgAM2mOUX
        RfnNs4Knm3JFMsUOU1KSank=
X-Google-Smtp-Source: AGHT+IGdU9WK6dn0/CXstsASCTDYl3IpbJI/A3uatHo8Wxh/zd0fX94yR6UvkFhzl1DJF/dXvby6yg==
X-Received: by 2002:a05:6808:1599:b0:3a8:7446:7aba with SMTP id t25-20020a056808159900b003a874467abamr97745oiw.5.1692740011888;
        Tue, 22 Aug 2023 14:33:31 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:1bf5:f5af:8849:83c8])
        by smtp.gmail.com with ESMTPSA id r2-20020a056870878200b001c4b473581fsm6081220oam.12.2023.08.22.14.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 14:33:31 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     robh+dt@kernel.org
Cc:     linux-doc@vger.kernel.org, giometti@enneenne.com,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@denx.de>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] MAINTAINERS: pps: Update pps-gpio bindings location
Date:   Tue, 22 Aug 2023 18:33:17 -0300
Message-Id: <20230822213317.60798-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

The pps-gpio bindings have been converted to yaml.

Update the file path accordingly.

Fixes: 7ceb60ece856 ("dt-bindings: pps: pps-gpio: Convert to yaml")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308230517.n0rrszYH-lkp@intel.com/
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf8dd33048ba..afde89d9b7ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17132,7 +17132,7 @@ L:	linuxpps@ml.enneenne.com (subscribers-only)
 S:	Maintained
 W:	http://wiki.enneenne.com/index.php/LinuxPPS_support
 F:	Documentation/ABI/testing/sysfs-pps
-F:	Documentation/devicetree/bindings/pps/pps-gpio.txt
+F:	Documentation/devicetree/bindings/pps/pps-gpio.yaml
 F:	Documentation/driver-api/pps.rst
 F:	drivers/pps/
 F:	include/linux/pps*.h
-- 
2.34.1


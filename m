Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909D67776C5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbjHJLUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbjHJLUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:20:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDB826A6;
        Thu, 10 Aug 2023 04:20:30 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe45481edfso7445875e9.1;
        Thu, 10 Aug 2023 04:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691666429; x=1692271229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aDxxSL5D6Sg3pDQaCyyvxAHt6fubmFUtWux90siqRTQ=;
        b=Xsdv6p1JFUc3C4H+0bKCf2jHxp5Y3znRMVnOofMY2s6Ptj4aj/X4TQdTeTfArxefJx
         QRjNmoBZpwk7WM3WGAplTmi1YCDjVqNnI2tiCgDfVUp2pa49/hPdOQONhbt5LFMlt/Nm
         BHmWJMyyG1CxrfC5/UkCJV2fXZaY6l3heDMvaLNmbPGOodPK3Ak+y2Mg+qM7VOPYlvgG
         1a//ykXhw1leGEpavV4/SLjbc/B/f1MWuNR9Kmi+azi9Z8x/C+VmEuyU5gd324DIqmXj
         8HjizvyE48QWTfMvLSJMb0uI1j5a1zspqXFc6PpJEEXitdSFSoi4g9UNfOd8xpDOOs5H
         SOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691666429; x=1692271229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDxxSL5D6Sg3pDQaCyyvxAHt6fubmFUtWux90siqRTQ=;
        b=ICkWJ+WvRG03QHerrjJ2JrY1ri+tWehEDqCwXpSR0LCoc1RzogCjhz9XNLnZbLuRDz
         GzSOCf3hP1OKYsMg2W3vgTfZbjJFCpJivFL7zuor0IphLx9uPFEdWiLyVivY5Npnpt6s
         SC/xELdwAxer0NGqxbalBIOYKTVCGiixoCDVKrnNGGT2iOo60uyt8DAxgKntfp+hxHF2
         O+hkFMRTzYO5nOgbyIPQLvwI7B/dIfWnNKjZIqaj2KKizfbC1gwtO7GUSZk9B2dLWTXA
         PIYLjfCuKXZSyk/EFe0R7HYcztVYDByGqYPO11o3Z+QqKruxWbWqsLLUqHxmJr+R8gbq
         PtIQ==
X-Gm-Message-State: AOJu0YySlmmxEReXH/7PQca36EIiAqYpIX+NR+fpNxKgfSsXY6u52G2S
        rc2ES5DVYVdA4W0UfcqxQnK86fJ3RSYjzg==
X-Google-Smtp-Source: AGHT+IHeUcCVJQa8xo+iWniLi8iqv80aYSxC07IlpGqKy81o0FO9dXhQnWzPwcycW8D8G0xBRHH84w==
X-Received: by 2002:a5d:4683:0:b0:314:1a09:6e71 with SMTP id u3-20020a5d4683000000b003141a096e71mr2024174wrq.53.1691666428950;
        Thu, 10 Aug 2023 04:20:28 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id b2-20020adfde02000000b0031416362e23sm1856872wrm.3.2023.08.10.04.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 04:20:28 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     rui.zhang@intel.com, amitk@kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org, alex@shruggie.ro,
        Andrei Coardos <aboutphysycs@gmail.com>
Subject: [PATCH] thermal: k3_j72xx_bandgap: removed unneeded call to platform_set_drvdata()
Date:   Thu, 10 Aug 2023 14:20:15 +0300
Message-Id: <20230810112015.3578-1-aboutphysycs@gmail.com>
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

This function call was found to be unnecessary as there is no equivalent
platform_get_drvdata() call to access the private data of the driver. Also,
the private data is defined in this driver, so there is no risk of it being
accessed outside of this driver file.

Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---
 drivers/thermal/k3_j72xx_bandgap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index 5be1f09eeb2c..b91743dbd95a 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -502,8 +502,6 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 	writel(K3_VTM_ANYMAXT_OUTRG_ALERT_EN, data[0].bgp->cfg2_base +
 	       K3_VTM_MISC_CTRL_OFFSET);
 
-	platform_set_drvdata(pdev, bgp);
-
 	print_look_up_table(dev, ref_table);
 	/*
 	 * Now that the derived_table has the appropriate look up values
-- 
2.34.1


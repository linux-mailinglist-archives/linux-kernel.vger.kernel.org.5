Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9F976E874
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbjHCMiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbjHCMiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:38:11 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E933588;
        Thu,  3 Aug 2023 05:38:10 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so1618293e87.3;
        Thu, 03 Aug 2023 05:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691066288; x=1691671088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CcaCDfX0BFhhT8O2jtA9kzTVYt90EjZQ+Ts58Cj63i8=;
        b=jLm0OLuevwmXG9ZxSiXZ7lGMbhmulL35HveYmXRWadKWrD17tkxZBHu7d0cuU+dMxT
         uwhbzCsMB+T0V9mimFYx+rq+7TmrGcA5Bu5+CCqDI2oY55iDrOGwbQCl8dfDow3WOOKh
         Br9bcSxslKpqbeoOcWHpcUutS5kagJetF+q3hVOdX5+JEvvf5aEnWM9EYgRd3hz4RjJ6
         F3OJSdWlVTCFwyWlywmLbd4/fGFwDMCC0ccv+pKUNVHHBTjv7bg8Ju806HtsTO2TGzu4
         KAa3ZZZjUrxYOF14twFKe+l6rBeWo7SHk6ZM/xPTH9fLecPWPL4g9soD4ijRjqLyuqtE
         U0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691066288; x=1691671088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CcaCDfX0BFhhT8O2jtA9kzTVYt90EjZQ+Ts58Cj63i8=;
        b=YyYC+kh9myvKM23+rNel20RSjva11o3ZhldwhdCJ+BBje4X+5pneUv0aDbDQB/urAL
         kczVvrd3cWB33Hb25SjvDed67VNSMsD5vtixW2Ih1zAbezrKmF0qq6oZNOzldaBiCcwd
         w25jIMc2neHRVojfDyvHm8wufBf70ciifKUVissf6V3kfpzpX0WYig9TjH2UD8sQ9piS
         3P8tFaAv9IAEDOK+3/SSLh4iMNBq8E/I+NdaVatbuG3PLjr8D+Q4+8om3geFluD05CPg
         nkrfmRW2a6baWvLKErvKE21hIvRzF+xgYQzwreckpl2d0eBVG/wQZyiIUAkWdI/7nkEq
         iKKQ==
X-Gm-Message-State: ABy/qLZlkghM0A6dos5r/hmgIwn/mIIEWUQXmS4PpWGB50mL6UF6YMpe
        ZjZ5ib9hqrSot+GaPDemV2fSg6xiEwzf1Q==
X-Google-Smtp-Source: APBJJlGBQvKFg5NpQLwd+E2y8IaJeqMVxRUocBwIlgZTn+FZzp0eAqKjCE2g43Mqi/CEMkLeLpKHrQ==
X-Received: by 2002:ac2:58f1:0:b0:4fb:76a5:2325 with SMTP id v17-20020ac258f1000000b004fb76a52325mr6211932lfo.24.1691066287965;
        Thu, 03 Aug 2023 05:38:07 -0700 (PDT)
Received: from localhost (95-24-150-4.broadband.corbina.ru. [95.24.150.4])
        by smtp.gmail.com with ESMTPSA id n11-20020ac242cb000000b004fe0c0235ddsm3340546lfl.143.2023.08.03.05.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 05:38:06 -0700 (PDT)
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Mikhail Rudenko <mike.rudenko@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: fix file path for Omnvision OV4689
Date:   Thu,  3 Aug 2023 15:37:42 +0300
Message-ID: <20230803123743.1859036-1-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Correct the driver source path specified in the MAINTAINERS file,
which was mistakenly set due to an oversight during the driver's
initial addition.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3be1bdfe8ecc..daa8153bd1c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15620,7 +15620,7 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
-F:	drivers/media/i2c/ov5647.c
+F:	drivers/media/i2c/ov4689.c
 
 OMNIVISION OV5640 SENSOR DRIVER
 M:	Steve Longerbeam <slongerbeam@gmail.com>
-- 
2.41.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B3D7A3039
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 14:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239252AbjIPMjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 08:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239160AbjIPMjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 08:39:12 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEA419A;
        Sat, 16 Sep 2023 05:39:07 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5280ef23593so3446581a12.3;
        Sat, 16 Sep 2023 05:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694867946; x=1695472746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbUZvYmQNv8XlHrBCEW1i93lPke7LBgt2Bqs3H5wtAk=;
        b=F6iGH7t1axChCJBQ4Uaxbg98Y4TGX5MxKr8LsU3k6OXTPdBIyGRbYuMceFsEXU4ldk
         3ZHwMC6cSS6RctFKY4UaI3kdyYbS1ZakgohUvNulvlSvt3MsHJZkrPhDIxqyrSzeIHPc
         xHzyliViJ1HpDFqHvXBtf36UuTQtmA55r8+cJ127ZA227YBomiKH5yRANEABzXi4lW7L
         hsm9S90QBhmnCIWjHIRndbG24g0bRFad1g7xyPZqtuYCfETtaIJ1fuoMt8kGbYYRqz3c
         Sq7weyQj171yAco72DNj0n3s0aWRHGFHFqOlM1GcwX8XkXhYMcfUj1Os4fKppxauMGXC
         pt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694867946; x=1695472746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbUZvYmQNv8XlHrBCEW1i93lPke7LBgt2Bqs3H5wtAk=;
        b=QQ3yd+tYyLW2vthZMsYSi9r00NkiJZebTGo08g/B6obVQmuxC3yg+aE7cig9kNUFUB
         pqE5wM9lroOE2hG29p5jnzYqgK7SOCqf+dLjlskXw1EpPHSuzyqQYE8zbYolT3b61mm+
         NAxCmHA6XDCxj8n5nW4poX75U4f9e4TSMI/ASTIUY9qLdNhNE9Bb3zv2Big5chqXCAeE
         rwkP5UnaiaA14fHh/0HppbUsIGz93oOuiqPQCWSRjZQxEjh4CXl0OYy7rhny/s1VNzL6
         94GOZLi2LZHVvsiPZs+aqZoEM6lp2PIOH9jcGesFJOdVAHTMpfSlCv+I+65qcXG00B7G
         GB6Q==
X-Gm-Message-State: AOJu0YwOj54vqisrBxGQee9NBLZKX4rnMt316curU1/8twljBa0VlxW7
        2SpcDVb66xRmSGT/vVXAkxs=
X-Google-Smtp-Source: AGHT+IEW9exOYt9cVJju2hIT4N6DQ0wSOJuXq361U1FWB9/G6uY7vFibOZIXUkdPPmEq6pa9zXc1Gg==
X-Received: by 2002:a05:6402:14c4:b0:530:4fc4:50f8 with SMTP id f4-20020a05640214c400b005304fc450f8mr3350537edx.29.1694867945641;
        Sat, 16 Sep 2023 05:39:05 -0700 (PDT)
Received: from localhost.localdomain ([77.134.181.150])
        by smtp.gmail.com with ESMTPSA id bo6-20020a0564020b2600b0052284228e3bsm3474064edb.8.2023.09.16.05.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 05:39:05 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v9 3/7] iio: accel: kionix-kx022a: Warn on failed matches and assume compatibility
Date:   Sat, 16 Sep 2023 14:38:49 +0200
Message-Id: <b587cfec2f3350623277005f62121864bee857c7.1694867379.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1694867379.git.mehdi.djait.k@gmail.com>
References: <cover.1694867379.git.mehdi.djait.k@gmail.com>
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

Avoid error returns on a failure to match and instead just warn with
assumption that we have a correct dt-binding telling us that
some new device with a different ID is backwards compatible.

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
 drivers/iio/accel/kionix-kx022a.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index 2f1e7da25460..5a144f86c634 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -1025,10 +1025,8 @@ int kx022a_probe_internal(struct device *dev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to access sensor\n");
 
-	if (chip_id != KX022A_ID) {
-		dev_err(dev, "unsupported device 0x%x\n", chip_id);
-		return -EINVAL;
-	}
+	if (chip_id != KX022A_ID)
+		dev_warn(dev, "unknown device 0x%x\n", chip_id);
 
 	irq = fwnode_irq_get_byname(fwnode, "INT1");
 	if (irq > 0) {
-- 
2.30.2


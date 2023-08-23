Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBC6786231
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 23:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237967AbjHWVRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 17:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237754AbjHWVRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 17:17:19 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5D610D9;
        Wed, 23 Aug 2023 14:17:08 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31aeee69de0so3939690f8f.2;
        Wed, 23 Aug 2023 14:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692825427; x=1693430227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBhW4wID0JIBzXq30CtMEcBzXY+D5owAfsHnM6WiThM=;
        b=SW69Dt7EvPmo7GrI7+WQHgQ+C3j7Nhu6EtYvcJ7G39Zl2sIENZTwhg7y0ucsG8CaaH
         JURbDe8FCRB0hBZfr6VX+j3cr5GLZfQcokWIY9k51BpJAgNP8ljrf/uYUBWF2DQtnm4U
         gpMWrOn5wSo4pbUkPCalTRryV0d/I3Jpfl8Kz7hpOW5t33suqplq5uBhYi3VC3zIKTXD
         ia0672jI7yscD4dIG9YJLPBCS1+JYSyTJPIYnkUzf6Uto7zlR4sfXmgChb+BSzohnuD4
         zIjNtWZs7DbxsOTfZYO9aFmHJRkMPMYrQaB6T04BQUR2B4AgjtglEqIYZUIooIdD0B1C
         cIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692825427; x=1693430227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBhW4wID0JIBzXq30CtMEcBzXY+D5owAfsHnM6WiThM=;
        b=Gl7/RwamSPfmwWS1CO353ZYs6pFf2SyGagWLtRgny82GqvVrBe4FHqQLWzQ/MvhwlM
         JXAL3a/5u5W3t03CdDjcmIlntVR8F2EpkjnE+fjxp/bs13knrhba9QJaXBck30orMvsu
         iVN2RZ4zMRA+Hb+haif61khLOr2D9SOXz5Hn786mQS8ASeoazV60Uvy6uBTj+OWIX13n
         OTtJeTuHXUCcqn2r2ib/TNRAZmq2PxbPSvmO0rPiSQPXPWkUrCYx92MXz7QLkxJBQDbE
         E738A6/50Uil0b7jjJMhLAXbjweImzW0Ca7CZVr6wlodups+ES6ScU23pkc0OynnBt72
         8cZQ==
X-Gm-Message-State: AOJu0YwZDfvw4DDTo5q4tYB2FZgqmHkybFy0zWj3t1Mw9GmUijJg4VZD
        xsjDPw0GscDm1my+px7W/xQ=
X-Google-Smtp-Source: AGHT+IEYbuRCCegB3AHGhT/w7aCIe7XV+NZ/igBPNz52HC1CAMdzL/YdUZvMcbJz7UTiLK6nTR5YZA==
X-Received: by 2002:adf:f184:0:b0:314:35e2:e28d with SMTP id h4-20020adff184000000b0031435e2e28dmr10951714wro.13.1692825426825;
        Wed, 23 Aug 2023 14:17:06 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:bb2:6df0:64ae:3840:3a64:b26a])
        by smtp.gmail.com with ESMTPSA id p11-20020adfe60b000000b003176c6e87b1sm20193399wrm.81.2023.08.23.14.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 14:17:05 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v8 3/7] iio: accel: kionix-kx022a: Warn on failed matches and assume compatibility
Date:   Wed, 23 Aug 2023 23:16:37 +0200
Message-Id: <2c69e918cb6dfab663bb62952c554b6b72f58390.1692824815.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1692824815.git.mehdi.djait.k@gmail.com>
References: <cover.1692824815.git.mehdi.djait.k@gmail.com>
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
v8:
v7:
v6:
v5:
v4:
- no changes

v3:
- changed from 'unsupported' to 'unknown'
- removed the opening bracket

v2:
- no changes, this patch is introduced in the v2

 drivers/iio/accel/kionix-kx022a.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index ff8aa7b9568e..494e81ba1da9 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -1036,10 +1036,8 @@ int kx022a_probe_internal(struct device *dev)
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


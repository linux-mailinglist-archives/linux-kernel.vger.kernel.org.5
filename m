Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C057A3650
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 17:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236931AbjIQP2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 11:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbjIQP1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 11:27:41 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE5711F;
        Sun, 17 Sep 2023 08:27:36 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40479f8325fso27476235e9.1;
        Sun, 17 Sep 2023 08:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694964454; x=1695569254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQmw68BxoRUha7oPFqTU+EThuQkLbUrzB5b28thzr/w=;
        b=PNP/Km3+QM9MWFoWr2JMVGrGbtl5kNIa9gKQ32lro2WIkUwF0xG16PV8r1zlAjF2fu
         9L7EzM2+HHDLPnx2+3j7lBTIS5x6hHLDXMDtTeyJMxGLEM6e6iiYBYb4TEL/AHmbmLTn
         YGCVLKA7+3MiREH3UsYu1/C5C5y1RBbeQvSuUeCqr+MMnYSun70XznzRQPZGj0FIQ5uR
         eNcv/IFZfsEEcuhq5WReFmXW3T+GQ9iLdP6114eljbScokvEL85gua3wqwxzPKXOg7XS
         gUykcTRvuGGLMXBWLbTn+5DCo3gGupX666zRc30f6P24KJfjaAa1YJKgs/BKHVYPuClu
         aYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694964454; x=1695569254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQmw68BxoRUha7oPFqTU+EThuQkLbUrzB5b28thzr/w=;
        b=GH9cT7K/lW3tnujngpPDTF1nG8hLL+rZ4TrDLi6G+O3Ho10sddAx77omGTP3wyOkYc
         APRp7Hh84HamemtFpELkpoxiIvHzZB7xek5rPed1BlLnmoCPfHabw3v67frtR117giqw
         GQpiIkJwe1XJFXdZeeJOzIsQBwAiCT0VXdjTuknGanWr0ILFE6MlfXmR5Js78AnF0aXY
         Q3LMVpFTsgnEr1nZKBgVYS+ZjJ8Gx0qGQgVy7vzRu3FY3JBUv7Q0EvVPAGL5oRS5gVTx
         TJHWeZGiy6uEQU3jBaDi0c4836ZtT4ppuos/8CuBqqgoNFQlZnJgvR9bg/Y5v6ote/Bf
         cOCw==
X-Gm-Message-State: AOJu0Yw8XFq3aYxJ4X5RH6u6a2+rO/nGKvq+Hu4mRva4L1ZNzwkq7PFz
        kbU393D//5XgSrt9VS1U+vs=
X-Google-Smtp-Source: AGHT+IHXg5bI6LiwY5neIQaMjC6xoDzCmTHWLh8hZoZeoHAxA0NwnWzPpBV+I/WJq0bGf0N2OD9Imw==
X-Received: by 2002:a7b:c415:0:b0:403:442:5421 with SMTP id k21-20020a7bc415000000b0040304425421mr5271816wmi.4.1694964454299;
        Sun, 17 Sep 2023 08:27:34 -0700 (PDT)
Received: from localhost.localdomain ([5.45.134.53])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c489700b003fe15ac0934sm7388865wmp.1.2023.09.17.08.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 08:27:33 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        abdelalkuor@geotab.com
Subject: [PATCH v5 07/15] USB: typec: Apply patch again after power resume
Date:   Sun, 17 Sep 2023 11:26:31 -0400
Message-Id: <20230917152639.21443-8-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230917152639.21443-1-alkuor@gmail.com>
References: <20230917152639.21443-1-alkuor@gmail.com>
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

From: Abdel Alkuor <abdelalkuor@geotab.com>

TPS25750 PD controller might be powered off externally at power suspend,
after resuming PD controller power back, apply the patch again.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
 drivers/usb/typec/tipd/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 3ad8112c78b6..bd5436fd88fd 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -1189,6 +1189,18 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct tps6598x *tps = i2c_get_clientdata(client);
+	u8 mode;
+	int ret;
+
+	ret = tps6598x_check_mode(tps, &mode);
+	if (ret)
+		return ret;
+
+	if (mode == TPS_MODE_PTCH) {
+		ret = tps25750_apply_patch(tps);
+		if (ret)
+			return ret;
+	}
 
 	if (tps->wakeup) {
 		disable_irq_wake(client->irq);
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0C97B460C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbjJAIPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbjJAIPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:15:42 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363AB11B;
        Sun,  1 Oct 2023 01:15:31 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9a648f9d8e3so2221916366b.1;
        Sun, 01 Oct 2023 01:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696148130; x=1696752930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWPzDpCgbdga7D5FXbvvos+grST88yl+CjFPhYb4TDA=;
        b=lhGICNzX7uUj9Foc0oDMrHWeOdO5z/mpiC0bDdgTg2CGvxjtYQeguw21xWNquht6bg
         NzMHG9D0VnjgUbxOIolVTLxQV8geUMaUnA97hTzLwcBL2bgV082RKTqpme1BkyeP2QZ7
         McdrziK48w5ViGId7FIzSe5dfn/XJR3BAe6xuko+H3/fv0M6rl6Q5G5iftfLIyYq60cI
         uXKvh8JZgYOp5/EoMRXnS/ycMQVRPL5jvzrvHlDNuxLwaZzSTTJlKLB8NA/IJUF+QbNg
         QThWGcoMmRenzlHYGNcyagpzuZKq+KxqOdLUWhpzl0LzubZakfEYE363+BEj6yyO3wh7
         mi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696148130; x=1696752930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWPzDpCgbdga7D5FXbvvos+grST88yl+CjFPhYb4TDA=;
        b=SLLU4TDT3Gck5ZPU1I4MMZPp1A9Loow6dKSTk/qpDW+uLvvtqSr+RYe1z3KwO7/KBM
         TqPYx0LJpeKDF9t60sQjpD6yD92LBsu1tva1Q6S7NpwhWYS6avLELWClESw4hRrea+jC
         OVTZT3phZ+nOlKvpbZP4LPoniA3CqoLsmVU4V9PO8iGoYWoHNK7vzU6RGNXVP5UO/8Fw
         Av1v5Zoq/Fkcyw9xYpmgQaDexcsh0Rx5v2XroF4yAxsTH530CdIq3liupgqXS4p6rWqo
         Em8AZuE8x/D6a5BqmgNAr6ONMgk6Ffskw1uKNNn0vmmNzNdU1JcoWHUZFUlod5MH5jZq
         nUYg==
X-Gm-Message-State: AOJu0Yxr8lgvVRpDe2d9tQwsOtRyH9nFrOk/pB3TwW/vgYCa6+OX8491
        QbHQsiorZcYeHFqzKWxoz18LBeIrCJm5JHJ7ASU=
X-Google-Smtp-Source: AGHT+IHDsTec3fgiEALS+siWRNMOHfVUW6qb1cbHfSNwkpqVRAS+Y46ASHD9C7yZFgvbYqnksAArrQ==
X-Received: by 2002:a17:906:20d9:b0:9ad:7d5c:3d4b with SMTP id c25-20020a17090620d900b009ad7d5c3d4bmr7734269ejc.35.1696148129945;
        Sun, 01 Oct 2023 01:15:29 -0700 (PDT)
Received: from primary.. ([213.139.52.198])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906374800b0099cf840527csm15121841ejc.153.2023.10.01.01.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 01:15:29 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v9 07/14] USB: typec: tps6598x: Apply patch again after power resume
Date:   Sun,  1 Oct 2023 04:11:27 -0400
Message-Id: <20231001081134.37101-8-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231001081134.37101-1-alkuor@gmail.com>
References: <20231001081134.37101-1-alkuor@gmail.com>
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
Changes in v9:
  - No changes
Changes in v8:
  - Use device_is_compatible instead of of_device_is_compatible
Changes in v7:
  - Add driver name to commit subject
Changes in v6:
  - Check tps25750 using is_compatiable device node
Changes in v5:
  - Incorporating tps25750 into tps6598x driver
 drivers/usb/typec/tipd/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 2598433a69cf..32e42798688f 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -1203,6 +1203,17 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct tps6598x *tps = i2c_get_clientdata(client);
+	int ret;
+
+	ret = tps6598x_check_mode(tps);
+	if (ret < 0)
+		return ret;
+
+	if (device_is_compatible(tps->dev, "ti,tps25750") && ret == TPS_MODE_PTCH) {
+		ret = tps25750_apply_patch(tps);
+		if (ret)
+			return ret;
+	}
 
 	if (tps->wakeup) {
 		disable_irq_wake(client->irq);
-- 
2.34.1


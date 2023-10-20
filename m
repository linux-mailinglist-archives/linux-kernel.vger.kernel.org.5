Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EC27D1634
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 21:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjJTTLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 15:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjJTTLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 15:11:12 -0400
Received: from mail-oo1-xc4a.google.com (mail-oo1-xc4a.google.com [IPv6:2607:f8b0:4864:20::c4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B176FD5B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 12:11:09 -0700 (PDT)
Received: by mail-oo1-xc4a.google.com with SMTP id 006d021491bc7-581f38fe82cso1969672eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 12:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697829069; x=1698433869; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JCm2M6I5bgNLk9qAIkXy20cqaWg+1XaBIDAOydYH9Ss=;
        b=U5Ny8KDY4rZVRqWlkixhibI67Yo2VCbvNUiMvMCxbU4+s4tK+in4eDDVKaMpGaZUvw
         7Hk2Uub+4GSzi18+BC6aNa2MWElAd2USZF5UHKn/HwPVDfsS2OObGDOSkXnUUm4TN1N7
         UW5aa+1kTPHH0smZ3uEjs2UMwQb2Iw4EA3/V0JXDZmbJ2ja2dujdXlkdRt5LPWnd5+2S
         XqlAMzlya8RqudGicN7esfIn7ZKeXIfj1h23b7YJn77nZfhwfqjKOEp44Dfe8FZ9nTo6
         iueD44LmqxV6/cdlo8AMpNhCVwo6bX4OTIjfZ2uwdLahoBX32hxalTXZDff9wYYNBDld
         7UfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697829069; x=1698433869;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JCm2M6I5bgNLk9qAIkXy20cqaWg+1XaBIDAOydYH9Ss=;
        b=t/qxnsPxQ5jLznl+Mp4zHrZisfEwqtDv/mB7S+AzVGbd2xTaCN23swiwzvEhTVspFJ
         7Qneo2kp9mGvaDHJ+Ly6BxN22FW7IvaHHcqlnoVLA9FPAjGcoAM90hB4tWVx4v4Xs10O
         +dnDRCtujmkSUwsuCai072lKzy+2Cwu2qFXy3YfmhBBCUzApKs8u2oI88T2D+rKn4yXj
         76QYXIosIhYGD2s5PgjjG8Irfttzd01heW0OwUvy9w68LSzId1GRmPKRPgPKeJyMrp9+
         0nLj1C7VvQOiqP5g4ljGCg2BYcc/CikluPHcWSNbIehvczEzOeVhIV1Ih7Kiai+l7IAk
         Y/MA==
X-Gm-Message-State: AOJu0YyCyKbqZDYaGNiwDmAwgJ2ReNmuy+AKwz+nfT6Sm/0bYl27OrgQ
        GEbVZXFgHjNrXFb9Wwg16FzuwZQaRJf3eq4AeQ==
X-Google-Smtp-Source: AGHT+IEqvLzXV0BCbJ0SSa/RhsQXtiSfYp3NxAn7pGZKKdDUbMG4kYhUVRRgyLbX/hTr51wstV6LTNAoB5/kVEFMnw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a4a:7441:0:b0:581:dbb1:219b with SMTP
 id t1-20020a4a7441000000b00581dbb1219bmr947789ooe.0.1697829068928; Fri, 20
 Oct 2023 12:11:08 -0700 (PDT)
Date:   Fri, 20 Oct 2023 19:11:07 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMrQMmUC/x2NUQrCMBAFr1L224UkpZB4FRExybYuSBp3tbaU3
 t3g5zyYNzsoCZPCudtBaGHluTSwpw7S414mQs6NwRnXW+MM6ltKqhtm4YVEsc5fEtRPrc8N48s NwZtbU2Vqc8IQffSjtbk3AdppFRp5/Qcv1+P4AVjzVWGAAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697829067; l=2877;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=u+18cFaIHnUUKwHSCJsgL5LfGU9t+G4HsmSCTeLLoLQ=; b=8FO7so2vWbouPTrrT9aPtQNW43rRsmEn5X0jiNZbdX35BM72HcSNWPRlPuRiYWxYkDjOogAhU
 riJeM/LPOzjBUjlfqbUeeBCfheXKSoLdgYkccwoGD7iS+oBRAs5jLLV
X-Mailer: b4 0.12.3
Message-ID: <20231020-strncpy-drivers-power-supply-bq25980_charger-c-v1-1-7b93be54537b@google.com>
Subject: [PATCH] power: supply: bq25980: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect bq->model_name to be NUL-terminated based on its usage with
sysfs_emit and format strings:

val->strval is assigned to bq->model_name in
bq25980_get_charger_property():
|       val->strval = bq->model_name;

... then in power_supply_sysfs.c we use value.strval with a format string:
|       ret = sysfs_emit(buf, "%s\n", value.strval);

we assigned value.strval via:
|       ret = power_supply_get_property(psy, psp, &value);
... which invokes psy->desc->get_property():
|       return psy->desc->get_property(psy, psp, val);

with bq25980_get_charger_property():
|       static const struct power_supply_desc bq25980_power_supply_desc = {
...
|       	.get_property = bq25980_get_charger_property,

Moreover, no NUL-padding is required as bq is zero-allocated in
bq25980_charger.c:
|       bq = devm_kzalloc(dev, sizeof(*bq), GFP_KERNEL);

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Let's also opt to use the more idiomatic strscpy() usage of (dest, src,
sizeof(dest)) as this more closely ties the destination buffer and the
length.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Similar-to: https://lore.kernel.org/all/20231020-strncpy-drivers-power-supply-bq24190_charger-c-v1-1-e896223cb795@google.com/
Similar-to: https://lore.kernel.org/all/20231020-strncpy-drivers-power-supply-bq2515x_charger-c-v1-1-46664c6edf78@google.com/
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/power/supply/bq25980_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq25980_charger.c b/drivers/power/supply/bq25980_charger.c
index d8411722266f..0c5e2938bb36 100644
--- a/drivers/power/supply/bq25980_charger.c
+++ b/drivers/power/supply/bq25980_charger.c
@@ -1223,7 +1223,7 @@ static int bq25980_probe(struct i2c_client *client)
 
 	mutex_init(&bq->lock);
 
-	strncpy(bq->model_name, id->name, I2C_NAME_SIZE);
+	strscpy(bq->model_name, id->name, sizeof(bq->model_name));
 	bq->chip_info = &bq25980_chip_info_tbl[id->driver_data];
 
 	bq->regmap = devm_regmap_init_i2c(client,

---
base-commit: bb55d7f7f7445abcc8db50e6a65d4315e79f75c7
change-id: 20231020-strncpy-drivers-power-supply-bq25980_charger-c-9b8b8f11d309

Best regards,
--
Justin Stitt <justinstitt@google.com>


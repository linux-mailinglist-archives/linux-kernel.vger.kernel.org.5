Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C297D1643
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 21:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjJTTWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 15:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJTTWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 15:22:02 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3DE1A8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 12:21:50 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7ac9c1522so17639787b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 12:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697829710; x=1698434510; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qALOrG6vepevyfdTV65I5X2dgTb+XRjcAA0K1wR5V78=;
        b=avyZOTCxSheiio0cQy8we9ioz7bsEXKOaiDle56ZEEWD3VeroRzhHAwYc4FvxMOp12
         6CrHrDFoZI556Xdrb+S2T5Ipy7xAkWN04RAjc+wKelNnx4Na7l02arP7YLwqEOlWkcLu
         ufExZn8FipZ9QPhE6+UsYRwJOzotnuX2LtpRfueFfT7c+RsLaTToycOE76C2GsF/xJEl
         tfvQOgfzs64n6rTLv5nYP0b59jcO8nmPxEhTxl24l20Ip3H8LyAD4Ep0H6ZSorrfw7MD
         fKicyMxWnxHFtvh1B2OEIGKDclqoQG7f/L2eLd/m7g8/v2/0IzLiZ2W7N6nckd6Ot7ao
         Le2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697829710; x=1698434510;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qALOrG6vepevyfdTV65I5X2dgTb+XRjcAA0K1wR5V78=;
        b=JEd036jt1kOaNkVXAjyQ4X4YjsmlevLlhA2q/JdXpUlqoGUgw1mGXpugxO1179Cxdx
         5sszsOSnUh6HgJz5AGflqwLaXOaIYJAVAC9feN1joC9sG1puIbkDlP3DjAvM1ROyZBt3
         MbM9Q59f3K5WhYRBOKcjfvl97TQeq4Da5Cx+5XnbhT93EmatHUboYxt1mT17J1Bi5RmV
         DnkHTYz5GwlqvIv3uLFBU/pOq/jS7K/UniJy6RiukrTH+W01yluszYaWwu6AdI7u5gkp
         tYWPIdB+GMWLSBGXpaeD0tOuSKBJvsvOuipr9iaOWYRd3pB0+2Q4Oe3z++2YIV7hAUAz
         Ep6A==
X-Gm-Message-State: AOJu0YzZW7b8WvBkA2oK82yQ4+en5WlhXCD8s3921L4N9c2K7GhyBLRP
        +OH6IlsjY49eR7aTpPFxVOd6U/UfYGGRAY+etw==
X-Google-Smtp-Source: AGHT+IF0gbKlBuVYWFSDhK1cHQbvO0vJ+f+8x3DRXak9PN8AwNgsgu3tNhmxk4ZIHpRQ+61kd2848nUx67nBfQ58iQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:d110:0:b0:d9c:c9a8:8c27 with SMTP
 id i16-20020a25d110000000b00d9cc9a88c27mr57393ybg.13.1697829709856; Fri, 20
 Oct 2023 12:21:49 -0700 (PDT)
Date:   Fri, 20 Oct 2023 19:21:46 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAErTMmUC/x3NwQqDQAwE0F+RnBtYIyj2V0oPyxptoF2XpLUV8
 d+NPQ3vMDMbGKuwwbXaQHkRkzk76ksF6RHzxCiDGyhQUwcKaG/Nqaw4qCyshmX+sqJ9Snmu6BW dnK+Y45kJqWm7tuOxpz6BjxblUX7/w9t93w+Y0Zw+gAAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697829708; l=2442;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=Mdqt94cfpfyPw2z8vNiZUw0jKlb6Y4rhrl6QkPkNsjg=; b=eGMemd00Wx/G5iPloPDERokDgu99pfw0hb8wRp5tP7bzTbL5R7kAwXrl89cUd53z1hIPdIRS8
 PsuJh/QEPMuD+eAqiCuQ/YtrDg+fE0fCywNIJFMoI5Bm2NEFlO3Dq6u
X-Mailer: b4 0.12.3
Message-ID: <20231020-strncpy-drivers-power-supply-charger-manager-c-v1-1-698f73bcad2a@google.com>
Subject: [PATCH] power: supply: charger-manager: replace deprecated strncpy
 with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect cm->psy_name_buf to be NUL-terminated based on its usage with
format strings:
1522: cm->charger_psy_desc.name = cm->psy_name_buf;
...
1587: dev_err(&pdev->dev, "Cannot register charger-manager with name \"%s\"\n",
1587:   cm->charger_psy_desc.name);

Moreover, NUL-padding is not required as `cm` is already zero-allocated
and thus any future NUL-byte assignments (like what strncpy() will do)
are redundant:
1437: cm = devm_kzalloc(&pdev->dev, sizeof(*cm), GFP_KERNEL);

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Let's also opt for the more idiomatic strscpy() usage of:
strscpy(dest, src, sizeof(dest)).

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/power/supply/charger-manager.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 5fa6ba7f41e1..085d5277bc19 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1516,9 +1516,11 @@ static int charger_manager_probe(struct platform_device *pdev)
 	memcpy(&cm->charger_psy_desc, &psy_default, sizeof(psy_default));
 
 	if (!desc->psy_name)
-		strncpy(cm->psy_name_buf, psy_default.name, PSY_NAME_MAX);
+		strscpy(cm->psy_name_buf, psy_default.name,
+			sizeof(cm->psy_name_buf));
 	else
-		strncpy(cm->psy_name_buf, desc->psy_name, PSY_NAME_MAX);
+		strscpy(cm->psy_name_buf, desc->psy_name,
+			sizeof(cm->psy_name_buf));
 	cm->charger_psy_desc.name = cm->psy_name_buf;
 
 	/* Allocate for psy properties because they may vary */

---
base-commit: bb55d7f7f7445abcc8db50e6a65d4315e79f75c7
change-id: 20231020-strncpy-drivers-power-supply-charger-manager-c-236767ef929c

Best regards,
--
Justin Stitt <justinstitt@google.com>


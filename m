Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042617A25B8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 20:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbjIOS3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 14:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236095AbjIOS3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:29:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DD12D49
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 11:28:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d815354ea7fso2799261276.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 11:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694802528; x=1695407328; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y1TNhbabomfqxi0sSxeEOnLpESqLvSHW6eZcfpfNAeo=;
        b=shsz4NxqypQhdtRZb+2ArAjNbNsbC9gJdHgjUlcjlN6hQ2Y5Gs7VC+jF9I4AI2ZtaO
         rU+24rkLSE7ZJCtKfNaIMfzJ+nPRThW2Tne8lLZrK0Tkj3A+gLVzkNyv0GoCKFSI0q86
         kl8c2XpNYCi6dR+LYezrVhxnCSEJb4882hnyfBUNKNL63neV3yzar/YX+b92IHhg1WOO
         ZoKrT759x7DqOQl90FhdqMywSRu9nOf3284JDr0bGFMhIHi+pj3Z0hfXg6uLeiemqFv/
         NAdoQgtJ/gDIFb/qJNnph4CUzV/zomN8AG2PKnlvN86GP0uTF/TTjjCceEV5+0UGsPIa
         9VQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694802528; x=1695407328;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y1TNhbabomfqxi0sSxeEOnLpESqLvSHW6eZcfpfNAeo=;
        b=VJOaxc0GOVGMmyVW+9pbbtdA4T1bv+PygR4haCbVPlFnu6Mpeb3bqjxvXG4Ki7skub
         ZtvYyK9LgyHfJbPiJ3EN4Lo85EPK9r+5I0a8lUR9zUiNPzTY4kGQlnDYBV3bK7cCHR0O
         587Yb+Xr28U9vXdjBaBpEt4ALZMWnwhB18R/LGSzLH7+ZEyrjg3EVjRDZOi+OLreS9wi
         5AaLj61zQ/J/Vr7VPyMEGKlVF0qBrkKfVv4K+WgfjgS+ru6j+jFOa10uVSXG+K8t1SyP
         njxq2dpKnM9hAkRIXKgPf54sZag+d2GZyIq4ywL5GRjpI45qd6OXyH7jWY7JIZkTQtC0
         KICg==
X-Gm-Message-State: AOJu0YwP2nmAxaNsSX//zX3UGaMDH/3EUamL/xcpcJDAYnThzUnSMw1o
        4PZk/xvPb19aUuVrhJflQ0DeSJWVVrmxQfeoEg==
X-Google-Smtp-Source: AGHT+IFXBdLYQW32vcCTfWMAvUyIlKvbL2zlS6Bcu0Nz89AKvbH33GJOMchNCk+p0KBjGmIFKVbMepWC7FREJ4WeAw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:4cf:b0:d7b:92d7:5629 with
 SMTP id v15-20020a05690204cf00b00d7b92d75629mr61024ybs.8.1694802528783; Fri,
 15 Sep 2023 11:28:48 -0700 (PDT)
Date:   Fri, 15 Sep 2023 18:28:41 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFiiBGUC/yWNQQrCMBAAv1L27EKaYGr8iojUdG330CTs1qqU/
 t2gl4G5zGygJEwK52YDoZWVc6rSHhqIU59GQh6qgzXWmdAeURdJsXxwEF5JFKfXnBOW+f7UP28 xC2HEk+2C9y540zuouSL04Pdvdbnu+xfaojGoegAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694802527; l=1589;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=ipgUK5swse4talncYcp6ZaLyjV9MF6ZXeEtQq4t0z+U=; b=yh6ji8oppxJbHWrSSNWzb+891+/79MW/r+6+gbkV96zGC/G3BpGuzOqrL/9EaMbaa54XhF4HE
 AIU7cylhy+6BOoljr90F/91Mh0SiWTLQa1nb8q+u8TQGrMeqSEQFENN
X-Mailer: b4 0.12.3
Message-ID: <20230915-strncpy-drivers-hwmon-pmbus-pmbus_core-c-v1-1-fca2cbca41ea@google.com>
Subject: [PATCH] hwmon: pmbus: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
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

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should prefer more robust and less ambiguous string interfaces.

A suitable replacement is `strscpy` [2] due to the fact that it guarantees
NUL-termination on the destination buffer without unnecessarily NUL-padding.

`label` is zero-allocated and as such the NUL-padding behavior of
strncpy is not required here.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 1363d9f89181..dcc8b12387cc 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1394,7 +1394,7 @@ static int pmbus_add_label(struct pmbus_data *data,
 	snprintf(label->name, sizeof(label->name), "%s%d_label", name, seq);
 	if (!index) {
 		if (phase == 0xff)
-			strncpy(label->label, lstring,
+			strscpy(label->label, lstring,
 				sizeof(label->label) - 1);
 		else
 			snprintf(label->label, sizeof(label->label), "%s.%d",

---
base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
change-id: 20230915-strncpy-drivers-hwmon-pmbus-pmbus_core-c-8279663960a3

Best regards,
--
Justin Stitt <justinstitt@google.com>


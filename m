Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317EF7A1172
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 01:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjINXKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 19:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjINXKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 19:10:40 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47382707
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 16:10:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d81486a0382so1693476276.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 16:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694733035; x=1695337835; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KF0ypLEqc8BBDWzXbz6oiYZjtdi3CP4D2nc6vcNdwQ8=;
        b=dcm6mUs6NrlRr3+Bv4MU/6hRlV8JryV0LkFeM1Rs87sn8Y2hKrFJH9CBA3ZYg6rEUD
         qotPg+8AlWD4BihnV0IeVn/O0sWC0oxVgqBV4ekk6Bzmzm2sDZcR2AgQK+xCjswEcEZy
         T75X+lKpFPb5PZQtmkx43qdHMBMcauFmJa8ae3znI1T8xk2IMvOEajy+bVL5DlT3ILhx
         htKAqPXAcQg/+bAdrySOK2/MRvzieRTxrAiieZIi6qXaOd3rQHX9qJdItganmcF8SDAS
         8iTPDSmgUGWVKOLNDMFTmhtwVzj4NT2mkVRriapokM5smLE69wGvGYgSg58bo+/ePLqh
         w+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694733035; x=1695337835;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KF0ypLEqc8BBDWzXbz6oiYZjtdi3CP4D2nc6vcNdwQ8=;
        b=WWBD6Olud/TUAyGinSg1f5Ht1PBXQEYcqf/9UMNxiHZ13jx/JQ2rgWjaKz5Ww9TOKi
         eLkV8JP6mMB8xWFOg/D52N5AK3ZUl4b2HIuJvPfAnHiX+s38rVEhiM6SjBYudjIPtqAg
         h2u1cM4egFJiDj8Y3dy5wegHapjgUVWy1h7axmKH0dZ1DubsFsiC3vZtQeChurscB+xK
         C7ozw+ZicHG2zmYAlol5aD7jhHVGsavqRbwq66jj6daT0ElHwo/IkB3b52GlvVvtPHXn
         L8O9r8D8yHeqG2XZGzZgxUhAgydbXjpJelJBU2J8hbEUTXQQ+6GZHr8Fy49AZHpyiNFx
         YicA==
X-Gm-Message-State: AOJu0YxnnlTOrhxAVS3x67oANIOmv12LfuRixYLsk4OjQNvMBVVuzDXQ
        /ChKH8b5BF9KB1qZdC41HHgLpktSKg/S9ixdvw==
X-Google-Smtp-Source: AGHT+IEILjzGGETs9OgY3sII6tzaC1e1gmqUd3mwSZtiyvhjJac1glb0Y6mJhrCOidnIMcdGRfBU+6AqAxMZUqgzow==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:684:b0:d81:8e4d:b681 with
 SMTP id i4-20020a056902068400b00d818e4db681mr80330ybt.12.1694733035150; Thu,
 14 Sep 2023 16:10:35 -0700 (PDT)
Date:   Thu, 14 Sep 2023 23:10:34 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOmSA2UC/x2NQQqDMBAAvyJ77kJiQ4v9SikSkm3dgxvZrVoR/
 27oceYws4ORMhk8mh2UFjYuUsFfGkhDlA8h58rQuvbqOh/Qvipp2jArL6SGwzoWwWiz9evIvZF YqToheUeuCzHc7hlqblJ68++/er6O4wQmV5npegAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694733034; l=1557;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=1iP5Kt48YlJbVGCF4UiawrlrXPZCOJ+oBhMz4zjhzn8=; b=STd1ZyVgYq02tF3XVQ/Irb/McEXI8g01pYBzaUJmsnLEJJxLiij7ySF3piV/6RfuxFPDTD0hi
 6RSnhuI3LY9A89UlMBC96MAOPsGwzwiEx7mkwcGty1+A9V8bdZgr5gx
X-Mailer: b4 0.12.3
Message-ID: <20230914-strncpy-drivers-hwmon-asus_wmi_sensors-c-v1-1-e1703cf91693@google.com>
Subject: [PATCH] hwmon: (asus_wmi_sensors) refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Ed Brindley <kernel@maidavale.org>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should prefer more robust and less ambiguous string interfaces.

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding. If, for any reason, NUL-padding is needed
let's opt for `strscpy_pad`.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/hwmon/asus_wmi_sensors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/asus_wmi_sensors.c b/drivers/hwmon/asus_wmi_sensors.c
index 6e8a908171f0..c2dd7ff882f2 100644
--- a/drivers/hwmon/asus_wmi_sensors.c
+++ b/drivers/hwmon/asus_wmi_sensors.c
@@ -300,7 +300,7 @@ static int asus_wmi_sensor_info(int index, struct asus_wmi_sensor_info *s)
 		goto out_free_obj;
 	}
 
-	strncpy(s->name, name_obj.string.pointer, sizeof(s->name) - 1);
+	strscpy(s->name, name_obj.string.pointer, sizeof(s->name));
 
 	data_type_obj = obj->package.elements[1];
 	if (data_type_obj.type != ACPI_TYPE_INTEGER) {

---
base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
change-id: 20230914-strncpy-drivers-hwmon-asus_wmi_sensors-c-e10e094a467d

Best regards,
--
Justin Stitt <justinstitt@google.com>


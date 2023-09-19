Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C787A592C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 07:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjISFIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 01:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjISFIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 01:08:05 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E4B130
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 22:07:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d814105dc2cso5889599276.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 22:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695100076; x=1695704876; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4oTsRSgwJtZLa+M83Y1yWR55/2t80oAcXHVnltbxXw8=;
        b=MdkDS/DpRm2IX1lscdC+KprOcZen/xiKsCehm0ncKUGp2zzoQMvA4q+YGARRBNTvdr
         TrQho4gVurgwzPK0e7vaK38IY5awbtrVMLcDXS+FsjLSXlI/KuAAdgJvIaryltijc3Ze
         nkf84sjlEaoVgE7R8KVn4u5dGy2sVhoiUWSxqG+er6BWyKJEq7bInHdINHDAfrH31Xpf
         sAYVEgiXID1ioBv5ZkqBoXURko7fzlfC9U36l8A5ij/Fe2Ipchvq0y2cmWlO3il8khf6
         oOHl8mc7TTT6NBfSYNbrRl+W+eAagXA15r+Ea3+ECzit0NWo0U0JilSuO/Y6QIIV3gen
         1sZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695100076; x=1695704876;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4oTsRSgwJtZLa+M83Y1yWR55/2t80oAcXHVnltbxXw8=;
        b=nVah4jPIVPZhakj9eA6Ihz1BUJQlveKv/hTmwRCfS7PKw+U2mpFGLsxIf/TtBGR5XT
         dUlBRZ6ujyrKMYAZKHaiu432stwMj3z+KHoGRlrVnz4NaqotOv4a9aFgr5BZR84PLkZe
         etEKzCziS5jsMSsoaUcR53D1WyunDg9YpgniQHJyqD5LsmmWCeNGZ4tEIJK2kONt1klY
         YVELJiwCRxix/f/ir17wUJIUmkqN5/+MmHSyYSDAdYb5P4aXYgr3NFdHFw97L0sxNIxh
         OskKUFUP2Q+U3uZvzkDTFLxX59i354TZmyqhWJbmgrdp3hpoMRCmm2UVUXnCmXfvwc5W
         n5lQ==
X-Gm-Message-State: AOJu0YwuVFXXhzzeuwfGKP/ko2IIIByePBKRi9eQg6JPuC7zBTViB/bF
        JVwyILBVQTG9YbRrYUw2CYn+T+/fC2vmS3aQzg==
X-Google-Smtp-Source: AGHT+IHgpdy40SXoJZs8x8Y4QEC2s+vjPTRr0VVLfIHsdj+ODF/YWJhdnuTQigcgAmLTqleeB0ARpcklz9o8GiGVgQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:254:0:b0:d63:8364:328 with SMTP id
 81-20020a250254000000b00d6383640328mr221186ybc.5.1695100076655; Mon, 18 Sep
 2023 22:07:56 -0700 (PDT)
Date:   Tue, 19 Sep 2023 05:07:55 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKosCWUC/53NQQ6DIBCF4as0rDsNoEbpqvdojLE4KEkFMhisM
 d691CN0+b/F+3YWkSxGdr/sjDDZaL3LIa8XpqfejQh2yM0klwVXooS4kNNhg4FsQoowrbN30Ot
 gu+BXpG7GBQk0aGXk0PCqeKFh+S4QGvs5qWebe7Jx8bSdchK/9Q8kCRCgeCVVXdbKYPMYvR/fe NN+Zu1xHF9hZvJM4QAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695100075; l=1462;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=D6HTLPFYfWZS31qXNBGXxqODI77MOGRmlaVNX/fxtHc=; b=D6DC0vgDrZzaJzQDLWiKywgRxB5iAFc/QksLGR+tSu6mt9uzXKVKMNW2nu+M6UmN7tlvBElSF
 oJhKhaQS5nlD0HudNvcFHlGqsrWQGMvC0+d6jLD36ypMnbyggbbga8S
X-Mailer: b4 0.12.3
Message-ID: <20230919-strncpy-drivers-hwmon-acpi_power_meter-c-v2-1-8348432d6442@google.com>
Subject: [PATCH v2] hwmon: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
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

A trailing zero is already handled by the kcalloc
|	*str = kcalloc(element->string.length + 1, sizeof(u8), GFP_KERNEL);
... which makes memcpy() a suitable replacement to strncpy.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- use memcpy over strscpy (thanks Kees)
- Link to v1: https://lore.kernel.org/r/20230914-strncpy-drivers-hwmon-acpi_power_meter-c-v1-1-905297479fe8@google.com
---
 drivers/hwmon/acpi_power_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index fa28d447f0df..82e99aec4a33 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -803,7 +803,7 @@ static int read_capabilities(struct acpi_power_meter_resource *resource)
 			goto error;
 		}
 
-		strncpy(*str, element->string.pointer, element->string.length);
+		memcpy(*str, element->string.pointer, element->string.length);
 		str++;
 	}
 

---
base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
change-id: 20230914-strncpy-drivers-hwmon-acpi_power_meter-c-c9f2d8053bef

Best regards,
--
Justin Stitt <justinstitt@google.com>


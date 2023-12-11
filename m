Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE39C80DA97
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344329AbjLKTKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjLKTJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:09:58 -0500
Received: from mail-oa1-x49.google.com (mail-oa1-x49.google.com [IPv6:2001:4860:4864:20::49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10796CF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:10:04 -0800 (PST)
Received: by mail-oa1-x49.google.com with SMTP id 586e51a60fabf-1fae4875e0eso7348207fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702321803; x=1702926603; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pLJuiH0afxkaD2YOLBf8rgHfrGxhKASBgMKSWQ9l3mE=;
        b=DXZXHnvWDv1GI9kRvrmRjIx3m4w0oTSRYgeKHGm4CwXW/tMsCg/+wi861aOf8Sgf7R
         EfwTiB/u9o3jZYKgDVsLxHNgoQlclQM8Q9oB2zjj5uP4WXafk+AAS5w+1+rZiHLy/VMd
         yGJ8WGJCdPYaYy8b+Q1fIKmxwoAXQO9go0xtIkcpYXffAdyTq+ClrG7If+nEbURcov3C
         YN2iqYt/ymSkBL3b4QVuHaqOGyIEq/g1vuaoytBAYcizwy1flPTYkStBjKadZ72tn58F
         igw70YImFR9E7k68vHr0d4oO9CRbDgPHldWj4Zqr9wj4cD4E9BAQGxFmfswK9wtX1Ng5
         EZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702321803; x=1702926603;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pLJuiH0afxkaD2YOLBf8rgHfrGxhKASBgMKSWQ9l3mE=;
        b=qgedqU96BLoTT3xtuDV+UfVoz3F/nP4a38LBJb6ju2hUDxWMdFVWe3fOsLU/Hcavsp
         KYF4ok+ziGikbHZdPCtf0HUaiUp+tX1Mlhb97Km5fy4utvE5i2YyunkmIJ8PCK+54vEo
         zrTSrEk4txGzmKyh12MhuXGXhRL7t186nl1vpgzIC2H3Ly0cyDQMAEQD0uLUXhLqPI6h
         Fg0ZwTbbT0SMbrCFwT8SDWMG9xOb/1XWCwq40bcQfMhc1+PVKC3djKJgYQu0rjWikofH
         /4iEIcDE7dw9BU7xAzRuHYgj4nP5Wk6WLaTu//ngOX+5vmtH+rrxWbArmJmVYHe1Oj3O
         zdcQ==
X-Gm-Message-State: AOJu0YynS/vEuRCuOYjqN7qZ9nzwj99rZEq17NSW1Qd3lkxJyhxNUA8f
        zScJbtr4CWupWclegxy6zGHFpX7mAjj3xfpBrA==
X-Google-Smtp-Source: AGHT+IHvKqZP7f3jQfiI7xCBWbc5qtLEWaeWmYvrD28lL4j/tV/o+OHKvd7szRecAtwyGcYAOPdL5mAJDugJ7cETuQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6870:e415:b0:1fb:1176:50ff with
 SMTP id n21-20020a056870e41500b001fb117650ffmr5427291oag.6.1702321803322;
 Mon, 11 Dec 2023 11:10:03 -0800 (PST)
Date:   Mon, 11 Dec 2023 19:10:00 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIded2UC/5WNvQrCMBRGX0UyG8kPVuvke4hDc+9tGrBJSUqwl
 L67aR3ETZcPzjecM7NE0VFil93MImWXXPAF9H7HoGu8Je6wMFNCaSmk4mmMHoaJY3SZYuKeRt6
 jC++xQxngBhFrQgGVFqyohkite26Z271w59IY4rRVs1zfPwNZcskbUxtRQQvYmKsNwT7oAKFna yGrj1WJ049WVaygznhUiBpb+rIuy/ICm7kPhi8BAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702321802; l=2882;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=eLgUSsGRn6KvttCFjRNfTegIE4/MfMaKpVwBfZ9Mjyw=; b=4k3Sy8wCNWvA4Zo9ZylXCECbUz9MlMkk4n1/lpfkHH9mPOzfccsgiWsA7pNu7eVmRvk5OA8R3
 ZGAN8m2trIxBVgmT/c0T+5IdaK9w5hrN5MwA5ExGe5c9OEfdps0SHAN
X-Mailer: b4 0.12.3
Message-ID: <20231211-strncpy-drivers-net-mdio-mdio-gpio-c-v3-1-76dea53a1a52@google.com>
Subject: [PATCH v3] net: mdio-gpio: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect new_bus->id to be NUL-terminated but not NUL-padded based on
its prior assignment through snprintf:
|       snprintf(new_bus->id, MII_BUS_ID_SIZE, "gpio-%x", bus_id);

Due to this, a suitable replacement is `strscpy` [2] due to the fact
that it guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding.

We can also use sizeof() instead of a length macro as this more closely
ties the maximum buffer size to the destination buffer. Do this for two
instances.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v3:
- swap another instance of MII_BUS_ID_SIZE to sizeof() (thanks Russell)
- rebase onto mainline bee0e7762ad2c602
- Link to v2: https://lore.kernel.org/r/20231207-strncpy-drivers-net-mdio-mdio-gpio-c-v2-1-c28d52dd3dfe@google.com

Changes in v2:
- change subject line as it was causing problems in patchwork with
  "superseded" label being improperly applied.
- update commit msg with rationale around sizeof() (thanks Kees)
- Link to v1 (lore): https://lore.kernel.org/r/20231012-strncpy-drivers-net-mdio-mdio-gpio-c-v1-1-ab9b06cfcdab@google.com
- Link to v1 (patchwork): https://patchwork.kernel.org/project/netdevbpf/patch/20231012-strncpy-drivers-net-mdio-mdio-gpio-c-v1-1-ab9b06cfcdab@google.com/
- Link to other patch with same subject message: https://patchwork.kernel.org/project/netdevbpf/patch/20231012-strncpy-drivers-net-phy-mdio_bus-c-v1-1-15242e6f9ec4@google.com/
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/mdio/mdio-gpio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mdio/mdio-gpio.c b/drivers/net/mdio/mdio-gpio.c
index 897b88c50bbb..778db310a28d 100644
--- a/drivers/net/mdio/mdio-gpio.c
+++ b/drivers/net/mdio/mdio-gpio.c
@@ -123,9 +123,9 @@ static struct mii_bus *mdio_gpio_bus_init(struct device *dev,
 	new_bus->parent = dev;
 
 	if (bus_id != -1)
-		snprintf(new_bus->id, MII_BUS_ID_SIZE, "gpio-%x", bus_id);
+		snprintf(new_bus->id, sizeof(new_bus->id), "gpio-%x", bus_id);
 	else
-		strncpy(new_bus->id, "gpio", MII_BUS_ID_SIZE);
+		strscpy(new_bus->id, "gpio", sizeof(new_bus->id));
 
 	if (pdata) {
 		new_bus->phy_mask = pdata->phy_mask;

---
base-commit: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
change-id: 20231012-strncpy-drivers-net-mdio-mdio-gpio-c-bddd9ed0c630

Best regards,
--
Justin Stitt <justinstitt@google.com>


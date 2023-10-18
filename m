Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639117CEA36
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjJRVuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjJRVuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:50:04 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E331112
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 14:50:02 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7d1816bccso111552937b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 14:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697665801; x=1698270601; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z8zZipBfwYNWzVL/d5y/qUL95UR9zvumjoOjtC0bzRU=;
        b=sl82I0r5PMtHtJ6HzraR/DHXHBM77LzsndZNdvsOaZrTDj2RWUzCXC9OpAXU+iwjpE
         jnPMHAU6cvTBsnuuEM45zMaC6XYV8h6gj46DIQstwtT/6FjJ4SqnZSWf4w9I0iH5lDYR
         Gc+QbeIfiQDNG7QxmfTY5CnVfgcyfdAvuBFDIH7DI0b9QccGe04yt/mgxlfTQ8k9vWw+
         hEORv86pxWu/B3LU/VaqoxoxtrHMm65zM2jgjCWH+ddmW48pm6NUipKNoOTRfIkZlW9B
         3CCTfW0eWnQHqgHUwddT9NAxuiiGmD9uvLeciy8vzROLj/6+2L8KEiUaZ7SqajjW9sOo
         bMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697665801; x=1698270601;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z8zZipBfwYNWzVL/d5y/qUL95UR9zvumjoOjtC0bzRU=;
        b=bshZtfpct/6019EcRWdeLnxO5qY8yaWdA1ds2YA/636lammrY0nAKMtO5zCRfIacK4
         fcNq8j8J4PV8Jw8ZlzxHpuESawvHDTF1UJ9bV/j5Jqdt4T+ZvDoBaNycLl8gBGGpnlyr
         qpBdkMFwQVoxay4XpzftMINSEUwZqu4Kb/DQYGiBwA0xD+8MvijfOGpmvyS5GMOrQYJN
         3xmcpXXoP6cyKMAPMoyFzK2DKm9f+GGtx+g3AcokfXcEPm8so8kAFboEwi7HISFnkkiy
         yddtKZVJSLtWaVBG8tzU2H5bKuDo/6EBKxWGintK56CZWcyLoqJm2yiE9QM/lPUlTAZR
         414g==
X-Gm-Message-State: AOJu0Ywf29ueE+ECrmiXG24gdotk+U++35yKGZ++2xC/8R7kz6e7Zr45
        1dR+0TrAXQy/TX7b+5vJ++1OKtZs6A3FfnXK2A==
X-Google-Smtp-Source: AGHT+IEN/FTSASrll23QyNRMxl3kr6I8Hj0ECv2EwBFAUZlWSl9jzbvTcPJAY+6SodfofM1HCyBdr6WOwoVCZaWyww==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:9a42:0:b0:d9a:da03:97e8 with SMTP
 id r2-20020a259a42000000b00d9ada0397e8mr15079ybo.2.1697665801580; Wed, 18 Oct
 2023 14:50:01 -0700 (PDT)
Date:   Wed, 18 Oct 2023 21:50:01 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAhTMGUC/x3NwQqDMAyA4VeRnBdou4vsVcYOXUy3gIuSFHWI7
 27x+F3+fwdnE3Z4dDsYL+IyaUO8dUDfrB9GGZohhXSPIfbo1ZTmPw4mC5ujcsVVjEd2xyq4jjQ Z4y+LIiEFSn1OpbxDgdacjYts1+/5Oo4Td1K6yn8AAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697665800; l=2656;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=+Kzx2MbD//7ayd+aOst6C3X1PEowOw6WZ0FJ1cJtGh0=; b=PHmejvnmSgVgn+JBcu0Adx76+ya44Z1bQUxBUSKkPHEXVZqm2ntP844KkvGQvnoeCjqDYj+QK
 VdfW2La2QM2BXds6tdk7luDoj/gtbofZTNzHKJ52cnnh7z7vH0EK0Xu
X-Mailer: b4 0.12.3
Message-ID: <20231018-strncpy-drivers-net-wireless-ti-wlcore-main-c-v1-1-1b1055f482a1@google.com>
Subject: [PATCH] wifi: wlcore: main: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect fw_version strings to be NUL-terminated based on other similar
assignments:

wireless/broadcom/brcm80211/brcmsmac/main.c
7867:           snprintf(wlc->wiphy->fw_version,
7868:                    sizeof(wlc->wiphy->fw_version), "%u.%u", rev, patch);

wireless/broadcom/b43legacy/main.c
1765:   snprintf(wiphy->fw_version, sizeof(wiphy->fw_version), "%u.%u",

wireless/broadcom/b43/main.c
2730:   snprintf(wiphy->fw_version, sizeof(wiphy->fw_version), "%u.%u",

wireless/intel/iwlwifi/dvm/main.c
1465:   snprintf(priv->hw->wiphy->fw_version,
1466:            sizeof(priv->hw->wiphy->fw_version),

wireless/intel/ipw2x00/ipw2100.c
5905:   snprintf(info->fw_version, sizeof(info->fw_version), "%s:%d:%s",

Based on this, NUL-padding is not required.

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/wireless/ti/wlcore/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index bf21611872a3..52a427bd54fa 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -1126,7 +1126,7 @@ int wl1271_plt_start(struct wl1271 *wl, const enum plt_mode plt_mode)
 
 		/* update hw/fw version info in wiphy struct */
 		wiphy->hw_version = wl->chip.id;
-		strncpy(wiphy->fw_version, wl->chip.fw_ver_str,
+		strscpy(wiphy->fw_version, wl->chip.fw_ver_str,
 			sizeof(wiphy->fw_version));
 
 		goto out;
@@ -2344,7 +2344,7 @@ static int wl12xx_init_fw(struct wl1271 *wl)
 
 	/* update hw/fw version info in wiphy struct */
 	wiphy->hw_version = wl->chip.id;
-	strncpy(wiphy->fw_version, wl->chip.fw_ver_str,
+	strscpy(wiphy->fw_version, wl->chip.fw_ver_str,
 		sizeof(wiphy->fw_version));
 
 	/*

---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20231018-strncpy-drivers-net-wireless-ti-wlcore-main-c-c0c28a2ffb0f

Best regards,
--
Justin Stitt <justinstitt@google.com>


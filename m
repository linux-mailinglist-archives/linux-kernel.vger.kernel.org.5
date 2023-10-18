Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43E07CE9DA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjJRVP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjJRVP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:15:26 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C75FE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 14:15:24 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7a6fd18abso112520037b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 14:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697663723; x=1698268523; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DWFdITK9FYnC6ndQyLKptFhv/4XAT9ljqHM/fNT7TZM=;
        b=OHA9bpChmrzhXQ0BWjrKQKkp/9+hMPyiDE8UJgC4rg8W7Lnu2OQadEKaLF9ebIptmv
         6WPZif1jBHClBCzQMsj0tYvPwZ3I+ZEeqAWtwjp8pA93esxzXYkhGYu5jMaRfI4AjOKr
         E7M3WLQiho9dRH8XeN5xS7t+sjMdKUvFLdaNsa6KasV629qTboz1II3Dpi+oYP8ech/t
         sPlJvjdwXJRteDxEbO3D7Vk5GX/beZFZE1ewC2oAfhweZKOGhp3iogi8LCLWR2qiuzZH
         Atics1pSevmExBk0TkkVxzU2IWWprGyBlxnAqyFuQhy3Q0gipUDHV+b3hvw+od3wrtkm
         d16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697663723; x=1698268523;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DWFdITK9FYnC6ndQyLKptFhv/4XAT9ljqHM/fNT7TZM=;
        b=MT3nf8lZtWnPS9AVxhYGjySgRpyxG6uugT2kwYR1BIKKSxcfJPS8zG4rPhTFTc92ab
         aAyAdIL3RpTHaD2mdHGX4FGBHqDqzcQfUzXRZcdgEHmbcmxYESj1eTqzYvP00MJRS0vT
         U8wCmWKRZnFgDklGXgV4juTT7yKi623dwLLeWamLd1swMoFpgqo/HxD21vHSBjcYZHSv
         cBX6OIh3FOW+D2Q+LBIT8c8F5AqKgt2CWNQhNzPCZCLInsKfhJ150CJKHggb7WBnGXbN
         H+uNqmcAC5IoowkYyD/LKeXJxc3vUHnxS1ZNExEeMGYreau3Q3d+77tXUwsHaArpUk8y
         bTlw==
X-Gm-Message-State: AOJu0Yw09wF7t3jmMSbA2nrjHXGqEC0+T6BVpIZpCeypHzA+NE7rl89J
        t3BX20Wm6F7HaSyDwhK2efIkLqhQpR3QDmlmEA==
X-Google-Smtp-Source: AGHT+IE98FBPpehxuSmAoDMMyrPO6eIxEf9m+v4GafxR/P68phKpdYLKbL9enPw6AIvI9BgsiyIo3/p7t7gXzQzvYg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:4215:0:b0:d9a:47ea:69a5 with SMTP
 id p21-20020a254215000000b00d9a47ea69a5mr13155yba.1.1697663723500; Wed, 18
 Oct 2023 14:15:23 -0700 (PDT)
Date:   Wed, 18 Oct 2023 21:15:23 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOpKMGUC/52NQQ6CMBBFr0K6dgxTghJX3sOwqO0Ik0BLpk2RE
 O5u9Qgu30/+e7uKJExR3apdCWWOHHwBfaqUHY0fCNgVVrrWDdZ4hZjE22UDJ5xJInhKsLLQRDF
 CYlgn1C3CbNiDhctTO9MhWWucKs5F6MXvX+/RFx45piDbL5/xu/5byggIjWltuXeamvY+hDBMd LZhVv1xHB9Bi0CG6wAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697663722; l=2913;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=yDbQL0fT5ECag/Hfa0melicYIqMQ//3xY2/rpNFfZOo=; b=iw2u/dbT5NFr1oMNr8mHNhtfVVlrHVDEyj+xyEAXaQhj7NdVCgY6R2c/BwjBfl2BSF93w/vCD
 qIz4P8kmKrDDoiAx7rQaljqwJ7AqZn07VHLp/I67Ngu6B4/Hxt+OECV
X-Mailer: b4 0.12.3
Message-ID: <20231018-strncpy-drivers-net-wireless-ti-wl1251-main-c-v2-1-67b63dfcb1b8@google.com>
Subject: [PATCH v2] wifi: wl1251: replace deprecated strncpy with strscpy
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

Based on other assignments of similar fw_version fields we can see that
NUL-termination is required but not NUL-padding:
ethernet/intel/ixgbe/ixgbe_ethtool.c
1111:   strscpy(drvinfo->fw_version, adapter->eeprom_id,
1112:           sizeof(drvinfo->fw_version));

ethernet/intel/igc/igc_ethtool.c
147:    scnprintf(adapter->fw_version,
148:              sizeof(adapter->fw_version),
153:    strscpy(drvinfo->fw_version, adapter->fw_version,
154:            sizeof(drvinfo->fw_version));

wireless/broadcom/brcm80211/brcmfmac/core.c
569:    strscpy(info->fw_version, drvr->fwver, sizeof(info->fw_version));

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

A suitable replacement is `strscpy` due to the fact that it guarantees
NUL-termination on the destination buffer without unnecessarily
NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- fix subject (thanks Jeff)
- Link to v1: https://lore.kernel.org/r/20231017-strncpy-drivers-net-wireless-ti-wl1251-main-c-v1-1-3a5c02382e35@google.com
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/wireless/ti/wl1251/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ti/wl1251/main.c b/drivers/net/wireless/ti/wl1251/main.c
index eded284af600..cd9a41f59f32 100644
--- a/drivers/net/wireless/ti/wl1251/main.c
+++ b/drivers/net/wireless/ti/wl1251/main.c
@@ -404,7 +404,7 @@ static int wl1251_op_start(struct ieee80211_hw *hw)
 
 	/* update hw/fw version info in wiphy struct */
 	wiphy->hw_version = wl->chip_id;
-	strncpy(wiphy->fw_version, wl->fw_ver, sizeof(wiphy->fw_version));
+	strscpy(wiphy->fw_version, wl->fw_ver, sizeof(wiphy->fw_version));
 
 out:
 	if (ret < 0)

---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20231017-strncpy-drivers-net-wireless-ti-wl1251-main-c-6b2da81eccad

Best regards,
--
Justin Stitt <justinstitt@google.com>


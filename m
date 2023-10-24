Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8934D7D59E2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 19:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344088AbjJXRmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 13:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344012AbjJXRmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 13:42:21 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B656E10CF
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 10:42:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da033914f7cso1351598276.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 10:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698169338; x=1698774138; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IiUyQYP0TuoT75NL7ZUXuVLk1dlI1JfFc9pMS1xuxEY=;
        b=t2S8tvDUUejCeZ24leQtjT9hpGKC3oyQqn2VVxA/2T9M++timZ+6N76fw7Mx9if+cw
         dhP18KcJiRHPNp1rn6pKvLSrv2l305m8UVej+yFIM7n73RUUTgfB4TXudIekTsUhDBVP
         h5yEdUS7ybCGUQHb4TFRMwmUcDB5/s0jGjK+76OMfBXIeg2lwScjbQkkGtHCCfqOJ9YM
         mWNcsE/PLgsxu59DVatz/ox8YiQsn36/nKAFcpclC0g7+f35iZW4KUO6zPVTKXDxGs6L
         llHmekKdTAoi+fWQrCRloWSepECx3zPJz9fb/k6GxjMY5NimB1yxY3EWORWKyd+vmfTJ
         8+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698169338; x=1698774138;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IiUyQYP0TuoT75NL7ZUXuVLk1dlI1JfFc9pMS1xuxEY=;
        b=MOLdl9GSQfWsJEM6fVcbJVWOlm6h/9EW9+SXhrMlkwT6P2QEaYYzH21KlnTqALU7Dm
         IKh7YgtwkwZmPUEYTdl1qvz1jVMztkVcvPXIw1SKZU/RDQOxys+3cywMKw34Xlh2Ms/u
         dLs11BrZjTXL2k0YOqs83qC8cSYGU6dCeS4SHc9Zn8pxD0uMFyGA/Qr14UiVeHYt3lZC
         rwT94fWq/oaGMCGmP0HpqoBebK5QQWZwsxXYI7hBsPglnCpjKWLkDx50ztH9e7f4m/yu
         dr310fQVYsP7zFEx6SRJnki96Nrx5Xxmhr+9ieQeOAJUGZ7QFbMRodKTgSY5h9EdNaMA
         143A==
X-Gm-Message-State: AOJu0YwH+hkThClsUZUEiyzgiFRzdRIx4bQ3/FBv+xc66Cmq57xVdF84
        JJbhblcgQ5hwg82qvy/NzugK6DaONlKmzA+lMw==
X-Google-Smtp-Source: AGHT+IGxBUJ6AOf1u6czuQpcFOXKwJ3JNLy/s7RwipVOoLtmeRdVForQN5tuNUrGj1C4sbWae1Qtv6lDQzZihH6Diw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1083:b0:d9a:c3b8:4274 with
 SMTP id v3-20020a056902108300b00d9ac3b84274mr332751ybu.7.1698169337984; Tue,
 24 Oct 2023 10:42:17 -0700 (PDT)
Date:   Tue, 24 Oct 2023 17:42:16 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPcBOGUC/52NTQqDMBCFryJZd0p+NIWueo/iIsRRQ9WUmZBWx
 Ls3eoTyeIvvLd63CUYKyOJebYIwBw5xKaAvlfCjWwaE0BUWWmqjpDLAiRb/XqGjkJEYFkzwCYQ
 TMoNL41ElXzA7DyU345rGWovWifL5JuzD9/Q928Jj4BRpPfVZHeu/pqxAga6xlloq1zvzGGIcJ rz6OIt23/cfmGU7pusAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698169336; l=2664;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=v7X6AgaYGtLwlN3x1yqa0dzr/NEuarCPk3n9BpO0sN0=; b=t/Ub/yzQiuI1fBkkvEt7r+RmgkE6N5jCyDcKYYtcuRX0JU7I4tPXvRrsG8ukYhxbLdofgXYK5
 fRSaupgp7LWCw9dftF9BYantl62Zrfybz6X6RRUqMFlL8hHOmRxfTbl
X-Mailer: b4 0.12.3
Message-ID: <20231024-strncpy-drivers-net-wireless-ath-ath10k-mac-c-v2-1-4c1f4cd4b4df@google.com>
Subject: [PATCH v2] wifi: ath10k: replace deprecated strncpy with memcpy
From:   Justin Stitt <justinstitt@google.com>
To:     Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
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

strncpy() is deprecated [1] and we should prefer less ambiguous
interfaces.

In this case, arvif->u.ap.ssid has its length maintained by
arvif->u.ap.ssid_len which indicates it may not need to be
NUL-terminated. Make this explicit with __nonstring and use a plain old
memcpy.

This is also consistent with future copies into arvif->u.ap.ssid:

	if (changed & BSS_CHANGED_SSID &&
	    vif->type == NL80211_IFTYPE_AP) {
		arvif->u.ap.ssid_len = vif->cfg.ssid_len;
		if (vif->cfg.ssid_len)
			memcpy(arvif->u.ap.ssid, vif->cfg.ssid,
			       vif->cfg.ssid_len);
		arvif->u.ap.hidden_ssid = info->hidden_ssid;
	}

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- update subject to include wifi
- prefer memcpy() over strtomem() (thanks Kalle, Jeff)
- rebase onto 6.6-rc7 @d88520ad73b79e71
- Link to v1: https://lore.kernel.org/r/20231013-strncpy-drivers-net-wireless-ath-ath10k-mac-c-v1-1-24e40201afa3@google.com
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/wireless/ath/ath10k/core.h | 2 +-
 drivers/net/wireless/ath/ath10k/mac.c  | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index 4b5239de4018..ba9795a8378a 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -607,7 +607,7 @@ struct ath10k_vif {
 			u8 tim_bitmap[64];
 			u8 tim_len;
 			u32 ssid_len;
-			u8 ssid[IEEE80211_MAX_SSID_LEN];
+			u8 ssid[IEEE80211_MAX_SSID_LEN] __nonstring;
 			bool hidden_ssid;
 			/* P2P_IE with NoA attribute for P2P_GO case */
 			u32 noa_len;
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 03e7bc5b6c0b..f3f6deb354c6 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -6125,9 +6125,8 @@ static void ath10k_bss_info_changed(struct ieee80211_hw *hw,
 
 		if (ieee80211_vif_is_mesh(vif)) {
 			/* mesh doesn't use SSID but firmware needs it */
-			strncpy(arvif->u.ap.ssid, "mesh",
-				sizeof(arvif->u.ap.ssid));
 			arvif->u.ap.ssid_len = 4;
+			memcpy(arvif->u.ap.ssid, "mesh", arvif->u.ap.ssid_len);
 		}
 	}
 

---
base-commit: d88520ad73b79e71e3ddf08de335b8520ae41c5c
change-id: 20231013-strncpy-drivers-net-wireless-ath-ath10k-mac-c-c73a55666e6a

Best regards,
--
Justin Stitt <justinstitt@google.com>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5AB7C8E60
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 22:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjJMUdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 16:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjJMUdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 16:33:50 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6856D83
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 13:33:49 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7ac9c1522so39508927b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 13:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697229228; x=1697834028; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eG6A8LXGdf5DishXidGUjCut3MBs3ddn444r7C+ElXE=;
        b=2GLPtszDPum7mvEFFd7ZG16lA3MmeTdMHTlFft9GmpFMwSsT9ZZKIfhGdlCfmHi2FX
         ZjuZMfsxXLbPvhhi9NdsObNaE1pZl3cT2P3AACBXiPkjpHetoMx+yFIlOBfPq0rHmE6m
         Q0bEOF9BoBUd4FAmDDRMlCIMmHn93EOhLLtbGVCIlJbTXnOpPFNOX+wWDSXZD2xMsZbt
         gsa7AgLr/5atERjPTKUu+h1H4OB6LMzbK19DxVYEST6XziN3W2B36hLiSY/N83IIXsYp
         eS6l0gdaGQtgaooXyrDGtquM0gA2prIzokC3X/Xu7upj5Q96JW1+ZiHNPIs8Hol87akv
         4exw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697229228; x=1697834028;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eG6A8LXGdf5DishXidGUjCut3MBs3ddn444r7C+ElXE=;
        b=Ibto03Sl/BX45rviClaaxcynW/dgiApZxv62kf+hS849UyWRaHcQh/T/qZnvZis65+
         DNXh1JpMWbqd2yJNlMDRHzpihsSeBO3m34Sh25WYTn/d0gn09VLGEPWgWVzpkZoW95rr
         WlSmi6V+ow3ztRbg55njSavORrcLPlmy2c5p+HDKFLgFKDcGLQ06X7gBDEO8/1Whz0+9
         Vx67uUhf/0vSpBlgyLNG/qqD7WIwPQIU6124fyMmfInuJJG+1NO4WFABnT7GxQAWpiPx
         WSJtQYfeO1JMIl9ZTyV/HN4CJ2ktfvXMO0o4ybL8BPDYAJDuZ5Cl0kzLqlRjFMTz2OTN
         fRxg==
X-Gm-Message-State: AOJu0Yw3zDCjRpqs28tCpMAoLs/a4+f6kcpAtyRByxXo0QTEeDKJu16Q
        D001kYWlfH4dq7/Cnz8M8mPha7uVU8/mGtiMAw==
X-Google-Smtp-Source: AGHT+IE1DLGODvnUeOyBO95DQWbeWAG3EQH/FQzqvAHpAtiVubf5eiiRi9rEMF1X30r6/tRVippKDNEtWmsLOAHylw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:5056:0:b0:d9a:3dac:6c1a with SMTP
 id e83-20020a255056000000b00d9a3dac6c1amr284177ybb.11.1697229228652; Fri, 13
 Oct 2023 13:33:48 -0700 (PDT)
Date:   Fri, 13 Oct 2023 20:33:48 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKupKWUC/x2NQQrCMBBFr1Jm7UDS0AheRVyE9GsHNZaZ0Cqld
 zfK4y/e5r+NDCowOnUbKRYxeZUm/tBRnlK5gWVsTr3rg3c+sFUtef7wqLJAjQsqr6J4wIxTnX7 z7s7PlLlxDGkYYoyIidrnrLjK+987X/b9C0V4zo5/AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697229227; l=2804;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=bIMAUwS6tKmB9c3Rk81R/5V5UUFo1cBwPXaV7yFWMoA=; b=CMqSCYBAwjGQ8NqCJLEe3oWu/b2U+C4UYTWSlc/PUeeYHnfx5MQOccK4vtSKlHLLgk37gUzWa
 wuqPSkQzuGcBq8W/yBQzKG3d3WsDrMe0sr4hx8u6ZKodNLkDgwsgk/2
X-Mailer: b4 0.12.3
Message-ID: <20231013-strncpy-drivers-net-wireless-ath-ath10k-mac-c-v1-1-24e40201afa3@google.com>
Subject: [PATCH] ath10k: replace deprecated strncpy with strtomem_pad
From:   Justin Stitt <justinstitt@google.com>
To:     Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated [1] and we should prefer less ambiguous
interfaces.

In this case, arvif->u.ap.ssid has its length maintained by
arvif->u.ap.ssid_len which indicates it may not need to be
NUL-terminated, although by virtue of using strtomem_pad (with NUL-byte
pad character) and having a destination size larger than the source,
ssid will, incidentally, be NUL-terminated here.

As strtomem_pad() docs say:
 * @dest: Pointer of destination character array (marked as __nonstring)
 * @src: Pointer to NUL-terminated string
 * @pad: Padding character to fill any remaining bytes of @dest after copy
 *
 * This is a replacement for strncpy() uses where the destination is not
 * a NUL-terminated string, but with bounds checking on the source size, and
 * an explicit padding character. If padding is not required, use strtomem().

Let's also mark ath10k_vif.u.ap.ssid as __nonstring.

It is unclear to me whether padding is strictly necessary. Perhaps we
should opt for just strtomem() -- padding certainly doesn't hurt,
though.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
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
index 03e7bc5b6c0b..7daa007bd8b3 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -6125,8 +6125,7 @@ static void ath10k_bss_info_changed(struct ieee80211_hw *hw,
 
 		if (ieee80211_vif_is_mesh(vif)) {
 			/* mesh doesn't use SSID but firmware needs it */
-			strncpy(arvif->u.ap.ssid, "mesh",
-				sizeof(arvif->u.ap.ssid));
+			strtomem_pad(arvif->u.ap.ssid, "mesh", '\0');
 			arvif->u.ap.ssid_len = 4;
 		}
 	}

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231013-strncpy-drivers-net-wireless-ath-ath10k-mac-c-c73a55666e6a

Best regards,
--
Justin Stitt <justinstitt@google.com>


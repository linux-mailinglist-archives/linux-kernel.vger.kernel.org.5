Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41B379E041
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 08:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238338AbjIMGy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 02:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjIMGy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 02:54:56 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DA8173E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 23:54:52 -0700 (PDT)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C8C603F66D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 06:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1694588088;
        bh=AuUP4uMpEXV7NNGmRh7ocQP9g6lCntCtTGB6qti7vSI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=dbVnMbrWmQxKxpmeBZn21P37wx8Jwy7Q9l+qoco8L82/3oDWEdQgRo5NAdwY6ilPD
         GoAxWx7bJ+wFO5q1Jw+ZbdyEmGDRODVJTJIuqO9/8V2g78kLtuw9E+y1JRmps8a5rS
         vBRbRuBZgjo0cIpEp4UyFDx/Bmd+baQAnZNvjiZ+9Ha9jkg0POvuGwyY3oNtUIMCSI
         qJBZRj3A2Gdqbyhjs5Qn/C1Rkl4xa2qutFWHIHKWyeoMjR0BfLJXcJzKQNhjKu7isO
         8CB998WmKFCYotnosfYnXCmMd66M7UK3V83FOpCiGb9artwIoZzM13zDQRyQb+yyj8
         WmfxOc9J5PI7A==
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-401c19fc097so50559395e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 23:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694588088; x=1695192888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AuUP4uMpEXV7NNGmRh7ocQP9g6lCntCtTGB6qti7vSI=;
        b=ZMDOyjJTwSqfm7kSKKLSX2QVdRL59d1fMKKR7GZbAbqI4eG/JhPgD2WCxxVC+gZpj6
         +8JFs4EkB51UwCN4339akXrfFOcAJBob+iWFkayyEH3n/C7uBtvSqJhfsifnlg21LUAn
         DerMgmx3tXtj1pjq9b04kpH3Vv1I2QZ0TRdq8zZqcwLC9r0BZ5lqnr8XrwxY67SUh0X0
         XLmdO/5GWTpLQkH6qXuxehfU6/wSMSP3fRwAyR5Nbq3aZBGx7TKSTwZcCgPOPeCXQx2G
         1q3JGN3kiwB0Z9+25m8cR0ONYPnkhCXfCLEWsh7sjpsg8QwJt+H8F2aVdFtc0S/phhu6
         89bA==
X-Gm-Message-State: AOJu0YyJIUk0SQPOX1wv+gSQec4/2oygkUIleb7QDNChE5WF4iYezVoG
        D3l8aF1wuc7YOdC+CEvhh9lbUvU8nXUhzZmeWC2ZQf8lzkG3e2j+zZzCkQkZUn6o9WCZNJl3bl0
        7BHgSZ2tO04XU3FPEIdV+zKe5t9cGT/E1n0mquA93ow==
X-Received: by 2002:a7b:c44b:0:b0:3f7:f2d0:b904 with SMTP id l11-20020a7bc44b000000b003f7f2d0b904mr1142857wmi.8.1694588088526;
        Tue, 12 Sep 2023 23:54:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELX8SVPWke/bYJiSBu4DzxplQdTDhwPyJaq++ur+9HfRMtx7dEx/+eEpgz3KK0VkuN7saPKA==
X-Received: by 2002:a7b:c44b:0:b0:3f7:f2d0:b904 with SMTP id l11-20020a7bc44b000000b003f7f2d0b904mr1142836wmi.8.1694588088217;
        Tue, 12 Sep 2023 23:54:48 -0700 (PDT)
Received: from localhost ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id 22-20020a05600c231600b003fef6881350sm1097497wmo.25.2023.09.12.23.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 23:54:47 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     aspriel@gmail.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Cc:     linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        marcan@marcan.st, keescook@chromium.org, gustavoars@kernel.org,
        hdegoede@redhat.com, juerg.haefliger@canonical.com,
        ryohei.kondo@cypress.com
Subject: [PATCH] wifi: brcmfmac: Replace 1-element arrays with flexible arrays
Date:   Wed, 13 Sep 2023 08:54:21 +0200
Message-Id: <20230913065421.12615-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 2d47c6956ab3 ("ubsan: Tighten UBSAN_BOUNDS on GCC"),
UBSAN_BOUNDS no longer pretends 1-element arrays are unbounded. Walking
'element' and 'channel_list' will trigger warnings, so make them proper
flexible arrays.

False positive warnings were:

  UBSAN: array-index-out-of-bounds in drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:6984:20
  index 1 is out of range for type '__le32 [1]'

  UBSAN: array-index-out-of-bounds in drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1126:27
  index 1 is out of range for type '__le16 [1]'

for these lines of code:

  6884  ch.chspec = (u16)le32_to_cpu(list->element[i]);

  1126  params_le->channel_list[i] = cpu_to_le16(chanspec);

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 .../wireless/broadcom/brcm80211/brcmfmac/fwil_types.h    | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
index bece26741d3a..ed723a5b5d54 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
@@ -442,7 +442,12 @@ struct brcmf_scan_params_v2_le {
 				 * fixed parameter portion is assumed, otherwise
 				 * ssid in the fixed portion is ignored
 				 */
-	__le16 channel_list[1];	/* list of chanspecs */
+	union {
+		__le16 padding;	/* Reserve space for at least 1 entry for abort
+				 * which uses an on stack brcmf_scan_params_v2_le
+				 */
+		DECLARE_FLEX_ARRAY(__le16, channel_list);	/* chanspecs */
+	};
 };
 
 struct brcmf_scan_results {
@@ -702,7 +707,7 @@ struct brcmf_sta_info_le {
 
 struct brcmf_chanspec_list {
 	__le32	count;		/* # of entries */
-	__le32	element[1];	/* variable length uint32 list */
+	DECLARE_FLEX_ARRAY(__le32, element);	/* variable length uint32 list */
 };
 
 /*
-- 
2.39.2


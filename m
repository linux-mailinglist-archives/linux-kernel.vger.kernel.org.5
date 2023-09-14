Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC42779FCB4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbjINHDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjINHD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:03:29 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EE6BD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 00:03:25 -0700 (PDT)
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 08E273F672
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 07:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1694675002;
        bh=goSxu7HgsxTeodjXmJUH/TuD0k0hgtAzYq7xYOspA+4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=WDk8FWMNg5jCyhP66uwB/GzZoWK53265q8Nh/hjEvdwTi4QTZhb/JgAi75PLin8wm
         vzJFFV0/JfHF7m5U4DM61117z60pWT7oCKUktAFXkBdZUTAGStCOyHPDTu8uk1FQN3
         roMJ6Aaf7TWs5BSG0zWmMRWFYhsmVNgh3EnaMefNq4OBB4R9h7MzBi9hougcLdPhI1
         QcGTzbpSXSk92+fmLDo3ddWaDDvo1eYJ2p9KDq0Fxnadcj1dVMY0FODKE4iidExKwz
         wFZWdm/plh+NKKbf2BSYbEGr+lqXdOgnlN9uiX8zB725I0yof9xFKOcK7OgWWiXOUv
         oV6on9m27CVdg==
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2bd132e84b2so7954461fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 00:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694675001; x=1695279801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goSxu7HgsxTeodjXmJUH/TuD0k0hgtAzYq7xYOspA+4=;
        b=Hn7OApw0lQlazWhyPgaMj1ffGbUKMshOFtGnwGFX8BvgrGejjg74fGMJINwPk8UlZq
         vnEY1+cJWPic6xaUyOO5XrSMrCk+ONDYyEzQ9L/8w+xObinv2FJNKMGMu+vif5o8cixi
         2tRcRHRWFaM5u/214sOoCd/ddxju57XLbPcPgy1WXIgMa8i6dMBGyFRYkjGSBB3QxirW
         SGbd7At49WrlvL+iOlpJovlOrR3YKOBaSKJqWNMmoMiClnkC5qaL16ISdfFCGMZuNaeb
         HPpQw1Q/7PiD+OGqj28cYYxSm4IpOL2QbEyQ5glEUjQINHJhRh7rdZCUmqX87WhM/OAw
         VuwQ==
X-Gm-Message-State: AOJu0YwjyH2Jb0lDP7KgeSQ8/SJJAs8ZTko2QLgdOTE7/2LPrHC4zcL3
        hkquaOQKh6yvswI3B4QPYFB6JhgR0pTyfqyw0WFriUBTLDmnGdnNF9u7OpaFlBbGnw0oRql3fB9
        U5jmeQSHQ6+ZIAPvqmyKdX7VTUM3Dnqv9UsqKXezSWg==
X-Received: by 2002:a2e:9ed9:0:b0:2bc:e32f:6fb0 with SMTP id h25-20020a2e9ed9000000b002bce32f6fb0mr4263143ljk.9.1694675000782;
        Thu, 14 Sep 2023 00:03:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2lvudBipBhYKFL0V/AUGrG/NPYxifvLzmEnbyiurqOzZt4iA6jNQCUaoQ+l2QV7FAleBBwA==
X-Received: by 2002:a2e:9ed9:0:b0:2bc:e32f:6fb0 with SMTP id h25-20020a2e9ed9000000b002bce32f6fb0mr4263113ljk.9.1694675000394;
        Thu, 14 Sep 2023 00:03:20 -0700 (PDT)
Received: from localhost ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id y14-20020a7bcd8e000000b004030e8ff964sm3981698wmj.34.2023.09.14.00.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 00:03:19 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     juerg.haefliger@canonical.com
Cc:     SHA-cyfmac-dev-list@infineon.com, aspriel@gmail.com,
        brcm80211-dev-list.pdl@broadcom.com, franky.lin@broadcom.com,
        gustavoars@kernel.org, hante.meuleman@broadcom.com,
        hdegoede@redhat.com, keescook@chromium.org, kvalo@kernel.org,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, marcan@marcan.st,
        ryohei.kondo@cypress.com, stable@vger.kernel.org
Subject: [PATCH v2] wifi: brcmfmac: Replace 1-element arrays with flexible arrays
Date:   Thu, 14 Sep 2023 09:02:27 +0200
Message-Id: <20230914070227.12028-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913065421.12615-1-juerg.haefliger@canonical.com>
References: <20230913065421.12615-1-juerg.haefliger@canonical.com>
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

Cc: stable@vger.kernel.org # 6.5+
Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>

---
v2:
  - Use element[] instead of DFA() in brcmf_chanspec_list.
  - Add Cc: stable tag
---
 .../wireless/broadcom/brcm80211/brcmfmac/fwil_types.h    | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
index bece26741d3a..611d1a6aabb9 100644
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
+	__le32  element[];	/* variable length uint32 list */
 };
 
 /*
-- 
2.39.2


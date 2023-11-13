Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4347E9644
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 05:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbjKMEhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 23:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjKMEhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 23:37:13 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E131718
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 20:37:10 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc0d0a0355so28030105ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 20:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1699850229; x=1700455029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7VAuuJUScsrG8D+oIxoYLreMolx9A0hdp1gM6zx9CU=;
        b=S1oVAvrBv+aVgFpWlYUu5JXisa8Dwhe5i2oR7SJqAQ6kDD20csWc0a1W4c8403/T+t
         GlgXa9R3lQiNHHnfrFPp4yDQee7hJnCDdfZrQ9Ip4qvYREs/yUtCBVDg62wCTX+jtxlc
         DfIF5vhulmbZMpHWfvlhHX2U6SSwnBY0UbOlcZ3o/uYjbM3U4ZwVTHxJo7FMVwadhMP7
         Tt/nyCQOzlxi45UzPx59hcrdOnOICpzmxvDmvt3lli93WSykg2v1ms4VVtriQqnNNFym
         I1m977JAUWJ2ca/VUJ15s7pst9T0Itkg2EvhWMWMrthhAH/fPRMkB4kKt/brIExwK4I/
         +LwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699850229; x=1700455029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7VAuuJUScsrG8D+oIxoYLreMolx9A0hdp1gM6zx9CU=;
        b=kY4jm7uFH5xFEcBF7tcHS8XuDzqkdveGmU5lmUATBcK2xQSkqTzg7ARYWqKZthXUFq
         Lv+IlPpHxZjA85iQCV1iy3MsihFa+kdHMa/byEspIXoatHhLAyXXpg/5vD/KVcXdivaH
         /VJEAqPaFwVr/ZWtu8Uhl52vmYS9GjtlNB4+r4BOd2aKOfCLPY8dG4vQ9bsd57e54Jix
         M9O6U2q49e2CKBMJQsT/2m5Xa9jqEVEf0zK34Fg+sVFbPRJXrucCCmG/tPk9EzJaEBzk
         xNIUS2uKGSbZ2cxJ25PO7BPlFAVBWK/lLVksn3zBlv8c3O1oChet/ZV3omlD2/FXN7gu
         jEQw==
X-Gm-Message-State: AOJu0YzoQ2MRB2GJ/72UbWR3Y6s7cQeTqwRDy83esO5CX78fNKKOn+eE
        WF0VpZPmuFtSXjYU/qJND5etpg==
X-Google-Smtp-Source: AGHT+IF9oBdLDvu7zgMRxBo24XkxPazV6MNbl+h0AEmKyXV3/JPezbKKr8P67KXv4niFvrKB0073hQ==
X-Received: by 2002:a17:902:d50a:b0:1ca:4092:7200 with SMTP id b10-20020a170902d50a00b001ca40927200mr3546686plg.54.1699850229373;
        Sun, 12 Nov 2023 20:37:09 -0800 (PST)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id l18-20020a170902eb1200b001cc3b988fd6sm3245181plb.265.2023.11.12.20.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 20:37:08 -0800 (PST)
From:   Jian-Hong Pan <jhp@endlessos.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessos.org,
        Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH v2] rtlwifi: rtl8723be: Disable ASPM if RTL8723BE connects to Intel PCI bridge
Date:   Mon, 13 Nov 2023 12:34:55 +0800
Message-ID: <20231113043454.10053-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <05390e0b-27fd-4190-971e-e70a498c8221@lwfinger.net>
References: <05390e0b-27fd-4190-971e-e70a498c8221@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable rtl8723be's ASPM if the Realtek RTL8723BE PCIe Wireless adapter
connects to some Intel PCI bridges, such as Skylake and Kabylake.
Otherwise, the PCI AER flood hangs system:

pcieport 0000:00:1c.5: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
pcieport 0000:00:1c.5:   device [8086:9d15] error status/mask=00000001/00002000
pcieport 0000:00:1c.5:    [ 0] RxErr                  (First)
pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
pcieport 0000:00:1c.5: AER: can't find device of ID00e5
pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
pcieport 0000:00:1c.5: AER: can't find device of ID00e5
pcieport 0000:00:1c.5: AER: Multiple Corrected error received: 0000:00:1c.5
pcieport 0000:00:1c.5: AER: can't find device of ID00e5

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=218127
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
v2: Add the switch case's default condition with comment:
    "The ASPM has already been enabled by initializing
    rtl8723be_mod_params' aspm_support as 1."

 .../wireless/realtek/rtlwifi/rtl8723be/sw.c   | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
index 43b611d5288d..b20c0b9d8393 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
@@ -25,10 +25,34 @@ static void rtl8723be_init_aspm_vars(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
+	struct pci_dev *bridge_pdev;
 
 	/*close ASPM for AMD defaultly */
 	rtlpci->const_amdpci_aspm = 0;
 
+	/* Disable ASPM if RTL8723BE connects to some Intel PCI bridges, such as
+	 * Skylake and Kabylake. Otherwise, the PCI AER flood hangs system.
+	 */
+	bridge_pdev = rtlpci->pdev->bus->self;
+	if (bridge_pdev->vendor == PCI_VENDOR_ID_INTEL) {
+		switch(bridge_pdev->device) {
+		case 0x9d15:
+		/* PCI bridges on Skylake */
+		case 0xa110 ... 0xa11f:
+		case 0xa167 ... 0xa16a:
+		/* PCI bridges on Kabylake */
+		case 0xa290 ... 0xa29f:
+		case 0xa2e7 ... 0xa2ee:
+			rtlpriv->cfg->mod_params->aspm_support = 0;
+			break;
+		default:
+			/* The ASPM has already been enabled by initializing
+			 * rtl8723be_mod_params' aspm_support as 1.
+			 */
+			break;
+		}
+	}
+
 	/* ASPM PS mode.
 	 * 0 - Disable ASPM,
 	 * 1 - Enable ASPM without Clock Req,
-- 
2.42.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57890757275
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 05:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjGRDnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 23:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjGRDno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 23:43:44 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B757410D1;
        Mon, 17 Jul 2023 20:43:42 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b8a8154f9cso32741445ad.1;
        Mon, 17 Jul 2023 20:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689651822; x=1692243822;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZdp+09RIWAK2Z+OGrivU9Ui9C1GynRgrEwV5eGtimc=;
        b=HwyHVWhJSAqEDdZPWTTNDnK1NW00QB6Mf6OmMADWZ+XUuvXB6xVquntN5XQw7lKWyR
         1+hYqdxj4zkSr26JeIQJg2/U31HBibDDNH9lFvhcVG1yyev74oV+PwS9hetkVHgHNaeF
         1Xxp6bNRBLgIKuboL7pJ/WHt7j2bBjVhqG+Z/PoLznbwAY2+ph414dWQ2cH7DzLvd9fX
         kKyWfs+uhjN7XSoLzKXC8vf6l10eZeB9q0juf44uGyaG0HU5y/1BI1yAFPiYPAxdQahk
         IWKog1bJhpWuy8Wb5kRHpYnHW15noFtrlIztqU08HXU3+ylHFO8ZU7zxAdLM/sz69Zvx
         EUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689651822; x=1692243822;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZdp+09RIWAK2Z+OGrivU9Ui9C1GynRgrEwV5eGtimc=;
        b=bgLiaeGytL+c567mDK9QUezMkQut1CRQFe7siWDCs7gMW2+no9ra3eEidU48AneJQL
         rBfCrp54ub+ghY8ao/5McX3+y7rSRaTad/BwA+ND26x/l7TxCP+2oVwc6EhJRQ0v8NvG
         8HPMCJBPeuIYtiRacnI+Gat/8vyOBE+rXdeuw8xZ/K9McZBLrJsJTsai45r0t8AlWScA
         h62yxXLt9Y0SYTxsfGZCVeRzwoPDvEPX6PwtfA7n3lY1QZDVQhragTwenFK6SJriPjcK
         lsjSSefplPSlj4CrdkBp7L+YEgDLyy3rBC27XkEBkSAO3EG4AHZawkivSaFQslWgwLmn
         FPRQ==
X-Gm-Message-State: ABy/qLYw22fhWOs/CkvhmtTHMXnHCfW11lkpSUKgLdwl/VKiC7AOsSJl
        WcDkAPggEIPjVtewllE523w=
X-Google-Smtp-Source: APBJJlHHeaJbqHg0s9NrwU8yx/cjKW+AFtQBWDJd984QimNU2yEcNSlNONq8l9WXpnICJorEdZcRsA==
X-Received: by 2002:a17:902:f548:b0:1b7:de50:7d9c with SMTP id h8-20020a170902f54800b001b7de507d9cmr15245504plf.15.1689651821905;
        Mon, 17 Jul 2023 20:43:41 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id f16-20020a170902ce9000b001b85a56597bsm614741plg.185.2023.07.17.20.43.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jul 2023 20:43:41 -0700 (PDT)
From:   "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-bluetooth@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>
Subject: [PATCH v2] Bluetooth: hci_event: Ignore NULL link key
Date:   Tue, 18 Jul 2023 11:43:37 +0800
Message-Id: <20230718034337.23502-1-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change is used to relieve CVE-2020-26555. The description of the
CVE:

Bluetooth legacy BR/EDR PIN code pairing in Bluetooth Core Specification
1.0B through 5.2 may permit an unauthenticated nearby device to spoof
the BD_ADDR of the peer device to complete pairing without knowledge
of the PIN. [1]

The detail of this attack is in IEEE paper:
BlueMirror: Reflections on Bluetooth Pairing and Provisioning Protocols
[2]

It's a reflection attack. Base on the paper, attacker can induce the
attacked target to generate null link key (zero key) without PIN code.

We can ignore null link key in the handler of "Link Key Notification
event" to relieve the attack. A similar implementation also shows in
btstack project. [3]

v2:
- Used Link: tag instead of Closes:
- Used bt_dev_dbg instead of BT_DBG
- Added Fixes: tag

Fixes: 55ed8ca10f35 ("Bluetooth: Implement link key handling for the management interface")
Link: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-26555 [1]
Link: https://ieeexplore.ieee.org/abstract/document/9474325/authors#authors [2]
Link: https://github.com/bluekitchen/btstack/blob/master/src/hci.c#L3722 [3]
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 net/bluetooth/hci_event.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 95816a938cea..ff0c331f53d6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4684,6 +4684,12 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, void *data,
 	bool persistent;
 	u8 pin_len = 0;
 
+	/* Ignore NULL link key against CVE-2020-26555 */
+	if (!memcmp(ev->link_key, ZERO_KEY, HCI_LINK_KEY_SIZE)) {
+		bt_dev_dbg(hdev, "Ignore NULL link key (ZERO KEY) for %pMR", &ev->bdaddr);
+		return;
+	}
+
 	bt_dev_dbg(hdev, "");
 
 	hci_dev_lock(hdev);
-- 
2.35.3


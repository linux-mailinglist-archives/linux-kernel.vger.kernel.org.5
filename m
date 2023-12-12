Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B201480F8C1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjLLU5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjLLU5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:57:40 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1D6DC;
        Tue, 12 Dec 2023 12:57:46 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-5913b73b53eso568306eaf.0;
        Tue, 12 Dec 2023 12:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702414666; x=1703019466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+NtwutO0Yef1IT5J57pTjQTn8pKKW2uFYT3a6IzSDIk=;
        b=iSzkrGt9YcWtIwy6TK/BkeZjGiJ6aRvsDLMoLYbXvHumtXEvFHK016tRckXNdSsgXL
         eUK3LsD0Pkt7OEFdvich6/HHEcOfgqG+eSlPO3XRCXO8xEKiaZdi5Grvg5e8G1eLKBY8
         BeZkpOFhj5FuY1qWPSUGvzZr7buSfEFo4Td2Z0w1qhqWPJ410y+3mospynj3/fXAkTS0
         OaPmdekPiEkt8+yHpBIJEq1lfOW4Oc2mZndzXyJBFIo/R70HBO5x4vmkMTIW5GNQzL0t
         BMMXDD7/bKGS08cOClFhIDqAmuOYME/25wpWk1wncDo6kysZd78UwSqakg2QfdG9geZE
         CU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414666; x=1703019466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+NtwutO0Yef1IT5J57pTjQTn8pKKW2uFYT3a6IzSDIk=;
        b=tNpZpb9D0qHc8ZZFSjLnCphKQiXfd89emxd1IUj5a2VDLsNrdzXL9qJdvwVen0jMAR
         kAo64JxQ5Ch1aLuw7gIUbs6MsWMeR2p+SCm7cvEXL2QrCMARyYsL1Y7xETGl8DcGf6PW
         yR1LwcV4/PxIoWyLzFbv5YlBlSpaIu6Q5aHx2MhF21Nfan7+ku/svouDFXwSmkPeB/2+
         /6Mb/B50rywp0W/UjuNZyKlLqIEDa69nikDruD2TmSFjQO4BInDHjteTuILyL/JJijmw
         MLzfy39AP36mzMZ2/qAunbxKAiCDLM4/qtOMgheVBVXHE+5gwuxlDR5wXf8a7xQ/vDEv
         ceqg==
X-Gm-Message-State: AOJu0Yz7qEnFltk163W3pz6B/FxLDpyPEVfyt8wC1KrO0fU7aGCL8W6e
        AEidSIY7KU1ePhQO12C2/uC1wrcKeMx4/w==
X-Google-Smtp-Source: AGHT+IEJjhRfAy7pnP/eL1tGE6KOLoprpMkpj+uSUAQSFJlvI5Px2dDNj5hSKoUX5IzshPV9ZhdqGg==
X-Received: by 2002:a05:6820:551:b0:590:96a7:34c2 with SMTP id n17-20020a056820055100b0059096a734c2mr5493515ooj.14.1702414665903;
        Tue, 12 Dec 2023 12:57:45 -0800 (PST)
Received: from guyc-asus.. ([173.216.104.94])
        by smtp.gmail.com with ESMTPSA id h26-20020a4a281a000000b0058df6ae23fdsm2634981ooa.33.2023.12.12.12.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 12:57:45 -0800 (PST)
From:   Guy Chronister <guylovesbritt@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] HID: elo fix coding style errors.
Date:   Tue, 12 Dec 2023 14:57:44 -0600
Message-Id: <20231212205744.36089-1-guylovesbritt@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix whitespace errors and missing spaces around ==.

Signed-off-by: Guy Chronister <guylovesbritt@gmail.com>
---
 drivers/hid/hid-elo.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-elo.c b/drivers/hid/hid-elo.c
index 2876cb6a7dca..d91d6ef4de9a 100644
--- a/drivers/hid/hid-elo.c
+++ b/drivers/hid/hid-elo.c
@@ -33,7 +33,7 @@ struct elo_priv {
 
 static struct workqueue_struct *wq;
 static bool use_fw_quirk = true;
-module_param(use_fw_quirk, bool, S_IRUGO);
+module_param(use_fw_quirk, bool, 0444);
 MODULE_PARM_DESC(use_fw_quirk, "Do periodic pokes for broken M firmwares (default = true)");
 
 static int elo_input_configured(struct hid_device *hdev,
@@ -193,7 +193,7 @@ static bool elo_broken_firmware(struct usb_device *dev)
 	u16 fw_lvl = le16_to_cpu(dev->descriptor.bcdDevice);
 	u16 child_vid, child_pid;
 	int i;
-    
+
 	if (!use_fw_quirk)
 		return false;
 	if (fw_lvl != 0x10d)
@@ -205,13 +205,13 @@ static bool elo_broken_firmware(struct usb_device *dev)
 		child_pid = le16_to_cpu(child->descriptor.idProduct);
 
 		/*
-		 * If one of the devices below is present attached as a sibling of 
-		 * the touch controller then  this is a newer IBM 4820 monitor that 
+		 * If one of the devices below is present attached as a sibling of
+		 * the touch controller then  this is a newer IBM 4820 monitor that
 		 * does not need the IBM-requested workaround if fw level is
 		 * 0x010d - aka 'M'.
 		 * No other HW can have this combination.
 		 */
-		if (child_vid==0x04b3) {
+		if (child_vid == 0x04b3) {
 			switch (child_pid) {
 			case 0x4676: /* 4820 21x Video */
 			case 0x4677: /* 4820 51x Video */
-- 
2.40.1


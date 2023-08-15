Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1C677D48B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239360AbjHOUqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239683AbjHOUpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:45:54 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983E62137;
        Tue, 15 Aug 2023 13:45:17 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bb84194bf3so36313175ad.3;
        Tue, 15 Aug 2023 13:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692132306; x=1692737106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/1qYopfzy5FScJaweAwME/q6+kQztgNks+lefLWesQA=;
        b=CeQpivSuRSA6iG28nLx4HaUQm/FBH0IOPCMzk+fnM0nKqiR3ao3+udRNFiZkas72R+
         b4JR+Dy8SVPPArz1aEb1UhL/Gga0uCZRmCzqF2GfQvjvr6JhdkI/Qq0g8Sjl6gLad/m3
         qCB7rrnV8Z0teJSmgecLqBBgple4RAiEBJFwaTKv+EGcBVJnR8bzsmEkEEbeqbXwk6v6
         kGda6GogIJUiCmHfp0r3XM+tYoS1C1QDi7K8vr0DLtSPZwHYScVF++joU0eb71MUJ/nO
         PqRBqO9LVIRwpKyDGwWSHbygMjk65UcsOd1NpO4L0pMfa1vGxHB6ZhVUCMKaZ/RG2ifL
         PnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692132306; x=1692737106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/1qYopfzy5FScJaweAwME/q6+kQztgNks+lefLWesQA=;
        b=Ho/kBRrHvr8aCGpyOR4x+BFnxrW53R11LA5Pgf1CH3gytjAIWckqXzmUU/7NVYiQ7g
         0bc7NBwpdN9G7rO1l/uvP2xW7TiCFmeUyhT4k+PqWEOY9Vv1i4Iu5AXEIasdbLnbLAHn
         cTy3bNmmchFs7Mgm21iutQswVb6xtXIHn2P7azmKvIZgkxFTBSXOgdn5gPv/bNiMgwtv
         frz9PLiy/O/qfA7CHj8SOhO84r4na4zuIeGZCavzTXYpsXOY3kp4plb/6gjAcXzYtAtr
         jgsBW1pR/Fy8/nV6blovHu9OoQ1kWjH7o1NXglJ/lNcOi5rbYQQpjtS7a4Qgcb+tU7G6
         Nb7A==
X-Gm-Message-State: AOJu0YxP7SLOJ0gbxZiSc9IHieXM+H3caU9d7+meoysYNQf+t8TVhlwa
        GFmcrqVQQkfzLzhOlyv4ye0=
X-Google-Smtp-Source: AGHT+IGfxdOOH/5kD9urs2vY3+SJbvVzNgPD/VAS9XTiGUhixol15HlxVUo1JglAH/S5ms0jLfis2w==
X-Received: by 2002:a17:902:bb8c:b0:1b1:9218:6bf3 with SMTP id m12-20020a170902bb8c00b001b192186bf3mr10622565pls.37.1692132306505;
        Tue, 15 Aug 2023 13:45:06 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c009:58e9:db85:3caf:1429:e455])
        by smtp.gmail.com with ESMTPSA id q15-20020a170902dacf00b001bbb7af4963sm11465826plx.68.2023.08.15.13.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 13:45:06 -0700 (PDT)
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        bagasdotme@gmail.com, raychi@google.com, f.suligoi@asem.it
Cc:     Atul Kumar Pant <atulpant.linux@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah@kernel.org
Subject: [PATCH v1] drivers: usb: Replaces spaces with tabs for indentation.
Date:   Wed, 16 Aug 2023 02:14:39 +0530
Message-Id: <20230815204439.52137-1-atulpant.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes following checkpatch.pl issue:
ERROR: code indent should use tabs where possible

Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
---
 drivers/usb/core/hub.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 97a0f8faea6e..1e56efe9214b 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1777,7 +1777,7 @@ static bool hub_descriptor_is_sane(struct usb_host_interface *desc)
 	if (!usb_endpoint_is_int_in(&desc->endpoint[0].desc))
 		return false;
 
-        return true;
+	return true;
 }
 
 static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
@@ -5840,14 +5840,14 @@ static void hub_event(struct work_struct *work)
 
 static const struct usb_device_id hub_id_table[] = {
     { .match_flags = USB_DEVICE_ID_MATCH_VENDOR
-                   | USB_DEVICE_ID_MATCH_PRODUCT
-                   | USB_DEVICE_ID_MATCH_INT_CLASS,
+		   | USB_DEVICE_ID_MATCH_PRODUCT
+		   | USB_DEVICE_ID_MATCH_INT_CLASS,
       .idVendor = USB_VENDOR_SMSC,
       .idProduct = USB_PRODUCT_USB5534B,
       .bInterfaceClass = USB_CLASS_HUB,
       .driver_info = HUB_QUIRK_DISABLE_AUTOSUSPEND},
     { .match_flags = USB_DEVICE_ID_MATCH_VENDOR
-                   | USB_DEVICE_ID_MATCH_PRODUCT,
+		   | USB_DEVICE_ID_MATCH_PRODUCT,
       .idVendor = USB_VENDOR_CYPRESS,
       .idProduct = USB_PRODUCT_CY7C65632,
       .driver_info = HUB_QUIRK_DISABLE_AUTOSUSPEND},
-- 
2.25.1


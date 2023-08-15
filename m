Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC9177D49E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239649AbjHOUtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239964AbjHOUta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:49:30 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D561FF1;
        Tue, 15 Aug 2023 13:49:08 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bc7b25c699so36110025ad.1;
        Tue, 15 Aug 2023 13:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692132535; x=1692737335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bogrc8I45CpUGNuJPor5QL0yiENpN5Kgir2vwQdsAWI=;
        b=DucT2EVtNWiAERc3j1yfKXILmVrQoibG/C6e8wvGKrW5hqO8qx8tzrNB8LtswY199K
         cXl8TOO2Z3WEPTQazw5hN4WQBiYUJput+Y5QWmR9qmW5Xq8qXvmiEVWPP1KzL3Znkp53
         KUfC/+5ecvqBvh7GNbEokew6ClwPjbPR3Yn5u6pT6zaq7L8RDiJlMpM0FmXd05p3mYcG
         EwiKKjsfHY0iylFed2jElnBWXxhRkvmUhIf7N6KRcRtnMcikTWqbT4CyYvbRfrxEBEzs
         XcwvyEv0zPZkLckml5b2/HKZw8TVpR5B7dn9yVW2Zf4t3SpY7TGzYW1qOlVVpknXL0A8
         uSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692132535; x=1692737335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bogrc8I45CpUGNuJPor5QL0yiENpN5Kgir2vwQdsAWI=;
        b=V426WYWZvpF9GrY4YnqOw9DbJJoSBOWizjJx0hd0iTzCZk1iQ7pnxdcR2zIflK90FU
         EgXgloVJhRXYVnXahr6kHmfb6nj18g9TBh8jVoaUDqfuai9JFVtl/hM1PpVdogXMYARu
         IsLm/wU0CJWujumVsLuH2rA11SQSQaDHfVMT4TTE+duIl0ebE//BAE5yhAy5b0+klaqT
         lysHxvMvDPy7fexPKqlMfmtGQzNB3mIkesBIVSUcg97fiwwo2ACj3OYrogNp9P3tRdde
         blFIwtR1MmqjiFSgtgWzoVVrEf0zlgiT9/vBK0gK0+/X7WNmJKq9e9CY7yzGj69/MB/a
         k0/g==
X-Gm-Message-State: AOJu0YwCkUxpRxl4wUVf/8dyhwrUgT/nWMxJptosmNI/U4bnF8xTZCqt
        zPkcwpF6CulxzKp4OWKl724=
X-Google-Smtp-Source: AGHT+IH5Wg2hJKsse7WyKIr/31ETWSa1Uu7wFDFLPBUTzAUf1xySzWO0D4/7mirpPniBkFl4sm+a6Q==
X-Received: by 2002:a17:902:f68c:b0:1b9:e1d6:7c7d with SMTP id l12-20020a170902f68c00b001b9e1d67c7dmr13567414plg.47.1692132535116;
        Tue, 15 Aug 2023 13:48:55 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c009:58e9:db85:3caf:1429:e455])
        by smtp.gmail.com with ESMTPSA id ja11-20020a170902efcb00b001b83e5ec666sm11472272plb.6.2023.08.15.13.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 13:48:54 -0700 (PDT)
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     oneukum@suse.com, gregkh@linuxfoundation.org
Cc:     Atul Kumar Pant <atulpant.linux@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah@kernel.org
Subject: [PATCH v1] kernel: usb: Adds space, removes trailing whitespace and fixes pointer declaration.
Date:   Wed, 16 Aug 2023 02:18:41 +0530
Message-Id: <20230815204841.52600-1-atulpant.linux@gmail.com>
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
ERROR: space required before the open parenthesis '('
ERROR: trailing whitespace
ERROR: space required after that ','
ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
---
 drivers/usb/class/cdc-acm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 11da5fb284d0..638c9cdaa041 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -203,7 +203,7 @@ static int acm_wb_is_avail(struct acm *acm)
 	n = ACM_NW;
 	spin_lock_irqsave(&acm->write_lock, flags);
 	for (i = 0; i < ACM_NW; i++)
-		if(acm->wb[i].use)
+		if (acm->wb[i].use)
 			n--;
 	spin_unlock_irqrestore(&acm->write_lock, flags);
 	return n;
@@ -1006,7 +1006,7 @@ static int wait_serial_change(struct acm *acm, unsigned long arg)
 		}
 	} while (!rv);
 
-	
+
 
 	return rv;
 }
@@ -1257,7 +1257,7 @@ static int acm_probe(struct usb_interface *intf,
 
 	if (control_interface == data_interface) {
 		/* some broken devices designed for windows work this way */
-		dev_warn(&intf->dev,"Control and data interfaces are not separated!\n");
+		dev_warn(&intf->dev, "Control and data interfaces are not separated!\n");
 		combined_interfaces = 1;
 		/* a popular other OS doesn't use it */
 		quirks |= NO_CAP_LINE;
@@ -1428,7 +1428,7 @@ static int acm_probe(struct usb_interface *intf,
 		goto err_free_write_urbs;
 
 	if (h.usb_cdc_country_functional_desc) { /* export the country data */
-		struct usb_cdc_country_functional_desc * cfd =
+		struct usb_cdc_country_functional_desc *cfd =
 					h.usb_cdc_country_functional_desc;
 
 		acm->country_codes = kmalloc(cfd->bLength - 4, GFP_KERNEL);
-- 
2.25.1


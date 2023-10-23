Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A69D7D404F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjJWTdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjJWTdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:33:31 -0400
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFA2B4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:33:29 -0700 (PDT)
Received: from localhost.localdomain ([141.170.221.62])
        by smtp.orange.fr with ESMTPSA
        id v0fzqGEQclciav0g4qWHEJ; Mon, 23 Oct 2023 21:33:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698089608;
        bh=/5Qo3nS8waaAiEey/mOoHQa+DwKTxtDvbnHYmE4+GsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iP/bKu14gUhGjswtz4l38t2ht/2Tcp77Pltkl5s8fh2CbTDC3k+5SxHNQw8oSj4Q0
         ImbJS7ubWWo7ZyBd+EbHnjPYcHXocTMqD42S7miGBjMv85zuknLVGSZnuFs6t+H2G+
         5aAp6lTX+7wPIfLmMt4BH3FtovjY8jktzW2yihDchkpC9t2APtudx3rPK6XLxjQ4dP
         052FHs+M3uNsazOSc2hEUNk7eJ01TjzZzzwSOm9Smj/OiKPkfyTMaswnvIV+z9nHWM
         k26E1DIo/DfM6JyJA9UtjIDmz+9HCOnKgUvpbTwiW56ITasuxPVxfBwREJmtOE7aNh
         GyTo42AJXguFw==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 23 Oct 2023 21:33:28 +0200
X-ME-IP: 141.170.221.62
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 3/4] ACPI: sysfs: Remove some useless trailing NULL writes
Date:   Mon, 23 Oct 2023 21:33:17 +0200
Message-Id: <d357fca843f8d3cc36a048732585de24d379a292.1698081019.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1698081019.git.christophe.jaillet@wanadoo.fr>
References: <cover.1698081019.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'modalias' is only written with snprintf(), so it is already guaranteed to
be NULL terminated.

Remove the unneeded (but harmless) writes of a trailing '\0'.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/acpi/device_sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 7ec3142f3eda..1cf6568a813f 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -177,7 +177,7 @@ static int create_pnp_modalias(const struct acpi_device *acpi_dev, char *modalia
 		len += count;
 		size -= count;
 	}
-	modalias[len] = '\0';
+
 	return len;
 }
 
@@ -237,7 +237,7 @@ static int create_of_modalias(const struct acpi_device *acpi_dev, char *modalias
 		len += count;
 		size -= count;
 	}
-	modalias[len] = '\0';
+
 	return len;
 }
 
-- 
2.32.0


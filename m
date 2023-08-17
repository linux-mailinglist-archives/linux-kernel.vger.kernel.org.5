Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D563977FC77
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353804AbjHQREF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353834AbjHQRDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:03:51 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A143B30C5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:03:49 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-34992fd567bso116465ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692291829; x=1692896629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/CF1sp7z18+6hzC94tDeSNxB7GD4ts5/I3Q7/FCqPU=;
        b=kZhb+6h+olefCaUxLh+5ROA9Q5Q0bYberN/mtcsV1M3xiXoWcHawfL+WLHazoMNlDb
         e19laAhHDhd/bigAMTN6dsOCKk+QXlEjrreWfBIIoJPksyINsnUarmTi2/wzB738IMHz
         UVQxI0I+8LuQsQvrujmNvtP4pixmOtv3VjOZRb4T79qQizq5lSy4oMB04UryeWLgkNXT
         DLRuGGGWuFAiCJ7f3UjN0aBxOktVG9iOas4VPd1mG9fwr5Jt+cHHOqHpU9HIYVSvWrTL
         a0ntdHT0g8+90gwCEBRdgcHCNZw5ao3niLnF+rcpXo1NsaxNDIFoLM0VLZdnodpZWdH6
         MyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692291829; x=1692896629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/CF1sp7z18+6hzC94tDeSNxB7GD4ts5/I3Q7/FCqPU=;
        b=JplpVfJ5zrtCSfl1glDnlXtqpAkLIS8BZ6xWc90k7UptvyKKEAm+sfxXI3GbQ4AdyY
         xFOepMKv77kwmjf7oWqXGWBvtQ22i7qfXlEKJABePatATBbOskh3N8VUIdUa6b47x6PN
         P0UTyMAHJ4CXHSblBqCFqDfzwlvMFVXzUov2R/ZwfW+tBrR7BA5wyHaS999NLSRMvIgc
         Wyp1RTRIWpMI98F4a5w0yzyE4J9WSH5vsHkKeVj5q4yazh6llWRhKQ+gZn8F5mWkYRA6
         vXYR9XvGQOyYdsMHiNPiMJ8R/eQPBwhGCO9G4ceszHHIzqI95ZDw9yWZPgQxy+ANUZYk
         XyVg==
X-Gm-Message-State: AOJu0Yz3ca6gzdywSet9VJFmtNE1O0An7nzUKE1b/bIChL7EruVFGdK6
        7MXB+wMraDU0QfJKf3rOSNc=
X-Google-Smtp-Source: AGHT+IGS7UsBL/IVOjFXyITZjakLFnLw2xV75JF+PU9lUQC5ZN2voEGYjEhUJl+UjcQe77M9Cch8/A==
X-Received: by 2002:a92:ca0b:0:b0:348:b086:2c4b with SMTP id j11-20020a92ca0b000000b00348b0862c4bmr4778445ils.9.1692291828909;
        Thu, 17 Aug 2023 10:03:48 -0700 (PDT)
Received: from sun-virtual-machine.localdomain ([103.149.144.245])
        by smtp.gmail.com with ESMTPSA id r2-20020a92d982000000b00342093347d8sm5315859iln.76.2023.08.17.10.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 10:03:48 -0700 (PDT)
From:   SSunk <ssunkkan@gmail.com>
To:     miquel.raynal@bootlin.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        michael@walle.cc, pratyush@kernel.org, richard@nod.at,
        ssunkkan@gmail.com, tudor.ambarus@linaro.org, vigneshr@ti.com
Subject: [PATCH] Add support for more XMC series
Date:   Fri, 18 Aug 2023 01:03:35 +0800
Message-Id: <20230817170335.3711-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817152050.6679eae3@xps-13>
References: <20230817152050.6679eae3@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add XMC XM25QH128C/XM25QH256C/XM25QU256C/XM25QH512C/XM25QU512C
and set the parse_sfdp flag.

Signed-off-by: Kankan Sun <ssunkkan@gmail.com>
---
Hi Michael,
Since this is the first time I've submitted code to the Linux community, please forgive me for some of the missteps that I've made.
I uploaded the incorrect patch file.
In a previous e-mail you said：
XMC parts seem to have SFDP tables and they should work out of the box
without any patches with the generic spi nor driver [1]. Therefore,
you don't need any entry at all.

I think it is related to the PARSE_SFDP flag.
The XMC flash part supports SFDP, so i don’t need to add NO_SFDP_FLAGS() macro.
 drivers/mtd/spi-nor/xmc.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/xmc.c b/drivers/mtd/spi-nor/xmc.c
index 051411e86339..e78bf11792d9 100644
--- a/drivers/mtd/spi-nor/xmc.c
+++ b/drivers/mtd/spi-nor/xmc.c
@@ -11,11 +11,20 @@
 static const struct flash_info xmc_nor_parts[] = {
 	/* XMC (Wuhan Xinxin Semiconductor Manufacturing Corp.) */
 	{ "XM25QH64A", INFO(0x207017, 0, 64 * 1024, 128)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ) },
+		PARSE_SFDP },
 	{ "XM25QH128A", INFO(0x207018, 0, 64 * 1024, 256)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ) },
+		PARSE_SFDP },
+	{ "XM25QH128C", INFO(0x204018, 0, 64 * 1024, 256)
+		PARSE_SFDP },
+	{ "XM25QH256C", INFO(0x204019, 0, 64 * 1024, 512)
+		PARSE_SFDP },
+	{ "XM25QU256C", INFO(0x204119, 0, 64 * 1024, 512)
+		PARSE_SFDP },
+	{ "XM25QH512C", INFO(0x204020, 0, 64 * 1024, 1024)
+		PARSE_SFDP },
+	{ "XM25QU512C", INFO(0x204120, 0, 64 * 1024, 1024)
+		PARSE_SFDP },
+
 };
 
 const struct spi_nor_manufacturer spi_nor_xmc = {
-- 
2.34.1


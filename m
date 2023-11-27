Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979157FAB37
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbjK0UTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbjK0UTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:19:10 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5906D59
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 12:19:16 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40859dee28cso37932385e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 12:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701116355; x=1701721155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vh8fgHf4VbVXQAtoSfn0NqPkk1fZpC4zX2ISfWKVIQM=;
        b=Ukylmb1MOXdJQd/VE/Dc4BeBZigvINLYJ6EF2cY+i9Qqg4CR8RYJXhVEoiVnANVrCI
         Op2RkdjtzM0/AnziiZcqzRIbY4XoN3xVUgaock5J/H1hCdze0/7KbOh5E9qJQ5qnAMOe
         MO3Wu6MRXdq4mQk8IrMo/g49Yw8gJPkY8lMmgs5FbCAt7ednXwLg0GMHOZJrcdFnNxYv
         GfdxUawekaHXee2ZJPSIt/GFlJNX1PaEZL9XOpNLZXLjImiTOydx9bGqC5BDY6kQ0gdQ
         D9uR1ts0+0/aeqmPe8AbmY2Tonxr2t9kOxX94g9fov3lsOorpbIFxBySApqzqSnSFK1d
         CAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701116355; x=1701721155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vh8fgHf4VbVXQAtoSfn0NqPkk1fZpC4zX2ISfWKVIQM=;
        b=qz97EgGhRdpBWLnHUDeA0cx+xvwbNP4I+ZORI3xd7PpyrRfc/QOGT0Nxfxuf8WEixE
         sxpBzAYSfKLY/Z8WyruJFiyCubneoteOgtKUt6Vi1lvIbKBFK7qYMTmV/1kkSb8GNI9z
         aEy2DD6XoHUq2YitL7MeN9+UNyaRrTD1FPSXfGN7pobXXWP82wQqrzM2C8ZjdmH/402/
         LuQytxZeRsiyoSU9SG+75NTz+SH7ql4ZWw21MUy6sReb2WnPO9iLB29hDBDYUwjK7lyy
         1Mfat1qlzyY5yvXdn6rcQTbqB7HAlMz0hsC2Qc4B3a7GCtmcBTsuT5dHFp8YkMIly5H4
         w/Mw==
X-Gm-Message-State: AOJu0YzsWNZjYLq0PxErjMEo7e7ldz8qC8Ho7HhJoyYPHsuobA7+23fL
        TeZqWZyxldOeSuoeVTBjFeY=
X-Google-Smtp-Source: AGHT+IGMGwwVCx10gzcRAqG5np2WYc67335sitXCPn8L8pVcCa1x2vhkFU6IztE/ZaP4pcbe9MHUQw==
X-Received: by 2002:a05:600c:3ca2:b0:40b:2a69:6c37 with SMTP id bg34-20020a05600c3ca200b0040b2a696c37mr10335004wmb.4.1701116354875;
        Mon, 27 Nov 2023 12:19:14 -0800 (PST)
Received: from mfe-desktop.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.googlemail.com with ESMTPSA id k32-20020a05600c1ca000b0040839fcb217sm15224619wms.8.2023.11.27.12.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 12:19:13 -0800 (PST)
From:   marc.ferland@gmail.com
X-Google-Original-From: marc.ferland@sonatest.com
To:     krzysztof.kozlowski@linaro.org
Cc:     gregkh@linuxfoundation.org, marc.ferland@sonatest.com,
        jeff.dagenais@gmail.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] w1: ds2433: remove unused definition
Date:   Mon, 27 Nov 2023 15:18:53 -0500
Message-Id: <20231127201856.3836178-3-marc.ferland@sonatest.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127201856.3836178-1-marc.ferland@sonatest.com>
References: <20231117192909.98944-1-marc.ferland@sonatest.com>
 <20231127201856.3836178-1-marc.ferland@sonatest.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Ferland <marc.ferland@sonatest.com>

W1_F23_TIME isn't used anywhere, get rid of it.

Signed-off-by: Marc Ferland <marc.ferland@sonatest.com>
---
 drivers/w1/slaves/w1_ds2433.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2433.c b/drivers/w1/slaves/w1_ds2433.c
index 9f21fd98f799..e18523ef8c45 100644
--- a/drivers/w1/slaves/w1_ds2433.c
+++ b/drivers/w1/slaves/w1_ds2433.c
@@ -30,8 +30,6 @@
 #define W1_PAGE_BITS		5
 #define W1_PAGE_MASK		0x1F
 
-#define W1_F23_TIME		300
-
 #define W1_F23_READ_EEPROM	0xF0
 #define W1_F23_WRITE_SCRATCH	0x0F
 #define W1_F23_READ_SCRATCH	0xAA
-- 
2.34.1


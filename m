Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012127CB336
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 21:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjJPTOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 15:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJPTOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 15:14:16 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB9D95
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 12:14:14 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7ab5150a7b5so3986482241.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 12:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697483654; x=1698088454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hX0YSXc6+jMKeduwiLhbDjjdLeLQnRptnmgyoj+8GRc=;
        b=BLIHsVXoexTIVy0SoqYOXsIi5zupC0Xf+8oTB/ldiiZEU6DBK1Xjvb8qBplwsoSqQh
         2sufimIiBpzOnYfSvfQWPPioiXRzQ4Y+PMtsies9Faz3SJFRZmAh/CU9wE90kISCeLtE
         Yxbohr/v+to8OJDddAfW1YrKgN/DXtrmRS2yHVSACJFCPKQ/17uwyBnRQnfyFQ3Dn/Bh
         qGNy/Tjahi6Ou8Q8/ZARtFmvg2T+7dea+ApmpdJDOEHzlKVxQeic/ZQIKvHu16FTpeIf
         +hlWTAlSvP/Z6h0NaGxONmBsyAUeSDv5CMLVPbRYtEtQK4ymkMU5/GFWwL4WACXIw9CY
         RQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697483654; x=1698088454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hX0YSXc6+jMKeduwiLhbDjjdLeLQnRptnmgyoj+8GRc=;
        b=SSL/2fXi3S2O51as8kqRdlyMr6zb8Nvr85fqH3ernEsbpNrd2raGpb4B1KLQdEqJxN
         rzcLUAG7aGCMpcaICOzdqkEyY2BSjdFhT2Wbg7aJnke68w1c0c240Pa9ulnUcBiAl71W
         zTSNx0L5JJGZMWXWnZ/enxvVXn2RjvGTS9S0nKCKemNxH5n1oIBDO2mQEMBgxCmBF2Qo
         tGPfR20dMcZfHJCu1/V/pgIqJEJxiWU44/AeJY6PQwxbqF79IxyLbsvp05LhJJvyPP2z
         HxHZwnxclkn/aHRCDoAJCCQNHXT1HC3airN76RG1VaZY8mp0Mn8vza4OYuNFMBr318Ap
         boiA==
X-Gm-Message-State: AOJu0YyBH2Zv35Ayk9kU+NvRinWBRUY+Znf6vSZ+AF3yJSHrzoFBanLw
        5CpaBQ1DkNfSCuvu4w6ia8I=
X-Google-Smtp-Source: AGHT+IGrKbvN/zNXdWU8coFtZ7pMo9v4I8oBSuDg4/xiDhsO+K6rGStQdN4Hsoq8uKFIxV1iMZZEkQ==
X-Received: by 2002:a67:c019:0:b0:44d:38d6:5cb8 with SMTP id v25-20020a67c019000000b0044d38d65cb8mr4770055vsi.10.1697483653794;
        Mon, 16 Oct 2023 12:14:13 -0700 (PDT)
Received: from policorp.cardumecowork.local ([177.91.232.53])
        by smtp.gmail.com with ESMTPSA id s8-20020ab07648000000b007b5f7b89beasm1464181uaq.21.2023.10.16.12.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 12:14:13 -0700 (PDT)
From:   Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
To:     corentin.chary@gmail.com
Cc:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
        markgross@kernel.org, acpi4asus-user@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, edson.drosdeck@gmail.com
Subject: [PATCH] platform/x86: asus-laptop: remove redundant braces in if statements
Date:   Mon, 16 Oct 2023 16:13:49 -0300
Message-Id: <20231016191349.3856-1-edson.drosdeck@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

Adhere to Linux kernel coding style.

Reported by checkpatch:

WARNING: braces {} are not necessary for single statement blocks

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
---
 drivers/platform/x86/asus-laptop.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index 761029f39314..bf03ea1b1274 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -1816,9 +1816,8 @@ static void asus_dmi_check(void)
 		return;
 
 	/* On L1400B WLED control the sound card, don't mess with it ... */
-	if (strncmp(model, "L1400B", 6) == 0) {
+	if (strncmp(model, "L1400B", 6) == 0)
 		wlan_status = -1;
-	}
 }
 
 static bool asus_device_present;
-- 
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1D27F639D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbjKWQHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjKWQHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:07:31 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402D6173F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:07:33 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a00191363c1so147958366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700755651; x=1701360451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WoI3lRlk1siP5XEqEA8VbXVQlXNyy2eE79v15BctaEA=;
        b=VA/Z40irgPjcAroKD6uB+LaayTpcyzISuE63/B7rTx9EhQEnRJg5k5sW0VN8WWNdRa
         sKEKuTZHGDVNAgO6lfsauN0qPL8PW2cqgblHHNi19XpmFEEXTyLDF5OUGrf1Eh3WFv6T
         JN9Gwi9TpMIMbUtjb8Jp6qSYY+DTCY6iFrGOMo/kt2GddUpqBvMfzgpa0r0eX51bhDn0
         ZMd5l16weNh6onJudBkQ9rPbpyPWLLzjsuzv5g7CZpV0zuj2C60Ii8z3fP4ePv0QllRi
         QJhbS5blOU0oF865SAcjZRAqGB8zhP/YGqy87zL1lcJdMBw9k/YNRWM77vIckcpBu+aE
         I3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700755651; x=1701360451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WoI3lRlk1siP5XEqEA8VbXVQlXNyy2eE79v15BctaEA=;
        b=fGNYhq3fyO1dl0053OlErGF2OnYwL9BPfYjMiSQruEYA8Mrg/CGTBERJCGnEO400ig
         2drX4cr4FNg7hMGPuFQxuJyQeBAB5fbULS4Xye0T0xlNaxnxhDnOO0Fzz2ZPMp7gKPSv
         7+1B1UuaZmnE9w+eJuK5GehIzZdCr8UhX52t22uoI2IqL6TtBzZQQ2pk42G0nUO/LBja
         d3adrsX8nzUYtcMu+zRcdJwJjfgmnLyKaohmGJtpDgGGgKEKq7rxVPTTpbWg9xJE4vMs
         kviqHoTPN+wsPg/ggOc+ENrUdyhQORA+j8p4D9mFCWFBqd+fxvzbDO7xwwcZDPfdhvZN
         HBgg==
X-Gm-Message-State: AOJu0YzJTHcNOAs4+ANKCLyxWz1UVmXa7WQQYcdo7taenr3tf2gOf6jy
        nLGxA/6Axz4H2mH2Nj8F0CQbPsGvR3GvlK8jk4o=
X-Google-Smtp-Source: AGHT+IGHrjV7KWZCoEyhk3LUDeDpJK+b8DsMP8V/SftnXg8kdd6A2uqtPufVt+RamQUhVxFmLniHLA==
X-Received: by 2002:a17:907:d38a:b0:9e2:af56:c380 with SMTP id vh10-20020a170907d38a00b009e2af56c380mr5454059ejc.6.1700755651692;
        Thu, 23 Nov 2023 08:07:31 -0800 (PST)
Received: from 1.. ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id h21-20020a1709070b1500b00a0180de2797sm941490ejl.74.2023.11.23.08.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 08:07:30 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     pratyush@kernel.org, michael@walle.cc
Cc:     linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 2/2] docs: mtd: spi-nor: drop obsolete info
Date:   Thu, 23 Nov 2023 18:07:21 +0200
Message-Id: <20231123160721.64561-3-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123160721.64561-1-tudor.ambarus@linaro.org>
References: <20231123160721.64561-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3053; i=tudor.ambarus@linaro.org; h=from:subject; bh=25OPubX9uzUyfM/XTP0zGdZT9n+Quh1N4wccoUHj8ic=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBlX3i5QFJr2OKH8EvKa+v/4w+Lmao2JCr0Mw7oV /lLZU7/wzqJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZV94uQAKCRBLVU9HpY0U 6QCbCAC4SngJRGZ0qeFbmpZ6hInfmNRUbhAEQHkQxqBDDtkD+zPfaHPtRDnzLTVp4wl9ZW+pv50 Uov8OIk5qS4gbc4Z4bJEqhsWZmOSpEV6Vlb7Se2LnRTeY7q0MPjA+Q4XkScUAnFB0EszN0POp5w 3gfs2paYIdVQbg3Nie3Dxomp8hpxgIjDEsjtP91bvES+Taajqgx4JQvOFebwksgWbrOp7r9iMrX s2wMu7w8QDSh9bODQfv8sDI1E3Ou+DKbos9OBejAD7lFPfLLpRsvZ1bKQSAMA5H/PVXrwOBXlmz CZt0aHdVmp+6qwMi1p03b9uGe7yE2Y3dTr2W9ZurmmhwLp22
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The architecture description is obsolete, it no longer applies to
the current SPI NOR framework state, remove it.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 Documentation/driver-api/mtd/spi-nor.rst | 62 ------------------------
 1 file changed, 62 deletions(-)

diff --git a/Documentation/driver-api/mtd/spi-nor.rst b/Documentation/driver-api/mtd/spi-nor.rst
index cc8e81e09544..7a8737fe181d 100644
--- a/Documentation/driver-api/mtd/spi-nor.rst
+++ b/Documentation/driver-api/mtd/spi-nor.rst
@@ -2,68 +2,6 @@
 SPI NOR framework
 =================
 
-Part I - Why do we need this framework?
----------------------------------------
-
-SPI bus controllers (drivers/spi/) only deal with streams of bytes; the bus
-controller operates agnostic of the specific device attached. However, some
-controllers (such as Freescale's QuadSPI controller) cannot easily handle
-arbitrary streams of bytes, but rather are designed specifically for SPI NOR.
-
-In particular, Freescale's QuadSPI controller must know the NOR commands to
-find the right LUT sequence. Unfortunately, the SPI subsystem has no notion of
-opcodes, addresses, or data payloads; a SPI controller simply knows to send or
-receive bytes (Tx and Rx). Therefore, we must define a new layering scheme under
-which the controller driver is aware of the opcodes, addressing, and other
-details of the SPI NOR protocol.
-
-Part II - How does the framework work?
---------------------------------------
-
-This framework just adds a new layer between the MTD and the SPI bus driver.
-With this new layer, the SPI NOR controller driver does not depend on the
-m25p80 code anymore.
-
-Before this framework, the layer is like::
-
-                   MTD
-         ------------------------
-                  m25p80
-         ------------------------
-	       SPI bus driver
-         ------------------------
-	        SPI NOR chip
-
-After this framework, the layer is like::
-
-                   MTD
-         ------------------------
-              SPI NOR framework
-         ------------------------
-                  m25p80
-         ------------------------
-	       SPI bus driver
-         ------------------------
-	       SPI NOR chip
-
-With the SPI NOR controller driver (Freescale QuadSPI), it looks like::
-
-                   MTD
-         ------------------------
-              SPI NOR framework
-         ------------------------
-                fsl-quadSPI
-         ------------------------
-	       SPI NOR chip
-
-Part III - How can drivers use the framework?
----------------------------------------------
-
-The main API is spi_nor_scan(). Before you call the hook, a driver should
-initialize the necessary fields for spi_nor{}. Please see
-drivers/mtd/spi-nor/spi-nor.c for detail. Please also refer to spi-fsl-qspi.c
-when you want to write a new driver for a SPI NOR controller.
-
 How to propose a new flash addition
 -----------------------------------
 
-- 
2.34.1


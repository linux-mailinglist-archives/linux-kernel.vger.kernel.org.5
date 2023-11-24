Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E507F8066
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 19:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345742AbjKXStO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 13:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjKXStI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 13:49:08 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C0A268C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:49:15 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a013d22effcso305204866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700851753; x=1701456553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiSRWT9NVEVchvdLGPLG5ZFEZReZtLSoIFrvmw6+vsw=;
        b=dX0JmeR3iCj9QJvipyYjeEnxTwI0oSAJ369J9TuiMr5GLyqLm4VM0niEYLVhGm4QVX
         PAqTiuZPXrCMriRGGKrLeW8i9duBfMR/VZwyajnGkfClShweF/6ocyRhZoz7TZmqoxMU
         k3+dc+Px4l90x8Gxt1HeYwqUE778UMrKHrPjflqbpGZ01pKO4f2nAaCVjW1GDslo6D+L
         PyhNbxPHCLXOokSx2QVYpVO5DoKCGSwhJSFuwYTlo36qTrwuEsN7AnqovD3BwRUVCYfH
         KNLJZAvy7yi3+jxsFtJXte/1S9UVOeeoA1/bKnSnvTdGSSsLrxWMA6vW5lvWEFqSz7qp
         ydLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700851753; x=1701456553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiSRWT9NVEVchvdLGPLG5ZFEZReZtLSoIFrvmw6+vsw=;
        b=XOocl/Bjg6ipQf8ZJv4+zUrftCJO7xEQRJtnxYrMfGzonNhX4fV70sT8pZoP7FrBYy
         lftwFwDwGIlhT1YVCmoB3dzbKglqHTNDLDNgGXzkY57sjxEEz43g9EDnc6+LU08MG3BY
         hJEg8QXk7gb66tG3M61OD9kmnAJ3Lhtq+pqILKR2tqb3HMncxKMZl9/IOXJlHzhyuW9a
         VTIK6OotluNuXiy22LAXxpBMkDf7bvM61pfBHP3Sua0ygL8YVUcmghApqNLhx9s2iYL5
         FW/cTHuR3iLcR/1zKohovUBGv6ISQfPj+6EKtIrxiyb7F5A2SPNWoFoJde2JO+zSw/nf
         au0Q==
X-Gm-Message-State: AOJu0YyYW6WzXDyaNnjZEM/Ph54UnGAV13rz7vg6vGWU/arql4oUIvxX
        kgKGtoZSCY46GNsexKWe4mtYew==
X-Google-Smtp-Source: AGHT+IH/7VhrrVnbxV8VXRJ9x7d9t9tc+2zqsdI8xTo7/pgmhJa5TYoNStBNrMvPPUJooSzLq/R8+g==
X-Received: by 2002:a17:906:c9d8:b0:9fb:8ce2:251f with SMTP id hk24-20020a170906c9d800b009fb8ce2251fmr3056500ejb.47.1700851753377;
        Fri, 24 Nov 2023 10:49:13 -0800 (PST)
Received: from 1.. ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id lb16-20020a170907785000b009fda665860csm2376405ejc.22.2023.11.24.10.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 10:49:13 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     pratyush@kernel.org, michael@walle.cc, bagasdotme@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 2/2] docs: mtd: spi-nor: drop obsolete info
Date:   Fri, 24 Nov 2023 20:49:02 +0200
Message-Id: <20231124184902.1194235-3-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231124184902.1194235-1-tudor.ambarus@linaro.org>
References: <20231124184902.1194235-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3151; i=tudor.ambarus@linaro.org; h=from:subject; bh=itMGyyH1T9w7U818zcDk6jPfMPBSALBUakBUrmbmYcM=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBlYPAe3c37W5bT8Y+dDdeVYNeWXCQMGnHVXEfUK x4XHME5yfWJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZWDwHgAKCRBLVU9HpY0U 6Q/FB/95avdMdbTJ5vj8H47/ju59+qdJiBZGM6rkE0htbS+XCVnm4UWM1Sq42d2WBZI+cC+MGc6 +5RHNmttVVEP7mmjbwRpwrLKCCOKj0VN5LC5DJYxsCITZ84QGYhJktlblILo+okgC5wei8duBiK gK5uSS7gV0fD+vWjECAlPSUGIhvzwvMRv5F41IQ1r3svuRZLtv8A2uDLLJf1/N4s4Is5LG5NFlS rqMhgF746rDuKi5/V+1NUk+bqO2tRdk27C9CrdCAxraT8CNoxkVqSObn85AZGg/Odfwk9Afav52 gacTikzqYooSaBS3LO/TDHdb9cawWDvjM3Avmx2zb4bjoniz
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The architecture description is obsolete, it no longer applies to
the current SPI NOR framework state, remove it.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Michael Walle <michael@walle.cc>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 Documentation/driver-api/mtd/spi-nor.rst | 62 ------------------------
 1 file changed, 62 deletions(-)

diff --git a/Documentation/driver-api/mtd/spi-nor.rst b/Documentation/driver-api/mtd/spi-nor.rst
index 3b2e1a6a88bf..e28c8d226608 100644
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


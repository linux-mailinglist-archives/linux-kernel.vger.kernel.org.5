Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65A97F3F54
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 08:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjKVH4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 02:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjKVH4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 02:56:41 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0D1F9;
        Tue, 21 Nov 2023 23:56:34 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-548f35e6a4bso2682895a12.0;
        Tue, 21 Nov 2023 23:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700639793; x=1701244593; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=attY11h1h0WyAPvIDEa+1GfI5MENPYGUC68Kv+mgJhQ=;
        b=RMpQPW1eEolSNLkMF6y8u/eprUJtbsXwfMddiJ1l9HtaHXVdID0j5UHM6hBU6u10VG
         cZMO/10E/sGJ91/M1dNyvDVz6L6H2p8+v4tmxUIiu/lHg5eMWeHMwlVyp5BTFPTHAOrW
         nxw1Xq7ogjqwqZNsKDwPWnFR8wPWhXNyqp6O+F056woZP9QahTsu6RmCsOjwc6wqs0kj
         w03dMdBrlBJ43BbnjG7ljnHIF3xAxSzPMcyap6mYN0vmKEgLAgPP1qbimUChxbmfiE55
         3MiP4U7BnNotl3tI9QwhXVA+c3QPW1sRPvbQFprdtnW7o4pxXP7vLRr1UzHLScxArXBM
         6ryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700639793; x=1701244593;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=attY11h1h0WyAPvIDEa+1GfI5MENPYGUC68Kv+mgJhQ=;
        b=wW2EUZdlevW8mih0WZDarpaDlg5rBa0oywG1Cq59gzBEk63JAX/1ESDc6Shlg7aVkm
         QpeyDg3XMq7nYMnOCkpGtz7d56iI+km1nCHDUkSrlihtkviz8spRQU+bhO63Y14v3vVr
         WAXRMQzad31WbHOkrBWfFG8oHT9Q7ZbhiPdyMiLGD8uC7pV45oot1ZF4h20HdTKCiE8q
         SJOnCsbv9rE0Ts7daaKErPDchm/FK/K0aEzHYnhLW1Zf27yrrM3QPEMjy9DyySzLdLQx
         kdlxJYMEj5JHa54o9FHeZbROoH5XvxF3moS2Gs0XA4FUqgAiR/KWso9fnS0IY3i8h4yH
         vWOw==
X-Gm-Message-State: AOJu0YxAi85c9nkOku+BuTIhYddUbAq5cPpRgMI7zYKZWDwefSxLWyVv
        52IJTBFEAHcD+bFo1d4w3+c/Q6ByvwY=
X-Google-Smtp-Source: AGHT+IEPGHlnRfT09L3HfIp+efOFBDzs439D/D2xsJWkmd8DJAAiGKS74VLrvi2Xw8aACeQ53Dy3gg==
X-Received: by 2002:aa7:d3c6:0:b0:543:caf4:e5bc with SMTP id o6-20020aa7d3c6000000b00543caf4e5bcmr1235189edr.1.1700639792716;
        Tue, 21 Nov 2023 23:56:32 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:14bb:d13c:65e3:46bf])
        by smtp.gmail.com with ESMTPSA id b8-20020aa7dc08000000b00543597cd190sm5759456edu.47.2023.11.21.23.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 23:56:32 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Marius Cristea <marius.cristea@microchip.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: improve section MICROCHIP MCP3564 ADC DRIVER
Date:   Wed, 22 Nov 2023 08:56:29 +0100
Message-Id: <20231122075629.21411-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 33ec3e5fc1ea ("iio: adc: adding support for MCP3564 ADC") adds a new
iio driver and corresponding MAINTAINERS section. It however uses spaces
instead of a single tab for all the entries in that MAINTAINERS section.

Although, the get_maintainer.pl script handles spaces instead of tabs
silently, the MAINTAINERS will quickly get into a messy state with
different indentations throughout the file. So, the checkpatch.pl script
complains when spaces instead of a single tab are used.

Fix this recently added section using tabs instead of spaces.
Further, add the driver's ABI documentation file to this section as well.

Fixes: 33ec3e5fc1ea ("iio: adc: adding support for MCP3564 ADC")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 04c6fcbb21aa..c74ec0681aa1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14213,11 +14213,12 @@ F:	Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
 F:	drivers/regulator/mcp16502.c
 
 MICROCHIP MCP3564 ADC DRIVER
-M:      Marius Cristea <marius.cristea@microchip.com>
-L:      linux-iio@vger.kernel.org
-S:      Supported
-F:      Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
-F:      drivers/iio/adc/mcp3564.c
+M:	Marius Cristea <marius.cristea@microchip.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	Documentation/ABI/testing/sysfs-bus-iio-adc-mcp3564
+F:	Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
+F:	drivers/iio/adc/mcp3564.c
 
 MICROCHIP MCP3911 ADC DRIVER
 M:	Marcus Folkesson <marcus.folkesson@gmail.com>
-- 
2.17.1


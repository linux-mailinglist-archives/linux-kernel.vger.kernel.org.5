Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422AC781D6D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 12:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjHTK1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 06:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjHTK1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 06:27:17 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C842DE44;
        Sun, 20 Aug 2023 03:24:01 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9a828c920so37804491fa.1;
        Sun, 20 Aug 2023 03:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692527040; x=1693131840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofF4OkE+VMyWAryaiiXvyjCmG50j8vejVEK7ge5yAvY=;
        b=S2wEiqkf5lbLFXO1FwyxItwfTgk5sHIoQ1Pc9AXVl6LNvULQgATaiksxMs98klLUP3
         jHIqURxdqdTllqVBz5mQHxvoVRvPPw7dQdrC40tERMtasy1Cup9b6HOaezdF0Qbq6gCy
         3nBIQDZX4sr8apHHtnHE2DVCxT/u61X8RZVNEGYSVEPi5UywlpvDSn4J1wthk9uoE7iZ
         0BeSk7596hmjWxgRH33W/nVOUUOTewXTHIDg8QD6pI1qJnyuFZo8704Fd06vfPs9NdPM
         9ZEuag68uaO59Y/k6jFKx/kfurtcT55rAimQScqk6bCQTM9qUdjAdWRU4ZKDqqLcGft5
         qzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692527040; x=1693131840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofF4OkE+VMyWAryaiiXvyjCmG50j8vejVEK7ge5yAvY=;
        b=L7onXZsPNnBD0EwV3iXR1XsMizNJCL0nnL2YU7QgGOeQ/9FM8VzvI8RbOIr8N2WnEw
         fgmgp/6l8y+dDO2TrrKz8gnO5WmIL4qKH3jZnxmkIcP+fay4pP4w9NArx734fi/gVUuw
         7w9ubAVGOcG0uaSoMLFOKpvD79+V2Jyxy4dpcGu4FL//hyXjacbl/oh4gAYlXem9ILT7
         Z9YKceSq9+B5nLECEYffZt3XcFOjCp+fvSJY3R4YFzvWv8EYnIhIhEWJE/u+Inwb7z2A
         8sK/T8ZGgqlZPPRx4rGx+IBltEN+9aVu+zyClmlDeVSLrd+kUhZw9Y2Wm2aFpFMDTLga
         qVlA==
X-Gm-Message-State: AOJu0YwYl6mbn+kSjzP6TIF/npHcHEJEwSTW33Kap11h+HMe5Aw4wzNH
        YycyGO45t6HC2pjMAVpTXt0=
X-Google-Smtp-Source: AGHT+IGYrftofQzmlc1fVOzdBrerMPFlLXdyziCG51rFynQ0b7HxeDtyxI7UEPfOGiFkFWWiealo/g==
X-Received: by 2002:ac2:44cc:0:b0:4fb:89e3:5ac6 with SMTP id d12-20020ac244cc000000b004fb89e35ac6mr2158314lfm.62.1692527039943;
        Sun, 20 Aug 2023 03:23:59 -0700 (PDT)
Received: from localhost.localdomain (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id x2-20020ac25dc2000000b004ff9d22e486sm1193787lfq.226.2023.08.20.03.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 03:23:59 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 5/6] iio: adc: mcp3911: avoid ambiguity parameters in macros
Date:   Sun, 20 Aug 2023 12:26:09 +0200
Message-ID: <20230820102610.755188-6-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230820102610.755188-1-marcus.folkesson@gmail.com>
References: <20230820102610.755188-1-marcus.folkesson@gmail.com>
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

Name macro parameters after what they represent instead of 'x'
and make sure the evaluation of that will have no side effects.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v5:
        - New patch in this series
    v6:
        - change 'ch' to '(ch)'
    v7:
        - Reword commit message

 drivers/iio/adc/mcp3911.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index f9db08813645..281cc1211fd6 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -29,8 +29,8 @@
 #define MCP3911_REG_MOD			0x06
 #define MCP3911_REG_PHASE		0x07
 #define MCP3911_REG_GAIN		0x09
-#define MCP3911_GAIN_MASK(ch)		(GENMASK(2, 0) << 3 * ch)
-#define MCP3911_GAIN_VAL(ch, val)      ((val << 3 * ch) & MCP3911_GAIN_MASK(ch))
+#define MCP3911_GAIN_MASK(ch)		(GENMASK(2, 0) << 3 * (ch))
+#define MCP3911_GAIN_VAL(ch, val)      ((val << 3 * (ch)) & MCP3911_GAIN_MASK(ch))
 
 #define MCP3911_REG_STATUSCOM		0x0a
 #define MCP3911_STATUSCOM_DRHIZ		BIT(12)
@@ -51,8 +51,8 @@
 #define MCP3911_REG_GAINCAL_CH1		0x17
 #define MCP3911_REG_VREFCAL		0x1a
 
-#define MCP3911_CHANNEL(x)		(MCP3911_REG_CHANNEL0 + x * 3)
-#define MCP3911_OFFCAL(x)		(MCP3911_REG_OFFCAL_CH0 + x * 6)
+#define MCP3911_CHANNEL(ch)		(MCP3911_REG_CHANNEL0 + (ch) * 3)
+#define MCP3911_OFFCAL(ch)		(MCP3911_REG_OFFCAL_CH0 + (ch) * 6)
 
 /* Internal voltage reference in mV */
 #define MCP3911_INT_VREF_MV		1200
-- 
2.41.0


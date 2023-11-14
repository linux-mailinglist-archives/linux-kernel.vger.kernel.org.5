Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D467EB734
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 21:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjKNUGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 15:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbjKNUGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 15:06:18 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E694B11F;
        Tue, 14 Nov 2023 12:06:12 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9d10f94f70bso884807966b.3;
        Tue, 14 Nov 2023 12:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699992371; x=1700597171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7Mr2ZgTh2/vo8hRXNB8ZpBVrsMPOFq+JrIplGgPEZQ=;
        b=mLHje3qzOJtzf6X8BbyUeRFI5u10JuhtLRpbMlwkXcb4m9lP7O9UOzkcFtD6Rek5gA
         p89abIqwmHSQKr8oW4FRnj/eJ4iWqRXEp5MqQYsAPL9L5PA3fGdsZwvzIWYoXbjSvBxb
         MOBdG75EEx3XfWsZwB7Mv3WdXMopsJMd3MmwMUH6KIQSOEBOPirkpoZHN7HHCxElbuHJ
         zgCAKR7mEo4eCuu2aH+q7eVhq3PHf1qLv0mfDMzKzSrE8HY8WOxnjsQq/lCu7ctlSGkB
         ahI9EvHQIct05n5MHcDXVX8XbdsQUPYHYI5o8+zq6asENc1nxVUjF1lidB42AsTn2uUK
         REFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699992371; x=1700597171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7Mr2ZgTh2/vo8hRXNB8ZpBVrsMPOFq+JrIplGgPEZQ=;
        b=giAY/y2cibrcqBmenOQI/B7FqUWYw5n64/C91badmD3kPVhctKfewFPJrHCzFm3aKx
         Yac2sASLDYYZLP13TnGjenHZt/quSn4Mtl81TNjSpCfHcw/BoJVkF+7mzf7wovV3q8Fy
         BU9aOLMbQJ/hFiMj71jI6lpcYTjRcDM8on95XjlIdHsp4b7aDOc2RHPYK1lNtwVGLQSm
         8tb+cGWY4O0FcaPt1d+uA5VBt7wZSdFap4KW3/Bz3lg3xdWY2VLTeJuo/9WQYoC2FXBM
         5K4CxRvv1WmcKSRcIxfM8ocoX4DJvVPZb7z8xFkxCA3ixeJA0BPJOk3h/mnGnY0SfT8i
         K4Iw==
X-Gm-Message-State: AOJu0YxQi+a8bCOvmzEC3+WoIqUP8+t3dtyJMYdNafiA6aKEmBthhkIy
        3lJm6USQmBoDjP1c26GBvLR3PWGRxx0WxbM4duY=
X-Google-Smtp-Source: AGHT+IE2tak691DnNaPukHISODyxkOWNm3bwSIuhQwCzZQvTU7H+vTG6Q3hWxOVR6Y2wiN8yYL2KrA==
X-Received: by 2002:a17:906:3942:b0:9e3:b88c:d735 with SMTP id g2-20020a170906394200b009e3b88cd735mr7444263eje.61.1699992371281;
        Tue, 14 Nov 2023 12:06:11 -0800 (PST)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id me19-20020a170906aed300b009ae587ce133sm5984429ejb.188.2023.11.14.12.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 12:06:10 -0800 (PST)
From:   Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To:     Alisa-Dariana Roman <alisa.roman@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Hennerich <michael.hennerich@analog.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v2 1/4] dt-bindings: iio: adc: ad7192: Add properties
Date:   Tue, 14 Nov 2023 22:05:30 +0200
Message-Id: <20231114200533.137995-2-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114200533.137995-1-alisa.roman@analog.com>
References: <20231114200533.137995-1-alisa.roman@analog.com>
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

Document properties used for clock configuration.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7192.yaml        | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index 16def2985ab4..9b59d6eea368 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -80,6 +80,16 @@ properties:
       and when chop is disabled.
     type: boolean
 
+  adi,clock-xtal:
+    description: |
+      External crystal connected from MCLK1 to MCLK2.
+    type: boolean
+
+  adi,int-clock-output-enable:
+    description: |
+      Internal 4.92 MHz clock available on MCLK2 pin.
+    type: boolean
+
   bipolar:
     description: see Documentation/devicetree/bindings/iio/adc/adc.yaml
     type: boolean
-- 
2.34.1


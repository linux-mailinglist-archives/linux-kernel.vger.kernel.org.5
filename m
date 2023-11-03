Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328A57E0531
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjKCPCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbjKCPCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:02:16 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90DED5B;
        Fri,  3 Nov 2023 08:02:09 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32f7c44f6a7so1268640f8f.1;
        Fri, 03 Nov 2023 08:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699023728; x=1699628528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tesw7WKuyg4I4jCWy3z1Ub8ebMp3kejf48dRXp6MTM=;
        b=RQLZ7F/JDUxabwnOhNvmsMcLMvv17u8Qoc0fAFb/sYu1YsqjCUy1COEGFORDVq4KSj
         HmfDiNWp1fdwi5KoK10WnjQBsnFOc14kpnjy/0lDJ+jwgvnvN95RoM5AARiuQrBmvuyx
         AXnTljHewWEh3FMNUGFaXlUM6Ivxk2bAlBD1wC+xwSN2V3lFycSdtuBxSW5FlkKOz6T/
         0QDDd2NLS27pqMvCLd6KAf24DZXfR0Y29hLyiIbjBCOK3y9CqKXp0F/yqnQDRkU/DKzY
         E9AiMjO1xg26u5xL8MjjQw+/VG62I828pQF2f7v4/NTPyMEnot2tpBuBTJFtEE2UsG+e
         99nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699023728; x=1699628528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3tesw7WKuyg4I4jCWy3z1Ub8ebMp3kejf48dRXp6MTM=;
        b=apTbpEUCcJZEZIJPfcpCtssAjAoO1UFypmJZ1JeKzbFKEal3qMwCUqiqtW1GV2+GCC
         CaG9EHpou9o46UPQtfB43Yd2HlYi92ExqjE+D3WnSK4xA/Q5Cn+f+MLdsVE/HIjJhNbj
         6AQx97VO/WMydiktaz9Gm8QI0ihYwHB5U0+likbxuJcqtIlWVibyAehrbKBvtnYhR93z
         dLq3RX5PeHpDok/gij7jPc2UBBixXjKCoXEHu79fQij/JRjSaz46ig3md/cBWsSaYde7
         /aF13aBI5Pft2wiY4yoFuNRBImzeIX+dCCPpT6OV16V46U24NV1U1s/NaQYgeOkbm2+j
         W96A==
X-Gm-Message-State: AOJu0YwaPvFTKkMt1au/E8Yc3laFrEvpnXU0xy1KOWk8gte+4TJy0M7D
        5HUbBCO0bk7x1c8lzlQichk=
X-Google-Smtp-Source: AGHT+IGYJmn0gV8S7J6NV1x8m+VB7BIy070HHbi0x35h/8QukOdG0IVgcoYDKJzi05t13yd1h3RGFg==
X-Received: by 2002:a5d:62c9:0:b0:32d:baf4:e572 with SMTP id o9-20020a5d62c9000000b0032dbaf4e572mr15078197wrv.23.1699023728135;
        Fri, 03 Nov 2023 08:02:08 -0700 (PDT)
Received: from ubuntu.. ([188.24.51.27])
        by smtp.gmail.com with ESMTPSA id o8-20020a5d6848000000b0032f933556b8sm2077277wrw.7.2023.11.03.08.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 08:02:07 -0700 (PDT)
From:   Ana-Maria Cusco <anamaria.cuscoo@gmail.com>
To:     Ana-Maria Cusco <ana-maria.cusco@analog.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: iio: hmc425a: add entry for ADRF5740
Date:   Fri,  3 Nov 2023 17:01:30 +0200
Message-Id: <20231103150130.1090246-3-anamaria.cuscoo@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103150130.1090246-1-anamaria.cuscoo@gmail.com>
References: <20231103150130.1090246-1-anamaria.cuscoo@gmail.com>
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

From: Ana-Maria Cusco <ana-maria.cusco@analog.com>

The ADRF5740 is a silicon, 4-bit digital attenuator with 22 dB
attenuation control range in 2 dB steps.

Signed-off-by: Ana-Maria Cusco <ana-maria.cusco@analog.com>
---
 .../devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml       | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
index 2ee6080deac7..42341fbf8d74 100644
--- a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
+++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
@@ -18,12 +18,16 @@ description: |
   HMC540S 1 dB LSB Silicon MMIC 4-Bit Digital Positive Control Attenuator, 0.1 - 8 GHz
     https://www.analog.com/media/en/technical-documentation/data-sheets/hmc540s.pdf
 
+  ADRF5750 2 dB LSB, 4-Bit, Silicon Digital Attenuator, 10 MHz to 60 GHz
+    https://www.analog.com/media/en/technical-documentation/data-sheets/adrf5740.pdf
+
 
 properties:
   compatible:
     enum:
       - adi,hmc425a
       - adi,hmc540s
+      - adi,adrf5740
 
   vcc-supply: true
 
-- 
2.34.1


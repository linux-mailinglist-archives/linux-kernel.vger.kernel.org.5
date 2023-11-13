Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1957E9A44
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 11:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjKMK01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 05:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjKMK0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 05:26:24 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B638135;
        Mon, 13 Nov 2023 02:26:21 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5441305cbd1so6550450a12.2;
        Mon, 13 Nov 2023 02:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699871180; x=1700475980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkcBjw6N38nWpcH98Wo6zXUMJseV8oYDmiwD9ic+Q3E=;
        b=acRHr70QJM5KDZTyQBBD9pXNi7yJC2HVA7FswhERM6elk9wCP9DoKRcHDA2FCjFU87
         ueuV9qBzegcvzsl3C43i7mN26Qm/MzyE+2Jbh/mmWbv77+SOjZKnUASkORqU5PhGuVHL
         pKTt05W5hm22E9/a2bgnqcCOfxClHjLPt2MxMNdTzruUFQPN3nQkkRho06xrU8IqOt6V
         fehToEeFTcUoO1OfdDcQqp1xFzgN/E8tdX9id7Ly/dBYcRSdNIFSi3jqabxD4m1S5fuM
         x1ZLocKULFLIxCvEtHw/ZDz2YwL5kSJlrEVBvQo3xh9Ux9ldEt40mzX0pWxhpl/OjEEY
         iDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699871180; x=1700475980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkcBjw6N38nWpcH98Wo6zXUMJseV8oYDmiwD9ic+Q3E=;
        b=P8MdAxFm/s7E/hIYxm4gQtcybpHGsnNnMqDI6MQMJrzDfsjKSpJswkANv8BckQwHCu
         NI/rGyamOwjn34YRfLXH8rwuX9Nk8HQlwGX179FN5iJuyUUXNezJYL4twbLST+/zW9hM
         FqIGjWbHCsMWEMpZLoKzBornyZNjzlZVLboUQGax+kqVt7LPcgwYFKHsPDDKFj2v/adI
         PLfprdj+xX0sHq1wyGzdQAKyItrWjydRppdZrE2OpaYDnAMvTh4CbD9MHFSK0mGLO90U
         BDh8DBDzkjfpA9H/YgM1yqFKOxdV/aHRajZqT0x/ZpvT6KthlVI33VcwszMK6UdcBx4Y
         xrrQ==
X-Gm-Message-State: AOJu0YyeQO0bDVMonzU5Ix0YeIKRvAXRQTOUUsLmhYOm5y1igHez4mU1
        jlkB/ZghYwL1u6tmReJwkBM=
X-Google-Smtp-Source: AGHT+IGqMHl8CJUMaVmkecdE6R78s9cUlTa5VTP87qqME7+hLOPi1TAewDP0fF0bv9D3ef3BJ+pqvQ==
X-Received: by 2002:aa7:d449:0:b0:547:4d23:3b2 with SMTP id q9-20020aa7d449000000b005474d2303b2mr1406389edr.17.1699871179578;
        Mon, 13 Nov 2023 02:26:19 -0800 (PST)
Received: from ubuntu.. ([188.24.51.27])
        by smtp.gmail.com with ESMTPSA id r20-20020aa7cfd4000000b005435c317fedsm3464940edy.80.2023.11.13.02.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 02:26:19 -0800 (PST)
From:   Ana-Maria Cusco <anamaria.cuscoo@gmail.com>
To:     Ana-Maria Cusco <ana-maria.cusco@analog.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] dt-bindings: iio: hmc425a: add entry for ADRF5740 Attenuator
Date:   Mon, 13 Nov 2023 12:25:35 +0200
Message-Id: <20231113102535.51074-3-anamaria.cuscoo@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113102535.51074-1-anamaria.cuscoo@gmail.com>
References: <20231113102535.51074-1-anamaria.cuscoo@gmail.com>
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
index 2ee6080deac7..67de9d4e3a1d 100644
--- a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
+++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
@@ -12,6 +12,9 @@ maintainers:
 description: |
   Digital Step Attenuator IIO devices with gpio interface.
   Offer various frequency and attenuation ranges.
+  ADRF5750 2 dB LSB, 4-Bit, Silicon Digital Attenuator, 10 MHz to 60 GHz
+    https://www.analog.com/media/en/technical-documentation/data-sheets/adrf5740.pdf
+
   HMC425A 0.5 dB LSB GaAs MMIC 6-BIT DIGITAL POSITIVE CONTROL ATTENUATOR, 2.2 - 8.0 GHz
     https://www.analog.com/media/en/technical-documentation/data-sheets/hmc425A.pdf
 
@@ -22,6 +25,7 @@ description: |
 properties:
   compatible:
     enum:
+      - adi,adrf5740
       - adi,hmc425a
       - adi,hmc540s
 
-- 
2.34.1


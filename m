Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22C57C77A5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 22:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442786AbjJLUHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 16:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442408AbjJLUHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 16:07:17 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E400DB7;
        Thu, 12 Oct 2023 13:07:14 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32d3755214dso1344749f8f.0;
        Thu, 12 Oct 2023 13:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697141233; x=1697746033; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=844OlQadaEhHMSKbiHRWaU2MB0ZcHGDbo8z2G63xyiU=;
        b=Wgxv3GOrOY6H4LQvmZbgdQIJ/SgeihkMheDc9c1t70nC7TGFo9fyLzbfkuO3ldW29Q
         88q7/DSV1sGg8/ymfKUVKNG7t5NoekE5FSb7sCXF2dTnhiiRTaj9+7wCeu0eLAQUCosa
         2dNa7TaSqutqi9MciDkZpiHIgMHHkfsSnaCS6eOZKwzPshh9+3L3ZZJvgDaqv0JQiwah
         7CODyUs39Xgts62fZYNMXgSDqFJUa/qUC+VRff+/28OeLaO10Yn42V9XOarNyz9GErkC
         9T5gXStnqKake8XVhfoS8+yHBw+kdDFz+pA1fcfZn6LcqS7z0Q1ThTmz3ME+B4lRLtjl
         soAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697141233; x=1697746033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=844OlQadaEhHMSKbiHRWaU2MB0ZcHGDbo8z2G63xyiU=;
        b=bjhl7qtGSFMDTweCVtXj1etjUTh8uV/sWDVERpphBnPrLvTFI/sAZjX7huiatvgLIE
         G81EIyCtTPrAd6k7VuBL93xZlZl5W85Q3E9E+biqLKGRp5Pv9z4FoXSM61kQFC6OXE1g
         jWwd+zuEuKj1BmQU35IZHf2d95bPxXxBnznHVZhqOiY0jk9vk0w1OvAhL6mjepcR12wI
         dL8mk5y/GJjR7La02jKr0FJ5nKOEZhk83NX1nXsYTX98SsfeUNWkk64shjNfqNLbVIpA
         ms0N5mUwJ6suPwYm4oT5DNSLDq/vbgxV5mTTuyvhoa2tkreqP9om7VMp+j4Hp3XJ5qa0
         +aEw==
X-Gm-Message-State: AOJu0YyReyh6/dOxrF7iKH0lM3kZ/pdP2BSF213+XXUGGFecjmunH5Pk
        FHiHn1N5p2gXYl3xCBa62aYYq7C13nI32Q==
X-Google-Smtp-Source: AGHT+IHOGn/X5J+AWMRx7A5V5zQqemztxQ5iU67inudRawhkTjAESJa6IRgUrL4alprG9L8gzReigA==
X-Received: by 2002:adf:ee10:0:b0:317:393f:8633 with SMTP id y16-20020adfee10000000b00317393f8633mr21990772wrn.58.1697141232924;
        Thu, 12 Oct 2023 13:07:12 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-de42-73c9-6d1f-dd27.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:de42:73c9:6d1f:dd27])
        by smtp.gmail.com with ESMTPSA id p7-20020a056000018700b003217cbab88bsm182093wrx.16.2023.10.12.13.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:07:12 -0700 (PDT)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Thu, 12 Oct 2023 22:07:08 +0200
Subject: [PATCH 2/2] dt-bindings: trivial-devices: add silabs,si7005
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231012-topic-si7005_devicetree-v1-2-6c8a6fa7b3ec@gmail.com>
References: <20231012-topic-si7005_devicetree-v1-0-6c8a6fa7b3ec@gmail.com>
In-Reply-To: <20231012-topic-si7005_devicetree-v1-0-6c8a6fa7b3ec@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697141229; l=1043;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=2+Iyh8RVH9Y2roARFTNQ7lEeeGJEecebSRkJV3HqyTo=;
 b=vtYzfZQdHu33vVjqLjQBWU7nHVCR30V1nzT888DJEely7Y+Bida3p8nivZ1Zs5EQ2BtVJvDUZ
 oKRUSs5mh1zBpWb88sfmv5fRyrTgba7HCrYwLniU9mN/q1NGRXiSnYx
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This simple I2C humidity sensor does not have any additional properties
and can be added to the trivial-devices binding.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 430a814f64a5..05bf410ca9dd 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -348,6 +348,8 @@ properties:
             # Silicon Labs SI3210 Programmable CMOS SLIC/CODEC with SPI interface
           - silabs,si3210
             # Relative Humidity and Temperature Sensors
+          - silabs,si7005
+            # Relative Humidity and Temperature Sensors
           - silabs,si7020
             # Skyworks SKY81452: Six-Channel White LED Driver with Touch Panel Bias Supply
           - skyworks,sky81452

-- 
2.39.2


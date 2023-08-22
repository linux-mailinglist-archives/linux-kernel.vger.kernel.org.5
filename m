Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9E078391E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 07:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjHVFMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 01:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjHVFMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 01:12:21 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BD718B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 22:12:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-cf4cb742715so5066882276.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 22:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692681136; x=1693285936;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y49tMxZ0YY48F/gzN+18jldmFoxIYYQIj22aWek7pLI=;
        b=1E/HKtR80/j8Afv68qazxtHwIdlC3o7xyddICTzM9am/XQD3utYOsEZpa1EjyYxs7X
         6QunZdQhbX095QFgceSxbBSO7Kwiok6SN0zRgsJqDe/EkeP2PZJO1NrdUQkCpVpFmVxq
         I4QwWXy2PbMBKwyashnNcsvqJj6VZevXpnT9CM698beC6M2c3ybsA4sr5Vb+fvF+Zhzf
         ncM7TZKj7jqzX9g8moiTrZ9Rr4jp5u4mahGfZULheLQfDX4ymuuAiOftRkNNHYxRMRfy
         uXv6GtUWdXRMLTofeCHX8GmS1+mwQCONcLUah2TTPRm/E8B68E/aCZSvCclywrBfOkSy
         Mpig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692681136; x=1693285936;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y49tMxZ0YY48F/gzN+18jldmFoxIYYQIj22aWek7pLI=;
        b=UDMNGtT03Ms5VHPAYd9SCD/3u3KOfjgjrJXLvEQ9S2JBZLHHCpVMUp4e8A/c98c6hI
         MbxDu7nGO8uU1+9V+B4qT6x1Xt0sxylkoC6v0SojubwmWI2cvNokoSd6Aio5fLnTq663
         VJQ3+hSrgwfURsEkp1oqB+9i/4HRaP0GjZMj6Q27sKvIvprKsVzCZ9Eu2moyzQI+YGw5
         LcIuMW22l466WX8JbFUQewOBU7J9HriBjp8FRpKdWZ0Li+6wZq+T3iK8GW/4CFDezUBw
         SjbxAImiPEiZS1rH3AzP0Aa9Y6vZKDrfF94lHqwHWwKMhpUbWmzeBRGZhEMjUk+z3nJU
         PRpw==
X-Gm-Message-State: AOJu0YyXFbT5GxaFouPTjyi3R2l69KEEZyYyUW3GQiw2GamgW8wfEiBX
        dzAv/gyW2K5vALIFRAazObYgwCvKT6ybKfUCraY=
X-Google-Smtp-Source: AGHT+IEQs81Q4KusiC28vK3V6P5+x3LAR0lCRrupgbRgEYSKykvPJ/zIapXaq37u0upbNb5/Fn7lcB19OJKAD4QiRPM=
X-Received: from anikett.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:2551])
 (user=aniketmaurya job=sendgmr) by 2002:a05:6902:1894:b0:d12:d6e4:a08d with
 SMTP id cj20-20020a056902189400b00d12d6e4a08dmr85489ybb.7.1692681136473; Mon,
 21 Aug 2023 22:12:16 -0700 (PDT)
Date:   Tue, 22 Aug 2023 05:12:09 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230822051209.2837818-1-aniketmaurya@google.com>
Subject: [PATCH] dt-bindings: i3c: Fix description for assigned-address
From:   Aniket <aniketmaurya@google.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, joychakr@google.com,
        manugautam@google.com, Aniket <aniketmaurya@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

assigned-address is a valid property for I3C device with or without
static address. Fix the description and an example for the same.

Signed-off-by: Aniket <aniketmaurya@google.com>
---
 Documentation/devicetree/bindings/i3c/i3c.yaml | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/i3c/i3c.yaml b/Documentation/devicetree/bindings/i3c/i3c.yaml
index fdb4212149e7..ab69f4115de4 100644
--- a/Documentation/devicetree/bindings/i3c/i3c.yaml
+++ b/Documentation/devicetree/bindings/i3c/i3c.yaml
@@ -135,9 +135,10 @@ patternProperties:
         minimum: 0x1
         maximum: 0xff
         description: |
-          Dynamic address to be assigned to this device. This property is only
-          valid if the I3C device has a static address (first cell of the reg
-          property != 0).
+          Dynamic address to be assigned to this device. In case static address is
+          present (first cell of the reg property != 0), this address is assigned
+          through SETDASA. If static address is not present, this address is assigned
+          through SETNEWDA after assigning a temporary address via ENTDAA.
 
     required:
       - reg
@@ -163,12 +164,18 @@ examples:
             pagesize = <0x8>;
         };
 
-        /* I3C device with a static I2C address. */
+        /* I3C device with a static I2C address and assigned address. */
         thermal_sensor: sensor@68,39200144004 {
             reg = <0x68 0x392 0x144004>;
             assigned-address = <0xa>;
         };
 
+        /* I3C device with only assigned address. */
+        pressure_sensor: sensor@0,39200124004 {
+            reg = <0x0 0x392 0x124000>;
+            assigned-address = <0xc>;
+        };
+
         /*
          * I3C device without a static I2C address but requiring
          * resources described in the DT.
-- 
2.42.0.rc1.204.g551eb34607-goog


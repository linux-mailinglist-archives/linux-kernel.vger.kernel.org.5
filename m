Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2667980E526
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345975AbjLLHyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 02:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345949AbjLLHyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 02:54:02 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E179B8;
        Mon, 11 Dec 2023 23:54:05 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-286d6c95b8cso5240088a91.0;
        Mon, 11 Dec 2023 23:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702367645; x=1702972445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pzU9Yc3xVoAF9cxNzwOqU7U+458n+BSBqv++lU30Lio=;
        b=HytxYWmFZWsCHn1biVOKMHdY5Xi22Sxnptk+y3zj1zujwgwuOyGbTfWOsjhnY99rsa
         1qILqPVlehutf6WmjMbwt89kzHpf4ovAOOn90+aNoeihiSWdUecnSbjjr2E2gbTHFc4Z
         8a+aKsrRNrU5Ww+HZfK7BViyGFszlzqa0eQoXOIk6K2bsuO6Tg+cVDOHi/OY4eR497ts
         FS53mzyx9hCkVGTNrWAlALTe7zzT5dckCINgMKmhecrlNtlVHDKAIMbBxSPL0737gLcB
         PKwmrjam1viSteCfJsj/IEyYqBPY+aQPMco3mgG5+CPrzJCzUBvab1AX8t+2/ZTNKGEc
         OA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702367645; x=1702972445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pzU9Yc3xVoAF9cxNzwOqU7U+458n+BSBqv++lU30Lio=;
        b=rCdzIp9b03ah25t8VJ5DA+ShqQwOCu+l+KYz2H197/h6vrcKxnUfpoC1MxykUbGP4L
         jq1fzSX7/fhBfCsBcGNRzuabcmJjUwqaOEbwoGcXTK2K6Lyrdo+i6vOwVqcipm24CRm5
         G+mjmJwfh/pCtch0MPh4k3MwWPsKaqSVSJqfKrX487JP+Fjn1k+/cmj9dFV5EMiBgj8H
         GCHJS/G/QdmKv5DXvd7QKw+y9TP4sS2UDxO1ZNNkLavojF6DcnYpnnV3bYEG7QUEvO/k
         fV/wOjnwGK96QgZ8p7xOG4/sQDbV93ZRXZcMLfJHdISoTscLg73+3JJP9Em3OEFe+6jA
         TnJQ==
X-Gm-Message-State: AOJu0Yyu4oSWfo8B3DJggIb1eUmefmdya0yDGqUsdaNMnzL6CkwFmdrt
        SYr+sKA1F6/e/IXbNWcuF+Y=
X-Google-Smtp-Source: AGHT+IF9QOtT9bgf09S0s6FLsU+B+rMIlxmiXzYlaVAex8M5R6qkgptzQp6LAgFBgT4dpzbLPq47gw==
X-Received: by 2002:a17:90a:ac07:b0:28a:ad8c:c122 with SMTP id o7-20020a17090aac0700b0028aad8cc122mr1441251pjq.40.1702367644848;
        Mon, 11 Dec 2023 23:54:04 -0800 (PST)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id qi9-20020a17090b274900b0028a28ad810csm8144319pjb.56.2023.12.11.23.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 23:54:04 -0800 (PST)
From:   Yang Chen <yangchen.openbmc@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        patrick@stwcx.xyz, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Jerry.Lin@quantatw.com, EasonChen1@quantatw.com,
        Leslie.Tong@quantatw.com, yangchen.openbmc@gmail.com
Subject: [PATCH 00/11] Modify DTS of META Minerva CMM BMC(AST2600)
Date:   Tue, 12 Dec 2023 15:51:49 +0800
Message-Id: <20231212075200.983536-1-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This series modifies the DTS of the Minerva CMM which is the board on the
META platform that uses the ASPEED SoC(AST2600).

Changelog:
- v1:
    - Rename the name of the DTS from aspeed-bmc-facebook-minerva-cmc.dts
      to aspeed-bmc-facebook-minerva.dts.
    - Revise the setting of the mac3.
    - Change the sgpio use from sgpiom1 to sgpiom0.
    - Enable power monitor device (INA230 and LTC2945) on the i2c bus 0.
    - Add one temperature sensor on the i2c bus 1.
    - Correct the address of the eeprom on the i2c bus 1.
    - Add bus labels and aliases for the Fan Controller Board connect to
      the i2c-mux on the i2c bus 2.
    - Add led of the fan for the fan fault.
    - Name the gpio and the sgpio.

Yang Chen (11):
  ARM: dts: aspeed: minerva: Revise the name of DTS
  ARM: dts: aspeed: minerva: Modify mac3 setting
  ARM: dts: aspeed: minerva: Change sgpio use
  ARM: dts: aspeed: minerva: Enable power monitor device
  ARM: dts: aspeed: minerva: Add temperature sensor
  ARM: dts: aspeed: minerva: correct the address of eeprom
  ARM: dts: aspeed: minerva: add bus labels and aliases
  ARM: dts: aspeed: minerva: add fan rpm controller
  ARM: dts: aspeed: minerva: Add led-fan-fault gpio
  ARM: dts: aspeed: minerva: add gpio line name
  ARM: dts: aspeed: minerva: add sgpio line name

 arch/arm/boot/dts/aspeed/Makefile             |   2 +-
 .../aspeed-bmc-facebook-minerva-cmc.dts       | 265 ---------
 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 543 ++++++++++++++++++
 3 files changed, 544 insertions(+), 266 deletions(-)
 delete mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts

-- 
2.34.1


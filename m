Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E585B802B62
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 06:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjLDFnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 00:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLDFn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 00:43:29 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C570DB3;
        Sun,  3 Dec 2023 21:43:35 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b844357f7cso2119470b6e.1;
        Sun, 03 Dec 2023 21:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701668615; x=1702273415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dcCMUyyydpcNnF03FcPhsepyrQYojahu/1jDYu378E4=;
        b=ioOq0roh4vdzks82oR86zFyp2soQ2PlfcvBqiMxJSUIrxJFFQ/nLIu8cuBr9ehupvr
         WjXelAD2n7y+sA5lEj645XmzTVhm8G/dEa7/bOGMaAL5L/zVGbGRY2G/4VBEXh2938YO
         PGqiy6fzso++dsmp13XUNWTNGSArej7k3VRhWIPH1JsPN3AVka3VfkbfylltSbGPhsip
         YMRc7mbdTG8kMpG9pyZrCVzTNeNMYabHCO34vzwi1U0VKnGayk9dUX9LuX+I8gzk+L/+
         OjsaH3uqLf+lp3mG1GwyyvFjZdb0l8xU3hL561qPY3rr/9eRHHI92rktY94vsLBziefD
         MuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701668615; x=1702273415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcCMUyyydpcNnF03FcPhsepyrQYojahu/1jDYu378E4=;
        b=utMAppJ2cZ/x1XRPkU+0uaCpzeyiGa7aL/YWf9LQmoq+hTKi9XUyneJ8bCvvxN5WAA
         wVarCIKhOt7qGhnKD3nYipv20q5+0+QfHzjxtMJLdkbfx49WKG1H3CCdhWg4ZwPXQ1ID
         vItX8fJvGCh2KenT91ybo2zVEgq3VowLvCzjahjgXQNExSIk2jvcbZZCZQAn7tJ4PyoJ
         XayV+vRA0xC4VIDYD5q5TbbQzCtqfZmDeHmT0zaQJsfH1tD8l6gAwkafAdg+wOqsHh87
         gDoVqAyC1vQDxVvkAS2vKtjvmD1dD17l5wbm+JpIhL1z32dnBe3OCqe0fZrQvwm0LL55
         /K5g==
X-Gm-Message-State: AOJu0YynUFdHzXcFQ8HDu3qibtfp6g1ZL/rsoLP3kUqcznhTpi/6G8F2
        VUETVxg2znaPnT6AEFDHk4Q=
X-Google-Smtp-Source: AGHT+IFTOzBkVsPxCRaAgiG/sz4j3LTI9aTnCdfxa2sXDtV2sN9jZzX/bAv4WhcKefI3AGAPnJCNqw==
X-Received: by 2002:a05:6808:128f:b0:3b8:b2cf:3106 with SMTP id a15-20020a056808128f00b003b8b2cf3106mr3844218oiw.25.1701668614921;
        Sun, 03 Dec 2023 21:43:34 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id b24-20020aa78718000000b006cb60b188basm6706655pfo.206.2023.12.03.21.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 21:43:34 -0800 (PST)
From:   Peter Yin <peteryin.openbmc@gmail.com>
X-Google-Original-From: Peter Yin <peter.yin@quantatw.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] Add Facebook Minerva Harma (AST2600) BMC
Date:   Mon,  4 Dec 2023 13:41:29 +0800
Message-Id: <20231204054131.1845775-1-peter.yin@quantatw.com>
X-Mailer: git-send-email 2.25.1
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

From: Peter Yin <peteryin.openbmc@gmail.com>

Summary:
Add linux device tree entry related to Minerva Harma
specific devices connected to BMC SoC.

v3:https://lore.kernel.org/all/20231123050415.3441429-3-peteryin.openbmc@gmail.com/
v2:https://lore.kernel.org/all/cdbc75b9-3be1-4017-9bee-c8f161b6843c@linaro.org/
v1:https://lore.kernel.org/all/20231024082404.735843-3-peteryin.openbmc@gmail.com/

Change log
v3 -> v4
  - Add SGPIO line name

v2 -> v3:
  - Fixed led schema
  - Fixed i2c mux schema
  - Add BMC_READY and SGPIO_READY

v1 -> v2:
  - Add Power sensors
  - Modify ehci number
  - Add Led
  - Modify SGPIO line-name
v1:
  - Create minerva harma dts file.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
Peter Yin (2):
  dt-bindings: arm: aspeed: add Meta Minerva Harma board
  ARM: dts: aspeed: Minerva Harma: Add Facebook Minerva Harma (AST2600)
    BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 595 ++++++++++++++++++
 3 files changed, 597 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts

-- 
2.25.1


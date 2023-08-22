Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A86783DDF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbjHVK1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbjHVK1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:27:46 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1EECC7;
        Tue, 22 Aug 2023 03:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1692700065;
  x=1724236065;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=WDt0bx6LiVXGKVc4xF/60SMvFuft506gwIf5jppItDg=;
  b=YW9lD2a9KYgEO4r1lDm7tEEhA4v7nz9sUHByBmnueuintyIRkphB+JoO
   tNVtsuhhpyZJ+qLwz9GSUgMew5dDE4PaGCFmNE4i6NEYcxjUmpoBqEQrK
   nwSoeCb2LguyTi4F33ayTj0cS6toIKoqljdH7cot98yFTcuDbRH6OiHBW
   j1zJ7Q2uWl2M0+hyrbHS46YHURtQvJ+m1VulxptT6aZ3zMtJEGsefBFzl
   06qpJ8uKOj+APQH8qv5URGlBMX3Ee6BPUUYUEyACTcku7nrS/E+qhgVNz
   w5bVxEJYsj8HneR8EGZDOE9BLT+kkHogr8UeY9xrhDtrCFu13IPp+U+VQ
   g==;
References: <cover.1692699931.git.waqar.hameed@axis.com>
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <kernel@axis.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: rtc: Add Epson RX8111
In-Reply-To: <cover.1692699931.git.waqar.hameed@axis.com>
Date:   Tue, 22 Aug 2023 12:25:31 +0200
Message-ID: <903c1e05804535f212fa128425326b7554c0794a.1692699931.git.waqar.hameed@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Epson RX8111 is an RTC with timestamp functionality. Add devicetree
bindings requiring the compatible string and I2C slave address (reg)
through `trivial-rtc.yaml`.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 Documentation/devicetree/bindings/rtc/trivial-rtc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
index 9af77f21bb7f..b0c07f734f14 100644
--- a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
@@ -38,6 +38,7 @@ properties:
       - epson,rx8025
       - epson,rx8035
       # I2C-BUS INTERFACE REAL TIME CLOCK MODULE with Battery Backed RAM
+      - epson,rx8111
       - epson,rx8571
       # I2C-BUS INTERFACE REAL TIME CLOCK MODULE
       - epson,rx8581
-- 
2.30.2


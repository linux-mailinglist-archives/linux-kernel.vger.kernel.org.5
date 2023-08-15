Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944A077D0F3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 19:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238851AbjHORY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 13:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238910AbjHORYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:24:45 -0400
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de [IPv6:2a01:238:400:200::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EC81BE7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 10:24:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1692120071; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=X/W//n+oIDXwP24aQCajDWRkR8EaNQzo8HPdxiewOD93pM76O80O5bJDV8mIaIcvIU
    1BhxEDyM3cfmFfASOqIbvFLpLqAHEq++27kWpj4YfJ2p749UKZhPRNJZxQqpgbrw9eh4
    Bu+FlVGhLtGFVM0ReUk1+V7TpDgl/Wk83psgMScsFnDY/F3lSaG96D2sDRmI2OWtHEpy
    M4nva9XgRWu/Souj00Q/DBoDfWOIf0eFKwxmOnVFM77qv9AScUuAygA/F1SERRO6Ltp0
    1LRyvdMk0n5HnoIPenoJQXla+wgckKSW0Dn40JFmkHRwkvloStqoE7LJfDDLrtfob4l3
    vIwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1692120071;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=1y3uip8c91UxGExgmxopFORpxxWi73kggoj9Qtq5UlQ=;
    b=RVFwW2FWtBhe3iwA7nm/jBl/HzkLUVgow+JBB+sxWD2E4Y1mQ6MT3Jd12cYl88JXlA
    DC2SEvGzsecCUK3I8qQ/wBn7kYIO/v4AsiuO4PKJzuNdJSJAoym8fnrx6paovqNBWWbp
    Sz/DjX6mp1HLQq4KEN8hxVCTvQUA3K2uIMKOQeNzwmsEohBqfNQyQ4yDguxOf7Aj2gcW
    h5yGsxIbVdcCCK/6KhSq5FjMJoyzGB5+KDjdc51+7MVSDv9TVI8iw+9Y+rWBoXthgJ74
    bJfHaeI9FfLXfqi8OROygm0stTiu7boe0AWiYhgq+YdsfMDP5nZ8/rVRM4wV02kfloJK
    8EiA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1692120071;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=1y3uip8c91UxGExgmxopFORpxxWi73kggoj9Qtq5UlQ=;
    b=KlOemiN3xYvrN0PlZn9tS7HONcokHHY+e6SsizLCx/agx+UZS+AUUIkmOGQClassPt
    JrkcyazqGbn4spKVbzNZll/kcfxkFtevjpvIIo0SMqow7SiKU0/auTk9Wcd74Y3Bijbg
    OK1ko4XzCapP9rZ9cjeKI2YmklCmXe1aKLrw6QdWisQqSKnXetRZp+DHsTIM5GZzrbsC
    SWzsmzuSnK/h/bR7Tmzlkww9AVeryc5+XK06QfCFgHHHySNoyg6V30fcpiCE7cvvD5S4
    BJumkGuuptKo1LaNVE+OGyiTGA+VSpiAjon/rA8JTDUSMXkYYy3n3Vlbfh0u5yGMavA6
    mNoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1692120071;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=1y3uip8c91UxGExgmxopFORpxxWi73kggoj9Qtq5UlQ=;
    b=8izbNucmkFktrZiJxRHhEgg/alqb0g1BuuQ0aWNGBUhvbnNXR6WJfGrHYkkLkzi1Xf
    Y6DooZTFP0dxKVJ7GQDQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4F1mw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.0 DYNA|AUTH)
    with ESMTPSA id v41b8bz7FHLB0YT
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 15 Aug 2023 19:21:11 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v3 0/3] leds: aw2013: Document interrupt and pull-up supply
Date:   Tue, 15 Aug 2023 19:21:03 +0200
Message-Id: <20230815-aw2013-vio-v3-0-2505296b0856@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP+z22QC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDI2MDC0NT3cRyIwNDY92yzHxdS6NEE1Mzs2RTCzNjJaCGgqLUtMwKsGHRsbW
 1AIxHDXpcAAAA
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nikita Travkin <nikita@trvn.ru>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AW2013 has an optional interrupt pin "INTN" which is used to report 
completion of started operations (e.g. power up or LED breath effects). 
The driver does not use it (yet) but it should be already described for 
completeness inside the DT schema.

Since the interrupt and I2C lines operate in open drain low active mode 
a pull-up supply is needed for correct operation. Unfortunately there 
is no ideal place to describe it in the DT: The pull-up needed for the 
I2C lines could be described on the I2C bus. However, the pull-up 
needed for the interrupt line belongs neither directly to the interrupt 
controller nor to AW2013. Since the AW2013 driver will be typically in 
control of the power management and interrupt masking it makes more 
sense to describe it inside the AW2013 device tree node.

Changes in v3:
  - Rewrite commit messages based on discussion on v2
  - Also document missing interrupt in DT schema (new patch)

Discussion on v2:
https://lore.kernel.org/linux-leds/20230321220825.GA1685482-robh@kernel.org/

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Lin, Meng-Bo (1):
      leds: aw2013: Enable pull-up supply for interrupt and I2C

Stephan Gerhold (2):
      dt-bindings: leds: aw2013: Document interrupt
      dt-bindings: leds: Document pull-up supply for interrupt and I2C

 .../devicetree/bindings/leds/leds-aw2013.yaml      | 13 ++++++++
 drivers/leds/leds-aw2013.c                         | 36 +++++++++++++---------
 2 files changed, 35 insertions(+), 14 deletions(-)
---
base-commit: 841165267827955bb3295b066cb6a906ba9265c0
change-id: 20230815-aw2013-vio-92a4566c5863

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>


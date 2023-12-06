Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E29D807B39
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 23:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377409AbjLFWQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 17:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjLFWQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 17:16:04 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEC3DE;
        Wed,  6 Dec 2023 14:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1701900964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=A+HKMjX23gsN6vSBJGJR0lhigHyqUNulJJzH3y7+qeI=;
        b=GjHJSw4QqikTVX9VTsSIr0ynJMtQL1dCaUU4q9y3KL/SsCq5kMlMGHjprah7eWdT3Gyriv
        YwOCShGwxcq41njwcHhLLfIIOlV8UU3b4l6aYeesZGW5j/WWmuZPHW88H0p4dKBOg30gzR
        uU8PhcA/nietXDFz8cVQsCjj3bTL1t0=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/3] ARM: dts: samsung: exynos4210-i9100 updates
Date:   Wed,  6 Dec 2023 23:15:53 +0100
Message-ID: <20231206221556.15348-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof / Rob,

Here a small patchset with a fix and some improvements to the DTS for
the Galaxy S2 (aka. i9100) phone.

The first patch unconditionally enables a regulator, which seems to be
needed for the phone to boot properly. I do not know what it is
connected to.

The last two patches add nodes for the touch keys and the accelerometer.

This patchset is based on linux-next-20231206.

Cheers,
-Paul.

Paul Cercueil (3):
  ARM: dts: samsung: exynos4210-i9100: Unconditionally enable LDO12
  ARM: dts: samsung: exynos4210-i9100: Add node for touch keys
  ARM: dts: samsung: exynos4210-i9100: Add accelerometer node

 .../arm/boot/dts/samsung/exynos4210-i9100.dts | 48 ++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

-- 
2.42.0


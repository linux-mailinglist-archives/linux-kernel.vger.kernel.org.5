Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE31779E276
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239042AbjIMIpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239043AbjIMIpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:45:10 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466301996
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:45:06 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bf57366ccdso5173285ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694594706; x=1695199506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fmv+Vq9O4hXwTu7w7+aDs70zSlTsq1mhjzn706AuHTQ=;
        b=QCIu2r1souu0AYvTviONV5pbNEMpx1sBK2Kjgx9HIvjr0TZpVty4NhPcJpYSQ8nf/y
         l46dEyQ/j4aoxsw0EIVFbYCVzKEgJt/emQEp2auZdL8jXUgE+7DIeIa2xO0LzJiub/rm
         hxnzQKv6khzyUhBof1TwqLCLMqfeqSspsAK/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694594706; x=1695199506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fmv+Vq9O4hXwTu7w7+aDs70zSlTsq1mhjzn706AuHTQ=;
        b=kAVke6bFvu1fBf/Rr/2nQwvQBcGn+z8ww0FsHGnjs6+ucTphKBp+EnrgsBtAvZsJHz
         nH8aCxfM8D2kZEbbdh6nNKdvOyCBpoKh1eeRZ2rnwz0S3WCcl4CqbXzAodR6yRYhyZ+n
         X/qgQzHvaht8Cw3EpTgInlahjMVaIeG98JM+nXFS9bxCQxM+FoG+1N7XA/rKuA7tINz5
         B1//B0BxCxx9FyxIfDL5mz+c/zRmV2HPPRPE1mfO8h/5e/ZbpciPHhkQPAixOHOKAFDP
         OM1CvhUzmJ+s1tBiPTM0TYPX9FFYsU5xJ8okuuRtLY2stLh0T62ou27BXnFau7mGNLYR
         kWlA==
X-Gm-Message-State: AOJu0YxzxcFFxWMI5OrKSSRylDiSmpYQdz0d77KyuZhoifAOYfCtzbCs
        dwcXikSI0B6MtXhuCLFxvAZlnF9GVQpKolGPaec=
X-Google-Smtp-Source: AGHT+IHtNFXdsXeRgSBZ865ZiAFdvUqy3I7+Xn/nQQMz7UYCXtRlSZT4eYOTpH2V4RjuYLt2yqB71A==
X-Received: by 2002:a17:90b:1e10:b0:26f:6f2a:a11 with SMTP id pg16-20020a17090b1e1000b0026f6f2a0a11mr3049931pjb.12.1694594705782;
        Wed, 13 Sep 2023 01:45:05 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:b24c:3be4:d952:d3b1])
        by smtp.gmail.com with ESMTPSA id p8-20020a17090a74c800b0027360359b70sm937099pjl.48.2023.09.13.01.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 01:45:05 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3] arm64: dts: mediatek: mt6358: Merge ldo_vcn33_* regulators
Date:   Wed, 13 Sep 2023 16:44:56 +0800
Message-ID: <20230913084457.1638690-1-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ldo_vcn33_bt and ldo_vcn33_wifi regulators are actually the same
regulator, having the same voltage setting and output pin. There are
simply two enable bits that are ORed together to enable the regulator.

Having two regulators representing the same output pin is misleading
from a design matching standpoint, and also error-prone in driver
implementations.

Now that the bindings have these two merged, merge them in the device
tree as well. Neither vcn33 regulators are referenced in upstream
device trees. As far as hardware designs go, none of the Chromebooks
using MT8183 w/ MT6358 use this output.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
This was part of the series "regulator: mt6358: Remove bogus regulators
and improvements". Since the driver parts related to this patch have all
been picked up, so I'm sending this separately.

 arch/arm64/boot/dts/mediatek/mt6358.dtsi | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6358.dtsi b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
index 96ba8490b629..ad5e4022e06d 100644
--- a/arch/arm64/boot/dts/mediatek/mt6358.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
@@ -292,15 +292,8 @@ mt6358_vrf18_reg: ldo_vrf18 {
 				regulator-enable-ramp-delay = <120>;
 			};
 
-			mt6358_vcn33_bt_reg: ldo_vcn33_bt {
-				regulator-name = "vcn33_bt";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3500000>;
-				regulator-enable-ramp-delay = <270>;
-			};
-
-			mt6358_vcn33_wifi_reg: ldo_vcn33_wifi {
-				regulator-name = "vcn33_wifi";
+			mt6358_vcn33_reg: ldo_vcn33 {
+				regulator-name = "vcn33";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3500000>;
 				regulator-enable-ramp-delay = <270>;
-- 
2.42.0.283.g2d96d420d3-goog


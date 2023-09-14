Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B837A009F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbjINJqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjINJqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:46:00 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289E8EB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 02:45:56 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5009d4a4897so1299883e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 02:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1694684754; x=1695289554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E7ZJS7sdRoRRRFWMj7zQxb45/LmVE5dZcYckff9SE60=;
        b=w8T+yCOI7KA4ub4gTbuO5LlaxcmLPW3AbXZHcii6XGbrDLSwAHGS9b28PK3EBj1/zE
         lTTquETWgywhc4XCnqfxiTEBAPsGtDKCbQ0ZN//vvrn6d2M7v9I6sWdWIBtAMzVdX8Vg
         gX8PG5iKVZ4T9C4Rda3ixtWoRcAAzA/R6FqTHdzIlHe+b8ixUTdeuto37ZtLUdSat477
         z1N8QSBHkb59V/lX0YbsijwGfHRid6HYot67rtW42vN4W7DfGJ02rMYh0/khqWOkyP+a
         p4cXUMUFLx/h+zsIlmWGgC51wT9wEeq6gVIeE3pLw3frHPXpUNz91Pm4Wd4rotN90Z5o
         3rWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694684754; x=1695289554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E7ZJS7sdRoRRRFWMj7zQxb45/LmVE5dZcYckff9SE60=;
        b=B5dJl20uh5guyRuHDpbPaM5jqt3s9tdOSwV+3QNTPwcMBdge5tCMyFlI7a79yfRu9i
         HNT/YxPAaIlb9vyYNFHQo4++DVOv+DuzyXQ+sHSZShNoDTrWoYYfTSJx1UE4EeRPvVl1
         mvAV+YU9ff22lsi/LNo4vtxW+lFLmUHgAMcCViwPH1FIKTzICdvOnFIGLDhxD1qXc9SW
         TFRmjnd25WDwcC4VZgjiGylnXIvNwaEUq0YLLPZD85slIeHM+aH3bg9Rcq17PcXm3VQE
         VDIuaJJfAtJ5ktBMse7Vl4iLo+VnbJjOjX2Mb6SpkpiZ4dRZMz5Iywgr8S9/WKdkrIFb
         2HQA==
X-Gm-Message-State: AOJu0YzPLO4SaHJ/zK7APqbBKFGdjTHpgH1C+CpnMUQPJKTfXl3dpXsS
        87lngoOHrdWwojy0OD8UvLjvCw==
X-Google-Smtp-Source: AGHT+IHSgul+kLrJPi7KVcBBip8N6s20VQqyBuiCm2/3Tvx45VXiObBiCIa3Y7CQVbs50y5JTgmjXg==
X-Received: by 2002:a05:6512:530:b0:4fb:772a:af12 with SMTP id o16-20020a056512053000b004fb772aaf12mr3871076lfc.21.1694684754247;
        Thu, 14 Sep 2023 02:45:54 -0700 (PDT)
Received: from fedora.. (dh207-96-100.xnet.hr. [88.207.96.100])
        by smtp.googlemail.com with ESMTPSA id e10-20020a50ec8a000000b0052565298bedsm690790edr.34.2023.09.14.02.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 02:45:53 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 1/2] arm64: dts: marvell: uDPU: rename the SFP GPIO properties
Date:   Thu, 14 Sep 2023 11:45:00 +0200
Message-ID: <20230914094550.1519097-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the GPIO related SFP properties to include the preffered -gpios
suffix as defined in the SFP schema.

This fixes the following warning:
arch/arm64/boot/dts/marvell/armada-3720-eDPU.dtb: sfp-eth1: 'los-gpio', 'mod-def0-gpio', 'tx-disable-gpio', 'tx-fault-gpio' do not match any of the regexes: 'pinctrl-[0-9]+'
from schema $id: http://devicetree.org/schemas/net/sff,sfp.yaml#

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi
index 3f79923376fb..3a9b6907185d 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi
@@ -61,10 +61,10 @@ led-alarm2 {
 	sfp_eth1: sfp-eth1 {
 		compatible = "sff,sfp";
 		i2c-bus = <&i2c1>;
-		los-gpio = <&gpiosb 7 GPIO_ACTIVE_HIGH>;
-		mod-def0-gpio = <&gpiosb 8 GPIO_ACTIVE_LOW>;
-		tx-disable-gpio = <&gpiosb 9 GPIO_ACTIVE_HIGH>;
-		tx-fault-gpio = <&gpiosb 10 GPIO_ACTIVE_HIGH>;
+		los-gpios = <&gpiosb 7 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&gpiosb 8 GPIO_ACTIVE_LOW>;
+		tx-disable-gpios = <&gpiosb 9 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpios = <&gpiosb 10 GPIO_ACTIVE_HIGH>;
 		maximum-power-milliwatt = <3000>;
 	};
 };
-- 
2.41.0


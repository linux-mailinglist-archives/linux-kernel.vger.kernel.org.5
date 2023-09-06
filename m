Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059BD793751
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbjIFIqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbjIFIqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:46:33 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A52F184
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 01:46:29 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5008d16cc36so5672785e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 01:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693989988; x=1694594788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pFyXU1rJoAdSg8rduev/f2O+iNJ9XIMyhvTB2QMlwI0=;
        b=ca92yBo0mmVbAENl12Y4OfeBEV2YYjMA8YCNC1XJU6OR6DC9y029f42nvAOBR8BAQQ
         Zb142upYUSBkunSI1hLqyPQo85MREKFQmxl+D/IZoQuSP4IM3hyQjLbvOgRjST4l0dSI
         caZPwnvmQM/n9m8JjCqieuErxBpEat8PLZZNhOdujwcoud7nRvzNGdanG8tzSvMeHMFO
         IcM23ItgDWgJAMF9oc53omii6BaG/pWdHjI6H011qYxlwfgPQsFoFhhy0o5nZOYyfYKu
         lWqAQ7ffIPcI8dP/xfonS4NiBVTarz9w/hRxehVozHNSZdXCv+tSJUp2RldMBKsfhGdb
         Uykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693989988; x=1694594788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pFyXU1rJoAdSg8rduev/f2O+iNJ9XIMyhvTB2QMlwI0=;
        b=CvmdhM+/hfYKK0sr2G7becItyOnVby5aSAPUj8ZYIPPc1Qbs/uqZSYWIn/3kWB4EQ9
         9B6nND0PV54m0gGy/hMjmPEy7Z49gUkv3LatlXFht+3vnV0AcMTLh9LpqHxeZG29RdFu
         skuNr+cRwJihUkSH5dik9ss8EwGNyLV8frRYej2RAB0SoNNVQXIPieHS4YH6zNbBR8Cq
         6E1qJeNVE1Zx3YWjujAFaj+eseZgHzcrYtHQ6buiajO8MRQPHVFISS2pMi99gjOWzuu4
         2pLUzurYkujJbD9zW1QxV0HRvRnQgy3ySuvSkwguvlS++srS3EDJ4FTYabNdXyjTuPy7
         bmqg==
X-Gm-Message-State: AOJu0YyqIOj+lECFK80zpcGJTR+EgwPRM5VKJOptIG4nKa++Hhu1TGA/
        a0xaPhDy7YEYy2X22aCs70FtOFd5yutWfIH19NE=
X-Google-Smtp-Source: AGHT+IE47EfCnzh1KN7l5aXDawFr4mufhZBee0quSalJzjlDFsXKSs0IS5EvONAqOsRl6KBfdgu6NA==
X-Received: by 2002:a19:6717:0:b0:4fe:7dcc:3dc1 with SMTP id b23-20020a196717000000b004fe7dcc3dc1mr1554762lfc.44.1693989987758;
        Wed, 06 Sep 2023 01:46:27 -0700 (PDT)
Received: from krzk-bin.. (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id cb8-20020a0564020b6800b0052c9f1d3cfasm4984750edb.84.2023.09.06.01.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 01:46:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: nxp: imx6qdl-nitrogen6: correct regulator node name
Date:   Wed,  6 Sep 2023 10:46:25 +0200
Message-Id: <20230906084625.29491-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Root node is not a bus, thus top-level nodes do not have unit addresses.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi
index 763831dc0e24..32a110a35b02 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi
@@ -15,7 +15,7 @@ memory@10000000 {
 		reg = <0x10000000 0xF0000000>;
 	};
 
-	reg_1p8v: regulator@0 {
+	reg_1p8v: regulator-1p8v {
 		compatible = "regulator-fixed";
 		regulator-name = "1P8V";
 		regulator-min-microvolt = <1800000>;
-- 
2.34.1


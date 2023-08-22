Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E036783C02
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbjHVIpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbjHVIph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:45:37 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DC11B0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:45:36 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1c8e9d75ce1so2221795fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692693935; x=1693298735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k79wdmYHctxTtTviGEsItx8Rkhv7MYSzlD064SW+BWo=;
        b=l3UNByXtp7EcL+5pV348GVt6NJLrnCD5W0g9jVmO89nbf6Dt9TJc7YhaUQr9r8jSi+
         NTk+SdWvqrIUWXCWUNUfLZB8bFQ8+DFThbyCe1qmx/G4NGmarLbYM1uGQxD4M6rfqIPI
         Kat4JQ8Me81NQIcTYoTx+JFs3gDoEGAyzlc5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692693935; x=1693298735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k79wdmYHctxTtTviGEsItx8Rkhv7MYSzlD064SW+BWo=;
        b=QoT6EfwoanbrvI4//1dBJf4dargQaKBtJARCBBEVIfLyvA0Gnn50xHNtsHxeuyGBcs
         WdV7cILVX6rwXeOY7F3zusjlZcmyoIMvCbIsiR6CN4eFBM+Iu8ZyF8FwMT3K3xT8k7Cq
         KhjxZmb8dXe3g12jRVoBpPvoiYr9siko0UmfBtLL8hm0+9Hc+BNesZvddE2sMqYXcxI+
         IpNXBor3ZDsOQnnDaGeP97mLNqwaEhg/D5FK2S9qQCAVBqiYAKx9/HQEQHxpqXHnH1Wu
         P2nFSbrbEfjsc1opMCoWnUqJ2yZ2zsexZSrYg8Vw/uJ6LxeKjwAxiXX152cmTaXacpso
         GRBw==
X-Gm-Message-State: AOJu0Yz8fqSw6HyvtvooSzAPTUZg1ifVXvbqL1n+6QpI3QXOhL6xP40i
        2TE26N9CNt7wU8YGyu6mlTnt0g==
X-Google-Smtp-Source: AGHT+IFrqNfX0Z2M1qPDMP5VU3WvMzTEBG6FxwX95QutkiDBAyygmWZFCFMonYMFDSbc3GnKB2Qo8A==
X-Received: by 2002:a05:6870:211:b0:1c8:d72a:d6b4 with SMTP id j17-20020a056870021100b001c8d72ad6b4mr9470932oad.2.1692693935466;
        Tue, 22 Aug 2023 01:45:35 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:e619:3fa0:1a90:6bb0])
        by smtp.gmail.com with ESMTPSA id s26-20020aa78d5a000000b00666b012baedsm7304790pfe.158.2023.08.22.01.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 01:45:35 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 02/11] mfd: mt6358: Add registers for MT6366 specific regulators
Date:   Tue, 22 Aug 2023 16:45:10 +0800
Message-ID: <20230822084520.564937-3-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230822084520.564937-1-wenst@chromium.org>
References: <20230822084520.564937-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT6366 PMIC, compared to the MT6358, does away with the VCAM*
regulators. Two regulators VM18 and VMDDR reuse their register space.
There's also a VSRAM type regulator VSRAM_CORE thats' split between
the VCAM* register space and other parts.

Add register address macros for these MT6366 specific regulators.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 include/linux/mfd/mt6358/registers.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/mfd/mt6358/registers.h b/include/linux/mfd/mt6358/registers.h
index 5ea2590be710..d83e87298ac4 100644
--- a/include/linux/mfd/mt6358/registers.h
+++ b/include/linux/mfd/mt6358/registers.h
@@ -294,4 +294,21 @@
 #define MT6358_AUD_TOP_INT_CON0               0x2228
 #define MT6358_AUD_TOP_INT_STATUS0            0x2234
 
+/*
+ * MT6366 has no VCAM*, but has other regulators in its place. The names
+ * keep the MT6358 prefix for ease of use in the regulator driver.
+ */
+#define MT6358_LDO_VSRAM_CON5                 0x1bf8
+#define MT6358_LDO_VM18_CON0                  MT6358_LDO_VCAMA1_CON0
+#define MT6358_LDO_VM18_CON1                  MT6358_LDO_VCAMA1_CON1
+#define MT6358_LDO_VM18_CON2                  MT6358_LDO_VCAMA1_CON2
+#define MT6358_LDO_VMDDR_CON0                 MT6358_LDO_VCAMA2_CON0
+#define MT6358_LDO_VMDDR_CON1                 MT6358_LDO_VCAMA2_CON1
+#define MT6358_LDO_VMDDR_CON2                 MT6358_LDO_VCAMA2_CON2
+#define MT6358_LDO_VSRAM_CORE_CON0            MT6358_LDO_VCAMD_CON0
+#define MT6358_LDO_VSRAM_CORE_DBG0            0x1cb6
+#define MT6358_LDO_VSRAM_CORE_DBG1            0x1cb8
+#define MT6358_VM18_ANA_CON0                  MT6358_VCAMA1_ANA_CON0
+#define MT6358_VMDDR_ANA_CON0                 MT6358_VCAMD_ANA_CON0
+
 #endif /* __MFD_MT6358_REGISTERS_H__ */
-- 
2.42.0.rc1.204.g551eb34607-goog


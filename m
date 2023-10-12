Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B8F7C7A27
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 01:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443174AbjJLXDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 19:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443125AbjJLXDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 19:03:18 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B87411A
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 16:03:08 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-53fa455cd94so1119248a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 16:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697151787; x=1697756587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZL2qR43CHkvuuHjLtXEqq66Lhh+fHM/KJL5HBKVwIw=;
        b=io1gPev+wnRRi7RgcMLLkzv+ZoVAlHx+0GWsWg+DzqjpPMltssaaLADCgcOo9hGCYY
         8Tt0TSrCufC2dlYHG7HCXfD6Gix9TDPkzE/i/02wvpMITEF0/yfimt0lXFGB8xN55el3
         2N1HLRVtT7ops6HYLqRstCaSz245P0VHGlB+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697151787; x=1697756587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZL2qR43CHkvuuHjLtXEqq66Lhh+fHM/KJL5HBKVwIw=;
        b=LHU2k0mS5k0fPyqpuCuZXbwwsIDJR0WfRx4gUotm91vroTeyrkwDmEf8Rw/WtmaAOm
         p3BLQqg5xxB5C/SVR5OlVRWejSAiHmSOt8XRGucADjSXG8cPs/tpFvKF0F5m5LxuxpK5
         lPovyGB2/Ssm5Av4vb3bBshCil9ftQN+1UJj7jMfMhv78uqk3KQ6YBY9WsknSJfnNEa1
         d9cLk1B9dXOUvvwravww1el54VruAzrZsGcz0Fk1xzWPx+tpLPNcsdV+YhrpELYj5jOb
         1zyOgfLUgPgYJs+agH99YDBw+/KI50iXZqw0m+2c0x5AA0NY6xtnxhtFrWN7vO1hF5Xl
         cMiw==
X-Gm-Message-State: AOJu0Yz3jurWsVOL9NCVIm5wfncfezJ5kgoOe5NCOBKktX+4QIpIW0JT
        uebwYDWQl2fLndqQcaqNAAEtYg==
X-Google-Smtp-Source: AGHT+IHNmLFSfXUvSCIZu97slh9dMsSIdN2phuDlOzogtcn/v4ql653OTqwp3qn3wC8meMvlaIr5PQ==
X-Received: by 2002:a17:902:b698:b0:1c8:791c:d797 with SMTP id c24-20020a170902b69800b001c8791cd797mr19017563pls.56.1697151787485;
        Thu, 12 Oct 2023 16:03:07 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:7397:2561:ed13:bac8])
        by smtp.gmail.com with ESMTPSA id g11-20020a1709026b4b00b001c613091aeasm2494390plt.297.2023.10.12.16.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 16:03:07 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] arm64: dts: mediatek: Add MT8186 Steelix platform based Rusty
Date:   Fri, 13 Oct 2023 07:02:34 +0800
Message-ID: <20231012230237.2676469-9-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231012230237.2676469-1-wenst@chromium.org>
References: <20231012230237.2676469-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8186 Rusty, otherwise known as the Lenovo 100e Chromebook Gen 4, is an
MT8186 based laptop. It is based on the "Steelix" design. Being a laptop
instead of a convertible device, there is no touchscreen or stylus.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/Makefile         |  1 +
 .../mt8186-corsola-rusty-sku196608.dts        | 21 +++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-rusty-sku196608.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 7bd9471b89f9..6b05f1f2e645 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -43,6 +43,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku32.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-rusty-sku196608.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-steelix-sku131072.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-steelix-sku131073.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacool-sku327681.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-rusty-sku196608.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-rusty-sku196608.dts
new file mode 100644
index 000000000000..02ab7eb11dcd
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-rusty-sku196608.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2022 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola-steelix.dtsi"
+
+/ {
+	model = "Google Rusty board";
+	compatible = "google,steelix-sku196608", "google,steelix-sku196609",
+		     "google,steelix", "mediatek,mt8186";
+	chassis-type = "laptop";
+};
+
+/delete-node/ &gpio_keys;
+/delete-node/ &touchscreen;
+
+&i2c1 {
+	status = "disabled";
+};
-- 
2.42.0.655.g421f12c284-goog


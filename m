Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DF27FE9DD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 08:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjK3Hku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 02:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344773AbjK3Hkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 02:40:40 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75179D5E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:40:46 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cfabcbda7bso14511395ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701330046; x=1701934846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKnc2RZBbgrdaniJjhXC1yNhidddngTlWoTj4fSfTDs=;
        b=Z+diMEv8ONuY6Fqp0+HMXG7vSxslfRRrIVJfpyzRj35ybU/GcA5YlJdEe/ih3SlY+p
         CMBBPF0HM/fONvn0dQFe/d34R1VUqTkOilpr3IaXsTzeSnnxjx9lSD0ZFsZHzdQtycqD
         X9g6++GCVPf8xL2vtU85zDWEXskE1LWbhGC7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701330046; x=1701934846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKnc2RZBbgrdaniJjhXC1yNhidddngTlWoTj4fSfTDs=;
        b=WkMJWrHr6v4ifs0JGAVT6807NopKdduhH9ipKvs7JOH2rCQ4FZss8S0ENyGgzDgg1Z
         hXZc5lgA0GPVEVIHReiNkEJkSUE5O/TVegFbNLxXk/60BTIiainlH9oLA/HmrQVM2acS
         sWFSD4j06w1WmAo2Fv4OlxnMCAV80ZEGtkYZlkopbWIWw+YZS9Md5pQesm60WlCawHna
         tH6BYAIiWfD8+BU+deaOD9hL0Zl2SBx0LrGth95LJQ+bqOj432tpI5/GIHOHodhnfP/w
         2SVZRI2R4nahXQRcjBfOqDu0829VovOc/EEiOTG6TxatgxU4p3T3pwG7789Lm1YKdVvS
         yh2A==
X-Gm-Message-State: AOJu0YxyrLZe2NU3Nn3PLhr+B42DwQ6Cx69zd7XRhDTxorKP9UPAg+EM
        dBdfxmLqa9cqgeTR/ej/Q/RVPA==
X-Google-Smtp-Source: AGHT+IGAr9LwKDNK6mCFGvRbs1763uve1b/upQrl2GE7plYDdI0iQfPRY6A2F/64FTmn8nJQgl95Tw==
X-Received: by 2002:a17:902:ac86:b0:1cf:c3fb:a75f with SMTP id h6-20020a170902ac8600b001cfc3fba75fmr19045596plr.17.1701330045865;
        Wed, 29 Nov 2023 23:40:45 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:7c8f:dafd:65c3:2bcf])
        by smtp.gmail.com with ESMTPSA id p35-20020a634f63000000b005bd3f34b10dsm612870pgl.24.2023.11.29.23.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 23:40:45 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 1/3] arm64: dts: mt8183: kukui-jacuzzi: Drop bogus anx7625 panel_flag property
Date:   Thu, 30 Nov 2023 15:40:29 +0800
Message-ID: <20231130074032.913511-2-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231130074032.913511-1-wenst@chromium.org>
References: <20231130074032.913511-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panel_flag property was used in ChromeOS's downstream kernel. It was
used to signal whether the downstream device was a fixed panel or
a connector for an external display.

This property was dropped in favor of standard OF graph descrptions of
downstream display panels and bridges.

Drop the property from the device tree file.

Fixes: cabc71b08eb5 ("arm64: dts: mt8183: Add kukui-jacuzzi-damu board")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
index bf97b60ae4d1..09e658bc30e6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
@@ -147,7 +147,6 @@ anx_bridge: anx7625@58 {
 		reg = <0x58>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&anx7625_pins>;
-		panel_flags = <1>;
 		enable-gpios = <&pio 45 GPIO_ACTIVE_HIGH>;
 		reset-gpios = <&pio 73 GPIO_ACTIVE_HIGH>;
 		vdd10-supply = <&pp1200_mipibrdg>;
-- 
2.43.0.rc2.451.g8631bc7472-goog


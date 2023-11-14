Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7D37EAE42
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 11:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjKNKoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 05:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjKNKoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 05:44:16 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4872F186
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 02:44:13 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1ef9f1640a5so3307781fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 02:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699958652; x=1700563452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EtGo2PbI4VhfFCzLF5CTcHmhJXxS0YiF4GH0b4RYzjc=;
        b=UYA4KFCpaFaA5Vb6lsM8FVWQ/+HU0Oxtm8zhCbwf57Szg8Kf8UA4QAi8m/VmONY/LH
         BJJwhQDKnQR1yuZaxSc+AYgO6nbdc0bhoiwEV7x0V7v+jDyoTYZdQmk9Fs1Lv0LZTQjY
         fb/hfeokqDJsF9duBwa4fbIEGH4ncoF4g4L3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699958652; x=1700563452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EtGo2PbI4VhfFCzLF5CTcHmhJXxS0YiF4GH0b4RYzjc=;
        b=EkkP00XmuNXWJzBAQtbowp9DfsCDGXQU5W//4bRU66VZPWeEuQH+TBnUF1faS6wu/V
         Oe3kL/+MBpriYYYvUnpT+HWp3SMvGDgjJzM95SrdXFphASL4n4POeloptyvIN/nOK3sK
         TUviPxqBiDJ++S+pyy1zB3KexCJux9+nOIoQP5xH5uwVrcLyTxMvBPeCV9OdkKzCe7AJ
         PDtj7hJfeQ3zuYuGkBm9Cj5/cY4MVZJ2a9zgPOnt8U9T6Lb5M8ld7/ynB3s+BcMdkWJU
         WcpR+ocJZH3myEEVqKL+2nbUTTq3oXUIkz2Wjq1PjEPWQvbvaNsJA4cHfe3jSC9+SzLC
         KrbQ==
X-Gm-Message-State: AOJu0YxMVK/O6TyAFzUJKhul1p7gYqPGtKXz7+Qz5EC6gfj4KpMQpV/H
        gTTePB8n68My+G16AmFU+BHbEA==
X-Google-Smtp-Source: AGHT+IHxmgUlMEBieMM61gtbnmLAhVuEAHgMl6ycbPU13IOxBVkaJ+NHHsqbyyZtI6i0GsUzVhD6Ig==
X-Received: by 2002:a05:6870:81b:b0:1e9:b550:c05a with SMTP id fw27-20020a056870081b00b001e9b550c05amr12708195oab.53.1699958652536;
        Tue, 14 Nov 2023 02:44:12 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:b51f:fb1c:5e29:cfc8])
        by smtp.gmail.com with ESMTPSA id m4-20020aa78a04000000b006c33311965esm926136pfa.68.2023.11.14.02.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 02:44:12 -0800 (PST)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH] arm64: dts: mt8173: Add G2Touch touchscreen node
Date:   Tue, 14 Nov 2023 18:43:23 +0800
Message-ID: <20231114104353.1693966-1-treapking@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
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

Lenovo Ideapad C330 Chromebook (MTK) uses G2Touch touchscreen as a
second source component.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

 arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
index bdcd35cecad9..0d6dbc36c352 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
@@ -29,6 +29,14 @@ touchscreen3: touchscreen@20 {
 		interrupt-parent = <&pio>;
 		interrupts = <88 IRQ_TYPE_LEVEL_LOW>;
 	};
+
+	touchscreen4: touchscreen@40 {
+		compatible = "hid-over-i2c";
+		reg = <0x40>;
+		hid-descr-addr = <0x0001>;
+		interrupt-parent = <&pio>;
+		interrupts = <88 IRQ_TYPE_LEVEL_LOW>;
+	};
 };
 
 &i2c4 {
-- 
2.42.0.869.gea05f2083d-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786B9767E6D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 13:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjG2LFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 07:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjG2LFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 07:05:01 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11623AB9;
        Sat, 29 Jul 2023 04:04:59 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9338e4695so43545691fa.2;
        Sat, 29 Jul 2023 04:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690628698; x=1691233498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ebeM2mGR4TMnC3Hsqfbcbfw6t45XlZ3ZN9tmUhCmp/4=;
        b=YqlKluSjEj86SSIVP8nR4TGkwdMAClWe/imOTxoQAiw9js2nPW6HHe8DDDUFoPCFz1
         SsdArHnaFoFWm+nMuu2SdFf3+phqw6AZIDSgc+/2ICmQ0cc7Iz8E7ayYQMLbkIMaCf71
         8z9D83CdLluWAGJqq1gV71Ra7zBOVefgt+8zSK0LItSkKykRry/euEtbve0ZSVgj+wvz
         vNE42Jr3eNABTHEGxZRseMFPpdfMwv/9FehB0BleHXOBtO5K4htAb4jw4vtKcW51ZBMF
         6faHRP+klBQO2pEyPV67KYxpUMHAwPgwzV3IKpDI/BXPuQDHa1HeHJ8gsVhbUrbM8ZXZ
         3tUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690628698; x=1691233498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ebeM2mGR4TMnC3Hsqfbcbfw6t45XlZ3ZN9tmUhCmp/4=;
        b=L1m/vtmzLoMKZyJyWi0qwAIIl1JgqUhbVE0GSGtRYSrWzIi0AftCXq8vU7kkhMmtpX
         bcVA0qkjDMqXt/IzoGAAu3d7T2HXyjWGPObbBt5FpdQoZtu5TMdwhZ9NcZRUytXaBDj1
         vs7HANQFpnngwo97gQ662obTWyUfrX0hKUVwE2x/JbN1P2h/iiYMbumSpqrj3ykwPYov
         QfhDu+RSw8TGWxgBfwg+siFu9NUt+23CUHnCIs5/cum2pHequKp3X3omJuev80kTUzDR
         9QY9aCeDzFoUEQoJvWmLyd/mZhNLQ5S23uphbuq3MQ7Sk/u3dk7zyjjsGXqHE2fadRHD
         pcFA==
X-Gm-Message-State: ABy/qLakifXFR8nslTOTykWsgFVCKDIijVP11ftwtWuYCd08TFTbIaFY
        GZZkpODxkWIcwcz+nJd6SOQ=
X-Google-Smtp-Source: APBJJlHNub5uJTMcqIiLRw0Io/ZV6tQGW8ogC+GOYzkIcNXpusJt/7q9LmBqiU3iW1LpLkV8BbgQMw==
X-Received: by 2002:a2e:2c0e:0:b0:2b8:4026:1f54 with SMTP id s14-20020a2e2c0e000000b002b840261f54mr3344659ljs.49.1690628697874;
        Sat, 29 Jul 2023 04:04:57 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id y9-20020a2e9789000000b002b9ae051ea1sm1438688lji.113.2023.07.29.04.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 04:04:57 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] mips: dts: ralink: reorder MT7621 clocks in Ethernet block
Date:   Sat, 29 Jul 2023 13:04:49 +0200
Message-Id: <20230729110449.1357-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Use order as specified in the binding (first "ethif" then "fe").

This fixes:
arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: ethernet@1e100000: clock-names:0: 'ethif' was expected
        From schema: Documentation/devicetree/bindings/net/mediatek,net.yaml
arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: ethernet@1e100000: clock-names:1: 'fe' was expected
        From schema: Documentation/devicetree/bindings/net/mediatek,net.yaml

Fixes: 7a6ee0bbab25 ("mips: dts: ralink: add MT7621 SoC")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/mips/boot/dts/ralink/mt7621.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
index 7caed0d14f11..73035d4f4cc1 100644
--- a/arch/mips/boot/dts/ralink/mt7621.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
@@ -300,9 +300,9 @@ ethernet: ethernet@1e100000 {
 		compatible = "mediatek,mt7621-eth";
 		reg = <0x1e100000 0x10000>;
 
-		clocks = <&sysc MT7621_CLK_FE>,
-			 <&sysc MT7621_CLK_ETH>;
-		clock-names = "fe", "ethif";
+		clocks = <&sysc MT7621_CLK_ETH>,
+			 <&sysc MT7621_CLK_FE>;
+		clock-names = "ethif", "fe";
 
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.35.3


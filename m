Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9987AA141
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjIUVAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjIUU7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:59:41 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7654D83F62
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:37:18 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5333fb34be3so1160127a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695317837; x=1695922637; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ABe5lag05JGrRRfK6Q7TQU2Nmk4xnwbIxqigvQsoK2A=;
        b=JwnjnrHShjI6zRawKAxhSBYdz0O8VDXWCPifpp0aJh6MB5rBHny5X7xZ6Fwt+Vqs54
         WCqs7RvvHfI4Zbnn2Ku/ujq6x1HWvXgsgBWOe5EXga6gm7+4mo2TXPMxkBjMxDO1MZUc
         F5rRDNz2EgN4J3DZbLv2wh52gvJGdPkhH8M/ZP0qYVkUT3MGYs3WVPJ08IjpV5f/KVxP
         VznYp+xMVWezX97qBFKlSKBuWlfDRz9uGDXFDzsPbZp3ODRCOt8bJt3Dwvac8+c8WGnX
         FiJYIB0ZZRWc23ugs+gUVak+WjN52RT/hS4yW6EoxwORyQccZ1JSV/lSrFj8tRSdef3z
         SboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317837; x=1695922637;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABe5lag05JGrRRfK6Q7TQU2Nmk4xnwbIxqigvQsoK2A=;
        b=Q201OU4CdWct1J2hAlCuopthuipnbI92x8+kf8GeT6jMZhPJ7gmR2/LXDYmygHVKz8
         +wMdIUU2I4X1i/otzKeGcmruAjH/e9j5skNn/9nujkugGgQuTslMa9RgK50C5gIkTRvK
         UCzYF+2i0Ue2tSKHiivN500N5BZ2geYx6TcwUTNicjPlQhNzsObY04CCbaUKbpgIPCe3
         pr6CVxMyTwzLm6ZHSHDKBojV0he/93P9HjsKhGlcZN4472hitJca01KDRCplL+2lt4qz
         OFxp8Hei2o6C8mL8wm86VmVTzhA3YPU5rbq+5PJWdt0OIFeFMv1eE1uYV6wx7j8UOJ95
         4tXw==
X-Gm-Message-State: AOJu0YzmVAi8K4wGvqpy+ll85rdftRov74pe08P78S7dpxINWwGbVY4x
        ZgbJgeKwV0+D09o8A++HFqgiMqKRsCdzTTXTR+c=
X-Google-Smtp-Source: AGHT+IGjoyNrvxCOmiRU6T/l2zYW9m8AVBU3LbyVShNlB4GekcqlT9pPNTweRl3dmSDWyO+BQzflag==
X-Received: by 2002:a17:906:20dd:b0:9ad:cb02:275f with SMTP id c29-20020a17090620dd00b009adcb02275fmr5307075ejc.34.1695306773342;
        Thu, 21 Sep 2023 07:32:53 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id lt12-20020a170906fa8c00b009a219ecbaf1sm1153327ejb.85.2023.09.21.07.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:32:52 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 21 Sep 2023 16:32:42 +0200
Subject: [PATCH v5 3/7] arm64: dts: mediatek: add apu support for mt8365
 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v5-3-fa6f03680832@baylibre.com>
References: <20230207-iommu-support-v5-0-fa6f03680832@baylibre.com>
In-Reply-To: <20230207-iommu-support-v5-0-fa6f03680832@baylibre.com>
To:     Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1174; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=LNi5XTwnw6k3l6Q87CyTgWzrlVLjaNEqurZKDlk2veo=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBlDFQP6GqJjbLUqKqxj6xy8Bno/ClUvJYLrn3Hmj6Z
 WRq+RVyJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZQxUDwAKCRArRkmdfjHURbzXEA
 CtoPjBUH3xYFYAKUMiNcdHOWrnTKIIVSJ1nCZqaEtp4uzw7YjrnDFm97+Xjuu2+We3fpcQh5rfUhYw
 sPyIKuzpBGukYrCyg1cntaJFnWj7zkuv5tm01rIhDSb9cvfIesD6Wgybc4c9xkvuufeAPSaCeamCUz
 6XKAk8oIdSwhXp2ZJEqjCfb8Jq1tq7XbtAU5EsNDm+YQdBRVmTESdE0p0z4fG12A1RSBoHDQkJ8ijo
 P2fbCbDjkeu6h0xg5dMIFwNbJH2JwCr4DraiG6jZ93u22kqyaC/ROO9iQKJgRR/0YB/pCHHP6cV7/V
 OZkxUkgLQaYd4dbZuxcw+30vhbMp3emKzdz79kYDtRtLJmDOhwD1R9BKAcO02Dbk4iw8XoePlfM4Hp
 qfMoX8zqKIVMWXXawqQUW74VBHelwGLmlFN4xEKBpB7G3q3fOr4zYGaVbddNoBC89lqFldbBxyAzwU
 qOQVRnIGbxtDEk3QP3Sl3fUZQR+naiUGD+2aUFpRP4K0yAOTqKgJQY2qtQPEs69zlj+RUH05ssfKC9
 Pza9sw4vljuxaR3KeKHzgsCsf/jmjP7vyPNPyEzOLyosR3g8gUvKKeiFzPQO6jPCpQrjt4ViZkv2II
 L23fuNQtT5JgfO60FwIvZvGiCWxWkrCQ5kc61MjwKwJmFbVD4HU4D8E6uLEQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AI Processor Unit System (APUSYS) is a highly efficient computing unit
system which is most suitable for AI/CV algorithms. It includes one
programmable AI processor (Cadence VP6) for both AI and CV algorithms,
and an eDMA engine for data movement between external DRAM and VP6
internal memory.

For more detail, ask Mediatek for the MT8365 AIoT application processor
functional specification.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index f9cddce5bd9d..c3ad7cbc89ab 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -615,6 +615,12 @@ camsys: syscon@15000000 {
 			reg = <0 0x15000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
+
+		apu: syscon@19020000 {
+			compatible = "mediatek,mt8365-apu", "syscon";
+			reg = <0 0x19020000 0 0x1000>;
+			#clock-cells = <1>;
+		};
 	};
 
 	timer {

-- 
2.25.1


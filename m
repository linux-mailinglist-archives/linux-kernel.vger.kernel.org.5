Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D897A9E5C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjIUUAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjIUT75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:59:57 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304C01BEF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:23:34 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-532addba879so2628430a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695317012; x=1695921812; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wErjPQt6qENv87TZs9KiIyjig4b2yslS27coAwsNZVw=;
        b=LLQlnGB1+gFa8DRy+Tj3tpBfPJoL5Co/c/cOWNvkk8fbRKO2CIxvzHAJR5UEUHsMX0
         cZyUIkFZa/gU4rAMgO7tXO8ZBWQGwQ223C+deZIeJ3ApuueAwm/4+M8NqNFGtaJUJzmo
         sMlagVdGBBfCBs063BXbKwRmW3RSn4KG9Mr8EN+8sYhKsCbS3FycLYgORvM+J5PI0ng0
         7scRj+NbD36wgzsoNG79qQsTfn5D7k1aun0U3ADaLT1MVY90OgjWtdLw6xq2GKUP/21/
         K/7aREUpdr+Di8iuJXfHXD28EJ7U/dT1ECg2BWyS1nx7JJRKg/77wwaExcpgLBiC2yO8
         aHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317012; x=1695921812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wErjPQt6qENv87TZs9KiIyjig4b2yslS27coAwsNZVw=;
        b=CdHdkTOzm7LqT8NsPf9hsv4Zgy9Ut2RoUwvRL/eYm8FYutlVDDUNbe35/VA9N/SIKP
         +5Q84tFsVztH293unDTdkpK9OSHBbZ71O6HNjNtA65TJqEOn/iTVXqvNikCgdjVA1ZvI
         y94DImXWKfAbQvQOSTrgFyDsLdkcG1pMYiUE4OYRQ5MS9U2Q6LdZE6q8XpiA2P592bJD
         setsrefON4u3xGhfEPl5suVQNDP4pY6ITUBjBhRMhESPtDBJn+9I29pV8Zc/OIfUT8EL
         gNgLaOt/tWF0M6zR+msFMOYtxUcAL3ymlJRjGAtyFfLHM1JjBF1rRk4IifnCLxFHAX3B
         ERAQ==
X-Gm-Message-State: AOJu0Yx8XRx9E4TDZOHWyflbPw6mJ5OAXth34IfSuez9ZkTCUE4OC+Hv
        4FoKCDkxDoblYOzANTUvSPJUrUQ7bfAuFjpvH8I=
X-Google-Smtp-Source: AGHT+IFOB3eMDwI2t0a2q9Bc3NUa0OvjwJSrkAn5FCb5ugaSbmUWlrXrinmvhlY5/5p++bwV6SZ9yA==
X-Received: by 2002:a17:906:847c:b0:9ae:6196:5094 with SMTP id hx28-20020a170906847c00b009ae61965094mr2756229ejc.30.1695306770505;
        Thu, 21 Sep 2023 07:32:50 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id lt12-20020a170906fa8c00b009a219ecbaf1sm1153327ejb.85.2023.09.21.07.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:32:49 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 21 Sep 2023 16:32:40 +0200
Subject: [PATCH v5 1/7] arm64: dts: mediatek: add mmsys support for mt8365
 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v5-1-fa6f03680832@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1264; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=5Tm918SwyWroVCRT9x2Od4dOEXsJxNFB5Eps83AeIaY=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBlDFQPu6ZqiZkD/quO4t8h+hA6Isg4BN08h2+76mls
 Gl5YOuqJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZQxUDwAKCRArRkmdfjHURVtUD/
 4/BNRJAHNO6Wlh1V/NiAriWpP17skcQQDHSsFYzz3Y/aaeyXPE91Bu4TdQVJLuNj+3Z5o86DvWG1SV
 U8KUyuQ1MmO1q61clIxSfn214ayuu6300dUg8HSU76C6jEdzWjQeYdaL06+g1XEKvnzNISOcsvsZ8B
 DlZZGHYUsfeAEFzNlL1o/2q3ZlPCqgkRLvu5rNFSB7ULIhzpjfrr7kh5SplD0SgfOCN8ydJp57fLCk
 xMUoKhP1brq3zfUonx4Kho4m719ZYPPbgODu1QGkztz5TRqheJWRWJG6DS9LCcsQ+Y3dTyurJLDNFc
 gOv9o7jCikev4QfhT07WIFFoNgEylBji9qVZf5ATyLaqJSSoK1rMwm7YitpXz6S38TLnWQVcFeb5TT
 sUeIYfOxMoGVK87fh3CJv/C61f4tCSEUYUSlWVBab/fqm4vcpyQX0TFJXz0dNBMc7z3Qqp6aFWPU8m
 cLA2NmyoAU9wiD7g26quS/1VsD6HoUpGbMssqlD1BAwP2Sn/ZNO/lr2pLHhGifeSbY72D2SHAZzgXD
 pkV5+nsdMHHd3lWLHVSR14J+DZdnuedWdiZRC75p6ftLrXyabvyesfi37UTn/dwOrFyqewKxN10x5l
 LvjEw3zQsCAan4BaA7VfIfbsVJoKuzd9KhBgOu7RI/ZLD+JNv3xa06Qehdug==
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

Multimedia subsystem (MMsys) contains multimedia controller, Multimedia
Data Path v2.0 (MDP 2.0) and Display (DISP). The multimedia controller
includes bus fabric control, Smart Memory Interface (SMI) control,
memory access second-level arbiter, and multimedia configuration. It
plays the key role in handling different handshakings between infra
subsystem, video subsystem, image subsystem and G3D subsystem.

For more detail, ask Mediatek for the MT8365 AIoT application processor
functional specification.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index 413496c92069..bcabc2b89a94 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -603,6 +603,12 @@ u2port1: usb-phy@1000 {
 				#phy-cells = <1>;
 			};
 		};
+
+		mmsys: syscon@14000000 {
+			compatible = "mediatek,mt8365-mmsys", "syscon";
+			reg = <0 0x14000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
 	};
 
 	timer {

-- 
2.25.1


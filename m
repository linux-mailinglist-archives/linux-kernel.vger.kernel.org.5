Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2217ADE76
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjIYSR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjIYSRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:17:52 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2CB111
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:17:46 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50444e756deso7501458e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695665864; x=1696270664; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dK9svkzd5BTaKwxJw9fwDjaSrOwG+HEsVIjgOVFtfuE=;
        b=wVYGdpMzvBXl32Hz46MVOksWUbFwwcojmQ3CpHBEIqfzJtznZRYLxgAiG1hNZRK6NB
         nIzGqRFoBWe0K0rVLKfew+2fYj/iuPYEXJE2mJKtfy6PZpQx1ReDiRDexQBxd3EZGFN6
         VtUUliAl0kVrvAixOh98UssvVM0GPne1aDoPM62I/qFJ9nfEhLxhvIewnYjzZ+zpkMYa
         LIsQCnnh+Y7iIvi81iiqOlqZQrguOlHIyU7f68SCbj93+5gJjAKieLjjwPx57xps7FIA
         vUblkStX0gnIrxypiBpQyqD4OcX6xz2nwW4MXxaNTFZJG/8UMGuE87RCvMA8I3HhoJ/n
         FZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695665864; x=1696270664;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dK9svkzd5BTaKwxJw9fwDjaSrOwG+HEsVIjgOVFtfuE=;
        b=by3bu1a7dCIxwRVU4bn4cYoHBahbdJgOAAD00q1EJbC3UHj3jwGWtZSgZCre//qEWT
         vt8Ab+Pu0qRhIa6WEQy9chjeh+dPYEa8h4KwEpmFF1gSYmng/Yrr5kUYIhYwckeY/4Rb
         A/Et98xHsXX4oAM47BzN/57phCBC9FayyYO9dE3Nui+wa00bvYfLn3sIMnjfw2jz/kfB
         Fg/n2NsV+3FtP82VeClg3WAqceznKqNlw3wDUK/YCfSvv38pb4MgL9RmSO99ARXQ7TqV
         FSuQaCq9hDxnzCiKkBL8TEHVqfjtdfLRJeuBRXHYLV+if0w55WYoZpqCX1bBOQDrU02R
         b6Ow==
X-Gm-Message-State: AOJu0Yzgq6vblUoXf/ixOaBEWuLK/x4rDc93yfAUsmNB9voHkLUbmqc1
        Y2er6mV7SgcxL8fMjolJWgkLQQ==
X-Google-Smtp-Source: AGHT+IH4f3Zy45N7aooSzTaDzz2tjwmrYrkiJtIrcuiwsXrjJTqM/3pRDFGwNrPlGO4oCd1gP3JB9A==
X-Received: by 2002:a19:6746:0:b0:503:35bb:1e74 with SMTP id e6-20020a196746000000b0050335bb1e74mr6085356lfj.61.1695665864466;
        Mon, 25 Sep 2023 11:17:44 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id j26-20020a170906831a00b00997d7aa59fasm6793962ejx.14.2023.09.25.11.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 11:17:43 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 25 Sep 2023 20:17:35 +0200
Subject: [PATCH v6 1/7] arm64: dts: mediatek: add mmsys support for mt8365
 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v6-1-24453c8625b3@baylibre.com>
References: <20230207-iommu-support-v6-0-24453c8625b3@baylibre.com>
In-Reply-To: <20230207-iommu-support-v6-0-24453c8625b3@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1263; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=3xFs1OXjad0XvE1yvI1YsSmmgVc5j01QOJdhl+XL6SI=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBlEc7FZEar/ON4sXpZXeINtiOHvT/onNcfUSIdLTxU
 fqzezeuJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZRHOxQAKCRArRkmdfjHURU3wD/
 0XoPzDUgXjVNvenXE5P7hb9zlHSrFtmlDaKfEWNHzM47z9dKN+JRhCkBjWJmZCTf74kIJkgiOTpHUC
 VGnL9yPp3fTnTlLIh0xYC7Dt0f1vuEWcFDu9WVH8hWGZGDK8jAXi9TYI6nu259zx7Ay7pV4OqK4jQh
 j6K+NnkTuwKB4qy5SGbSDgwLAbsNUx8n6rHCEaJulCr0EGgCLDAXVoQqLL9/ZnfgRMJ0zUvI81rSnN
 PCtvlu2BGrC0i9AMAShgw6JRsVfAUl6awqnJEp+hwQqBFoHQGRH604SSBHX1odm9YULfV0zV+Oc3iF
 xFHqEAWpSMwPjJ/8+EdG+pvEBBeSfy9DhY8fBj4YK5756jmsq4KWdaHPNpWCHdfzTnnfMzv1apcj7k
 wHEoXB7A5NVuRZsCYk2FQUpevCVyLdUsJQc9xomaQqvsl/BArj2nzul0CvlaLySnkaRRkVRyffBLvs
 munBn8Ui7EX+uMKnOX2ItFVQNeNBMqr1XyLYyxKYZyhOX5Qas4V/L2qtEmj4XBxm8G+ES6YipHNj9T
 /YyeYIy9IQ8lKh5LqAqHpGve4b8pBvLwv+OFqm6rFYmKiUIOhJqYBJxfUMdDhrrYc9UfE1CjWofOCP
 C8eiGlfEqsOmO1QpZZrxfxwCoMfDoPxnn77o86u0D4JD7qvNsWXe+gKaxjhg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

For more detail, ask Mediatek for the MT8365 IoT application processor
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


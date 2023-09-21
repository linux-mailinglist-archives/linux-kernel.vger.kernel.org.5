Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41A87A9E43
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjIUT7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjIUT7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:59:11 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2148840649
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:25:30 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-502b0d23f28so2086783e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695317128; x=1695921928; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RatweBkvtrU6P41JPdWUfgV+9gxtDS8Z15ua81Y0Obw=;
        b=QUL0f30a8HkzgySHP2P2nn/nEjmGVhn0ZNKAUDlSyFvge4XH/ydZUGLx0Ey5r5cj+o
         p/123AJpoCS2loAhW8/Zdk6EAjwGUoEd3U8Sy6a888WnKeX7EXrNCoQpKHPBFlNE3GCE
         9abuKrErOcfZGKqqXS9rcDu2M+DZsmAUq0gWcnzxRSJXxeBWqDVb4fnSJELxdbIc8Q5h
         SxikNq4LQ8eYkEJ+63D3+iqXNkv776zFE3QaqLYh36F1++QuYWk00mSh3ZAosbl0FGU5
         4wXRLaQg2HeRM50BkGBm5FumU2t6D54f2409v2UJsRlgzFjeh5bgc803zEE8IvHV7tk4
         Iufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317128; x=1695921928;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RatweBkvtrU6P41JPdWUfgV+9gxtDS8Z15ua81Y0Obw=;
        b=wKefYrrn8wODphyYMVN0xoeLw1b4iaqGEixFxRwn3DEHlaLK2yjwJvkLmhe9DEfXxz
         GEeVPuqF7LmecbZQI2a2GbnLN3XWdNYZmuHbPlx4N4LudtyL2Lf/P/hgQrHUGobFsn1k
         tca+xL84l61LHBbSHiAZVG0Iq0pyRKwT/ofvqDylGJ03bTNLHJnHVIvxhbA0IJzzX0wW
         mBGxzbPv9FXwU8Zvi3gxfXbJDV65GR2W0B5H/I2yTPzGVLc77VaIaTcarU6IrluSd+jd
         UuTB690YRoGy4xZ79grjZWnE6FAFULX60yH90fYdLtppDkKsFtQhmmRMLpbl3luQ/lnA
         sP7w==
X-Gm-Message-State: AOJu0YzSncVtICQ2ORU2svqij/XgApsENmWp1WJVMBckM2R5Grp0dCoR
        kbrz8eqWpA+G6v7e2nBGilDcq5UhBKe3OE7vNNo=
X-Google-Smtp-Source: AGHT+IGSkyWUtvar9ZLWBQZDLiST02yDQZgS7/saoVxYhwoVJNzn3LoyxXtwhZyKoMkQv/KBTVhA0g==
X-Received: by 2002:a17:906:194:b0:9ae:5848:3f8e with SMTP id 20-20020a170906019400b009ae58483f8emr2323416ejb.49.1695306771871;
        Thu, 21 Sep 2023 07:32:51 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id lt12-20020a170906fa8c00b009a219ecbaf1sm1153327ejb.85.2023.09.21.07.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:32:51 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 21 Sep 2023 16:32:41 +0200
Subject: [PATCH v5 2/7] arm64: dts: mediatek: add camsys support for mt8365
 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v5-2-fa6f03680832@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1127; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=gpd1qVgLFNytHp6mp3Oxt2b2oXUpJ1x+ZZ2jt7uMt0E=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBlDFQP0sH6dzPgSy2dVGfVl1WaQu1Hm5yWCM/Ma55H
 YHT71FOJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZQxUDwAKCRArRkmdfjHURbmBEA
 CNUoSrRob1rh1wg1N/+dAXP8ugPQkCTciCkJAoV+tvqQOyC/NYqw3bav8ExTwrfk7xCQ8gpE4vrKI3
 DorQIlZWdHiFAyqZSdMC7c8HiDZ3thBPXcLkEfX4FNlbbdCKd9Z310gFzjcTQKew+2QvBrNZomCmM8
 RMBvpn7RJIv/V2DxcTYPSN9pYYtYPoc9buoibKE0BGR86kJPjiWb3zk+MghfR1DfKMTF9xG0Mfvz8g
 fnMxDPAz1JpMWFXelGY2dIE5MBr5lmKt0j/ifEoIIQgCjGmfi4VYvN6E+b2PrmWDx9y9w3YApWrFJY
 4Z6iQgjC/mrZUGcwpbxquRQt7l9bZg+Ry657e9N8jxOhoj5Ng5jZhsPavKxqkpCp6TgJjdl6sg/VbO
 iJdR/OeolrPkH2Ws6s3AAWtTGXae0oyuJHOERcAyroMPRFXqKcBFccDDepqq6kpO9RNdMtdyjB8+c0
 b/BdeXZeORCt9GhWNKB+u6NcVLZ5dn5ZXuYo1r1OkezOtDAyiTPJ36+9h/kD3vsMfnEwa83f1eNACz
 d3r/F9dPCJfFxEzJv6fDNwgJU+ZZWVlalUZCxqFnqwxrgPBqbxyohTTupaRaSSo/UzNR/AvFS7wNDg
 T0MfzOqxQaDhh0E1SpQR5zH4pH+oDYof7B10ofS00iV4qd9G2rWLz06W/kTA==
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

Camera System (CamSys) incorporates an enhanced feature based image
signal processor to connect a variety of image sensor components. This
processor consists of timing generated unit (TG), lens/sensor
compensation unit and image process unit.

For more detail, ask Mediatek for the MT8365 AIoT application processor
functional specification.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index bcabc2b89a94..f9cddce5bd9d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -609,6 +609,12 @@ mmsys: syscon@14000000 {
 			reg = <0 0x14000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
+
+		camsys: syscon@15000000 {
+			compatible = "mediatek,mt8365-imgsys", "syscon";
+			reg = <0 0x15000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
 	};
 
 	timer {

-- 
2.25.1


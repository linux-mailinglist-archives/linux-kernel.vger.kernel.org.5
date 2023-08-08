Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99409774247
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbjHHRjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbjHHRiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:38:50 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02BD3AAE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:17:03 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2680182bc21so3144442a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691511375; x=1692116175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HvqYw50hA3eg6fTEyMxs963EOcH3mDmkMLxwXE575wg=;
        b=JEefN6JD6Q5vbzcjj8+Ur3NiD+Nmiwe/DoogdJeJlM5QDkICh6xOKeYpt0AfqPMgWY
         /kTegZtgG6IRhag0cI/K6AATs4rV98bau0LOpZUPcOezcamFFVXLBUNf7jMiIxdFSCkL
         q/PREVBboJUA8qIlnO/fN4QKI4RomvC7hBhik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511375; x=1692116175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HvqYw50hA3eg6fTEyMxs963EOcH3mDmkMLxwXE575wg=;
        b=jL81Fj5uIjfwdolEa+ukvbmvIWF7ixqxHQVNaxOMaosJJdz0RBROVg1ZStgTHJ3OVT
         Tp0pMpWMvxDRRQEfiiIECvY9Nkb5c5ilr1FQ5Q4Vh9jTrQ538wdlIDhaEPk8m/HgZ29x
         gaV8L8ZpCvYenQdsOWkjINHADwjkj8nG76ZRQdC+22uOydS9VejpgaiJt/vweEiMNJ8N
         RvFfIsAyBQHffwMSCMNh1idsuSfKjqs+FVBh+0XEtDdmpTuo2DsZDhRhiTYril5otp07
         D0jA/aez+t7tKD281ZauB7Jf8EEZ0HpfnuU9VT3N49Ve8tLk907mIoXy/tHV2FadTekK
         mD9w==
X-Gm-Message-State: AOJu0Ywqk9ZWwpo7NgZZQ6m3VoVZnLc4A5LqU5Ypkff+q3Jtu8vqEvDe
        +qOJqRRfQOLQypu4jF5Wj/7Kzow9wnmGv0UefJI=
X-Google-Smtp-Source: AGHT+IEr4kRNf11XniaflwZ5G4MFT6CEIrEsTvEvbpcV/reJoBZs+xiAbEYbAhT6n5rT/1rjg8mLWA==
X-Received: by 2002:a05:6a20:6a10:b0:13d:ee19:7725 with SMTP id p16-20020a056a206a1000b0013dee197725mr12015955pzk.12.1691480036426;
        Tue, 08 Aug 2023 00:33:56 -0700 (PDT)
Received: from localhost (97.176.124.34.bc.googleusercontent.com. [34.124.176.97])
        by smtp.gmail.com with UTF8SMTPSA id i5-20020a170902eb4500b001b04c2023e3sm8161899pli.218.2023.08.08.00.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 00:33:55 -0700 (PDT)
From:   Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Google-Original-From: Hsin-Te Yuan <yuanhsinte@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Hsin-Te Yuan <yuanhsinte@google.com>
Subject: [PATCH v2] arm64: dts: mt8195-cherry-tomato: change watchdog reset boot flow
Date:   Tue,  8 Aug 2023 07:33:07 +0000
Message-ID: <20230808073342.1054762-1-yuanhsinte@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The external output reset signal was originally disabled and sent from
firmware. However, an unfixed bug in the firmware on tomato prevents
the signal from being sent, causing the device to fail to boot. To fix
this, enable external output reset signal to allow the device to reboot
normally.

Signed-off-by: Hsin-Te Yuan <yuanhsinte@google.com>
---

Changes in v2:
- Limit the effect only on tomato.

 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts | 4 ++++
 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts | 4 ++++
 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
index 2d5e8f371b6de..a82d716f10d44 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
@@ -23,3 +23,7 @@ &sound {
 &ts_10 {
 	status = "okay";
 };
+
+&watchdog {
+	/delete-property/ mediatek,disable-extrst;
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
index 2586c32ce6e6f..2fe20e0dad836 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
@@ -43,3 +43,7 @@ &sound {
 &ts_10 {
 	status = "okay";
 };
+
+&watchdog {
+	/delete-property/ mediatek,disable-extrst;
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
index f54f9477b99da..dd294ca98194c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
@@ -44,3 +44,7 @@ &sound {
 &ts_10 {
 	status = "okay";
 };
+
+&watchdog {
+	/delete-property/ mediatek,disable-extrst;
+};
-- 
2.41.0.640.ga95def55d0-goog


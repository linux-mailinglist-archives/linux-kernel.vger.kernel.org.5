Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7604577423A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbjHHRh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbjHHRgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:36:55 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5562EF21
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:16:07 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-26928c430b2so2308293a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691511335; x=1692116135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HvqYw50hA3eg6fTEyMxs963EOcH3mDmkMLxwXE575wg=;
        b=BM/yqDEIkCparheYGPRKrHbGKFNzGhfbP/iJFFwJyhVpkNMQCfkoVtK1y+/hI+eTSU
         Osn2oGpiCagPidbIqwkdV+S+377z/Ny4oWDvdVgfYEuvjJmiYnJdVDqomEX+pucjdOLN
         rMXFbhNHJ96cKJW45o0e6X60z0z0rM744BNdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511335; x=1692116135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HvqYw50hA3eg6fTEyMxs963EOcH3mDmkMLxwXE575wg=;
        b=PLb3S0iMdMX683VR3Jd8l1NysbzUuYZ9zDgFIZTN8X8vfSIR8XcOfJ6C3UpxuK2wzr
         PdU277ZYUsBz5DcR5KrHyx7IfUYK3hl5QNuQ3EVzw3+FKmZXMlkOnUuUoWFJaeLhtCd7
         Cs/bd6tx7KyNhxHK6btDq/q3Y15wff2eZWuA6XQfmPJybySS0h6i5FsZqb9e0Zs4GV0+
         5aeepvFwHE/ZhJtKTeJ9fEZRKFFolUJRwJY5DRdaxZVf2WVGuY382ul3mYQz5c4LHXnM
         b5rEoNloOL0sQ/G8Z0KrW1v4t1tjSgKCgoUvh0r877Se8BGL5E2QA/uGU4HhkQCKPED5
         Xvdw==
X-Gm-Message-State: AOJu0YwTwAdy2AjFpvJx5INbspCUaqq/zkzWEJrnDUvWxSdrn0Bj4VCB
        k5eU6+P4soYrpRwIKm36fJQxDsUoVj1pBsjrgVM=
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
        autolearn=ham autolearn_force=no version=3.4.6
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


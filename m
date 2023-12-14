Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9E68123F0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 01:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbjLNAfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 19:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjLNAfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 19:35:48 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDADEE0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 16:35:53 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-286f22c52c7so5497142a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 16:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702514153; x=1703118953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i/9vhns2rh5wNRAmTF+7unWvvWQlEhzdv4Zy/TsV5A0=;
        b=dows6p8mXur/wQfnC2iMggrm2+iC6D64PXF1sAfvsbWuSFFWhYoBySauIfISJ/rL57
         Kxojgw/YFXNYQ7bQBLzau7t+nEvmpwRzNX4UBozdB9RYsaXNYuueaWcDowrd8j53YXC+
         kIaUq5y1v16T886wbKGZcdxNAYD6bRywzasdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702514153; x=1703118953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/9vhns2rh5wNRAmTF+7unWvvWQlEhzdv4Zy/TsV5A0=;
        b=B+gDelcTT8qHbcYRHCcaA9vx4dygnSqPnrLNs4o2MHJFXnYlbGUVPhPYJWdC2Bsh5I
         34bFgAaxJb8iSgVasZF9cX0BBOLj0cGahJkZ10K1zQwmsROwpw88OezoqsgHGTvE8ySc
         IHEiDiUt7vUZ3Mx8p5rT+6/JFsyqOyEejO5CJ7jGF7reD0X1lIItzFF6W3Xpo5zPFMs2
         Guyqc3/9tU8XxpVXVD4t514Zh/TiqrzFdBe1UPE1ogid/tP8J5L0i5Yme1p9VlYaRrb1
         hgENwZzuAvncLlEFBQftByeHXLjaFN8aHLyN3SEKZay+b3coW0kvmjS+jiylTJwDFisb
         9SDA==
X-Gm-Message-State: AOJu0YxrsRYSr+/FplmJdzVlv8cY7ltJBI8z5casVsh6MWRQJMWmsvfY
        zifeeEyRSVcIhw5dPz4mYZCa3QwETkZRiUfiy27GnWLq
X-Google-Smtp-Source: AGHT+IE/V1gvqFNTDzqqMA4JhqSbG/LhKExowWOW95PGLRoZTgWORK8uZ5xecK/IINEs9HhgjSZDqA==
X-Received: by 2002:a17:90a:ba85:b0:28a:fd40:1650 with SMTP id t5-20020a17090aba8500b0028afd401650mr719467pjr.25.1702514153413;
        Wed, 13 Dec 2023 16:35:53 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:f03:a4cc:c5f:7040])
        by smtp.gmail.com with ESMTPSA id sk13-20020a17090b2dcd00b002864c14063fsm11879981pjb.20.2023.12.13.16.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 16:35:52 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sc7180: Switch pompom to the generic edp-panel
Date:   Wed, 13 Dec 2023 16:35:02 -0800
Message-ID: <20231213163501.1.I8c20f926d15c9ddc12e423e07df1e89db1105d93@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pompom has several sources for its panel. Let's switch it to the
generic edp-panel compatible string to account for this.

This fixes a problem where the panel wouldn't come up on some pompon
devices after commit fb3f43d50d9b ("drm/panel-edp: Avoid adding
multiple preferred modes"). Specifically, some models of pompom have a
1920x1080 panel which is _very_ different than the 1366x768 panel
specified in the dts. Before the recent panel-edp fix on Linux things
kinda/sorta worked because the panel-edp driver would include both the
hardcoded and probed mode, AKA:

* #0 1920x1080
  60.00 1920 1944 1960 2000 1080 1083 1088 1111 133320
  flags: nhsync, nvsync; type: preferred, driver
* #1 1366x768
  60.00 1366 1406 1438 1500 768 773 778 900 81000
  flags: nhsync, nvsync; type: preferred, driver

...and, at least on ChromeOS, the userspace was consistently picking
the first mode even though both were marked as "preferred". Now that
the Linux driver is fixed we only get the hardcoded mode. That means
we end up trying to drive a 1920x1080 panel at 1366x768 and it doesn't
work so well.

Let's switch over to the generic panel-edp.

Fixes: fb3f43d50d9b ("drm/panel-edp: Avoid adding multiple preferred modes")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Techhnically we could put a "Fixes" in for the commits that added the
pompom device tree, but that gets a little weird. Specifically the
pompom device tree predates the introduction of the generic edp-panel
bindings. Older pompom hardware always had 1366x768 compatible panels
and worked fine so techncially those old commits weren't really
"broken" per say and thus don't need to be "fixed".

For now, I've marked this a fixing the Linux driver commit that broke
ChromeOS userspace.

 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
index 0be62331f982..067813f5f437 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
@@ -141,7 +141,7 @@ CROS_STD_MAIN_KEYMAP
 };
 
 &panel {
-	compatible = "kingdisplay,kd116n21-30nv-a010";
+	compatible = "edp-panel";
 };
 
 &pen_insert {
-- 
2.43.0.472.g3155946c3a-goog


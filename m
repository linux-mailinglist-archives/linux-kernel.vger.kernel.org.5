Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3338D7F75CA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjKXN5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjKXN5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:57:20 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD551739;
        Fri, 24 Nov 2023 05:57:26 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cfae5ca719so877735ad.0;
        Fri, 24 Nov 2023 05:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700834246; x=1701439046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lZfKd9ld8EcpTSh9IkKiwQ19+m7m8h2U5B+9O8cLUt0=;
        b=E2g+876az5WH8ZNeF2Yj4OEj3RjbFNbWCppFCUNmzgsyQyLKo1j7x0RE+xErl2vvgp
         9dF0tqP7SmaQg10mTwzbXDIBm9aSqYizG5CrFMXKvn78G3g+qpo3mpoaD2v/qXnoRO8F
         HmzMlKWJQjnlC+6P9mzQ5jlGTSrPOpmKltj8DXarFxqwT2T6WGQtbVVtzk8UXzcKNXCn
         RkPQHKJsprtesqfArKB3R/dJUTc0nCwKkvwfpazkybwVpDzTT2eZnB8e4qafjezC49W1
         myLh2Zs6dmIXSGI76mLDKEk9xXhoRkFCEvh4P7dOQpBTuOMy+cfw/SvCGii0hOK9k9gB
         rPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700834246; x=1701439046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lZfKd9ld8EcpTSh9IkKiwQ19+m7m8h2U5B+9O8cLUt0=;
        b=A60WE5lkkK849PoQD0Hn3Hh16foFGZK13gm8YQIlzS6HJf+ubXxYBphQ5Annbilu3j
         LO8rXIHlp89ufCN2D2JA1aVJnc/4HEyqMDRBmh88u9Nz02kwfbM/LTU/XzprW0NoywuK
         qoivEs4t9MNKBs1CsXB8IBMLYfCtTVVfaG+qSvcX13ALLypoI2CNStoz8c+mO4xMiXun
         zKi3BQLVzvci46udMuQtm0jTYygEsg9kY5Z5h87jPO+wegWq7PK6dRnb0DXVY3rUEcjA
         +LOytGoMwVSoMnc6Cv38bJbwr0gfecWTyJgzN0YX/Cw5DaKahmbWTaRHi+6eSC/mv2WP
         PiHQ==
X-Gm-Message-State: AOJu0YxSlTl43W+xqc5ZS4HOm7RZ8IPGips3ZXMhQohtf3DyA8kSJFWk
        p7KWB3HEpxhkfvjjNfO7FzgjWfM55yU=
X-Google-Smtp-Source: AGHT+IHfZuSyuZePFumVf9GySSD7n+qcNQXMUctv4gMfBPItfnYRDBsORnIEhA/mbCC0XzaUz63wEQ==
X-Received: by 2002:a17:902:c713:b0:1cf:677b:6c2b with SMTP id p19-20020a170902c71300b001cf677b6c2bmr2419200plp.29.1700834246261;
        Fri, 24 Nov 2023 05:57:26 -0800 (PST)
Received: from localhost.localdomain ([192.166.114.90])
        by smtp.gmail.com with ESMTPSA id o9-20020a170902d4c900b001c3be750900sm3179417plg.163.2023.11.24.05.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 05:57:25 -0800 (PST)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH 1/3] arm64: dts: qcom: sm8250-xiaomi-elish: Fix typos
Date:   Fri, 24 Nov 2023 21:57:11 +0800
Message-ID: <20231124135713.5610-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two typos in this dtsi, so fix it.
  classis -> chassis.
  80700000 -> 80600000

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
index 85e5cf3dc91e..3d4ea428e4cb 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
@@ -23,7 +23,7 @@
 /delete-node/ &xbl_aop_mem;
 
 / {
-	classis-type = "tablet";
+	chassis-type = "tablet";
 
 	/* required for bootloader to select correct board */
 	qcom,msm-id = <QCOM_ID_SM8250 0x20001>; /* SM8250 v2.1 */
@@ -114,7 +114,7 @@ vreg_s6c_0p88: smpc6-regulator {
 	};
 
 	reserved-memory {
-		xbl_aop_mem: xbl-aop@80700000 {
+		xbl_aop_mem: xbl-aop@80600000 {
 			reg = <0x0 0x80600000 0x0 0x260000>;
 			no-map;
 		};
-- 
2.41.0


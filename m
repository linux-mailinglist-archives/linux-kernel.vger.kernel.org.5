Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093D37E0C5E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 00:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjKCXfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 19:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjKCXfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 19:35:50 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B03E3
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 16:35:47 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c9c5a1b87bso20541875ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 16:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699054547; x=1699659347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glqKkAPKAL3EHMHf844juTHG+DunzJOhi1xGd5NnG1c=;
        b=YIoppzqAkJO3cS+fn1+y1jvWXp+Rm5ZD3IMcFOEqKbj5a5Vv3nlTIwTfYAe+v0FkTw
         Qu+qBwFIn+Y2wOZM0DrhT+Nu2X+j1REkiwVyWAlklXIWqAlzeoHuZ9MbbgDMTn8XG9qZ
         IKeJ+fzpJI3Jxbp95QxqM1j572end4SyiInPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699054547; x=1699659347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glqKkAPKAL3EHMHf844juTHG+DunzJOhi1xGd5NnG1c=;
        b=tzxE7MZk7YCkSt0oqDIzR2jE1Wpeh4VKBvTCN467ROzR0gntjCwQpUC0/vgcZQq0CV
         Du0ozBsrQl/ytgLOKTtm52oq0rOT+cW6Tk5MMayX3VCyzLicr8E7wzdrvduW1ZN+izPN
         8xAE5GbnGWGdt4hbUpHJ3R4kVwVEcdPXRkdMr4EaMvBimpJB9IR+/vjOVTXKTHj26FS/
         zpBXJJ7buqX51Bhde5HG8nABKLUOSkQY5Bd/vaSC1qKf4TGtqGkSgNaGVsP0c02OkvFf
         DQotHv6iRBtiWDlW+iMFqhIEdWx2dVvYsd8Wv1MMHsKFajsYQ5KBTaSQ+vHJmKGe6IBr
         rBLQ==
X-Gm-Message-State: AOJu0YyfoquEz680Y27Jovjssp0+p65yUk6Ub+YwPgPk4RPdDaVuXoR3
        CdJLVe8EsN/vRd6brCxFVB8+2Q==
X-Google-Smtp-Source: AGHT+IESldym4inn9YATUmmbeyfTvQh1Z0+qOzIN7GxWrFVd6kUFyFVEeE0OwqhAo/+IL9HHXCZF+w==
X-Received: by 2002:a17:903:11c8:b0:1cc:7ebe:4db6 with SMTP id q8-20020a17090311c800b001cc7ebe4db6mr9731129plh.39.1699054547026;
        Fri, 03 Nov 2023 16:35:47 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:5195:5e72:f5bb:e3f0])
        by smtp.gmail.com with ESMTPSA id jg5-20020a17090326c500b001b8b2a6c4a4sm1878114plb.172.2023.11.03.16.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 16:35:46 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] arm64: dts: qcom: sc7280: Make watchdog bark interrupt edge triggered
Date:   Fri,  3 Nov 2023 16:34:28 -0700
Message-ID: <20231103163434.2.I11f77956d2492c88aca0ef5462123f225caf4fb4@changeid>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231103163434.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
References: <20231103163434.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in the patch ("arm64: dts: qcom: sc7180: Make watchdog
bark interrupt edge triggered"), the Qualcomm watchdog timer's bark
interrupt should be configured as edge triggered. Make the change.

Fixes: 0e51f883daa9 ("arm64: dts: qcom: sc7280: Add APSS watchdog node")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 04bf85b0399a..1964ef66492f 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -5389,7 +5389,7 @@ watchdog: watchdog@17c10000 {
 			compatible = "qcom,apss-wdt-sc7280", "qcom,kpss-wdt";
 			reg = <0 0x17c10000 0 0x1000>;
 			clocks = <&sleep_clk>;
-			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
 			status = "reserved"; /* Owned by Gunyah hyp */
 		};
 
-- 
2.42.0.869.gea05f2083d-goog


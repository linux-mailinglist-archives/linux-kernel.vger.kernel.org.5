Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054627D9B28
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346175AbjJ0OVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346151AbjJ0OUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:20:44 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C71FD69
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:20:38 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-540105dea92so3218615a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1698416436; x=1699021236; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P5guGXTewYW2n7ENQHk5doI6SalggtwyVa2pq9bebSs=;
        b=YbElE/gkBDVFDTSH/RWrKuDiKtnHbSyVTWPpjUPq3Lk3P3Ck4ZPmM7VoqC/XxV88ew
         XpvQuoiKxfH5/stFy2SraElgI1+uFx779cxNSV5W4/wJTAX30siM1XMCAmT//c/MQ/H+
         yUh4fjX2hurTWbjE9iJwdu93WIWGGjP40vx5yVAlAazTRhExVJ2hyWnAvbQATUFY4ijK
         N43stjbJ31Ig4kx1Tb0HXblOtxJOXF75gp6sfUd/eQT21vlDqtnvT8h+ckztj0/wm0Db
         uH6WY7NQom8w91hx/v1CFDy3itzooTopJLQ4SRrppKwgU2Y4PqsVkySu/LNDFk/kPXQf
         T/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698416436; x=1699021236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5guGXTewYW2n7ENQHk5doI6SalggtwyVa2pq9bebSs=;
        b=TSuFR8ptGWAvkZBa3oq6fCeQoamYP6HpxzZ7+JPYL66JtN/7D0FsOLlNAcaXN0uzQr
         C9OK8zAJNvudk91vybDbBszwHetUoxljjTe9cvaANOY+woXcLswCkhTx2YM+Wfbsjxy9
         LinyFAz9VfTkSml5gAEfGI7waEQGw3cseKj2Qt5eAkl4yNfJRoHa/WNYQ19/gSs3A0A8
         XPO19yx87Xndn3NRlIELMNpxVdDFGeCK6z9blMWxKx6aiYARZ0HBZFoKOQrBmLDAoHUy
         TBYTMYUBweOVDNRaoeTde5ceAbfoeVEMt4V3ddFY+/Ed66wwEvhDrDyTich11NWRWaf7
         JnLA==
X-Gm-Message-State: AOJu0YxOafPGUd13Shsb/dEjYs5KKviVLjhyImT5VIDHqzN/s/qFOsdX
        agsDd/CDQ/HCKuGzqzUnKqeaoA==
X-Google-Smtp-Source: AGHT+IEqhd3xjFLMsXk83BUinySE1dGq7Y+pY7lq2bAn6pmtgmZD+wMInipigYhd8Vm6tTkFIkGYOA==
X-Received: by 2002:a17:906:db04:b0:9bf:9c58:e91e with SMTP id xj4-20020a170906db0400b009bf9c58e91emr2101293ejb.56.1698416435955;
        Fri, 27 Oct 2023 07:20:35 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id z23-20020a170906075700b0099cc36c4681sm1254076ejb.157.2023.10.27.07.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 07:20:35 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 27 Oct 2023 16:20:30 +0200
Subject: [PATCH 8/9] arm64: dts: qcom: qcm6490-fairphone-fp5: Enable
 various remoteprocs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231027-sc7280-remoteprocs-v1-8-05ce95d9315a@fairphone.com>
References: <20231027-sc7280-remoteprocs-v1-0-05ce95d9315a@fairphone.com>
In-Reply-To: <20231027-sc7280-remoteprocs-v1-0-05ce95d9315a@fairphone.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the ADSP, CDSP, MPSS and WPSS that are found on the SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index cc092735ce17..d65eef30091b 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -490,6 +490,26 @@ &qupv3_id_1 {
 	status = "okay";
 };
 
+&remoteproc_adsp {
+	firmware-name = "qcom/qcm6490/fairphone5/adsp.mdt";
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/qcm6490/fairphone5/cdsp.mdt";
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/qcm6490/fairphone5/modem.mdt";
+	status = "okay";
+};
+
+&remoteproc_wpss {
+	firmware-name = "qcom/qcm6490/fairphone5/wpss.mdt";
+	status = "okay";
+};
+
 &sdc2_clk {
 	drive-strength = <16>;
 	bias-disable;

-- 
2.42.0


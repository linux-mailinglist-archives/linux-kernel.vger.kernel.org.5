Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280817E984F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 09:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbjKMI4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 03:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbjKMI4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 03:56:30 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF8310FF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 00:56:26 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54366784377so6447648a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 00:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1699865785; x=1700470585; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mASKoKAO36kXxxMIcfJoCKkWeIfM9SAibAagzp3xhpQ=;
        b=xzR8CkdFZFvjC5RM4klrN0DKCXoipWjgczpVUZDYiP74iCSmWvARruR7QKQd81Q8pe
         5JebVBXSwjgrgt+F68SUaySd+L/UnKxrUuSN69H+iBikOi8Q3DlBGWaddWMGLneO6C/f
         XUKnTz5N3XPGbcrg8gVXDHGSeWDPV1303y0IQRJzJVmtmS9aTxCHow/Tno5cfkQsWJMa
         RR4diMZNQgwzO1hoKnSZTYoG3+NlPbRKj1Q9onB9FPJhc6ARo1WQIrSVnx+kenk4ziXQ
         ZMT0G7qc/Jg1LDiRq5SgX70P8KsAdYC3hbDZOdR7jspAzk0YBOwVpZPyG1BBQ+diWQOT
         eg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699865785; x=1700470585;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mASKoKAO36kXxxMIcfJoCKkWeIfM9SAibAagzp3xhpQ=;
        b=NKf3jMTOP/UAZSrhJwvwuxwLLjGhgkTVb85OomnKyVq1hVyZh+EYR/v7KxZm0aS8xC
         97pNnZx/gCtqt2CIYY1dEDsqUfFt36rw5shPnmrBslHrCGPxFULQctnt2SzSIYRJRAVg
         6P9JNvZAuDZS1HWdnwjy44GZukweuoeCfYjx42bhHdKVbA8/AIHEQxMwnqssQ2/qghjs
         mN4WTnDDrEBVVj/Rdv9svdnYJHKnlmHq0GxeM8hI/Xch0yC7ERtKgHCeVnz8lFJ5Jaxy
         OHHFcOmZhbyp0i+1zG6lhi60FiYO/g/gGPr2r+jFcB2s7SHmTd9sQZs1KPVCXZgdX+Iw
         YBgA==
X-Gm-Message-State: AOJu0Yy+QrzpZOUTHSaFZDk4SMDNjxQRM7TXYmV4w7i0T6fFI2+r8ged
        V1Xy2V4CmJYkWO4r24r/ePGxnA==
X-Google-Smtp-Source: AGHT+IE7Xh4bAVV7Uk5gawxmAUg/+51LSmrF3fXwuOSPA/6+9It+cRS8vElyhWnE9YuoVEbsjK+vcQ==
X-Received: by 2002:a17:906:2a91:b0:9be:85c9:43ef with SMTP id l17-20020a1709062a9100b009be85c943efmr4563373eje.62.1699865784972;
        Mon, 13 Nov 2023 00:56:24 -0800 (PST)
Received: from otso.luca.vpn.lucaweiss.eu (k10064.upc-k.chello.nl. [62.108.10.64])
        by smtp.gmail.com with ESMTPSA id kk22-20020a170907767600b009c758b6cdefsm3673538ejc.128.2023.11.13.00.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 00:56:24 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Mon, 13 Nov 2023 09:56:14 +0100
Subject: [PATCH v2 03/11] arm64: dts: qcom: sc7280: Rename reserved-memory
 nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231113-sc7280-remoteprocs-v2-3-e5c5fd5268a7@fairphone.com>
References: <20231113-sc7280-remoteprocs-v2-0-e5c5fd5268a7@fairphone.com>
In-Reply-To: <20231113-sc7280-remoteprocs-v2-0-e5c5fd5268a7@fairphone.com>
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
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was clarified a while ago that reserved-memory nodes shouldn't be
called memory@ but should have a descriptive name. Update sc7280.dtsi to
follow that.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 0d9cc44066ce..7bfe93713eb6 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -91,68 +91,68 @@ reserved-memory {
 		#size-cells = <2>;
 		ranges;
 
-		wlan_ce_mem: memory@4cd000 {
+		wlan_ce_mem: wlan-ce@4cd000 {
 			no-map;
 			reg = <0x0 0x004cd000 0x0 0x1000>;
 		};
 
-		hyp_mem: memory@80000000 {
+		hyp_mem: hyp@80000000 {
 			reg = <0x0 0x80000000 0x0 0x600000>;
 			no-map;
 		};
 
-		xbl_mem: memory@80600000 {
+		xbl_mem: xbl@80600000 {
 			reg = <0x0 0x80600000 0x0 0x200000>;
 			no-map;
 		};
 
-		aop_mem: memory@80800000 {
+		aop_mem: aop@80800000 {
 			reg = <0x0 0x80800000 0x0 0x60000>;
 			no-map;
 		};
 
-		aop_cmd_db_mem: memory@80860000 {
+		aop_cmd_db_mem: aop-cmd-db@80860000 {
 			reg = <0x0 0x80860000 0x0 0x20000>;
 			compatible = "qcom,cmd-db";
 			no-map;
 		};
 
-		reserved_xbl_uefi_log: memory@80880000 {
+		reserved_xbl_uefi_log: xbl-uefi-res@80880000 {
 			reg = <0x0 0x80884000 0x0 0x10000>;
 			no-map;
 		};
 
-		sec_apps_mem: memory@808ff000 {
+		sec_apps_mem: sec-apps@808ff000 {
 			reg = <0x0 0x808ff000 0x0 0x1000>;
 			no-map;
 		};
 
-		smem_mem: memory@80900000 {
+		smem_mem: smem@80900000 {
 			reg = <0x0 0x80900000 0x0 0x200000>;
 			no-map;
 		};
 
-		cpucp_mem: memory@80b00000 {
+		cpucp_mem: cpucp@80b00000 {
 			no-map;
 			reg = <0x0 0x80b00000 0x0 0x100000>;
 		};
 
-		wlan_fw_mem: memory@80c00000 {
+		wlan_fw_mem: wlan-fw@80c00000 {
 			reg = <0x0 0x80c00000 0x0 0xc00000>;
 			no-map;
 		};
 
-		video_mem: memory@8b200000 {
+		video_mem: video@8b200000 {
 			reg = <0x0 0x8b200000 0x0 0x500000>;
 			no-map;
 		};
 
-		ipa_fw_mem: memory@8b700000 {
+		ipa_fw_mem: ipa-fw@8b700000 {
 			reg = <0 0x8b700000 0 0x10000>;
 			no-map;
 		};
 
-		rmtfs_mem: memory@9c900000 {
+		rmtfs_mem: rmtfs@9c900000 {
 			compatible = "qcom,rmtfs-mem";
 			reg = <0x0 0x9c900000 0x0 0x280000>;
 			no-map;

-- 
2.42.1


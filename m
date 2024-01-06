Return-Path: <linux-kernel+bounces-18732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E3C8261F7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 23:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49BF6B21A5F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 22:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA8A101F0;
	Sat,  6 Jan 2024 22:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4uLV6oU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A294101DB;
	Sat,  6 Jan 2024 22:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7ba8e33dd0cso40709239f.0;
        Sat, 06 Jan 2024 14:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704580804; x=1705185604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c8cx4G027Gz6iFuAIfhaAQlzyB7pPX4ipODK9kWLrHg=;
        b=b4uLV6oUIW5+bjhHmJXZMwI1o19KJ0VO/PC+GzwryYc0hcBeL4pPRjGFB+lPXA8qGj
         pAGcXXkRWvR1XhTtCFT033Xu5mo24w571QorytCXimSv6+QqAopjZ6ldIJbpNGg2P6FO
         rhltdVCBdRL9mHDRf0nH/LUlZ7/gBpKz3BM0z4Bdglfhf0MB8BHJnKK55kQDH7t6uAB8
         bYtHURLnU5xTl6SFQua2XH6/D0AvQGjmbpUz+LQE3ZpuoWgoSzz1h+LxThw96Tyl5zcF
         /KYoch82dDPaZ0xmQ6k8IvLFh5lzGUueUkhqJQQH6P6TarK28ZTzdvhHxAEYVAUu0UFQ
         T8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704580804; x=1705185604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8cx4G027Gz6iFuAIfhaAQlzyB7pPX4ipODK9kWLrHg=;
        b=ZvfBVQUVCmETVQtnzX+ELFDZ875QQjqoIQ7OL4RPVa6jFkYD9Ccel9gRltaaEJn0ZF
         rGl7WVzXSyPvYjtxETReffdLR2YznKgPNY4Upa94Wzl2LJ2NWvYbs3/lwe8OViZdqvkF
         6Wep6YI7BN9b0tuBTLwxKiyITZIriyJU1fe8WmtYUjFJRRhzJGHorfFp6gXeh6juXVw7
         MVcGSbivOfjZfHuCRCu5NDA9kcZS8+f+0MfodWtV6KjlPTX2EWgN50GKZJt8wsoU5E6+
         hVD8iVPl1SI7S0zyv3JxkNOwZyhJgKlg2JkwLPI+8mxQQeQd+7lEb1do7dVNpSoQYvn4
         /vcg==
X-Gm-Message-State: AOJu0YyGgBj9UIJwC+lW40yHywuqeuQribgl2eZDCIq/ojs5q030lGrB
	FgtprvFO0GMBepOYmuG3eP+u2KWQ8nRyHw==
X-Google-Smtp-Source: AGHT+IF4ssqcTFHr3Jn08b3Gd7DuE+48XGfS+pjvMKa/I6ROTT1Ogk6JfMsJzI/AFBbKn9NBmODzPw==
X-Received: by 2002:a05:6e02:16c7:b0:35f:f707:46ed with SMTP id 7-20020a056e0216c700b0035ff70746edmr2343459ilx.5.1704580804057;
        Sat, 06 Jan 2024 14:40:04 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:af2f:17f0:33a3:d6fe])
        by smtp.gmail.com with ESMTPSA id l13-20020a056e021c0d00b0035ffe828182sm735346ilh.37.2024.01.06.14.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 14:40:03 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-pm@vger.kernel.org
Cc: Adam Ford <aford173@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: soc: imx: add fdcc clock to i.MX8MP hdmi blk ctrl
Date: Sat,  6 Jan 2024 16:39:48 -0600
Message-ID: <20240106223951.387067-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per guidance from the NXP downstream kernel, if the clock is
disabled before HDMI/LCDIF probe, LCDIF will not get pixel
clock from HDMI PHY and throw an error.  Fix this by adding
the fdcc clock to the hdmi_blk_ctrl.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml
index 1be4ce2a45e8..741b5d8da4bb 100644
--- a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml
@@ -42,8 +42,8 @@ properties:
       - const: hdmi-tx-phy
 
   clocks:
-    minItems: 4
-    maxItems: 4
+    minItems: 5
+    maxItems: 5
 
   clock-names:
     items:
@@ -51,6 +51,7 @@ properties:
       - const: axi
       - const: ref_266m
       - const: ref_24m
+      - const: fdcc
 
   interconnects:
     maxItems: 3
@@ -82,8 +83,9 @@ examples:
         clocks = <&clk IMX8MP_CLK_HDMI_APB>,
                  <&clk IMX8MP_CLK_HDMI_ROOT>,
                  <&clk IMX8MP_CLK_HDMI_REF_266M>,
-                 <&clk IMX8MP_CLK_HDMI_24M>;
-        clock-names = "apb", "axi", "ref_266m", "ref_24m";
+                 <&clk IMX8MP_CLK_HDMI_24M>,
+                 <&clk IMX8MP_CLK_HDMI_FDCC_TST>;
+        clock-names = "apb", "axi", "ref_266m", "ref_24m", "fdcc";
         power-domains = <&pgc_hdmimix>, <&pgc_hdmimix>, <&pgc_hdmimix>,
                         <&pgc_hdmimix>, <&pgc_hdmimix>, <&pgc_hdmimix>,
                         <&pgc_hdmimix>, <&pgc_hdmi_phy>;
-- 
2.43.0



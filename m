Return-Path: <linux-kernel+bounces-82450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A47C8684B6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EF3E1C21E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EDF136984;
	Mon, 26 Feb 2024 23:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UITuB6wv"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD42B135A50;
	Mon, 26 Feb 2024 23:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708991148; cv=none; b=nk2zBNWvXfE0YN8FwBhvso05Qm9KJfflOnWwKOfsqrk13MQuizIfc8WPk+8Us8WoV+097uXN4oJVLsO8DWdkdXxTSHKlJsMKyrBDPugxvq0m7PfH2Krzyyg5NLQw8VSn/FMWs3Ar63E/Lu7YbZt2rUYV4vm7WmsMUxGgfQRkdQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708991148; c=relaxed/simple;
	bh=ELvNOGdyWujRqFlgFnplgvQfFBySmgvbj61MCodDqJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nIb/52PZYLJtUcq7iZ48PONKSFMRYE9cjrBal/0oSfpSh7OhGmZhFWJNDl8U1CbVOuNk3gnjKAXbnscdEuVA5a9pFAWeiohyYmBpXYmMeCJkb8WMz8meu0wWWWmdEPftLrFet0KJkSxJFT3BaaF3MbAFwpDLlYFJ3daBRAH5x2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UITuB6wv; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7c7770fd687so212258339f.3;
        Mon, 26 Feb 2024 15:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708991146; x=1709595946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFej3XRK1im9Jtb1YXeIJeL5LA98qLbzr4AabBMlz7o=;
        b=UITuB6wvFBaLPm7+GMN8GkKkNbxqmW6hjsT931ZImtMlKKpZjOescH5UVC8pnHF/Cj
         8/hcjOqLpcV5lcvxI3lqVvUkzQakMqEDmlFHMvpHdV2CyXsCWKLWc9XKM+WL49/sAZsr
         iEtivSbMj6Eo7rjP9Ofp+BOXhOLzOstqZ53BadViakcBWH1hNvyrE/SlObZlonucu4Cx
         mlWS/VMbKuLnZ87erzh4DebXSThuTS4w4gQPdjCD3V6TQMJt9Zew3iUKw3Iv3K2/aHle
         4MCylYpTJpQc1zORl9Ejk61fkvHsYJO9AhnzOiL4j1hv8F2vKVHa4CFes4BbN82Q8EZk
         l6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708991146; x=1709595946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFej3XRK1im9Jtb1YXeIJeL5LA98qLbzr4AabBMlz7o=;
        b=NxdgZkf4vmw04BM88PDKFIZbV75ePIq4OnMkzQoZh9N7aou8211tDsLsCjAP1fJrpo
         1mPxeFEOoEafTaRDA/2IBUPXhCpIWEUe1J74+x8DKpcxYxS3wb+q53lNnRaou7ZUH1/l
         tA+E1jVUfapXWSITzTsoM8ffqQPNgv25WZa2p/EDZ65WMU9e8Jke6ZbaqlncFHQCjFuc
         ka6mjpJmyjQN/Sjr7wxTWGdEk02Ie3ohPN11bQIIReIM3p9xH0UVtecxFCw2gkW+b4jI
         M0eTj/dIsnzrAZ6C8nUnjvK9Kdcy/H3tNH+4npKOte3SUiuZ6vvoz8sa5lJwu3j16K6P
         IKPw==
X-Forwarded-Encrypted: i=1; AJvYcCVe3p75jZT6O/K2lbqP0OAuGs0l9EcUhCxahKLOIYGQkkv3Bd1Tt9Eo88Nsl7vy4SNtUrfNLH9h4451lth4QjAOzudYMN9LinzsNTihLn6sILjmDPQID0ij18YHbWtrbXKX/kzCjIb89g==
X-Gm-Message-State: AOJu0YwIqWL2ZcdisyHUawzBGG8f3LNj9xueq4yE7wqWoDaaajV40oJ5
	uHJbdl1k+QNaylzVkh2gPKeyT5T34rIX4GPSpOMBd0qsVkvIpurN
X-Google-Smtp-Source: AGHT+IEb//qk46NpdfE5g1O4nEXqBzzNmsQuvytZzFjujQ6auNCCTdAjrykOBRp3+Zzg/p2HzsqIhA==
X-Received: by 2002:a6b:6513:0:b0:7c7:7f22:c0f0 with SMTP id z19-20020a6b6513000000b007c77f22c0f0mr9117706iob.18.1708991145668;
        Mon, 26 Feb 2024 15:45:45 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:9c95:d061:819a:2ab2])
        by smtp.gmail.com with ESMTPSA id c25-20020a023319000000b004741cf1e95esm1545317jae.11.2024.02.26.15.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 15:45:45 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org
Cc: aford@beaconembedded.com,
	Lucas Stach <l.stach@pengutronix.de>,
	Adam Ford <aford173@gmail.com>,
	Marek Vasut <marex@denx.de>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V6 4/6] arm64: dts: imx8mp: add HDMI irqsteer
Date: Mon, 26 Feb 2024 17:45:15 -0600
Message-ID: <20240226234532.80114-5-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226234532.80114-1-aford173@gmail.com>
References: <20240226234532.80114-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lucas Stach <l.stach@pengutronix.de>

The HDMI irqsteer is a secondary interrupt controller within the HDMI
subsystem that maps all HDMI peripheral IRQs into a single upstream
IRQ line.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Adam Ford <aford173@gmail.com>
Tested-by: Marek Vasut <marex@denx.de>
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
V6:  No Change

V5:  Increase size to 4KB to match the ref manual

V2:  Add my (Adam) s-o-b and re-order position under AIPS4
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index c9bcb6641de7..18bfa7d9aa7f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1927,6 +1927,19 @@ hdmi_blk_ctrl: blk-ctrl@32fc0000 {
 						     "hdcp", "hrv";
 				#power-domain-cells = <1>;
 			};
+
+			irqsteer_hdmi: interrupt-controller@32fc2000 {
+				compatible = "fsl,imx-irqsteer";
+				reg = <0x32fc2000 0x1000>;
+				interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				fsl,channel = <1>;
+				fsl,num-irqs = <64>;
+				clocks = <&clk IMX8MP_CLK_HDMI_APB>;
+				clock-names = "ipg";
+				power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_IRQSTEER>;
+			};
 		};
 
 		pcie: pcie@33800000 {
-- 
2.43.0



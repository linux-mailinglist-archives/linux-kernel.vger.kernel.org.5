Return-Path: <linux-kernel+bounces-60539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7A2850651
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 21:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D08B0B24D5B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 20:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B778060240;
	Sat, 10 Feb 2024 20:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zco0K7Uf"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF1B5FEF8;
	Sat, 10 Feb 2024 20:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707597989; cv=none; b=HhdsWWPemgAdUSUKgqmhk835g3zkDllH5Sft0Twz/L/pt/9odw9b4J1lli/1HqqzIqwdOZGNoQGw8xXs/7Yy865NGYMBbqzc6Yv9QDQKQqoH1IvoH4nTzU0VcKLiFS0uR7YJ2OvzDivcJf3xBCGKNloOw9cMDkmk9uqKRVFzGk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707597989; c=relaxed/simple;
	bh=ExzBrVuqksVr/KkFLLfHPtMh/Ra5beb/+0XDkYW4dqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oiDsmcepurmcB+kbcIpki02edSyFV8lwJK+zv3zYbI8qJ4askknmFAuJngpRzkPuHJRKPtUe12JwR4ouuz2LheAMP1hrBmWgzP6oMv9Fr/65iIIhqjPWnAzlOpWzt8kx/Esj3NyO1/LMo2/E5B4gP+PxUzpDqA7HN8V2zdXjZkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zco0K7Uf; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-68ca1db07ceso11384096d6.2;
        Sat, 10 Feb 2024 12:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707597986; x=1708202786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMB30/edT3Hx3KxbOqd/+Af8cP2PAzP5WuJfM5yzKlc=;
        b=Zco0K7UfsWdbqOTS99zmHn/e7B0tn4hNs145Do811DweSgLte/nTIj+wKIcVmcNOHB
         VlN0qqlKjBLhzPT1br9e7AMSKTsAFWVLRS+IQocr8m8X+NmffUV/t1jqppAM8VRjA/wV
         yG8DCRwg6uP/comiUyecQhFfGVwn0DoLfp6oAM8nVhJyjVXqd+oA5onV2p4T8QX8drzF
         UGwlatiorEmHcJ4Z3axj8RAGxQsPPXsiSyVk1cBxac2tvCg/Xv2tpH3OAgBuYJ3TAVd/
         OGubZpR/+p2vUjvQ1GNSLps3h4tYNs4mbmJyAgmaYe0uSXDD0h4VdTv8wNQu3bMsL9el
         1KVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707597986; x=1708202786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMB30/edT3Hx3KxbOqd/+Af8cP2PAzP5WuJfM5yzKlc=;
        b=LkXjMAnOf/Wy2GIOuxvr/FPenBeF3s8iKBiHOcc3n9e+QUoy80Nr7ENlKq2SQOEVtZ
         yE6jJiZ+HgvNiuPEXLER/M4b3pM2R8DEDQdJ9rq1+nm503zaM3ydpxkEZ6/6OEBWy8PD
         nywEXTdiWI5F326azz5oG5plHx3ijR90Wlr5UFknWpi+CGyWAlN/2mQ8szOVBYL/ztCo
         m38m8JNY2fBktqyXB6g+/jPxwlSKMJ1lCw563X2sOowMPSEfa2un7zELmTY21ZhB7tlQ
         EoO3lXhCJRFihxrQ6rE0NEylGGKdYAXfGNSqUZmi7OzDuLf+UQbLjA3FVjbsv4U94wzZ
         TT1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhkDrVSbSV+cqo6Sj8v5EShubbTYdTarqyuaiE588sqfyOcnMPu7HMws3cOM81WIAlvtb+4VilqlAOgC4BdtoRcdnplhSGYgf1ow4RBwC2peyt27dU9NHwWmuS02qRJcXEAixQIFDztA==
X-Gm-Message-State: AOJu0YygtS1C5XEgy2asI3/0K0bMCGLL1zP5l/m6YkmTh7CkSflYtRC0
	j/D8fz9YtZ4YT1oiQHqTUJk8jW7+P1PrAdb6wRb/UhOREnGp7aj3
X-Google-Smtp-Source: AGHT+IHjWG+LOJylc03v3MtAQG3d2LHUxPk6oYRnsBvvHyMXOgvEM0QXrtAjkmdVQ3pkSzzt95ttLQ==
X-Received: by 2002:a05:6214:1c05:b0:68c:74a7:9e21 with SMTP id u5-20020a0562141c0500b0068c74a79e21mr5329427qvc.3.1707597986373;
        Sat, 10 Feb 2024 12:46:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXN808d0aRSjf5Bqe9DdeRZfOtW9W4eMEJH40oYyA4zjEbOARPlzT0KP9a+s/pLSAVsPaJKqHLxnvXiz4NixVZHlAzJfXMlz5twjePJSsPp2R7zb+6mQUw2HBcZCi6zFxqWlFgeK8Q2G+m5GppmxP4SsOQXiNzWhF8Ans9O/Xdr2xL4ZjqJslLjH3pkmg/5s8vjPeN/9MSpysmtmRfxYLdGASQ8BHwsm3kBcWr+y1ZTLcjt3mmsSmU8/0bdFghx2CM4HPcbnrxbk0ZsjYcBpfHe99BMcO+BslMOSsHmdvh2bXd8+JxWId2ZzaTfTW7VFpX88ckWlWiMnjBB4sN1hPCbPdfuuUeY3sMYEDmrUm9s3e9UQHwi8GU9DKdJnrVDoz62ZEgL0GTq9V1xp3dliHeDpdND5rr7hxr3+1KmcZeodj00EbfowlmMPL80zapmgW30jjYXvvE8bu2vKeg3T0BwX49yxDt+EvSh0oVla1EFzxJlvxUiP+Yl6vLdaRJXk9pQD0CEfBLg8crAMFtmQSQInW/rB+G3+ZhVY7D41DPcJ5gqyFXx7KASGMKk/cXCcHgxpDNgwXeaRAWNG2719aAFem6dUxzveffZNXcU0yezg==
Received: from aford-System-Version.lan ([2601:447:d002:5be:27d7:3989:2897:88a7])
        by smtp.gmail.com with ESMTPSA id m20-20020a0cdb94000000b0068c9db26ae1sm2079526qvk.41.2024.02.10.12.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 12:46:25 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: marex@denx.de,
	aford@beaconembedded.com,
	Lucas Stach <l.stach@pengutronix.de>,
	Adam Ford <aford173@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 4/6] arm64: dts: imx8mp: add HDMI irqsteer
Date: Sat, 10 Feb 2024 14:46:00 -0600
Message-ID: <20240210204606.11944-5-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240210204606.11944-1-aford173@gmail.com>
References: <20240210204606.11944-1-aford173@gmail.com>
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
---
V2:  Add my (Adam) s-o-b and re-order position under AIPS4
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 0730d4cf9bc4..9b8ab367d774 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1927,6 +1927,19 @@ hdmi_blk_ctrl: blk-ctrl@32fc0000 {
 						     "hdcp", "hrv";
 				#power-domain-cells = <1>;
 			};
+
+			irqsteer_hdmi: interrupt-controller@32fc2000 {
+				compatible = "fsl,imx-irqsteer";
+				reg = <0x32fc2000 0x44>;
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



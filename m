Return-Path: <linux-kernel+bounces-84092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E152486A220
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9859D283EDB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9602C1586F9;
	Tue, 27 Feb 2024 22:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1hh3BO3"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8882D158D62;
	Tue, 27 Feb 2024 22:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071514; cv=none; b=XsRCA45dq63vr/ZsFcSwUrTu49guEKOm6RwjoYf/Q+yb8uXSTNpbAbBKWjwCjDBEugkEINW/BZEYmtVPqsbwPtXq+Q16CbXDngt+qDV5KwNLjUxGyw6wJuxOB1/7ozwUW4dFzz4BVG3AVHDTsmT1/hY8graTGQtW0M0MplwlqNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071514; c=relaxed/simple;
	bh=Daep0Slfrtw0Ds07RH4d7jSApXPXFCQGE2TgTpYU9Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9NOsvRBuNvhfsTn+MJgeKUYM9soC8DfuN85H+TNYtQUZWlf9aVOZody9uwD5nX8O6vxPdsfTFypolsJZS/CgQK7kLNykok1H1epdncAmKx8T4MEW2COFppAs/yC+VTlQZcGXSMTmwa7oJKzMokemEu70z+6rGeZTpGsdqvxFjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1hh3BO3; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e0f43074edso3298112a34.1;
        Tue, 27 Feb 2024 14:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709071512; x=1709676312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pg+umx5FUIJdMs3diOaBF+zl4OepmD7HnZ+prHeGKsA=;
        b=L1hh3BO3W6NB+9b4t/ApCs1o1UuCHkKnezpMBhE01OoU4mcEcHXG6+trsVsaEU/ecG
         S6kn5/iVepX9MaGYfTMS9725qqqZs+kcG0dOvgvLr0+YmQBz8iyHgTnDAlMg1fXdXEDi
         Nj2GsbJyNrj/MSC8s7Xn7OCzkO4PjJQvjH54aTlmU6Ox2EFN/8TwL5NYqAmK+kyTKoZu
         w2ou58bFqs2Wo3e9CWNUtBc9Nmb6If+BKo/cZabSZLVy7k4wyLQ8/xN+qqfE5NZNAjOK
         3UzrBfcaLIzvvfcS2/vBDKEQa/SNFrtjkuvqCXEIrK1wYCeOj+L39mABmMdtGAAPJRfD
         iy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071512; x=1709676312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pg+umx5FUIJdMs3diOaBF+zl4OepmD7HnZ+prHeGKsA=;
        b=TLSarUTJTvTLF/VR9TLxCNOxccIgiXY/mrnIWCEqbjzhuHRY2ABiGxP3/L6C6RLokj
         ZRM/riLPoOrqmiioIIvEQhe5ffciyO6Xy+W1U8oEG1EijgpDCIPvIxhA5UavqGrQYayd
         RUtVPp48thyvSZqjZGtLCpX2ruwPGOZKqhxklK9gY78nmk8buwDbqumV3iFXaK0U2ex8
         Wc3YngkA5oqI1axkotxmxTIauqDd5QlzydZOlF6ylAeencYjmw/axFdqOz3Zl7Ecy8Co
         RdU3op9pSQdYBCWHCrPtwaPf3MtE9nPJaWetvhR69uOB6ZYOa7clMyuYlASh4MzWYDw+
         Z1Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXj83BdAC9IkWMLnmVnDcoFBslwNYBumIGsV81KKEslnfIC1kDgOukrxn5noUJEbepghH9NKe4iUennRi+P2QIXCM0ZY7E3Ou044mQ27rD9NGtqjKXtH+5+Z6iKEJ2pQs+7u6xCtbdvCw==
X-Gm-Message-State: AOJu0YxZpsk5ZW+bqwCiM9ADb7n5MbqW2F46NBMGrq8KSd55WOlhtArP
	ovEQO5qPS5szBpT53/OH23Xavfh41YPAGx8bdLABfMti5bDjzxem
X-Google-Smtp-Source: AGHT+IEmWreknrcyf09k6m1PvVcfqFMnpM75hkf6hTSSVFVvDaq/6FD0SFqz9UMfV4yL5nvUNAshIA==
X-Received: by 2002:a05:6358:9496:b0:17b:57c9:dddc with SMTP id i22-20020a056358949600b0017b57c9dddcmr8981848rwb.5.1709071512522;
        Tue, 27 Feb 2024 14:05:12 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:9ee3:b2ab:6ca:180d])
        by smtp.gmail.com with ESMTPSA id c12-20020a0ce14c000000b0068fc55bcf6asm4569556qvl.119.2024.02.27.14.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:05:12 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org
Cc: aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
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
	Lucas Stach <l.stach@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 6/6] arm64: defconfig: Enable DRM_IMX8MP_DW_HDMI_BRIDGE as module
Date: Tue, 27 Feb 2024 16:04:40 -0600
Message-ID: <20240227220444.77566-7-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227220444.77566-1-aford173@gmail.com>
References: <20240227220444.77566-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i.MX8M Plus has support for an HDMI transmitter.  The
video is genereated by lcdif3, routed to the hdmi parallel
video interface, then fed to a DW HDMI bridge to support
up to 4K video output.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
V7:  No Change

V6:  No Change

V5:  Added Review and tested-by from Luca
     No functional change since V1
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 34681284043f..ee644d27652b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -887,6 +887,7 @@ CONFIG_DRM_ANALOGIX_ANX7625=m
 CONFIG_DRM_I2C_ADV7511=m
 CONFIG_DRM_I2C_ADV7511_AUDIO=y
 CONFIG_DRM_CDNS_MHDP8546=m
+CONFIG_DRM_IMX8MP_DW_HDMI_BRIDGE=m
 CONFIG_DRM_DW_HDMI_AHB_AUDIO=m
 CONFIG_DRM_DW_HDMI_CEC=m
 CONFIG_DRM_IMX_DCSS=m
-- 
2.43.0



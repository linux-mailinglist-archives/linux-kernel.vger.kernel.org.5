Return-Path: <linux-kernel+bounces-11032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6F181E052
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 13:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64D71B207B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 12:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDBB53E24;
	Mon, 25 Dec 2023 12:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHINl97K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868D5537EA;
	Mon, 25 Dec 2023 12:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d2e56f3a6so20869495e9.1;
        Mon, 25 Dec 2023 04:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703505821; x=1704110621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wA2GwbVoxb7vt9RNqPQ+B0nt5JREg2MA/Ix8qlZazuQ=;
        b=UHINl97KfiOfAkMwIvALRAnsx4LD8X+vYZLVhacroj9F30aNr8ZYo9bfUCu5CMahmH
         ncy8RWNt2hgeEfUN/E+9mOc0ON1LUq3oOOD/Whf0u5zEoiYaff+J8JM9NeWlHEwfr3/A
         Qt/t+2TaLY/gxaEnmH98yWSzaI7XM0iQTp4a5jf+NPRuDGGUdlgBs1GPezz0Y5iJq0lW
         3F63rKW1mT1QeJVRD6KbKbXoqSPY4NHrVFyQ3YkAWpaKLnjr5vLKL55dfcMCcRJwBtMg
         cOrrsfFgruIp7yXmDpYAk3POmhL4MHqsnjwkpeCaiInrGrqWGrO8q0qaWzljk++zCgdh
         WlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703505821; x=1704110621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wA2GwbVoxb7vt9RNqPQ+B0nt5JREg2MA/Ix8qlZazuQ=;
        b=noRECX1wL3y3QIBC4Alw0Ss28KR6fWWPJb2zFp8WpvjnbvklqQIRjepFuTmPAbHCso
         09q7VNEj/JBTwRbj3qdB7rY87lgpXydmqUrtpEvTzKvxKitIsBQ/9upiixA5vImR6ugP
         9TQy9ICwwTys8zij2LWKuLcS6AhMZzJT9rtmuNJGTCKuqoJhkjPWbntYoQ6OXTc6dFnc
         p49p45qLoY+UbihgPLwTTB36f8q48rkkD1XuORLDKwgV2emp2QAIfwrHuO0fwi6OadC2
         X7HjvYLHomB+/lAkCxMPxOLNMqaTWImuRXBANisxeOrhNynpr6UHo2/hlmUA4FT4vdbW
         K5AQ==
X-Gm-Message-State: AOJu0YwCztcqxHK5ZsZGd11ZDA7G7o8VwtncWzKZjTYrNvyHNlLNR8jx
	K3JFmrnT5b+AdOZwwZo5bQ8=
X-Google-Smtp-Source: AGHT+IFC0NQhcxu6RcuvKfgUGzeb1uVPeKQOxXZlwOy4+uTIL/cxXPsw2nN6RyAnz8JE2poyss5tRQ==
X-Received: by 2002:a05:600c:3548:b0:40d:4d60:5276 with SMTP id i8-20020a05600c354800b0040d4d605276mr2111975wmq.142.1703505820534;
        Mon, 25 Dec 2023 04:03:40 -0800 (PST)
Received: from david-ryuzu.fritz.box ([178.26.111.208])
        by smtp.googlemail.com with ESMTPSA id 14-20020a05600c020e00b0040d23cea7bcsm6349456wmi.1.2023.12.25.04.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 04:03:40 -0800 (PST)
From: David Wronek <davidwronek@gmail.com>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joe Mason <buddyjojo06@outlook.com>,
	hexdump0815@googlemail.com
Cc: cros-qcom-dts-watchers@chromium.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	David Wronek <davidwronek@gmail.com>
Subject: [PATCH v3 5/8] phy: qcom: qmp-ufs: Add SC7180 support
Date: Mon, 25 Dec 2023 12:59:58 +0100
Message-ID: <20231225120327.166160-6-davidwronek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231225120327.166160-1-davidwronek@gmail.com>
References: <20231225120327.166160-1-davidwronek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SC7180 UFS PHY is identical to the one found on SM7150. Add a
compatible for it.

Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 3c2e6255e26f..0276de802d78 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -1880,6 +1880,9 @@ static const struct of_device_id qmp_ufs_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sa8775p-qmp-ufs-phy",
 		.data = &sa8775p_ufsphy_cfg,
+	}, {
+		.compatible = "qcom,sc7180-qmp-ufs-phy",
+		.data = &sm7150_ufsphy_cfg,
 	}, {
 		.compatible = "qcom,sc7280-qmp-ufs-phy",
 		.data = &sc7280_ufsphy_cfg,
-- 
2.43.0



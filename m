Return-Path: <linux-kernel+bounces-133935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D7D89AB1A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921C11C20C62
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 13:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA8236B0E;
	Sat,  6 Apr 2024 13:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fC0yWUPg"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96807374C4;
	Sat,  6 Apr 2024 13:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712410648; cv=none; b=qSUxVKZhkOHYX4JHjEgfGTByZZb4+SsFR6acpUvaxgiWD+jdwr8Vj1N7qnzFoxgZ6IwpH/3MkPm2V8XXPse9hoS85+6ygt87eabEp0ApKgLBhZEb29PkZZFSjH+bXrOSddgDy73ehUwESNQ325Da6WTdGXKi/cT333KDmz3wKQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712410648; c=relaxed/simple;
	bh=x9vBbBPJ0M4uDqwxedwx2EqtJY1p6kyMp8WzLcoxG+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XzzUdcMhU/6Da0EOLFw+lwm8L+r8+WY+OFtE88WJ6o/8cvD9VAqAaqWnQm/tlLRt1t3EK9JLvsiNRdR7k8sMETpfCFn953DeS6SdWwwisx5/8XWiNsou96luPlQHPE9N0WEV0RmZXVqg2CAnvbDpoQhdh6GFjikXf/vL9xwgLt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fC0yWUPg; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4162ec14805so15574255e9.1;
        Sat, 06 Apr 2024 06:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712410644; x=1713015444; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+WLAnNCRu6P4N5RNkCdLMJV4Al/A3hve5ECn2W2mAK8=;
        b=fC0yWUPgSjLy/qV6U7t72gizodSUEWFLya/wz3lW2y/jlcjdmRDY7grpbRCs1jk70D
         9c9Kgw8nqmzLjeM1ZWeLHoLa5F/qfCH6QDihzzZP0/bMugVEpCSoCJXL7QPolU+Wk14I
         n2bDhBafOnWOn8bnxYp2MwxVwE43U7UTE8HPBaQPiHlmyUjTn6cl+ZXEreIKZ9M0ljzb
         duibdp9t7oWQpje1fknWSaL09pi/mpSEkr7XJRyM7yxNC+kPhgkqXuMUXHNDVxd6PEx2
         ehvV2NRniS+TXT0LGhbDojTTgu5GkLt0Tg5HH5Fs8v3wQ0/0lqAOXj7jfOOPDOZyqYIX
         rvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712410644; x=1713015444;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+WLAnNCRu6P4N5RNkCdLMJV4Al/A3hve5ECn2W2mAK8=;
        b=wFrGhruhzEEbWHMwEzeiG/Tr5Nv8ipna1lYkfWGpmrgpEhgRcE5ZxVxs0RG/wFv2d+
         SaqJ/GedFwZs8yQFt+YO7Mp/ucJjLHMCDhpn0njfMunEqtfzXUD3yxf1/lbnDFzprfhC
         vLnR34KPYG+X8OTFtiJPedmbFDeJ6ICcH7I7d2tY2MuG6FKkgu1GX3eT9ebIv/39FsKY
         UAlwmxpnvYVwLBU1SyYoBaep0X1hE3ebA1NosY5OARUHIcCdovmFUy38Bu3ZkLrp2QBU
         znZ1a3ADEBUVaNJneoAlVF0fMPpRk1INoz+S4Y+wWM9oSaG2fbZtFf4/rdqnNRhX1Ijf
         RCHA==
X-Forwarded-Encrypted: i=1; AJvYcCUogqiOVQLcy4uvna5yqexHp+nBANS2cstLTdcYnM2PgaMfnRd/KeV9kPmi0cacw+5vwFyIw7LSDPrKKgY7HRoJSN8KDTIQt9F4lg3M
X-Gm-Message-State: AOJu0Yz1d8Ff+TCeLra3UGEruohDiFZFHLs+IWWQ03gmsqpLCO/nxTNC
	IXAenWfhhXpIcX48kKN/1DXbJUg6lnBB+Io0qIdnxAaHQoK3/6td
X-Google-Smtp-Source: AGHT+IGJuEOafaI7+tCV7vsTYfc7mKh6m8d0wpe81NoSi6m5Vkv9sw2ORNDcFFTz+9IabAg6YVanUA==
X-Received: by 2002:a05:600c:3c88:b0:416:2f05:41d with SMTP id bg8-20020a05600c3c8800b004162f05041dmr4456038wmb.18.1712410644031;
        Sat, 06 Apr 2024 06:37:24 -0700 (PDT)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id z22-20020a7bc7d6000000b004162bd5ba59sm6510510wmk.39.2024.04.06.06.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 06:37:23 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Sat, 06 Apr 2024 15:37:09 +0200
Subject: [PATCH v2] phy: qcom: m31: match requested regulator name with dt
 schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240406-phy-qcom-m31-regulator-fix-v2-1-c8e9795bc071@gmail.com>
X-B4-Tracking: v=1; b=H4sIAARQEWYC/42NTQ6CMBBGr0Jm7Zi20BJceQ/DomBtJ+HPVhsJ4
 e6OnMDle/nyvg2Si+QSXIoNosuUaJ4Y1KmAPtjJO6Q7MyihKqGUwCWs+OznEcdSYnT+PdjXHPF
 BH2xqrbWtjBadBA4s0bE+4reWOVDi6Xp8Zfmzf2WzRIm1qXVX2Uaarrz60dJw5jW0+75/ASJjI
 m/EAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.13.0

According to the 'qcom,ipq5332-usb-hsphy.yaml' schema, the 5V
supply regulator must be defined via the 'vdd-supply' property.
The driver however requests for the 'vdda-phy' regulator which
results in the following message when the driver is probed on
a IPQ5018 based board with a device tree matching to the schema:

  qcom-m31usb-phy 5b000.phy: supply vdda-phy not found, using dummy regulator
  qcom-m31usb-phy 5b000.phy: Registered M31 USB phy

This means that the regulator specified in the device tree never
gets enabled.

Change the driver to use the 'vdd' name for the regulator as per
defined in the schema in order to ensure that the corresponding
regulator gets enabled.

Fixes: 08e49af50701 ("phy: qcom: Introduce M31 USB PHY driver")
Reviewed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v2:
- rebase on top of phy/fixes; ee13e1f3c72b ("phy: qcom: qmp-combo: Fix
  register base for QSERDES_DP_PHY_MODE")
- add Reviewed-by tag from Varadarajan Narayanan
- Link to v1: https://lore.kernel.org/r/20240220-phy-qcom-m31-regulator-fix-v1-1-7675b4a916b3@gmail.com
---
 drivers/phy/qualcomm/phy-qcom-m31.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-m31.c b/drivers/phy/qualcomm/phy-qcom-m31.c
index 03fb0d4b75d7..20d4c020a83c 100644
--- a/drivers/phy/qualcomm/phy-qcom-m31.c
+++ b/drivers/phy/qualcomm/phy-qcom-m31.c
@@ -297,7 +297,7 @@ static int m31usb_phy_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(qphy->phy),
 				     "failed to create phy\n");
 
-	qphy->vreg = devm_regulator_get(dev, "vdda-phy");
+	qphy->vreg = devm_regulator_get(dev, "vdd");
 	if (IS_ERR(qphy->vreg))
 		return dev_err_probe(dev, PTR_ERR(qphy->vreg),
 				     "failed to get vreg\n");

---
base-commit: ee13e1f3c72b9464a4d73017c060ab503eed653a
change-id: 20240220-phy-qcom-m31-regulator-fix-97555a4650b1

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>



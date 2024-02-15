Return-Path: <linux-kernel+bounces-66682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2390A8560F8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2280B37266
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC26413172F;
	Thu, 15 Feb 2024 10:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P/94mqqZ"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E6F130E2D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993585; cv=none; b=s0D7QySkqLpJLHgbYx4VFlykKuchu9K3At3UNHOpofZ1HKga+kdrvOMJVPNwRtEuQwcztdDjVcyDItQCafYZxuD41xTbeH//gIjduzWKFWjJAu7dqCGD4eS0S3PuW5s4A1+GptjJVIdELNVSCxxR0shrhshgtPFCagD5AP/vK4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993585; c=relaxed/simple;
	bh=gOy17tuDWMpGGIAMdxDlvpGP151b/AW6UzIQXHsI/1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RHKSLqYtJAKQFZnWno4vddKK1dTWzFwbggg+Bt4QOuHHJXk6Dfqn2bN/86r4pIlinEMSoUL9D93+YnLqHLMeqN3nmtyltvhrIMwGA01W5WjoI1dwP81yA4VPPWTIzdY719T+zNInIqsMWoKXySSMUgLZ6ic2VnepPjVqiMN6rSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P/94mqqZ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3d0d26182dso71245866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 02:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707993581; x=1708598381; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QD1gYi0qromzk9mvV/EvG6oZSGwvLtBgJUyJlsYq8VE=;
        b=P/94mqqZpOlV0S+C/dhlV6Or0Yy9ETQVk9tEGptEEObCaMI5iwwajekpPUjDtaA2RL
         Ip7XWGE+qmN2D5J2HLQqd72nfAydwhtrHWTsVora5PHe9zzJhMIeryJvec3sdVqJBv+W
         4lAJM2gCFqCMWrEHxza45F+eiJQE3Ab/D2IIleN+N5+BwboEQlJDyykY/0/imUdHSnu5
         brNnEhFcSik+z4EAiwFALOoyAHWhZ7T5Vr8TZ9im4UPvxDiCRq86QXCeAIswm1cpEwZ8
         mzV8QBKT+mnewQiSitSY7rEOkqGaB9icP1gi8c53PwtliqIb6BaQs3hvZdDT49rQ2pVH
         p4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707993581; x=1708598381;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QD1gYi0qromzk9mvV/EvG6oZSGwvLtBgJUyJlsYq8VE=;
        b=A/z6L3xj7sUSUqicBIQUrcfZ0hwcSlM8pXC91//N/ErFCPQvAu1BwrR3mnV6x//5Sa
         oXVTiyDYE6SgSRCeYlvFQY8ZiS6y8K8fGk2Pze3mPHasyW7Qrp+6kSMxqXwUCbVnQxWx
         ZIF1lkG43ICIaDvxwyKEuOsgQQ7rcG5YRhsfhQgQAzvxO1vdHACj7DS9qxPrfz9M5cWP
         KVS523f7cJPWZ1Cicn6aiICWrGu7ZD2az/a8UWRDQ5tYiazhOxKmJ850uDbx+SMFX23Q
         fZlBZWnC4I13Gd5RP4v/CvFyX+li3+oX0mH6vcHEQfe3ambE0+bxRfXOiX8MQxOaL8WO
         D2QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUATfDWKJtd3WuvSrM00H/xtz5LnEzCOqUxSSIDtsZMOxqF0Qoe0FLBi5n25pdDzFRNnWLn2U+Dzd5rNHKHpt1WNgGjINLUpy+ct6Na
X-Gm-Message-State: AOJu0YzUz9VP/lroQ1MCNxI+rVggKgIUaSIr5qoNGpx/MWly5yGTm/u8
	4X/XiTHNPwP0zfIfvWHo82MeSI8qerW70yYBDw0RdG3D8vSlrABJq4P7oztYwbQ=
X-Google-Smtp-Source: AGHT+IHxJXsj6sPkpwp8k9eOLHcS3JXWQ+PARRS2qqTZM8K+VYZlpVBLRUa3qwQgc2W8yHDlG80EPQ==
X-Received: by 2002:a17:906:d9c8:b0:a3d:4ac5:2012 with SMTP id qk8-20020a170906d9c800b00a3d4ac52012mr874808ejb.25.1707993581699;
        Thu, 15 Feb 2024 02:39:41 -0800 (PST)
Received: from [10.167.154.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id qo3-20020a170907874300b00a3da5bf6aa5sm194070ejc.211.2024.02.15.02.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 02:39:40 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Thu, 15 Feb 2024 11:39:31 +0100
Subject: [PATCH] PCI: dwc: Use the correct sleep function in wait_for_link
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-topic-pci_sleep-v1-1-7ac79ac9739a@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOLpzWUC/x2N0QqDMAwAf0XyvEBbp4i/ImO0XaqBUkuzDUH89
 4U93sFxJwg1JoG5O6HRl4X3omBvHcTNl5WQX8rgjLsbZwd875Uj1shPyUQV+3GyZvI2hTGBVsE
 LYWi+xE278slZZW2U+Phvlsd1/QAqX4L1dgAAAA==
To: Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johan Hovold <johan+linaro@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707993579; l=1741;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=gOy17tuDWMpGGIAMdxDlvpGP151b/AW6UzIQXHsI/1s=;
 b=gVAzF0+FSbsq0Gk2mQfYr0dVV9Vx0Uy24zbpDOkYsC02CTjGY54YpNSlrdkowpJL8FbwhfUwX
 7Haxlo8bEJdDsDLu3q4WGDsbD/ejzwIYoYQ1k7lPjQH5weiHmIQopYE
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

According to [1], msleep should be used for large sleeps, such as the
100-ish ms one in this function. Comply with the guide and use it.

[1] https://www.kernel.org/doc/Documentation/timers/timers-howto.txt

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Tested on Qualcomm SC8280XP CRD
---
 drivers/pci/controller/dwc/pcie-designware.c | 2 +-
 drivers/pci/controller/dwc/pcie-designware.h | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 250cf7f40b85..abce6afceb91 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -655,7 +655,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 		if (dw_pcie_link_up(pci))
 			break;
 
-		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
+		msleep(LINK_WAIT_MSLEEP_MAX);
 	}
 
 	if (retries >= LINK_WAIT_MAX_RETRIES) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 26dae4837462..3f145d6a8a31 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -63,8 +63,7 @@
 
 /* Parameters for the waiting for link up routine */
 #define LINK_WAIT_MAX_RETRIES		10
-#define LINK_WAIT_USLEEP_MIN		90000
-#define LINK_WAIT_USLEEP_MAX		100000
+#define LINK_WAIT_MSLEEP_MAX		100
 
 /* Parameters for the waiting for iATU enabled routine */
 #define LINK_WAIT_MAX_IATU_RETRIES	5

---
base-commit: 26d7d52b6253574d5b6fec16a93e1110d1489cef
change-id: 20240215-topic-pci_sleep-368108a1fb6f

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>



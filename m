Return-Path: <linux-kernel+bounces-121821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 034FB88EE39
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A9B71F3605B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB15B14F108;
	Wed, 27 Mar 2024 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xs3oChH8"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB5A14D6FF
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711563895; cv=none; b=h7jhnS5efDGJzEzgRpnXbm6gHxafBONYSa9V4VK8i54jg47pKSK/zzj1i5vMuBVn9eEY3tMmZx9gURfXp8uZa6/ST6tHLYqdoDGksM0zq3ovzB90rX6NTAixFarFPRKuTMb54F7hrnlt0qOCP1Gj3Y+170vEKXWhc8kJAP62KGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711563895; c=relaxed/simple;
	bh=kPo4wclzokScqHeaFzs+0i6+ebyttqbqO7yFLXqglB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kyqPiKpA4bMAvehv05c9EJfQPJ8TpH2HE6T2FmOjC3Wpu2fRxOkL/SfboshLJ9n9biEwPlzJ/6T0IROz+VVR42M7rGDSZV9w+nAFEfOkH3aNw567SJANrc6U5wbqJQYc5cVEYAXiAcUveYc+W/KoSP49yw2V+HSZxRBQCtwK/q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xs3oChH8; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d28051376eso1052911fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711563891; x=1712168691; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DRxufnUia30f3JjqILIFYFBLjRnWCusL8U9ayoswPeI=;
        b=Xs3oChH8QohFzGN3iqNNZeqnmxblZnulIiQMxFY8vd4bXXgprOeJGQKGyetUPWQq7B
         bmfQqGe4Ee8RYJfVpvTQqw7Br/112qN/chGIJaaHWDgwxOkVBXhs5hSN3TWNVVNmgUTA
         TCL0W51AdFJ/kHXjKIKuhKDHmkZNQezTVh4B8llhH0NR0YMzaPrMn5w+z7kqVkGj1Mc3
         DBAotUyLEC/Cmt8AnWIAfFjzsWhXcHw+xWqr9Ht0X+Nsna26/kdY5lfZkoRA7GXG3zFG
         PD77B6vxyQxkU9N3VScVA2KxM+3NAwYespValoHAtwD050Jy0Na2MfATxU4E4RlD7CDS
         UP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711563891; x=1712168691;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DRxufnUia30f3JjqILIFYFBLjRnWCusL8U9ayoswPeI=;
        b=FCbdogzncUeS7zSHdZg+fVqgU/ViPmDJ+JWTE3rxubHIPwxMRpC2bWX4Ojk4EFIJ5j
         qWxt3t/a9P8st6LQhEeE0ffnVaI3ILZJOg1Wd3OqAv5etov1UVYCsb0OI+YFo1xltSAm
         1vHHJOOTEUCrM7BrUjh/bRoAtMsLrGDBP3zj2MlzDi/KGenpWLkI9e44qnCLcss4Yb9r
         G3RJrGphWH2Ikfr5TsN7gPguu6+L393/rTCh8cV7T/Oj8Ek3j33FSJ/vd1sG+dxAHKu4
         V+gThW/ihpv9Io8W/bq8+YSZ+vVH5zHaBwllC2Bgi5+l+ho5/qUPvhsZA5iXHqhI2enz
         5k+w==
X-Forwarded-Encrypted: i=1; AJvYcCVyzFfnvFRwBcjE+iNXbtL0O5sogWYOetQ7CeesgPpIcIeH0TKiltoDs4Eo9RnWIrOJUxWNrA1jAZ3/ka0ZWVNykxVaBgTVuizPafL8
X-Gm-Message-State: AOJu0YxdlKUlp4DzcHvFwu3WMRp+kxmJXeiD/LcGdTjmh6IWUrnhUBCN
	sHTxlLtyXMOB2lh06fNonbgZFo7ugZ9QkDZ40USuLgKNa3Oud8oUvTrDr9IJ6dHs8UIJiiSR08Z
	3
X-Google-Smtp-Source: AGHT+IGBlbjAr7EmVXygfiU1CM7+Z+uNl6Zydp3fz6xJH6tdE+lAi/XQJf2IZuNEx8BoIDc0pq0zLQ==
X-Received: by 2002:ac2:489c:0:b0:515:af1f:5bad with SMTP id x28-20020ac2489c000000b00515af1f5badmr241202lfc.28.1711563891638;
        Wed, 27 Mar 2024 11:24:51 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090681c500b00a4a2bbee931sm3939946ejx.118.2024.03.27.11.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 11:24:51 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 27 Mar 2024 19:24:49 +0100
Subject: [PATCH v2] PCI: dwc: Use the correct sleep function in
 wait_for_link
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-topic-pci_sleep-v2-1-79334884546b@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHBkBGYC/3WNQQ6CMBAAv0L27BpaFMST/zDELHWBTZq2aZFoC
 H+3cvc4k0xmhcRROMG1WCHyIkm8y6APBZiJ3Mgoz8ygS30qtTrj7IMYDEYeyTIHrOqLKi+khr4
 eIFc9JcY+kjNT7tzL2ixD5EHe++beZZ4kzT5+9uuifvb/YFGosCHTtGTapmrpZsVR9EcfR+i2b
 fsC60oZ7MQAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711563889; l=1927;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=kPo4wclzokScqHeaFzs+0i6+ebyttqbqO7yFLXqglB0=;
 b=doph5A235zHAd0ItlQ/KXm/hUkD/eqCJVe4KY/kZyS9/hV8IJtjFwjbtt2eA3IjXeBBkaASqr
 LGuMHVMeWpsDwKdZUTXinatnEQCIAmJczcmHXkW05I3NBs4E/epfonD
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

According to [1], msleep should be used for large sleeps, such as the
100-ish ms one in this function. Comply with the guide and use it.

[1] https://www.kernel.org/doc/Documentation/timers/timers-howto.txt

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Tested on Qualcomm SC8280XP CRD
---
Changes in v2:
- Rename the define
- Sleep for 90ms (the lower boundary) instead of 100
- Link to v1: https://lore.kernel.org/r/20240215-topic-pci_sleep-v1-1-7ac79ac9739a@linaro.org
---
 drivers/pci/controller/dwc/pcie-designware.c | 2 +-
 drivers/pci/controller/dwc/pcie-designware.h | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 250cf7f40b85..62915e4b2ebd 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -655,7 +655,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 		if (dw_pcie_link_up(pci))
 			break;
 
-		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
+		msleep(LINK_WAIT_SLEEP_MS);
 	}
 
 	if (retries >= LINK_WAIT_MAX_RETRIES) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 26dae4837462..b17e8ff54f55 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -63,8 +63,7 @@
 
 /* Parameters for the waiting for link up routine */
 #define LINK_WAIT_MAX_RETRIES		10
-#define LINK_WAIT_USLEEP_MIN		90000
-#define LINK_WAIT_USLEEP_MAX		100000
+#define LINK_WAIT_SLEEP_MS		90
 
 /* Parameters for the waiting for iATU enabled routine */
 #define LINK_WAIT_MAX_IATU_RETRIES	5

---
base-commit: 26074e1be23143b2388cacb36166766c235feb7c
change-id: 20240215-topic-pci_sleep-368108a1fb6f

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>



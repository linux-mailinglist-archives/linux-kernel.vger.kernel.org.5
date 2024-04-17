Return-Path: <linux-kernel+bounces-148981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4E78A8A13
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 486FB1F246FB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A2D172765;
	Wed, 17 Apr 2024 17:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mMDmLXox"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85601487DE
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713374257; cv=none; b=sVgPoEW/xZbMeGv3QfC/4yHeH6Ap06Z6QGYOClhz7D3fJ/9Isf1vwVyW8Q/XdgJ7n4L1Mvn0UeZEwZ+fj5apqMMeA/ZG7KXqo/ksc2MWZFXIz3OapYE4MOqxkzl2otZan69NmqgXFRRHnTfB3NHVsAVjHZEtyhLiNOm+3gF357I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713374257; c=relaxed/simple;
	bh=J6u2bxlGnbIF6tRpiSb3c4MJtWb4Cq6U1VSDhfK2Qek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uUF5lIJbieyCAcM3mA1Y/pZlXWWz0stXaT71wA8GBbTGdBao61IhI4zK4P0US+aY5VD5ZH4lzlynSUjCNA3eaKl51dF2rU/lz9i6s91c8wi5Bgpz3tzidEW0YO49myxkfLhu05vKY1gTyTbhg9j6oe/qikxgBGX+2sQx+ECTSjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mMDmLXox; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e3f6f03594so39934855ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 10:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713374255; x=1713979055; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eAk6uogai3rNX6lMJ46qIg1YdGd/JpkmZGvXO96KEvg=;
        b=mMDmLXoxgWsdYoFpMNVKtV7YJ6NCILQeXid2S5E4Dk0u2rDI5cecjMFkbiHxS1Alxm
         uJfS9W4lrRksE+n2G+6y+HFrWmlh0UjAvnOwEYX0tlpY9TFigp3LpyI7VU7cpDXY1Bn6
         3SpcCP4uwTB0OH/vzLmKQeSqpEki1xFKH1diGXE3AWmAajOVOxneRBKQds4JQu1vLH4c
         FzB6BbkiajTJ+k2AkUNCoGOagIjFkNZxuYW1PTj2dSbBr6RTvQApnAKyb0Dl/qqHO98Q
         iJ5724PZXk1jGpyunGnT+af4VMm8pBb2/7qWFOR/HKoqz9V5yRpgtS8MiPr8t/TeVTjL
         dcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713374255; x=1713979055;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eAk6uogai3rNX6lMJ46qIg1YdGd/JpkmZGvXO96KEvg=;
        b=p66b88cPI8+ldpAek5KsLPQJgT9fAwcVvhZm8LenrVFKbkkykq+XBu1r8jV9VldDwO
         7Ln0aBMbx2Bd5FKDwgSR8/hXLdlYYSN2hNmGNgyKDcZv2i6yyvO9j8KZGC86c4r4IUec
         KJxesunwwAosU024FiSG4rGzXruZ2yYTbRAnpIxWHuWUNtnotyquD+fEQFiIeTVcov+M
         qFUfkrHAczJ4qZgUNYhqqLMlsZtf6QgyrVi5NaRKoaa9fnpuHjKh9znis0Fqs0zc8nUV
         /pV3pZPRXCc18Qf3hSsLklZmGuuz0150PhjT4/5mquYA6ECcMsKD7umZsiiV3Kntdgm4
         /rLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVQQv/RcfsomUWp6anyzr/727T8aqp0UIGMbNBsnz2QXSNgbCgsJIV16pYX8+Q0RJZxMoyMZpN4OYfTJQN+v3r7E12AO8nQ6q3YMts
X-Gm-Message-State: AOJu0Yy42d2xCUSHFPKdkd+yUW3ZgvyBgYFRYGR8YjPaC3xMw8TnBquK
	vuoQl+iJfZLIeQOsquuv7whYXNQeWlwrDBUjEV2FJD+ihMGnZ+vDBzdFYeE7Qw==
X-Google-Smtp-Source: AGHT+IFIi1lEFembgRKov2h7AZSrh7UBxBJ/QsJbOYggw76xveV2WdGbwRBOEPrJoFvPA154SjKo6w==
X-Received: by 2002:a17:902:f552:b0:1e4:436e:801b with SMTP id h18-20020a170902f55200b001e4436e801bmr108253plf.67.1713374254688;
        Wed, 17 Apr 2024 10:17:34 -0700 (PDT)
Received: from [127.0.1.1] ([120.60.54.9])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b001e28d18bd52sm11834709plf.232.2024.04.17.10.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 10:17:34 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 17 Apr 2024 22:47:25 +0530
Subject: [PATCH] PCI: endpoint: pci-epf-test: Make use of cached
 'epc_features' in pci_epf_test_core_init()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240417-pci-epf-test-fix-v1-1-653c911d1faa@linaro.org>
X-B4-Tracking: v=1; b=H4sIACQEIGYC/x2MSwqAMBDFrlJm7UAdBD9XERe1PnU2Wtoignh3i
 8sEkocSoiLRYB6KuDTpeRSoK0N+d8cG1qUwiZXGNnXLwSsjrJyRMq96s4jtHURmdJZKFiKK/pf
 j9L4fMtvpWGIAAAA=
To: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1888;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=J6u2bxlGnbIF6tRpiSb3c4MJtWb4Cq6U1VSDhfK2Qek=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmIAQm+b4LV4HDd0rzzd55tBAcc1ac1jtIA/fGL
 mHEFEXExWOJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZiAEJgAKCRBVnxHm/pHO
 9WPvB/4pvTZs1X/EebRr/UmxQOf9x08wM7Zjrth/RwfBVDa2O2c2IQMBH8fbnk1w4NPXwu6Igz0
 dL40JO2E/x/UVWvQyyvNhbtnkuch+/m9tdBqCV2OA9t4SZqDFuiqcXHtu+OnI3V8nq2iQw3mwRw
 3QO4MtZO2VhUSLKJjz13sF8JR6qcecBfEmrs+ZqFF3f0PboHKo5LsN7Igm4MoNPRyvSY58Uxc3d
 ZUp/mzLanwZnshOlB0rQdegcNKyw3IfXepb9chOJuTUk8BYlf7ixwezZJHtdnyie5wpiUznuuJk
 dU5s2XHPEQw1fpoXYUaXFuSSJNUxlYcjtPjtq0x+rEJa6aKx
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Instead of getting the epc_features from pci_epc_get_features() API, use
the cached pci_epf_test::epc_features value to avoid the NULL check. Since
the NULL check is already performed in pci_epf_test_bind(), having one more
check in pci_epf_test_core_init() is redundant and it is not possible to
hit the NULL pointer dereference. This also leads to the following smatch
warning:

drivers/pci/endpoint/functions/pci-epf-test.c:784 pci_epf_test_core_init()
error: we previously assumed 'epc_features' could be null (see line 747)

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-pci/024b5826-7180-4076-ae08-57d2584cca3f@moroto.mountain/
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 977fb79c1567..0d28f413cb07 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -743,11 +743,10 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
 	bool msi_capable = true;
 	int ret;
 
-	epc_features = pci_epc_get_features(epc, epf->func_no, epf->vfunc_no);
-	if (epc_features) {
-		msix_capable = epc_features->msix_capable;
-		msi_capable = epc_features->msi_capable;
-	}
+	epc_features = epf_test->epc_features;
+
+	msix_capable = epc_features->msix_capable;
+	msi_capable = epc_features->msi_capable;
 
 	if (epf->vfunc_no <= 1) {
 		ret = pci_epc_write_header(epc, epf->func_no, epf->vfunc_no, header);

---
base-commit: 6e47dcb2ca223211c43c37497836cd9666c70674
change-id: 20240417-pci-epf-test-fix-2209ae22be80

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>



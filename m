Return-Path: <linux-kernel+bounces-149685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57ADB8A9484
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4221C21A7C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03D07BAFD;
	Thu, 18 Apr 2024 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z1b38tM1"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6A179950
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713427211; cv=none; b=IXZ/T/MVPmBXPZWoZ2ypEpz7mfIdv/wiPjWIdYlpAoq7MZM13/jly3+JfCOJ08YWHQ+w5qk8/5/g/f489xl5Ii+HSFQKSsO58bv7ay7LXdhxEPX7D0OAKo0itmj7WF9CXJvhllbFaeOQrGtSJFG5ZZxwkY8yRYWPxWwYSoAbYCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713427211; c=relaxed/simple;
	bh=+dPJhpBZ6Z9Bvg50ANU6nm5U04Z4RKW/SsbP2j5yqfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oWI3COeZslGyH2s51RNsFaDY4Z94Qag4L1OI3D5VpgXW6M3MBnYMq7FSqmkRxxHASDC8snnV6LnDZoicL7u465lhvH9b0ASNu067Yr8Zq98/Jn4Z4W+yOZY0PWW5LWeickOLQUDWHVSxsyWZttdNBqdxj9BfpOmgBI7xT0vZk6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z1b38tM1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e3c9300c65so5738025ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 01:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713427209; x=1714032009; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1bUXYeNx7u3tu+bha+S/5ez5PzMF1gaI6KQP6MUtJvI=;
        b=Z1b38tM1gWHD8nFneGgKnZOGy2AhzH4bzPLB2ct6BQwikNU6/AMhTzMifHrIeQXvgS
         MhinchFCuL8MTVZebwL1o5Xyu29u5PERZoHdhH0yr0GYQvtzbqTC0P9C+IZF4jqf84J1
         4t1NdtEx52Xzk39cNVd14mgVPOVf5MNPDvSFpFPVY5jXSYr/BeRuekAYl8tUuKp8V2fF
         q/rntlwaP+FT5yUfcq6qND5PvwVJvRTZpocqgd4RV1EwF9gV7XL9tdy8uV/91AVi24i8
         lxoWWzn3U8nEx1ms+J1O81GKBq2pyEPzSjAM9pPtO3X39jNIKA0WpjXA6d6ekoATnZO/
         n2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713427209; x=1714032009;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bUXYeNx7u3tu+bha+S/5ez5PzMF1gaI6KQP6MUtJvI=;
        b=DfB7qCPJIj+MUDMDJ1jVUEX93irurByfQJu/s+gACekuT+87AJ32nBd4rSeGHkms9c
         Xg/876HS9G5Fsqlcoxbqy0UbikVGWbMUtjRGnbDGfYpIZ8xAv5W694bCovMiIsHjWyvn
         njGGeQdBIxLp2RAn7mu5k0E4dLLmhZeU/MC2P1Hack6K8yEZb0GM8Cqs4nfHn5LwLFgp
         ImHWuEUjJ/j3UptajNczLWLPTvGyLpVgvXcxqDFIk3TMRqm7gy5Wu8KQk0mjV+ODy2cB
         3qHhMn/xRBo459R0TeIk7PsJ7NoZJwTZrsYZCoTW48Ajtp86QiGwRfmHbCzsl3YDW4Js
         6j3g==
X-Forwarded-Encrypted: i=1; AJvYcCWzgIAi78dS82LpzgsnKvMgKbGF5cqRHl9Xs8cFyRgI9UuJ4MF+VTTiNM9aexHvpxAu22dIQ/xO1Lyg+Bgr/L7bjumI80sE2nxcwupP
X-Gm-Message-State: AOJu0YzwXoQL6menVKCC/RRbrT3mK3ENBLUSXktbFzjdCXqg19vBTvMU
	AXN1fegYHWBOKRxpOhP6DAAyDJNRgSgNYsJYweseT8HUoyLBxQXU52RC0UM6fE0XLd3EXJIRurg
	=
X-Google-Smtp-Source: AGHT+IHyoPFQlFoXtgY40googjyG4b/IPCLMz9M13nObHKBj6NsKcJCqoQzLHYGR4bg6XNUk30j9PQ==
X-Received: by 2002:a17:903:244f:b0:1e4:47bf:6926 with SMTP id l15-20020a170903244f00b001e447bf6926mr2516174pls.4.1713427208644;
        Thu, 18 Apr 2024 01:00:08 -0700 (PDT)
Received: from [127.0.1.1] ([120.56.197.253])
        by smtp.gmail.com with ESMTPSA id lo8-20020a170903434800b001e546a10c50sm889956plb.286.2024.04.18.01.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 01:00:08 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 18 Apr 2024 13:29:58 +0530
Subject: [PATCH v2 1/2] PCI: endpoint: pci-epf-test: Make use of cached
 'epc_features' in pci_epf_test_core_init()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-pci-epf-test-fix-v2-1-eacd54831444@linaro.org>
References: <20240418-pci-epf-test-fix-v2-0-eacd54831444@linaro.org>
In-Reply-To: <20240418-pci-epf-test-fix-v2-0-eacd54831444@linaro.org>
To: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Niklas Cassel <cassel@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2897;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=+dPJhpBZ6Z9Bvg50ANU6nm5U04Z4RKW/SsbP2j5yqfg=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmINMAYZWQ9fwZiwl1pCOKA3kyB/eiUU1F0L9bZ
 runv8zRI+aJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZiDTAAAKCRBVnxHm/pHO
 9WM4B/9ZeGWbuXnjR4+7h9CZgLQ0vMxh/i6wPAid348nY5SPMlgWPWRYM3j4yN6Os63DWBjK6nQ
 iNKBYwHCiuF2T0LdOZnKZzq2h6ISixgtK7cID1C30bMhm6JTSyBP1oFrkzWPKadRfL0rBx5rFgv
 U5rTNPzvmhQEIY/rVAaM+abkAeAXwM1jSNm0XQBwrZb9IgKcBZuyxplL/5utU9kiAG75TatSgU8
 GcW2j/mKMFJor/Yyqk49tUq+AHviHvkcioV2mb2+EbQ+blWCIS7AOabeHCtywXc8AyNrN6V4aLv
 VVbhiIGD4EA06ADsxjwWuqkM8DoJnUdCfhncLWhNTw0wHo9y
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Instead of getting the epc_features from pci_epc_get_features() API, use
the cached pci_epf_test::epc_features value to avoid the NULL check. Since
the NULL check is already performed in pci_epf_test_bind(), having one more
check in pci_epf_test_core_init() is redundant and it is not possible to
hit the NULL pointer dereference.

Also with commit a01e7214bef9 ("PCI: endpoint: Remove "core_init_notifier"
flag"), 'epc_features' got dereferenced without the NULL check, leading to
the following false positive smatch warning:

drivers/pci/endpoint/functions/pci-epf-test.c:784 pci_epf_test_core_init()
error: we previously assumed 'epc_features' could be null (see line 747)

So let's remove the redundant NULL check and also use the epc_features::
{msix_capable/msi_capable} flags directly to avoid local variables.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-pci/024b5826-7180-4076-ae08-57d2584cca3f@moroto.mountain/
Fixes: 5e50ee27d4a5 ("PCI: pci-epf-test: Add support to defer core initialization")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 977fb79c1567..546d2a27955c 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -735,20 +735,12 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
 	struct pci_epf_header *header = epf->header;
-	const struct pci_epc_features *epc_features;
+	const struct pci_epc_features *epc_features = epf_test->epc_features;
 	struct pci_epc *epc = epf->epc;
 	struct device *dev = &epf->dev;
 	bool linkup_notifier = false;
-	bool msix_capable = false;
-	bool msi_capable = true;
 	int ret;
 
-	epc_features = pci_epc_get_features(epc, epf->func_no, epf->vfunc_no);
-	if (epc_features) {
-		msix_capable = epc_features->msix_capable;
-		msi_capable = epc_features->msi_capable;
-	}
-
 	if (epf->vfunc_no <= 1) {
 		ret = pci_epc_write_header(epc, epf->func_no, epf->vfunc_no, header);
 		if (ret) {
@@ -761,7 +753,7 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
 	if (ret)
 		return ret;
 
-	if (msi_capable) {
+	if (epc_features->msi_capable) {
 		ret = pci_epc_set_msi(epc, epf->func_no, epf->vfunc_no,
 				      epf->msi_interrupts);
 		if (ret) {
@@ -770,7 +762,7 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
 		}
 	}
 
-	if (msix_capable) {
+	if (epc_features->msix_capable) {
 		ret = pci_epc_set_msix(epc, epf->func_no, epf->vfunc_no,
 				       epf->msix_interrupts,
 				       epf_test->test_reg_bar,

-- 
2.25.1



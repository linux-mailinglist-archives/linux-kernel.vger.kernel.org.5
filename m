Return-Path: <linux-kernel+bounces-149686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A533A8A9486
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40FCC1F22B1F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2C27C6C5;
	Thu, 18 Apr 2024 08:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rmwV2Ryd"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1F87BB11
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713427213; cv=none; b=JsTDZLhbDKJ5p9wyCTzGhVkcQwtz+SwsgQDvLLMQaLoxu57kcfeQtINVg6MTaXROYzHEElcOnLuDy+1hFmg2X+dMOVZyT5wimgAPLAy+ny1weP3TydQNmpGRYaN60N/X2YIKnVDUD79QH9vDDDgZ7pNUKbgo3eMEhlQo5M/jYGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713427213; c=relaxed/simple;
	bh=dx7Pu4GSAq806/2nc7mcGWRQfuaNyNK4rj6uW2+wJD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZETCaqycsS0IML3jobGYsBz8ipyzpi4XE7qLpqfX0gIkuoMvhBTDYYcAomwXec1CtPAEUJYjehdQjZ9evpcl+MKX1/imSwsgIfm7Pwc4o9fpNuZ0xBXM/SRmlswVTOW1391O9bVhHkCpaFcvYf7n0xAZIFKObr+HEeuwP1S5hSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rmwV2Ryd; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e3f6f03594so4796005ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 01:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713427212; x=1714032012; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nmNqm7iwZFYKOgfpdWXEANgZEqRwFMnPvW+zA13+SJs=;
        b=rmwV2RydkUmuWYF2Knz90kOJE40CMz+PdHxBCEvX0NinaUm4sBB9a/HTuevBGXpTht
         Ajaevc+D3g+amXwNOB9oprm8sGCIhblB3L1mXPC5leYbMWcJdilCDUxGKm26uUMbIPeG
         9rWbz1ecIMYnH9xcNQGxhzBD1HW6T4z5yydX3UGep72ADr2nCPtaGumP75YzJmfX0DCW
         CslAanFtMQAU7LMFOzDPIlnevrdctSlMctMXT5VjtcuI3pztrQOSAcYCfwYqZO9t2rPm
         Fz0q9lRR+LpuhPw9N5B9ecSvW57n9ZZc6m0e2CsUqP3crrLQB+EyEaI7JF8teYDZCsJU
         sYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713427212; x=1714032012;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmNqm7iwZFYKOgfpdWXEANgZEqRwFMnPvW+zA13+SJs=;
        b=Kv5CJilnArDh83iDx784CAF/WgasMlkZaYn3Vk7W6fVugNhpsHUfk8qJo9Dm1pv9di
         PJk8RU9GSnZtzdtgKHZG+NOjMFwcgiBvVhmLPJCx3R5Wdwy4njHdjZVzDpiYnvFFE5l3
         BEf2JW6NiXDKSDvPgmL5ZUWxjkpfuLA/a5v27b32jBlsKAvsuivRTuigmHs0WpIg1+0T
         zuMkvGeJhKZ5oeVMrEBOtWfQE2SYAK2b7bX14fHdxExoQXipZn+MADzH2BVONUWAP+qT
         vo/cBbKCAtbCFfIC9RNo91ca9aMVQQ9jXYC9gZurHfHlNrtSbtkdz+/OYeemvUwsaorJ
         6QNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyZoQfNPP0U4nSNatmhE0+4pVTLlpEhCrngmh48s3/trkRgAYAXGvxG4E2zh7NoC6p+trwC0Hm0G2hyvIH5Lo+wRmXPFNMjUYMvy4L
X-Gm-Message-State: AOJu0Yx/QDyOpUcC/gYkDQAIUcVr24JXsU5i5O1ia8IrByZJIjnMzaS8
	d8nX4lrPNqWRaS5nU11LBMpZ6GTkegk/f5jsPVaEhTEOLZBZD0WFMTuTU+33qcp7FzBsOFwBjeM
	=
X-Google-Smtp-Source: AGHT+IFsdTsbM7dhIhKZYJ6YbLdedOkZDV8WFJ5e3qauhUx4R1UbGZ4dAe8MDYRyW/9F2ULB2VwWJg==
X-Received: by 2002:a17:902:c212:b0:1e4:4955:98d9 with SMTP id 18-20020a170902c21200b001e4495598d9mr2092824pll.45.1713427211626;
        Thu, 18 Apr 2024 01:00:11 -0700 (PDT)
Received: from [127.0.1.1] ([120.56.197.253])
        by smtp.gmail.com with ESMTPSA id lo8-20020a170903434800b001e546a10c50sm889956plb.286.2024.04.18.01.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 01:00:11 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 18 Apr 2024 13:29:59 +0530
Subject: [PATCH v2 2/2] PCI: endpoint: pci-epf-test: Use 'msix_capable'
 flag directly in pci_epf_test_alloc_space()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-pci-epf-test-fix-v2-2-eacd54831444@linaro.org>
References: <20240418-pci-epf-test-fix-v2-0-eacd54831444@linaro.org>
In-Reply-To: <20240418-pci-epf-test-fix-v2-0-eacd54831444@linaro.org>
To: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Niklas Cassel <cassel@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1427;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=dx7Pu4GSAq806/2nc7mcGWRQfuaNyNK4rj6uW2+wJD8=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmINMA5+bqKFZPvbU7DVk3Jfh5SvPNaW0wC9WR1
 0WC1DukO3+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZiDTAAAKCRBVnxHm/pHO
 9aiiB/wIftcF3SlSCrP5fsOjH8SZ+x/gtt40KoKbiXqD56t8qWPVnQBWt/suyD/M6TloYwe3/ZF
 x5EIJ3PG0zDzrBXsUXc0XlenBWMUbopvYoIEgjPbWvrdp+B/Gf2GGOj0euZ5a/B0Wi2Q6M+DF5s
 mHfACMhqiDJrJoxuN/zNSD5MhkEorgTa2wiik19zGMPlJrOu01O9PXNdRZZb/6fRH7DSpRlVgMm
 Q8tDyrckS+CWdlvuDYwYWfNNmcJt1BM9wPrgFvzSsKrf2ActOoF+BbelsHGDcJMEk/xXjcuha72
 W9xfYcG7ulee2XdrbcKzmsxuB1VP9mmzSdKrkAYfVtIVRY0Y
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Instead of using a local variable to cache the 'msix_capable' flag, use it
directly to simplify the code.

Suggested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 546d2a27955c..3de18a601e7b 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -802,19 +802,15 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	size_t msix_table_size = 0;
 	size_t test_reg_bar_size;
 	size_t pba_size = 0;
-	bool msix_capable;
 	void *base;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	enum pci_barno bar;
-	const struct pci_epc_features *epc_features;
+	const struct pci_epc_features *epc_features = epf_test->epc_features;
 	size_t test_reg_size;
 
-	epc_features = epf_test->epc_features;
-
 	test_reg_bar_size = ALIGN(sizeof(struct pci_epf_test_reg), 128);
 
-	msix_capable = epc_features->msix_capable;
-	if (msix_capable) {
+	if (epc_features->msix_capable) {
 		msix_table_size = PCI_MSIX_ENTRY_SIZE * epf->msix_interrupts;
 		epf_test->msix_table_offset = test_reg_bar_size;
 		/* Align to QWORD or 8 Bytes */

-- 
2.25.1



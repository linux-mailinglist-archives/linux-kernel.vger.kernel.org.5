Return-Path: <linux-kernel+bounces-118835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FACD88BFE6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52C731C290FF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D2255E6E;
	Tue, 26 Mar 2024 10:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nmb3ZbAU"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8E952F9A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711450153; cv=none; b=IMbjjWc5hTMRSgQz+306YgToavEWuM/Db4XsasqvVCE2kDL1H9EYEzXZs96G3F/q+L8jYGo5O2GC4N+0S4iMBdX8Mz+0GalKmg0/UogfTd28GL4BvLo2tq51osGpXsLYXk3im+285pvgOWvlTIR0MXIKuCsTVj5ylEvQvO12W2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711450153; c=relaxed/simple;
	bh=FdIlecklqovWUvrpfyhP9M3zVKU0Sq4nhdASMDLOLeM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F9NyKabRJbe7y2cN5gyf/U0fy/J56QZZXaOBfUdBGfr6ZSw9Nw4KlOxa0oqP+czTrb/4ut/wQMbOA2d6GTo/b0x3kTtaSQJ5tHUzD13uFG0zuGI4HoYMoUN/pcToG/Dizab47E66oiNbJPQ7I9LEOGh63rLEmjV+5GP5LCY53hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nmb3ZbAU; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29ddfd859eeso4445663a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 03:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711450151; x=1712054951; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vFbJYhdYGvuoH/oaiD2HBWtmIM7M07m8HS3m2IPBo/Q=;
        b=Nmb3ZbAUW1UmI1tzHyg8ILf73dPZJO2fjLqRqpUsnT3d933tWOFlP8PdT/oql1qla7
         xmN7olPIjJOMbH7nTulCCwJm9GBq//U1i7fBFMFnEBaUwqUt7KOetgEltqQG5NP3v6n8
         gcNRzaXkDDvulv7Er/7uJd9hnqX/40sds7fKgbS3nPXNkUFNerE7zPfXrAfYG6sW3uOj
         jH2J1Lel1bYEee+47BhEN6fjyu0wC6XyqUZe9Uca291+K3bCZBInZ6Uff/L84QxjACkS
         sC9iKsvwmFaBSW5VVLypGRThfRQqgti5/PxSdFgv+0Wv4FPXws9DZg7hpNp/3fpQINMt
         U+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711450151; x=1712054951;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFbJYhdYGvuoH/oaiD2HBWtmIM7M07m8HS3m2IPBo/Q=;
        b=SGOBklbgmL0pnpihQWSK30jQkhNAA8/Hrk3piYl57vj12z3ap+0hOWsEb67KaGKWGS
         HZCQp5CEhz9FevljfNKVRvs48t3tUAe3byv/zGkcufFeNK4fwowD/RQKOl8OTY3IfYWu
         jtDmWYSKTdfJL7hq5KlryN73BVKEWP69yYJH2hBJYg15wNA/0ID9fWXir4/Yv4Trj/jm
         bt6STK6YwhnOtS4X2ZgGsUUnzjemG8tjU+H4lBVqTUNa1El+yGU0FDIz6SrN0JuBQYza
         fcmJdfO1vpTVxRLDh19NMm/fI+iSsjnsBFNj3euaiTrOkbjFGeRanF4TuOFdJs7wkebJ
         OLQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0E+WxHnSFLGFC7uq7LNVBMMcknUebykBxrgx4nJgcZpZljS6e8YU2b/ifGNXcXSvVFY7MXIFI4F7WvFmQer3f+mtlKyENa5fuBuYX
X-Gm-Message-State: AOJu0YxC7B7z1u1wQBiT2v3XrN3rIwoc3rlBtu1+DX68R7KnWrf2Esps
	ozZTqmDWsszDq0Y2QmS5ZsiPMbHkzWEywGtrU3NNwGQQLPaGHv97qF8c/GQwtA==
X-Google-Smtp-Source: AGHT+IGxQHf1BymA0HBDL7TqSsjS+f9g8ewlhc49CHvhJdNFTTeKuQxe+y2yjxy3ofTQUrQg7LmtBQ==
X-Received: by 2002:a17:90a:1305:b0:2a0:4c3b:3454 with SMTP id h5-20020a17090a130500b002a04c3b3454mr7137289pja.47.1711450151523;
        Tue, 26 Mar 2024 03:49:11 -0700 (PDT)
Received: from [127.0.1.1] ([117.207.28.168])
        by smtp.gmail.com with ESMTPSA id i22-20020a17090a059600b0029fc196159bsm8777218pji.30.2024.03.26.03.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 03:49:11 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Tue, 26 Mar 2024 16:18:20 +0530
Subject: [PATCH v4 4/4] PCI: Allow PCI bridges to go to D3Hot on all
 Devicetree based platforms
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-pci-bridge-d3-v4-4-f1dce1d1f648@linaro.org>
References: <20240326-pci-bridge-d3-v4-0-f1dce1d1f648@linaro.org>
In-Reply-To: <20240326-pci-bridge-d3-v4-0-f1dce1d1f648@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, lukas@wunner.de, 
 mika.westerberg@linux.intel.com, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1862;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=FdIlecklqovWUvrpfyhP9M3zVKU0Sq4nhdASMDLOLeM=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmAqgV8B1oRhS/KEisLhilKgX2Z9YTFnu8il8dh
 f9ajS7O2tWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZgKoFQAKCRBVnxHm/pHO
 9eXUB/9NbhfHS2KhKNmrNgI0BRCyWwQs5Z61KL+HT/cENsQwy5+PBFop3vvKi5jAjCjl2F2llnV
 azk7wpPnz6M+RGS/kui+2NwlCPvmI2RSGReR8pmDUlW7dUL1MURBFvS9BrbA2GweE46rGR3GwCn
 zd6e4YlTwdT1bawePXF0Ovy39OdzdchHvn6R9RSCqaMulgoYAPPgdZACD1yY0TZh1bk4AbzGLTI
 V905mcjIEhpdM0/BDSMVr8EQDY+x6xFxuouAXOFl8RutypXrd6J459cVerSyAICab9gWMzhvoUf
 JJR1oISium2mQig51ikU2pslp2AlKXazrJbOLS7KrgkQcA3d
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Unlike ACPI based platforms, there are no known issues with D3Hot for the
PCI bridges in the Devicetree based platforms. So let's allow the PCI
bridges to go to D3Hot during runtime. It should be noted that the bridges
need to be defined in Devicetree for this to work.

Currently, D3Cold is not allowed since Vcc supply which is required for
transitioning the device to D3Cold is not exposed on all Devicetree based
platforms.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/pci.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 48e2ca0cd8a0..2fe9defa69e3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2992,6 +2992,18 @@ static bool pci_bridge_d3_allowed(struct pci_dev *bridge, pci_power_t state)
 		if (pci_bridge_d3_force)
 			return true;
 
+		/*
+		 * Allow D3Hot for all Devicetree based platforms having a
+		 * separate node for the bridge. We don't allow D3Cold for now
+		 * since not all platforms are exposing the Vcc supply in
+		 * Devicetree which is required for transitioning the bridge to
+		 * D3Cold.
+		 *
+		 * NOTE: The bridge is expected to be defined in Devicetree.
+		 */
+		if (state == PCI_D3hot && dev_of_node(&bridge->dev))
+			return true;
+
 		/* Even the oldest 2010 Thunderbolt controller supports D3. */
 		if (bridge->is_thunderbolt)
 			return true;
@@ -3042,7 +3054,7 @@ bool pci_bridge_d3cold_allowed(struct pci_dev *bridge)
  *
  * This function checks if the bridge is allowed to move to D3Hot.
  * Currently we only allow D3Hot for recent enough PCIe ports on ACPI based
- * platforms and Thunderbolt.
+ * platforms, Thunderbolt and Devicetree based platforms.
  */
 bool pci_bridge_d3hot_allowed(struct pci_dev *bridge)
 {

-- 
2.25.1



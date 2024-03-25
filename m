Return-Path: <linux-kernel+bounces-118087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E634F88B391
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F871C3CFDE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2750173182;
	Mon, 25 Mar 2024 22:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIt7/30A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CF15D737;
	Mon, 25 Mar 2024 22:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711404665; cv=none; b=qEdoCYZEndMCNKoprMYzPEK94zvf0o7SLDe9zfFNmrg2Ez07AbEHnwAzjp3SwQMdGd0aEKgatGU3p8Wnuurord7DNHx3QcwLytSDSI1lZDNe1UjJINObe3abEMcEmGdJR/ZcS2JjdNYNDkwuvae82Ifta9eC0w5cy7Rcfp/syL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711404665; c=relaxed/simple;
	bh=wMUjV0++fHWKNqMEBLYMOOBBH0T2phMvx1BShL5sYM4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kl/uCiNmljZGJcvfUGLb69dKcOw9OqgBnDoANsuLEwSY9ug5R0UpVeCWLwdSs8y1V65vCbuuHMJV6NzyoLUs84T7OHO8hesGdgwpgsOLmUEcE3jWzkdQhGy1G4QbNYgK+AP96j46KjeN0RCcxJGZ/xBNGSGnQplairGsohCl1fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIt7/30A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD51EC433F1;
	Mon, 25 Mar 2024 22:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711404665;
	bh=wMUjV0++fHWKNqMEBLYMOOBBH0T2phMvx1BShL5sYM4=;
	h=From:To:Cc:Subject:Date:From;
	b=DIt7/30AHXLnKyiIfIO6YizhTDrl7YBbnyiySR4eYYWh0GNM1sMRJMtEyF3TTFC+o
	 SZyRhs/3xAPdeTitNf8LLHGKqQgNn9rgCR+7/EsUrgjN182ZRBdFQXFYXPoVswgIrA
	 KOC8knMyQgVn5ZPE01Xh9urFh3uKzh5/YXtteytkFT5FjUgRIjIJAa6vGp563g8PO6
	 z7koDb96JjW8zqwKwrjkZ9D7YLmTFw50d+qFfrcTb4ow8wpxlBqr1U7uCeu9+4St4G
	 A3mMakmcJKJBUYDrC3+WsmVt+/BmCdgv91D4/YmVJUzzlICFhMMcbdeHrlqXuSoEpL
	 YmO7aa6MsND1g==
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] Documentation: PM: Update platform_pci_wakeup_init() reference
Date: Mon, 25 Mar 2024 17:09:53 -0500
Message-Id: <20240325220952.1453477-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

platform_pci_wakeup_init() was removed by d2e5f0c16ad6 ("ACPI / PCI: Rework
the setup and cleanup of device wakeup") but was still mentioned in the
documentation.

Update the doc to refer to pci_acpi_setup(), which does the equivalent
work.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---

pci_acpi_setup() is a firmware-specific wart in this otherwise generic
paragraph, so maybe there's some better way to express this?

 Documentation/power/pci.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/power/pci.rst b/Documentation/power/pci.rst
index 12070320307e..e2c1fb8a569a 100644
--- a/Documentation/power/pci.rst
+++ b/Documentation/power/pci.rst
@@ -333,7 +333,7 @@ struct pci_dev.
 The PCI subsystem's first task related to device power management is to
 prepare the device for power management and initialize the fields of struct
 pci_dev used for this purpose.  This happens in two functions defined in
-drivers/pci/pci.c, pci_pm_init() and platform_pci_wakeup_init().
+drivers/pci/, pci_pm_init() and pci_acpi_setup().
 
 The first of these functions checks if the device supports native PCI PM
 and if that's the case the offset of its power management capability structure
-- 
2.34.1



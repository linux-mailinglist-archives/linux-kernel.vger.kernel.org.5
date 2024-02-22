Return-Path: <linux-kernel+bounces-77263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6238602B2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 915D81F220BA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79964548F5;
	Thu, 22 Feb 2024 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iCpDEVJY"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9A71DFD9
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708630231; cv=none; b=JE0U/zF5KX+/Xpcrx1K2UmucuFCbyVVPRyPhLZNh5RJh2tfmnp3jrrAwoSIog/n9rM4LZEp7LoY1Oa/CuOGWBgIjQ4tol6e9KQ5Dk6yuMOk/9/OHq2OvSiQEnzZgAgoSqLc4gFDsaDAvbcwEEPEnx8PkY1aDTUlMOpCW9HKLHOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708630231; c=relaxed/simple;
	bh=AXdomOiekerhENh78B183FT3bbxbOBF/etVA0Wb0lLo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oVMhu6SQJstSV+z1VJFqH5w3ihUsDWFUXeVNgZ4c9xNAwhMWBAMn9dqxZlvKoHGu+uMN8VjaqfMzwYq7KD7QC6/7BxCdiVmQZ41AKEYVePNoW/gFeP+9pGK8t6yEia1r1JK/9ROEsadO8BG10aN5Y8Rwb7dZIc9NZo3i0mD8jbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iCpDEVJY; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 3F146C00D21E;
	Thu, 22 Feb 2024 11:30:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 3F146C00D21E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1708630229;
	bh=AXdomOiekerhENh78B183FT3bbxbOBF/etVA0Wb0lLo=;
	h=From:To:Cc:Subject:Date:From;
	b=iCpDEVJYw5gaNib7xnCUw33GfR2XTTYAlVnKjX5r2hA5+XnYCQ6SphpZaX4+EsH4+
	 TjvsvBsxM4nV7jVPmoEPaWM68KRF0uGobbrmZJPZ+5bTXzwCUKIBgfxu4KLhLnIYNQ
	 PhPUbZJ8yz6JZZVrHPcnNVCfTlmFRefHU2aqdFN4=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 9B51718041CAC4;
	Thu, 22 Feb 2024 11:30:27 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
Cc: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	james.quinlan@broadcom.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] MAINTAINERS: Update SCMI entry with HWMON driver
Date: Thu, 22 Feb 2024 11:30:27 -0800
Message-Id: <20240222193027.920006-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scmi-hwmon.c is tightly coupled with the SCMI subsystem, fold it under
the SCMI subsystem MAINTAINERS umbrella.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 466a0fc46f76..92973c5a0e83 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21327,6 +21327,7 @@ F:	drivers/clk/clk-sc[mp]i.c
 F:	drivers/cpufreq/sc[mp]i-cpufreq.c
 F:	drivers/firmware/arm_scmi/
 F:	drivers/firmware/arm_scpi.c
+F:	drivers/hwmon/scmi-hwmon.c
 F:	drivers/pmdomain/arm/
 F:	drivers/powercap/arm_scmi_powercap.c
 F:	drivers/regulator/scmi-regulator.c
-- 
2.34.1



Return-Path: <linux-kernel+bounces-113282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D440888313
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA871F25561
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600BC67A00;
	Sun, 24 Mar 2024 22:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBcil/qZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F1818C9E4;
	Sun, 24 Mar 2024 22:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320082; cv=none; b=ED5Iyw0nCt+s5Ivu9ar9MZuiYxDXwRhP9tjyns/oekYcoa9wn/bJle2P9RoBLC+gkIKJzoHWCk4xjqDW1nNV1kZY4Uu0vFLBNoBN8vg6MK0dSBe/Sn9eRn0zMYrh7hysawQ165u8494BN7b/BU9AEDb6ci1wO7neSMkJlRe75/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320082; c=relaxed/simple;
	bh=AblLMCLKhGeVcNTlP4GxhDoq/j9RcxhSil5RYWBtqm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxTv3vehDq6cOtelTx437luwBpLnLrWuwzU8UYjq3sthpp6IrFQUEyZ3sSsQ/wAAnqDwuxoFdzoj07KDkmiIDbP6py6O8pAFF4kzFLzEUsTsb9R/eHMl5HpeqTku4V1nID7gZPqs8oatJwIBjXC1a3+1nvP7AbzWDXJVcB8HkYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBcil/qZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF17C433C7;
	Sun, 24 Mar 2024 22:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320082;
	bh=AblLMCLKhGeVcNTlP4GxhDoq/j9RcxhSil5RYWBtqm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SBcil/qZUl4NaH5kyr9+u4vDc2sPsjpHaQr5SzVdHfYYW1sXK3kYm47VzXotsEZ59
	 BpRawgZX2dgax3oJwpSRzWXA5whuEjYAbsiuThuM9mYB3wlb8IMiMWGcYua7eUF2hO
	 ZjyaCpPLH+hOuR2S/a6provqjL2z88QMomCaVGb2C30++IVPy+FYSJBMFNbPcC1kqv
	 5Z4lJIbWo1jckI6FCVqTBw9nD2FevBdcc8IkfWC7snV9h+2hfetqq8bmz7u8w5fXCJ
	 cRR6WAmib2Qux1anMkSvvQTM2CjmEuS5T8BmS9T/IBuI0DzDioLl3YGML30t3/2Nt/
	 RfFdBOkquSuRg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 391/715] PCI/AER: Fix rootport attribute paths in ABI docs
Date: Sun, 24 Mar 2024 18:29:30 -0400
Message-ID: <20240324223455.1342824-392-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan+linaro@kernel.org>

[ Upstream commit 0e7d29a39a546161ea3a49e8e282a43212d7ff68 ]

The 'aer_stats' directory never made it into the sixth and final revision
of the series adding the sysfs AER attributes.

Link: https://lore.kernel.org/r/20240202131635.11405-2-johan+linaro@kernel.org
Link: https://lore.kernel.org/lkml/20180621184822.GB14136@bhelgaas-glaptop.roam.corp.google.com/
Fixes: 12833017e581 ("PCI/AER: Add sysfs attributes for rootport cumulative stats")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
index 860db53037a58..24087d5fd417a 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
@@ -100,19 +100,19 @@ collectors) that are AER capable. These indicate the number of error messages as
 device, so these counters include them and are thus cumulative of all the error
 messages on the PCI hierarchy originating at that root port.
 
-What:		/sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_cor
+What:		/sys/bus/pci/devices/<dev>/aer_rootport_total_err_cor
 Date:		July 2018
 KernelVersion: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	Total number of ERR_COR messages reported to rootport.
 
-What:	    /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_fatal
+What:		/sys/bus/pci/devices/<dev>/aer_rootport_total_err_fatal
 Date:		July 2018
 KernelVersion: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	Total number of ERR_FATAL messages reported to rootport.
 
-What:	    /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_nonfatal
+What:		/sys/bus/pci/devices/<dev>/aer_rootport_total_err_nonfatal
 Date:		July 2018
 KernelVersion: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
-- 
2.43.0



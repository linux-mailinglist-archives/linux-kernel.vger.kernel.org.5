Return-Path: <linux-kernel+bounces-113824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F687888EA1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38DD1F345B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A81200121;
	Sun, 24 Mar 2024 23:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCYDg74F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333ED1E6F77;
	Sun, 24 Mar 2024 22:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320862; cv=none; b=ZvjyFwDwPf3WtMHQ8OBswZo8NNqnh8/TJkGLLmbKHvFnAiJ1Lh0DCixjvVlO+hkdlXRdZ7Yy3bdN5i3/APKvZ4tVNhEzhlbQWbeMuW0GoGHlprrSdsL9TxY5DJXJg60q8uvKxrBJwxasRS6B7J3+INEPGMhn+2MOlL6RCRuiFvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320862; c=relaxed/simple;
	bh=AblLMCLKhGeVcNTlP4GxhDoq/j9RcxhSil5RYWBtqm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=px37Ue0gpuns1c5VCVeynUR1vy3AWO3kg0m1bred6S7mJATi8OhcK9zj6SKqz3Oj8+Lna6ygzb0bfoS8jhUarG2/QFfV+7ZU0ZmSyZOzcvXaDghYd2CfXyUYIu/xp893JvmdFtOYhogCAeQPWK+RhmcRiDd3XeM1Hu2IrKB0O6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCYDg74F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70859C433C7;
	Sun, 24 Mar 2024 22:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320861;
	bh=AblLMCLKhGeVcNTlP4GxhDoq/j9RcxhSil5RYWBtqm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hCYDg74F2NQ1r7E3ucpCFbLwqiEn8G6GRnBqbHcdHHAqIReCmWxHxTHRmf+NX1e8V
	 3MaqticQZXSOdbAm0DgGir0k7YczphaPyJOR1QyUlPy0Y5UTb0l8pN/WVooO+RUT6Q
	 B97wfxOOTVFSwrRXzi9EhhJtbsgxxUxkF88jiFUyLNawe4zBOq41NaqWaOC0LKp/X4
	 RcrAquF7JS+ahlAcY9beG0xh0iSl50/HaxNdKWpHWKfTwMeAGQAfVbRCUJd8BKRlGF
	 z6aW3FpmxHlsoJtMBhfRpkT/lpOglA24byGmN0R7yszvRyTh+VS4V41zD6mQCbv2sv
	 96L+mYPwj/tCQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 425/713] PCI/AER: Fix rootport attribute paths in ABI docs
Date: Sun, 24 Mar 2024 18:42:31 -0400
Message-ID: <20240324224720.1345309-426-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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



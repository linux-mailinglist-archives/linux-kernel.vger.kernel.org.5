Return-Path: <linux-kernel+bounces-115101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D453888D1A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EA461C2A930
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDB61C5836;
	Mon, 25 Mar 2024 01:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u02dUute"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF0328CE50;
	Sun, 24 Mar 2024 23:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324102; cv=none; b=HcniyyCCNk1RXPfrk3/OxH9cmnXy/FgpJOvnUIbLSqWrmhi5XabF2dSkP5aFIPkGpa55wZ3mycSY94RW1Dgvud45a3QOfhXqMLQmZtsO++VA7V18+ht2ZV1gJKSuR9Yy231lrg9JSe+0dM7VJt1MIgMC+AKVtqpOKUa7z4dW99M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324102; c=relaxed/simple;
	bh=YcHd1bswbqsnEctIwDQgIBMvzzOmYcfo7MBYD+mF5Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgUobtF2D2rsGcT70f+pNiqs1SkzuAybUBMwSRfCW0MhMDjffor44WZWPSj+crgRbgNDoLTdUY28c4z92ZOdOxLvyR2/QtJzY1/nRyEn09dRBYB7oI26+TVnqtO52l9tl9CV8ZPfWItlvTN//iIb/+aGekMucQItjogO69kL4wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u02dUute; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023F8C43390;
	Sun, 24 Mar 2024 23:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324101;
	bh=YcHd1bswbqsnEctIwDQgIBMvzzOmYcfo7MBYD+mF5Mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u02dUuteFUfk/PPyTR7Ff2aZQpLuAqXi1DDPgJDGoGfEEVCZDYujgz4h8dvWNtOlI
	 E+oiNqcOGER/CTfX5l92tqhyXiFLWPGb/7F4RMPzYMY7fNUGLQk4V7e3nTpURFEBJm
	 r02hoJcUyDVxpXVJcFjvNstcju26l9/Xmn/IsRL2Pg7YfHjH21T7qmWE5Wd3mirARt
	 Q5EGjCo2x6Wvx2G9O5S7DGclxS9LCCq6weoksnisSjEAD/TD0HREPoXbEzxkzQmAcd
	 BASm+gWnj+ru5jZLDOQMCyAQemgTGYiMNtXzDBWUgVMOKJvluUYIlNsBWyScVXjaFk
	 PaQBPMZ9jxYeg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 100/183] PCI/AER: Fix rootport attribute paths in ABI docs
Date: Sun, 24 Mar 2024 19:45:13 -0400
Message-ID: <20240324234638.1355609-101-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 3c9a8c4a25eb8..988724cc85182 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
@@ -103,19 +103,19 @@ collectors) that are AER capable. These indicate the number of error messages as
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



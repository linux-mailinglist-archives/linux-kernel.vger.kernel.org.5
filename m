Return-Path: <linux-kernel+bounces-115218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36044888DCD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2051F276F4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8C3295D17;
	Mon, 25 Mar 2024 01:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzF9qJY/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2156122E80E;
	Sun, 24 Mar 2024 23:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324306; cv=none; b=WBdZGU26pAJUmsQYHsfrD9tSRlrYYd9DVZjAo+gS4XMLVKKYU4CNRUhUlDcWhrwhVfzSsFHcQlQFqs8sZ/FZh9mq/styUWjX2F0Ui7ydl1ozBovBHgpvw0jTo3hmKU6Br7mmUJsSPAKm0RkirGNEZZNUj5qIT9Y05riOVuMsVJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324306; c=relaxed/simple;
	bh=UqehTMGg7Fn+zZSiEgY3XgpNnzC1QL9aW+I7SEnJRHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOdxGLikbf2kRsjJ6JKL24oWswtaU6i2UTB7EFpFatgzgt7n4sMEGRzSK1M+GkrAZGCb9XebWYNhzXOwmLzvM91x4KoCuoVS537s8R04arHcQcOcwcrIhYtJSUwhO5EWgvA0RL5mZi5Ic2FDo/HTItV+Pm19EgzX8eH8WxWJFjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzF9qJY/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474F8C43399;
	Sun, 24 Mar 2024 23:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324306;
	bh=UqehTMGg7Fn+zZSiEgY3XgpNnzC1QL9aW+I7SEnJRHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SzF9qJY/ugHK/bQy+4hVktAiVNM6neb7H0CiFwKw//GA6EnU3NTqa5U1TFW9tayke
	 IjsyuFYq3H+OGBYbfX+dd56jlapeQNY6SDyEPsLgToilsJrzsgue2Q+PxTuYrAbmgm
	 qxxw0gsP+fkqS9TbUkKE/NXuum20kb5nAiaqD00SFwCujCUkSr/94lxlHKVviUShmW
	 317ug93vWTLnHtzYsjKVJ1grCVYmX14jVgpQkdjssHo2T+fXJVGWA6Sb35pl6AznrL
	 wv5EsPzocYhnAYylx82IseAL44lbS+yxrona2QsJ12bBe0VMJJOTqrs6RIvlM3F3rF
	 0RwEI3480Q2vA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 078/148] PCI/AER: Fix rootport attribute paths in ABI docs
Date: Sun, 24 Mar 2024 19:49:02 -0400
Message-ID: <20240324235012.1356413-79-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index ff229d71961c3..afe7bdf4f9ad0 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
@@ -103,19 +103,19 @@ collectors) that are AER capable. These indicate the number of error messages as
 device, so these counters include them and are thus cumulative of all the error
 messages on the PCI hierarchy originating at that root port.
 
-What:		/sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_cor
+What:		/sys/bus/pci/devices/<dev>/aer_rootport_total_err_cor
 Date:		July 2018
 Kernel Version: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	Total number of ERR_COR messages reported to rootport.
 
-What:	    /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_fatal
+What:		/sys/bus/pci/devices/<dev>/aer_rootport_total_err_fatal
 Date:		July 2018
 Kernel Version: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	Total number of ERR_FATAL messages reported to rootport.
 
-What:	    /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_nonfatal
+What:		/sys/bus/pci/devices/<dev>/aer_rootport_total_err_nonfatal
 Date:		July 2018
 Kernel Version: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
-- 
2.43.0



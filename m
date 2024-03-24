Return-Path: <linux-kernel+bounces-116328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D866F889E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15CF41C359A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F45F22F8ED;
	Mon, 25 Mar 2024 03:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ng7x8F+s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243BF22E803;
	Sun, 24 Mar 2024 23:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324305; cv=none; b=tWe9/6sZj7gxl4G0rAeFRHJbbJVNaCuxrlHc+ReVKyncfsdfDEqCwLiCWyDYfHfH3S1BuZnbxiu7Fpb8HDO6UtNWyAjWYhmCEjomfJykAybanZSihl2fUCvoPbkBzO2G25A1oi8OBb8dXWrL0rvuyGltxgC39zOKRLJHatsrs8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324305; c=relaxed/simple;
	bh=8klRyTWkxBJY9mtFt54/MDexI3MPHXzw9//0eOHJF/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxTJR6GW1zbPmCVjk8pFbTKFwm+VaGmI3wgdtclc2r3XqKEYBrpJ002Cl8FVEd6iDXlQWYYLY1EVxHzlJ4a6a9WBwWulbHY3jVMeY5wksIdDssLcg9A4TPFExRFhyNJYFnZDITkc6k1EEQ/F2f+Wvukvi/E97PdAwlhxrwW+Maw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ng7x8F+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B6AC433C7;
	Sun, 24 Mar 2024 23:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324305;
	bh=8klRyTWkxBJY9mtFt54/MDexI3MPHXzw9//0eOHJF/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ng7x8F+sRU4TYnf1Q/wWeOa+DoBlyxWb6tC28+6JJ4lcQFey68wsDN1D7iuZIs2wN
	 5xAcZcWGMIBZAWBtt/Y8pxvP2/IrYDNhok3u3K0bSBVCav+DPEHpvWyO1871yOdyLD
	 laR4Oikm1P04oUeim502HpvR98QkAnI9m0eynSVtoba6qsY5Hd6pjasy7yGo1TJjS6
	 t+CvvDTmEdrEsjJ2eQs5eoIsfZLRVK+v254V+XoICbhSHvm8fw5az0ZKh/l7KkeUFP
	 B7fAUaLS7HvZLhmYbg459EJbk6sGjznAXXwAfAbjPQFlqSFj5TjuA8b+kcgfkDg9uz
	 2iXdF9mVnI3lQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 077/148] ABI: sysfs-bus-pci-devices-aer_stats uses an invalid tag
Date: Sun, 24 Mar 2024 19:49:01 -0400
Message-ID: <20240324235012.1356413-78-sashal@kernel.org>
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

From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

[ Upstream commit abf313b5a8b72302062dd407ed7e470d67d389bb ]

According with Documentation/ABI/, the right tag to describe
an ABI symbol is "What:", and not "Where:".

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 0e7d29a39a54 ("PCI/AER: Fix rootport attribute paths in ABI docs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ABI/testing/sysfs-bus-pci-devices-aer_stats      | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
index 4b0318c99507f..ff229d71961c3 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
@@ -9,7 +9,7 @@ errors may be "seen" / reported by the link partner and not the
 problematic endpoint itself (which may report all counters as 0 as it never
 saw any problems).
 
-Where:		/sys/bus/pci/devices/<dev>/aer_dev_correctable
+What:		/sys/bus/pci/devices/<dev>/aer_dev_correctable
 Date:		July 2018
 Kernel Version: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
@@ -31,7 +31,7 @@ Header Log Overflow 0
 TOTAL_ERR_COR 2
 -------------------------------------------------------------------------
 
-Where:		/sys/bus/pci/devices/<dev>/aer_dev_fatal
+What:		/sys/bus/pci/devices/<dev>/aer_dev_fatal
 Date:		July 2018
 Kernel Version: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
@@ -62,7 +62,7 @@ TLP Prefix Blocked Error 0
 TOTAL_ERR_FATAL 0
 -------------------------------------------------------------------------
 
-Where:		/sys/bus/pci/devices/<dev>/aer_dev_nonfatal
+What:		/sys/bus/pci/devices/<dev>/aer_dev_nonfatal
 Date:		July 2018
 Kernel Version: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
@@ -103,19 +103,19 @@ collectors) that are AER capable. These indicate the number of error messages as
 device, so these counters include them and are thus cumulative of all the error
 messages on the PCI hierarchy originating at that root port.
 
-Where:		/sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_cor
+What:		/sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_cor
 Date:		July 2018
 Kernel Version: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	Total number of ERR_COR messages reported to rootport.
 
-Where:	    /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_fatal
+What:	    /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_fatal
 Date:		July 2018
 Kernel Version: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	Total number of ERR_FATAL messages reported to rootport.
 
-Where:	    /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_nonfatal
+What:	    /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_nonfatal
 Date:		July 2018
 Kernel Version: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
-- 
2.43.0



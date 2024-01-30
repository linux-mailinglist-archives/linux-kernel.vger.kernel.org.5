Return-Path: <linux-kernel+bounces-45358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D578842F4A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FE1A1C2461F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B937D3F7;
	Tue, 30 Jan 2024 21:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOL2+b5C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D25B7D3F1;
	Tue, 30 Jan 2024 21:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651970; cv=none; b=rKFcmLWDC4itrSDH5BPOUWBnAzHR/gsLW2SIlWrKv3AN/sesGGlEoyLCStPTTVp14wG6WkUGacUzTW5mdN0cBIWcG1/yMzfFpO/L0NRNiqIguyBb/kkFdrvifd0H17MZWBRbsqdRsghV5h3qc4nnMJl4FAeK1bLU/iQ4KmyrzSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651970; c=relaxed/simple;
	bh=tkvCjl0GNbqD1VkgAKjcr0EoK5C3zyMt6LCQohgONiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q3vk2JlizFOnd9DROf7G11zeIGPLqJVgkgUug2Vhtbndbawo2ATwuxe+bHLDilA84EkHMrCFMNRzVHUQM88V3nkqs7RnGB3fl9Wb/4jgfp7Mdkk5cJaBiA0adFpN+vexY6QmyxaY5QQxcvZoADZBT64CAB0AZ74Xx5MkG5eP8bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOL2+b5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599FBC433C7;
	Tue, 30 Jan 2024 21:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706651969;
	bh=tkvCjl0GNbqD1VkgAKjcr0EoK5C3zyMt6LCQohgONiY=;
	h=From:To:Cc:Subject:Date:From;
	b=IOL2+b5CebcBuwOKmYO4VzGmG63j0/rHkSURYyagXz/0HM6f5YDijQgM//HoUjwAQ
	 dyZUVYtlBG+odNAw8DCWWq0vb9P2rT6/fA7bc/FGCyyZYdwJM2vhvqecmBsezyQym7
	 KwbgUuz2iPaK0cy9pk48/uRgcivhiCIitLyVFzY+GHNQcqfhzUT9G52SXghz5LYrRu
	 aqokpalQ1gHP3nBk0qQ15KdeamrJRtIDcKfOppbc0pS2inhKqROVn4u5pIhjEtWlzJ
	 aTDKfksirLsKQe1H68vnud04jd/y86z1ts72M+/jknudmGbH6EWduULI5VdRw+6amW
	 G6E2qdYD/OL3Q==
From: Rob Herring <robh@kernel.org>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add TPM DT bindings to TPM maintainers
Date: Tue, 30 Jan 2024 15:59:17 -0600
Message-ID: <20240130215917.2473250-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bindings for a given device class generally go to the respective
subsystem maintainers. Add the TPM bindings to the TPM
maintainers entry.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97f51d5ec1cf..e5e3dd672018 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22040,6 +22040,7 @@ S:	Maintained
 W:	https://kernsec.org/wiki/index.php/Linux_Kernel_Integrity
 Q:	https://patchwork.kernel.org/project/linux-integrity/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
+F:	Documentation/devicetree/bindings/tpm/
 F:	drivers/char/tpm/
 
 TPS546D24 DRIVER
-- 
2.43.0



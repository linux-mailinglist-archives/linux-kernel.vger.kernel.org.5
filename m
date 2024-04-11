Return-Path: <linux-kernel+bounces-140050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 540288A0ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B751F2487A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D1313F45B;
	Thu, 11 Apr 2024 08:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHaTjvwz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09822EAE5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712822656; cv=none; b=Tfz4CqDaTEv59S2KUlNrxUE+0/y/ReGmX7spq1Z3hekj0FmoYdlBMsK0EUawid4L/L/fhO8r0nlZqeouYrOc26zSlngCk4ujNR1bt+etY3lULJd6d2KpYJtITzaZy6PdQyi+6fKKvIYee6n3/zyCU8pY0gnX/DsmabizZRhw7k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712822656; c=relaxed/simple;
	bh=RcCMzl+NVoCvYWaAiqWRk+k/Xy+cyvig7et+5PQ76tg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WKbH0vBolHlKOZneTXreZh1gtOn0f+sxireIPBNOTHOyRMvkkGrAbAnTHQQsm+fF7qv4SXFXh68zdqa49FDu3EHT6WbioSX5yuev+Z296uW9wcscHTZp2cG9kiV+OUHZS/LRCGYZI69FvOjTn9OBj9tgeT6+rUpC/AIA8xiD9ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHaTjvwz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC94CC433F1;
	Thu, 11 Apr 2024 08:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712822655;
	bh=RcCMzl+NVoCvYWaAiqWRk+k/Xy+cyvig7et+5PQ76tg=;
	h=From:To:Cc:Subject:Date:From;
	b=qHaTjvwz0tCqMUYvDRD1juussuEBadPHoITDIDKlMxZi11WWgFvvqfKMhH9al2lMq
	 PuKPn11roAarEX7kSLjRmkvQZzjP6V4GwiLWS9DLEQXWsMJSaKhqOqmOvrv2IYKDMM
	 3oOrZkoEUWP1d1sKOQL3884jZQ+nXoMKoG/qo2fIsvFh+MTT9SDeC5WfoduqLBUYKu
	 5bM06+3e976cM1BcB3MUHKdB+FX0I9ua2ZeYhvHLcEKI5ST1Da2rLp+/wE1GaNHS1C
	 25WiR1uUT1w49wQRmT1KrR5zySYWNiZ3u40AmnHpVwHIXiGgq4881t5MbjawKw0rEh
	 Y2FPCF4SMFB5g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rupPo-000000002Pb-3B3k;
	Thu, 11 Apr 2024 10:04:12 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] arm64: defconfig: enable ext4 security labels
Date: Thu, 11 Apr 2024 10:03:28 +0200
Message-ID: <20240411080328.9230-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable ext4 security labels so that setcap works as expected.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7739e426d1c5..ac6fb3de1e3a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1599,6 +1599,7 @@ CONFIG_HTE_TEGRA194=y
 CONFIG_HTE_TEGRA194_TEST=m
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_BTRFS_FS=m
 CONFIG_BTRFS_FS_POSIX_ACL=y
 CONFIG_FANOTIFY=y
-- 
2.43.2



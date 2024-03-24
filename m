Return-Path: <linux-kernel+bounces-114180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D808888EB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29751C27849
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B658624A86F;
	Sun, 24 Mar 2024 23:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWUsL5BT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84D7137748;
	Sun, 24 Mar 2024 23:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321517; cv=none; b=kH5TPw5TwDHbfH9enrRqkhzrQ3J511xkpIou5FUssg0QajXDM8CVBHxwHVjOO8difanWhDrTJ4R2A8dXq1rW3HbgowaisG8sZ8FdGx9yjmTmJHU6nM1EH+2xnCf2cLh2wcpyBvRwLsmnt7p+m85NPsXzjIQAhqrrs8iI2E4S8gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321517; c=relaxed/simple;
	bh=M0rRp9TZohhOSgUlfBcWPQEY0vryjI1+b07eow0JeMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gnKYso12TbDjF9BttZBT4ESXBt9hGIIxQYYJuo5GmlKW0+Gj5DFBc/r4lfyVvbrMyLxO1m6wF/PPDbd/Ov1OjftZhlXK6qhBuhaDcvgW3MMPUSITOQFMEb5OIdA3z7dPV1ADCNXNi2wB90te1L8Ui+nqQrln3YVlo/qibRWq0V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWUsL5BT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8C4C43330;
	Sun, 24 Mar 2024 23:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321516;
	bh=M0rRp9TZohhOSgUlfBcWPQEY0vryjI1+b07eow0JeMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jWUsL5BTW80xoCSYxnr89zqjpbnduwHr16dQYYZ3jTwjGacMKnx8B9/eh8CMq3whQ
	 0x+xLAuXpHnOsCc/GzGDxDMsMeon8kuzz1/NcAAyAOMx3ABLXSfZwZW0wf4q6SvFho
	 tzg1LThQgxmwsyBRIfXUTmgma5WFw4BH3LdhHyRioH31UDU32OqgD5I70emUGDL51Q
	 W038zuegt7hpbOuScS1BvNKbSi/fyLplEwUca2+1utx5uQWOcW5ZDc2ElH/m/SCF5t
	 kH16RqDjO06XJwV0RGGCBFv+MWDlSYrSvU7o92xTIT2HUp8jWyEMOkXLZBzZu7+Jd7
	 SVsXJYOD71lyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Judith Mendez <jm@ti.com>,
	Wadim Egorov <w.egorov@phytec.de>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 243/638] arm64: dts: ti: k3-am64-main: Fix ITAP/OTAP values for MMC
Date: Sun, 24 Mar 2024 18:54:40 -0400
Message-ID: <20240324230116.1348576-244-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Judith Mendez <jm@ti.com>

[ Upstream commit 379c7752bbd0e81654544a896dd19c19ebb6faba ]

Update MMC0/MMC1 OTAP/ITAP values according to the datasheet
[0], refer to Table 7-68 for MMC0 and Table 7-77 for MMC1.

[0] https://www.ti.com/lit/ds/symlink/am6442.pdf

Fixes: 8abae9389bdb ("arm64: dts: ti: Add support for AM642 SoC")
Signed-off-by: Judith Mendez <jm@ti.com>
Tested-by: Wadim Egorov <w.egorov@phytec.de>
Link: https://lore.kernel.org/r/20240213235701.2438513-5-jm@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 693e7550bf955..064eb062bb54a 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -612,6 +612,9 @@ sdhci0: mmc@fa10000 {
 		ti,otap-del-sel-mmc-hs = <0x0>;
 		ti,otap-del-sel-ddr52 = <0x6>;
 		ti,otap-del-sel-hs200 = <0x7>;
+		ti,itap-del-sel-legacy = <0x10>;
+		ti,itap-del-sel-mmc-hs = <0xa>;
+		ti,itap-del-sel-ddr52 = <0x3>;
 		status = "disabled";
 	};
 
@@ -624,12 +627,16 @@ sdhci1: mmc@fa00000 {
 		clock-names = "clk_ahb", "clk_xin";
 		ti,trm-icp = <0x2>;
 		ti,otap-del-sel-legacy = <0x0>;
-		ti,otap-del-sel-sd-hs = <0xf>;
+		ti,otap-del-sel-sd-hs = <0x0>;
 		ti,otap-del-sel-sdr12 = <0xf>;
 		ti,otap-del-sel-sdr25 = <0xf>;
 		ti,otap-del-sel-sdr50 = <0xc>;
 		ti,otap-del-sel-sdr104 = <0x6>;
 		ti,otap-del-sel-ddr50 = <0x9>;
+		ti,itap-del-sel-legacy = <0x0>;
+		ti,itap-del-sel-sd-hs = <0x0>;
+		ti,itap-del-sel-sdr12 = <0x0>;
+		ti,itap-del-sel-sdr25 = <0x0>;
 		ti,clkbuf-sel = <0x7>;
 		status = "disabled";
 	};
-- 
2.43.0



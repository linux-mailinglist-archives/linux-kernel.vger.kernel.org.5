Return-Path: <linux-kernel+bounces-114791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EC988913D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 172871C2D547
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF207316E;
	Mon, 25 Mar 2024 00:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbxlGip/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87BC276C59;
	Sun, 24 Mar 2024 23:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323396; cv=none; b=qsgtNwxlvowf4pje7X2WaKHvOEah/6ZIM3COubokKDUNLvbkMz4OKk6DbGxkrikejf4pxsafGN4Z/160Imf9tA26D+KeITUW1EuZTEOA9n17Whxjq6pr95LAV/CDZZPmbt7J10D0flxgV49nwW1cKEDakdIlqA/BNPsBskfWygM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323396; c=relaxed/simple;
	bh=dd4KnlxxisDWdlAEjMRav2AocqQbAWoZBZFicLAtksc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sliKImKGLzrVJx5AtdYiiXdrjAOuRX2MWsXhQst4rpS8KZYV6EIGgumoOZaZ8HDb7Rb73MxtY2JEhfaXUs+GyvXXLmb9rakdu0d+lL0l4USkA7XoZecAtTktahQ/+j/7PhJu+zaLFjBeUcvNSaU7f0zveMNEKWbJxKG/96G+hzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbxlGip/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F69C433C7;
	Sun, 24 Mar 2024 23:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323396;
	bh=dd4KnlxxisDWdlAEjMRav2AocqQbAWoZBZFicLAtksc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sbxlGip/27MEpsNNgExaGUGWqpyfcWYIiWHQ0Ula5QmQwdaEBM4Ql91B9ppz7OORO
	 SZbJVQKAtzWPh9mr1GoTRvY1a5h6n0Z/YLiFHOuu12w+pLWN0JUeaQQukEDfN9qdza
	 CGIMMz8ZcpOzjyZGpkyBxnewdFU8ef2g2v8F2gmYUQlGSPufhFlYZOaC5owrFcLS4m
	 nkdg22z9fkTtbSX7981MhOWN0SzaVs73sRkOgF6V1edSifP46pZeoDLHgPZgjcTD0g
	 eHmSU5bGS+WAb7XjrlSzIt8C01FwqixBDE4N2xLCT59OEXom0sY/Mvldk0+o7Xd0Xe
	 UBBOGzeKJXRBw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Prashant Malani <pmalani@chromium.org>,
	Alexandru M Stan <amstan@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 097/317] arm64: dts: mt8183: kukui: Add Type C node
Date: Sun, 24 Mar 2024 19:31:17 -0400
Message-ID: <20240324233458.1352854-98-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Prashant Malani <pmalani@chromium.org>

[ Upstream commit fd31f778da81fec188f3ac8e03da4338642a8f08 ]

Add a node describing the USB Type C connector, in order to utilize the
Chromium OS USB Type-C driver that enumerates Type-C ports and connected
cables/peripherals and makes them visible to userspace.

Cc: Alexandru M Stan <amstan@chromium.org>
Cc: Benson Leung <bleung@chromium.org>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Alexandru M Stan <amstan@chromium.org>
Reviewed-by: Benson Leung <bleung@chromium.org>
Link: https://lore.kernel.org/r/20211209195112.366176-1-pmalani@chromium.org
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Stable-dep-of: 04bd6411f506 ("arm64: dts: mt8183: Move CrosEC base detection node to kukui-based DTs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 6b7a42c5d5153..30a84d888c66c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -831,6 +831,20 @@ usbc_extcon: extcon0 {
 		cbas {
 			compatible = "google,cros-cbas";
 		};
+
+		typec {
+			compatible = "google,cros-ec-typec";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			usb_c0: connector@0 {
+				compatible = "usb-c-connector";
+				reg = <0>;
+				power-role = "dual";
+				data-role = "host";
+				try-power-role = "sink";
+			};
+		};
 	};
 };
 
-- 
2.43.0



Return-Path: <linux-kernel+bounces-115643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C79588945D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35DBC2839E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CD134F4F5;
	Mon, 25 Mar 2024 02:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAcMNrlB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661BB206C87;
	Sun, 24 Mar 2024 23:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321511; cv=none; b=GkOYnnwnTCRZddVJUpO7UpvJbDm5psU0QjkxC1PMbBxaw19cbNk4p0ZRusjczuCzlsiucx5HKzXYmmZ9c4AGVAg6Pf/pbBWuubbbzrKCbD7axEMo5Je03tuMnM6DyizJLAH+INPUii1glI3dg8WmlnOR2+/RE9Buk6mqqcNbQiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321511; c=relaxed/simple;
	bh=UhipjQvNWfeeujAdzDwbZqGmfdqnpiMVNNRI02gZzEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5BmufU0blSI9qI56adOkaF+FuIyGOU2SlL61dq51p+/XIBcsiQBi7Owb9ffLw+MOzNNzMJjLbM1dX0tn1SfK6lf1HDdGbGrBnh6kUPJbQvEJAlRVsF6N3VN0o260s8knEZm3hy/f90jg2Dp8NSRSWuTEFUhsh+qcxruJlbHP5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAcMNrlB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7367C433C7;
	Sun, 24 Mar 2024 23:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321511;
	bh=UhipjQvNWfeeujAdzDwbZqGmfdqnpiMVNNRI02gZzEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nAcMNrlBm0COMddmYOIpJvn6GNf/bh87ZWHU/ZSTieH79RHvLjzq64RRkLZu30ksN
	 ebGqQdkbOCsP4EcubQBjRpx9qc2Ne8tgcpnyMe5NoQYWntC3hIvwOx1O0o1zcNn0Ff
	 XofBwtoj1Z4/i82GN3HuzuFEBv+jD2saooY3KAOrYGfrFqsmp0Gki4M13/VkoEAW1w
	 e9ZcnrmXzrDecFMFjZUpT+7d+iWpoaBsQxK3cMWq4wvvU65Ms+CwCiF1O8woxjlah4
	 oJT9DnDv81XF8nxyVfJLBJ5h2jr74B1nMvFccRenHJXgDaOauPpUU0njdpx1ZrKA9y
	 QIJeKo8EjzjKw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bhavya Kapoor <b-kapoor@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 237/638] arm64: dts: ti: k3-j7200-common-proc-board: Remove clock-frequency from mcu_uart0
Date: Sun, 24 Mar 2024 18:54:34 -0400
Message-ID: <20240324230116.1348576-238-sashal@kernel.org>
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

From: Bhavya Kapoor <b-kapoor@ti.com>

[ Upstream commit 0fa8b0e2083d333e4854b9767fb893f924e70ae5 ]

Clock-frequency property is already present in mcu_uart0 node of the
k3-j7200-mcu-wakeup.dtsi file. Thus, remove redundant clock-frequency
property from mcu_uart0 node.

Fixes: 3709ea7f960e ("arm64: dts: ti: k3-j7200-common-proc-board: Add uart pinmux")
Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
Link: https://lore.kernel.org/r/20240214105846.1096733-3-b-kapoor@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 53594c5fb8e8f..7a0c599f2b1c3 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -211,7 +211,6 @@ &mcu_uart0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_uart0_pins_default>;
-	clock-frequency = <96000000>;
 };
 
 &main_uart0 {
-- 
2.43.0



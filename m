Return-Path: <linux-kernel+bounces-115278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4607D889CA9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77BA51C349DA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF9715B57D;
	Mon, 25 Mar 2024 02:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PM6AhYnN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393697580A;
	Sun, 24 Mar 2024 22:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320472; cv=none; b=eqvifkWG0TgR38/lx9VHEcuJJduGWuJUe17RbgbLm6q8N0gCOrI88szonLAUxVeZlUvsy6Co0f69ca4v9cQmQFVC6xijyAHnbHEpcvRIfOw+uRrBgushgfBTuwwmNUc/CS0RKCZM4YNh38qesvM56AOmAYil0ADHNYsNgr8KRbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320472; c=relaxed/simple;
	bh=T/akRPi5ao0d12BmCz3WEgH+FPHY9KHNebOOEFBHkBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcop4bOaQpjkP/KUWDwC86PT63BzeV8rnLYm8jnJisx+ZV8N1r3HvFozb/xHKyrngDaHbhzd3sXfAPpV0Ks6yk2wlYeFxS46OHZUm4rPOyJDlTDDzCCZPArtS3HGVnzbbZ1G9ywjZ7P/KEEx1l5L2W7tTCNJViWPjnmt5p/4hQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PM6AhYnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740B4C43390;
	Sun, 24 Mar 2024 22:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320472;
	bh=T/akRPi5ao0d12BmCz3WEgH+FPHY9KHNebOOEFBHkBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PM6AhYnN8f8aoIUet0YZ6Mr5sKiBRkR7CRrRfLga4ALGAZvshaAiebNszXDolRwQb
	 dQ5ji3UlqmqbyGQTAwuo9Y46IE6OwmU6gi5HWRjOWud/2ZBR1lJjdTvZcgFDq42eRS
	 elj1WDwur2hY6gS8DSxIdWB4Ge9iJKq5vWdEdjymQHlV1LocrNLBXjCqGDu/yB6+9i
	 9W8nbE8nuGWCnOfYACxz/4i7hcM3zoqoWqm5xOR54D3pNP+O5HcXaym9YNpaPDA+WM
	 zoQtbrsW797Danx6Q1dVls729Xh9Ia3PYyDDcfvN5coLb/FgTLYowbzekEgxtnUqpO
	 48xmiOFMMdc1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 031/713] riscv: dts: sifive: add missing #interrupt-cells to pmic
Date: Sun, 24 Mar 2024 18:35:57 -0400
Message-ID: <20240324224720.1345309-32-sashal@kernel.org>
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

From: Conor Dooley <conor.dooley@microchip.com>

[ Upstream commit ce6b6d1513965f500a05f3facf223fa01fd74920 ]

At W=2 dtc complains:
hifive-unmatched-a00.dts:120.10-238.4: Warning (interrupt_provider): /soc/i2c@10030000/pmic@58: Missing '#interrupt-cells' in interrupt provider

Add the missing property.

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index 07387f9c135ca..72b87b08ab444 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -123,6 +123,7 @@ pmic@58 {
 		interrupt-parent = <&gpio>;
 		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
+		#interrupt-cells = <2>;
 
 		onkey {
 			compatible = "dlg,da9063-onkey";
-- 
2.43.0



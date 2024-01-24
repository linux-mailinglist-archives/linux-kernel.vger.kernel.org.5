Return-Path: <linux-kernel+bounces-37128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 564E983ABDC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0F51F2B58D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4804285C7E;
	Wed, 24 Jan 2024 14:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYAzeuRf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA3B85C64;
	Wed, 24 Jan 2024 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106532; cv=none; b=tKc3uzkcOvYKj3jNuziaRjRni0u+XHRpctlhUEgzYLjepP20ZBdLDDN1aQxQls6RWtPg3X3ZX3OR7x+XmA3KF42GaUhEUJx+6/jv61pyB6QxutKJR254uFHVEfTIo7+HNf8hUCEEhCtgVZnxuDmtL++pq1gHEvnpCRuvl/sdcUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106532; c=relaxed/simple;
	bh=bbad/rI4TG9uW7+Wm5mv6bprZtTeOnxaDblTNybQL1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPStdSnndHzqYFejSECrVAbL56MY6s3b0RFbX38uMPcn0zlJ8hmJYemsNWzzYCFF+WlCVDz9R7dodGcwtq75V34YAbZBFb1VRy940QrLKfkwtlnXoorZxHCtDBpqx4tKr7kkTz0tgZHS+wP6PQehHYjcQqU6jv6VFqtkzo5VftU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYAzeuRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A76FC433F1;
	Wed, 24 Jan 2024 14:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106532;
	bh=bbad/rI4TG9uW7+Wm5mv6bprZtTeOnxaDblTNybQL1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eYAzeuRf9M3xULsDp6VEcmPU8HPnNn9LcMAn5kwW5vBW7H/YFYOyMMpAIqONI+I4a
	 P946y4C10ysYRnjkFrDoQctllV0gV4QqKbp+jMxS4l+NLJQA5fYqWnUX1BfeZoRkSt
	 FDA1/b3xeloZuCiHlzhltx3eh/2bVOCrz6KoqRX1tH5MeQqY0f1S4J/pPRbKtehOlX
	 SesqXdahAav3pqa1JneBhFV8YaK7SP+PK8RByhszz9D1jHBuq8T/ONcfu4ohqly9eR
	 AiKXxXCHimFtMFIQsj/BGFGJM5r/d4rfGoTZ7KipWEwZiCwyaKerVO8APyMGoNXyx4
	 OqqX9kNxHMJoA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.7 12/13] mfd: ti_am335x_tscadc: Fix TI SoC dependencies
Date: Wed, 24 Jan 2024 09:28:05 -0500
Message-ID: <20240124142820.1283206-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124142820.1283206-1-sashal@kernel.org>
References: <20240124142820.1283206-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
Content-Transfer-Encoding: 8bit

From: Peter Robinson <pbrobinson@gmail.com>

[ Upstream commit 284d16c456e5d4b143f375b8ccc4038ab3f4ee0f ]

The ti_am335x_tscadc is specific to some TI SoCs, update
the dependencies for those SoCs and compile testing.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
Link: https://lore.kernel.org/r/20231220155643.445849-1-pbrobinson@gmail.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 90ce58fd629e..68d71b4b55bd 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1483,6 +1483,7 @@ config MFD_SYSCON
 
 config MFD_TI_AM335X_TSCADC
 	tristate "TI ADC / Touch Screen chip support"
+	depends on ARCH_OMAP2PLUS || ARCH_K3 || COMPILE_TEST
 	select MFD_CORE
 	select REGMAP
 	select REGMAP_MMIO
-- 
2.43.0



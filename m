Return-Path: <linux-kernel+bounces-37139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D52EC83ABF7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1343D1C21CF3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77926129A6F;
	Wed, 24 Jan 2024 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScUeyPmY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE991292FF;
	Wed, 24 Jan 2024 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106577; cv=none; b=j8Vm7iNi4wKMNyZiLT5p2yT/15s5qi1Mf/4KhYABv70lUYi3nsWHGkiKQ95jrqcL6cWJ2sT1Knn6oZ1a5bH8MElDVFDUzd6z4FJu2LxSydP7uoTTRuXjQL6xm0DbD9K9cLGQnapb1X43wV6dirt1JYkptlXaYf4kDRjAQ90VzS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106577; c=relaxed/simple;
	bh=bbad/rI4TG9uW7+Wm5mv6bprZtTeOnxaDblTNybQL1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjenM1ARhxZB9VMIBaOLwrMv+MdSJOmHmPEi1p9SDtlqUDqqF6lcJ0aabDbZNCCUzFAdjSNmhqWszvl3OYBFD6gkaCyqLCbuNQWWMI5eSsCvVo/fupxmpGVj5/jtQPv0LFP/Sahzh/hvKZXU2vcM5ndkDxLlf8bFwgHLx0eCutk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScUeyPmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBFCC43143;
	Wed, 24 Jan 2024 14:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106577;
	bh=bbad/rI4TG9uW7+Wm5mv6bprZtTeOnxaDblTNybQL1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ScUeyPmYFCWDPlBq5c7laDm8JanfSOZU+b0+exn9lba99tbIBRXujdiVB0e+jxzsC
	 nexCjH9dkOp4OWA3hpC3gaMU4seCYMEifijdpynGERgBJTFwyPb66knLrO5wozchM4
	 dQMMlF+o3qhE2ghbEEJ9OjIc9d7iytW/5iZDTMHDAiLHicXbwwDxXg0S9QbGl+JEFe
	 pusD2GYGBhzcvRSqd19Fjo2RzmoP2tDdaRg7oAAflADYIpgLTcbYi5//hSe80RwBis
	 AlsaBC5bkBb+fT8LY+4UVgM3b3w3Ul1uu8im1S9qAUSaLEzGxOc/kown+9E7tONIPQ
	 jCbvOfRkfD4fw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 10/11] mfd: ti_am335x_tscadc: Fix TI SoC dependencies
Date: Wed, 24 Jan 2024 09:28:53 -0500
Message-ID: <20240124142907.1283546-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124142907.1283546-1-sashal@kernel.org>
References: <20240124142907.1283546-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
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



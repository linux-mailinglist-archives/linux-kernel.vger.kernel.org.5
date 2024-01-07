Return-Path: <linux-kernel+bounces-19010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C35C826669
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 23:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49FA1F21477
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 22:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5981400A;
	Sun,  7 Jan 2024 22:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ch+/YL1V"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682C813FE0
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 22:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B02C433C7;
	Sun,  7 Jan 2024 22:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704667235;
	bh=gMeYwznrjbIU8oGXfP+WnPDxDzH5U/iZaLqQJDBkChs=;
	h=From:Date:Subject:To:List-Id:Cc:From;
	b=Ch+/YL1VL+p4NtQnARIOOvL4qWL68Ui0QhykfB4b/pOBtjQKZozTQkoGQQyMv+v+z
	 OX0jtC9KynReOz1mP1Zwvzj9sHFOqvxAzhfU6J+oKdR0YP+3YM7UrvjbnZqVQ3Uobb
	 mPi8FeOYKqMJ9RCY9m5BLt5WKh8M5nxdP7qeM+xzl8/Dfzjcn1dDXOaMqScZhwL+Rq
	 bw7fayEX2Zlpb3pn+0EAseAYmbxjpCdlI6DcL2xndgxnGmvh32HnkXiA5ZH9BbTWi6
	 KTpP3oXOisn5a2r2HWDc9hrvC0gkuGUhk906yzxjWLords+GAit3PHEY+MkbZKebwN
	 YYIkeuMioaTGg==
From: Mark Brown <broonie@kernel.org>
Date: Sun, 07 Jan 2024 22:40:29 +0000
Subject: [PATCH] ARM: multi_v7_defconfig: Enable STM32 IPCC mailbox driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240107-arm-defconfig-stm32-ipcc-v1-1-924721db5661@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFwom2UC/x3MMQrDMAxA0asEzRXIboggVykdjCwnGmwHu5RCy
 N1rMr7h/xO6NtMO63RC0691q2XAPSaQPZRN0eIwePIzOWIMLWPUJLUk27B/8tOjHSK4zETshEN
 khpEfTZP97vXrfV1/dKzoIGoAAAA=
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-stm32@st-md-mailman.stormreply.com, soc@kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=924; i=broonie@kernel.org;
 h=from:subject:message-id; bh=gMeYwznrjbIU8oGXfP+WnPDxDzH5U/iZaLqQJDBkChs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlmyhg2lXCL3MIQsuRcxZL6PRQTJ7KfgTBogFnh
 kEGv+36+OaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZZsoYAAKCRAk1otyXVSH
 0NjRB/4r9gayJx9sLsDkrCbccgsHwsdKSDyE5usVSohEHTWmpBpP/xjYkadUXQydpUw6NnJVofa
 Wzpv1APyGBl3kcdHZ0wBtQT8+LUDnaLek7FPGhVzEBAjpWwotHbpOF0hP9JcPiEAKpNeO7ytTvb
 Az6HYTN830yfs+Uf+tZUJOdkUjEeSeObsl2yaOx3810jVLC1mEN9o1CxsGh6j5JaoUGIVqR4uIb
 kjVOi+0O0BY7oYRnLdLWZLnSXsWSoBJ14/O9uxPniT3Xhm5k756YuyvUVAo8yCKXAw3GY+2LMgE
 htQUGy6rTPa9cVobOQW8wTKh2r3GpGSGiGW591lPXMQB9VTC
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The STM32 systems have a mailbox used for communication with non-Linux
processors like the M4 on the STM32MP157A.  Enable the driver for the
mailbox so it is available for testing.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 10fd74bf85f9..f43ae4532586 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1073,6 +1073,7 @@ CONFIG_OMAP2PLUS_MBOX=y
 CONFIG_BCM2835_MBOX=y
 CONFIG_QCOM_APCS_IPC=y
 CONFIG_QCOM_IPCC=y
+CONFIG_STM32_IPCC=m
 CONFIG_OMAP_IOMMU=y
 CONFIG_OMAP_IOMMU_DEBUG=y
 CONFIG_ROCKCHIP_IOMMU=y

---
base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a
change-id: 20240107-arm-defconfig-stm32-ipcc-640071c7ad77

Best regards,
-- 
Mark Brown <broonie@kernel.org>



Return-Path: <linux-kernel+bounces-23778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A16082B186
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CA35B2455C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4204F8A1;
	Thu, 11 Jan 2024 15:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="p+9+sKPZ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6EB4CB47
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704986096;
	bh=0znedC8OB15oZfdhOihzbhh+CJ3Focnsl8tk4l0W1qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p+9+sKPZS08mP2NlNyNeVGEBxJTNTsLGDmyvYAANyw2Kt8BEJ04UljvZ1otKuZFMd
	 1Iw2i/8aDoRKNOGMlEUFg51NlZ8WlZ7BSsacnnjCVG/7xLV5Sx7rOk58ADP7/7RTDc
	 t9C41EXRKksWgJDD9tfH+APcdsqEjhavuSZNmxsDfs7EaGnVFS+DwbleIkPi+vQFog
	 PFxRhFOG4fo5U7sIHdeT65sTo2R4ThUzwAGRBpM3FurLdNOqsbDN94MhJTGG7zPwvs
	 kJ+DCEe139Mqjg9grNJcNyPvvb1azG5t55oYTRtkNOPY1irow/2CLH4IY6RWKJqkSV
	 s22Z2Xih+4ggw==
Received: from localhost.localdomain (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 956CE3782012;
	Thu, 11 Jan 2024 15:14:51 +0000 (UTC)
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: defconfig: Enable support for cbmem entries in the coreboot table
Date: Thu, 11 Jan 2024 12:11:49 -0300
Message-ID: <20240111151226.842603-5-nfraprado@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111151226.842603-1-nfraprado@collabora.com>
References: <20240111151226.842603-1-nfraprado@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Enable the cbmem driver and dependencies in order to support reading
cbmem entries from the coreboot table, which are used to store logs from
coreboot on arm64 Chromebooks, and provide useful information for
debugging the boot process on those devices.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0b0ef6877a12..cd94d55b23b2 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -255,6 +255,9 @@ CONFIG_INTEL_STRATIX10_RSU=m
 CONFIG_MTK_ADSP_IPC=m
 CONFIG_QCOM_QSEECOM=y
 CONFIG_QCOM_QSEECOM_UEFISECAPP=y
+CONFIG_GOOGLE_FIRMWARE=y
+CONFIG_GOOGLE_CBMEM=m
+CONFIG_GOOGLE_COREBOOT_TABLE=m
 CONFIG_EFI_CAPSULE_LOADER=y
 CONFIG_IMX_SCU=y
 CONFIG_IMX_SCU_PD=y
-- 
2.43.0



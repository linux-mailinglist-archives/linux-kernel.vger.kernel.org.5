Return-Path: <linux-kernel+bounces-22800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0307382A30E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00841C227B7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BDC4F219;
	Wed, 10 Jan 2024 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JjKgFda3"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EDC4F5E8;
	Wed, 10 Jan 2024 21:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704920889;
	bh=FBy4JaNYah3EAa7vsotPhU5x1QVsgRyszaVKUcXB1cA=;
	h=From:To:Cc:Subject:Date:From;
	b=JjKgFda3Y8qtFXfrmwQD1XLw4+chmXgGcgs8NRaeCQ5l8QK2g/dCtMkdw+A3Jikrs
	 olDjwDFughlQYHQrjKGXIxcNl4FJ9pkOV4VLU/SrVpROTIIV2OYsYcx7sySvXsy4Jv
	 ZjxbKI9SZwYKPV84R1sPm+R+Z2+Pdbs+PjHuDrdEtXaXecblSPmzU6Jkniy8LeKMMu
	 GhRks25sFGDzUTS5B7mbdfkwjr3OD/fuN2wD8M0K1b0dLqTDFLTYZAmhe6SyuqzNm7
	 LcNKn9AL3pRU3WG1e5QVK7G7LSA+DF3n6WOBsb4FIt4Z/lqn07pFmJigfr6u6UVowl
	 UyIcKmMys2cXQ==
Received: from localhost.localdomain (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C63823781469;
	Wed, 10 Jan 2024 21:08:03 +0000 (UTC)
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
To: Kees Cook <keescook@chromium.org>
Cc: kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Tony Luck <tony.luck@intel.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Enable PSTORE_RAM as a module in the arm64 defconfig
Date: Wed, 10 Jan 2024 18:05:01 -0300
Message-ID: <20240110210600.787703-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This series enables the PSTORE_RAM config, aka the ramoops driver, in
the defconfig.


Nícolas F. R. A. Prado (2):
  pstore/ram: Register to module device table
  arm64: defconfig: Enable PSTORE_RAM

 arch/arm64/configs/defconfig | 1 +
 fs/pstore/ram.c              | 1 +
 2 files changed, 2 insertions(+)

-- 
2.43.0



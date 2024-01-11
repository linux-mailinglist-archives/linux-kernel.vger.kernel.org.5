Return-Path: <linux-kernel+bounces-23064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9887882A718
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 05:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38FB2B2730A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 04:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F132F256D;
	Thu, 11 Jan 2024 04:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TV4VhHxG"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0B01856;
	Thu, 11 Jan 2024 04:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=lAETidl+Wl8rX9fUWkjIkcQ01vBdcd3CEgjPvhm/LgI=; b=TV4VhHxGOOo0zwqPwqq0JsbLD7
	WqpNTK3xwMcGySVFSzPbh08e4Glb5NWvfIUtm5BaNQpt7ynoAKLSzEfScTFav4HT1UHJaYNniZ7Qm
	T90qIYbducqvA2Ppo8djHjIXxN72mhZi4wTJws9kRfPNCrSZ8oO4wD1GEzBjDLhw2IpgTcj5YU0JR
	VFAOV71WoBjNdsIiZZ1oWWi4e3PgnlsmwqZ1ffbpPbjOtXpZTqiN8+hGrCgbP9dwUbb8FK3XNczXD
	PFkwdQctCsaotAMRFcfVT+9k2XyHQT3wibAzazFuVQKfqVN6dwEG/BRud+jx2eNvjmaYlbUBgn1xP
	MEnyiZfA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rNn2N-00FrCJ-15;
	Thu, 11 Jan 2024 04:51:27 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	kernel test robot <lkp@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] pinctrl: mt7986: excise kernel-doc warnings
Date: Wed, 10 Jan 2024 20:51:26 -0800
Message-ID: <20240111045126.13768-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix kernel-doc warnings for enum (anonymous): the enum values are not
documented, so don't indicate that the comment contains kernel-doc
notation.

pinctrl-mt7986.c:68: warning: Enum value 'GPIO_BASE' not described in enum '(anonymous)'
pinctrl-mt7986.c:68: warning: Enum value 'IOCFG_RT_BASE' not described in enum '(anonymous)'
pinctrl-mt7986.c:68: warning: Enum value 'IOCFG_RB_BASE' not described in enum '(anonymous)'
pinctrl-mt7986.c:68: warning: Enum value 'IOCFG_LT_BASE' not described in enum '(anonymous)'
pinctrl-mt7986.c:68: warning: Enum value 'IOCFG_LB_BASE' not described in enum '(anonymous)'
pinctrl-mt7986.c:68: warning: Enum value 'IOCFG_TR_BASE' not described in enum '(anonymous)'
pinctrl-mt7986.c:68: warning: Enum value 'IOCFG_TL_BASE' not described in enum '(anonymous)'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312110210.x3vxq42A-lkp@intel.com/
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org
Cc: Sean Wang <sean.wang@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/pinctrl/mediatek/pinctrl-mt7986.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/pinctrl/mediatek/pinctrl-mt7986.c b/drivers/pinctrl/mediatek/pinctrl-mt7986.c
--- a/drivers/pinctrl/mediatek/pinctrl-mt7986.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7986.c
@@ -16,7 +16,7 @@
 		PIN_FIELD_CALC(_s_pin, _e_pin, _i_base, _s_addr, _x_addrs, _s_bit,	\
 			_x_bits, 32, 0)
 
-/**
+/*
  * enum - Locking variants of the iocfg bases
  *
  * MT7986 have multiple bases to program pin configuration listed as the below:


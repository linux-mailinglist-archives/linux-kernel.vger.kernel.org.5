Return-Path: <linux-kernel+bounces-29312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2333E830CA8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9ABCB242FC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5A82374D;
	Wed, 17 Jan 2024 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="x2pbTALC"
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C883A23747;
	Wed, 17 Jan 2024 18:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705515739; cv=none; b=LrsiDYL9v8abxPmWKj5eNqOVsL+oH5YdZ9jSvaWRIbzEiaOQGgx1hQx2aPlyyKu0IYXCvTNH2gz0YpS3EAgYmrEpXawL6abVQox26wLPZDm4B9aT4lzdapln+LW60wMYlEf313r6jbJ/9jHEZgLVXQvYE1HIjaPivK57AfiCEGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705515739; c=relaxed/simple;
	bh=3VdOjc3X148qsKr0xLzhVrZ+WN/d9jtjGD8XrGEuK1E=;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mail-ID; b=EPOEJtB8pOMiyuo2x/HBIM5ST9JpxmQXcCz18GtOmSYHJlMYs2Iq/xk82i/iC9XWNClBdmfjsKISsO7HFTAffSC9SYsK8c7wU165Nk7cG3ijT6dtaRE/lnRYYGdXmi8DhkIbEZro09VOygKstz/3ZTKq7LO14z/itCkfVSrdwJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=x2pbTALC; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout2.routing.net (Postfix) with ESMTP id 452265FC7E;
	Wed, 17 Jan 2024 18:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1705515353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=faaWm9kKMcck2ImmwhnetGgTDP4WHiKRSvb4Y2er2NM=;
	b=x2pbTALCTpXpjTlSpbqC3CbYw83ZKHbpjyKWCW5LEU1zrgBGHziOM2hEt9jrSmRH9Q+P8E
	0CYzL4UsE/VqPJTdzPkoa9ZKjGMQSTcnutw/dA+0cJe+4LCSK2d4LKUqDj4A9iqTyjHtAL
	Md7Tdrl08PIPHBM4nLUnzRQBceXLJes=
Received: from frank-G5.. (fttx-pool-217.61.151.254.bambit.de [217.61.151.254])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 367C93601D6;
	Wed, 17 Jan 2024 18:15:52 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	Sam Shih <sam.shih@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 0/2] Add reset controller to mt7988 infracfg
Date: Wed, 17 Jan 2024 19:15:43 +0100
Message-Id: <20240117181545.60355-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 2b681597-9b8b-4c5c-8a97-97f5be73149f

From: Frank Wunderlich <frank-w@public-files.de>

Infracfg on mt7988 supports reset controller function which is
needed to get lvts thermal working.

Patches are based on clk-next due to recently added mt7988 clock driver:
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git

changes:
 v3:
   - start resets on RST0 offset (LVTS is RST1)
   - rename offset constants with MT7988 prefix (else collision with reset.h)
 v2:
   - change value of constant to 0 from 9
   - add missing SoB and commit-message for binding-patch


Frank Wunderlich (2):
  dt-bindings: reset: mediatek: add MT7988 reset IDs
  clk: mediatek: add infracfg reset controller for mt7988

 drivers/clk/mediatek/clk-mt7988-infracfg.c    | 23 +++++++++++++++++++
 .../reset/mediatek,mt7988-resets.h            |  6 +++++
 2 files changed, 29 insertions(+)

-- 
2.34.1



Return-Path: <linux-kernel+bounces-74122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4A685D036
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58AA02867C8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2378712B89;
	Wed, 21 Feb 2024 06:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MdqULe9P"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CE138F9B;
	Wed, 21 Feb 2024 06:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708495315; cv=none; b=eMgIixG9zu+jAePVgNV0viBxpC4ik2NzXglTR8yE/bORYlOUbSTFc7x5GqUp/cDVvLSBw1ioJPdlFlONdZx4BSpVGqDxu+dvn/w0XFaBUdsShcrSQM9wTT5p1TUzJCTiBsCU2joI+aiJtdF5bwx9qDAtNPlEGHMGWfHgRtHU9iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708495315; c=relaxed/simple;
	bh=3mYbxteSnGdLwRswU9vmblnB24big6NFdwetFY1MgB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QbmlS66kV3ddNauLS4duslg3mS8zL2BDLpi7uPuQ4zXnMx+g2hxGrnY+eXFLMzhw7R1Wa54faPJ788bYRO08xqYrWyyUPK6Y0oa60b9hVEl5W1KYkRoV7wP/2sgTTvWKn/TzeJVqSDsNKiJZNlBS5lSTW+iWlG2HZIIbdiZT1co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MdqULe9P; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=GAwyW1WmqnYJsvj/UUVCgTHwqyf9JnLOO1VjiUjrKdA=; b=MdqULe9PNEvg23rSt0Q05dJAhc
	oZjFw4Ub5bIjDanYCSHCP99yOsJ9uzL8vtb/pXBmsuedu7dXmRCi4i9VOEDOoFDzO0IcTTB/sRGOM
	8iT8BBj12ji5/XN71FOBMIurvIXhlEYf3Ir8NGJf/+zpHkLQnjn6oS9rlpS4qq0frGMcNmbYCLoKE
	+/U9f33CDmkp26PsbgcEbbuSVs2x4Nb47Bk0U071giA+dV9JRlajVlCqa6QBOyOVqzaN5SbIKQ/LD
	b9cseDXUUjn3YS1i2c+evyoJ3SEPOSGU8ZiLYLnODBPdM/IS9o4e0fVvgPuPJLC9YcBjCbFYWptHm
	1yV2CAGg==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcfg1-0000000HHhi-2igR;
	Wed, 21 Feb 2024 06:01:53 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	linux-leds@vger.kernel.org
Subject: [PATCH] leds: mlxreg: fix a kernel-doc warning
Date: Tue, 20 Feb 2024 22:01:53 -0800
Message-ID: <20240221060153.3924-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop one struct description to fix a kernel-doc warning:

drivers/leds/leds-mlxreg.c:42: warning: Excess struct member 'led_data' description in 'mlxreg_led_data'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vadim Pasternak <vadimp@nvidia.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Lee Jones <lee@kernel.org>
Cc: linux-leds@vger.kernel.org
---
 drivers/leds/leds-mlxreg.c |    1 -
 1 file changed, 1 deletion(-)

diff -- a/drivers/leds/leds-mlxreg.c b/drivers/leds/leds-mlxreg.c
--- a/drivers/leds/leds-mlxreg.c
+++ b/drivers/leds/leds-mlxreg.c
@@ -29,7 +29,6 @@
  * @data: led configuration data;
  * @led_cdev: led class data;
  * @base_color: base led color (other colors have constant offset from base);
- * @led_data: led data;
  * @data_parent: pointer to private device control data of parent;
  * @led_cdev_name: class device name
  */


Return-Path: <linux-kernel+bounces-51880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6017C84905B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92BA01C21B7C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9E1286A2;
	Sun,  4 Feb 2024 20:31:34 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC4325542
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 20:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707078694; cv=none; b=Xcm76J+2JAPOgytQy8qXbdkfXCvGKMvmH7ED91+UixYbRc4DzKZpgfp8Mc0j+GSkINxm6v2xiSni3rTgENdLWzQ+Aaa+R19CCRyJ6Ni2IZljbVKOzWdFXMA6JQ6n1cs+63Dl8wAjY0VDVCkKSaTz9K/nfHTrbiyrJDv97O2N8EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707078694; c=relaxed/simple;
	bh=3Gq/ec25WbFpbYKeDm3qfAdZ9+oAoiWuleAZ6KXpFBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XB572N5AVyRTrZU37pRlhOjSAFJAI3C1Y2x7m5sBxPV57bgAzo/kAZy/EyUIyqg4FaZflabDqr8RKXwobHOaqrQOqwdGh3ib7ZERiDtrW+X9IvJn31mepnDA1jBxdjEJ70VJ744EAbnQMB5mAVpaWXnnUQoSKwYiJnYROfjhnwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-30.elisa-laajakaista.fi [88.113.26.30])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 60a7153a-c39c-11ee-b3cf-005056bd6ce9;
	Sun, 04 Feb 2024 22:31:30 +0200 (EET)
From: andy.shevchenko@gmail.com
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Minjie Du <duminjie@vivo.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 0/2] spi: fsl-dspi: A couple of error handling improvements
Date: Sun,  4 Feb 2024 22:29:17 +0200
Message-ID: <20240204203127.1186621-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of error handling improvements here:
- unshadowing error code from dmaengine_slave_config()
- making error messages uniform

In v2:
- split to two patches (Vladimir)
- improved commit message in the patch 2 (Vladimir)

Andy Shevchenko (2):
  spi: fsl-dspi: Preserve error code returned by
    dmaengine_slave_config()
  spi: fsl-dspi: Unify error messaging in dspi_request_dma()

 drivers/spi/spi-fsl-dspi.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

-- 
2.43.0



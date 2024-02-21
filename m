Return-Path: <linux-kernel+bounces-74155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C427885D08E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01D71C2323B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0112E40C;
	Wed, 21 Feb 2024 06:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fXxIvKfp"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E904C365
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708497667; cv=none; b=RG/G2vrqSys4xdzrPwKH5vDgOTDgR31vgIWMucRHvp9A8f6nt1fG4FLnUaVe5wCtHuqJVuCPhdBOgSL3vY3XDXR8oys8BRv+eLlJ6sOd0ZaxzXtZCPfusNJsEVmJV3LFsqzxUNahjJtFNfEaTi0HR1N6oIr7xd2tnxO+rvoIHrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708497667; c=relaxed/simple;
	bh=BpdPWR7pon5r5ZEdPdiDwdmwrRSn8q/xofPHNbBvSPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RBcg9xgR3ITgSPgFV5+2DRTmxB19/RA8QgIgzBZKItj19qoVL9N+4RPZEuBCe/18l9pLZ6rsfgRpvs/8uBwldw7EcPkwjB7rcfN0iblP2ZW27QOgmFe15+RSu/ASnByIO9/+RnlSxrSG1n3WFys3A4Ud0CW7JbjA9gV0PLBZ720=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fXxIvKfp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=4GBEUR6m/x4kV1WpR6FFfymIX//G8pHWwa4ckAC909E=; b=fXxIvKfpQDJjEEK84TB5PY8Ved
	BuCYyJr6KitX8z6MflRqoPFv9F1N1KoXQrODjxb1Jbz/pl0s6fxDc4oiz3NGVwWHrZW6tjWtKzylz
	NKBpqisr5luUXR8tjQUmOh1Ipd45tYx1pj+UbNkzwbTuyVTRYVokzvYW15IUDWoBsLJfySVMSo5++
	0hXy2G/Z3VK1JVYiC9FUdzhEgfAK795ai8H7YWay0gNwO4rpRjx4pgJAloWy82xWL4vr33ddgP9j/
	YzbTjh7iL4DFnhF0qbAtuEyAqq+5v9nOei7W/TcvjxNPwKx4wcPQc+plGR56mEIVS6kBrtU0HNIiD
	O/AaXuTA==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcgHx-0000000HMS8-1cG9;
	Wed, 21 Feb 2024 06:41:05 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] irqchip: vic: fix a kernel-doc warning
Date: Tue, 20 Feb 2024 22:41:04 -0800
Message-ID: <20240221064104.7863-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop one extraneous struct member to quieten a warning:

drivers/irqchip/irq-vic.c:73: warning: Excess struct member 'parent_irq' description in 'vic_device'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-vic.c |    1 -
 1 file changed, 1 deletion(-)

diff -- a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
--- a/drivers/irqchip/irq-vic.c
+++ b/drivers/irqchip/irq-vic.c
@@ -47,7 +47,6 @@
 
 /**
  * struct vic_device - VIC PM device
- * @parent_irq: The parent IRQ number of the VIC if cascaded, or 0.
  * @irq: The IRQ number for the base of the VIC.
  * @base: The register base for the VIC.
  * @valid_sources: A bitmask of valid interrupts


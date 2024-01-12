Return-Path: <linux-kernel+bounces-24698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FA682C0FF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90986B23C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F646D1AF;
	Fri, 12 Jan 2024 13:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YsYg7Hty"
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DD76D1A3;
	Fri, 12 Jan 2024 13:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=W/DoE
	b9FwSanGKvU8HAUWKBed/QOzlqzNKFOJh+GK88=; b=YsYg7Hty959xJqrhZUNGk
	94fEHSpiBbf1B/1qMnjM5UIEYximpWtik73ijJ5p8tCSC2MaEcNOQHDS+agBtWF8
	wa7S3ZedB1+E0QJKRH33gPbvM89MYpWc85jNT7CzteKDP2zL9vCNeboKyzW8gcll
	OWQQzmtxq3zVdu9lFadoXM=
Received: from localhost.localdomain (unknown [36.4.236.25])
	by zwqz-smtp-mta-g3-0 (Coremail) with SMTP id _____wD3vyUMQaFlmw_AAw--.36249S4;
	Fri, 12 Jan 2024 21:39:56 +0800 (CST)
From: Lizhe <sensor1010@163.com>
To: ilpo.jarvinen@linux.intel.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	u.kleine-koenig@pengutronix.de,
	frank.li@vivo.com,
	tglx@linutronix.de,
	zhang_shurong@foxmail.com,
	robh@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Lizhe <sensor1010@163.com>
Subject: [PATCH v10] serial: linflexuart: Remove redundant uart type assignment
Date: Fri, 12 Jan 2024 05:39:23 -0800
Message-Id: <20240112133923.190852-1-sensor1010@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3vyUMQaFlmw_AAw--.36249S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw4rJF4kGF18Gr4ftw1UWrg_yoW3trb_CF
	nru347ur10kFWakFnrXFWYkrWSgws5ZF48ZF1vq3saq3yqvw4rXry0grZrW39rJ3yUZr97
	ursrWr12yrsrXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNvtCUUUUUU==
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBXhdjq2VOA9DkXgABsC

In linflex_config_port() the member variable type will be
assigned again. Remove redundant uart type assignment from
linflex_probe().

Signed-off-by: Lizhe <sensor1010@163.com>

---

v10:
    Move changelog below --- line.
    Correct commit message.
---
 drivers/tty/serial/fsl_linflexuart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
index 3bdaf1ddc309..c5a04a168c15 100644
--- a/drivers/tty/serial/fsl_linflexuart.c
+++ b/drivers/tty/serial/fsl_linflexuart.c
@@ -837,7 +837,6 @@ static int linflex_probe(struct platform_device *pdev)
 		return ret;
 
 	sport->dev = &pdev->dev;
-	sport->type = PORT_LINFLEXUART;
 	sport->iotype = UPIO_MEM;
 	sport->irq = ret;
 	sport->ops = &linflex_pops;
-- 
2.25.1



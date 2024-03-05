Return-Path: <linux-kernel+bounces-92174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A66871C48
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8DE2B2471C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB6F60267;
	Tue,  5 Mar 2024 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="k94ZMr/X"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3298F55E77
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635485; cv=none; b=hM50DZ90BG+jcmiuQWdc/qVqdhtMq67TvzC8r3+N09IH7meZPFGePrZE3S4R8c0Gm6Aof3DT/LteSvxYeGyhCA8B3ELeH+S3HjrXOobgGa9TyGh04uBw8irWdpAG0Zj9qAYeoVperTd9L07p7z7lxTzsAxxygwTcGT7pincv4+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635485; c=relaxed/simple;
	bh=QeHrKsgsTP2nrj7upJ4BboKEwdaU/NwMM1tn9hOgY5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M4JxHw5tzVYJ0UVFNkOtvXc5taBFiLzim0jVFZC8dq2wKgUiBLHq4gOfoa+/1PLAtizwCrd4/NPnSgY30ckeZlS/FKEoPd0LNQWXT6BwturO9Udy/VPNVwZ5hJMwj9XQzB0Uk4HcIWt3CUg85CRLW5qbIZDJvw0ZxHVlDQ4r4DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=k94ZMr/X; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=kgcjcX6n1YPrYY
	QV0p8f+mPuuBgvuJhzdYh16iDnb6A=; b=k94ZMr/XRFWNL0orq+NEkPMuA8wz7o
	+zr4AFlGnFpMsrWa7oA4Huzgh2ayeBeV88149SiQgRrynirm7cBwabv4ATcLbp5R
	JK3plXuEZyXgs3TLYS3SWXTiUa1rzEGF7jOMlA0cHa1IA9bPD/JKUKaXSot40UVs
	O22+u1K+n3qo9FyTPGdEsha3zCak58CaIBZBRdgZxAetUk3OKqxQ4Xmewf9Zu1wo
	XjYNR5DO5JU4xNZCKzZTTvZCJ0S4CiKT8MneGiuaoFBU/rx9mEYFcdSc2eFa2yX+
	FXcOV69z8zoDkyg76d7bIGauOOgYkWE8Xcw1jrP4R0VuCc1slpVmsDCw==
Received: (qmail 3843203 invoked from network); 5 Mar 2024 11:44:32 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 5 Mar 2024 11:44:32 +0100
X-UD-Smtp-Session: l3s3148p1@OPH+hucS0sggAwDPXyskAOYD60938Lkb
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	stable@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Chris Ball <cjb@laptop.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mmc: tmio: avoid concurrent runs of mmc_request_done()
Date: Tue,  5 Mar 2024 11:42:56 +0100
Message-ID: <20240305104423.3177-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the to-be-fixed commit, the reset_work handler cleared 'host->mrq'
outside of the spinlock protected critical section. That leaves a small
race window during execution of 'tmio_mmc_reset()' where the done_work
handler could grab a pointer to the now invalid 'host->mrq'. Both would
use it to call mmc_request_done() causing problems (see link below).

However, 'host->mrq' cannot simply be cleared earlier inside the
critical section. That would allow new mrqs to come in asynchronously
while the actual reset of the controller still needs to be done. So,
like 'tmio_mmc_set_ios()', an ERR_PTR is used to prevent new mrqs from
coming in but still avoiding concurrency between work handlers.

Reported-by: Dirk Behme <dirk.behme@de.bosch.com>
Closes: https://lore.kernel.org/all/20240220061356.3001761-1-dirk.behme@de.bosch.com/
Fixes: df3ef2d3c92c ("mmc: protect the tmio_mmc driver against a theoretical race")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
Reviewed-by: Dirk Behme <dirk.behme@de.bosch.com>
Cc: stable@vger.kernel.org # 3.0+
---

Change since v1/RFT: added Dirk's tags and stable tag

@Ulf: this is nasty, subtle stuff. Would be awesome to have it in 6.8
already!

 drivers/mmc/host/tmio_mmc_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index be7f18fd4836..c253d176db69 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -259,6 +259,8 @@ static void tmio_mmc_reset_work(struct work_struct *work)
 	else
 		mrq->cmd->error = -ETIMEDOUT;
 
+	/* No new calls yet, but disallow concurrent tmio_mmc_done_work() */
+	host->mrq = ERR_PTR(-EBUSY);
 	host->cmd = NULL;
 	host->data = NULL;
 
-- 
2.43.0



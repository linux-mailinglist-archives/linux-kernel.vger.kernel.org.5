Return-Path: <linux-kernel+bounces-140479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 631848A1539
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0C58B25111
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6832E149C7F;
	Thu, 11 Apr 2024 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="mKUFNUk9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="gvZESPUs"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611FD38DD2;
	Thu, 11 Apr 2024 13:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712840707; cv=none; b=RI5f6s94dFhASVmNLWA8Oes7AwaMvgAI1+3PnRPf5et164iI3ewZLXKEl+zh/WUzMyPVnCPPc0ZyagkStGNrH/9boelvxJOeUT58pqtc5h1shdYy66+VlqdDI4rqTdEJHh8IFaZqvQSxy/m8jewkddBdEYrCLcsrzv4xd6DKgHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712840707; c=relaxed/simple;
	bh=ZrO8njZB9AZNmPKmPyEZoaoX8nSebxgDBxikZ6b+YEI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o/m9ZyWiU0qn2UPtCswr6vH18Wg2WK63ABi68nD9WsIM7mnXYJ4Q1b9lpZU03iq4+SwqpmFXVkxNBT45r/H76BBL8mw6IotcqTMCS9o788fq1E2NVJvhVfAQZWeBbdrsbFZC03LmOMxMj50Vs/Fuxfokv24NAq9MuJymO3T1FwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=mKUFNUk9; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=gvZESPUs reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1712840703; x=1744376703;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GwardD7WuS5Bsy9JLAG1ZGah+5S9uvjwccp3uchevzs=;
  b=mKUFNUk98Vssm+X+B4ZJppFVcWp7A15UcJDYgajIflR+uQ9WGs0G91uX
   i+4/RflDdEY1p33+pX1/AOYn5o5PPhPHtQwtrM0vhRm79oMXrGgCKymvK
   BT0xm6Sep5c8deUHlwiWDW76wyC9gETJR0uYTrqMCZrj1v9/Oqk9u9Hjo
   6iBGVOc/3V0V0XrECcZNV//3QTWV1sfpGT5eLmzg4pABQbi2bQHyLCYzO
   PB2eAIHyCcg8haQs3MiaROJYZMVN7hAeiWlVjHiyL41PehdTNOxrdBRSu
   TkfylpuvKdnBxIhOFs7wfDUHc4dqg4PlaK7zeqS59H7q+XvXhuNk2tz9n
   w==;
X-IronPort-AV: E=Sophos;i="6.07,193,1708383600"; 
   d="scan'208";a="36370095"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 11 Apr 2024 15:05:00 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8A18F17145F;
	Thu, 11 Apr 2024 15:04:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1712840696; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=GwardD7WuS5Bsy9JLAG1ZGah+5S9uvjwccp3uchevzs=;
	b=gvZESPUsNKGOKDS/H6LMn3yjy9VCKVgOt1H3UvJhsdJqn3pNBPnFnwkSCImsih63N2AIp3
	bZHpBBazcq/CNmofIenPiKwLydl11Eotf/a7pj+W7DvM+L6pE18dWsUkLk0IRR4ABwqPEl
	YQd5aJiPT1GyoQ3jobVyFPajcU0mT1Thl7FoozvfjeNKdDoWJovhGu922Dldyr3CoQhBTa
	UktybazpioB05tjb9vjyjOBBEVWY7pJhD6ML+oWDJsUmPTm2OMeB0Il8db4GDpZo4NncoK
	ZkjYHNHMx09gK3BCD/pTzm+MgXT8+eaRwrNrk36jwrAX5VlILlEDnSTEST352g==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 1/1] tty: serial: fsl_lpuart: use dev_err_probe for clocks
Date: Thu, 11 Apr 2024 15:04:48 +0200
Message-Id: <20240411130449.1096090-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Clocks might not be available yet when probing lpuart. Silence -517 errors
by using dev_err_probe.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/tty/serial/fsl_lpuart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index bbcbc91482af0..d0977124632e5 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2884,8 +2884,7 @@ static int lpuart_probe(struct platform_device *pdev)
 	sport->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(sport->ipg_clk)) {
 		ret = PTR_ERR(sport->ipg_clk);
-		dev_err(&pdev->dev, "failed to get uart ipg clk: %d\n", ret);
-		return ret;
+		return dev_err_probe(&pdev->dev, ret, "failed to get uart ipg clk\n");
 	}
 
 	sport->baud_clk = NULL;
@@ -2893,8 +2892,7 @@ static int lpuart_probe(struct platform_device *pdev)
 		sport->baud_clk = devm_clk_get(&pdev->dev, "baud");
 		if (IS_ERR(sport->baud_clk)) {
 			ret = PTR_ERR(sport->baud_clk);
-			dev_err(&pdev->dev, "failed to get uart baud clk: %d\n", ret);
-			return ret;
+			return dev_err_probe(&pdev->dev, ret, "failed to get uart baud clk\n");
 		}
 	}
 
-- 
2.34.1



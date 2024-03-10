Return-Path: <linux-kernel+bounces-98151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C89168775BE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 09:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B481F21D22
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 08:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E201DA3A;
	Sun, 10 Mar 2024 08:06:29 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CD4179BF
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 08:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710057988; cv=none; b=Tz53Abf+z4OATv1tP/+vTU6oK8FdzKLSOXY0TxocJIdxbQbFLqP7rUJSskbuTBDQzBWlBk05XgGj3txlBpHc9auOHThMHkVc7NDXQAZt+yiNb+LLyMCbrp8WbvjN3AFcoAOTd5ZX0i/vl7JC4EARl5jmD3DfvBCoyWBg0rGVZDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710057988; c=relaxed/simple;
	bh=6oRLyYOr0K8Fr6EOJdxUdCudAZbuqk+EFlXQ5Gmzn7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pYD0ip2SnLjTEr2CnfLP5PpJwOCJRTYoui8qeTUBoDXLg6IXsMRnq3tMD9S8RE/dSZMvwhaQ2wg1Egn7okSlav5PiTQemMhm2n+b6NCPWe47zIj5sWU9UbNHgSQOryzayle7JrD/D4xEd2QlqafCkher8Qbe2SjA/gzo11g7iXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjECC-00073P-Vx; Sun, 10 Mar 2024 09:06:13 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjECB-005Txq-Pp; Sun, 10 Mar 2024 09:06:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjECB-003KQr-2H;
	Sun, 10 Mar 2024 09:06:11 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: William Breathitt Gray <william.gray@linaro.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	Julien Panis <jpanis@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	David Lechner <david@lechnology.com>
Subject: [PATCH 0/2] counter: Convert to platform remove callback returning void
Date: Sun, 10 Mar 2024 09:06:05 +0100
Message-ID: <cover.1710057753.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=898; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=6oRLyYOr0K8Fr6EOJdxUdCudAZbuqk+EFlXQ5Gmzn7s=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl7Wnup/dsCC3NnmEbHrjLyg2n4oZbjkZkeMS8R 8UFshIAuieJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZe1p7gAKCRCPgPtYfRL+ TtWrCACg60zMWv6NCg+YdADaWbrO42BDBpBcW/+q2pCUPsBBQAeWEtF+LrRoh+4kYQihD3NlRUk znayd/IDcVovSoJ/X7GS2Fj98lu6Hohkci9ufcomkbEIHHK0w5PHl5qbkPOEP00nllU31idQ6/p jeq3/IFhaSo/s21Bh4x4e9SW+k8lx3SqDY1nVWHKUiQb7gEMa2i0Qpp4wuXTfLn84syuJDA2U2b tPbX1BSID7mBmJFHfhXkPPwyBG8B+ypcMR0nkPlYaLWjBvUT9rYX1Fr2ULW4tgZNPw0zyN5pqZs L9gjCwiGYBFvc4D0UDBvedy9B29Spj81BdfrFsZO95DxwGtH
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello,

this series converts all platform drivers below drivers/counter to stop
using struct platform_driver::remove(). See commit 5c5a7680e67b
("platform: Provide a remove callback that returns no value") for an
extended explanation and the eventual goal.

Both conversations are trivial, because the driver's .remove() callbacks
returned zero unconditionally.

There are no interdependencies between these patches, still I'd expect
them to be picked up together.

Best regards
Uwe

Uwe Kleine-König (2):
  counter: ti-ecap-capture: Convert to platform remove callback
    returning void
  counter: ti-eqep: Convert to platform remove callback returning void

 drivers/counter/ti-ecap-capture.c | 6 ++----
 drivers/counter/ti-eqep.c         | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
-- 
2.43.0



Return-Path: <linux-kernel+bounces-2784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 656918161C9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 20:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70CE5B21AF2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 19:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A267481D0;
	Sun, 17 Dec 2023 19:31:59 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E34481AD
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEwrg-0007Gd-RU; Sun, 17 Dec 2023 20:31:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEwrg-00GXTh-2n; Sun, 17 Dec 2023 20:31:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEwrf-004ow1-Pa; Sun, 17 Dec 2023 20:31:51 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Santosh Shilimkar <ssantosh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: kernel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] memory: emif: ifdefs and platform_driver_probe()
Date: Sun, 17 Dec 2023 20:31:30 +0100
Message-ID: <cover.1702829744.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=943; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=zVJugfeOTymRnAnugpVWTjoIeVkVRWBo0ysEr89178Y=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlf0ySpS4VMK9/vx8l5wy5vJnnVRaF1uwwstsiy 9qDliC4GlOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZX9MkgAKCRCPgPtYfRL+ TkoIB/9fVFn9BQkvfEmo89Eo5CqUNwWRlpXwwv1ln1FYgiDGy+RqzJ0aQ+3TMsYSyDo4xtLhpd+ Qt24Gl6FryPQHvCzHeNYuYcnYQFEWibFnRNBnCIJnx38Te3WcgJTLWcxxNqJuF5fO8ZmbqCIfDR Q8suGxeOzFLmFFaAov7Dwkz44K3IO2szqcw1EDDMc9dpW3XRE+taTUAm7v0QYilxBtWONSpjk0E IOYam2JDtZWbHeLOHzRumNNWqahgEATFnySRBM2bvgkOpcXdefDmYOVzSU4kK749iiYkrlGDR1d kIdaw2wsnsPD100ZdIVNNnVblWekeFsNckvpnfLxZEbzAdI2
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello,

while preparing the series to convert the platform drivers below
drivers/memory to use .remove_new()[1], I noticed that the emif driver
unnecessarily uses some #ifdefs and doesn't use platform_driver_probe()
correctly. Note there is a conflict between these series. Tell me if you
need support to resolve this.

The alternative to the third patch is to do s/__init_or_module/__init/
in the driver and mark emif_driver with __refdata.

Best regards
Uwe

[1] https://lore.kernel.org/r/cover.1702822744.git.u.kleine-koenig@pengutronix.de 

Uwe Kleine-König (3):
  memory: emif: Simplify code handling CONFIG_DEBUG_FS
  memory: emif: Simplify code handling CONFIG_OF
  memory: emif: Drop usage of platform_driver_probe()

 drivers/memory/emif.c | 63 ++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 40 deletions(-)

base-commit: 17cb8a20bde66a520a2ca7aad1063e1ce7382240
-- 
2.42.0


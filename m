Return-Path: <linux-kernel+bounces-11140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E6C81E1F3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 19:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE091F22118
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 18:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE18537F1;
	Mon, 25 Dec 2023 18:13:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF4552F9D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 18:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rHpS2-00024X-Ur; Mon, 25 Dec 2023 19:13:18 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rHpS0-001TaR-FZ; Mon, 25 Dec 2023 19:13:17 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rHpS1-000xT3-1Y;
	Mon, 25 Dec 2023 19:13:17 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v2 0/2] bus: ts-nbus: Two improvements
Date: Mon, 25 Dec 2023 19:12:51 +0100
Message-ID: <cover.1703527372.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=877; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=GKUcOP/MEJuW+ygYID099n67/wpGy01LrNnILk5OHHg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlicYkFrKKQC+okclehmgTI7D8FT36FA4Ue7cRI u8MQuFaY4iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYnGJAAKCRCPgPtYfRL+ Tjs4B/4hATb24ZRp0K4pmW9LFEVuf1ftgWlnEnx865J8aWOXqEvoVp+XlUrQxefOe+vx5Aa1ov8 fFFk4f6iShyIqcx6it9tp8son0aB4ePrO1pdGvrAG+vGG40hobNMXAnoNDYh7f1QnL8/EbZiH8Q FM5u8/24IWYy0GXFhU++7/LfPgH2dgOso6lJBl3cqffAUEWfe+gkXe23baMhCfl8zbbHhlMG4LL bNmv4G0D1ouRf96QKlRK9hi5wOJwfTtgUK/nOsRouKVrHPJUNJrWRF8QWc4qY0VlIpnnE04inEZ XFEvq4ZWAFHc9fXM2jCtB4qx99CPULilxpNxfGZx1ZpXq8jT
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello Arnd,

the last changes for drivers/bus/ts-nbus.c went in via arm-soc. Would
you pick up these two, too? Tell me if a PR would simplify things for
you. I'd base it on top of fc540426f7baa0c7d4b477e80435d075659092a2
then.

Changes since (implicit) v1 of this series
(https://lore.kernel.org/linux-kernel/cover.1702160838.git.u.kleine-koenig@pengutronix.de):

 - Add a closing parenthesis to the commit log of patch 1 (xkcd#859)
 - Fix return value in one error path of patch 2, noticed by Christophe
   JAILLET)
 - (trivially) rebased to current next

Uwe Kleine-König (2):
  bus: ts-nbus: Convert to atomic pwm API
  bus: ts-nbus: Improve error reporting

 drivers/bus/ts-nbus.c | 81 ++++++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 47 deletions(-)

base-commit: 39676dfe52331dba909c617f213fdb21015c8d10
-- 
2.43.0



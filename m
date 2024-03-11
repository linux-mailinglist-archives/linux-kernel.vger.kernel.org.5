Return-Path: <linux-kernel+bounces-99586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BFD878A5E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EB661C214E2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7742757301;
	Mon, 11 Mar 2024 21:59:49 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4F956B98
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710194389; cv=none; b=teS9+ng54Y72idrdFt7c9vRyt2IZ5tHix5j27NBWGD12qCd1uNJuKvpwsJS3emeegOqC3QfARX6juKklhUbcZVK/b7ghouysKh3pyfuznbJT5HUaGBbSgu9ndBPaitN4m4JfkB1egNVO0IghEJw2SrBUVqwh8+FAnJi7IKny4lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710194389; c=relaxed/simple;
	bh=AXf6Wp22U3dAExAAqsENzbJz5haG5wXlyCTZYj7tEcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dj1ApSSetRXQJ5U4xNJSAFGjsAd5OQSe7cxB6ZclLYcZgfsuuh2YvC8aUvC94MIEcDGL6jlATvoyEoqJVVCU1ISXGwM7tEMJynxrgGrF7vgyI+X5JJujjCuM94BOpT9bvxCPtwhflL5AXpHcKRvQBMdbWAvUkf+hR+QnrCaJ0wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjngP-0006Ce-G1; Mon, 11 Mar 2024 22:59:45 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjngO-005nEv-TI; Mon, 11 Mar 2024 22:59:44 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjngO-004JCA-2e;
	Mon, 11 Mar 2024 22:59:44 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andy Shevchenko <andy@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	Paul Burton <paulburton@kernel.org>
Subject: [PATCH 0/3] auxdisplay: Convert to platform remove callback returning void
Date: Mon, 11 Mar 2024 22:59:21 +0100
Message-ID: <cover.1710194084.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1074; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=AXf6Wp22U3dAExAAqsENzbJz5haG5wXlyCTZYj7tEcg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl7366bmOfeXwRbOzT8v5/BgTLT9+Tqh6v4hWPj eqi2JDGkzGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZe9+ugAKCRCPgPtYfRL+ Trp8B/4654GH5S1ljtEvGGpxOxe3hxs+hBrz+VdZ+oacxzBg0GAE4vq/ljYUtl7r/NSEWwH0aaq 1ZL1YGfksfx/pw9i2Tbp1VvoZabCZ4Qby3c0cMSeHpfX762/iTWOvF1s9N+ybBZSfo0o7VVKAAE eCQjnsIciMVSGOtA8P8zJo926SA1ADX9kIUeX44kL+p1spyNP2tu50YCgDVc1CYW81W/R9kw+EB 1dbSNTN/5+7IEmkg6YPigxNdOav3svI1Z5+ofRDErD2eNiNnaj4nphDbTuuiZTW3dbMQlq2WZF7 9LUGLnrYSpF/irOpEGigRLmnBu7rF+Wuz6DgBD9l5zWtD7PF
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello,

this series converts all platform drivers below drivers/auxdisplay to
stop using struct platform_driver::remove(). See commit 5c5a7680e67b
("platform: Provide a remove callback that returns no value") for an
extended explanation and the eventual goal.

All conversations are trivial, because the driver's .remove() callbacks
returned zero unconditionally.

There are no interdependencies between these patches, still I'd expect
them to be picked up together. This is merge window material.

Best regards
Uwe

Uwe Kleine-König (3):
  auxdisplay: cfag12864bfb: Convert to platform remove callback
    returning void
  auxdisplay: hd44780: Convert to platform remove callback returning
    void
  auxdisplay: img-ascii-lcd: Convert to platform remove callback
    returning void

 drivers/auxdisplay/cfag12864bfb.c  | 6 ++----
 drivers/auxdisplay/hd44780.c       | 5 ++---
 drivers/auxdisplay/img-ascii-lcd.c | 5 ++---
 3 files changed, 6 insertions(+), 10 deletions(-)

base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
-- 
2.43.0



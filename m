Return-Path: <linux-kernel+bounces-71161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F414985A180
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94DACB20FE9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC62428E1B;
	Mon, 19 Feb 2024 10:59:41 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88F728DC8
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708340381; cv=none; b=BSa7brWduUdoUCaFoXcwlXhXkOAeMuq7qk9T/RKDSzOkRMBqx96PaZMBicl1dF1l43fcaa+evWKlx99wbMrUmb2YgS9+oxVmHjTf9+itu8AJ/j/FI4hOrhtN/NDTsOO4wczwxvRHWfC3/e3a3qgH+jdmfuYx7vdGE4QPQkref/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708340381; c=relaxed/simple;
	bh=b6TSCmY4KOm1qPceMF1H7RCDkgfn20Lg56yP87WJe28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QiyTnwfG5n0ssGq0a8KUe/mCqakiCWp94XXOMiiphAH6MCx6rRAeOoTtAF+GFy9MQ8b9jb1vkKpzHvJ9hjUd3qzCRfZY1QLpioun01l5uhzi8LDU0kbdjEPCYmetWSxf84U5lAYTu/x8FQ+/hnove6DzU3HOL/W6Mqx9JOlBzbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rc1N2-0007sz-61; Mon, 19 Feb 2024 11:59:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rc1N1-001dB4-JJ; Mon, 19 Feb 2024 11:59:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rc1N1-007llt-1f;
	Mon, 19 Feb 2024 11:59:35 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: kernel@pengutronix.de,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 0/4] w1: Convert to platform remove callback returning void
Date: Mon, 19 Feb 2024 11:59:26 +0100
Message-ID: <cover.1708340114.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1120; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=b6TSCmY4KOm1qPceMF1H7RCDkgfn20Lg56yP87WJe28=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl0zSOMXux9g+DWSz8p7ilT/bnPfQuNyOZhLzIO l7OLIOa3E+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdM0jgAKCRCPgPtYfRL+ TtlDCACU0eUv1HJRTvM1qy2qiJKAALbflR/xpJcOWlY+SpuU/9o4vW4BhXAvmQvyhCZDuQTwOV1 vDWmucXWlpxhlxsAv4oI7TXyu52CEkbWkh93OinH2d1Iu5169mXcqO2+0UJOisg8vPjyg/WEOpL TBYzEnJh7PrDeMOfYggUNGJpKb6PsNv1bmX4uytn9S4OYc8M4febGj7Mk2xSfgiv7C5jy0V38pq fznGn+9T7jomEdRvRsDyZEYlDUnqpsumclaUn+rPYzr91o63kS7+MUnJ4GXnjgA204rQEvzXZub rVChIwazf5H0BD59DhKxG/tKglUsKsmdVDJ2YQuxDqxfjUyy
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello,

this series converts all drivers below drivers/w1 to struct
platform_driver::remove_new(). See commit 5c5a7680e67b ("platform:
Provide a remove callback that returns no value") for an extended
explanation and the eventual goal.

All four conversations are trivial, because their .remove() callbacks
returned zero unconditionally. 

There are no interdependencies between these patches, so they could be
picked up individually. However I'd expect them to go in all together
via Krzysztof's tree.

Thanks
Uwe

Uwe Kleine-König (4):
  w1: mxc_w1: Convert to platform remove callback returning void
  w1: omap_hdq: Convert to platform remove callback returning void
  w1: sgi_w1: Convert to platform remove callback returning void
  w1: w1-gpio: Convert to platform remove callback returning void

 drivers/w1/masters/mxc_w1.c   | 6 ++----
 drivers/w1/masters/omap_hdq.c | 6 ++----
 drivers/w1/masters/sgi_w1.c   | 6 ++----
 drivers/w1/masters/w1-gpio.c  | 6 ++----
 4 files changed, 8 insertions(+), 16 deletions(-)

base-commit: 35a4fdde2466b9d90af297f249436a270ef9d30e
-- 
2.43.0



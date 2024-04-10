Return-Path: <linux-kernel+bounces-138662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6661289F941
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54F8AB27B99
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE270181309;
	Wed, 10 Apr 2024 13:41:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9F2180A69
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756485; cv=none; b=Exzf30JhYWnUOiHO/fJovRpERZbu5F3XTDUfYgLt024y+14s6tLYxeQh/P9UzwSi5k5Aq0hQ7XxFDs5/wfBQkjfrRE4Wf28jsN6rcEc3ZAXW5Y1fBf4xE/jdnX+JllZKmiZ4RoCQsCjjCss8BnGoPrqKK5aFJxA+LdT2sbfr0eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756485; c=relaxed/simple;
	bh=/hnmB2uN6mPShM5rRzYJFYniz17di1xl7Dd/Cl6n3ko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q+aK5rOnJhRzLQDvpjWE9hIvVkaqNAiE9I2nQfnj/GpmJL3wWTKVv8ahWqyKeS1FKgyT2tnXLI6QN1xwFw4J6nyoJMpaQx9I/UTdvlF9cCAqCgKLwmfkq3tFJdvobuPllJZQeJZGi4Lm7qPIBphYI914apLbXWX7g6WYXBQeJfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruYCT-0003pl-Hk; Wed, 10 Apr 2024 15:41:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruYCS-00BVN3-MP; Wed, 10 Apr 2024 15:41:16 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruYCS-00HaVg-1w;
	Wed, 10 Apr 2024 15:41:16 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sebastian Reichel <sre@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	Osama Muhammad <osmtendev@gmail.com>
Subject: [PATCH 0/2] HSI: Convert to platform remove callback returning void
Date: Wed, 10 Apr 2024 15:41:09 +0200
Message-ID: <cover.1712756364.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=938; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=/hnmB2uN6mPShM5rRzYJFYniz17di1xl7Dd/Cl6n3ko=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmFpb2x5JfA9sZSMTffKMLV0t6JPtrDtdseWrLX GGW5s6plhCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhaW9gAKCRCPgPtYfRL+ TncTB/4+kQQOFC7X0h8K++nGW4ld9vNL9WLycKWaKUvjmKfP8C9QxutZklcA+XA57lJyAeVjpdq Mut0sErNsFCHSZSjuDVBqEuWa3zT7cK+R5klovRBNq90IO0dDlIyIl4tIzW390jMVCDuJ1kDMCD 6XfvESiVYVDy4DvfHKTuYp5XONIct33jodB6OVpsKL2rDqKhGoVgIUOJcrMoNAdT6WQKKogdA2M mCJ9iQGQXKJldDhyFbeuBfig+JPWFEGn42Gn65CluaT/hhxf5kjzv5pSwHLHiYEIk7mD92ad9sj W9gRTn5HwZFDJQh6II9t6k2RYOSghm7DFnqJkhkkWoQrG4pj
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello,

this series converts all platform drivers below drivers/hsi/ to not use
struct platform_device::remove() any more. See commit 5c5a7680e67b
("platform: Provide a remove callback that returns no value") for an
extended explanation and the eventual goal.

All conversations are trivial, because the driver's .remove() callbacks
returned zero unconditionally.

There are no interdependencies between these patches, so they can be
applied independently if needed. This is merge window material.

Best regards
Uwe


Uwe Kleine-König (2):
  HSI: omap_ssi_core: Convert to platform remove callback returning void
  HSI: omap_ssi_port: Convert to platform remove callback returning void

 drivers/hsi/controllers/omap_ssi_core.c | 6 ++----
 drivers/hsi/controllers/omap_ssi_port.c | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)


base-commit: 6ebf211bb11dfc004a2ff73a9de5386fa309c430
-- 
2.43.0



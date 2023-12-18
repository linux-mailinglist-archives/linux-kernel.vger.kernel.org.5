Return-Path: <linux-kernel+bounces-4386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 513A3817C5D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC3A8B23650
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F241B7348F;
	Mon, 18 Dec 2023 21:05:34 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0310A2D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFKnr-0002lP-0x; Mon, 18 Dec 2023 22:05:31 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFKnq-00GmWx-AZ; Mon, 18 Dec 2023 22:05:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFKnq-005Y6C-1Q; Mon, 18 Dec 2023 22:05:30 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: kernel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] parport: Convert to platform remove callback returning void
Date: Mon, 18 Dec 2023 22:05:17 +0100
Message-ID: <cover.1702933181.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=841; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=NqpmQLSPHcC2yz+6ePrX/QuLgXrvJdL3SxGAU6DN9XA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlgLQMgC/Iq/GHBw6WgR8xnEPtf4JApJhnSdHXY xcvmGvMAzWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYC0DAAKCRCPgPtYfRL+ Tvo1CACrvkfCfOPMM65fgJySkgUA0rfOMRoQSKHHlbsWuan5wr1rx+EA++5Sd0Mv7A7zrCJl2/8 SpJd9dUC4EV1ERTJNqBFfb9WfUuYRxoO8tTnjxmlw5m5CNxvcyP/hpHzfF18ut9RM8yrepmF7Hf NHgcV1uuK/iyMj+Ea2sNkOFwbT+Qmz+tMqMcZy6WXrr/Lwsv2MKAnLi2TlrN3DVflZ6D50vgB+/ DcuN13ggn4dhem3d9qLLRX3xAxLrO6XCPEXklUq7/hLZ2otgHbo1f5eUXBXlMYcG/aNCMIkFoqd BcAhmB8E75QQUF6ry3LS66OrOlPgOAfjvtTzsyNixJWZpQdY
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello,

this series converts all drivers below drivers/parport to use
.remove_new(). See commit 5c5a7680e67b ("platform: Provide a remove
callback that returns no value") for an extended explanation and the
eventual goal. The TL;DR; is to make it harder for driver authors to
leak resources without noticing.

This is merge window material. The two patches are independent of each
other, so they could be applied individually.

Best regards
Uwe

Uwe Kleine-König (2):
  parport: amiga: Convert to platform remove callback returning void
  parport: sunbpp: Convert to platform remove callback returning void

 drivers/parport/parport_amiga.c  | 5 ++---
 drivers/parport/parport_sunbpp.c | 6 ++----
 2 files changed, 4 insertions(+), 7 deletions(-)


base-commit: ceb2fe0d438644e1de06b9a6468a1fb8e2199c70
-- 
2.42.0



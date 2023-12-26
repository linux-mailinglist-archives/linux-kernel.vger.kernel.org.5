Return-Path: <linux-kernel+bounces-11521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C91F81E79D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 14:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A751F2248F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 13:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35C54F5E6;
	Tue, 26 Dec 2023 13:28:32 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729904F21A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rI7Td-0006yA-Ok; Tue, 26 Dec 2023 14:28:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rI7Tb-001ePn-6K; Tue, 26 Dec 2023 14:28:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rI7Tc-001FX6-0c;
	Tue, 26 Dec 2023 14:28:08 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Dov Murik <dovmurik@linux.ibm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>
Cc: kernel@pengutronix.de,
	Gerd Hoffmann <kraxel@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] virt: Convert to platform remove callback returning void
Date: Tue, 26 Dec 2023 14:28:01 +0100
Message-ID: <cover.1703596577.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1113; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=I/rhHgWCaWJ+BH2OuSz7nNFM0gwtPxZ9++znIJn0D5g=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlitThZ+fdNR8+LdCIYJrTv4aSxdn6CtUXNi9zt iJdN68/YsWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYrU4QAKCRCPgPtYfRL+ TlqFCAC6Q/aG49sJByhYeif65RvGgcjnzA3Sh0BaHSOGAIKSVPAXHUmUbS8137UA1J+sPGKgMP1 Gdl54wOC5CNlzQXUf7YwV+KDipRAyyWNfk/JiHsqRntaqwwvTzQ/C1jocbff5qXnrixiUU3Pzxy gVQus2BHlW334mIki0L3EraWVU6ND48r2U2sXpvBUHYxpRFzeiDIx8IvvR7RNueDOUmFNAI49lc oPB89MG/uyZoteY6QqXotP+J886ll7YkwPG05h6QjZL8TfAyUxx7/pNL6fawNeRVCAQMdeGjrGI THJEi44V5hQ4gw0YvyPymcrGE+F4a+nzE2E9uU37A2v/1e1n
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello,

this series converts the two platform drivers below drivers/virt that
make use of .remove() to use .remove_new() instead.

See commit 5c5a7680e67b ("platform: Provide a remove callback that
returns no value") for an extended explanation and the eventual goal.
The TL;DR; is to make it harder for driver authors to leak resources
without noticing. The drivers here get it right though and so can be
converted trivially.

This is merge window material. There doesn't seem to be a maintainer for
all of drivers/virt and I don't know how patch application works there
usally. The two patches are independent of each other so they can be
applied individually if necessary.

Best regards
Uwe

Uwe Kleine-König (2):
  virt: efi_secret: Convert to platform remove callback returning void
  virt: sev-guest: Convert to platform remove callback returning void

 drivers/virt/coco/efi_secret/efi_secret.c | 5 ++---
 drivers/virt/coco/sev-guest/sev-guest.c   | 6 ++----
 2 files changed, 4 insertions(+), 7 deletions(-)

base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.43.0



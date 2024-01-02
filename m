Return-Path: <linux-kernel+bounces-14706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6796F8220F1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AE351F21C60
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7900F156F4;
	Tue,  2 Jan 2024 18:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZMtYEv1X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MxrJq0CO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FF115AD8;
	Tue,  2 Jan 2024 18:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Jan 2024 18:21:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704219713;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SK5ZmdPni3oiwsprKqAA8w0COgY7F015Nt8bwwcDuKI=;
	b=ZMtYEv1XmaV6l2LbJ88534WVYNKrmqnFdCAsHrHMHMHXh7oMLf1V2KQUX18+MaxlDt+NL7
	I90yUfTKmuhl6BGIWMinTvscxBS1LSqkO3ulY8xQg0x6NfEwxg9ek5KXpFHcl9wkqvUGO7
	0FTWrlUs3lknr9dOIMapcTH0VBkoNZXbnEM/jqL94uR5faqL4EsEj6RUrxRfaguxgl++vj
	zMVT2R75gW/tU2lQhnqm54ozYTX3A0dxFSDAhWTkzFvJVNzRbSqg4eLFEK+4hr6xdyjHPM
	DFXHCGCDqHkYhxfXiksjyxjTBzsEtEHgJsypLB2vYjmdno2vnOlD57+XKovSyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704219713;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SK5ZmdPni3oiwsprKqAA8w0COgY7F015Nt8bwwcDuKI=;
	b=MxrJq0CO375g2Mw6LOtD0lJMj6RnoTPBqKIz2IyOzkSd3DAo6I/08nakRbnGSTqKHwyoRE
	xeSshJg8Co+MABCg==
From:
 tip-bot2 for Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] virt: sev-guest: Convert to platform remove callback
 returning void
Cc: u.kleine-koenig@pengutronix.de, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C52826a50250304ab0af14c594009f7b901c2cd31=2E17035?=
 =?utf-8?q?96577=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
References: =?utf-8?q?=3C52826a50250304ab0af14c594009f7b901c2cd31=2E170359?=
 =?utf-8?q?6577=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170421971260.398.3650838941459484381.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     d642ef7111014805f2e21e9cddb0c0a93ae1313d
Gitweb:        https://git.kernel.org/tip/d642ef7111014805f2e21e9cddb0c0a93ae=
1313d
Author:        Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
AuthorDate:    Tue, 26 Dec 2023 14:28:03 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 02 Jan 2024 19:07:18 +01:00

virt: sev-guest: Convert to platform remove callback returning void

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/52826a50250304ab0af14c594009f7b901c2cd31.1703=
596577.git.u.kleine-koenig@pengutronix.de
---
 drivers/virt/coco/sev-guest/sev-guest.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-=
guest/sev-guest.c
index bc564ad..87f2418 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -994,7 +994,7 @@ e_unmap:
 	return ret;
 }
=20
-static int __exit sev_guest_remove(struct platform_device *pdev)
+static void __exit sev_guest_remove(struct platform_device *pdev)
 {
 	struct snp_guest_dev *snp_dev =3D platform_get_drvdata(pdev);
=20
@@ -1003,8 +1003,6 @@ static int __exit sev_guest_remove(struct platform_devi=
ce *pdev)
 	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
 	deinit_crypto(snp_dev->crypto);
 	misc_deregister(&snp_dev->misc);
-
-	return 0;
 }
=20
 /*
@@ -1013,7 +1011,7 @@ static int __exit sev_guest_remove(struct platform_devi=
ce *pdev)
  * with the SEV-SNP support, it is named "sev-guest".
  */
 static struct platform_driver sev_guest_driver =3D {
-	.remove		=3D __exit_p(sev_guest_remove),
+	.remove_new	=3D __exit_p(sev_guest_remove),
 	.driver		=3D {
 		.name =3D "sev-guest",
 	},


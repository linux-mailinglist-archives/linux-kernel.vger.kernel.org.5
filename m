Return-Path: <linux-kernel+bounces-63335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 883A4852DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D08B1F24FC3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4DF24A00;
	Tue, 13 Feb 2024 10:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P0urb2D/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5fVkOcMI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30445249EA;
	Tue, 13 Feb 2024 10:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819725; cv=none; b=BQVrjmdRAvNV2XAVPkDd9CM40ywwrKzFieJAqGbtP8UorXV0oi8EY463V58Tvo5aQ8PZygbIcDFC3rIJtoCHbMTwEwPrQzBCj+Tl8qzPrWSzQ3Rr0U1ddCWQ67wLDkXWP1atq5lAIQlLDM4/H1VRCyzZ6KapvsELV6Or0QWAb5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819725; c=relaxed/simple;
	bh=a4cX1/yXXqKHNynGrhr84BbP0evBMA9gDVvVaBwwXE0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fEQi+r8t9e9iO4uWzMIEtAJuZvPFjUfN0aIa4/cnoaICm62J30mvJ3ueBJGU0oePmUwfcCluomY+9iBC6NYi9TpsG8rp6XRMuvXTwTGh+3h//6jt2Y/Efm8Eh9QRmG1FYdq1vWRVnap5tHz3L7MOITPI+F3nzaeyJFT6RpKu6mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P0urb2D/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5fVkOcMI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Feb 2024 10:22:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707819722;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jV1AlrzTVRtepO7sOkkDJ2Dl7gJbt/dfPd7N7+cYnF4=;
	b=P0urb2D/THptf95SfkHC7YA6mjalpkuvzvAcOr97rL3BaZ9ehfZqMCbXhfm3LawAcD9mPG
	q3ltTmGP+h6W+G5bOfo94L1IQ5JBDU3dxe9mmkcEQI8dxB+cORZb2h1JonBfAYL6ksgchc
	pZmNToeTguW1Caz7tD0OPT2g4PbVAe2o8XlMzRciAYreBJIFMIMFdb914BxyaV4trPZy6g
	qvRm8P+hBBCH55emz3XBXQeQZp6jfJ+UgeTskl7Zx1JJl+Y1EGalCuDYnYN/HICicOcjw7
	b0S5syA9nAahrlkh0thL5Tzs0IyEu6tF9KvG+yMxU01acxDhWBhpBRDO3hb4RA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707819722;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jV1AlrzTVRtepO7sOkkDJ2Dl7gJbt/dfPd7N7+cYnF4=;
	b=5fVkOcMINCjShmxO0tB8ubd32mUf3qbWEH5ODjF6UZtBpc1fzN7g+Do2WdJuw55XmupaN+
	OkVnr5vD+qMcokBQ==
From: "tip-bot2 for Christophe JAILLET" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v3-its: Remove usage of the deprecated
 ida_simple_xx() API
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C3b472b0e7edf6e483b8b255cf8d1cb0163532adf=2E17052?=
 =?utf-8?q?22332=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
References: =?utf-8?q?=3C3b472b0e7edf6e483b8b255cf8d1cb0163532adf=2E170522?=
 =?utf-8?q?2332=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170781972146.398.15056573304957978726.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ee4c1592b7e9a5bf89b962d7afd7e9b04c8d16ee
Gitweb:        https://git.kernel.org/tip/ee4c1592b7e9a5bf89b962d7afd7e9b04c8d16ee
Author:        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
AuthorDate:    Sun, 14 Jan 2024 09:52:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 13 Feb 2024 11:18:55 +01:00

irqchip/gic-v3-its: Remove usage of the deprecated ida_simple_xx() API

ida_alloc() and ida_free() should be used instead of the deprecated
ida_simple_get() and ida_simple_remove().

The upper limit of ida_simple_get() is exclusive, but the one of
ida_alloc_max() is inclusive. Adjust the code accordingly.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/3b472b0e7edf6e483b8b255cf8d1cb0163532adf.1705222332.git.christophe.jaillet@wanadoo.fr

---
 drivers/irqchip/irq-gic-v3-its.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index d097001..cd950f4 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4419,12 +4419,12 @@ static const struct irq_domain_ops its_sgi_domain_ops = {
 
 static int its_vpe_id_alloc(void)
 {
-	return ida_simple_get(&its_vpeid_ida, 0, ITS_MAX_VPEID, GFP_KERNEL);
+	return ida_alloc_max(&its_vpeid_ida, ITS_MAX_VPEID - 1, GFP_KERNEL);
 }
 
 static void its_vpe_id_free(u16 id)
 {
-	ida_simple_remove(&its_vpeid_ida, id);
+	ida_free(&its_vpeid_ida, id);
 }
 
 static int its_vpe_init(struct its_vpe *vpe)


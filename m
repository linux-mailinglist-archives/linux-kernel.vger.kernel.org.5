Return-Path: <linux-kernel+bounces-165766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A948B90E5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB5DA1C22F43
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CB2168B1B;
	Wed,  1 May 2024 20:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="XckCldwC"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0511635A9;
	Wed,  1 May 2024 20:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714596498; cv=none; b=PG3mGi/sctz/sW++49NwVwDmebruUgOWdqi+0ah5trGgFzV4Z9MH2vt3OjluDNLQujzHwxnDXm3SmE+0zCiTXX7DdPAhbKHh67+fOt0coxdo1lkEx7ne0Pkh1j0HXHW0J+FDTTZFwTsaOY7tH+RI0Xwg/Z5fUFiu16hn9Apwg8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714596498; c=relaxed/simple;
	bh=qACjeJ8WIuESunSMWPlu5A8R78ujFaqbQZlXKib7gwQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KSFwIIVhD2G4OG3QsQfnT86RIU3Y/22xdAFaslUf7Syx1U25N+7wY7ORCZJVA3LvxTP779PxZ6tArZnxVWI/iHYe2Kc44BRYgngc1IO9W71nT+VpDH+O+On4rt+CbwmdIqrCBSdcMD8OVVqqPmxS2lPQ9SwsR0nHgx0nX/RKXAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=XckCldwC; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s2Grz-005PNh-2A;
	Wed, 01 May 2024 22:48:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=h8RCSKC+enaAXM/E/bFJEcaWjvNfKRuAfVQEY1KJEF8=; b=XckCldwC2WffgnEb7L6zWrbTa0
	+DKKWP1YE3eg/0y8cqYNOwx193BIU7KSmUzSfqfVOs6dU/72CPOkNqMtuCxHDWggRM97wJI5GwE4F
	exTPomdKQoVBTeEEHOpNKViyWAAS38K4CCcXK+djshWFO3krG8AlNk+sxnFKAXe/xrxdc0CEMtbdW
	QlE3kEyEdV/SNuji4wxToNj+2o7I1w7+BUDIZXnm+pG4Jk2SqIbfQZPnPul9WHw2BKqrqifKDeWtB
	4ZXIQ+BRzRIkQgWj0Lj1aQbxVHwL1+/bnUS37NCL+a4nUJyGE32csxZY2Ck/OKALTkTJi5cZVb8+5
	hBKXXeOA==;
Received: from p200300c2071a02001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:c2:71a:200:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s2Grx-000OnW-3B;
	Wed, 01 May 2024 22:48:03 +0200
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s2Gry-003BKm-3C;
	Wed, 01 May 2024 22:48:02 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	o.rempel@pengutronix.de,
	andreas@kemnade.info,
	u.kleine-koenig@pengutronix.de,
	hdegoede@redhat.com,
	oliver.graute@kococonnector.com,
	ye.xingchen@zte.com.cn,
	p.puschmann@pironex.com,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andy.shevchenko@gmail.com,
	felix@kaechele.ca
Subject: [PATCH v3 2/2] Input: edt-ft5x06 - add ft5426
Date: Wed,  1 May 2024 22:47:58 +0200
Message-Id: <20240501204758.758537-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240501204758.758537-1-andreas@kemnade.info>
References: <20240501204758.758537-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As ft5426 seems to be compatible with this driver, add it.
Debug output during identification: Model "generic ft5x06 (79)", Rev. "

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/input/touchscreen/edt-ft5x06.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 2a1db11344766..028ec66faa193 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -1486,6 +1486,7 @@ static const struct of_device_id edt_ft5x06_of_match[] = {
 	{ .compatible = "edt,edt-ft5406", .data = &edt_ft5x06_data },
 	{ .compatible = "edt,edt-ft5506", .data = &edt_ft5506_data },
 	{ .compatible = "evervision,ev-ft5726", .data = &edt_ft5506_data },
+	{ .compatible = "focaltech,ft5426", .data = &edt_ft5506_data },
 	/* Note focaltech vendor prefix for compatibility with ft6236.c */
 	{ .compatible = "focaltech,ft6236", .data = &edt_ft6236_data },
 	{ /* sentinel */ }
-- 
2.39.2



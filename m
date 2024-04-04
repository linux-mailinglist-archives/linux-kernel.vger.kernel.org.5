Return-Path: <linux-kernel+bounces-132196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05813899134
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3706C1C21865
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED1F13C676;
	Thu,  4 Apr 2024 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="sGX0qgz5"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38D613473D;
	Thu,  4 Apr 2024 22:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712269225; cv=none; b=RHUqwcofh++lRkpcmdNhFsJuBPKwmKZ0XMFFHUQu8HlNeQld8LMbrsz6+TxKq3EyRUYJYm0DOKmEdUGRW0R1AB2F50KlBmou2zEnOgpY5qviuhlqKoy02z2fr0bmwL8cdXovZfL0iThOdJ84H1J3iqG12KR7Z6bHOX7MFFqcPGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712269225; c=relaxed/simple;
	bh=1amtG1tMvtsm2W9ukj3lLmNfIaNpzMvJZ/j8etMTEYY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OpoWZxkHDh6hZTZSZdlzeGE+hR5pGK5mWGo2If1y/kziiWX9EcGetjXpId7Gn6z2xGtEW6iCEoI1Blb6xjdu4+0hnyxcKylH6LevBEC06xbgxrqF9L89il9olrzyE7QyBJhzTRlzi7/413gVWMyu6WX6dEj1L/3cOfoLwdhlCww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=sGX0qgz5; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rsVRR-003r6M-2c;
	Fri, 05 Apr 2024 00:20:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XI+TA2dvHhHhLvWbTaAQjVRQOBUokh+WbPMJYzMObwc=; b=sGX0qgz53gmLTGQ7Bew1xFzn1B
	yDlEmdUZ0e13eiWAGlYS4IgZKRe7e1lCqBxQf6RlrW81g8sP2cavbeTiqMOqTAtX27qOP+rsr9C6M
	ueEImF+ydnemTb7ojw570D25Y4+Utb+jaJ1D3U4LhMKNwvwHYw/c4pqvgVNo2a7ZIqKoknn6HjN68
	J5Rvd75Bry0Yq5Olu1Msl1QINTt3eN4AL6RpOL8Gg2uI8B90LpnAOOSdYK6rJZkt+rUq/IP3Pcr++
	BLqNhAcNrYV51xy37F0oSuZcISux7Po4fkt/2ie52etq9ZZF3I+/AYiANOBH65LbXY16UHD3+Am0q
	cOoz71PA==;
Received: from p2003010777026a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7702:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rsVRP-000Nwr-1D;
	Fri, 05 Apr 2024 00:20:15 +0200
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rsVRP-002oTv-0l;
	Fri, 05 Apr 2024 00:20:15 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: dmitry.torokhov@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andreas@kemnade.info,
	o.rempel@pengutronix.de,
	u.kleine-koenig@pengutronix.de,
	hdegoede@redhat.com,
	andy.shevchenko@gmail.com,
	ye.xingchen@zte.com.cn,
	p.puschmann@pironex.com,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	caleb.connolly@linaro.org
Subject: [PATCH v2 2/2] Input: edt-ft5x06 - add ft5426
Date: Fri,  5 Apr 2024 00:20:09 +0200
Message-Id: <20240404222009.670685-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240404222009.670685-1-andreas@kemnade.info>
References: <20240404222009.670685-1-andreas@kemnade.info>
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
index 2a1db1134476..4e7621a80175 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -1484,6 +1484,7 @@ static const struct of_device_id edt_ft5x06_of_match[] = {
 	{ .compatible = "edt,edt-ft5206", .data = &edt_ft5x06_data },
 	{ .compatible = "edt,edt-ft5306", .data = &edt_ft5x06_data },
 	{ .compatible = "edt,edt-ft5406", .data = &edt_ft5x06_data },
+	{ .compatible = "focaltech,ft5426", .data = &edt_ft5506_data },
 	{ .compatible = "edt,edt-ft5506", .data = &edt_ft5506_data },
 	{ .compatible = "evervision,ev-ft5726", .data = &edt_ft5506_data },
 	/* Note focaltech vendor prefix for compatibility with ft6236.c */
-- 
2.39.2



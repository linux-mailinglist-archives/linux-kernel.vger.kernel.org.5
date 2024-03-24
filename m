Return-Path: <linux-kernel+bounces-117332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AE188AA19
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB15F1F69E61
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4143146D76;
	Mon, 25 Mar 2024 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="UzfQA2qL"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95981146D56;
	Mon, 25 Mar 2024 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711379327; cv=none; b=Hfj2RZeYHnnZuCwIeeN5l3T6RieoGwudUIzbdrJjwoRfl/x/P0YRFnoDC6ZSu6IhpM5qdviBjggSrXTFToOARCMVYPqgtoFIGLWDnzDNVzTct2GjYQPy5UiZlFHLFLQOK+IWLDys7bzXpUV8Rjw6jw9FTuuzPFF3VodC6BBVQpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711379327; c=relaxed/simple;
	bh=cOB5ofcragOsxUPDcRYrRuGwwiFEh7d8O8+uK+5YN54=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QhwnJld7OLugBcTCgqFo7XlEbozusP+TOOQmDWVPj1B1Fb6U0Rvq2xU4LCjLLxAXYsS00RVUMrilC4/hb9LfHKwF0nPgLj3dsxhDaAEy4qZ05SUtp/tNIKJJWpDGZa138RbGIGfS+9ZgrjdZf7UklN9sQmkLz8GGLeFR/zuq0AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=UzfQA2qL; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rolwE-003KEg-1E;
	Mon, 25 Mar 2024 16:08:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TkWL+DHrht+nOfgyUNGNUf3KP01IjzuevLkBJPg3TiI=; b=UzfQA2qL+bndZw6lsmdoDeELjW
	uuMpHqJV3OOnQ9XErtmLJOy8b775fseCT6uPNyDf4d1N1tAXwO+MJ0ULPrEKXyjQyi8YLURYw2v5y
	KfkjM3J2swbh6A8ItMFOFROS6dpDMSnWtBsEbxtuHw8ncnSZthPG/ot12FcTz1NBqd/lR6vhn1QtI
	M2/IcyOWSSQ2b5riYCQjyVq8M2NaPXS0zWswkIjSKqdSXXeo1/xCxfcuDTZ1VpmbtSZrJGKrENIO1
	zXhQX6yY8FkiiRJiDSwb6y9jgAXyrL93P/2TXu8W57oql31y/aTZOE4wvAiskqSLBF/N2EHpH0Eea
	vw72pM9Q==;
Received: from p2003010777026a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7702:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1roSqO-000Y2F-Df; Sun, 24 Mar 2024 19:45:19 +0100
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1roSqN-000rkQ-0s;
	Sun, 24 Mar 2024 19:45:19 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: dmitry.torokhov@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andreas@kemnade.info,
	o.rempel@pengutronix.de,
	dario.binacchi@amarulasolutions.com,
	u.kleine-koenig@pengutronix.de,
	hdegoede@redhat.com,
	p.puschmann@pironex.com,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	caleb.connolly@linaro.org
Subject: [PATCH 2/2] Input: edt-ft5x06 - add ft5426
Date: Sun, 24 Mar 2024 19:44:15 +0100
Message-Id: <20240324184415.206587-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240324184415.206587-1-andreas@kemnade.info>
References: <20240324184415.206587-1-andreas@kemnade.info>
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
index 2a1db11344766..4e7621a801756 100644
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



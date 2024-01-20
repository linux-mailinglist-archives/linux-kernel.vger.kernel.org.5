Return-Path: <linux-kernel+bounces-31882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6A18335E0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 20:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758CD282E12
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 19:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F12612B76;
	Sat, 20 Jan 2024 19:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="j1xTB9rk"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF8F1078D;
	Sat, 20 Jan 2024 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705778434; cv=none; b=TIcoS92eHXlmtp3MwbIdy8aR5E/TB1U/dsQ1M3mrR6cQ4wm1xsi3VmbQjzYpnVgoEYagZ+G3JQDpJnCwpwhftdcpVp/QGSN7eFQqqDGTsVe6n8pNgYuvhTjqobJ2v2wlzctQEP80YtwJ++MjQyXANxyDb9VcgMBq7dJ38yqCVaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705778434; c=relaxed/simple;
	bh=lbgvZZ+jq9gybgJnb0ibUvNKN58JqyZYhdnzv9MmZtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/MBm1A/FlCvut/LySN9MV/mQjc4t1AUmzUPObNFir8H3Bgc76kjW4hEs/CQXC1FogYKT11Ot3oGi/Z1VL/0oGHVTj7jmOsTpZ+CVVzmcWJGYq6mXqj3WAWYMYdCqLuOQci5DrFG5HJCwKHX5yRMgAnO2wahtd4uiiAu1HhrmZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz; dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b=j1xTB9rk; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 2B44B283BD2;
	Sat, 20 Jan 2024 20:20:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1705778429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4HCW9YBPmcsH6XFypSoaa73HChH/KfPfLJleih85h4c=;
	b=j1xTB9rkOy3HnnDbQ4D02+SJlqP+woDc5iyjVEtx/LKWtRSXEwurFewmdejXUzlKFh3VWX
	vXwDqHLRtfyPojYAtmG5RlTIBitZm7GBvKq2FneHMfGZ5cRpXDkNeM5zn4ShkEi2ZzqccK
	7+2Waf8qgZND0M2GeUeg8R4qkxmpaZ4=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 0480C4577A2;
	Sat, 20 Jan 2024 20:20:29 +0100 (CET)
From: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
To: Markuss Broks <markuss.broks@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org
Subject: [PATCH v4 1/5] input/touchscreen: imagis: Correct the maximum touch area value
Date: Sat, 20 Jan 2024 20:11:12 +0100
Message-ID: <20240120191940.3631-2-karelb@gimli.ms.mff.cuni.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240120191940.3631-1-karelb@gimli.ms.mff.cuni.cz>
References: <20240120191940.3631-1-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Markuss Broks <markuss.broks@gmail.com>

As specified in downstream IST3038B driver and proved by testing,
the correct maximum reported value of touch area is 16.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
Signed-off-by: Karel Balej <balejk@matfyz.cz>
---
 drivers/input/touchscreen/imagis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
index 07111ca24455..e67fd3011027 100644
--- a/drivers/input/touchscreen/imagis.c
+++ b/drivers/input/touchscreen/imagis.c
@@ -210,7 +210,7 @@ static int imagis_init_input_dev(struct imagis_ts *ts)
 
 	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_X);
 	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_Y);
-	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, 16, 0, 0);
 
 	touchscreen_parse_properties(input_dev, true, &ts->prop);
 	if (!ts->prop.max_x || !ts->prop.max_y) {
-- 
2.43.0



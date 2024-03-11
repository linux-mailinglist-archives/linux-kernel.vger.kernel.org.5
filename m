Return-Path: <linux-kernel+bounces-99178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D7C878485
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9BA1F2117D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C6653E08;
	Mon, 11 Mar 2024 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="WYDQ+Dvi"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE43E51C5A;
	Mon, 11 Mar 2024 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710172925; cv=none; b=tgLlGp6UsxsUsaLdmdCEKsP2S7ieXYDYcr8/VX4t0SSetbuOffwFtbSCes3d3FMfgMwyXpAH+7k1ISs3r434IHkoOuBuBZIKZk1YsJrDykmT+/iws927sdHZ4R4+FdVKynszzgooMrNRtqwFN9RJA8bt0b54XhRn0oNjJQ+atyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710172925; c=relaxed/simple;
	bh=X8u1uSp8PSGBxfTjwO9Jh3/p2urwTYeubgK79OdVU/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubmhH7nfgTNB2JbQ0OoffWZ0rPsPzWbzyG9oM5VsmAnq1L9oigHJ8S6MgE9lg8YLzwQNqmkLp+PgqnAzgHlNiZHMd+eArvSwJfZ25UPnz5IOf+I3+55MbGMPL5hG4uDmYJ8NzjqoIa9tYfLjVmcdsOP639C/ih4p9TAy5qyLxQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz; dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b=WYDQ+Dvi; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 748982846EE;
	Mon, 11 Mar 2024 17:02:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1710172922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L8AQ4xgfMvMsXIMfpwAjFqhheRmmqGTQDMpqDvceVgs=;
	b=WYDQ+DviIwjnSHQmtDbppmhVfJe55T9vR2PEbm2MUKFLA754hgB9nPLl1GYMdMFGwbcFJ7
	t5LFv0DK3ARcdRRLIPEv9pNEHPN58CiQHY2MBv7VNh3tdXdiSXhQB/psI6RQdAVlf+2Cw9
	wjPaAOQjIQvn+CvgwGMfvV3HHGih/Pw=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 45AE9456963;
	Mon, 11 Mar 2024 17:02:02 +0100 (CET)
From: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
To: Karel Balej <balejk@matfyz.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org
Subject: [RFC PATCH v4 5/5] MAINTAINERS: add myself for Marvell 88PM886 PMIC
Date: Mon, 11 Mar 2024 16:51:57 +0100
Message-ID: <20240311160110.32185-6-karelb@gimli.ms.mff.cuni.cz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311160110.32185-1-karelb@gimli.ms.mff.cuni.cz>
References: <20240311160110.32185-1-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karel Balej <balejk@matfyz.cz>

Add an entry to MAINTAINERS for the Marvell 88PM886 PMIC MFD, onkey and
regulator drivers.

Signed-off-by: Karel Balej <balejk@matfyz.cz>
---

Notes:
    RFC v3:
    - Remove onkey bindings file.
    RFC v2:
    - Only mention 88PM886 in the commit message.
    - Add regulator driver.
    - Rename the entry.

 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 960512bec428..944f88c92df6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12949,6 +12949,15 @@ F:	drivers/net/dsa/mv88e6xxx/
 F:	include/linux/dsa/mv88e6xxx.h
 F:	include/linux/platform_data/mv88e6xxx.h
 
+MARVELL 88PM886 PMIC DRIVER
+M:	Karel Balej <balejk@matfyz.cz>
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/marvell,88pm886-a1.yaml
+F:	drivers/input/misc/88pm886-onkey.c
+F:	drivers/mfd/88pm886.c
+F:	drivers/regulators/88pm886-regulator.c
+F:	include/linux/mfd/88pm886.h
+
 MARVELL ARMADA 3700 PHY DRIVERS
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
 S:	Maintained
-- 
2.44.0



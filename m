Return-Path: <linux-kernel+bounces-89701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AB386F459
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 11:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0708F1C2089C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 10:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47537125A3;
	Sun,  3 Mar 2024 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="CvoH8IKr"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC73511188;
	Sun,  3 Mar 2024 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709460941; cv=none; b=QIaDjvOKVg5gkwj0EXvNTEuioe6mQYppH/7DtfYtzoUKS5RujIQjzECBh3U2SFw+JmeD58SJCpgxE+NHNidjsemMebi2g1LAc5IQVYCKMd8M8c4qhT3I+Id23u7sHUcwVkI1ZJoVWDRsKMphm5ryrJ0OiE5h5KGRQN7lUUzfFfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709460941; c=relaxed/simple;
	bh=X8u1uSp8PSGBxfTjwO9Jh3/p2urwTYeubgK79OdVU/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=esWy7olqSSVjb9wv2H5e53O5amnH28Vm1YMgwmW8KvY5RYaz8sdBxN9QNGxUsj1HRynMaF+Ahf9n1wQ2B6jpmM0Psll/0gvLQKVpinr6mn5pzI62ofE4UqkvbiLD3tAdj3d9dgIfucp4CVPVx2eG2IqLLeCvo5hfdUJ0zCZNupU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz; dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b=CvoH8IKr; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 2578628428C;
	Sun,  3 Mar 2024 11:15:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1709460938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L8AQ4xgfMvMsXIMfpwAjFqhheRmmqGTQDMpqDvceVgs=;
	b=CvoH8IKrHNt16qFEKIgD+LeIQF2An8FpTMMtyevmadTwAcgVHFlayLzjnwmKNTGwIDOqVV
	q6W6AVjSLvMO1IH/9BJcyg4V1juL2En5eI3btM/oTsHWGMabRlNoEW50yCZKi7IdybkZCv
	e0GfCAhxoKH084aTM0/g+khnMOdOU5k=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 01C8F456F3E;
	Sun,  3 Mar 2024 11:15:37 +0100 (CET)
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
Subject: [RFC PATCH v3 5/5] MAINTAINERS: add myself for Marvell 88PM886 PMIC
Date: Sun,  3 Mar 2024 11:04:26 +0100
Message-ID: <20240303101506.4187-6-karelb@gimli.ms.mff.cuni.cz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240303101506.4187-1-karelb@gimli.ms.mff.cuni.cz>
References: <20240303101506.4187-1-karelb@gimli.ms.mff.cuni.cz>
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



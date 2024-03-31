Return-Path: <linux-kernel+bounces-126047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E42289315F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 12:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13CCB1F22809
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 10:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2C8144D32;
	Sun, 31 Mar 2024 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="HnrrSMPc"
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74AA1448F9;
	Sun, 31 Mar 2024 10:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711882731; cv=none; b=etTr8jyxPfmDsHsvVcBdXrPGqgyc+OM68kz+J33GWUL2DbhvwXcu/gVUPH/cDl81xxe7PcGhbVtiO5RWs822P1sHvVzgZ7eVeEpk6DiLZmkxMIvO6oZZgSPTsyfQvYlaEz2MVsdc/i78ee6a2P51zSfObzGD2ukp2QDjh06sAL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711882731; c=relaxed/simple;
	bh=BnENT5VmFur1MN1/Wf3VPddAYXMMlqbqiihjspougus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKkf4zcDI4byhto6sOUWXy3JfXUCdP0DriCI37E/e+EH6sz8rA1toOjeBsDtJT32NoPkC7fo55tny8PQzg4/RCB1XAzH3jaF9LSoIFAZoOQOYFOGmndeoWQPTrfGd5fXami5LXRIXMbh47Hx/RmvL+ZxmWNKHqINmDv1F3ExLws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=HnrrSMPc; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1711882708; x=1713182708;
	bh=MBCZGUR/JpS2Y8PwCRlC22Q+rst7VT9yNoCBV75WlPQ=;
	h=From:MIME-Version;
	b=HnrrSMPcIQTNtPgiwRNKk6ReKKJNSsQ/5Jpr+5nlJdytD3V/KuuUtK1IsP5xFyJk3
	 pKZeAqOnQjW5pISluhwzXOPB4IgNF90g3tnbyA/GsDCakyOVcWUgzILyKaLn+azFWt
	 5qgJEQsXybp14cR2JziLh59GS1IXUL/U05QegQYm/qJFJRvHPW+bE7C6LgKqFUo0SS
	 fJMKtxR/0VYnMhUoqkGBMHRiydfcZNm44JcneXD3KbW9KK54SjjWN3hTcBnrjDbH6S
	 Bh34T9qMlkst5wcA8o9I/C7mm/dETYGJaDyMf36mqXvtYfG6bgfGiyQHSJZ5mAf9ha
	 iWD/3l4v7wReA==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 42VAwRn9095416
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 31 Mar 2024 12:58:28 +0200 (CEST)
	(envelope-from balejk@matfyz.cz)
From: Karel Balej <balejk@matfyz.cz>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: [PATCH 5/5] MAINTAINERS: add myself for Marvell 88PM886 PMIC
Date: Sun, 31 Mar 2024 12:46:58 +0200
Message-ID: <20240331105608.7338-7-balejk@matfyz.cz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240331105608.7338-2-balejk@matfyz.cz>
References: <20240331105608.7338-2-balejk@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index aa3b947fb080..c6bdf93ea3a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13048,6 +13048,15 @@ F:	drivers/net/dsa/mv88e6xxx/
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



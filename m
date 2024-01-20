Return-Path: <linux-kernel+bounces-31884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996738335E6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 20:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E825AB21D68
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 19:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69FE14ABD;
	Sat, 20 Jan 2024 19:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="ffiZwZuL"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C5F11CAB;
	Sat, 20 Jan 2024 19:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705778436; cv=none; b=UE0ocLP4aOlrTg1As3d9C4F4yRiPz0VAVb+Uks2zDkij1nMa+9HIGZLLif8TXMPULmZ16b7AGYHdZAepukGtAXoEJr2B7Ct5ufMaKSI3rm8ttECHre+EOx+vRia3OM5PTQWB9IwbD1rkm/7b837unr4+EWzg4SBlzcIcrFGvrM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705778436; c=relaxed/simple;
	bh=v1KSwid17+YZwnEM/2QMXL0rKb4tz5sf2ADmZFvSaR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqujQQdG6xLygEoHYU9TRGLK35iqZSLh8HXACmph6PF2RhQ8BQIf4ar7eQ58AvRXQqOPK1+Ed9JI/H4NFGHa2Ga7mIp3RErhMN6CfwtkNcVCQZdENC+yOKjWzFykAie+ik1UWkFa+YA/m70McZVXfbbfeIfpTsUT/GUgl/trV10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz; dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b=ffiZwZuL; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 1E87F283BD0;
	Sat, 20 Jan 2024 20:20:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1705778432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/dID/rk5TxJzyZNl6L5pM/cORYDEDnsW7lNaq9RdHVg=;
	b=ffiZwZuLCixy2om0avl2RKoU6vC2NElWb/lW0IS+6Soju9uVAPNBS4mDsag9bkf3eKmGqd
	ZMAXgU7372lWKijwq1KxcMA5Ys40xkx68S0THkMPM8VMmr9qrFhvL7lW3YKUXgNOdgbdjf
	wyUen0bxlCSUcdCZ++DcUMk9ow5r/bg=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id EDAFF4577A2;
	Sat, 20 Jan 2024 20:20:31 +0100 (CET)
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
Subject: [PATCH v4 2/5] dt-bindings: input/touchscreen: Add compatible for IST3038B
Date: Sat, 20 Jan 2024 20:11:13 +0100
Message-ID: <20240120191940.3631-3-karelb@gimli.ms.mff.cuni.cz>
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

Imagis IST3038B is a variant (firmware?) of Imagis IST3038 IC
differing from IST3038C in its register interface. Add the
compatible for it to the IST3038C bindings.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
[balejk@matfyz.cz: elaborate chip differences in the commit message]
Signed-off-by: Karel Balej <balejk@matfyz.cz>
---

Notes:
    v4:
    * Mention how the chip is different in terms of the programming model in
      the commit message.
    * Add Conor's trailer.

 .../devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
index 0d6b033fd5fb..b5372c4eae56 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
@@ -18,6 +18,7 @@ properties:
 
   compatible:
     enum:
+      - imagis,ist3038b
       - imagis,ist3038c
 
   reg:
-- 
2.43.0



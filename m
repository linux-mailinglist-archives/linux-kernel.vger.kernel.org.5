Return-Path: <linux-kernel+bounces-59668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C3F84FA26
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2B41C283FF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21D3129A84;
	Fri,  9 Feb 2024 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="EaqgnBpC"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30851292D3;
	Fri,  9 Feb 2024 16:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497344; cv=none; b=a8NsM786HwBpfmfUujODnkpKb9FDFukkc/ApRlKjySVV7pwR+fZtb4unlIHtW4CmKLVZTL/U36ybU/2vvf5pXJP9qgzPfw8x1+lC52VIVb6/ObWZMDAsRWgXRg1qFbui0Q7JJXqPiQhZbIfn/aiQoskutTCg8HjifmShARnVyOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497344; c=relaxed/simple;
	bh=v1KSwid17+YZwnEM/2QMXL0rKb4tz5sf2ADmZFvSaR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0xL5DohDwqIbaRjvyNOJQc4B0JFr7BXZwkZvniREQSwQIsFxqPDhMa3cSf/k1jP6ksFFOFB5XynrymipSbl4gOV9juD9MYMJXy8BQRP+1Gx3OsFVJfP4GR6wXlMlCNYyFaQ6wVf7mZsasqP7v/xnTijCZmCdoZfnwC7gzcLElk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz; dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b=EaqgnBpC; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 3AF09283DF0;
	Fri,  9 Feb 2024 17:42:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1707496960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/dID/rk5TxJzyZNl6L5pM/cORYDEDnsW7lNaq9RdHVg=;
	b=EaqgnBpCI8NHPSF50WGRpw9QKD70/s3PPPDSCaAQ8zLSDGsUxpzlCWEqI+mlY4PmoVJ8O5
	GGqc8SiYGriG87KjQrV/6TEWPiGYU6Qjqcs5PdayrBXGvetFdvxssGZcaK/Y8ik52TG5A1
	xtW0qzo1nNQnlZ0K7EWVa/7sMmOrtCQ=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 1982F4590CD;
	Fri,  9 Feb 2024 17:42:40 +0100 (CET)
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
Subject: [PATCH v5 2/5] dt-bindings: input/touchscreen: Add compatible for IST3038B
Date: Fri,  9 Feb 2024 17:34:19 +0100
Message-ID: <20240209164217.9008-3-karelb@gimli.ms.mff.cuni.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209164217.9008-1-karelb@gimli.ms.mff.cuni.cz>
References: <20240209164217.9008-1-karelb@gimli.ms.mff.cuni.cz>
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



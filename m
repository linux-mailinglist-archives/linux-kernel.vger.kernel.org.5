Return-Path: <linux-kernel+bounces-88774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4842086E661
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616661C20AE5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524F123776;
	Fri,  1 Mar 2024 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="u+gZsrAi"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE1E525B;
	Fri,  1 Mar 2024 16:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311667; cv=none; b=qZV2PLyepSo2l/IXcP3YU0D10vQ2H3uUxHqHZZOYcaVqLJTr+hglogR8LfKW7FdtoaEwsE3dBuXOTD4qJntYImXylZ61Q/vxbCMa9WaN58ekDLWJMTQQ3XhxdlZQ+LPieUjwJhp42v46mcb7nxz+6tY+lQnIe/OiRCi6zfrVTlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311667; c=relaxed/simple;
	bh=jWkyeprtDcmm372p45VVEktoZD14WIqZ/duBacZeYHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yjii2mMMq1O/x8a6/j89dmYkpTDoapapxlGH9YjAdFOGRi6eGiDmUerDJJMOQ/CDifkYtDh+4a1zm0VbyCGgTvTPgX44L7MLRDLVeWUzf02Hy84e/LVnWNxz9KIMaQuMjmWGHYem70uWUbljFrNq9P6ykfHVmzEyAVnW+VaZzOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz; dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b=u+gZsrAi; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 592ED284257;
	Fri,  1 Mar 2024 17:47:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1709311657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Te2cu5IWLMOf63F8UHnTyXgS+llf7Gs1S1hHLvmrD0=;
	b=u+gZsrAi825CQAUwZHOkvhxmPIMUYV1PLMZB8UWvl5aNmeUWXIIMwIhvOz90fBCisr5XT4
	NI1Zzo9WZbH/rTzufCRISk5re7+c0Ob5zhFSKWoEshDz4hhBrDUPWgBIz+PWeCgQ02baEa
	wm21ioHf9R+HL65tCj9kNTqwTjSyqpo=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 39C844587C6;
	Fri,  1 Mar 2024 17:47:37 +0100 (CET)
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
	phone-devel@vger.kernel.org,
	karelb@gimli.ms.mff.cuni.cz
Subject: [RESEND PATCH v5 4/5] dt-bindings: input/touchscreen: imagis: add compatible for IST3032C
Date: Fri,  1 Mar 2024 17:41:03 +0100
Message-ID: <20240301164659.13240-5-karelb@gimli.ms.mff.cuni.cz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240301164659.13240-1-karelb@gimli.ms.mff.cuni.cz>
References: <20240301164659.13240-1-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karel Balej <balejk@matfyz.cz>

IST3032C is a touchscreen IC which seems mostly compatible with IST3038C
except that it reports a different chip ID value.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Karel Balej <balejk@matfyz.cz>
---

Notes:
    v5:
    - Add Rob's trailer.
    v4:
    - Reword commit description to mention how this IC differs from the
      already supported.

 .../devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
index b5372c4eae56..2af71cbcc97d 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
@@ -18,6 +18,7 @@ properties:
 
   compatible:
     enum:
+      - imagis,ist3032c
       - imagis,ist3038b
       - imagis,ist3038c
 
-- 
2.44.0



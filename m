Return-Path: <linux-kernel+bounces-152449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD5E8ABEA3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 07:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6638B20BFC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 05:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D48D2FE;
	Sun, 21 Apr 2024 05:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E7l3AT3F"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2972DDC3;
	Sun, 21 Apr 2024 05:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713679056; cv=none; b=n2wy0QNzQ7jIQSVIBUGAb35lf6NfZGZYJPvIj9eJ9KOJnaE00zuJg24D/LDv2i3mzo4e1B0eICxQY1FUE/CeAxU0kAWou1ayppqC8muwj/FgGq2ouzkwzs3xABW2lWj9BdEb9GzIU4FelzYZZYRoLNbZ/3Cc5Ox4mvA0EzJBugg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713679056; c=relaxed/simple;
	bh=SQI+W4X5svgIhMTr0FlelWlsBm0aCHiU4dR3/m16cSM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PPKJpntZeg1wuwxdvuPIBCRPPLsjl/g10WJlQDYEuId+1nxiFtGlCLRTgkAFqLV+RilJgmrUgFsiw5/lBVll9C6VxPSvNYkOP8J/YKsN8LgistH8CGtsVB71QgpUywytUlZyhyRCrXoSRtCFvLEmmkVS9dCzIKwyw5p5Jo5ywPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E7l3AT3F; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B63E01BF203;
	Sun, 21 Apr 2024 05:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713679046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/dDHo+ZHs/JUcsjGJGg/vbysKC5Mw590x28u5YYvIXg=;
	b=E7l3AT3FYz1yTsQXYEgHUxlwDcUxJppyNcyMUtqYOQmd0Ih/jufAbBe04TfkT9r8EXn4/D
	s2KHP3veqSG3ErTVL3PEO1yMYKWBlDTXp9L9+WBbJhCS2zP6gqESEh5zvpVg1hbDZ0wV11
	6hDELEJ0L/ky9dpv6e0HKwCKRG6irshytE7Io7KM+SUDFwl2iPNRdIvCLjcl1Nej1jfTbz
	cvEfms5FFMZW3wBiXWPhTzif7FOHQIZui4h34Zs9q1fapM0sX2/bBmuZYh8Z2cTcJosDFH
	uLP6PcB8zxFpTnWqLGtCXF+xMfm+zTeqIiTTqj7HxA6QZFZWJYGB82V9Ct2zMA==
From: michael.opdenacker@bootlin.com
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Chao Wei <chao.wei@sophgo.com>
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] dt-bindings: riscv: add Milk-V Duo S board compatibles
Date: Sun, 21 Apr 2024 07:57:09 +0200
Message-Id: <20240421055710.143617-2-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240421055710.143617-1-michael.opdenacker@bootlin.com>
References: <20240421055710.143617-1-michael.opdenacker@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Document the compatible strings for the Milk-V Duo S board[1] which uses
the SOPHGO SG2000 SoC, compatible with the CV1812H SoC[2].

Link: https://milkv.io/duo-s [1]
Link: https://en.sophgo.com/product/introduce/cv181xH.html [2]

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 Documentation/devicetree/bindings/riscv/sophgo.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/sophgo.yaml b/Documentation/devicetree/bindings/riscv/sophgo.yaml
index 9bc813dad098..79546aa21021 100644
--- a/Documentation/devicetree/bindings/riscv/sophgo.yaml
+++ b/Documentation/devicetree/bindings/riscv/sophgo.yaml
@@ -24,6 +24,7 @@ properties:
           - const: sophgo,cv1800b
       - items:
           - enum:
+              - milkv,duo-s
               - sophgo,huashan-pi
           - const: sophgo,cv1812h
       - items:
-- 
2.34.1



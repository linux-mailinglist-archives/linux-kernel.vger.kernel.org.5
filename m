Return-Path: <linux-kernel+bounces-152492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BECBA8ABF3B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 14:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FADD1F21434
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 12:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665A21757A;
	Sun, 21 Apr 2024 12:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="GCq27bp9"
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08171401E;
	Sun, 21 Apr 2024 12:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713704048; cv=none; b=mBDOl9/WBz3vLQeW9FH6nH3KBzBOeih+/3IR/A1cFoBfLN+ycLOGYLUsaDlup41ThHV0/ikK+sD7Sg7yXt6y7OCl/n68N2zlFUUeQAQVOYeU+kupSk3zqB2u3mN6F7bZcQ9Ox6s2qr2ef0PxidFA2ZnEqNYiK301eVlpEwLzeRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713704048; c=relaxed/simple;
	bh=OMxEbSghiub32vJy5K8PNa355eAgggd/IUtvpXdfhkM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=TT3EjwIwMqFZP8f5RSdvP+zrKmUjuWCs2ZLHQ2Rs6EvrPhM1L/0jOpSCidwMlZ7YIOe6uw5bmMy5VCrR8bzwo7QZANsfUo9uHjRiwx/SwGaWjc26HjQjH/Xz6tmndaQmEGWFtX2LIOrOZ2ir1dAGfucAK6riRnKMOW0ahjmKvSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=GCq27bp9; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1713704027; bh=+MFWVuEyUVqlNiNc84ZLlRbkslCJ1Q/32gOiB+YTW2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GCq27bp9DOpfpFtNbQ+ps1WKJIJh6TsojhuwC7VkZgdWEIVJx2t6w5RN2TBDu74Oq
	 Ofm37a/qfcx+cLaOSsfSv1XpSFLVsQB3tfeivUKFbaszUpgAbtWxYlNXb+WNs1H6HP
	 xZWbPyualZf6Awh3XjRa8zVcCaMxmaVw2XoGorr0=
Received: from cyy-pc.lan ([240e:379:2264:6200:aa04:7d36:395a:da35])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id D6B1C271; Sun, 21 Apr 2024 20:53:43 +0800
X-QQ-mid: xmsmtpt1713704023t32d6eczu
Message-ID: <tencent_31510A9A680F39CAE25AC60485043772F00A@qq.com>
X-QQ-XMAILINFO: MvTK+AXQ7a4FhEnFVpRX4G66+GiF/6N8d5qNLQRLLX2rV2tcDzzoadgdArdnVU
	 dz1NkQiSsfsChzkeiJEPf6LLSX8srOMnUsANmnxzIo7X4x1P16IT3B3qmFFmFksO4UgcfUzk/P5h
	 NmSks9IOiVB+PJdHeAuXSgvi85S7PK0BFTeO+eNsD/kXE5ga9YZ9LGsKsFhb+BWCpbTUGuezkLy9
	 p2tvy8yTiaUXZPD1hgeNYhRYW9JTYDJTd/7CFAnY/liIGKUIip9IgrKLoTAruZab7xPARl1gMzq5
	 Vg8ECqx1+z9TygrVKJlw2kQmb16CiEby9D3zH3p0RPmKe1hY8yBNIH/u2oS48MKW9G8+J9dtWvBH
	 Njmkw6Q93BBWhuDigkdmUVKVFV8AZXbyW2kxKiYw2Ze4N5rPmd+gsKMUabLAiUkpaKSDLo4zy2NE
	 8KnROju1uOHPpEwjUie8N2vK9/QdftKylrnZPmHa5tJktnz7QHAIIhmQTNPLko2oLnJnxOeBH8tG
	 nhiNJOyiAFeHrIsDDGd0X8dFo1LOlrdQFmEtyCJN5HcLWbmcePFEBbrBvacAAub9FVRlWd5luH0N
	 y5zCPMd65rY6h3bJwTux44Pcfy0PAyHH5clre+2SPhTOFYOIIjC5IXduum+sGyiyVi8QW0ESY7rJ
	 EMepmi6+9DjlIlTZXskBYCzvximCXoOlFylz4h3XOtJX+96HafQp1iSBmIma2aXQKWskqHfkdQrE
	 5QTGPopCXi8mN79d+N/fAW0bFdj+LubR7svXAHizMXK9qG/tsmcsyXdo/RSwQ1CT6XeOzmcOE1LQ
	 RzFqG8hLZ4FDg0WNGXutp2cx2ZLRb9noU7O3/N5+3MXmWcIsCegMizoMDtWWVJfmxkW078ughOnK
	 ZKi5WEIV4j0vjBA4EdeWMg7mHi7LqCxxAfU/im43RnNVWbaTGtUTxT4Pd9ngrmgNHDwFzXEwQSCL
	 N2/8vGlgN7BhKZYbknFkaD64K6FwSmuKLBJ20wOiPSisK7Myk0nMvl1jKJKKuxC7ogq6gZD4Bcs+
	 wyEuZfVA==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v1 1/2] dt-bindings: dwc2: Add bindings for new Canaan Kendryte K230 SoC
Date: Sun, 21 Apr 2024 20:53:29 +0800
X-OQ-MSGID: <20240421125330.1039774-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_E9B853316D217B8D1E7CDF8288DA5E8ED908@qq.com>
References: <tencent_E9B853316D217B8D1E7CDF8288DA5E8ED908@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the dwc2 bindings for the Canaan Kendryte K230 SoC from Canaan.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 Documentation/devicetree/bindings/usb/dwc2.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
index 0a5c98ea711d..c39d7f9d76a3 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.yaml
+++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
@@ -17,6 +17,9 @@ properties:
   compatible:
     oneOf:
       - const: brcm,bcm2835-usb
+      - items:
+          - const: canaan,k230-otg
+          - const: snps,dwc2
       - const: hisilicon,hi6220-usb
       - const: ingenic,jz4775-otg
       - const: ingenic,jz4780-otg
-- 
2.43.0



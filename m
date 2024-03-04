Return-Path: <linux-kernel+bounces-90801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DF9870532
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D9EEB22BB3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181A24BA94;
	Mon,  4 Mar 2024 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="zMZnaViR"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D092B487B0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709565416; cv=none; b=Gbb5XQfx8JfTG4t41hUJry3ytN2gn85csMO0DQssQhRWltb+BbgixXLokRb9O1Z0YzpZnmiBkzJq+WDZNzNtQmkkk9z3agzJTt6Hza1RGd3LU2IwIdIJ3wk2WqxIgFy10r4IVlu81ue2eOPCd1p6ua07E7dhbjleWv26Yg80n60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709565416; c=relaxed/simple;
	bh=jM3OJNwKB81cUdcyvS7QazGsC6f8eN6sQOqfgimcGAg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=XgQPXPE6BuRqPFTFgJLpJhXssN7HxZGTdAeagikggll+lb/SJJnjIz+7JNEi3L1poLrsXD9GLqQo/sm8LPwY6OgqSP5hCg519nodYJIAnltFW3L9t6KpU6Meg0d6JyGFB6h3XIHvpYnMSbVp5GTceqPA69sVVIsGDTX66qjkxPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=zMZnaViR; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709565408; bh=0+JXxUau3OkyJeeGutyiyK3QETtDeC61mbo4iJi+WJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zMZnaViRsfpH/EcpyRYr/MYac3GZTcF+iSEmTT8D+QKGbPhn+FvRjOFugZhkLvyK1
	 uUM/ggRQN8JjEuEJ+pB+EHhmdWtPpyBorNnjL3aGFsZhSweKrSOrHJATJvfKQEBIYL
	 qcxwd+eTFjNq4lv1nXCqz3uJIh1rKvBGyALC5vk8=
Received: from cyy-pc.lan ([240e:379:2240:e500:994d:62ab:74a6:932b])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 42726AAD; Mon, 04 Mar 2024 23:16:39 +0800
X-QQ-mid: xmsmtpt1709565406ti8xoznv3
Message-ID: <tencent_23A08076AB6331AE43CC64C87FA3081F8006@qq.com>
X-QQ-XMAILINFO: NX3IH4pixvQA+Il7G9Idge2OWHMvE5RPgPBSoWeYsrW7Dx9cnsEv9kw/bcUdvh
	 V4ai4Pewg6j/09bHaCBhnbkn+wyxDM2RKGdyGac5C5vuuQh+MVgJhff5rZDg/2TkjlPYXThH5xZl
	 wsfo6W0SuilP7sxMyDkBMzY6PqjlMjrT2lK/I4Q75bJBL6aAmfab75GXPLEgen2f/CN/hcr+6Vf5
	 Wsw+g05TrIaj5Sq2DRMgFiLQ9SA5FkD2xyJniplHoOSXcrq5jnXnDfydDR1B0UrvDa7dVMVK7uJe
	 cmKCTGVOXdkW4fU5BKWjKzFKu0puqVGlmpNo4PPLf+Z6qei6Mb0JxW2EpXNsmQb0MgA95FrqbXyO
	 q2UBwGnJHZ9hGMK/tiBbh7CSn0qzW3cA8GWHDbiGVaf1c2OYx8cb6TrnFnYL5BBngmixE/yA+ke7
	 u8VTGpzymxcphKzlozq3w2fESNeK/SlegbbbYhz/fUB/Cm4wO/rqkhiznE4jMFDhprQKCBjzss63
	 6uuXTrJTzvi/U14yKQVFfZMTZDZDq35sDpVWo4ByAf3SX38vlv2V3oFbUJR+Ze6r4l57Oo2S4W0L
	 tqDW304xB1wZb34hnbBdyNB3pRbzLI9rLbMmcOopO/O7fa5GvN1MRyi1QD/gFB85ZGgB2qD5pVBR
	 fyqXVmaXCgdeMiNOQhU975Rh6f8Ec6AMnEjrxvZdquUYsXsTa5C5GEg+OYl0w6th3gBh7Uw5iKp+
	 NojD6niXJ1TTSJlrqOXJeGtFcEgYy3X3f4eghsZL/Qv+/yOREh6NkMVsmZNR32JWgB0EgDZFiEVT
	 1QYCd5J2/FCp2Ps62V7ELJy99ol+xXlWf7FR7rf4Gq8Vw6q0jgOJoVaZqJul0pHJORmVJTExbmoB
	 aZYjTTOtiVkML3ERoOp/TNYxO0/Ah/lynP0PnouSLNtYlXLlNHzkh+iiVOYegu26Uud9D1XbcLwD
	 TPx0UwZqloYnki6LvmKQgvT0iixuUPNnSuUM7Jnq6hOlqAaCtch9/h7b6c9rA7rDJVwpWx7uhnaw
	 biRtYSFAJsuD87Q8a6
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v2 4/7] dt-bindings: interrupt-controller: Add Canaan K230 PLIC
Date: Mon,  4 Mar 2024 23:16:23 +0800
X-OQ-MSGID: <20240304151626.759150-4-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_64A9B4B31C2D70D5633042461AC9F80C0509@qq.com>
References: <tencent_64A9B4B31C2D70D5633042461AC9F80C0509@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible string for Canaan K230 PLIC.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 709b2211276b..da147faf32bd 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -69,6 +69,7 @@ properties:
               - sophgo,cv1812h-plic
               - sophgo,sg2042-plic
               - thead,th1520-plic
+              - canaan,k230-plic
           - const: thead,c900-plic
       - items:
           - const: sifive,plic-1.0.0
-- 
2.43.0



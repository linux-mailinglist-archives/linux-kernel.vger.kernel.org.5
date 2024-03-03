Return-Path: <linux-kernel+bounces-89750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C76B86F517
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE78D28257D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4236CDDD2;
	Sun,  3 Mar 2024 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="tKwO6mQP"
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4A0947B;
	Sun,  3 Mar 2024 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709472434; cv=none; b=gBNyYP+x2ZQl4Ts19sRy6ieJOEkQLorsClQvbV4lb1FNYcdCFctNpL2ZzVELz0dpgxuXcItrVlIIfC9OkfItVFrAoVpTkctx3zbIlZbarvfl5joDA1++ueftrB5Mb/5YrQARSF0zjWw6HE1dDCn3k0eyNfTeUMuw4nYY8cwJ82w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709472434; c=relaxed/simple;
	bh=DKttMB1N2T/a3qA0drlDnJPhu/xAsypRFFsP4i1eoa0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Rp2rWWfrd8v37rZAiBYJONWuR58vHQp5NAttuEqvducOChJIf/GoK28OQP1YUDdSritgSxJnjUGdfnAGwFoPkod7ch6LKqpPMpMt59ANVl0CNBb4pPFqSG/JkYlen5q7CzTyLgWlTI/pt+xWkrgxwZ4cv/7uK0WMuJ1dpiMbbYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=tKwO6mQP; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709472429; bh=CQkJ2LPVHwvfrPpeo+8GgP/58OCyvWTP8GNw56RzbQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tKwO6mQPFw5cJnvW9iZdO+4F+Fj7cvoG7yRoabkdN/r/QnJ0G7FZHTTRlkrzeL6yB
	 jUSH8N81er7ctRDeb8LB0HmRFCMVhqWjnZDMAZitlnS3y5R3CQglD+yOsRcHAQOowa
	 0WtC6ZhVL48BIi6LYQHDXg4Bk3MNlhwvmLm7AWn0=
Received: from cyy-pc.lan ([240e:379:2240:e500:994d:62ab:74a6:932b])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 6C4A707D; Sun, 03 Mar 2024 21:27:04 +0800
X-QQ-mid: xmsmtpt1709472424teu4q778f
Message-ID: <tencent_BD3B8D107CA98249DA8D8EFDB862310A2108@qq.com>
X-QQ-XMAILINFO: OIPiZ4jSkGWAZMr6Ai1HjCrB8QSkmDI5dCBZcs7t5CsaTLJpeQjYNPa1nAh6i9
	 vLm1o/lSq1q2vruFwcQuRjjn9ndi/Dx72VelHIjd9o9m+zODLXpbc2q3OctAbbw6xgpFqUipNzV0
	 PrJbD+tsx91vOhFO6g0K2CgSI4DFTXW5RW0AfwP4wTdpxZe3iDoAu8iq9C0Z2beNcaUdyn6d4xv5
	 mRBbFJtNANynNXGEM4vl/c+yuHiLX3iG4jpfxY9Dpj+9I4+w5QcsYOl1vEUeJ2VjlUyRAo2zzuPh
	 ZnFmxIV0w+7hI9ZrTFCugjP11FVPHO3rXzq5gac0GQh6BktB2rtDTCg7Kvip4nsx5s/2Q5PVFmYV
	 X8aC7QRVp8YnshWObfCnW5at1Se2OO234UPFzsHU3tML06CHGGiCH0Brl/xXJ57lEImlXeXlQkFz
	 P/3fYYvie4MO9cHc1cfTRsWgFbBZVPnfFV+h7xP7xfrFrdoSy7woz3vyvNuMwCs/N2WFvjVGsqIz
	 VVgsJb68/zNw5yAjkhxYKYuQ4woZltAV24p4/b6sZiJzE9mf18Oim0AHweMBJV7jm9Ulf2V9F9tx
	 UWeCUpcHV5XmtFHRKa8wAHofaMBqcOc7P/DT6NhjiCxY7QgcUa/yB1kxxD0eeXvj2bk5BPN2qyon
	 gUsPaamN3TVjK0BrdJrOPSURAScSyL9TKrdrSO5+xh3ayM4Cr+f8L+OQdDqUPRAv+I2T/ATdS+n2
	 yV168QtHisVIYyNzUppidF6T1PxVyQSgxjaOhyfgse5ouhYYY7VeITROHvEAFmT3aDYo6Dg/h0i7
	 J2TAUPVqzm9AeaplMUbdlWBOT21BZtJpAB5qwxFe225sjA8EB1btIAfdnZK8zMqAlCuQcTYgFB/f
	 0MCnhsR6SjgSLurjeDSjkIp9ZhPZC9n+Rs6DLEBVn4lmCaClf8ZcQIRuOqPyZUfO1XpM6b0Uwa48
	 u/OHdXAJo7gseZGtJuyTjKnut8Mu4DZx6IfTcSYxZTIr5Z6v7PEIo91GGYaCJ0Dk6xf0/lWkr5oj
	 53ssMz4uNJjeSgViTr
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH 1/5] dt-bindings: riscv: Add T-HEAD C908 compatible
Date: Sun,  3 Mar 2024 21:26:23 +0800
X-OQ-MSGID: <20240303132627.553698-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_E15F8FE0B6769E6338AE690C7F4844A31706@qq.com>
References: <tencent_E15F8FE0B6769E6338AE690C7F4844A31706@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The thead,c908 is a RISC-V CPU core from T-HEAD Semiconductor which used
in Canaan Kendryte K230 SoC.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 9d8670c00e3b..e853a7fcee8a 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -47,6 +47,7 @@ properties:
               - sifive,u74
               - sifive,u74-mc
               - thead,c906
+              - thead,c908
               - thead,c910
               - thead,c920
           - const: riscv
-- 
2.43.0



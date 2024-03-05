Return-Path: <linux-kernel+bounces-92897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F098727BA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8B61C263CC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A660286644;
	Tue,  5 Mar 2024 19:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="SqSU8QFI"
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3A88664F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 19:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709667554; cv=none; b=sG9FoFOX+5eXAiITVFF0VYL6plbHlSp9Sckr07ZKdFyG5y8Ar3jqYX3ugrZT7X3TbES4h9PYsl539mzUtXNZ4flRD7kunw4BiAlk2+P3MXUR0lHEzkGdUc79AeSCeC5E5Tfz6LfC9iRj3BeyZZgETorqtal/M3Cax8oOOCjglok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709667554; c=relaxed/simple;
	bh=O7BvSwlYz5q/4vtoLO0hK6uwpygGTir//zkJjVtpwBM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=qTZn9p5YHHyPEynY6mAuOOSMlnocQbVvDxmwsToimEV5UiTRKcFN37aqlE5tACOkFncaRz18H+BDamIinfiIYp9JxHEcTo8Pe+/zaiSxcLgONBionwUjujl6eVB1kFoK7pOvGv/Cpp/+eJaax7pPcy5aB0EHSAV8qfbovjVJ+jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=SqSU8QFI; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709667543; bh=RRjix0llQAKkZ0Th8vUk4UX/Alg4KPw3+Xw8qybrfN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SqSU8QFIL9W7ZW+iDmSVSq13xgn3Mx/aGpkNNYeAQ/yhnUKbM1zdkj+8z7SJ2TxD3
	 b12ACg22BKhSpDiuJ2mDGLUCNLWSat4LazP5gAEKVP2gcsrGs0UFKrjOQRW7nNUrV3
	 OvXu+p9w/rnhwT35O+o7dkUaGBI04yjpyj+roaWE=
Received: from cyy-pc.lan ([240e:379:2267:e200:bd8:e8f9:fb59:de48])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 9B6B9246; Wed, 06 Mar 2024 03:38:54 +0800
X-QQ-mid: xmsmtpt1709667540thoirjwv6
Message-ID: <tencent_7DA0F188AF4130573BCD9106F738862DA405@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeie4OtLKJmFhfdwewlzjSHecvDggKwqR1CfOGM21ebqXl8dHq598K
	 +8fI4AjWA+pCGw3tuPpci7DcYAzcBtoxedHsBr+DAx/GBAcD4mJCBhoA99iwOu+uORe77yzvgpfe
	 QOU9OoF72SBofkwgdaVwTc1RImnsNGVP9tgygPwDF1k7+rzUXbaowOAV7QfBk95wfqzQ1AwvheSg
	 dQ2hRxrQUpW0iQSNclgAFPRghQe5shn3UNkPUoeJGuU6ErJ6L4xJEx8bXg4IsYpCECs7hEAgFmHw
	 geoX1jRom6ywkD5R6QyR+QmNRhxuwVha44JUvn7CQ/le7yJGBG1WwG8jj8qZg9v0BAcBi8DtTQuB
	 bQ1WyJBjDOkBh6mSFI9PbRRTTBnZg8m8n9UA4jPECDTKLB3tNAQCDwJgleQEEqHjYMFiUCKFPW+H
	 Fzb0406vYpJx3c4OshEpjIQhrxjyxF2U6G23f+KI1GtJoKmLJhF/tUH6bBToPWLHcDLRK9LjAFjG
	 hIrayCUzrcm3jceeJmbaFu+bE65Wa51x/X1JDdTwO7pswdPDqqhFmhYCdD3mUAI1iKIrkIB0OFVY
	 XX8oGRaBZLyWOt5f4Y7cDxZoSNbRfW9D6l/wINvZ0MG9z4E/zRYU7T9bYUBT4bifz3Z/X00WPwAM
	 VVjEJjDUkJuwHXbEH7+2Jp7VS+RO+Uu/7kKLt9aVbjO/2T8rkSyhLEsJh5RydH6Upl/si9m1T7U2
	 5gYpeCVYu7a+yNEqHOOOKiF30JonidkEhCmywIRPxufqz4SlUfPXvDIdrh2ohiPNV1BGF5ZWGnEn
	 nOZoFyMovB6/g3Qcrqm1MBHhGYrh9kEZtFvZZv8KiAYb67UugXPK7B6o/3yyWoe9pC47BCOd/kxN
	 e44PuSt+82MVM4fNXhaCYF74kHE51ItAuG7YyA4Nf/rJLbaOHAshBJBfe3QvZqFUn6Vz5GGRxiXd
	 Mveg1s7Q4dXFLfJVqiF11F9hFGYrPhVGEpD7CAr/zeLfquRvYAJsJNU1THA+8uCyvoZP9tszbZs3
	 WeD0BrlbkOl+D4YPkQXkx2h+tjF9Vlh3CU+3tGHTx2Ay7zhzdj
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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
	Yangyu Chen <cyy@cyyself.name>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v4 3/7] dt-bindings: timer: Add Canaan K230 CLINT
Date: Wed,  6 Mar 2024 03:38:27 +0800
X-OQ-MSGID: <20240305193831.1084556-3-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_587730262984A011834F42D0563BC6B10405@qq.com>
References: <tencent_587730262984A011834F42D0563BC6B10405@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible string for Canaan K230 CLINT.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index fced6f2d8ecb..06c67f20ad3c 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -38,6 +38,7 @@ properties:
       - items:
           - enum:
               - allwinner,sun20i-d1-clint
+              - canaan,k230-clint
               - sophgo,cv1800b-clint
               - sophgo,cv1812h-clint
               - thead,th1520-clint
-- 
2.43.0



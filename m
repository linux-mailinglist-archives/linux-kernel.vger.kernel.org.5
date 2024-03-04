Return-Path: <linux-kernel+bounces-91274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE21870C2A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55F68B24C77
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247457B3F9;
	Mon,  4 Mar 2024 21:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="MKolYSMf"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FA110A39
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 21:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709586399; cv=none; b=c42g4cqEy5me9oX98dRLL8rG5eMj47AxQPux2n6ngXLkUJmtXlD/76+/Rz7VrJJB40Kwh6VrLhb3+HYjEGQ1Ue6kL1oZjSERd9SxSLkaEXWXIBZzVznx3lhie9pyAB51ESpoJy8XIqOZICl/HzY4Al06DyTIhZp81f7e2FTYUlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709586399; c=relaxed/simple;
	bh=oW+Vnj7KYFUFVgVEUW7ziNbt+6eV2eZVqwbaiLa4SBo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=W3pzcQRkxOO74liAMhmNjW/I1KcUQaoEHYpyPimGNwUX7J2fi8fLea7tP0XD54gNtgja0EuDORSg0mL57RGbebb9y0rvgFNnues5z3oTfQe+SmK7Oj4xRIm2wCTrsV9PrumIqVmluIz8lUkJe/CVLoV4iPET+m2AU8Kera1F/qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=MKolYSMf; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709586393; bh=Ia1gwhGj9oMsY1Gs1EXwKmn33KXTNReSu7KithRz3og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MKolYSMfuWvCSONw9QBbRKNgqmIVwOfWER+LtoY+ZCRLBqS8xeuIpKF+lbH8HOIGx
	 WCGaN7bl5ARPfzZKnBnseCUOhVHCbzercU9cusV1oWVnub312j592oaj5iW4Zmc4iR
	 PUrsXAEp19KvMqaxNMXrvWt1+F4OsQMnfNLhsy1s=
Received: from cyy-pc.lan ([240e:379:2240:e500:994d:62ab:74a6:932b])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 1953A8D2; Tue, 05 Mar 2024 05:06:21 +0800
X-QQ-mid: xmsmtpt1709586391txwo4izeh
Message-ID: <tencent_1B1643401B7BF8EC04C3B5551D9D703B6209@qq.com>
X-QQ-XMAILINFO: NnA3IMNPwBd+jnu/wd3UFMXKkTt7bRLu27jCyfzHaPAh+rXFnucBn8PkW14VA8
	 w+0I7gpfGVUMGOHVgMNm455bPwP2TiksbGOfaeTi0kM+BzBH51a7ELUcYsdbRxl/1mlrDyc2UUj3
	 IvcJDtbeCHgI6rbsgdWVawm69P0M2Rm3DYSq5+1OkN9A/UlHLjdG5p0xepO2O7sS2dN5lOKyL95g
	 cW+SzFyau/PXuOuBmVkFCq2S83Bp34Sb5s/AJ7bXf3Ff/CbTKhQGCAXuzfgUYHxeUOGndiHGw8zB
	 4Z0vd8d8HI7h5k66TnX8yh8qdVA8Mf2NdxYVxQ99Eq21cH3v3K/ssexRIjZn/Tday/WFgAacQOg7
	 3HGh4FCk00NeSUb+CPEcgndE1LQ6gHlT3yRIQ3fY7gKcZqcj6nDj5Jdgzxf6HKgv+vaBgYHlz/CS
	 zbGlFEmUhsWuXiUaPMbi3RlLaGk+C4RtGP/UP3i3V/WOmMIX008yjScf3XNeLhzZXZmH7rhoJx6X
	 CBvi7ZzQkRTSSbW2oWeIZBfEA2Y9RSFK9bVC0YoO9MOiuNUYm4nPeX2Ozx5fA/DruUyJ7I7uaOPj
	 BhFNQvb86YY0PS55lGZOkqKEqnTYTwjE02t4hMG10Sokf758htzk3OCOHChBTZVxM4XzW9udSqv9
	 ntl4NYCeP+gCFIG3by5BrzN1CsbF0QgWsnNGoDNbVJ0BxYhXBS9/1SI1Y3KesJmMs8D7/wEzUudW
	 66d05rIlYOW5h6HRvUV1Luu8MLG01qoxoAc59bLI/fN0oSzHxXMlZWxvMH7AgDhxIfZFp64M9x4m
	 7r0/vO8Nq1H7mTv9W+8HN5u0YBAHsvV4z8Tz1rstfU7YcJXkRD76trtPNcaz/z3ncNo5q120Zhq6
	 nykW5TGx0PTKHThr9z5MxnSi3q9Zuz5aHfptHaDhrWzHG3qoh8D8UcY0rr4NMPcjPPUkRYG2Xkv0
	 bdzUdNrH79DrrpUTS7JRTv6lXepiPCTlImn4wsGWEsj+lSMXH9Q2MxjwrsU76pk0kMaHODV+2RJH
	 JzXgLJ56cc+7QXxn65wn82WPVXlrDpIzGS8PWODvOd73PnWbVc
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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
Subject: [PATCH v3 4/7] dt-bindings: interrupt-controller: Add Canaan K230 PLIC
Date: Tue,  5 Mar 2024 05:05:58 +0800
X-OQ-MSGID: <20240304210601.777883-4-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_BB2364BBF1812F4E304F7BDDD11E57356605@qq.com>
References: <tencent_BB2364BBF1812F4E304F7BDDD11E57356605@qq.com>
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
index 709b2211276b..122f9b7b3f52 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -65,6 +65,7 @@ properties:
       - items:
           - enum:
               - allwinner,sun20i-d1-plic
+              - canaan,k230-plic
               - sophgo,cv1800b-plic
               - sophgo,cv1812h-plic
               - sophgo,sg2042-plic
-- 
2.43.0



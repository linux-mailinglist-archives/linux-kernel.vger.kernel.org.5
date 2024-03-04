Return-Path: <linux-kernel+bounces-91275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5742A870C2B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF291F24066
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B4F7BB10;
	Mon,  4 Mar 2024 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ceaLihVg"
Received: from out203-205-251-36.mail.qq.com (out203-205-251-36.mail.qq.com [203.205.251.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865A110A2B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 21:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709586401; cv=none; b=kbDN3MNRldFHiifByvQc3OipX4/tT2tQWtFQYB+9+SLCKG8jp51oRqh0Ze3LksDjB9No1zQeAOo5Wg46QQGN/vM8k9+7Kx4FQRvRhzkCDEmhtKsP2rEuK8aKnrcpfqEv6NZXhlTkLlqK2hpcRSwBJPn/ZB/ibAIEbBP+rOUiNO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709586401; c=relaxed/simple;
	bh=weW5//40oIeSOmT3+nNyK1hV5Tfvi+28xWQO5yyRa2g=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=g9ri+f6zh9oIqvSzgNzUTa5/GER404YsUmAHUlTL08bMCr6Vj5Ztmzvf/QfjGSd7qtluQmK92zXfKjtoL0KglsUhszXmBf9OzoZnQEMV5ICKdVAsGGzUpSSWKMrQrRnk5/ILnZdK1EeAKwWGKzxZap+bLLvkafEiso+rSVRb9gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ceaLihVg; arc=none smtp.client-ip=203.205.251.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709586391; bh=pMaLts8PXA5REiyGeypCyU36YZO+RzJa569u2oVazis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ceaLihVg8y5mUsomMZbBLA+atCasT6619NzNq1ssi5djzsT0hmjbz8Lsa+bHQqcz+
	 ES454s55XjrlpsN1CBLN2VIHsl28yjzfjg+iNgqjrnYG6oNDAXAjtgrnKWsz3jaGcT
	 onDQZsGyjpleE2iZU26+qHGsCNcO1Q+hbzUhjbNo=
Received: from cyy-pc.lan ([240e:379:2240:e500:994d:62ab:74a6:932b])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 1953A8D2; Tue, 05 Mar 2024 05:06:21 +0800
X-QQ-mid: xmsmtpt1709586389tfhvjy0km
Message-ID: <tencent_CC6884F036B6F3D50A6269733BEAE226C40A@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntujUM20gunPaMedHkDBepcC8+uwF0oYczOXSdekrAihPwKwaTG3s3
	 WmSohxDN6+V0rQGtpzybTDviWfbbJqiJqLjvmYxKpSP8dWGRDhGwmZKFpeY+UcsR3S5k2HY1bu/v
	 rwsxzQuLj7RjbBSD/bVBnOZriqSFsse/K/2IlVILbvVr9OQjwcfrilAY3CQk2G8eZnlDVjwK3eeK
	 eaz7cy1Uw0lyDu7I/gQramQlatjcshUnERa9W1Inbx8kB6eEhEQvhzlBzCALzfu1eaIlFti83/hX
	 chC1CscEVeWmvEtmFK/kYHkg9RcOQyZb7Oo7P2FIFtEECJ06cQ3jr7PalIkv94y7cTRJeEcdqXDK
	 zrOmtn0ZuvORy3xN9w9OqLXRXzQx9TxHkgAvt08fNrFGqb+UkbVxTqly9IYWoocj5sVa05eCqbkN
	 Ubh1dKEHqF2u8gFSx6xOXCiwo47mPIlnMvcNawoAc7xq6P/xydXespiO+ObcvvwjO4TWAqwSREGA
	 Lrxi/UOB9Jh3NV73emoTB0WlRVDc5LpeCZlyVGnhzMqc4TtR9Tgzozgxjw/bDMb0CaFQYF7UOO9v
	 lCA7jOySVlyIbgH5uRcg1IzZ5WMV2vMiWmPuTwlCIpy/HFY/s97W1AFPUOrfBkP6JkFqg66B4TqZ
	 kEPaQnP7yax7ps3zT0jdrlrFg7yhW2ydpWmWhk5zKUDnnfBVEWk17Khm4a1S37kawK60X9toWLU/
	 Q8MyHUMLtYn894lwUDhv7u049CbXtpITq4sgv7osPfi4y4fxHLpek3Skoxaau9g7FfpKVFsUUGp8
	 faUaYou4e8pC/D8C+ZmbAyMgYsok6P/2xkgklWWUMnjz2ARBP8C2iEc/TWaI9ILAIeJWgtNFgr4f
	 jISb10vTSuqGK57GRy7jZVOSltJ/uNRrw7tZf1OQ8SpHTYLhnKYKqk4sPCEYIcHrvHKDKw5fk9mk
	 wseMuPwo4JF9CwU4Rnjj3LdIxv4F31IvExtgH3wqeucztDHo9sQt3V10YZZC8CXbbzsj0fzPNYH3
	 qa3Bn1UyH5oTJt38VUa2GSgv0KVVvgUPdW3jrnoXHB7HXaIFhZ
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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
Subject: [PATCH v3 3/7] dt-bindings: timer: Add Canaan K230 CLINT
Date: Tue,  5 Mar 2024 05:05:57 +0800
X-OQ-MSGID: <20240304210601.777883-3-cyy@cyyself.name>
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

Add compatible string for Canaan K230 CLINT.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
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




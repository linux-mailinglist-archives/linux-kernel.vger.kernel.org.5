Return-Path: <linux-kernel+bounces-92928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1726872841
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE2EB28E204
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B4312AACD;
	Tue,  5 Mar 2024 20:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="IizAeKiJ"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7640412A152
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 20:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709669005; cv=none; b=ZTTNoHaw1a/iwN58S9GJfg369B2IexUtZFLgBTw+RMEJ58T3sdOCtpzsQ9b5DTVJt5SLP4V2FWaNHd14bwpa5HODW9/HkbEQCCDZ8qIG+czZ1AIa7DgTjE2NdZTYyUIK6sRCXVdN7s9hJHxNIPGX0Z6a3u5Qo5ly9LJwtOXNdBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709669005; c=relaxed/simple;
	bh=QRLQxeqsECyJ6uun0xKaJizzaw8Pb5i5/HMBcCU6mS0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=TPzpccNt1qCITHLGiQ7vVrqc+RjzRZDbVpjpAaxhXONsiHZGUsgKQGH/pinLpAIO7Orx4de3nw7t8q+LlYJXoSyJAuHm+z2j8YH68t5my6Vr8uS/WGrs+HJjbXrhpqIbzZQcI/O7iuOSNQMqpJJD7ymSB2vJz1BpfiZBO2WIXJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=IizAeKiJ; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709668994; bh=kvuS7K0wl30nwl4M5zznAdLvDfFhfeZr9JFWkFZyoG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IizAeKiJZElcZvRpGUkgHE+zJ7hYWr5C4HA2xC1OY0DtfFv5G5e/M6BQI/3zUU43a
	 RPC28T7QU9iP5Yd8HnYur9Yei2nD3lDRemeHJWsmyUJ8moQcNDjAr5DXP48KIxwos6
	 5oCIHtI7WITFZR/YEfOm/t5ZHFkvD8tyqzMw2qeI=
Received: from cyy-pc.lan ([240e:379:2267:e200:bd8:e8f9:fb59:de48])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id C898283; Wed, 06 Mar 2024 04:03:08 +0800
X-QQ-mid: xmsmtpt1709668991t51dbf17e
Message-ID: <tencent_71D182BEDAFB8E18B8A731AD21528D647C08@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85Nocr6fbMh4xTQw3mSzIOZrRGAfu421uLuIFWnEw2MuWI/sjuKaT+
	 eVaLjbMXc0z6hy7cZlDvhhVhMmj7KynZ1YO3uFRRFdGTNQW35W9NoCBf5wx08YqeqFGm+dgt/pgY
	 r7dq+N6ClD9OXPdqNxYDDKYk5anIuyjokGIIt0F0SEkamumhT+lXvvDDjfFFpU3nGlskEivrniZz
	 eOWtxJ8d7sJYOGnzbdTHa/qehRnLh3UutnFPRUMMutzhsw8PkWEWioFI7LEeYLU7Lmr6CBMHblVk
	 Ga03nyjpoVSn2PJc+xFrLSw4wh1KSwXNL+e6Ou9sdVV+inMS1vUby0W9hMIRO6nyZNOKLv9vhbNy
	 HD4IkXgp8P7/bPwCutZ4APOSsGktn9yPMgTs4zWgIBWpRofaWGyIazs3LYVgpjJsatwKNxYh0jGk
	 mJi0tXoJRXmnvS5wsXeu+l1c7inKY4yXHJ38D699t1n9/bu/rk7I67ssYAtfAurRAwJslyuQxyjC
	 /DNyCK0Y3cqmxIt+/5p7102oeIY2I6NpDNcOtoJJoqxjAGspZ0RgcQnseH/rfe9n5Svh/Wg7HSQ5
	 g1z/yzD6ZV2z6pAB4WrAn6il0StW34dfREtdOaTfNilCGy0AwVAULmgydvFtj2/kw1Jtcke9VEYF
	 EsNGytVlV5rVFY4/WYnMWEDJEQB57DpZo56/S+Z7gjVqU7fMIv8v5kvz8eJr+YAy51f4Gw4A9cyv
	 I5vWCGX1aIhOFmr7x0AbQeMZFPfNTv4FFJqkVt7hMOqOswTi5rbpom41c2T5/vQd2nnmK8fTgWdR
	 LfY9nuH+Lao0K4pMpBTJYNn5p4W0dmvMOmKZjI76r3On828EuXrfeonX4LWO7A5JzL35P+7MerJt
	 lfP8wwMkxm0pUtIwl2UanU28lzCIewXzavi2jEAyZkecktmenCTE0g/gkwupbglfoSH1ISmRUZKc
	 QZnhhOhxmRmoAk7YujxEDUCc5fCPTjbObM+yDRE7wYMVQJlMkRUA1NQ73VtcSMakbNiQrCKXvKyq
	 4U7dbtIee4BnaieJvLEFIQA8mC75CynB9lpKBBSvggCS/npp+BQt31T6BoZrFo3ME42iyjZw==
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
	Yangyu Chen <cyy@cyyself.name>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 2/7] dt-bindings: add Canaan K230 boards compatible strings
Date: Wed,  6 Mar 2024 04:02:57 +0800
X-OQ-MSGID: <20240305200302.1093082-2-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_FC10B3C630BE27412FED2547245CBE18D807@qq.com>
References: <tencent_FC10B3C630BE27412FED2547245CBE18D807@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since K230 was released, K210 is no longer the only SoC in the Kendryte
series, so remove the K210 string from the description. Also, add two
boards based on k230 to compatible strings to allow them to be used in the
dt.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 Documentation/devicetree/bindings/riscv/canaan.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/riscv/canaan.yaml b/Documentation/devicetree/bindings/riscv/canaan.yaml
index 41fd11f70a49..f9854ff43ac6 100644
--- a/Documentation/devicetree/bindings/riscv/canaan.yaml
+++ b/Documentation/devicetree/bindings/riscv/canaan.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Damien Le Moal <dlemoal@kernel.org>
 
 description:
-  Canaan Kendryte K210 SoC-based boards
+  Canaan Kendryte SoC-based boards
 
 properties:
   $nodename:
@@ -42,6 +42,12 @@ properties:
       - items:
           - const: canaan,kendryte-k210
 
+      - items:
+          - enum:
+              - canaan,canmv-k230
+              - canaan,k230-usip-lp3-evb
+          - const: canaan,kendryte-k230
+
 additionalProperties: true
 
 ...
-- 
2.43.0



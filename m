Return-Path: <linux-kernel+bounces-2218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8568159C3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 15:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 755D71C21828
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 14:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D462E3F8;
	Sat, 16 Dec 2023 14:13:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0712D797;
	Sat, 16 Dec 2023 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 304B024DB83;
	Sat, 16 Dec 2023 22:12:51 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 16 Dec
 2023 22:12:51 +0800
Received: from ubuntu.localdomain (161.142.156.108) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 16 Dec
 2023 22:12:46 +0800
From: Jia Jie Ho <jiajie.ho@starfivetech.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
	<davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] crypto: starfive: Add support for JH8100
Date: Sat, 16 Dec 2023 22:12:29 +0800
Message-ID: <20231216141234.417498-1-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

This patch series add driver support for StarFive JH8100 SoC crypto
engine. Patch 1 adds compatible for jh8100 to dt-bindings. Patch 2 and 3
updates current driver dma usage for compatibility with different device
variants. Patch 4 and 5 adds new sm3 and sm4 algo support to device
driver.

Jia Jie Ho (5):
  dt-bindings: crypto: starfive: Add jh8100 compatible string
  crypto: starfive: Update hash dma usage
  crypto: starfive: Use dma for aes requests
  crypto: starfive: Add sm3 support for JH8100
  crypto: starfive: Add sm4 support for JH8100

 .../crypto/starfive,jh7110-crypto.yaml        |    6 +-
 drivers/crypto/starfive/Kconfig               |   28 +
 drivers/crypto/starfive/Makefile              |    3 +
 drivers/crypto/starfive/jh7110-aes.c          |  583 ++++++---
 drivers/crypto/starfive/jh7110-cryp.c         |   65 +-
 drivers/crypto/starfive/jh7110-cryp.h         |  102 +-
 drivers/crypto/starfive/jh7110-hash.c         |  275 ++--
 drivers/crypto/starfive/jh8100-sm3.c          |  532 ++++++++
 drivers/crypto/starfive/jh8100-sm4.c          | 1107 +++++++++++++++++
 9 files changed, 2327 insertions(+), 374 deletions(-)
 create mode 100644 drivers/crypto/starfive/jh8100-sm3.c
 create mode 100644 drivers/crypto/starfive/jh8100-sm4.c

--=20
2.34.1



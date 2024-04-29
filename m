Return-Path: <linux-kernel+bounces-161636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 422068B4EE7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 02:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E34281238
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E598F5D;
	Mon, 29 Apr 2024 00:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcABOnQw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445B18BE7;
	Mon, 29 Apr 2024 00:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714350413; cv=none; b=J7uDxlNQqpGRSVxxogRiUz4v8d1fcFFMESdQ+qo3JdqUHi5HjyEXecRfzncdO6W/EtniAd6Lw9nUdOPhcgO/A/M96OPHSxnYrb3b3slZH5RmVDLQfH0xJg0M0hCI5nmqICSlFpQr7U5I8gdBxuwIVop5tVIo1dGFYjIvj84mzAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714350413; c=relaxed/simple;
	bh=JV9sARz8mXFB1oPD9Q4pwlzsDwDsirXQg0InRkhTXdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vst3xBsMD1ou8UV0mzDFs8yLFklCTe6Q3pKxt7PEBGIJvV6R02PFrD5GQl9oWWmXpD2TENWrO1XCHhvlh/Q3ZxXadvzJeX0RchJvOByJWWKeOk7VdDIKEc0AaOHTswerHCqVFtEnKklgE4Bug9SWP5nmYTcZIEBGLqUdwwW/fsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcABOnQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D26AC4AF1B;
	Mon, 29 Apr 2024 00:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714350412;
	bh=JV9sARz8mXFB1oPD9Q4pwlzsDwDsirXQg0InRkhTXdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZcABOnQw04CLdm4lLPfwclk96h+C/SU8r0D3oYtTi4FuVrKwidES13DjGjymF3rml
	 THUqm0veDndSNbRipgGjxF/Xa+v1tdcghJD+zhPT8Xoo9T3rMSmJQhZJKWmwWqcgkR
	 L3Toqg36ARKie/6XxygT71tBabWIbWTVmuCASoNYSOmuH31yZO0l6P5ISJVtYl9Sqz
	 tOB2XXU1pYZ8tDe7eUi6KQkzH2qxbGJA3L9f0RvwSejYC18PJdXIkD/7f0m4zkA0bp
	 OZkc9rFRoIHmeP+Wi+waCRtdi8nmPPIN10CeP1pnQNcJ3pc8lWnxE0Wzs2weQH/F9i
	 Tuz6dLZnUDyQw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Emil Renner Berthing <kernel@esmil.dk>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: [PATCH v4 2/8] dt-bindings: riscv: starfive: add Milkv Mars board
Date: Mon, 29 Apr 2024 08:13:11 +0800
Message-ID: <20240429001317.432-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429001317.432-1-jszhang@kernel.org>
References: <20240429001317.432-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree bindings for the Milkv Mars board which is
equipped with StarFive JH7110 SoC.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 Documentation/devicetree/bindings/riscv/starfive.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Documentation/devicetree/bindings/riscv/starfive.yaml
index cc4d92f0a1bf..b672f8521949 100644
--- a/Documentation/devicetree/bindings/riscv/starfive.yaml
+++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
@@ -26,6 +26,7 @@ properties:
 
       - items:
           - enum:
+              - milkv,mars
               - starfive,visionfive-2-v1.2a
               - starfive,visionfive-2-v1.3b
           - const: starfive,jh7110
-- 
2.43.0



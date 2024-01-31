Return-Path: <linux-kernel+bounces-46512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B21B18440CA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E941F24F2E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA4D7F493;
	Wed, 31 Jan 2024 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9lWHjWB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC69380C1A;
	Wed, 31 Jan 2024 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708337; cv=none; b=gv+w2pFRJraI7gIAznv5nNmqK/3qEfxCcDPO9bPr6JRB4+iTQQH6dF0R5S5gV50jL4fjiJE8/5qQ/mP7gB9/92an2jKZb/J3e0TZRPNy3c7p1nrSnHoGDvCf2a1IRTnludLrdMuVOuynbBx5Ub/h3PKBiQT5SiNft3TbeFHTzqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708337; c=relaxed/simple;
	bh=4YaSmKc2XhAaRmO9Ia1dq+Ad5ogssm1YjCUlZHMFidw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEIkH5wyXavPlNqpJhssOrRJfIMd7qZlnzp2GVXaHS5/rbIyaoRyrOxCAKmd2y+gOPvivDTRwpg6ngy6QE61vXHQMu20RTO0487ZspGQE/NAa7pE90o9uxDH9K9U0J/Li1jB1+pnDz50jHT/2GqKGXIDBw+A4cmVOH52qZwPw78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9lWHjWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AAAC43399;
	Wed, 31 Jan 2024 13:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706708337;
	bh=4YaSmKc2XhAaRmO9Ia1dq+Ad5ogssm1YjCUlZHMFidw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O9lWHjWBEh5lZC5/FLgavIirpXAEYvJWVooFyf41aWm901/r3fyHaK6P3gSOXrN7e
	 cahqDWswIWtoK8TbVuneFC7wwrnrV7KqcWOVVfo7z4SASPMowTIZwdMLeoVWQNoPg2
	 WHO8ZGSbGgwyOJNdJlXzDfnXEWmnZ7Shl+hQ7eUwIYkWL7oOESZBfsz3DK9On0ljPn
	 PP4V1r0uAh8dA1m5qmXWSjtgzX49EYmFpE+4Qt87eRY+50bFerqXBWnIU3hy39iU2q
	 2i2eXDdAM9yKtB3JGZAl9/UTCLPk1bgqTmfLzY/jlghqGzRc96ecUhpwRjovgfzpUb
	 Tv+sEyPfjuG2w==
From: Jisheng Zhang <jszhang@kernel.org>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Emil Renner Berthing <kernel@esmil.dk>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/6] dt-bindings: riscv: starfive: add Milkv Mars board
Date: Wed, 31 Jan 2024 21:25:56 +0800
Message-ID: <20240131132600.4067-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131132600.4067-1-jszhang@kernel.org>
References: <20240131132600.4067-1-jszhang@kernel.org>
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



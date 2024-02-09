Return-Path: <linux-kernel+bounces-59036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FACF84F032
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A3C31F25187
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5F157885;
	Fri,  9 Feb 2024 06:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ml0o+mxK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC28E57300;
	Fri,  9 Feb 2024 06:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707459796; cv=none; b=B+p7JQuKxyTK7wSeEUhOKANEdBTTKHx4odqmDHdpxd91SSIuiQpQmw090bwB1dnhZLM9KBIc/51T++g1sdOn9D3dPeq65zB8mY5/NYCeaqfKWj5w5/rCcFfvo0DqS0cQ1hEkJ2J3yEeScervVSk+r4JDnYu2LogxVVWFF3ow03E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707459796; c=relaxed/simple;
	bh=S5QTvUq6sE9Cp1C8VwuWZA/YXB1LZbFmxjhmWirs68s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ts/YrmMn/U8wGOM0UKQPLJeDCdgS/2J/RP6AO97k4TTYD4gTSNHQ0gYB3rKZ1qcGTMzfEh7eK4M5IuzdmNfpVEhMCyJqqCwEOVi2BHtMEULOpW9dRERwLEn3kxF1sqVn6D88mUdEEKWlpC+OwXNSVcqnu+EeDGQAg6Xzg7jN7bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ml0o+mxK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B762C43390;
	Fri,  9 Feb 2024 06:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707459796;
	bh=S5QTvUq6sE9Cp1C8VwuWZA/YXB1LZbFmxjhmWirs68s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ml0o+mxKk9MSlKVF04FEo+v2cT7c01rbMvj+JLhCZsAjGU4m8dmwJIclZo6Nsjyeh
	 CH1tGQkBze/bDM6/NfpBvZFrULLYdLkRFaEGkp7hcA7f0r99AQZsMOABTueHEzlOpu
	 bcXCLbZcjVZ74VR2RZ8WMuXrJ0G6tLfKh+NzI0XTO7QKpOI8BflBauWFhjPUj3sRuU
	 1QYEnb7F0OQfoJw5qHFfAIeZ/gAi7hR7ZWoEESZT3ffttUwUKqCOX/88xkoIgo0gS7
	 e+Gvhj4o3NC1F4BTp0chh03Q5kedeNrhWeBDIWLd/DGiUrxj0sPF6UWhWMMJDRlhka
	 5uiEb0E+MpQIw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACD8C4828F;
	Fri,  9 Feb 2024 06:23:16 +0000 (UTC)
From: Christoph Winklhofer via B4 Relay
 <devnull+cj.winklhofer.gmail.com@kernel.org>
Date: Fri, 09 Feb 2024 07:22:37 +0100
Subject: [PATCH v6 1/3] dt-bindings: serial: allow onewire as child node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-w1-uart-v6-1-3e753c149196@gmail.com>
References: <20240209-w1-uart-v6-0-3e753c149196@gmail.com>
In-Reply-To: <20240209-w1-uart-v6-0-3e753c149196@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Christoph Winklhofer <cj.winklhofer@gmail.com>, 
 Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707459793; l=868;
 i=cj.winklhofer@gmail.com; s=20240104; h=from:subject:message-id;
 bh=f5JrNqSq+DhQN/cCXZvlLdSNxNweO7or4GNetVHb2s4=;
 b=i8nJeuGuspoRflRfsdAvwXwHC6q3tS8FQ/gCfqsWKHyQLg1nXRc0Y/yiXb4KYxkuo6oZ8QYuP
 CpbSwlzBOFsAMsB3OQttNwgWA02rBgI7Qj1l+ju9rG7ixylpxbIrgt0
X-Developer-Key: i=cj.winklhofer@gmail.com; a=ed25519;
 pk=lgjGjOt7hFKJT9UXhgUyrdthxvZ7DJ5F1U/7d9qdAsk=
X-Endpoint-Received:
 by B4 Relay for cj.winklhofer@gmail.com/20240104 with auth_id=111
X-Original-From: Christoph Winklhofer <cj.winklhofer@gmail.com>
Reply-To: <cj.winklhofer@gmail.com>

From: Christoph Winklhofer <cj.winklhofer@gmail.com>

The UART 1-Wire bus utilizes the Serial Device Bus to create the 1-wire
timing patterns.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Christoph Winklhofer <cj.winklhofer@gmail.com>
---
 Documentation/devicetree/bindings/serial/serial.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/serial.yaml b/Documentation/devicetree/bindings/serial/serial.yaml
index 65804ca274ae..ffc9198ae214 100644
--- a/Documentation/devicetree/bindings/serial/serial.yaml
+++ b/Documentation/devicetree/bindings/serial/serial.yaml
@@ -88,7 +88,7 @@ properties:
       TX FIFO threshold configuration (in bytes).
 
 patternProperties:
-  "^(bluetooth|bluetooth-gnss|gnss|gps|mcu)$":
+  "^(bluetooth|bluetooth-gnss|gnss|gps|mcu|onewire)$":
     if:
       type: object
     then:

-- 
2.43.0



Return-Path: <linux-kernel+bounces-126589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C61893A14
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ED391F22222
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220D617564;
	Mon,  1 Apr 2024 10:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxFxLN3o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F79612E5E;
	Mon,  1 Apr 2024 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711966255; cv=none; b=JUWHz/XSYjq8/IOuzG6vGMnp7SCdK0jxPFt58FYDjMbi7+NJSKGCpTtrGNtUr1NB2DULXh62spTzbrSSFllCocyzVZDZHmxgY4lJ5r1y7R81K3OFWuCaItwTjCcmHhfXE8pEWFxioOpXAJC81CBYPldrZ+V0wIhYnIzigSUn1Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711966255; c=relaxed/simple;
	bh=87vxEiXK4Bw7uWercX7BECQUi8vL2f8Pu9x/4eHktak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eMDXXj1o0dUWeD6iZz5pYfmLXmg0UIy8onkoZUhvUGBQZEABKwquNrZAjdwH6xivTpp9CpCFtigP0GahIhtqYruQ0jpyCSytOh8hu+F1xlA0twU3XPnWfP4zFu6x0+ipQ+gTWGzEmzGc4q5IUaoAzl33azu4Ugu/Lr0k5uWdIP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxFxLN3o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D079FC433C7;
	Mon,  1 Apr 2024 10:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711966254;
	bh=87vxEiXK4Bw7uWercX7BECQUi8vL2f8Pu9x/4eHktak=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lxFxLN3oGf0q9tbkirgIInupoQhqNN8zrXBxT7onNhhp3PREXnr5gP9xZ2ZdJc0gb
	 GSnTx1wcpi6U9RRgLIfzCGpqNsXmZk7e6EhlQOHWINVYO25dsds1FoAtUE9cQaj8v4
	 TZUaHCFZU46N8MGf1f64YtY964ey7nZgfVnwf88pw7WBcOzGZtSion8R/z+Bq1HmGK
	 gQVntk4zcTIRTr4ZnlsOW3AOfPQgOQe2YCj/tD7goWYXnCyzd7xpaarTLf4KaTh8hV
	 4Ltr1v4K79AqJ0UNNpTJYcqwe8J8Hu2JZH0OZL24G/ex4EBzuY9fGwv8RgZuYXHZNK
	 mC4AHcIivPTPA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6D1CD1283;
	Mon,  1 Apr 2024 10:10:54 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Mon, 01 Apr 2024 18:10:49 +0800
Subject: [PATCH v3 1/5] dt-bindings: arm: amlogic: add A4 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-basic_dt-v3-1-cb29ae1c16da@amlogic.com>
References: <20240401-basic_dt-v3-0-cb29ae1c16da@amlogic.com>
In-Reply-To: <20240401-basic_dt-v3-0-cb29ae1c16da@amlogic.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-serial@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711966252; l=1029;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=qwPgdDWTmKejFsU6gaw/3XWYRmAsFuyvj2aPVFS4Wuo=;
 b=wphnuoooDrs+q+UVo1L5BE8A2WRQO5j1/LdinYam5CbywNyb9vcUwaME0qWhaFFCR1Wh0T5mL
 KWdkemYxCsABqjueasGGU48Gc2eJAWToeyYYQrponOeL8KDFPyaed0L
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Document the new A4 SoC/board device tree bindings.

Amlogic A4 is an application processor designed for smart audio
and IoT applications.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 949537cea6be..520975e7cac0 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -201,6 +201,12 @@ properties:
               - amlogic,ad402
           - const: amlogic,a1
 
+      - description: Boards with the Amlogic A4 A113L2 SoC
+        items:
+          - enum:
+              - amlogic,ba400
+          - const: amlogic,a4
+
       - description: Boards with the Amlogic C3 C302X/C308L SoC
         items:
           - enum:

-- 
2.37.1




Return-Path: <linux-kernel+bounces-126587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A419D893A12
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F030B218A3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6C1171C9;
	Mon,  1 Apr 2024 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWOh7MzS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D71012E51;
	Mon,  1 Apr 2024 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711966255; cv=none; b=HNA1tj/q/yOz1HW6xDFzKESA/qCXC85/qdCZ6FoqNJRpA3lDniCT1bgRtLLq6GlwLi24VYi6ljVA1wnugAUDW0kqq/vlahk/xVkmvQVicYIK3NJ4BS/S44/ttf3xj3+CoJYjS+VxttLtYarQMTVsa8AMbzdwDB8HBu2Sl0S7Zno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711966255; c=relaxed/simple;
	bh=BlBJpiUv7aUmAuFYUdvRYginZ8mbbvQ7MHOWOPOYjTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JNGs6mYPmEBjIzBkCM9z6tcG8XGdjL9LLvu4JjuYtxz7X3vgiiukCsrSc7G5R8YbRxjELMPT1okIpBwOvfOU8cFcKY8raEAxFdPkuW5gaaLELs6Rc2RWLXlTJWd7Yf4VFXo/q+nkA30HpnaWFcJMxpqHC1BWDz7SW7VDHgHWyyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWOh7MzS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDFB0C433B1;
	Mon,  1 Apr 2024 10:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711966255;
	bh=BlBJpiUv7aUmAuFYUdvRYginZ8mbbvQ7MHOWOPOYjTM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rWOh7MzSja3Tv/nIkmXomxahTuXKF0z28xJ1UjSSC6Myrd78ZwCptLzhg1yszT9W2
	 5TlWDTV5bfTLYSIhV2yE3cyH/6Liiann71hkRcmafVhianLGdk27nVsdIIjdAcl0HZ
	 yKvs/9AbM0k6JEGlKIgaWBT1EExijooUSbSPD/fnS0EIoXQk8gHhFRByYWgomVZi3u
	 DKqzl2GIrD3W0fVCf1aioxwIR7oeXMVopCHKIRsdbEbHHOBu0D3/WWIX28pOytIa1T
	 SxFqG8Iqqv/2/R5kEsNLTuyQxkVLOCpvhf9F0tDPqQGvHIiFnzxHfJJuXWYTyW80qi
	 XKi7d11CsAsjg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCE8CD1294;
	Mon,  1 Apr 2024 10:10:54 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Mon, 01 Apr 2024 18:10:51 +0800
Subject: [PATCH v3 3/5] dt-bindings: serial: amlogic,meson-uart: Add
 compatible string for A4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-basic_dt-v3-3-cb29ae1c16da@amlogic.com>
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
 linux-serial@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711966253; l=1045;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=BoOg9oQGXAIVipNRqINyIKrEQRpu4JFfXxioyfv5GFo=;
 b=mZ+9Ep9WWQoTg3a/P02KSgdMBd1++x66NLZBVFzDPu+9hcHs0xLkwundg7BoZB9L42CWB88kJ
 IJIMFTOpNA0AqAFgMZslQiz9dJNHfYcjr9+2kgNGridt4qlPuRqOT25
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Amlogic A4 SoCs uses the same UART controller as S4 SoCs and G12A.
There is no need for an extra compatible line in the driver, but
add A4 compatible line for documentation.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
index 2e189e548327..0565fb7649c5 100644
--- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
@@ -54,7 +54,9 @@ properties:
           - const: amlogic,meson-gx-uart
       - description: UART controller on S4 compatible SoCs
         items:
-          - const: amlogic,t7-uart
+          - enum:
+              - amlogic,a4-uart
+              - amlogic,t7-uart
           - const: amlogic,meson-s4-uart
 
   reg:

-- 
2.37.1




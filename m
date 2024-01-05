Return-Path: <linux-kernel+bounces-17600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC1D825001
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926621C214D8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F00A24B4D;
	Fri,  5 Jan 2024 08:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcFuCEyh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BB121A12;
	Fri,  5 Jan 2024 08:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D7BBC43391;
	Fri,  5 Jan 2024 08:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704443225;
	bh=71uc0hK9NDOdEhHgFTZarT58L7adnWBofG0Y0tpQY4Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NcFuCEyh+prk2fzKt+wDxEd4g9CaqT+SUEmJN6lIgMXxBfamoBotw7SWeFr/qT1qz
	 zoWoWDG8AYA2oo9XA+6mCm3PNxF1xrX7QglLDOVrDneumceTdK/W/3ikMRFeDIhPgK
	 DqOLgVenomd/xYaRsi7LUwrHL3ya3DMk20p5TwXXmr8g/9b8p+UmYLz+9+WE53lXkl
	 LdxOEzTIv4y8MBU29uTsTP0t0t+EvxjGUnJ8YVdhUZyu4hd73l6RXGV8+VlmUS9xrF
	 tZNqGTkJT2OP/Nx3CN5SokCKJpPqF50XyfPo2bHDB4iQYHxRFbq5vUAwAI2agd2Dh1
	 +3kx3auLxtAPQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CE4C3DA6E;
	Fri,  5 Jan 2024 08:27:05 +0000 (UTC)
From: Christoph Winklhofer via B4 Relay
 <devnull+cj.winklhofer.gmail.com@kernel.org>
Date: Fri, 05 Jan 2024 09:26:43 +0100
Subject: [PATCH v3 2/3] dt-bindings: serial: allow onewire as child node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240105-w1-uart-v3-2-8687093b2e76@gmail.com>
References: <20240105-w1-uart-v3-0-8687093b2e76@gmail.com>
In-Reply-To: <20240105-w1-uart-v3-0-8687093b2e76@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704443222; l=827;
 i=cj.winklhofer@gmail.com; s=20240104; h=from:subject:message-id;
 bh=BPcWb7esDB40/mUZFKo7VPDltCBO7/vmdkKQuHI4X3c=;
 b=ay2ffRxDQFeORRmb/dFUU1+2tmYdubWI25/2dywCsok6JsxpAOUY/+GGh2vft0EDpfYIOh9CZ
 BrLamM8Za7rBjBIbMVgBG0MBgYYvd6Pdyqxpvz1QltICXRCtXrP9SU1
X-Developer-Key: i=cj.winklhofer@gmail.com; a=ed25519;
 pk=lgjGjOt7hFKJT9UXhgUyrdthxvZ7DJ5F1U/7d9qdAsk=
X-Endpoint-Received:
 by B4 Relay for cj.winklhofer@gmail.com/20240104 with auth_id=111
X-Original-From: Christoph Winklhofer <cj.winklhofer@gmail.com>
Reply-To: <cj.winklhofer@gmail.com>

From: Christoph Winklhofer <cj.winklhofer@gmail.com>

The UART 1-Wire bus utilizes the Serial Device Bus to create the 1-wire
timing patterns.

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



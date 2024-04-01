Return-Path: <linux-kernel+bounces-127086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E14D4894691
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E56D1C21881
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8155789E;
	Mon,  1 Apr 2024 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpC6pCTP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E1654FAC;
	Mon,  1 Apr 2024 21:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712006655; cv=none; b=gnL0fpOR5tslnqjhxQbAdBJU+jGm+4I6n4lzW0vOkeczvIAsdPs/jjIz1sCWKXi0cxRMO5lVntBFpS06FV9E6KN96crg6bnjw7qRmOG51o8Tg9DsGFFZ0PrIlcguCfnZje3nSe42tNEQ/PYwPISHgcPrv1yb7YIT/3YmaLT1Io8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712006655; c=relaxed/simple;
	bh=JvZ9DjATerhrdZXHJcR5iNqmcuYJoWGExgpd7+c6UhM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ovJE1wQgLQ8roWTbiq4ANJuKooTxfU9QqYymUHodRdCctST6BDYn2E4jvK0ZQjy71gmoEvYcxe7wPKwVmItkyh4jGirWqi/WG1giRmTzIhe5fxBvGr26WsArYobxOuSmJfvEPTd9hQRmIMLVgJwdiGujYeIHIjg4U2bGw4np9EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpC6pCTP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7D01C433F1;
	Mon,  1 Apr 2024 21:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712006654;
	bh=JvZ9DjATerhrdZXHJcR5iNqmcuYJoWGExgpd7+c6UhM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=EpC6pCTP/4yn8SsPctg6qvbKEvmTz3dFwiMhjTjvZ0FiEqFF4zeoyxn4tmhJ6O6Ro
	 YXHkYqTs+PuzgL4ZZfv7ipdnVnBnJeMxTXbiJ4UF6a44M7KUAe8Hmb4prTKU8nmHUo
	 U9oBRSDeILQgnCZJNFkJAqYXPRzzYjUL4cL+3rqp7mKyrZqcEcLHNpJzkzRztWYO5C
	 MEwoKc/IEx4VsGjL+8m24mJDmmZ5EgFeTW8Jpnr3yvpqt3/8LPgdECVEaDYdbtVlLN
	 LjfNAZRyQKur93gwm8YWCBIgb+dwCZWjtYoRjXG6IwAZryBBba5nIBDAvjXo9G4KRB
	 gQx3jY7P9i62A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91971CD1294;
	Mon,  1 Apr 2024 21:24:14 +0000 (UTC)
From: =?utf-8?q?Andr=C3=A9_Apitzsch_via_B4_Relay?= <devnull+git.apitzsch.eu@kernel.org>
Subject: [PATCH v2 0/3] Add sy7802 flash led driver
Date: Mon, 01 Apr 2024 23:23:54 +0200
Message-Id: <20240401-sy7802-v2-0-1138190a7448@apitzsch.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOolC2YC/zXMQQ6DIBCF4auYWZcGR9Cmq96jcYEIZTZqGEtqD
 XcvNXH5v7x8O7CL5Bju1Q7RJWKapxJ4qcAGM72coLE0oEQlG9SCt+4mUXglvW29bjVqKOclOk+
 fA3r2pQPxOsftcFP9X0+iO4lUCynGoVNmaNAb4x9mofXLNlzdG/qc8w897YTOngAAAA==
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <keescook@chromium.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712006653; l=1363;
 i=git@apitzsch.eu; s=20240325; h=from:subject:message-id;
 bh=JvZ9DjATerhrdZXHJcR5iNqmcuYJoWGExgpd7+c6UhM=;
 b=CsSah5WnQVUtjNjrlw5gu4Gao8S8QY2nMFQ6MIhCxS6uoASsfJ8db1HQdi0pBimstKMB/Wsz7
 BYz4yP8sITnBiqcqs5eQgZrY8IR7yz9VdSWr2xW2mJX2gL5YTJP3gay
X-Developer-Key: i=git@apitzsch.eu; a=ed25519;
 pk=wxovcZRfvNYBMcTw4QFFtNEP4qv39gnBfnfyImXZxiU=
X-Endpoint-Received: by B4 Relay for git@apitzsch.eu/20240325 with
 auth_id=142
X-Original-From: =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Reply-To: git@apitzsch.eu

This series introduces a driver for the Silergy SY7802 charge pump used
in the BQ Aquaris M5 and X5 smartphones.

The implementation is based on information extracted from downstream as
the datasheet provided by a distributor of the hardware didn't include
any information about the i2c register description.

Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
Changes in v2:
- bindings: remove unneeded allOf
- bindings: example: move flash-led-controller under i2c node to fix
  check error
- Cc to phone-devel
- Link to v1: https://lore.kernel.org/r/20240327-sy7802-v1-0-db74ab32faaf@apitzsch.eu

---
André Apitzsch (3):
      dt-bindings: leds: Add Silergy SY7802 flash LED
      leds: sy7802: Add support for Silergy SY7802 flash LED controller
      arm64: dts: qcom: msm8939-longcheer-l9100: Add rear flash

 .../devicetree/bindings/leds/silergy,sy7802.yaml   | 100 ++++
 .../boot/dts/qcom/msm8939-longcheer-l9100.dts      |  26 +
 drivers/leds/flash/Kconfig                         |  11 +
 drivers/leds/flash/Makefile                        |   1 +
 drivers/leds/flash/leds-sy7802.c                   | 532 +++++++++++++++++++++
 5 files changed, 670 insertions(+)
---
base-commit: a6bd6c9333397f5a0e2667d4d82fef8c970108f2
change-id: 20240325-sy7802-f40fc6f56525

Best regards,
-- 
André Apitzsch <git@apitzsch.eu>



